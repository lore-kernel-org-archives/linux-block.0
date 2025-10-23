Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D392EBDD9
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206974; cv=none; b=HkrxquwcSJqlnGOkf231OSt6Jvzn6o8bz+AJ2FwwiU2avU/ahD9VjGP0b3k1fY+BxGRj/eVLLB7UPHxqSKUqTADYX+c9ae2ZM+jhrzrCpz1fT/1t51xTdCii0f1lQxnlGjTnh7vaEBLVwk668ABvmy6aniIkNzJb7Nh/7YvBA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206974; c=relaxed/simple;
	bh=/77RzbxehvZ1ikM+7gUsqS16xAUFQ5RX1eMOCrGM+84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRoMJaTLv1XBhvM4C5cKN63hE/YS7kIK6LxPoUzFusaQx0WtUk67SpnIgiwb0TwX7akDYgO3oEnq1Oh+2IiZZaiawtDQWj1xZQLINRT2493cRW/IYish+hLsLBd/KAJXlqQfcPj7Ol0/D0zziX7GcoCkQIqB77aNQMKXT9I8eGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kYYFswem; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYYFswem"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UDGB5IxL53rt1Dr2ri0tGGZPsBM0MXiOrsmsKajWVtY=; b=kYYFswemG3TCRweSSZtSl+JdiM
	bBfH9Q9teacyuXl/ATlEQdSFVEtQEqTXQPCide7mVX1Y97knaqWvVQqZuK8nNjTj3C/4ghalxK9Mg
	e+AEcfuVuxPIU7L/eM+iyjwjA1O+mbioI0KhZLoB5Jv6YrApVx1+sMG2I35L/mBsYsUIeDFK/FsM9
	y0zqVkAxYA9zs2fcsPJfUJUh6eaKF/TxdgRRdsLd26pqDe6XyWXCKlVfwTsTemBSob6wRlAin9o35
	EiUKhjAKXyiqEV+V4njQRXdWSCNBDPiKBuOGEakc1r3pwaFTFoIpJna7qg7R4Vm+usBgS1HaskcXn
	9lTx5jxA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqO1-00000005Tna-39ms;
	Thu, 23 Oct 2025 08:09:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] slab, block: generalize bvec_alloc_gfp
Date: Thu, 23 Oct 2025 10:08:54 +0200
Message-ID: <20251023080919.9209-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023080919.9209-1-hch@lst.de>
References: <20251023080919.9209-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bvec_alloc_gfp is useful for any place that tries to kmalloc first and
then fall back to a mempool.  Rename it and move it to blk.h to prepare
for using it to allocate the default integrity buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c          | 13 ++-----------
 include/linux/slab.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..4ea5833a7637 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -169,16 +169,6 @@ void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs)
 		kmem_cache_free(biovec_slab(nr_vecs)->slab, bv);
 }
 
-/*
- * Make the first allocation restricted and don't dump info on allocation
- * failures, since we'll fall back to the mempool in case of failure.
- */
-static inline gfp_t bvec_alloc_gfp(gfp_t gfp)
-{
-	return (gfp & ~(__GFP_DIRECT_RECLAIM | __GFP_IO)) |
-		__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
-}
-
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask)
 {
@@ -201,7 +191,8 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 	if (*nr_vecs < BIO_MAX_VECS) {
 		struct bio_vec *bvl;
 
-		bvl = kmem_cache_alloc(bvs->slab, bvec_alloc_gfp(gfp_mask));
+		bvl = kmem_cache_alloc(bvs->slab,
+				try_alloc_gfp(gfp_mask & ~__GFP_IO));
 		if (likely(bvl) || !(gfp_mask & __GFP_DIRECT_RECLAIM))
 			return bvl;
 		*nr_vecs = BIO_MAX_VECS;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index d5a8ab98035c..a6672cead03e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1113,6 +1113,16 @@ void kfree_rcu_scheduler_running(void);
  */
 size_t kmalloc_size_roundup(size_t size);
 
+/*
+ * Make the first allocation restricted and don't dump info on allocation
+ * failures, for callers that will fall back to a mempool in case of failure.
+ */
+static inline gfp_t try_alloc_gfp(gfp_t gfp)
+{
+	return (gfp & ~__GFP_DIRECT_RECLAIM) |
+		__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+}
+
 void __init kmem_cache_init_late(void);
 void __init kvfree_rcu_init(void);
 
-- 
2.47.3

