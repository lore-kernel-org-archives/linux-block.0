Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <1e03f5f3033779b6ba3d01feae904ef161d3627c.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 13/24] powerpc/mm: Split dump_pagelinuxtables flag_array
 table
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:40 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

To reduce the complexity of flag_array, and allow the removal of
default 0 value of non existing flags, lets have one flag_array
table for each platform family with only the really existing flags.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile                        |   7 ++
 arch/powerpc/mm/dump_linuxpagetables-8xx.c      |  82 +++++++++++++
 arch/powerpc/mm/dump_linuxpagetables-book3s64.c | 115 ++++++++++++++++++
 arch/powerpc/mm/dump_linuxpagetables-generic.c  |  82 +++++++++++++
 arch/powerpc/mm/dump_linuxpagetables.c          | 155 +-----------------------
 arch/powerpc/mm/dump_linuxpagetables.h          |  19 +++
 6 files changed, 307 insertions(+), 153 deletions(-)
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-8xx.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-book3s64.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-generic.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables.h

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index cdf6a9960046..3c844bdd16c4 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -43,5 +43,12 @@ obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
 obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o
+ifdef CONFIG_PPC_PTDUMP
+obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
+obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
+obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
+endif
 obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
 obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
diff --git a/arch/powerpc/mm/dump_linuxpagetables-8xx.c b/arch/powerpc/mm/dump_linuxpagetables-8xx.c
new file mode 100644
index 000000000000..33f52a97975b
--- /dev/null
+++ b/arch/powerpc/mm/dump_linuxpagetables-8xx.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * From split of dump_linuxpagetables.c
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ */
+#include <linux/kernel.h>
+#include <asm/pgtable.h>
+
+#include "dump_linuxpagetables.h"
+
+static const struct flag_info flag_array[] = {
+	{
+		.mask	= _PAGE_PRIVILEGED,
+		.val	= 0,
+		.set	= "user",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_RO | _PAGE_NA,
+		.val	= 0,
+		.set	= "rw",
+	}, {
+		.mask	= _PAGE_RO | _PAGE_NA,
+		.val	= _PAGE_RO,
+		.set	= "r ",
+	}, {
+		.mask	= _PAGE_RO | _PAGE_NA,
+		.val	= _PAGE_NA,
+		.set	= "  ",
+	}, {
+		.mask	= _PAGE_EXEC,
+		.val	= _PAGE_EXEC,
+		.set	= " X ",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PRESENT,
+		.val	= _PAGE_PRESENT,
+		.set	= "present",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_GUARDED,
+		.val	= _PAGE_GUARDED,
+		.set	= "guarded",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "dirty",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "accessed",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_NO_CACHE,
+		.val	= _PAGE_NO_CACHE,
+		.set	= "no cache",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "special",
+	}
+};
+
+struct pgtable_level pg_level[5] = {
+	{
+	}, { /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pud */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pmd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pte */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	},
+};
diff --git a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
new file mode 100644
index 000000000000..a637e612b205
--- /dev/null
+++ b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * From split of dump_linuxpagetables.c
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ */
+#include <linux/kernel.h>
+#include <asm/pgtable.h>
+
+#include "dump_linuxpagetables.h"
+
+static const struct flag_info flag_array[] = {
+	{
+		.mask	= _PAGE_PRIVILEGED,
+		.val	= 0,
+		.set	= "user",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_READ,
+		.val	= _PAGE_READ,
+		.set	= "r",
+		.clear	= " ",
+	}, {
+		.mask	= _PAGE_WRITE,
+		.val	= _PAGE_WRITE,
+		.set	= "w",
+		.clear	= " ",
+	}, {
+		.mask	= _PAGE_EXEC,
+		.val	= _PAGE_EXEC,
+		.set	= " X ",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PTE,
+		.val	= _PAGE_PTE,
+		.set	= "pte",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PRESENT,
+		.val	= _PAGE_PRESENT,
+		.set	= "present",
+		.clear	= "       ",
+	}, {
+		.mask	= H_PAGE_HASHPTE,
+		.val	= H_PAGE_HASHPTE,
+		.set	= "hpte",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "dirty",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "accessed",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_NON_IDEMPOTENT,
+		.val	= _PAGE_NON_IDEMPOTENT,
+		.set	= "non-idempotent",
+		.clear	= "              ",
+	}, {
+		.mask	= _PAGE_TOLERANT,
+		.val	= _PAGE_TOLERANT,
+		.set	= "tolerant",
+		.clear	= "        ",
+	}, {
+		.mask	= H_PAGE_BUSY,
+		.val	= H_PAGE_BUSY,
+		.set	= "busy",
+	}, {
+#ifdef CONFIG_PPC_64K_PAGES
+		.mask	= H_PAGE_COMBO,
+		.val	= H_PAGE_COMBO,
+		.set	= "combo",
+	}, {
+		.mask	= H_PAGE_4K_PFN,
+		.val	= H_PAGE_4K_PFN,
+		.set	= "4K_pfn",
+	}, {
+#else /* CONFIG_PPC_64K_PAGES */
+		.mask	= H_PAGE_F_GIX,
+		.val	= H_PAGE_F_GIX,
+		.set	= "f_gix",
+		.is_val	= true,
+		.shift	= H_PAGE_F_GIX_SHIFT,
+	}, {
+		.mask	= H_PAGE_F_SECOND,
+		.val	= H_PAGE_F_SECOND,
+		.set	= "f_second",
+	}, {
+#endif /* CONFIG_PPC_64K_PAGES */
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "special",
+	}
+};
+
+struct pgtable_level pg_level[5] = {
+	{
+	}, { /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pud */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pmd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pte */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	},
+};
diff --git a/arch/powerpc/mm/dump_linuxpagetables-generic.c b/arch/powerpc/mm/dump_linuxpagetables-generic.c
new file mode 100644
index 000000000000..1e3829ec1348
--- /dev/null
+++ b/arch/powerpc/mm/dump_linuxpagetables-generic.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * From split of dump_linuxpagetables.c
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ */
+#include <linux/kernel.h>
+#include <asm/pgtable.h>
+
+#include "dump_linuxpagetables.h"
+
+static const struct flag_info flag_array[] = {
+	{
+		.mask	= _PAGE_USER,
+		.val	= _PAGE_USER,
+		.set	= "user",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_RW,
+		.val	= _PAGE_RW,
+		.set	= "rw",
+		.clear	= "r ",
+	}, {
+#ifndef CONFIG_PPC_BOOK3S_32
+		.mask	= _PAGE_EXEC,
+		.val	= _PAGE_EXEC,
+		.set	= " X ",
+		.clear	= "   ",
+	}, {
+#endif
+		.mask	= _PAGE_PRESENT,
+		.val	= _PAGE_PRESENT,
+		.set	= "present",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_GUARDED,
+		.val	= _PAGE_GUARDED,
+		.set	= "guarded",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "dirty",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "accessed",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_WRITETHRU,
+		.val	= _PAGE_WRITETHRU,
+		.set	= "write through",
+		.clear	= "             ",
+	}, {
+		.mask	= _PAGE_NO_CACHE,
+		.val	= _PAGE_NO_CACHE,
+		.set	= "no cache",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "special",
+	}
+};
+
+struct pgtable_level pg_level[5] = {
+	{
+	}, { /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pud */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pmd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pte */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	},
+};
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 876e2a3c79f2..e60aa6d7456d 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -27,6 +27,8 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
+#include "dump_linuxpagetables.h"
+
 #ifdef CONFIG_PPC32
 #define KERN_VIRT_START	0
 #endif
@@ -101,159 +103,6 @@ static struct addr_marker address_markers[] = {
 	{ -1,	NULL },
 };
 
-struct flag_info {
-	u64		mask;
-	u64		val;
-	const char	*set;
-	const char	*clear;
-	bool		is_val;
-	int		shift;
-};
-
-static const struct flag_info flag_array[] = {
-	{
-		.mask	= _PAGE_USER | _PAGE_PRIVILEGED,
-		.val	= _PAGE_USER,
-		.set	= "user",
-		.clear	= "    ",
-	}, {
-		.mask	= _PAGE_RW | _PAGE_RO | _PAGE_NA,
-		.val	= _PAGE_RW,
-		.set	= "rw",
-	}, {
-		.mask	= _PAGE_RW | _PAGE_RO | _PAGE_NA,
-		.val	= _PAGE_RO,
-		.set	= "ro",
-	}, {
-#if _PAGE_NA != 0
-		.mask	= _PAGE_RW | _PAGE_RO | _PAGE_NA,
-		.val	= _PAGE_RO,
-		.set	= "na",
-	}, {
-#endif
-		.mask	= _PAGE_EXEC,
-		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
-	}, {
-		.mask	= _PAGE_PTE,
-		.val	= _PAGE_PTE,
-		.set	= "pte",
-		.clear	= "   ",
-	}, {
-		.mask	= _PAGE_PRESENT,
-		.val	= _PAGE_PRESENT,
-		.set	= "present",
-		.clear	= "       ",
-	}, {
-#ifdef CONFIG_PPC_BOOK3S_64
-		.mask	= H_PAGE_HASHPTE,
-		.val	= H_PAGE_HASHPTE,
-#else
-		.mask	= _PAGE_HASHPTE,
-		.val	= _PAGE_HASHPTE,
-#endif
-		.set	= "hpte",
-		.clear	= "    ",
-	}, {
-#ifndef CONFIG_PPC_BOOK3S_64
-		.mask	= _PAGE_GUARDED,
-		.val	= _PAGE_GUARDED,
-		.set	= "guarded",
-		.clear	= "       ",
-	}, {
-#endif
-		.mask	= _PAGE_DIRTY,
-		.val	= _PAGE_DIRTY,
-		.set	= "dirty",
-		.clear	= "     ",
-	}, {
-		.mask	= _PAGE_ACCESSED,
-		.val	= _PAGE_ACCESSED,
-		.set	= "accessed",
-		.clear	= "        ",
-	}, {
-#ifndef CONFIG_PPC_BOOK3S_64
-		.mask	= _PAGE_WRITETHRU,
-		.val	= _PAGE_WRITETHRU,
-		.set	= "write through",
-		.clear	= "             ",
-	}, {
-#endif
-#ifndef CONFIG_PPC_BOOK3S_64
-		.mask	= _PAGE_NO_CACHE,
-		.val	= _PAGE_NO_CACHE,
-		.set	= "no cache",
-		.clear	= "        ",
-	}, {
-#else
-		.mask	= _PAGE_NON_IDEMPOTENT,
-		.val	= _PAGE_NON_IDEMPOTENT,
-		.set	= "non-idempotent",
-		.clear	= "              ",
-	}, {
-		.mask	= _PAGE_TOLERANT,
-		.val	= _PAGE_TOLERANT,
-		.set	= "tolerant",
-		.clear	= "        ",
-	}, {
-#endif
-#ifdef CONFIG_PPC_BOOK3S_64
-		.mask	= H_PAGE_BUSY,
-		.val	= H_PAGE_BUSY,
-		.set	= "busy",
-	}, {
-#ifdef CONFIG_PPC_64K_PAGES
-		.mask	= H_PAGE_COMBO,
-		.val	= H_PAGE_COMBO,
-		.set	= "combo",
-	}, {
-		.mask	= H_PAGE_4K_PFN,
-		.val	= H_PAGE_4K_PFN,
-		.set	= "4K_pfn",
-	}, {
-#else /* CONFIG_PPC_64K_PAGES */
-		.mask	= H_PAGE_F_GIX,
-		.val	= H_PAGE_F_GIX,
-		.set	= "f_gix",
-		.is_val	= true,
-		.shift	= H_PAGE_F_GIX_SHIFT,
-	}, {
-		.mask	= H_PAGE_F_SECOND,
-		.val	= H_PAGE_F_SECOND,
-		.set	= "f_second",
-	}, {
-#endif /* CONFIG_PPC_64K_PAGES */
-#endif
-		.mask	= _PAGE_SPECIAL,
-		.val	= _PAGE_SPECIAL,
-		.set	= "special",
-	}
-};
-
-struct pgtable_level {
-	const struct flag_info *flag;
-	size_t num;
-	u64 mask;
-};
-
-static struct pgtable_level pg_level[] = {
-	{
-	}, { /* pgd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pud */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pmd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pte */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	},
-};
-
 static void dump_flag_info(struct pg_state *st, const struct flag_info
 		*flag, u64 pte, int num)
 {
diff --git a/arch/powerpc/mm/dump_linuxpagetables.h b/arch/powerpc/mm/dump_linuxpagetables.h
new file mode 100644
index 000000000000..5d513636de73
--- /dev/null
+++ b/arch/powerpc/mm/dump_linuxpagetables.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+
+struct flag_info {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+	bool		is_val;
+	int		shift;
+};
+
+struct pgtable_level {
+	const struct flag_info *flag;
+	size_t num;
+	u64 mask;
+};
+
+extern struct pgtable_level pg_level[5];
-- 
2.13.3
