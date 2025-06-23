Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A314A62B
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687991; cv=none; b=KyRDcOGwmKOmzHraPISWP/7ENXr52J47omeWQ1v37T4jDxPmTTGHSJcNLbwI8pZUW9mMRcnnaQtAMJ2xTJqVukcPyymrpT7r/+HsGVquPFSQFrjkNx2fiU22YDHwAjjoEDwKCSBmmgKlSJAL10z+ghQl0579CRuIiIdLEhYJrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687991; c=relaxed/simple;
	bh=bhDNstH511BzZPpOaioBgZf8XXNyCCCJbbPXE3tOLh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUN96x6rYyE3p2G6vEE7MfVOBAosXukGIQ8QizJz2Kd0GryRff6zkaBK7z76bXE0sMBiDzNdkGRp1j1PtIXL17/ZirQ+aTW9ffQgxDcBtpgzr/DUgu4dkukilqL/8Q9DoCxa1/X0KA85lEf4hgFSJlriU+WwsYazotaOpkcGw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jla9cHOn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jla9cHOn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rchnnphz/QAftABNWfln9n3JGZZ3Tbl4kyghCow2jhU=; b=jla9cHOnzb9s/fY+HfFw75Z3B3
	bts8IuvSARDpHHcK1AnwSxRBlXEB8m9qazXbUOvCtRgie/TYm6KAe7kiA9H56kRxIGu9EyATLh649
	rlDDjgmLFf/l2k/4+OgPld1JHJw2iPbLqzGIORs+gqq2+8oVXpO8OFT3f1GMufqIwKm64xhgDN/5x
	GdTGo/MFU/PcObMF3pI5kLOpceCPU9NYDIkABIsPkyclVVYgw9wq3ip7wzqrh2QJUxUjbmBMq+0s0
	aHicEMTJmlj52Me4T8G9/5JXBvpVSp9MEwYMwa/pyadXbwWymsdasVwvIaV9taAGoqEoGXRaiPJC0
	f3nz5evw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThv0-00000002znN-2eBU;
	Mon, 23 Jun 2025 14:13:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 1/8] block: don't merge different kinds of P2P transfers in a single bio
Date: Mon, 23 Jun 2025 16:12:23 +0200
Message-ID: <20250623141259.76767-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623141259.76767-1-hch@lst.de>
References: <20250623141259.76767-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

To get out of the DMA mapping helpers having to check every segment for
it's P2P status, ensure that bios either contain P2P transfers or non-P2P
transfers, and that a P2P bio only contains ranges from a single device.

This means we do the page zone access in the bio add path where it should
be still page hot, and will only have do the fairly expensive P2P topology
lookup once per bio down in the DMA mapping path, and only for already
marked bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/bio-integrity.c     |  3 +++
 block/bio.c               | 20 +++++++++++++-------
 include/linux/blk_types.h |  2 ++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 10912988c8f5..6b077ca937f6 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -128,6 +128,9 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	if (bip->bip_vcnt > 0) {
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
 
+		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+			return 0;
+
 		if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
 			bip->bip_iter.bi_size += len;
 			return len;
diff --git a/block/bio.c b/block/bio.c
index 3c0a558c90f5..92c512e876c8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -930,8 +930,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
-	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
-		return false;
 
 	if ((vec_end_addr & PAGE_MASK) != ((page_addr + off) & PAGE_MASK)) {
 		if (IS_ENABLED(CONFIG_KMSAN))
@@ -982,6 +980,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio, len));
 
+	if (is_pci_p2pdma_page(page))
+		bio->bi_opf |= REQ_P2PDMA | REQ_NOMERGE;
+
 	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
@@ -1022,11 +1023,16 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (bio->bi_iter.bi_size > UINT_MAX - len)
 		return 0;
 
-	if (bio->bi_vcnt > 0 &&
-	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset)) {
-		bio->bi_iter.bi_size += len;
-		return len;
+	if (bio->bi_vcnt > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+			return 0;
+
+		if (bvec_try_merge_page(bv, page, len, offset)) {
+			bio->bi_iter.bi_size += len;
+			return len;
+		}
 	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c..2a02972dc17c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -386,6 +386,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
+	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -418,6 +419,7 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
+#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 
-- 
2.47.2

