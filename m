Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <72a3b716211b937bcf3f0bd44f5e93a9d191486e.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 10/24] powerpc/mm: add pte helpers to query and change pte
 flags
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Tue,  9 Oct 2018 13:51:52 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

In order to avoid using generic _PAGE_XXX flags in powerpc
core functions, define helpers for all needed flags:
- pte_mkuser() and pte_mkprivileged() to set/unset and/or
unset/set _PAGE_USER and/or _PAGE_PRIVILEGED
- pte_hashpte() to check if _PAGE_HASHPTE is set.
- pte_ci() check if cache is inhibited (already existing on book3s/64)
- pte_exprotect() to protect against execution
- pte_exec() and pte_mkexec() to query and set page execution
- pte_mkpte() to set _PAGE_PTE flag.
- pte_hw_valid() to check _PAGE_PRESENT since pte_present does
something different on book3s/64.

On book3s/32 there is no exec protection, so pte_mkexec() and
pte_exprotect() are nops and pte_exec() returns always true.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 41 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 35 ++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  5 ++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  5 ++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 28 +++++++++++++++++++
 5 files changed, 114 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 3127cc529aa1..a6ca799e0eb5 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -301,6 +301,7 @@ static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY);
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline bool pte_exec(pte_t pte)		{ return true; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 static inline int pte_present(pte_t pte)
@@ -308,6 +309,21 @@ static inline int pte_present(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
+static inline bool pte_hw_valid(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_PRESENT;
+}
+
+static inline bool pte_hashpte(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_HASHPTE);
+}
+
+static inline bool pte_ci(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_NO_CACHE);
+}
+
 /*
  * We only find page table entry in the last level
  * Hence no need for other accessors
@@ -354,6 +370,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
 
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
@@ -364,6 +385,16 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return pte;
+}
+
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
@@ -389,6 +420,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_USER);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_USER);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d4327f494371..c8564762b6f0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -519,6 +519,11 @@ static inline int pte_special(pte_t pte)
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SPECIAL));
 }
 
+static inline bool pte_exec(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_EXEC));
+}
+
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
@@ -587,6 +592,11 @@ static inline int pte_present(pte_t pte)
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID));
 }
 
+static inline bool pte_hw_valid(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT));
+}
+
 #ifdef CONFIG_PPC_MEM_KEYS
 extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
 #else
@@ -646,6 +656,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
@@ -656,6 +671,16 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_PTE);
+}
+
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	/*
@@ -689,6 +714,16 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+}
+
 /*
  * This is potentially called with a pmd as the argument, in which case it's not
  * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 4373f8c44b6d..6fecfd7854f5 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -164,6 +164,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(ptev);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 72dac522aa66..b7d65d4b61be 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -114,6 +114,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index c746e9e784cd..b256e38a047c 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -19,6 +19,9 @@ static inline int pte_read(pte_t pte)		{ return 1; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline bool pte_hashpte(pte_t pte)	{ return false; }
+static inline bool pte_ci(pte_t pte)		{ return pte_val(pte) & _PAGE_NO_CACHE; }
+static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -44,6 +47,11 @@ static inline int pte_present(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
+static inline bool pte_hw_valid(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_PRESENT;
+}
+
 /*
  * We only find page table entry in the last level
  * Hence no need for other accessors
@@ -77,6 +85,11 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
@@ -87,6 +100,11 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkspecial(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
@@ -97,6 +115,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_HUGE);
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
-- 
2.13.3
