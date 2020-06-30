/*
 * Copyright 2016 the original author or authors.
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

package org.gradle.api.artifacts.transform;

import java.io.File;
import java.util.List;

/**
 * Base class for artifact transformations.
 *
 * <p>Implementations must provide a public constructor. The constructor may optionally be annotated with {@link javax.inject.Inject} and accept parameters. The following parameters are available:</p>
 *
 * <ul>
 * <li>{@link ArtifactTransformDependencies} parameter to receive the dependencies of the file to be transformed.</li>
 * <li>The objects provided to {@link org.gradle.api.ActionConfiguration#setParams(Object...)}.</li>
 * </ul>
 *
 * @since 3.4
 */
public abstract class ArtifactTransform {
    private File outputDirectory;

    public File getOutputDirectory() {
        return outputDirectory;
    }

    public void setOutputDirectory(File outputDirectory) {
        this.outputDirectory = outputDirectory;
    }

    public abstract List<File> transform(File input);
}
