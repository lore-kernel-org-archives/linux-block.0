Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5A399019;
	Sun,  3 May 2026 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780639; cv=none; b=Jmk88FG3f6VzmlqnsGKckeQlw1VBbuQ4C/OUjGfdTtTFoFHLfhBQafqhTkogmw9B17eMRTUbUzlCSPzO737PJe1S35L/G4AGcU2kLC+4CZhqIE0Hk9ojhin//fAl6s15E61nqBd+jRR47Kh0LjqBUHkw0UFCYBKDGNsX9n7qt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780639; c=relaxed/simple;
	bh=FhSFyZ0mAf0IzP+Xb38CmM5ZWJTDvALlc5lIIybfLyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7o5ZxInE/NZKlDxDRDALJ5PL5AQIVi5pjB1hxmH5Ott9M6PTgjaFPeLDoRFp1Su7KNIYqa5LcmDBuf21mWROSpWA8rRWlMiNuwmoLgsdUmDJ5fkpvstokGAgj0+Q6r8xOb9lxQNI5mGSqWqnSuBRofegU3IKae2jDPhLXhmUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pUcUt4QB; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pUcUt4QB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777780634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuC2pvLxUU1chQHeCnNr7wGoZXl7dyXI80i3pwcxUgs=;
	b=pUcUt4QBzn7EsfduNC3v+vvvqABo6RnlJF/eMAw4gioPLFoAPCn4/XIqZ9fUUmJnUX9mQX
	w2/eOamw03obwVl/gY7tp2qKXw5JZ0GTU6z8DgCCEYgl6BgzLLPVH0B6tUkHEitfefXUCQ
	Jd7XiOkUMpzhPos4BFuWfkBwV9zkNpA=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: axboe@kernel.dk,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [RFC v2 3/3] tools/ufq_iosched: add BPF example scheduler and build scaffolding
Date: Sun,  3 May 2026 11:56:23 +0800
Message-ID: <20260503035623.28771-4-kaitao.cheng@linux.dev>
In-Reply-To: <20260503035623.28771-1-kaitao.cheng@linux.dev>
References: <20260503035623.28771-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add ufq_iosched as a simple example for the UFQ block I/O scheduler,
In the ufq_simple example, we implement the eBPF struct_ops hooks the
kernel exposes so we can exercise and validate the behavior and stability
of the kernel UFQ scheduling framework. The Makefile and directory
layout are modeled after sched_ext.

This mirrors the sched_ext examples pattern so developers can experiment
with user-defined queueing policies on top of IOSCHED_UFQ.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 tools/ufq_iosched/.gitignore                  |   2 +
 tools/ufq_iosched/Makefile                    | 262 ++++++++
 tools/ufq_iosched/README.md                   | 145 +++++
 .../include/bpf-compat/gnu/stubs.h            |  12 +
 tools/ufq_iosched/include/ufq/common.bpf.h    |  75 +++
 tools/ufq_iosched/include/ufq/common.h        |  90 +++
 tools/ufq_iosched/include/ufq/simple_stat.h   |  23 +
 tools/ufq_iosched/ufq_simple.bpf.c            | 604 ++++++++++++++++++
 tools/ufq_iosched/ufq_simple.c                | 120 ++++
 9 files changed, 1333 insertions(+)
 create mode 100644 tools/ufq_iosched/.gitignore
 create mode 100644 tools/ufq_iosched/Makefile
 create mode 100644 tools/ufq_iosched/README.md
 create mode 100644 tools/ufq_iosched/include/bpf-compat/gnu/stubs.h
 create mode 100644 tools/ufq_iosched/include/ufq/common.bpf.h
 create mode 100644 tools/ufq_iosched/include/ufq/common.h
 create mode 100644 tools/ufq_iosched/include/ufq/simple_stat.h
 create mode 100644 tools/ufq_iosched/ufq_simple.bpf.c
 create mode 100644 tools/ufq_iosched/ufq_simple.c

diff --git a/tools/ufq_iosched/.gitignore b/tools/ufq_iosched/.gitignore
new file mode 100644
index 000000000000..d6264fe1c8cd
--- /dev/null
+++ b/tools/ufq_iosched/.gitignore
@@ -0,0 +1,2 @@
+tools/
+build/
diff --git a/tools/ufq_iosched/Makefile b/tools/ufq_iosched/Makefile
new file mode 100644
index 000000000000..7dc37d9172aa
--- /dev/null
+++ b/tools/ufq_iosched/Makefile
@@ -0,0 +1,262 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 KylinSoft Corporation.
+# Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+include ../build/Build.include
+include ../scripts/Makefile.arch
+include ../scripts/Makefile.include
+
+all: all_targets
+
+ifneq ($(LLVM),)
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
+CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
+CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
+CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
+CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
+CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
+CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
+CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
+CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
+CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+
+ifeq ($(CROSS_COMPILE),)
+ifeq ($(CLANG_TARGET_FLAGS),)
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk)
+else
+CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
+endif # CLANG_TARGET_FLAGS
+else
+CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif # CROSS_COMPILE
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+else
+CC := $(CROSS_COMPILE)gcc
+endif # LLVM
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+GENDIR := $(abspath ../../include/generated)
+GENHDR := $(GENDIR)/autoconf.h
+
+ifeq ($(O),)
+OUTPUT_DIR := $(CURDIR)/build
+else
+OUTPUT_DIR := $(O)/build
+endif # O
+OBJ_DIR := $(OUTPUT_DIR)/obj
+INCLUDE_DIR := $(OUTPUT_DIR)/include
+BPFOBJ_DIR := $(OBJ_DIR)/libbpf
+UFQOBJ_DIR := $(OBJ_DIR)/ufq_iosched
+BINDIR := $(OUTPUT_DIR)/bin
+BPFOBJ := $(BPFOBJ_DIR)/libbpf.a
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(OBJ_DIR)/host/obj
+HOST_OUTPUT_DIR		:= $(OBJ_DIR)/host
+HOST_INCLUDE_DIR	:= $(HOST_OUTPUT_DIR)/include
+else
+HOST_BUILD_DIR		:= $(OBJ_DIR)
+HOST_OUTPUT_DIR		:= $(OUTPUT_DIR)
+HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+DEFAULT_BPFTOOL := $(HOST_OUTPUT_DIR)/sbin/bpftool
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../vmlinux						\
+		     /sys/kernel/btf/vmlinux					\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
+	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+LDFLAGS += -lelf -lz -lpthread
+
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
+	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)		\
+	     -I$(CURDIR)/include -I$(CURDIR)/include/bpf-compat			\
+	     -I$(INCLUDE_DIR) -I$(APIDIR)					\
+	     -I../../include							\
+	     $(call get_sys_includes,$(CLANG))					\
+	     -Wall -Wno-compare-distinct-pointer-types				\
+	     -Wno-microsoft-anon-tag						\
+	     -fms-extensions							\
+	     -O2 -mcpu=v3
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf			\
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids	\
+	       $(INCLUDE_DIR) $(UFQOBJ_DIR) $(BINDIR))
+
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+ifneq ($(CROSS_COMPILE),)
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
+	   $(APIDIR)/linux/bpf.h						\
+	   | $(OBJ_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) CROSS_COMPILE=$(CROSS_COMPILE) 		\
+		    -C $(BPFDIR) OUTPUT=$(OBJ_DIR)/libbpf/			\
+		    EXTRA_CFLAGS='-g -O0 -fPIC'					\
+		    LDFLAGS="$(LDFLAGS)"					\
+		    DESTDIR=$(OUTPUT_DIR) prefix= all install_headers
+endif
+
+$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		\
+	   $(APIDIR)/linux/bpf.h						\
+	   | $(HOST_BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) 				\
+		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/				\
+		    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0 -fPIC'					\
+		    DESTDIR=$(HOST_OUTPUT_DIR) prefix= all install_headers
+
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
+		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
+		    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/				\
+		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/			\
+		    LIBBPF_DESTDIR=$(HOST_OUTPUT_DIR)/				\
+		    prefix= DESTDIR=$(HOST_OUTPUT_DIR)/ install-bin
+
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(UFQOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h include/ufq/*.h		\
+		       | $(BPFOBJ) $(UFQOBJ_DIR)
+	$(call msg,CLNG-BPF,,$(notdir $@))
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(INCLUDE_DIR)/%.bpf.skel.h: $(UFQOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL)
+	$(eval sched=$(notdir $@))
+	$(call msg,GEN-SKEL,,$(sched))
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
+	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $@
+	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $(@:.skel.h=.subskel.h)
+
+UFQ_COMMON_DEPS := include/ufq/common.h include/ufq/simple_stat.h | $(BINDIR)
+
+c-sched-targets = ufq_simple
+
+$(addprefix $(BINDIR)/,$(c-sched-targets)): \
+	$(BINDIR)/%: \
+		$(filter-out %.bpf.c,%.c) \
+		$(INCLUDE_DIR)/%.bpf.skel.h \
+		$(UFQ_COMMON_DEPS)
+	$(eval sched=$(notdir $@))
+	$(CC) $(CFLAGS) -c $(sched).c -o $(UFQOBJ_DIR)/$(sched).o
+	$(CC) -o $@ $(UFQOBJ_DIR)/$(sched).o $(BPFOBJ) $(LDFLAGS)
+
+$(c-sched-targets): %: $(BINDIR)/%
+
+install: all
+	$(Q)mkdir -p $(DESTDIR)/usr/local/bin/
+	$(Q)cp $(BINDIR)/* $(DESTDIR)/usr/local/bin/
+
+clean:
+	rm -rf $(OUTPUT_DIR) $(HOST_OUTPUT_DIR)
+	rm -f *.o *.bpf.o *.bpf.skel.h *.bpf.subskel.h
+	rm -f $(c-sched-targets)
+
+help:
+	@echo   'Building targets'
+	@echo   '================'
+	@echo   ''
+	@echo   '  all		  - Compile all schedulers'
+	@echo   ''
+	@echo   'Alternatively, you may compile individual schedulers:'
+	@echo   ''
+	@printf '  %s\n' $(c-sched-targets)
+	@echo   ''
+	@echo   'For any scheduler build target, you may specify an alternative'
+	@echo   'build output path with the O= environment variable. For example:'
+	@echo   ''
+	@echo   '   O=/tmp/ufq_iosched make all'
+	@echo   ''
+	@echo   'will compile all schedulers, and emit the build artifacts to'
+	@echo   '/tmp/ufq_iosched/build.'
+	@echo   ''
+	@echo   ''
+	@echo   'Installing targets'
+	@echo   '=================='
+	@echo   ''
+	@echo   '  install	  - Compile and install all schedulers to /usr/bin.'
+	@echo   '		    You may specify the DESTDIR= environment variable'
+	@echo   '		    to indicate a prefix for /usr/bin. For example:'
+	@echo   ''
+	@echo   '                     DESTDIR=/tmp/ufq_iosched make install'
+	@echo   ''
+	@echo   '		    will build the schedulers in CWD/build, and'
+	@echo   '		    install the schedulers to /tmp/ufq_iosched/usr/bin.'
+	@echo   ''
+	@echo   ''
+	@echo   'Cleaning targets'
+	@echo   '================'
+	@echo   ''
+	@echo   '  clean		  - Remove all generated files'
+
+all_targets: $(c-sched-targets)
+
+.PHONY: all all_targets $(c-sched-targets) clean help
+
+# delete failed targets
+.DELETE_ON_ERROR:
+
+# keep intermediate (.bpf.skel.h, .bpf.o, etc) targets
+.SECONDARY:
diff --git a/tools/ufq_iosched/README.md b/tools/ufq_iosched/README.md
new file mode 100644
index 000000000000..1fa305fb576e
--- /dev/null
+++ b/tools/ufq_iosched/README.md
@@ -0,0 +1,145 @@
+UFQ IOSCHED EXAMPLE SCHEDULERS
+============================
+
+# Introduction
+
+This directory contains a simple example of the ufq IO scheduler. It is meant
+to illustrate the different kinds of IO schedulers you can build with ufq;
+new schedulers will be added as the project evolves across releases.
+
+# Compiling the examples
+
+There are a few toolchain dependencies for compiling the example schedulers.
+
+## Toolchain dependencies
+
+1. clang >= 16.0.0
+
+The schedulers are BPF programs, and therefore must be compiled with clang. gcc
+is actively working on adding a BPF backend compiler as well, but are still
+missing some features such as BTF type tags which are necessary for using
+kptrs.
+
+2. pahole >= 1.25
+
+You may need pahole in order to generate BTF from DWARF.
+
+3. rust >= 1.85.0
+
+Rust schedulers uses features present in the rust toolchain >= 1.85.0. You
+should be able to use the stable build from rustup.
+
+There are other requirements as well, such as make, but these are the main /
+non-trivial ones.
+
+## Compiling the kernel
+
+In order to run a ufq scheduler, you'll have to run a kernel compiled
+with the patches in this repository, and with a minimum set of necessary
+Kconfig options:
+
+```
+CONFIG_BPF=y
+CONFIG_IOSCHED_UFQ=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_DEBUG_INFO_BTF=y
+```
+
+It's also recommended that you also include the following Kconfig options:
+
+```
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_JIT_DEFAULT_ON=y
+CONFIG_PAHOLE_HAS_SPLIT_BTF=y
+CONFIG_PAHOLE_HAS_BTF_TAG=y
+```
+
+There is a `Kconfig` file in this directory whose contents you can append to
+your local `.config` file, as long as there are no conflicts with any existing
+options in the file.
+
+## Getting a vmlinux.h file
+
+You may notice that most of the example schedulers include a "vmlinux.h" file.
+This is a large, auto-generated header file that contains all of the types
+defined in some vmlinux binary that was compiled with
+[BTF](https://docs.kernel.org/bpf/btf.html) (i.e. with the BTF-related Kconfig
+options specified above).
+
+The header file is created using `bpftool`, by passing it a vmlinux binary
+compiled with BTF as follows:
+
+```bash
+$ bpftool btf dump file /path/to/vmlinux format c > vmlinux.h
+```
+
+`bpftool` analyzes all of the BTF encodings in the binary, and produces a
+header file that can be included by BPF programs to access those types.  For
+example, using vmlinux.h allows a scheduler to access fields defined directly
+in vmlinux
+
+The scheduler build system will generate this vmlinux.h file as part of the
+scheduler build pipeline. It looks for a vmlinux file in the following
+dependency order:
+
+1. If the O= environment variable is defined, at `$O/vmlinux`
+2. If the KBUILD_OUTPUT= environment variable is defined, at
+   `$KBUILD_OUTPUT/vmlinux`
+3. At `../../vmlinux` (i.e. at the root of the kernel tree where you're
+   compiling the schedulers)
+4. `/sys/kernel/btf/vmlinux`
+5. `/boot/vmlinux-$(uname -r)`
+
+In other words, if you have compiled a kernel in your local repo, its vmlinux
+file will be used to generate vmlinux.h. Otherwise, it will be the vmlinux of
+the kernel you're currently running on. This means that if you're running on a
+kernel with ufq support, you may not need to compile a local kernel at
+all.
+
+### Aside on CO-RE
+
+One of the cooler features of BPF is that it supports
+[CO-RE](https://nakryiko.com/posts/bpf-core-reference-guide/) (Compile Once Run
+Everywhere). This feature allows you to reference fields inside of structs with
+types defined internal to the kernel, and not have to recompile if you load the
+BPF program on a different kernel with the field at a different offset.
+
+## Compiling the schedulers
+
+Once you have your toolchain setup, and a vmlinux that can be used to generate
+a full vmlinux.h file, you can compile the schedulers using `make`. The build
+vendors libbpf and bpftool under `build/`, then compiles BPF objects with
+`clang` and the userspace loader (for example `ufq_simple.c`) with `gcc`.
+
+```bash
+$ make -j($nproc)
+```
+
+## ufq_simple
+
+A simple IO scheduler that provides an example of a minimal ufq scheduler.
+Populates commonly used kernel-exposed BPF interfaces for testing the UFQ
+scheduler framework in the kernel.
+
+### bpftool feature detection (`llvm`, `libcap`, `libbfd`)
+
+While building bpftool, you may see lines similar to:
+
+```
+Auto-detecting system features:
+...                         clang-bpf-co-re: [ on  ]
+...                                    llvm: [ OFF ]
+...                                  libcap: [ OFF ]
+...                                  libbfd: [ OFF ]
+```
+
+This matches a typical minimal build environment: CO-RE support is on, while
+bpftool's optional links to LLVM (for some disassembly paths), libcap, and
+libbfd are off. **`llvm: [ OFF ]` is not a build failure** for these examples;
+the scheduler build can still complete (libbpf static library, bpftool,
+`vmlinux.h` generation, BPF `.o` files, and final `ufq_simple` link with `gcc`).
+
+If `libcap` or `libbfd` show `[ OFF ]`, you only miss optional bpftool features
+that depend on those libraries; you do not need them for compiling and loading
+the schedulers in this directory.
diff --git a/tools/ufq_iosched/include/bpf-compat/gnu/stubs.h b/tools/ufq_iosched/include/bpf-compat/gnu/stubs.h
new file mode 100644
index 000000000000..f200ac0f6ccd
--- /dev/null
+++ b/tools/ufq_iosched/include/bpf-compat/gnu/stubs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Dummy gnu/stubs.h. clang can end up including /usr/include/gnu/stubs.h when
+ * compiling BPF files although its content doesn't play any role. The file in
+ * turn includes stubs-64.h or stubs-32.h depending on whether __x86_64__ is
+ * defined. When compiling a BPF source, __x86_64__ isn't set and thus
+ * stubs-32.h is selected. However, the file is not there if the system doesn't
+ * have 32bit glibc devel package installed leading to a build failure.
+ *
+ * The problem is worked around by making this file available in the include
+ * search paths before the system one when building BPF.
+ */
diff --git a/tools/ufq_iosched/include/ufq/common.bpf.h b/tools/ufq_iosched/include/ufq/common.bpf.h
new file mode 100644
index 000000000000..515821ba5b01
--- /dev/null
+++ b/tools/ufq_iosched/include/ufq/common.bpf.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#ifndef __UFQ_COMMON_BPF_H
+#define __UFQ_COMMON_BPF_H
+
+#ifdef LSP
+#define __bpf__
+#include "../vmlinux/vmlinux.h"
+#else
+#include "vmlinux.h"
+#endif
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <asm-generic/errno.h>
+#include "simple_stat.h"
+
+#define BPF_STRUCT_OPS(name, args...)					\
+	SEC("struct_ops/" #name) BPF_PROG(name, ##args)
+
+/* Define struct ufq_iosched_ops for .struct_ops.link in the BPF object */
+#define UFQ_OPS_DEFINE(__name, ...)					\
+	SEC(".struct_ops.link")						\
+	struct ufq_iosched_ops __name = {				\
+		__VA_ARGS__,						\
+	}
+
+/* list and rbtree */
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
+struct request *bpf_request_acquire(struct request *rq) __ksym;
+void bpf_request_release(struct request *rq) __ksym;
+bool bpf_request_bio_try_merge(struct request *rq, struct bio *bio,
+			       unsigned int nr_segs) __ksym;
+struct request *bpf_request_try_merge(struct request *rq, struct request *next) __ksym;
+
+void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
+void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
+
+#define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
+#define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
+
+int bpf_list_push_front_impl(struct bpf_list_head *head,
+				    struct bpf_list_node *node,
+				    void *meta, __u64 off) __ksym;
+#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
+
+int bpf_list_push_back_impl(struct bpf_list_head *head,
+				   struct bpf_list_node *node,
+				   void *meta, __u64 off) __ksym;
+#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
+
+struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
+struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
+bool bpf_list_empty(struct bpf_list_head *head) __ksym;
+struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+				   struct bpf_list_node *node) __ksym;
+
+struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
+				      struct bpf_rb_node *node) __ksym;
+int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
+			bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
+			void *meta, __u64 off) __ksym;
+#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node, less, NULL, 0)
+
+struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
+
+void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym;
+#define bpf_refcount_acquire(kptr) bpf_refcount_acquire_impl(kptr, NULL)
+
+#endif	/* __UFQ_COMMON_BPF_H */
diff --git a/tools/ufq_iosched/include/ufq/common.h b/tools/ufq_iosched/include/ufq/common.h
new file mode 100644
index 000000000000..a1e3a07844c4
--- /dev/null
+++ b/tools/ufq_iosched/include/ufq/common.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#ifndef __UFQ_IOSCHED_COMMON_H
+#define __UFQ_IOSCHED_COMMON_H
+
+#ifdef __KERNEL__
+#error "Should not be included by BPF programs"
+#endif
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <errno.h>
+#include <bpf/bpf.h>
+#include "simple_stat.h"
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+typedef int8_t s8;
+typedef int16_t s16;
+typedef int32_t s32;
+typedef int64_t s64;
+
+#define UFQ_ERR(__fmt, ...)							\
+	do {									\
+		fprintf(stderr, "[UFQ_ERR] %s:%d", __FILE__, __LINE__);		\
+		if (errno)							\
+			fprintf(stderr, " (%s)\n", strerror(errno));		\
+		else								\
+			fprintf(stderr, "\n");					\
+		fprintf(stderr, __fmt __VA_OPT__(,) __VA_ARGS__);		\
+		fprintf(stderr, "\n");						\
+										\
+		exit(EXIT_FAILURE);						\
+	} while (0)
+
+#define UFQ_ERR_IF(__cond, __fmt, ...)						\
+	do {									\
+		if (__cond)							\
+			UFQ_ERR((__fmt) __VA_OPT__(,) __VA_ARGS__);		\
+	} while (0)
+
+/*
+ * struct ufq_iosched_ops can grow over time. With common.bpf.h::UFQ_OPS_DEFINE()
+ * and UFQ_OPS_LOAD()/UFQ_OPS_ATTACH(), libbpf performs struct_ops attachment.
+ */
+#define UFQ_OPS_OPEN(__ops_name, __ufq_name) ({					\
+	struct __ufq_name *__skel;						\
+										\
+	__skel = __ufq_name##__open();						\
+	UFQ_ERR_IF(!__skel, "Could not open " #__ufq_name);			\
+	(void)__skel->maps.__ops_name;						\
+	__skel;									\
+})
+
+#define UFQ_OPS_LOAD(__skel, __ops_name, __ufq_name) ({				\
+	(void)(__skel)->maps.__ops_name;					\
+	UFQ_ERR_IF(__ufq_name##__load((__skel)), "Failed to load skel");	\
+})
+
+/*
+ * New versions of bpftool emit additional link placeholders for BPF maps,
+ * and set up BPF skeleton so libbpf can auto-attach BPF maps (v1.5+). Old
+ * libbpf ignores those links. Disable autoattach on newer libbpf to avoid
+ * attaching twice when we attach struct_ops explicitly.
+ */
+#if LIBBPF_MAJOR_VERSION > 1 ||							\
+	(LIBBPF_MAJOR_VERSION == 1 && LIBBPF_MINOR_VERSION >= 5)
+#define __UFQ_OPS_DISABLE_AUTOATTACH(__skel, __ops_name)			\
+	bpf_map__set_autoattach((__skel)->maps.__ops_name, false)
+#else
+#define __UFQ_OPS_DISABLE_AUTOATTACH(__skel, __ops_name) do {} while (0)
+#endif
+
+#define UFQ_OPS_ATTACH(__skel, __ops_name, __ufq_name) ({			\
+	struct bpf_link *__link;						\
+	__UFQ_OPS_DISABLE_AUTOATTACH(__skel, __ops_name);			\
+	UFQ_ERR_IF(__ufq_name##__attach((__skel)), "Failed to attach skel");	\
+	__link = bpf_map__attach_struct_ops((__skel)->maps.__ops_name);		\
+	UFQ_ERR_IF(!__link, "Failed to attach struct_ops");			\
+	__link;									\
+})
+
+#endif	/* __UFQ_IOSCHED_COMMON_H */
diff --git a/tools/ufq_iosched/include/ufq/simple_stat.h b/tools/ufq_iosched/include/ufq/simple_stat.h
new file mode 100644
index 000000000000..c26d0ea57a69
--- /dev/null
+++ b/tools/ufq_iosched/include/ufq/simple_stat.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#ifndef __UFQ_SIMPLE_STAT_H
+#define __UFQ_SIMPLE_STAT_H
+
+enum ufq_simp_stat_index {
+	UFQ_SIMP_INSERT_CNT,
+	UFQ_SIMP_INSERT_SIZE,
+	UFQ_SIMP_DISPATCH_CNT,
+	UFQ_SIMP_DISPATCH_SIZE,
+	UFQ_SIMP_RQMERGE_CNT,
+	UFQ_SIMP_RQMERGE_SIZE,
+	UFQ_SIMP_BIOMERGE_CNT,
+	UFQ_SIMP_BIOMERGE_SIZE,
+	UFQ_SIMP_FINISH_CNT,
+	UFQ_SIMP_FINISH_SIZE,
+	UFQ_SIMP_STAT_MAX,
+};
+
+#endif /* __UFQ_SIMPLE_STAT_H */
diff --git a/tools/ufq_iosched/ufq_simple.bpf.c b/tools/ufq_iosched/ufq_simple.bpf.c
new file mode 100644
index 000000000000..81954e73068a
--- /dev/null
+++ b/tools/ufq_iosched/ufq_simple.bpf.c
@@ -0,0 +1,604 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#include <ufq/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define UFQ_DISK_SUM		20
+#define BLK_MQ_INSERT_AT_HEAD	0x01
+#define REQ_OP_MASK		((1 << 8) - 1)
+#define SECTOR_SHIFT		9
+#define UFQ_LOOP_MAX		100
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, UFQ_SIMP_STAT_MAX);
+} stats SEC(".maps");
+
+enum ufq_simp_data_dir {
+	UFQ_SIMP_READ,
+	UFQ_SIMP_WRITE,
+	UFQ_SIMP_DIR_COUNT
+};
+
+struct queue_list_node {
+	struct bpf_list_node node;
+	struct request __kptr * req;
+};
+
+struct sort_tree_node {
+	struct bpf_refcount ref;
+	struct bpf_rb_node rb_node;
+	u64 key;
+	struct request __kptr * req;
+};
+
+struct ufq_simple_data {
+	struct bpf_spin_lock lock;
+	struct bpf_rb_root sort_tree_read __contains(sort_tree_node, rb_node);
+	struct bpf_rb_root sort_tree_write __contains(sort_tree_node, rb_node);
+	struct bpf_list_head dispatch __contains(queue_list_node, node);
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, UFQ_DISK_SUM);
+	__type(key, s32);
+	__type(value, struct ufq_simple_data);
+} ufq_map SEC(".maps");
+
+static void stat_add(u32 idx, u32 val)
+{
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
+
+	if (cnt_p)
+		(*cnt_p) += val;
+}
+
+static void stat_sub(u32 idx, u32 val)
+{
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
+
+	if (cnt_p)
+		(*cnt_p) -= val;
+}
+
+static bool sort_tree_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct sort_tree_node *node_a, *node_b;
+
+	node_a = container_of(a, struct sort_tree_node, rb_node);
+	node_b = container_of(b, struct sort_tree_node, rb_node);
+
+	return node_a->key < node_b->key;
+}
+
+static struct ufq_simple_data *dd_init_sched(struct request_queue *q)
+{
+	struct ufq_simple_data ufq_sd = {}, *ufq_sp;
+	int ret, id = q->id;
+
+	bpf_printk("ufq_simple init sched!");
+	ret = bpf_map_update_elem(&ufq_map, &id, &ufq_sd, BPF_NOEXIST);
+	if (ret && ret != -EEXIST) {
+		bpf_printk("ufq_simple/init_sched: update ufq_map err %d", ret);
+		return NULL;
+	}
+
+	ufq_sp = bpf_map_lookup_elem(&ufq_map, &id);
+	if (!ufq_sp) {
+		bpf_printk("ufq_simple/init_sched: lookup queue id %d in ufq_map failed", id);
+		return NULL;
+	}
+
+	return ufq_sp;
+}
+
+int BPF_STRUCT_OPS(ufq_simple_init_sched, struct request_queue *q)
+{
+	if (dd_init_sched(q))
+		return 0;
+	else
+		return -EPERM;
+}
+
+int BPF_STRUCT_OPS(ufq_simple_exit_sched, struct request_queue *q)
+{
+	int id = q->id;
+
+	bpf_printk("ufq_simple exit sched!");
+	bpf_map_delete_elem(&ufq_map, &id);
+	return 0;
+}
+
+int BPF_STRUCT_OPS(ufq_simple_insert_req, struct request_queue *q,
+		   struct request *rq, blk_insert_t flags,
+		   struct list_head *freeq)
+{
+	struct ufq_simple_data *ufq_sd;
+	struct queue_list_node *qnode;
+	struct sort_tree_node *snode;
+	int id = q->id, ret = 0;
+	struct request *acquired, *old;
+	enum ufq_simp_data_dir dir = ((rq->cmd_flags & REQ_OP_MASK) & 1) ?
+				   UFQ_SIMP_WRITE : UFQ_SIMP_READ;
+
+	ufq_sd = bpf_map_lookup_elem(&ufq_map, &id);
+	if (!ufq_sd) {
+		ufq_sd = dd_init_sched(q);
+		if (!ufq_sd) {
+			bpf_printk("ufq_simple/insert_req: dd_init_sched failed");
+			return -EPERM;
+		}
+	}
+
+	if (flags & BLK_MQ_INSERT_AT_HEAD) {
+		/* create queue_list_node */
+		qnode = bpf_obj_new(typeof(*qnode));
+		if (!qnode) {
+			bpf_printk("ufq_simple/insert_req: qnode alloc failed");
+			return -ENOMEM;
+		}
+
+		acquired = bpf_request_acquire(rq);
+		if (!acquired) {
+			bpf_obj_drop(qnode);
+			bpf_printk("ufq_simple/head-insert_req: request_acquire failed");
+			return -EPERM;
+		}
+
+		/* Set request for queue_list_node */
+		old = bpf_kptr_xchg(&qnode->req, acquired);
+		if (old)
+			bpf_request_release(old);
+
+		/* Add queue_list_node to dispatch list */
+		bpf_spin_lock(&ufq_sd->lock);
+		ret = bpf_list_push_back(&ufq_sd->dispatch, &qnode->node);
+		bpf_spin_unlock(&ufq_sd->lock);
+	} else {
+		/* create sort_tree_node */
+		snode = bpf_obj_new(typeof(*snode));
+		if (!snode) {
+			bpf_printk("ufq_simple/insert_req: sort_tree_node alloc failed");
+			return -ENOMEM;
+		}
+
+		/* Use request's starting sector as sort key */
+		snode->key = rq->__sector;
+
+		/*
+		 * Acquire request reference again for sort_tree_node (each node
+		 * needs independent reference)
+		 */
+		acquired = bpf_request_acquire(rq);
+		if (!acquired) {
+			bpf_obj_drop(snode);
+			bpf_printk("ufq_simple/insert_req: bpf_request_acquire failed");
+			return -EPERM;
+		}
+
+		/* Set request for sort_tree_node */
+		old = bpf_kptr_xchg(&snode->req, acquired);
+		if (old)
+			bpf_request_release(old);
+
+		/* Add sort_tree_node to red-black tree */
+		bpf_spin_lock(&ufq_sd->lock);
+		if (dir == UFQ_SIMP_READ)
+			bpf_rbtree_add(&ufq_sd->sort_tree_read, &snode->rb_node, sort_tree_less);
+		else
+			bpf_rbtree_add(&ufq_sd->sort_tree_write, &snode->rb_node, sort_tree_less);
+		bpf_spin_unlock(&ufq_sd->lock);
+	}
+
+	if (!ret) {
+		stat_add(UFQ_SIMP_INSERT_CNT, 1);
+		stat_add(UFQ_SIMP_INSERT_SIZE, rq->__data_len);
+	}
+	return ret;
+}
+
+struct request *BPF_STRUCT_OPS(ufq_simple_dispatch_req, struct request_queue *q)
+{
+	struct request *rq = NULL;
+	struct bpf_list_node *list_node;
+	struct bpf_rb_node *rb_node = NULL;
+	struct queue_list_node *qnode;
+	struct sort_tree_node *snode;
+	struct ufq_simple_data *ufq_sd;
+	int id = q->id;
+
+	ufq_sd = bpf_map_lookup_elem(&ufq_map, &id);
+	if (!ufq_sd) {
+		bpf_printk("ufq_simple/dispatch_req: ufq_map lookup %d failed", id);
+		return NULL;
+	}
+
+	bpf_spin_lock(&ufq_sd->lock);
+	list_node = bpf_list_pop_front(&ufq_sd->dispatch);
+
+	if (list_node) {
+		qnode = container_of(list_node, struct queue_list_node, node);
+		rq = bpf_kptr_xchg(&qnode->req, NULL);
+		bpf_spin_unlock(&ufq_sd->lock);
+		bpf_obj_drop(qnode);
+	} else {
+		rb_node = bpf_rbtree_first(&ufq_sd->sort_tree_read);
+		if (rb_node) {
+			rb_node = bpf_rbtree_remove(&ufq_sd->sort_tree_read, rb_node);
+		} else {
+			rb_node = bpf_rbtree_first(&ufq_sd->sort_tree_write);
+			if (rb_node)
+				rb_node = bpf_rbtree_remove(&ufq_sd->sort_tree_write, rb_node);
+		}
+
+		if (!rb_node) {
+			bpf_spin_unlock(&ufq_sd->lock);
+			goto out;
+		}
+
+		snode = container_of(rb_node, struct sort_tree_node, rb_node);
+
+		/* Get request from sort_tree_node (this will be returned) */
+		rq = bpf_kptr_xchg(&snode->req, NULL);
+		bpf_spin_unlock(&ufq_sd->lock);
+		bpf_obj_drop(snode);
+	}
+	if (!rq)
+		bpf_printk("ufq_simple/dispatch_req: no request to dispatch");
+
+out:
+	if (rq) {
+		stat_add(UFQ_SIMP_DISPATCH_CNT, 1);
+		stat_add(UFQ_SIMP_DISPATCH_SIZE, rq->__data_len);
+	}
+
+	return rq;
+}
+
+bool BPF_STRUCT_OPS(ufq_simple_has_req, struct request_queue *q, int rqs_count)
+{
+	struct ufq_simple_data *ufq_sd;
+	bool has;
+	int id = q->id;
+
+	ufq_sd = bpf_map_lookup_elem(&ufq_map, &id);
+	if (!ufq_sd) {
+		bpf_printk("ufq_simple/has_req: ufq_map lookup %d failed", id);
+		return false;
+	}
+
+	bpf_spin_lock(&ufq_sd->lock);
+	has = !bpf_list_empty(&ufq_sd->dispatch) ||
+	      bpf_rbtree_root(&ufq_sd->sort_tree_read) ||
+	      bpf_rbtree_root(&ufq_sd->sort_tree_write);
+	bpf_spin_unlock(&ufq_sd->lock);
+
+	return has;
+}
+
+void BPF_STRUCT_OPS(ufq_simple_finish_req, struct request *rq)
+{
+	if (rq) {
+		stat_add(UFQ_SIMP_FINISH_CNT, 1);
+		stat_add(UFQ_SIMP_FINISH_SIZE, (u64)rq->stats_sectors << SECTOR_SHIFT);
+	}
+}
+
+struct request *BPF_STRUCT_OPS(ufq_simple_merge_req, struct request_queue *q,
+				struct request *rq, int *type)
+{
+	struct sort_tree_node *snode = NULL;
+	sector_t rq_start, rq_end, other_start, other_end;
+	enum elv_merge mt = ELEVATOR_NO_MERGE;
+	struct bpf_rb_node *rb_node = NULL;
+	struct blk_mq_ctx *targ_mq_ctx;
+	struct blk_mq_hw_ctx *targ_mq_hctx;
+	struct ufq_simple_data *ufq_sd;
+	struct request *targ = NULL;
+	enum ufq_simp_data_dir dir;
+	struct bpf_rb_root *tree;
+	int id = q->id;
+	int count = 0;
+
+	*type = ELEVATOR_NO_MERGE;
+	dir = ((rq->cmd_flags & REQ_OP_MASK) & 1) ? UFQ_SIMP_WRITE : UFQ_SIMP_READ;
+	ufq_sd = bpf_map_lookup_elem(&ufq_map, &id);
+	if (!ufq_sd)
+		return NULL;
+
+	/* Calculate current request position and end */
+	rq_start = rq->__sector;
+	rq_end = rq_start + (rq->__data_len >> SECTOR_SHIFT);
+
+	if (dir == UFQ_SIMP_READ)
+		tree = &ufq_sd->sort_tree_read;
+	else
+		tree = &ufq_sd->sort_tree_write;
+
+	bpf_spin_lock(&ufq_sd->lock);
+	rb_node = bpf_rbtree_root(tree);
+	if (!rb_node) {
+		bpf_spin_unlock(&ufq_sd->lock);
+		return NULL;
+	}
+
+	while (mt == ELEVATOR_NO_MERGE && rb_node && count < UFQ_LOOP_MAX) {
+		count++;
+		snode = container_of(rb_node, struct sort_tree_node, rb_node);
+		targ = bpf_kptr_xchg(&snode->req, NULL);
+		if (!targ)
+			break;
+
+		other_start = targ->__sector;
+		other_end = other_start + (targ->__data_len >> SECTOR_SHIFT);
+		targ_mq_ctx = targ->mq_ctx;
+		targ_mq_hctx = targ->mq_hctx;
+
+		targ = bpf_kptr_xchg(&snode->req, targ);
+		if (targ) {
+			bpf_spin_unlock(&ufq_sd->lock);
+			bpf_request_release(targ);
+			return NULL;
+		}
+
+		if (rq_start > other_end)
+			rb_node = bpf_rbtree_right(tree, rb_node);
+		else if (rq_end < other_start)
+			rb_node = bpf_rbtree_left(tree, rb_node);
+		else if (rq_end == other_start)
+			mt = ELEVATOR_FRONT_MERGE;
+		else if (other_end == rq_start)
+			mt = ELEVATOR_BACK_MERGE;
+		else
+			break;
+
+		if (mt) {
+			if (rq->mq_ctx != targ_mq_ctx || rq->mq_hctx != targ_mq_hctx) {
+				mt = ELEVATOR_NO_MERGE;
+				break;
+			}
+
+			rb_node = bpf_rbtree_remove(tree, rb_node);
+			if (rb_node) {
+				snode = container_of(rb_node,
+					struct sort_tree_node, rb_node);
+				targ = bpf_kptr_xchg(&snode->req, NULL);
+				bpf_spin_unlock(&ufq_sd->lock);
+				if (targ) {
+					*type = mt;
+					stat_add(UFQ_SIMP_RQMERGE_CNT, 1);
+					stat_add(UFQ_SIMP_RQMERGE_SIZE, targ->__data_len);
+					stat_sub(UFQ_SIMP_INSERT_CNT, 1);
+					stat_sub(UFQ_SIMP_INSERT_SIZE, targ->__data_len);
+				}
+
+				bpf_obj_drop(snode);
+			} else {
+				bpf_spin_unlock(&ufq_sd->lock);
+				*type = ELEVATOR_NO_MERGE;
+			}
+			return targ;
+		}
+	}
+	bpf_spin_unlock(&ufq_sd->lock);
+
+	return NULL;
+}
+
+static struct request *merge_bio_left_unlock(struct ufq_simple_data *ufq_sd,
+					     struct bpf_rb_root *tree,
+					     struct sort_tree_node *snode,
+					     struct request *cand)
+{
+	sector_t cand_start, left_start, left_end;
+	struct request *free = NULL;
+	struct request *left_rq = NULL;
+	struct sort_tree_node *left_node = NULL;
+	struct bpf_rb_node *tmp, *removed = NULL;
+
+	cand_start = cand->__sector;
+	tmp = bpf_rbtree_left(tree, &snode->rb_node);
+	if (!tmp)
+		goto end;
+
+	left_node = container_of(tmp, struct sort_tree_node, rb_node);
+	if (!left_node)
+		goto end;
+
+	left_rq = bpf_kptr_xchg(&left_node->req, NULL);
+	if (!left_rq)
+		goto end;
+
+	left_start = left_rq->__sector;
+	left_end = left_start + (left_rq->__data_len >> SECTOR_SHIFT);
+
+	if (left_end == cand_start)
+		free = bpf_request_try_merge(left_rq, cand);
+
+	if (free == cand) {
+		removed = bpf_rbtree_remove(tree, &snode->rb_node);
+		left_rq = bpf_kptr_xchg(&left_node->req, left_rq);
+		bpf_spin_unlock(&ufq_sd->lock);
+		if (removed) {
+			struct sort_tree_node *drop = container_of(removed,
+					struct sort_tree_node, rb_node);
+			bpf_obj_drop(drop);
+		}
+		stat_add(UFQ_SIMP_RQMERGE_CNT, 1);
+		stat_add(UFQ_SIMP_RQMERGE_SIZE, free->__data_len);
+
+		if (left_rq)
+			bpf_request_release(left_rq);
+
+		return free;
+	}
+
+	left_rq = bpf_kptr_xchg(&left_node->req, left_rq);
+
+end:
+	cand = bpf_kptr_xchg(&snode->req, cand);
+	bpf_spin_unlock(&ufq_sd->lock);
+	if (left_rq)
+		bpf_request_release(left_rq);
+
+	if (cand)
+		bpf_request_release(cand);
+
+	return NULL;
+}
+
+static struct request *merge_bio_right_unlock(struct ufq_simple_data *ufq_sd,
+					      struct bpf_rb_root *tree,
+					      struct sort_tree_node *snode,
+					      struct request *cand)
+{
+	sector_t cand_end, right_start;
+	struct request *free = NULL;
+	struct request *right_rq = NULL;
+	struct sort_tree_node *right_node = NULL;
+	struct bpf_rb_node *right_rb, *removed = NULL;
+
+	cand_end = cand->__sector + (cand->__data_len >> SECTOR_SHIFT);
+
+	right_rb = bpf_rbtree_right(tree, &snode->rb_node);
+	if (!right_rb)
+		goto end;
+
+	right_node = container_of(right_rb, struct sort_tree_node, rb_node);
+	if (!right_node)
+		goto end;
+
+	right_rq = bpf_kptr_xchg(&right_node->req, NULL);
+	if (!right_rq)
+		goto end;
+
+	right_start = right_rq->__sector;
+	if (cand_end == right_start)
+		free = bpf_request_try_merge(cand, right_rq);
+
+	if (free == right_rq) {
+		removed = bpf_rbtree_remove(tree, right_rb);
+		cand = bpf_kptr_xchg(&snode->req, cand);
+		bpf_spin_unlock(&ufq_sd->lock);
+		if (removed) {
+			struct sort_tree_node *drop = container_of(removed,
+					struct sort_tree_node, rb_node);
+			bpf_obj_drop(drop);
+		}
+		stat_add(UFQ_SIMP_RQMERGE_CNT, 1);
+		stat_add(UFQ_SIMP_RQMERGE_SIZE, free->__data_len);
+
+		if (cand)
+			bpf_request_release(cand);
+
+		return free;
+	}
+
+	right_rq = bpf_kptr_xchg(&right_node->req, right_rq);
+
+end:
+	cand = bpf_kptr_xchg(&snode->req, cand);
+	bpf_spin_unlock(&ufq_sd->lock);
+	if (right_rq)
+		bpf_request_release(right_rq);
+
+	if (cand)
+		bpf_request_release(cand);
+
+	return NULL;
+}
+
+struct request *BPF_STRUCT_OPS(ufq_simple_merge_bio,
+			       struct request_queue *q, struct bio *bio,
+			       unsigned int nr_segs, bool *merged)
+{
+	sector_t start, end, cand_start, cand_end;
+	struct request *cand = NULL, *old, *free = NULL;
+	struct sort_tree_node *snode = NULL;
+	struct bpf_rb_node *rb_node = NULL;
+	struct ufq_simple_data *ufq_sd;
+	enum ufq_simp_data_dir dir;
+	int id = q->id, count = 0;
+	struct bpf_rb_root *tree;
+
+	if (!merged)
+		return NULL;
+	start = bio->bi_iter.bi_sector;
+	end = start + (bio->bi_iter.bi_size >> SECTOR_SHIFT);
+	dir = ((bio->bi_opf & REQ_OP_MASK) & 1) ? UFQ_SIMP_WRITE : UFQ_SIMP_READ;
+	ufq_sd = bpf_map_lookup_elem(&ufq_map, &id);
+	if (!ufq_sd)
+		return NULL;
+
+	bpf_spin_lock(&ufq_sd->lock);
+	if (dir == UFQ_SIMP_READ)
+		tree = &ufq_sd->sort_tree_read;
+	else
+		tree = &ufq_sd->sort_tree_write;
+
+	rb_node = bpf_rbtree_root(tree);
+	while (rb_node && count < UFQ_LOOP_MAX) {
+		count++;
+		snode = container_of(rb_node, struct sort_tree_node, rb_node);
+		cand = bpf_kptr_xchg(&snode->req, NULL);
+		if (!cand)
+			break;
+
+		cand_start = cand->__sector;
+		cand_end = cand_start + (cand->__data_len >> SECTOR_SHIFT);
+
+		if (end < cand_start) {
+			rb_node = bpf_rbtree_left(tree, rb_node);
+		} else if (start > cand_end) {
+			rb_node = bpf_rbtree_right(tree, rb_node);
+		} else if (cand_start == end) {
+			if (bpf_request_bio_try_merge(cand, bio, nr_segs)) {
+				*merged = true;
+				free = merge_bio_left_unlock(ufq_sd, tree, snode, cand);
+				stat_add(UFQ_SIMP_BIOMERGE_CNT, 1);
+				stat_add(UFQ_SIMP_BIOMERGE_SIZE, bio->bi_iter.bi_size);
+				return free;
+			}
+			rb_node = NULL;
+		} else if (cand_end == start) {
+			if (bpf_request_bio_try_merge(cand, bio, nr_segs)) {
+				*merged = true;
+				free = merge_bio_right_unlock(ufq_sd, tree, snode, cand);
+				stat_add(UFQ_SIMP_BIOMERGE_CNT, 1);
+				stat_add(UFQ_SIMP_BIOMERGE_SIZE, bio->bi_iter.bi_size);
+				return free;
+			}
+			rb_node = NULL;
+		} else {
+			rb_node = NULL;
+		}
+
+		old = bpf_kptr_xchg(&snode->req, cand);
+		if (old) {
+			bpf_spin_unlock(&ufq_sd->lock);
+			bpf_request_release(old);
+			return NULL;
+		}
+	}
+
+	bpf_spin_unlock(&ufq_sd->lock);
+	return NULL;
+}
+
+UFQ_OPS_DEFINE(ufq_simple_ops,
+	.init_sched		= (void *)ufq_simple_init_sched,
+	.exit_sched		= (void *)ufq_simple_exit_sched,
+	.insert_req		= (void *)ufq_simple_insert_req,
+	.dispatch_req		= (void *)ufq_simple_dispatch_req,
+	.has_req		= (void *)ufq_simple_has_req,
+	.finish_req		= (void *)ufq_simple_finish_req,
+	.merge_req		= (void *)ufq_simple_merge_req,
+	.merge_bio		= (void *)ufq_simple_merge_bio,
+	.name			= "ufq_simple");
diff --git a/tools/ufq_iosched/ufq_simple.c b/tools/ufq_iosched/ufq_simple.c
new file mode 100644
index 000000000000..0e7b018699a2
--- /dev/null
+++ b/tools/ufq_iosched/ufq_simple.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <ufq/common.h>
+#include "ufq_simple.bpf.skel.h"
+
+const char help_fmt[] =
+"A simple ufq scheduler.\n"
+"\n"
+"Usage: %s [-v] [-d] [-h]\n"
+"\n"
+"  -v            Print version\n"
+"  -d            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+#define UFQ_SIMPLE_VERSION "0.1.0"
+#define TIME_INTERVAL 3
+static bool verbose;
+static volatile int exit_req;
+__u64 old_stats[UFQ_SIMP_STAT_MAX];
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int simple)
+{
+	exit_req = 1;
+}
+
+static void read_stats(struct ufq_simple *skel, __u64 *stats)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	__u64 cnts[UFQ_SIMP_STAT_MAX][nr_cpus];
+	__u32 idx;
+
+	memset(stats, 0, sizeof(stats[0]) * UFQ_SIMP_STAT_MAX);
+
+	for (idx = 0; idx < UFQ_SIMP_STAT_MAX; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct ufq_simple *skel;
+	struct bpf_link *link;
+	__u32 opt;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	skel = UFQ_OPS_OPEN(ufq_simple_ops, ufq_simple);
+
+	while ((opt = getopt(argc, argv, "vdh")) != -1) {
+		switch (opt) {
+		case 'v':
+			printf("ufq_simple version: %s\n", UFQ_SIMPLE_VERSION);
+			return 0;
+		case 'd':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	UFQ_OPS_LOAD(skel, ufq_simple_ops, ufq_simple);
+	link = UFQ_OPS_ATTACH(skel, ufq_simple_ops, ufq_simple);
+
+	printf("ufq_simple loop ...\n");
+	while (!exit_req) {
+		__u64 stats[UFQ_SIMP_STAT_MAX];
+
+		printf("--------------------------------\n");
+		read_stats(skel, stats);
+		printf("bps:%lluk  iops:%llu\n",
+		       (stats[UFQ_SIMP_FINISH_SIZE] -
+			old_stats[UFQ_SIMP_FINISH_SIZE]) / 1024 / TIME_INTERVAL,
+		       (stats[UFQ_SIMP_FINISH_CNT] -
+			old_stats[UFQ_SIMP_FINISH_CNT]) / TIME_INTERVAL);
+		printf("(insert:   cnt=%llu size=%llu)\n",
+			stats[UFQ_SIMP_INSERT_CNT], stats[UFQ_SIMP_INSERT_SIZE]);
+		printf("(rqmerge: cnt=%llu size=%llu) (biomerge: cnt=%llu size=%llu)\n",
+			stats[UFQ_SIMP_RQMERGE_CNT], stats[UFQ_SIMP_RQMERGE_SIZE],
+			stats[UFQ_SIMP_BIOMERGE_CNT], stats[UFQ_SIMP_BIOMERGE_SIZE]);
+		printf("(dispatch: cnt=%llu size=%llu) (finish: cnt=%llu size=%llu)\n",
+			stats[UFQ_SIMP_DISPATCH_CNT], stats[UFQ_SIMP_DISPATCH_SIZE],
+			stats[UFQ_SIMP_FINISH_CNT], stats[UFQ_SIMP_FINISH_SIZE]);
+		memcpy(old_stats, stats, sizeof(old_stats));
+		sleep(TIME_INTERVAL);
+	}
+
+	printf("ufq_simple loop exit ...\n");
+	bpf_link__destroy(link);
+	ufq_simple__destroy(skel);
+
+	return 0;
+}
-- 
2.50.1 (Apple Git-155)

