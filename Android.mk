LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libOpenCL
LOCAL_SRC_FILES := opencl11_stubs.c
LOCAL_C_INCLUDES := $(LOCAL_PATH)/opencl11_stubs_include
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog -fPIE

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := src/common.cpp src/clpeak.cpp src/options.cpp src/logger.cpp src/global_bandwidth.cpp src/compute_sp.cpp src/compute_hp.cpp src/compute_dp.cpp src/compute_integer.cpp src/transfer_bandwidth.cpp src/kernel_latency.cpp src/entry.cpp
ifeq ($(TARGET_ARCH), $(filter $(TARGET_ARCH), arm arm64))
LOCAL_ARM_NEON := true
endif
LOCAL_MODULE := clpeak
LOCAL_C_INCLUDES := $(LOCAL_PATH)/src/kernels $(LOCAL_PATH)/deps/OpenCL-CLHPP/include $(LOCAL_PATH)/include $(LOCAL_PATH)/opencl11_stubs_include
LOCAL_CPPFLAGS := -std=gnu++0x -Wall -fPIE
LOCAL_CPP_FEATURES := exceptions
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog -fPIE -pie
LOCAL_SHARED_LIBRARIES := libOpenCL

include $(BUILD_EXECUTABLE)
