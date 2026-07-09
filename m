Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BB28D8DB;
	Thu,  9 Jul 2026 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562517; cv=none; b=fK0hhcXlu+8ijif7AVp8cu0nxYE+MujWD3Tmoqycg2QFKd75aCpr31hMy5l70ZbjMvIm8aC0NvEImi6Krvxl0F6OVsZg7vyyw52rBvCGqeukR4AXYt+v3BcEI9LXkvwno1A1waBzR68P95sZmRxGJoLfMFfCb5tS9H+dcLrh4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562517; c=relaxed/simple;
	bh=ptPEga048dDfpgc4NPgaPHAhwkl8FxeIJkwYC+b6Dtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sbGB/KJkMplzF8KVSXREoXwa8w4MnOjvsM2IcZOsTj3Tjsp2rjnC301zx/7Ly1XvUKqgZbH/RmKZ6+EnMMxEDpUwM7gVh9lOf9YDpD/Jy2Ujgy6V68oeeJt1Y9CCxdN5O17rcCbqNP+DF2Q0aX5yCqOEp5Shrg0wZWYc23Z5IKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ka6bwvf4; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ka6bwvf4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783562507; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=scrgrihMNdO71W2pEG7BjKMGeX9yjfpvjJGMYkvGkKA=;
	b=ka6bwvf4y0jXqMy1JMcATa1ldYpuE8DE+Pr+Asu/hA92tinDN9SqHx+BAmmccmt0hjhLsydchk3i87x4JOh8+LN9rTi9R0Ye1mALHqboE3khrtPw41NqjltUc0nHhcWmoQZfEESDZnlJ6J2lxWCen7MdtaDIh6zGx+8Ox7S5uLg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6j0BH0_1783562506;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6j0BH0_1783562506 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 10:01:46 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Baokun Li <libaokun@linux.alibaba.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: try slab allocation in bio_alloc_bioset() before mempool
Date: Thu,  9 Jul 2026 10:01:45 +0800
Message-Id: <20260709020145.4011533-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the per-CPU bio cache is enabled but empty, bio_alloc_percpu_cache()
returns NULL and bio_alloc_bioset() falls straight through to the mempool
fallback:

    if (unlikely(!bio)) {
        if (!(saved_gfp & __GFP_DIRECT_RECLAIM))
            return NULL;
        ...
    }

For non-sleeping allocations (no __GFP_DIRECT_RECLAIM) this returns NULL
without ever attempting a slab allocation, even when there is plenty of
free memory.

Commit b520c4eef83d ("block: split bio_alloc_bioset more clearly into a
fast and slowpath") introduced this. Before it, a percpu cache miss fell
through to mempool_alloc(), which attempted the underlying slab allocation
first and only failed when that slab allocation failed. The restructuring
dropped the slab attempt that non-sleeping callers of a cache-enabled
bioset (such as the default fs_bio_set used by bio_alloc()) relied on.

Try a slab allocation with optimistic GFP_ flags before falling back to
the mempool whenever the bio is still NULL, so both the cache-empty and
non-cache paths share the same slab attempt. This restores the previous
behavior for non-sleeping allocations.

Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/bio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a9672..982f2e47a4218 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -555,6 +555,14 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		bio = bio_alloc_percpu_cache(bs);
 	} else {
 		opf &= ~REQ_ALLOC_CACHE;
+	}
+
+	/*
+	 * For a bioset without a percpu cache, or when the percpu cache was
+	 * empty, try a slab allocation with optimistic GFP_ flags before
+	 * falling back to the mempool.
+	 */
+	if (!bio) {
 		p = kmem_cache_alloc(bs->bio_slab, gfp);
 		if (p)
 			bio = p + bs->front_pad;
-- 
2.39.3

