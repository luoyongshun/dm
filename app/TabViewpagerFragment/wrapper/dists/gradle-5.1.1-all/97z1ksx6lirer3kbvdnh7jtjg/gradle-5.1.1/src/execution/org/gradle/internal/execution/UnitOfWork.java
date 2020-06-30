/*
 * Copyright 2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.internal.execution;

import com.google.common.collect.ImmutableSortedMap;
import org.gradle.api.file.FileCollection;
import org.gradle.caching.internal.CacheableEntity;
import org.gradle.caching.internal.origin.OriginMetadata;
import org.gradle.internal.execution.history.changes.ExecutionStateChanges;
import org.gradle.internal.file.TreeType;
import org.gradle.internal.fingerprint.CurrentFileCollectionFingerprint;

import java.time.Duration;
import java.util.Optional;

public interface UnitOfWork extends CacheableEntity {

    /**
     * Executes the work synchronously.
     *
     * @return Whether any work has been performed.
     */
    boolean execute();

    Optional<Duration> getTimeout();

    void visitOutputs(OutputVisitor outputVisitor);

    long markExecutionTime();

    FileCollection getLocalState();

    /**
     * Loading from cache failed and all outputs were removed.
     */
    void outputsRemovedAfterFailureToLoadFromCache();

    CacheHandler createCacheHandler();

    void persistResult(ImmutableSortedMap<String, CurrentFileCollectionFingerprint> finalOutputs, boolean successful, OriginMetadata originMetadata);

    Optional<ExecutionStateChanges> getChangesSincePreviousExecution();

    /**
     * Paths to locations changed by the unit of work.
     *
     * <p>
     * We don't want to invalidate the whole file system mirror for artifact transformations, since I know exactly which parts need to be invalidated.
     * For tasks though, we still need to invalidate everything.
     * </p>
     *
     * @return {@link Optional#empty()} if the unit of work cannot guarantee that only some files have been changed or an iterable of the paths which were changed by the unit of work.
     */
    Optional<? extends Iterable<String>> getChangingOutputs();

    interface OutputVisitor {
        void visitOutput(String name, TreeType type, FileCollection roots);
    }

    ImmutableSortedMap<String, CurrentFileCollectionFingerprint> snapshotAfterOutputsGenerated();
}
