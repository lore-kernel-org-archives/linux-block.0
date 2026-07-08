Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F113AB46F;
	Wed,  8 Jul 2026 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473266; cv=none; b=U48/UDvouL+XoeJRlYlkQ3jS1Ty/tVpLOHUXAoRCagOQ8hTsLO68FDA2VWuzSmWOJkDgR4kNW4Ov6oUwS427MJD6JwzP1qk97H6EfPCbggxdyySwy6ZOOxiCKuFHENz4O8fT+6pXiZzd4TAPpSpMn9NqQ3wvPGFBpJfO2EHULL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473266; c=relaxed/simple;
	bh=uxXH4OCdQNVcoJDnYc+6TkQr4S6ahnEGta2zHozo41U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GQdbpyM3h8dBU/z72SJKYCiMQCOzhFNOah7bdHOxQC6L6Pb9dlAe0x3c9dAwfWRs3DzqoYA7IKUw1VC2WvrU9RRUfc6UZxabpcDaMX+K4DgFeUELF7x6Xu2oOB6DSokIItjCC9maUuF1qmXXYXu7vtk/+YTD4v0jct/u2LLC6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ib6BqtYq; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ib6BqtYq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783473255; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wOAaybedUmuWUHgMHUNa4smaYJIP76fQhcxrxi262GU=;
	b=ib6BqtYqplfbuiwJutWX9Q1RkN4sgfjy6YeP5cd63rlK9onogezPB8df3EncSrcBF338sT/Ndl/HYYQHXcaftEMdkf8zgD2TSwAgQvTcRn0MQIrSGlWSD12af2oJnclDmwbxiWzWjgLBIiIgHvfR2hDTdMPrHSDCyRZYumO/lZo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6fmkFO_1783473254;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6fmkFO_1783473254 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 09:14:14 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baokun Li <libaokun@linux.alibaba.com>
Subject: [PATCH] block: fix bio_alloc_bioset() percpu cache fallback for non-reclaim contexts
Date: Wed,  8 Jul 2026 09:14:13 +0800
Message-Id: <20260708011413.1710118-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bio_alloc_bioset() was restructured in commit b520c4eef83d ("block:
split bio_alloc_bioset more clearly into a fast and slowpath") to
separate fast and slow paths. However, the restructuring introduced a
regression for GFP_ATOMIC callers when the per-CPU bio cache is enabled.

Before the restructuring, a percpu cache miss would fall through to the
mempool allocation path, which internally performs a slab allocation.
After the restructuring, a percpu cache miss leaves bio as NULL and
falls through to:

    if (unlikely(!bio)) {
        if (!(saved_gfp & __GFP_DIRECT_RECLAIM))
            return NULL;
        ...
    }

This immediately returns NULL for GFP_ATOMIC callers without ever
attempting a slab allocation, even when there is plenty of free memory.
The comment says "non-blocking mempool allocations just go back to the
slab allocation", but for the percpu-cache path the slab was never tried
in the first place.

This causes virtio-pmem flush (async_pmem_flush) to fail with -ENOMEM
whenever the percpu bio cache happens to be empty (common right after
boot), making the device effectively unmountable:

    Buffer I/O error on dev pmem0, logical block 0, lost sync page write

Fix this by restructuring the allocation so that the percpu cache is
tried first when applicable, and the slab allocation is always attempted
as a common fallback path when the bio is still NULL.

Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/bio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a9672..9e7939861b94a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -553,6 +553,11 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		 */
 		opf |= REQ_ALLOC_CACHE;
 		bio = bio_alloc_percpu_cache(bs);
+		if (!bio) {
+			p = kmem_cache_alloc(bs->bio_slab, gfp);
+			if (p)
+				bio = p + bs->front_pad;
+		}
 	} else {
 		opf &= ~REQ_ALLOC_CACHE;
 		p = kmem_cache_alloc(bs->bio_slab, gfp);
-- 
2.39.3

