Return-Path: <prvs=6650905ae=bart.vanassche@wdc.com>
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
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Date: Mon, 14 May 2018 11:46:33 -0700
Message-Id: <20180514184634.2160-2-bart.vanassche@wdc.com>
In-Reply-To: <20180514184634.2160-1-bart.vanassche@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com>
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

f
---
 .../features/locking/cmpxchg64/arch-support.txt    | 31 ++++++++++++++++++++++
 arch/Kconfig                                       |  3 +++
 arch/alpha/Kconfig                                 |  1 +
 arch/arm/Kconfig                                   |  1 +
 arch/arm64/Kconfig                                 |  1 +
 arch/ia64/Kconfig                                  |  1 +
 arch/m68k/Kconfig                                  |  1 +
 arch/mips/Kconfig                                  |  1 +
 arch/parisc/Kconfig                                |  1 +
 arch/powerpc/Kconfig                               |  1 +
 arch/s390/Kconfig                                  |  1 +
 arch/sparc/Kconfig                                 |  1 +
 arch/x86/Kconfig                                   |  1 +
 arch/xtensa/Kconfig                                |  1 +
 14 files changed, 46 insertions(+)
 create mode 100644 Documentation/features/locking/cmpxchg64/arch-support.txt

diff --git a/Documentation/features/locking/cmpxchg64/arch-support.txt b/Documentation/features/locking/cmpxchg64/arch-support.txt
new file mode 100644
index 000000000000..65b3290ce5d5
--- /dev/null
+++ b/Documentation/features/locking/cmpxchg64/arch-support.txt
@@ -0,0 +1,31 @@
+#
+# Feature name:          cmpxchg64
+#         Kconfig:       ARCH_HAVE_CMPXCHG64
+#         description:   arch supports the cmpxchg64() API
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: |  ok  |
+    |         arc: | TODO |
+    |         arm: |!thumb|
+    |       arm64: |  ok  |
+    |         c6x: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: |  ok  |
+    |        m68k: |  ok  |
+    |  microblaze: | TODO |
+    |        mips: |64-bit|
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: |  ok  |
+    |     powerpc: |64-bit|
+    |        s390: |  ok  |
+    |          sh: | TODO |
+    |       sparc: |  ok  |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: |  ok  |
+    -----------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665c8d53..bd54eb125b15 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -358,6 +358,9 @@ config HAVE_ALIGNED_STRUCT_PAGE
 	  on a struct page for better performance. However selecting this
 	  might increase the size of a struct page by a word.
 
+config ARCH_HAVE_CMPXCHG64
+	bool
+
 config HAVE_CMPXCHG_LOCAL
 	bool
 
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b2022885ced8..94fc28e30ed2 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -16,6 +16,7 @@ config ALPHA
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select AUDIT_ARCH
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_VULNERABILITIES
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..7be06e46d329 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -21,6 +21,7 @@ config ARM
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_HAVE_CMPXCHG64 if !THUMB2_KERNEL
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..998e454a51b5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,6 +23,7 @@ config ARM64
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_INLINE_READ_LOCK if !PREEMPT
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
 	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPT
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bbe12a038d21..b99a7fd9efec 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -42,6 +42,7 @@ config IA64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_LEGACY
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select ARCH_TASK_STRUCT_ON_STACK
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..9249de31414b 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -12,6 +12,7 @@ config M68K
 	select HAVE_UID16
 	select VIRT_TO_BUS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
+	select ARCH_HAVE_CMPXCHG64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_STRNCPY_FROM_USER if MMU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 225c95da23ce..7f453e7cb9e4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -10,6 +10,7 @@ config MIPS
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
+	select ARCH_HAVE_CMPXCHG64 if 64BIT
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fc5a574c3482..deae8720861e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -31,6 +31,7 @@ config PARISC
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CPU_DEVICES
 	select GENERIC_STRNCPY_FROM_USER
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181a7cbb..315fc1e46baa 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -150,6 +150,7 @@ config PPC
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 199ac3e4da1d..b06b34ae8b3d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -74,6 +74,7 @@ config S390
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
 	select ARCH_INLINE_READ_LOCK_IRQ
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..cd41bf0d5afd 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -76,6 +76,7 @@ config SPARC64
 	select PERF_USE_VMALLOC
 	select IRQ_PREFLOW_FASTEOI
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select HAVE_C_RECORDMCOUNT
 	select NO_BOOTMEM
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..a5bcbb179ff2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -68,6 +68,7 @@ config X86
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if X86_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_CMPXCHG64
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c921e8bccdc8..8234278a821d 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -23,6 +23,7 @@ config XTENSA
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
+	select ARCH_HAVE_CMPXCHG64
 	select HAVE_FUTEX_CMPXCHG if !MMU
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
-- 
2.16.3
