Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D329CC43217
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKBPUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKBPTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:19:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22618E35
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:19:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g12so25026363wrs.10
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sXPnj4a9cJY4OJxSEMI079XGw7qQy2cvmQCwAb8viI=;
        b=Q85W0CcBLrlcP50D+nHEUMuY4/X0PGYXoPtGUBzWXWl/ArV0P4d9fxndcAy8EconoO
         +PLrdKPACnQPrD113Nng4gwsbFEoiVuy09J8rCB/zAXtHycRMd/AZtSk+l74omaOSADB
         JR/AKnlRJhRtCjKMHkOcxc6A+8qGNpZaWxQMYPJCeXEJaIfjz6wz0kxs/54CPKrapqOq
         Dtnz+yugsZcS9eamk+lvvW/jBfEk8G1LgpTuhWU5KlB2ngxtGXKtRghbKLd49aw7UOrb
         zHAUQbDekfoOl7aIk3tuxSjv3I8Eh0r/bsZ7tvAHV7EojlXPC4BJ1XcrC+CQBX108Gey
         136w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sXPnj4a9cJY4OJxSEMI079XGw7qQy2cvmQCwAb8viI=;
        b=z0VR+V4dOWGDSQvLINTy4HwyZ9KVhcZkPad3dq7VZtOMOmTg2kA9Nk+Nb+JwHJzJj8
         VNP8TETDxHs3sPYoayrdbOU6V/Gim5t/eIbEf0/+c41ki7ftZYaHpnOgUhBZhcIRJNLI
         QYrYITf9zbb1+LUUOucl6UM9nZPJVgKzCyn9JgE1Z+nwescUy0YvQZtfH03Nq6B2KzXb
         /T+42kd19T/5g1IdeAsgBUUnlWhpo7pUskqaXxG0wpW9OP8HV45gP2YHLATQKW9e+MiU
         CIPdUYqFUfnJqgYDGnfzWiwFHHMjLM13GjiRq2rLl59iaE7GEjUY898+wnHdOnYjiz3f
         t4Nw==
X-Gm-Message-State: ACrzQf0amcJAIMx9x0T4NRWyCjnLQ/356saEdj0nB+Z2sHbGxPBbBXZP
        XCRF97sgBjABmqYp3WJuWqM=
X-Google-Smtp-Source: AMsMyM6C44jUz8zG1iiIyL2p37iZd32LcQL2/FL8pkNEucxJG0+tJfRUia8SDZlRIhp6AJfgSn0saw==
X-Received: by 2002:a5d:47c7:0:b0:236:64a4:6d5a with SMTP id o7-20020a5d47c7000000b0023664a46d5amr15328841wrc.666.1667402380281;
        Wed, 02 Nov 2022 08:19:40 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.186.241])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0022e66749437sm13043232wrq.93.2022.11.02.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:19:39 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next v4 4/6] bio: add pcpu caching for non-polling bio_put
Date:   Wed,  2 Nov 2022 15:18:22 +0000
Message-Id: <c2306de96b900ab9264f4428ec37768ddcf0da36.1667384020.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1667384020.git.asml.silence@gmail.com>
References: <cover.1667384020.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch extends REQ_ALLOC_CACHE to IRQ completions, whenever
currently it's only limited to iopoll. Instead of guarding the list with
irq toggling on alloc, which is expensive, it keeps an additional
irq-safe list from which bios are spliced in batches to ammortise
overhead. On the put side it toggles irqs, but in many cases they're
already disabled and so cheap.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 70 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f99d27566839..d989e45583ac 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -25,9 +25,15 @@
 #include "blk-rq-qos.h"
 #include "blk-cgroup.h"
 
+#define ALLOC_CACHE_THRESHOLD	16
+#define ALLOC_CACHE_SLACK	64
+#define ALLOC_CACHE_MAX		512
+
 struct bio_alloc_cache {
 	struct bio		*free_list;
+	struct bio		*free_list_irq;
 	unsigned int		nr;
+	unsigned int		nr_irq;
 };
 
 static struct biovec_slab {
@@ -408,6 +414,22 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
 	queue_work(bs->rescue_workqueue, &bs->rescue_work);
 }
 
+static void bio_alloc_irq_cache_splice(struct bio_alloc_cache *cache)
+{
+	unsigned long flags;
+
+	/* cache->free_list must be empty */
+	if (WARN_ON_ONCE(cache->free_list))
+		return;
+
+	local_irq_save(flags);
+	cache->free_list = cache->free_list_irq;
+	cache->free_list_irq = NULL;
+	cache->nr += cache->nr_irq;
+	cache->nr_irq = 0;
+	local_irq_restore(flags);
+}
+
 static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
 		unsigned short nr_vecs, blk_opf_t opf, gfp_t gfp,
 		struct bio_set *bs)
@@ -417,8 +439,12 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
 
 	cache = per_cpu_ptr(bs->cache, get_cpu());
 	if (!cache->free_list) {
-		put_cpu();
-		return NULL;
+		if (READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD)
+			bio_alloc_irq_cache_splice(cache);
+		if (!cache->free_list) {
+			put_cpu();
+			return NULL;
+		}
 	}
 	bio = cache->free_list;
 	cache->free_list = bio->bi_next;
@@ -462,9 +488,6 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
  * submit_bio_noacct() should be avoided - instead, use bio_set's front_pad
  * for per bio allocations.
  *
- * If REQ_ALLOC_CACHE is set, the final put of the bio MUST be done from process
- * context, not hard/soft IRQ.
- *
  * Returns: Pointer to new bio on success, NULL on failure.
  */
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
@@ -678,11 +701,8 @@ void guard_bio_eod(struct bio *bio)
 	bio_truncate(bio, maxsector << 9);
 }
 
-#define ALLOC_CACHE_MAX		512
-#define ALLOC_CACHE_SLACK	 64
-
-static void bio_alloc_cache_prune(struct bio_alloc_cache *cache,
-				  unsigned int nr)
+static int __bio_alloc_cache_prune(struct bio_alloc_cache *cache,
+				   unsigned int nr)
 {
 	unsigned int i = 0;
 	struct bio *bio;
@@ -694,6 +714,17 @@ static void bio_alloc_cache_prune(struct bio_alloc_cache *cache,
 		if (++i == nr)
 			break;
 	}
+	return i;
+}
+
+static void bio_alloc_cache_prune(struct bio_alloc_cache *cache,
+				  unsigned int nr)
+{
+	nr -= __bio_alloc_cache_prune(cache, nr);
+	if (!READ_ONCE(cache->free_list)) {
+		bio_alloc_irq_cache_splice(cache);
+		__bio_alloc_cache_prune(cache, nr);
+	}
 }
 
 static int bio_cpu_dead(unsigned int cpu, struct hlist_node *node)
@@ -732,6 +763,12 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 	struct bio_alloc_cache *cache;
 
 	cache = per_cpu_ptr(bio->bi_pool->cache, get_cpu());
+	if (READ_ONCE(cache->nr_irq) + cache->nr > ALLOC_CACHE_MAX) {
+		put_cpu();
+		bio_free(bio);
+		return;
+	}
+
 	bio_uninit(bio);
 
 	if ((bio->bi_opf & REQ_POLLED) && !WARN_ON_ONCE(in_interrupt())) {
@@ -739,13 +776,14 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 		cache->free_list = bio;
 		cache->nr++;
 	} else {
-		put_cpu();
-		bio_free(bio);
-		return;
-	}
+		unsigned long flags;
 
-	if (cache->nr > ALLOC_CACHE_MAX + ALLOC_CACHE_SLACK)
-		bio_alloc_cache_prune(cache, ALLOC_CACHE_SLACK);
+		local_irq_save(flags);
+		bio->bi_next = cache->free_list_irq;
+		cache->free_list_irq = bio;
+		cache->nr_irq++;
+		local_irq_restore(flags);
+	}
 	put_cpu();
 }
 
-- 
2.38.0

