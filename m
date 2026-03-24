Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179831DC985
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342864; cv=none; b=R+QFOTC7eQDv5lh9F6z8d7i7vObO714YB5MHakRrpC3P6wgGzpbPGDuuP6TYH6p3Ii2Q0AZk2L0LSds3OK2uOW5HU12Rqz6eJxQ6RtknS+23W9gWD9Mf4HJAPV8XB3XfhagWK7xHqFtZqO5AjcvYX6j2yTo7gW0cWUn5bxQilHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342864; c=relaxed/simple;
	bh=NUCt9499jjNNkuEEykHY4WzmSJ+p9GFYgLXZ1YnXaWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQd9wkcgCPGDIdN3qw0nMi1+UhsQE/KIRVyobdhw2T9W8udOJdeat3siNkjO6IhlYmDFPPHUbEEKxruhVMPvXiwpgLm+QMjx6JZywcCOwVxLgiIZ+uLhK0ysAjzJRBNhul5QO55Tglf27TRm2pvx/LllJSrIyBjStu7aKLzo0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J083fDTN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J083fDTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774342861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GAFdc90vtERiRN159wE1VgpqPHexiDdaSJGXbwhit1k=;
	b=J083fDTNNC9LxmjWwo5lySawsKA0/IDf4XQ2WMhrwH2wTO0eArOXQ7xmlC+c9jUhfIiC1m
	AJwB/nCrkGF4uzTGmiWnaj+LZzq/UB7Ic4TESH3IbFqiAfOhLRZ7r9tkI27BVPbH7tPe0S
	1hfxKmPewvYnv7x9sAS2WNWFBedp0GM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-RxjzfJo3NYqPteGTj33nqQ-1; Tue,
 24 Mar 2026 05:00:59 -0400
X-MC-Unique: RxjzfJo3NYqPteGTj33nqQ-1
X-Mimecast-MFC-AGG-ID: RxjzfJo3NYqPteGTj33nqQ_1774342858
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6917A18002DC;
	Tue, 24 Mar 2026 09:00:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.133])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38A18180035F;
	Tue, 24 Mar 2026 09:00:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] bio: fix kmemleak false positives from percpu bio alloc cache
Date: Tue, 24 Mar 2026 17:00:52 +0800
Message-ID: <20260324090052.1782766-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Cc: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index d80d5d26804e..093006e5aba0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/blk-crypto.h>
 #include <linux/xarray.h>
+#include <linux/kmemleak.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -504,6 +505,9 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
 	cache->nr--;
 	put_cpu();
 
+	kmemleak_alloc((void *)bio - bs->front_pad,
+		       kmem_cache_size(bs->bio_slab), 1, gfp);
+
 	if (nr_vecs)
 		bio_init_inline(bio, bdev, nr_vecs, opf);
 	else
@@ -765,6 +769,9 @@ static int __bio_alloc_cache_prune(struct bio_alloc_cache *cache,
 	while ((bio = cache->free_list) != NULL) {
 		cache->free_list = bio->bi_next;
 		cache->nr--;
+		kmemleak_alloc((void *)bio - bio->bi_pool->front_pad,
+			       kmem_cache_size(bio->bi_pool->bio_slab),
+			       1, GFP_KERNEL);
 		bio_free(bio);
 		if (++i == nr)
 			break;
@@ -828,6 +835,7 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 		bio->bi_bdev = NULL;
 		cache->free_list = bio;
 		cache->nr++;
+		kmemleak_free((void *)bio - bio->bi_pool->front_pad);
 	} else if (in_hardirq()) {
 		lockdep_assert_irqs_disabled();
 
@@ -835,6 +843,7 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 		bio->bi_next = cache->free_list_irq;
 		cache->free_list_irq = bio;
 		cache->nr_irq++;
+		kmemleak_free((void *)bio - bio->bi_pool->front_pad);
 	} else {
 		goto out_free;
 	}
-- 
2.53.0

