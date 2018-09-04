Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/13] xen: provide a prototype for xen_biovec_phys_mergeable in xen.h
Date: Tue,  4 Sep 2018 12:14:21 -0700
Message-Id: <20180904191431.20102-4-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Having multiple externs in arch headers is not a good way to provide
a common interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/io.h   | 3 ---
 arch/arm64/include/asm/io.h | 3 ---
 arch/x86/include/asm/io.h   | 5 -----
 include/xen/xen.h           | 4 ++++
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 6774553dc214..9855a4d48956 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -459,9 +459,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 
 #include <asm-generic/io.h>
 
-struct bio_vec;
-extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
-				      const struct bio_vec *vec2);
 #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
 	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
 	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 35b2e50f17fb..9bc620c44d32 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -205,9 +205,6 @@ extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
 extern int devmem_is_allowed(unsigned long pfn);
 
-struct bio_vec;
-extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
-				      const struct bio_vec *vec2);
 #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
 	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
 	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 6de64840dd22..193dae6d9c45 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -371,11 +371,6 @@ extern bool is_early_ioremap_ptep(pte_t *ptep);
 
 #ifdef CONFIG_XEN
 #include <xen/xen.h>
-struct bio_vec;
-
-extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
-				      const struct bio_vec *vec2);
-
 #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
 	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
 	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 1e1d9bd0bd37..d7a2678da77f 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -39,4 +39,8 @@ extern uint32_t xen_start_flags;
 #define xen_initial_domain()	(0)
 #endif	/* CONFIG_XEN_DOM0 */
 
+struct bio_vec;
+bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
+		const struct bio_vec *vec2);
+
 #endif	/* _XEN_XEN_H */
-- 
2.18.0
