/*
 * Copyright 2013 the original author or authors.
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

package org.gradle.internal.execution.history.changes;

import org.gradle.internal.change.Change;
import org.gradle.internal.change.ChangeVisitor;
import org.gradle.internal.execution.history.AfterPreviousExecutionState;

/**
 * Represents the complete changes in execution state
 */
public interface ExecutionStateChanges {

    int MAX_OUT_OF_DATE_MESSAGES = 3;

    /**
     * Returns changes to input files only.
     */
    Iterable<Change> getInputFilesChanges();

    /**
     * Visits any change to inputs or outputs.
     */
    void visitAllChanges(ChangeVisitor visitor);

    /**
     * Whether there are changes that force an incremental task to fully rebuild.
     */
    boolean isRebuildRequired();

    /**
     * The base execution the changes are calculated against.
     */
    AfterPreviousExecutionState getPreviousExecution();
}
