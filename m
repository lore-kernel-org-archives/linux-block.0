Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <66ab295549a362f8b79921e2accd8e4fbe47f35f.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 21/24] powerpc/mm: Define platform default caches related
 flags
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Tue,  9 Oct 2018 13:52:14 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

Cache related flags like _PAGE_COHERENT and _PAGE_WRITETHRU
are defined on most platforms. The platforms not defining
them don't define any alternative. So we can give them a NUL
value directly for those platforms directly.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h |  3 +++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  4 ++++
 arch/powerpc/include/asm/pte-common.h        | 11 -----------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index ab043b3e9b99..7a8b3c94592f 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -53,6 +53,9 @@
 /* No page size encoding in the linux PTE */
 #define _PAGE_PSIZE		0
 
+/* cache related flags non existing on 40x */
+#define _PAGE_COHERENT	0
+
 #define _PAGE_KERNEL_RO		0
 #define _PAGE_KERNEL_ROX	_PAGE_EXEC
 #define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index b899c3c877ac..2b4669b3badb 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -46,6 +46,10 @@
 #define _PAGE_NA	0x0200	/* Supervisor NA, User no access */
 #define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
+/* cache related flags non existing on 8xx */
+#define _PAGE_COHERENT	0
+#define _PAGE_WRITETHRU	0
+
 #define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
 #define _PAGE_KERNEL_ROX	(_PAGE_PRIVILEGED | _PAGE_RO | _PAGE_EXEC)
 #define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_DIRTY)
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 1a2102f8b1e7..ff01368a175a 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -1,17 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Included from asm/pgtable-*.h only ! */
 
-/*
- * Some bits are only used on some cpu families... Make sure that all
- * the undefined gets a sensible default
- */
-#ifndef _PAGE_COHERENT
-#define _PAGE_COHERENT	0
-#endif
-#ifndef _PAGE_WRITETHRU
-#define _PAGE_WRITETHRU	0
-#endif
-
 /* Location of the PFN in the PTE. Most 32-bit platforms use the same
  * as _PAGE_SHIFT here (ie, naturally aligned).
  * Platform who don't just pre-define the value so we don't override it here
-- 
2.13.3
