Return-Path: <hpa@zytor.com>
Date: Fri, 18 May 2018 11:32:57 -0700
In-Reply-To: <20180518180006.24389-2-bart.vanassche@wdc.com>
References: <20180518180006.24389-1-bart.vanassche@wdc.com> <20180518180006.24389-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v11 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
CC: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>
From: hpa@zytor.com
Message-ID: <C2876D88-F59B-48D7-85D9-49EB79B1FBE3@zytor.com>
List-ID: <linux-block@vger.kernel.org>

On May 18, 2018 11:00:05 AM PDT, Bart Van Assche <bart=2Evanassche@wdc=2Eco=
m> wrote:
>The next patch in this series introduces a call to cmpxchg64()
>in the block layer core for those architectures on which this
>functionality is available=2E Make it possible to test whether
>cmpxchg64() is available by introducing CONFIG_ARCH_HAVE_CMPXCHG64=2E
>
>Signed-off-by: Bart Van Assche <bart=2Evanassche@wdc=2Ecom>
>Cc: Catalin Marinas <catalin=2Emarinas@arm=2Ecom>
>Cc: Will Deacon <will=2Edeacon@arm=2Ecom>
>Cc: Tony Luck <tony=2Eluck@intel=2Ecom>
>Cc: Fenghua Yu <fenghua=2Eyu@intel=2Ecom>
>Cc: Geert Uytterhoeven <geert@linux-m68k=2Eorg>
>Cc: "James E=2EJ=2E Bottomley" <jejb@parisc-linux=2Eorg>
>Cc: Helge Deller <deller@gmx=2Ede>
>Cc: Benjamin Herrenschmidt <benh@kernel=2Ecrashing=2Eorg>
>Cc: Paul Mackerras <paulus@samba=2Eorg>
>Cc: Michael Ellerman <mpe@ellerman=2Eid=2Eau>
>Cc: Martin Schwidefsky <schwidefsky@de=2Eibm=2Ecom>
>Cc: Heiko Carstens <heiko=2Ecarstens@de=2Eibm=2Ecom>
>Cc: David S=2E Miller <davem@davemloft=2Enet>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@redhat=2Ecom>
>Cc: H=2E Peter Anvin <hpa@zytor=2Ecom>
>Cc: Chris Zankel <chris@zankel=2Enet>
>Cc: Max Filippov <jcmvbkbc@gmail=2Ecom>
>Cc: Arnd Bergmann <arnd@arndb=2Ede>
>Cc: Jonathan Corbet <corbet@lwn=2Enet>
>---
>=2E=2E=2E/features/locking/cmpxchg64/arch-support=2Etxt    | 33
>++++++++++++++++++++++
> arch/Kconfig                                       |  4 +++
> arch/arm/Kconfig                                   |  1 +
> arch/ia64/Kconfig                                  |  1 +
> arch/m68k/Kconfig                                  |  1 +
> arch/mips/Kconfig                                  |  1 +
> arch/parisc/Kconfig                                |  1 +
> arch/riscv/Kconfig                                 |  1 +
> arch/sparc/Kconfig                                 |  1 +
> arch/x86/Kconfig                                   |  1 +
> arch/xtensa/Kconfig                                |  1 +
> 11 files changed, 46 insertions(+)
>create mode 100644
>Documentation/features/locking/cmpxchg64/arch-support=2Etxt
>
>diff --git a/Documentation/features/locking/cmpxchg64/arch-support=2Etxt
>b/Documentation/features/locking/cmpxchg64/arch-support=2Etxt
>new file mode 100644
>index 000000000000=2E=2E84bfef7242b2
>--- /dev/null
>+++ b/Documentation/features/locking/cmpxchg64/arch-support=2Etxt
>@@ -0,0 +1,33 @@
>+#
>+# Feature name:          cmpxchg64
>+#         Kconfig:       ARCH_HAVE_CMPXCHG64
>+#         description:   arch supports the cmpxchg64() API
>+#
>+    -----------------------
>+    |         arch |status|
>+    -----------------------
>+    |       alpha: |  ok  |
>+    |         arc: |  =2E=2E  |
>+    |         arm: |  ok  |
>+    |       arm64: |  ok  |
>+    |         c6x: |  =2E=2E  |
>+    |       h8300: |  =2E=2E  |
>+    |     hexagon: |  =2E=2E  |
>+    |        ia64: |  ok  |
>+    |        m68k: |  ok  |
>+    |  microblaze: |  =2E=2E  |
>+    |        mips: |  ok  |
>+    |       nds32: |  =2E=2E  |
>+    |       nios2: |  =2E=2E  |
>+    |    openrisc: |  =2E=2E  |
>+    |      parisc: |  ok  |
>+    |     powerpc: |  ok  |
>+    |       riscv: |  ok  |
>+    |        s390: |  ok  |
>+    |          sh: |  =2E=2E  |
>+    |       sparc: |  ok  |
>+    |          um: |  =2E=2E  |
>+    |   unicore32: |  =2E=2E  |
>+    |         x86: |  ok  |
>+    |      xtensa: |  ok  |
>+    -----------------------
>diff --git a/arch/Kconfig b/arch/Kconfig
>index 8e0d665c8d53=2E=2E9840b2577af1 100644
>--- a/arch/Kconfig
>+++ b/arch/Kconfig
>@@ -358,6 +358,10 @@ config HAVE_ALIGNED_STRUCT_PAGE
> 	  on a struct page for better performance=2E However selecting this
> 	  might increase the size of a struct page by a word=2E
>=20
>+config ARCH_HAVE_CMPXCHG64
>+	bool
>+	default y if 64BIT
>+
> config HAVE_CMPXCHG_LOCAL
> 	bool
>=20
>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>index a7f8e7f4b88f=2E=2E02c75697176e 100644
>--- a/arch/arm/Kconfig
>+++ b/arch/arm/Kconfig
>@@ -13,6 +13,7 @@ config ARM
> 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
> 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>+	select ARCH_HAVE_CMPXCHG64 if !THUMB2_KERNEL
> 	select ARCH_HAVE_CUSTOM_GPIO_H
> 	select ARCH_HAS_GCOV_PROFILE_ALL
> 	select ARCH_MIGHT_HAVE_PC_PARPORT
>diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>index bbe12a038d21=2E=2E31c49e1482e2 100644
>--- a/arch/ia64/Kconfig
>+++ b/arch/ia64/Kconfig
>@@ -41,6 +41,7 @@ config IA64
> 	select GENERIC_PENDING_IRQ if SMP
> 	select GENERIC_IRQ_SHOW
> 	select GENERIC_IRQ_LEGACY
>+	select ARCH_HAVE_CMPXCHG64
> 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> 	select GENERIC_IOMAP
> 	select GENERIC_SMP_IDLE_THREAD
>diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>index 785612b576f7=2E=2E7b87cda3bbed 100644
>--- a/arch/m68k/Kconfig
>+++ b/arch/m68k/Kconfig
>@@ -11,6 +11,7 @@ config M68K
> 	select GENERIC_ATOMIC64
> 	select HAVE_UID16
> 	select VIRT_TO_BUS
>+	select ARCH_HAVE_CMPXCHG64
> 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
> 	select GENERIC_CPU_DEVICES
> 	select GENERIC_IOMAP
>diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>index 225c95da23ce=2E=2E088bca0fd9f2 100644
>--- a/arch/mips/Kconfig
>+++ b/arch/mips/Kconfig
>@@ -7,6 +7,7 @@ config MIPS
> 	select ARCH_DISCARD_MEMBLOCK
> 	select ARCH_HAS_ELF_RANDOMIZE
> 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>+	select ARCH_HAVE_CMPXCHG64 if 64BIT
> 	select ARCH_SUPPORTS_UPROBES
> 	select ARCH_USE_BUILTIN_BSWAP
> 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
>diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>index fc5a574c3482=2E=2E166c30865255 100644
>--- a/arch/parisc/Kconfig
>+++ b/arch/parisc/Kconfig
>@@ -30,6 +30,7 @@ config PARISC
> 	select GENERIC_ATOMIC64 if !64BIT
> 	select GENERIC_IRQ_PROBE
> 	select GENERIC_PCI_IOMAP
>+	select ARCH_HAVE_CMPXCHG64
> 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> 	select GENERIC_SMP_IDLE_THREAD
> 	select GENERIC_CPU_DEVICES
>diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>index cd4fd85fde84=2E=2E4f886a055ff6 100644
>--- a/arch/riscv/Kconfig
>+++ b/arch/riscv/Kconfig
>@@ -8,6 +8,7 @@ config RISCV
> 	select OF
> 	select OF_EARLY_FLATTREE
> 	select OF_IRQ
>+	select ARCH_HAVE_CMPXCHG64
> 	select ARCH_WANT_FRAME_POINTERS
> 	select CLONE_BACKWARDS
> 	select COMMON_CLK
>diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>index 8767e45f1b2b=2E=2Ee3429b78c491 100644
>--- a/arch/sparc/Kconfig
>+++ b/arch/sparc/Kconfig
>@@ -75,6 +75,7 @@ config SPARC64
> 	select HAVE_PERF_EVENTS
> 	select PERF_USE_VMALLOC
> 	select IRQ_PREFLOW_FASTEOI
>+	select ARCH_HAVE_CMPXCHG64
> 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> 	select HAVE_C_RECORDMCOUNT
> 	select NO_BOOTMEM
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index c07f492b871a=2E=2E52331f395bf4 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -67,6 +67,7 @@ config X86
> 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> 	select ARCH_HAS_UBSAN_SANITIZE_ALL
> 	select ARCH_HAS_ZONE_DEVICE		if X86_64
>+	select ARCH_HAVE_CMPXCHG64		if X86_CMPXCHG64
> 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
> 	select ARCH_MIGHT_HAVE_PC_PARPORT
>diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>index c921e8bccdc8=2E=2E0e5c77958fa3 100644
>--- a/arch/xtensa/Kconfig
>+++ b/arch/xtensa/Kconfig
>@@ -4,6 +4,7 @@ config ZONE_DMA
>=20
> config XTENSA
> 	def_bool y
>+	select ARCH_HAVE_CMPXCHG64
> 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
> 	select ARCH_WANT_FRAME_POINTERS
> 	select ARCH_WANT_IPC_PARSE_VERSION

Perhaps it would be better to define cmpxchg64 as a macro (which can be #d=
efine cmpxchg64 cmpxchg64) rather putting this in Kconfig? Putting it in Kc=
onfig makes sense if it affects config options=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
