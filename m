Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75499364049
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536071; cv=none; b=Ctkk0qhtsKiOSHA22GM2Bvs9o4giEmFGb4QSLXVJK3If7gazamNdyaQzMllu2zP+/bInOP/dJ/OhiTFx0ZDXkmbXbZJ51krehEhPJqeNi/uHMuNa15aJYEwrdADRnDrEU/LId62eoQEE6ET2zYXUGCvcMuwnypr9Ovkn/YLg2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536071; c=relaxed/simple;
	bh=N3tNyF++LQGvDb388xzI0rH9GxGkrrzCY5McsCsoLXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQGjyPkwkk2f6DTkYa2fGrE7ba2ZUBbVoLRUtFLEmSF05VGcpw5rPmUF0fZXe5fi4WeSK9R+kP5F+pad0sZPEzFIoCu0DtZ3eom6QS+C9TS/FgAZRvYpcR8MU82EJ+ZkTvW0Fi6Zp7a5Xa0WLf+gxdNlSnUV4f22CEAbqcxgtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QelhRizN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QelhRizN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2tHVA1Ng8MAmkH4viRjejvgap4agzC3k6mGhfxyOjhY=;
	b=QelhRizNxR+gozrUcd1o7vpzSTmy4rRtmXUw16pd6zAxfvTEtvC0mnGyTsPqP9z56rapkv
	wXzAcOq/yzHZTiAEyujXjpalU2FIlelIUWKlhcbCrC45cn8vPqTaFr7scPnfl4ELJ+RIPC
	9PAQ35vaOHSF69dBpHHR77ZQfZ7OgEE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-CR_kASp4PB2HaAbi5UjRig-1; Thu,
 26 Mar 2026 10:41:06 -0400
X-MC-Unique: CR_kASp4PB2HaAbi5UjRig-1
X-Mimecast-MFC-AGG-ID: CR_kASp4PB2HaAbi5UjRig_1774536066
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC6E51800620;
	Thu, 26 Mar 2026 14:41:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BC601800765;
	Thu, 26 Mar 2026 14:41:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2] bio: fix kmemleak false positives from percpu bio alloc cache
Date: Thu, 26 Mar 2026 22:40:58 +0800
Message-ID: <20260326144058.2392319-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When a bio is allocated from the mempool with REQ_ALLOC_CACHE set and
later completed, bio_put() places it into the per-cpu bio_alloc_cache
via bio_put_percpu_cache() instead of freeing it back to the
mempool/slab. The slab allocation remains tracked by kmemleak, but the
only reference to the bio is through the percpu cache's free_list,
which kmemleak fails to trace through percpu memory. This causes
kmemleak to report the cached bios as unreferenced objects.

Use symmetric kmemleak_free()/kmemleak_alloc() calls to properly track
bios across percpu cache transitions:

 - bio_put_percpu_cache: call kmemleak_free() when a bio enters the
   cache, unregistering it from kmemleak tracking.

 - bio_alloc_percpu_cache: call kmemleak_alloc() when a bio is taken
   from the cache for reuse, re-registering it so that genuine leaks
   of reused bios remain detectable.

 - __bio_alloc_cache_prune: call kmemleak_alloc() before bio_free() so
   that kmem_cache_free()'s internal kmemleak_free() has a matching
   allocation to pair with.

Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- rebase on for-7.1/block
	- add helper of bio_slab_addr()

 block/bio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 77067fa346d3..c8234d347fc5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/blk-crypto.h>
 #include <linux/xarray.h>
+#include <linux/kmemleak.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -116,6 +117,11 @@ static inline unsigned int bs_bio_slab_size(struct bio_set *bs)
 	return bs->front_pad + sizeof(struct bio) + bs->back_pad;
 }
 
+static inline void *bio_slab_addr(struct bio *bio)
+{
+	return (void *)bio - bio->bi_pool->front_pad;
+}
+
 static struct kmem_cache *bio_find_or_create_slab(struct bio_set *bs)
 {
 	unsigned int size = bs_bio_slab_size(bs);
@@ -486,6 +492,9 @@ static struct bio *bio_alloc_percpu_cache(struct bio_set *bs)
 	cache->nr--;
 	put_cpu();
 	bio->bi_pool = bs;
+
+	kmemleak_alloc(bio_slab_addr(bio),
+		       kmem_cache_size(bs->bio_slab), 1, GFP_NOIO);
 	return bio;
 }
 
@@ -728,6 +737,9 @@ static int __bio_alloc_cache_prune(struct bio_alloc_cache *cache,
 	while ((bio = cache->free_list) != NULL) {
 		cache->free_list = bio->bi_next;
 		cache->nr--;
+		kmemleak_alloc(bio_slab_addr(bio),
+			       kmem_cache_size(bio->bi_pool->bio_slab),
+			       1, GFP_KERNEL);
 		bio_free(bio);
 		if (++i == nr)
 			break;
@@ -791,6 +803,7 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 		bio->bi_bdev = NULL;
 		cache->free_list = bio;
 		cache->nr++;
+		kmemleak_free(bio_slab_addr(bio));
 	} else if (in_hardirq()) {
 		lockdep_assert_irqs_disabled();
 
@@ -798,6 +811,7 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 		bio->bi_next = cache->free_list_irq;
 		cache->free_list_irq = bio;
 		cache->nr_irq++;
+		kmemleak_free(bio_slab_addr(bio));
 	} else {
 		goto out_free;
 	}
-- 
2.53.0

