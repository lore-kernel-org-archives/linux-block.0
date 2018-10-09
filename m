Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <f01dd2670a0325da7731be171fddb62f773ca09c.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 23/24] powerpc/8xx: change name of a few page flags to
 avoid confusion
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Tue,  9 Oct 2018 13:52:18 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

_PAGE_PRIVILEGED corresponds to the SH bit which doesn't protect
against user access but only disables ASID verification on kernel
accesses. User access is controlled with _PMD_USER flag.

Name it _PAGE_SH instead of _PAGE_PRIVILEGED

_PAGE_HUGE corresponds to the SPS bit which doesn't really tells
that's it is a huge page but only that it is not a 4k page.

Name it _PAGE_SPS instead of _PAGE_HUGE

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 28 ++++++++++++++--------------
 arch/powerpc/kernel/head_8xx.S               |  6 +++---
 arch/powerpc/mm/8xx_mmu.c                    |  2 +-
 arch/powerpc/mm/dump_linuxpagetables-8xx.c   |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 2b4669b3badb..1c57efac089d 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -29,10 +29,10 @@
  */
 
 /* Definitions for 8xx embedded chips. */
-#define _PAGE_PRESENT	0x0001	/* Page is valid */
-#define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
-#define _PAGE_PRIVILEGED	0x0004	/* No ASID (context) compare */
-#define _PAGE_HUGE	0x0008	/* SPS: Small Page Size (1 if 16k, 512k or 8M)*/
+#define _PAGE_PRESENT	0x0001	/* V: Page is valid */
+#define _PAGE_NO_CACHE	0x0002	/* CI: cache inhibit */
+#define _PAGE_SH	0x0004	/* SH: No ASID (context) compare */
+#define _PAGE_SPS	0x0008	/* SPS: Small Page Size (1 if 16k, 512k or 8M)*/
 #define _PAGE_DIRTY	0x0100	/* C: page changed */
 
 /* These 4 software bits must be masked out when the L2 entry is loaded
@@ -50,15 +50,15 @@
 #define _PAGE_COHERENT	0
 #define _PAGE_WRITETHRU	0
 
-#define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
-#define _PAGE_KERNEL_ROX	(_PAGE_PRIVILEGED | _PAGE_RO | _PAGE_EXEC)
-#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_DIRTY)
-#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_EXEC)
+#define _PAGE_KERNEL_RO		(_PAGE_SH | _PAGE_RO)
+#define _PAGE_KERNEL_ROX	(_PAGE_SH | _PAGE_RO | _PAGE_EXEC)
+#define _PAGE_KERNEL_RW		(_PAGE_SH | _PAGE_DIRTY)
+#define _PAGE_KERNEL_RWX	(_PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
 
 /* Mask of bits returned by pte_pgprot() */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
 			 _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
-			 _PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_EXEC)
+			 _PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
 
 #define _PMD_PRESENT	0x0001
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
@@ -74,7 +74,7 @@
 #define PTE_ATOMIC_UPDATES	1
 
 #ifdef CONFIG_PPC_16K_PAGES
-#define _PAGE_PSIZE	_PAGE_HUGE
+#define _PAGE_PSIZE	_PAGE_SPS
 #else
 #define _PAGE_PSIZE		0
 #endif
@@ -115,28 +115,28 @@ static inline pte_t pte_mkwrite(pte_t pte)
 
 static inline bool pte_user(pte_t pte)
 {
-	return !(pte_val(pte) & _PAGE_PRIVILEGED);
+	return !(pte_val(pte) & _PAGE_SH);
 }
 
 #define pte_user pte_user
 
 static inline pte_t pte_mkprivileged(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+	return __pte(pte_val(pte) | _PAGE_SH);
 }
 
 #define pte_mkprivileged pte_mkprivileged
 
 static inline pte_t pte_mkuser(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+	return __pte(pte_val(pte) & ~_PAGE_SH);
 }
 
 #define pte_mkuser pte_mkuser
 
 static inline pte_t pte_mkhuge(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_HUGE);
+	return __pte(pte_val(pte) | _PAGE_SPS);
 }
 
 #define pte_mkhuge pte_mkhuge
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6582f824d620..134a573a9f2d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -642,7 +642,7 @@ DTLBMissIMMR:
 	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT | _PAGE_NO_CACHE
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
@@ -660,7 +660,7 @@ DTLBMissLinear:
 	li	r11, MD_PS8MEG | MD_SVALID | M_APG2
 	mtspr	SPRN_MD_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
@@ -679,7 +679,7 @@ ITLBMissLinear:
 	li	r11, MI_PS8MEG | MI_SVALID | M_APG2
 	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 9137361d687d..36484a2ef915 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -67,7 +67,7 @@ void __init MMU_init_hw(void)
 	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
 #ifdef CONFIG_PIN_TLB_DATA
 	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
-	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY;
+	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY;
 #ifdef CONFIG_PIN_TLB_IMMR
 	int i = 29;
 #else
diff --git a/arch/powerpc/mm/dump_linuxpagetables-8xx.c b/arch/powerpc/mm/dump_linuxpagetables-8xx.c
index 33f52a97975b..ab9e3f24db2f 100644
--- a/arch/powerpc/mm/dump_linuxpagetables-8xx.c
+++ b/arch/powerpc/mm/dump_linuxpagetables-8xx.c
@@ -11,7 +11,7 @@
 
 static const struct flag_info flag_array[] = {
 	{
-		.mask	= _PAGE_PRIVILEGED,
+		.mask	= _PAGE_SH,
 		.val	= 0,
 		.set	= "user",
 		.clear	= "    ",
-- 
2.13.3
