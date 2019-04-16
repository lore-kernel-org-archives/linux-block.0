Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB7C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 06:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0B20645
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 06:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfDPGeL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:34:11 -0400
Received: from verein.lst.de ([213.95.11.211]:33421 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfDPGeL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 02:34:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 22BCA68AA6; Tue, 16 Apr 2019 08:33:57 +0200 (CEST)
Date:   Tue, 16 Apr 2019 08:33:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190416063356.GA25763@lst.de>
References: <20190408104641.4905-1-hch@lst.de> <20190408104641.4905-2-hch@lst.de> <20190415194435.GA23676@roeck-us.net> <20190415205242.GA6380@lst.de> <20190415210731.GA32723@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415210731.GA32723@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 15, 2019 at 02:07:31PM -0700, Guenter Roeck wrote:
> On Mon, Apr 15, 2019 at 10:52:42PM +0200, Christoph Hellwig wrote:
> > On Mon, Apr 15, 2019 at 12:44:35PM -0700, Guenter Roeck wrote:
> > > This patch causes crashes with various boot tests. Most sparc tests crash, as
> > > well as several arm tests. Bisect results in both cases point to this patch.
> > 
> > That just means we trigger an existing bug more easily now.  I'll see
> > if I can help with the issues.
> 
> Code which previously worked reliably no longer does. I would be quite
> hesitant to call this "trigger an existing bug more easily". "Regression"
> seems to be a more appropriate term - even more so as it seems to cause
> 'init' crashes, at least on arm.

Well, we have these sgls in the wild already, it just is that they
are fairly rare.  For a related fix on a mainstream platform see
here for example:

	https://lore.kernel.org/patchwork/patch/1050367/

Below is a rework of the sparc32 iommu code that should avoid your
reported problem.  Please send any other reports to me as well.

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index e8d5d73ca40d..93c2fc440cb0 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -175,16 +175,38 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 	}
 }
 
-static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
+static u32 __sbus_iommu_map_page(struct device *dev, struct page *page, unsigned offset,
+		unsigned len, bool need_flush)
 {
 	struct iommu_struct *iommu = dev->archdata.iommu;
+	phys_addr_t paddr = page_to_phys(page) + offset, p;
+	unsigned long pfn = __phys_to_pfn(paddr);
+	unsigned long off = (unsigned long)paddr & ~PAGE_MASK;
+	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	int ioptex;
 	iopte_t *iopte, *iopte0;
 	unsigned int busa, busa0;
 	int i;
 
+	/* XXX So what is maxphys for us and how do drivers know it? */
+	if (!len || len > 256 * 1024)
+		return DMA_MAPPING_ERROR;
+
+	/*
+	 * We expect unmapped highmem pages to be not in the cache.
+	 * XXX Is this a good assumption?
+	 * XXX What if someone else unmaps it here and races us?
+	 */
+	if (need_flush && !PageHighMem(page)) {
+		for (p = paddr & PAGE_MASK; p < paddr + len; p += PAGE_SIZE) {
+			unsigned long vaddr = (unsigned long)phys_to_virt(p);
+
+			flush_page_for_dma(vaddr);
+		}
+	}
+
 	/* page color = pfn of page */
-	ioptex = bit_map_string_get(&iommu->usemap, npages, page_to_pfn(page));
+	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
 	if (ioptex < 0)
 		panic("iommu out");
 	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
@@ -193,11 +215,11 @@ static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
 	busa = busa0;
 	iopte = iopte0;
 	for (i = 0; i < npages; i++) {
-		iopte_val(*iopte) = MKIOPTE(page_to_pfn(page), IOPERM);
+		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
 		iommu_invalidate_page(iommu->regs, busa);
 		busa += PAGE_SIZE;
 		iopte++;
-		page++;
+		pfn++;
 	}
 
 	iommu_flush_iotlb(iopte0, npages);
@@ -205,99 +227,62 @@ static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
 	return busa0;
 }
 
-static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t len)
-{
-	void *vaddr = page_address(page) + offset;
-	unsigned long off = (unsigned long)vaddr & ~PAGE_MASK;
-	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	
-	/* XXX So what is maxphys for us and how do drivers know it? */
-	if (!len || len > 256 * 1024)
-		return DMA_MAPPING_ERROR;
-	return iommu_get_one(dev, virt_to_page(vaddr), npages) + off;
-}
-
 static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
 		struct page *page, unsigned long offset, size_t len,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	flush_page_for_dma(0);
-	return __sbus_iommu_map_page(dev, page, offset, len);
+	return __sbus_iommu_map_page(dev, page, offset, len, false);
 }
 
 static dma_addr_t sbus_iommu_map_page_pflush(struct device *dev,
 		struct page *page, unsigned long offset, size_t len,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	void *vaddr = page_address(page) + offset;
-	unsigned long p = ((unsigned long)vaddr) & PAGE_MASK;
-
-	while (p < (unsigned long)vaddr + len) {
-		flush_page_for_dma(p);
-		p += PAGE_SIZE;
-	}
-
-	return __sbus_iommu_map_page(dev, page, offset, len);
+	return __sbus_iommu_map_page(dev, page, offset, len, true);
 }
 
-static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs,
+		bool need_flush)
 {
 	struct scatterlist *sg;
-	int i, n;
-
-	flush_page_for_dma(0);
+	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
+		sg->dma_address = __sbus_iommu_map_page(dev, sg_page(sg),
+				sg->offset, sg->length, need_flush);
+		if (sg->dma_address == DMA_MAPPING_ERROR)
+			return 0;
 		sg->dma_length = sg->length;
 	}
 
 	return nents;
 }
 
-static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
+static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	unsigned long page, oldpage = 0;
-	struct scatterlist *sg;
-	int i, j, n;
-
-	for_each_sg(sgl, sg, nents, j) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-
-		/*
-		 * We expect unmapped highmem pages to be not in the cache.
-		 * XXX Is this a good assumption?
-		 * XXX What if someone else unmaps it here and races us?
-		 */
-		if ((page = (unsigned long) page_address(sg_page(sg))) != 0) {
-			for (i = 0; i < n; i++) {
-				if (page != oldpage) {	/* Already flushed? */
-					flush_page_for_dma(page);
-					oldpage = page;
-				}
-				page += PAGE_SIZE;
-			}
-		}
-
-		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
-		sg->dma_length = sg->length;
-	}
+	flush_page_for_dma(0);
+	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, false);
+}
 
-	return nents;
+static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, true);
 }
 
-static void iommu_release_one(struct device *dev, u32 busa, int npages)
+static void __sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
+		size_t len)
 {
 	struct iommu_struct *iommu = dev->archdata.iommu;
-	int ioptex;
-	int i;
+	unsigned busa, npages, ioptex, i;
 
+	busa = dma_addr & PAGE_MASK;
 	BUG_ON(busa < iommu->start);
 	ioptex = (busa - iommu->start) >> PAGE_SHIFT;
+	npages = ((dma_addr & ~PAGE_MASK) + len + PAGE_SIZE-1) >> PAGE_SHIFT;
 	for (i = 0; i < npages; i++) {
 		iopte_val(iommu->page_table[ioptex + i]) = 0;
 		iommu_invalidate_page(iommu->regs, busa);
@@ -309,22 +294,17 @@ static void iommu_release_one(struct device *dev, u32 busa, int npages)
 static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		size_t len, enum dma_data_direction dir, unsigned long attrs)
 {
-	unsigned long off = dma_addr & ~PAGE_MASK;
-	int npages;
-
-	npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
-	iommu_release_one(dev, dma_addr & PAGE_MASK, npages);
+	__sbus_iommu_unmap_page(dev, dma_addr, len);
 }
 
 static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
-	int i, n;
+	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		iommu_release_one(dev, sg->dma_address & PAGE_MASK, n);
+		__sbus_iommu_unmap_page(dev, sg->dma_address, sg->length);
 		sg->dma_address = 0x21212121;
 	}
 }
