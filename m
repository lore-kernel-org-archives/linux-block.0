Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9E3A1A2D;
	Fri, 10 Apr 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835270; cv=none; b=qy/ERmz+QxiRiHOETk9jmeNId8GvehoTi/cMLyBVR5c5/boUFTZx/D/wIQDV/dO7DRX9Y6aGfCKxip6CQthN+ZBUWUAE4SRM64qY2EiXVA2kLAxVi6GITPPvNmHehFjwidbRFlLxDaPHItj85Y5iDmS6Q79lNmZcMEFvdDFxuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835270; c=relaxed/simple;
	bh=6r8NfQuREpOl4mPq4FRvjDXiv0VAZ2FTjeMoWGRxGAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qee7mptoi/b6mP9WpRGAS8JA7Z9idSIdxbNLnGAhCO+uB1NThswwrIt1LYzdFd0STed+gyhpGx8l7VAf3vExWKdIwkAzgN9ZJA9wbgVU5lB7OPFBHpz9yaJ8oNGQ+ttNabWCFL1xa0xZCijApTxic2C0ZAfvmW6cmonIozYW7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WvEY05aa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WvEY05aa"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id CBDB520B712B;
	Fri, 10 Apr 2026 08:34:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBDB520B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775835268;
	bh=bf3l9Mflj3y2HFV+qANusF65526jx3N6UZilVeuV6Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvEY05aaaRTDC7ik9OHBDgEE2NDxGUSmyYFw29mOTngXzqnKNF/y1wnu6YtXcaJJV
	 J9bnvqo8Ft7w2fk92Zsm2ytnydf7r2RhA2/D3+ELy9sHngtgKiSXGZqZHMXUPUvMRZ
	 vETBPiT4RElXeNcu8RW8yg285p4WU1gkMAUJbqjQ=
From: Naman Jain <namjain@linux.microsoft.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	namjain@linux.microsoft.com
Subject: [PATCH v2 2/2] block: relax pgmap check in bio_add_page for compatible zone device pages
Date: Fri, 10 Apr 2026 15:34:14 +0000
Message-ID: <20260410153414.4159050-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410153414.4159050-1-namjain@linux.microsoft.com>
References: <20260410153414.4159050-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bio_add_page() and bio_integrity_add_page() reject pages from different
dev_pagemaps entirely, returning 0 even when those pages have compatible
DMA mapping requirements. This forces callers to start a new bio when
buffers span pgmap boundaries, even though the pages could safely coexist
as separate bvec entries.

This matters for guests where memory is registered through
devm_memremap_pages() with MEMORY_DEVICE_GENERIC in multiple calls,
creating separate dev_pagemaps for each chunk. When a direct I/O buffer
spans two such chunks, bio_add_page() rejects the second page, forcing an
unnecessary bio split or I/O failure.

Introduce zone_device_pages_compatible() in blk.h to check whether two
pages can coexist in the same bio as separate bvec entries. The block DMA
iterator (blk_dma_map_iter_start) caches the P2PDMA mapping state from the
first segment and applies it to all others, so P2PDMA pages from different
pgmaps must not be mixed, and neither must P2PDMA and non-P2PDMA pages.
All other combinations (MEMORY_DEVICE_GENERIC pages from different pgmaps,
or MEMORY_DEVICE_GENERIC with normal RAM) use the same dma_map_phys path
and are safe.

Replace the blanket zone_device_pages_have_same_pgmap() rejection with
zone_device_pages_compatible(), while keeping
zone_device_pages_have_same_pgmap() as a merge guard.
Pages from different pgmaps can be added as separate bvec entries but
must not be coalesced into the same segment, as that would make
it impossible to recover the correct pgmap via page_pgmap().

Fixes: 49580e690755 ("block: add check when merging zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 block/bio-integrity.c |  6 +++---
 block/bio.c           |  6 +++---
 block/blk.h           | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf0477943..e54c6e06e1cbb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -231,10 +231,10 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	if (bip->bip_vcnt > 0) {
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
 
-		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+		if (!zone_device_pages_compatible(bv->bv_page, page))
 			return 0;
-
-		if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
+		if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
+		    bvec_try_merge_hw_page(q, bv, page, len, offset)) {
 			bip->bip_iter.bi_size += len;
 			return len;
 		}
diff --git a/block/bio.c b/block/bio.c
index 641ef0928d735..c52a0bd1e8993 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1048,10 +1048,10 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+		if (!zone_device_pages_compatible(bv->bv_page, page))
 			return 0;
-
-		if (bvec_try_merge_page(bv, page, len, offset)) {
+		if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
+		    bvec_try_merge_page(bv, page, len, offset)) {
 			bio->bi_iter.bi_size += len;
 			return len;
 		}
diff --git a/block/blk.h b/block/blk.h
index 50a41db039133..b998a7761faf3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -136,6 +136,25 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	return true;
 }
 
+/*
+ * Check if two pages from potentially different zone device pgmaps can
+ * coexist as separate bvec entries in the same bio.
+ *
+ * The block DMA iterator (blk_dma_map_iter_start) caches the P2PDMA mapping
+ * state from the first segment and applies it to all subsequent segments, so
+ * P2PDMA pages from different pgmaps must not be mixed in the same bio.
+ *
+ * Other zone device types (FS_DAX, GENERIC) use the same dma_map_phys() path
+ * as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
+ */
+static inline bool zone_device_pages_compatible(const struct page *a,
+						const struct page *b)
+{
+	if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
+		return zone_device_pages_have_same_pgmap(a, b);
+	return true;
+}
+
 static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
-- 
2.43.0

