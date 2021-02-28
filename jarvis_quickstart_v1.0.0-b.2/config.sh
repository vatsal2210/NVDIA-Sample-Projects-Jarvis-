# Copyright (c) 2021, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# Enable or Disable Jarvis Services
service_enabled_asr=true
service_enabled_nlp=true
service_enabled_tts=true

# Specify one or more GPUs to use
# specifying more than one GPU is currently an experimental feature, and may result in undefined behaviours.
gpus_to_use="device=0"

# Specify the encryption key to use to deploy models
MODEL_DEPLOY_KEY="tlt_encode"

# Locations to use for storing models artifacts
#
# If an absolute path is specified, the data will be written to that location
# Otherwise, a docker volume will be used (default).
#
# jarvis_init.sh will create a `jmir` and `models` directory in the volume or
# path specified. 
#
# JMIR ($jarvis_model_loc/jmir)
# Jarvis uses an intermediate representation (JMIR) for models
# that are ready to deploy but not yet fully optimized for deployment. Pretrained
# versions can be obtained from NGC (by specifying NGC models below) and will be
# downloaded to $jarvis_model_loc/jmir by `jarvis_init.sh`
# 
# Custom models produced by NeMo or TLT and prepared using jarvis-build
# may also be copied manually to this location $(jarvis_model_loc/jmir).
#
# Models ($jarvis_model_loc/models)
# During the jarvis_init process, the JMIR files in $jarvis_model_loc/jmir
# are inspected and optimized for deployment. The optimized versions are
# stored in $jarvis_model_loc/models. The jarvis server exclusively uses these
# optimized versions.
jarvis_model_loc="jarvis-model-repo"

# The default JMIRs are downloaded from NGC by default in the above $jarvis_jmir_loc directory
# If you'd like to skip the download from NGC and use the existing JMIRs in the $jarvis_jmir_loc
# then set the below $use_existing_jmirs flag to true. You can also deploy your set of custom
# JMIRs by keeping them in the jarvis_jmir_loc dir and use this quickstart script with the
# below flag to deploy them all together.
use_existing_jmirs=false

# Ports to expose for Jarvis services
jarvis_speech_api_port="50051"
jarvis_vision_api_port="60051"

# NGC orgs
jarvis_ngc_org="nvidia"
jarvis_ngc_team="jarvis"
jarvis_ngc_image_version="1.0.0-b.2"
jarvis_ngc_model_version="1.0.0-b.1"

# Pre-built models listed below will be downloaded from NGC. If models already exist in $jarvis-jmir
# then models can be commented out to skip download from NGC

models_asr=(
### Punctuation model
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_punctuation:${jarvis_ngc_model_version}"

### Jasper Streaming w/ CPU decoder, best latency configuration
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_jasper_english_streaming:${jarvis_ngc_model_version}"

### Jasper Streaming w/ CPU decoder, best throughput configuration
#    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_jasper_english_streaming_throughput:${jarvis_ngc_model_version}"

###  Jasper Offline w/ CPU decoder
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_jasper_english_offline:${jarvis_ngc_model_version}"
 
### Quarztnet Streaming w/ CPU decoder, best latency configuration
#    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_quartznet_english_streaming:${jarvis_ngc_model_version}"

### Quarztnet Streaming w/ CPU decoder, best throughput configuration
#    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_quartznet_english_streaming_throughput:${jarvis_ngc_model_version}"

### Quarztnet Offline w/ CPU decoder
#    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_quartznet_english_offline:${jarvis_ngc_model_version}"

### Jasper Streaming w/ GPU decoder, best latency configuration
#    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_jasper_english_streaming_gpu_decoder:${jarvis_ngc_model_version}"

### Jasper Streaming w/ GPU decoder, best throughput configuration
#    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_jasper_english_streaming_throughput_gpu_decoder:${jarvis_ngc_model_version}"

### Jasper Offline w/ GPU decoder
#    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_asr_jasper_english_offline_gpu_decoder:${jarvis_ngc_model_version}"
)

models_nlp=(
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_punctuation:${jarvis_ngc_model_version}"
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_named_entity_recognition:${jarvis_ngc_model_version}"
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_intent_slot:${jarvis_ngc_model_version}"
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_question_answering:${jarvis_ngc_model_version}"
    "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_text_classification:${jarvis_ngc_model_version}"
)
models_tts=(
   "${jarvis_ngc_org}/${jarvis_ngc_team}/jmir_jarvis_tts_ljspeech:${jarvis_ngc_model_version}"
)

NGC_TARGET=${jarvis_ngc_org}
if [[ ! -z ${jarvis_ngc_team} ]]; then
  NGC_TARGET="${NGC_TARGET}/${jarvis_ngc_team}"
else
  team="\"\""
fi

# define docker images required to run Jarvis
image_client="nvcr.io/${NGC_TARGET}/jarvis-speech-client:${jarvis_ngc_image_version}"
image_speech_api="nvcr.io/${NGC_TARGET}/jarvis-speech:${jarvis_ngc_image_version}-server"

# define docker images required to setup Jarvis
image_init_speech="nvcr.io/${NGC_TARGET}/jarvis-speech:${jarvis_ngc_image_version}-servicemaker"

# daemon names
jarvis_daemon_speech="jarvis-speech"
jarvis_daemon_client="jarvis-client"
