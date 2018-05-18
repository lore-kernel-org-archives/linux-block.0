Return-Path: <prvs=669a0b661=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v11 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Date: Fri, 18 May 2018 11:00:05 -0700
Message-Id: <20180518180006.24389-2-bart.vanassche@wdc.com>
In-Reply-To: <20180518180006.24389-1-bart.vanassche@wdc.com>
References: <20180518180006.24389-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The next patch in this series introduces a call to cmpxchg64()
in the block layer core for those architectures on which this
functionality is available. Make it possible to test whether
cmpxchg64() is available by introducing CONFIG_ARCH_HAVE_CMPXCHG64.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 .../features/locking/cmpxchg64/arch-support.txt    | 33 ++++++++++++++++++++++
 arch/Kconfig                                       |  4 +++
 arch/arm/Kconfig                                   |  1 +
 arch/ia64/Kconfig                                  |  1 +
 arch/m68k/Kconfig                                  |  1 +
 arch/mips/Kconfig                                  |  1 +
 arch/parisc/Kconfig                                |  1 +
 arch/riscv/Kconfig                                 |  1 +
 arch/sparc/Kconfig                                 |  1 +
 arch/x86/Kconfig                                   |  1 +
 arch/xtensa/Kconfig                                |  1 +
 11 files changed, 46 insertions(+)
 create mode 100644 Documentation/features/locking/cmpxchg64/arch-support.txt

diff --git a/Documentation/features/locking/cmpxchg64/arch-support.txt b/Documentation/features/locking/cmpxchg64/arch-support.txt
new file mode 100644
index 000000000000..84bfef7242b2
--- /dev/null
+++ b/Documentation/features/locking/cmpxchg64/arch-support.txt
@@ -0,0 +1,33 @@
+#
+# Feature name:          cmpxchg64
+#         Kconfig:       ARCH_HAVE_CMPXCHG64
+#         description:   arch supports the cmpxchg64() API
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: |  ok  |
+    |         arc: |  ..  |
+    |         arm: |  ok  |
+    |       arm64: |  ok  |
+    |         c6x: |  ..  |
+    |       h8300: |  ..  |
+    |     hexagon: |  ..  |
+    |        ia64: |  ok  |
+    |        m68k: |  ok  |
+    |  microblaze: |  ..  |
+    |        mips: |  ok  |
+    |       nds32: |  ..  |
+    |       nios2: |  ..  |
+    |    openrisc: |  ..  |
+    |      parisc: |  ok  |
+    |     powerpc: |  ok  |
+    |       riscv: |  ok  |
+    |        s390: |  ok  |
+    |          sh: |  ..  |
+    |       sparc: |  ok  |
+    |          um: |  ..  |
+    |   unicore32: |  ..  |
+    |         x86: |  ok  |
+    |      xtensa: |  ok  |
+    -----------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665c8d53..9840b2577af1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -358,6 +358,10 @@ config HAVE_ALIGNED_STRUCT_PAGE
 	  on a struct page for better performance. However selecting this
 	  might increase the size of a struct page by a word.
 
+config ARCH_HAVE_CMPXCHG64
+	bool
+	default y if 64BIT
+
 config HAVE_CMPXCHG_LOCAL
 	bool
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..02c75697176e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -13,6 +13,7 @@ config ARM
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAVE_CMPXCHG64 if !THUMB2_KERNEL
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bbe12a038d21..31c49e1482e2 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -41,6 +41,7 @@ config IA64
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_LEGACY
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..7b87cda3bbed 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -11,6 +11,7 @@ config M68K
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select VIRT_TO_BUS
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 225c95da23ce..088bca0fd9f2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -7,6 +7,7 @@ config MIPS
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAVE_CMPXCHG64 if 64BIT
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fc5a574c3482..166c30865255 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -30,6 +30,7 @@ config PARISC
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CPU_DEVICES
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cd4fd85fde84..4f886a055ff6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -8,6 +8,7 @@ config RISCV
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_WANT_FRAME_POINTERS
 	select CLONE_BACKWARDS
 	select COMMON_CLK
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..e3429b78c491 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -75,6 +75,7 @@ config SPARC64
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select IRQ_PREFLOW_FASTEOI
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
 	select NO_BOOTMEM
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..52331f395bf4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -67,6 +67,7 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if X86_64
+	select ARCH_HAVE_CMPXCHG64		if X86_CMPXCHG64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c921e8bccdc8..0e5c77958fa3 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -4,6 +4,7 @@ config ZONE_DMA
 
 config XTENSA
 	def_bool y
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
-- 
2.16.3
