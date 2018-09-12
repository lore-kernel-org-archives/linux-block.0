Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <b13fe9020383bd9fc43f9b11e07906ca9cc4e8b3.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 18/24] powerpc/mm: Distribute platform specific PAGE and
 PMD flags and definitions
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:50 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

The base kernel PAGE_XXXX definition sets are more or less platform
specific. Lets distribute them close to platform _PAGE_XXX flags
definition, and customise them to their exact platform flags.

Also defines _PAGE_PSIZE and _PTE_NONE_MASK for each platform
allthough they are defined as 0.

Do the same with _PMD flags like _PMD_USER and _PMD_PRESENT_MASK

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h       | 29 ++++++++++
 arch/powerpc/include/asm/nohash/32/pte-44x.h       | 35 ++++++++++++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       | 27 +++++++++
 arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h | 38 +++++++++++++
 arch/powerpc/include/asm/nohash/pte-book3e.h       | 30 ++++++++++
 arch/powerpc/include/asm/pte-common.h              | 66 ----------------------
 6 files changed, 159 insertions(+), 66 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index bb4b3a4b92a0..2b48bc289a4d 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -50,13 +50,42 @@
 #define _PAGE_EXEC	0x200	/* hardware: EX permission */
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
 
+/* No page size encoding in the linux PTE */
+#define _PAGE_PSIZE		0
+
+#define _PAGE_KERNEL_RO		0
+#define _PAGE_KERNEL_ROX	_PAGE_EXEC
+#define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
+#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE | _PAGE_EXEC)
+
 #define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
+#define _PMD_PRESENT_MASK	_PMD_PRESENT
 #define _PMD_BAD	0x802
 #define _PMD_SIZE_4M	0x0c0
 #define _PMD_SIZE_16M	0x0e0
+#define _PMD_USER	0
+
+#define _PTE_NONE_MASK	0
 
 /* Until my rework is finished, 40x still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
+
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
+#define _PAGE_BASE	(_PAGE_BASE_NC)
+
+/* Permission masks used to generate the __P and __S table */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_40x_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
index f812c0272364..8d6b268a986f 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-44x.h
@@ -85,14 +85,49 @@
 #define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
 #define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
 
+/* No page size encoding in the linux PTE */
+#define _PAGE_PSIZE		0
+
+#define _PAGE_KERNEL_RO		0
+#define _PAGE_KERNEL_ROX	_PAGE_EXEC
+#define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
+#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
+
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
+
 /* TODO: Add large page lowmem mapping support */
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
+#define _PMD_USER	0
 
 /* ERPN in a PTE never gets cleared, ignore it */
 #define _PTE_NONE_MASK	0xffffffff00000000ULL
 
+/*
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
+ */
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
+#if defined(CONFIG_SMP)
+#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
+#else
+#define _PAGE_BASE	(_PAGE_BASE_NC)
+#endif
+
+/* Permission masks used to generate the __P and __S table */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_44x_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index f04cb46ae8a1..d06fc45bd9ac 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -46,19 +46,46 @@
 #define _PAGE_NA	0x0200	/* Supervisor NA, User no access */
 #define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
+#define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
+#define _PAGE_KERNEL_ROX	(_PAGE_PRIVILEGED | _PAGE_RO | _PAGE_EXEC)
+#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_DIRTY)
+#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_EXEC)
+
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
+			 _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
+			 _PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_EXEC)
+
 #define _PMD_PRESENT	0x0001
+#define _PMD_PRESENT_MASK	_PMD_PRESENT
 #define _PMD_BAD	0x0fd0
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 #define _PMD_PAGE_512K	0x0004
 #define _PMD_USER	0x0020	/* APG 1 */
 
+#define _PTE_NONE_MASK	0
+
 /* Until my rework is finished, 8xx still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
 #ifdef CONFIG_PPC_16K_PAGES
 #define _PAGE_PSIZE	_PAGE_HUGE
+#else
+#define _PAGE_PSIZE		0
 #endif
 
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#define _PAGE_BASE	(_PAGE_BASE_NC)
+
+/* Permission masks used to generate the __P and __S table */
+#define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_NA)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_RO)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_RO | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_RO)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_RO | _PAGE_EXEC)
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_8xx_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
index d1ee24e9e137..1ecf60fe0909 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
@@ -31,11 +31,49 @@
 #define _PAGE_WRITETHRU	0x00400	/* H: W bit */
 #define _PAGE_SPECIAL	0x00800 /* S: Special page */
 
+#define _PAGE_KERNEL_RO		0
+#define _PAGE_KERNEL_ROX	_PAGE_EXEC
+#define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
+#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
+
+/* No page size encoding in the linux PTE */
+#define _PAGE_PSIZE		0
+
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
+
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
+#define _PMD_USER	0
+
+#define _PTE_NONE_MASK	0
 
 #define PTE_WIMGE_SHIFT (6)
 
+/*
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
+ */
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
+#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
+#else
+#define _PAGE_BASE	(_PAGE_BASE_NC)
+#endif
+
+/* Permission masks used to generate the __P and __S table */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_FSL_BOOKE_H */
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 12730b81cd98..58eef8cb569d 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -77,7 +77,37 @@
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
+#define _PMD_USER	0
+#else
+#define _PTE_NONE_MASK	0
 #endif
 
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
+
+/*
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
+ */
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#if defined(CONFIG_SMP)
+#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
+#else
+#define _PAGE_BASE	(_PAGE_BASE_NC)
+#endif
+
+/* Permission masks used to generate the __P and __S table */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_PTE_BOOK3E_H */
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 556a914ff845..cce60b3ba7d4 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -17,9 +17,6 @@
 #ifndef _PAGE_SAO
 #define _PAGE_SAO	0
 #endif
-#ifndef _PAGE_PSIZE
-#define _PAGE_PSIZE		0
-#endif
 /* _PAGE_RO and _PAGE_RW shall not be defined at the same time */
 #ifndef _PAGE_RO
 #define _PAGE_RO 0
@@ -42,30 +39,6 @@
 #define _PAGE_HUGE 0
 #endif
 
-#ifndef _PMD_PRESENT_MASK
-#define _PMD_PRESENT_MASK	_PMD_PRESENT
-#endif
-#ifndef _PMD_USER
-#define _PMD_USER	0
-#endif
-#ifndef _PAGE_KERNEL_RO
-#define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
-#endif
-#ifndef _PAGE_KERNEL_ROX
-#define _PAGE_KERNEL_ROX	(_PAGE_PRIVILEGED | _PAGE_RO | _PAGE_EXEC)
-#endif
-#ifndef _PAGE_KERNEL_RW
-#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_RW | \
-				 _PAGE_HWWRITE)
-#endif
-#ifndef _PAGE_KERNEL_RWX
-#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_RW | \
-				 _PAGE_HWWRITE | _PAGE_EXEC)
-#endif
-#ifndef _PTE_NONE_MASK
-#define _PTE_NONE_MASK	0
-#endif
-
 /* Location of the PFN in the PTE. Most 32-bit platforms use the same
  * as _PAGE_SHIFT here (ie, naturally aligned).
  * Platform who don't just pre-define the value so we don't override it here
@@ -89,45 +62,6 @@
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | \
                          _PAGE_ACCESSED | _PAGE_SPECIAL)
 
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | \
-			 _PAGE_USER | _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
-			 _PAGE_PRIVILEGED | \
-			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
-
-/*
- * We define 2 sets of base prot bits, one for basic pages (ie,
- * cacheable kernel and user pages) and one for non cacheable
- * pages. We always set _PAGE_COHERENT when SMP is enabled or
- * the processor might need it for DMA coherency.
- */
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
-#else
-#define _PAGE_BASE	(_PAGE_BASE_NC)
-#endif
-
-/* Permission masks used to generate the __P and __S table,
- *
- * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
- *
- * Write permissions imply read permissions for now (we could make write-only
- * pages on BookE but we don't bother for now). Execute permission control is
- * possible on platforms that define _PAGE_EXEC
- */
-#define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_NA)
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
-				 _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO)
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO | \
-				 _PAGE_EXEC)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO | \
-				 _PAGE_EXEC)
-
 /* Permission masks used for kernel mappings */
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
 #define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-- 
2.13.3
