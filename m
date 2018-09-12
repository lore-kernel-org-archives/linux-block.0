Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <d5036d6c9b61e9552eba111ceace1afa2c532df5.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 14/24] powerpc/mm: drop unused page flags
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:42 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

The following page flags in pte-common.h can be dropped:

_PAGE_ENDIAN is only used in mm/fsl_booke_mmu.c and is defined in
asm/nohash/32/pte-fsl-booke.h

_PAGE_4K_PFN is nowhere defined nor used

_PAGE_READ, _PAGE_WRITE and _PAGE_PTE are only defined and used
in book3s/64

The following page flags in book3s/64/pgtable.h can be dropped as
they are not used on this platform nor by common code.

_PAGE_NA, _PAGE_RO, _PAGE_USER and _PAGE_PSIZE

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +---------
 arch/powerpc/include/asm/pte-common.h        | 17 +----------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 56eddd79ab7d..8cf44faa6ff3 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -14,10 +14,6 @@
  */
 #define _PAGE_BIT_SWAP_TYPE	0
 
-#define _PAGE_NA		0
-#define _PAGE_RO		0
-#define _PAGE_USER		0
-
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
 #define _PAGE_READ		0x00004	/* read access allowed */
@@ -123,10 +119,6 @@
 #define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY |	\
 				 _PAGE_RW | _PAGE_EXEC)
 /*
- * No page size encoding in the linux PTE
- */
-#define _PAGE_PSIZE		0
-/*
  * _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
  */
@@ -149,7 +141,7 @@
  * pages. We always set _PAGE_COHERENT when SMP is enabled or
  * the processor might need it for DMA coherency.
  */
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #define _PAGE_BASE	(_PAGE_BASE_NC)
 
 /* Permission masks used to generate the __P and __S table,
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index bef56141a549..5a5ba43bdf98 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -14,18 +14,12 @@
 #ifndef _PAGE_EXEC
 #define _PAGE_EXEC	0
 #endif
-#ifndef _PAGE_ENDIAN
-#define _PAGE_ENDIAN	0
-#endif
 #ifndef _PAGE_COHERENT
 #define _PAGE_COHERENT	0
 #endif
 #ifndef _PAGE_WRITETHRU
 #define _PAGE_WRITETHRU	0
 #endif
-#ifndef _PAGE_4K_PFN
-#define _PAGE_4K_PFN		0
-#endif
 #ifndef _PAGE_SAO
 #define _PAGE_SAO	0
 #endif
@@ -39,9 +33,6 @@
 #define _PAGE_RW 0
 #endif
 
-#ifndef _PAGE_PTE
-#define _PAGE_PTE 0
-#endif
 /* At least one of _PAGE_PRIVILEGED or _PAGE_USER must be defined */
 #ifndef _PAGE_PRIVILEGED
 #define _PAGE_PRIVILEGED 0
@@ -122,7 +113,7 @@ static inline bool pte_user(pte_t pte)
 
 /* Mask of bits returned by pte_pgprot() */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_ENDIAN | _PAGE_4K_PFN | \
+			 _PAGE_WRITETHRU | \
 			 _PAGE_USER | _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
 			 _PAGE_PRIVILEGED | \
 			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
@@ -208,12 +199,6 @@ static inline bool pte_user(pte_t pte)
 #define PAGE_AGP		(PAGE_KERNEL_NC)
 #define HAVE_PAGE_AGP
 
-#ifndef _PAGE_READ
-/* if not defined, we should not find _PAGE_WRITE too */
-#define _PAGE_READ 0
-#define _PAGE_WRITE _PAGE_RW
-#endif
-
 #ifndef H_PAGE_4K_PFN
 #define H_PAGE_4K_PFN 0
 #endif
-- 
2.13.3
