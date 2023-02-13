LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= pixman

LOCAL_CFLAGS:= -D_USE_MATH_DEFINES -O2 -DPIXMAN_NO_TLS -DHAVE_PTHREADS -DPACKAGE="android-cairo" -include "limits.h" -Wno-missing-field-initializers -fno-integrated-as

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/pixman \
	$(LOCAL_PATH)/pixman/dither

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/pixman

LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/pixman/pixman.c \
	$(LOCAL_PATH)/pixman/pixman-access.c \
	$(LOCAL_PATH)/pixman/pixman-access-accessors.c \
	$(LOCAL_PATH)/pixman/pixman-bits-image.c \
	$(LOCAL_PATH)/pixman/pixman-combine32.c \
	$(LOCAL_PATH)/pixman/pixman-combine-float.c \
	$(LOCAL_PATH)/pixman/pixman-conical-gradient.c \
	$(LOCAL_PATH)/pixman/pixman-filter.c \
	$(LOCAL_PATH)/pixman/pixman-x86.c \
	$(LOCAL_PATH)/pixman/pixman-mips.c \
	$(LOCAL_PATH)/pixman/pixman-arm.c \
	$(LOCAL_PATH)/pixman/pixman-ppc.c \
	$(LOCAL_PATH)/pixman/pixman-edge.c \
	$(LOCAL_PATH)/pixman/pixman-edge-accessors.c \
	$(LOCAL_PATH)/pixman/pixman-fast-path.c \
	$(LOCAL_PATH)/pixman/pixman-glyph.c \
	$(LOCAL_PATH)/pixman/pixman-general.c \
	$(LOCAL_PATH)/pixman/pixman-gradient-walker.c \
	$(LOCAL_PATH)/pixman/pixman-image.c \
	$(LOCAL_PATH)/pixman/pixman-implementation.c \
	$(LOCAL_PATH)/pixman/pixman-linear-gradient.c \
	$(LOCAL_PATH)/pixman/pixman-matrix.c \
	$(LOCAL_PATH)/pixman/pixman-noop.c \
	$(LOCAL_PATH)/pixman/pixman-radial-gradient.c \
	$(LOCAL_PATH)/pixman/pixman-region16.c \
	$(LOCAL_PATH)/pixman/pixman-region32.c \
	$(LOCAL_PATH)/pixman/pixman-solid-fill.c \
	$(LOCAL_PATH)/pixman/pixman-timer.c \
	$(LOCAL_PATH)/pixman/pixman-trap.c \
	$(LOCAL_PATH)/pixman/pixman-utils.c \
	$(LOCAL_PATH)/pixman/dither/make-blue-noise.c

ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
	LOCAL_CFLAGS += -DARCH_32BIT -DABI_ARMEABI_V7A -DUSE_ARM_NEON
	LOCAL_SRC_FILES += \
		$(LOCAL_PATH)/pixman/pixman-arm-neon.c	\
		$(LOCAL_PATH)/pixman/pixman-arm-neon-asm.S	\
		$(LOCAL_PATH)/pixman/pixman-arm-neon-asm-bilinear.S
else ifeq ($(TARGET_ARCH_ABI), arm64-v8a)
	LOCAL_CFLAGS += -DARCH_64BIT -DABI_ARM64_V8A -DUSE_ARM_A64_NEON
	LOCAL_SRC_FILES += \
		$(LOCAL_PATH)/pixman/pixman-arm-neon.c	\
		$(LOCAL_PATH)/pixman/pixman-arma64-neon-asm.S \
        $(LOCAL_PATH)/pixman/pixman-arma64-neon-asm-bilinear.S
else ifeq ($(TARGET_ARCH_ABI), x86_64)
	LOCAL_CFLAGS += -DARCH_64BIT -DABI_X86_64 -msse3 -Winline -DUSE_SSE3
	LOCAL_SRC_FILES += $(LOCAL_PATH)/pixman/pixman-ssse3.c
endif

LOCAL_ARM_NEON := true
LOCAL_STATIC_LIBRARIES := cpufeatures

include $(BUILD_STATIC_LIBRARY)
$(call import-module,android/cpufeatures)