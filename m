Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D10EC43219
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiKBPUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKBPTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:19:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B121809
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:19:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so25064251wrh.1
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONzzojRePq37xqITluKuxgMnGfoyFw7UZB2xd8qRqeg=;
        b=nJOC2eRTqccm5tiEXuF3S74F0fXQIJkraiPb/7wmM3t/+1LVP3RUviGFsLCq020dc5
         Y6RS0TZSUDQ2S2mZFKIMuoNsI+otylZqpddVi9EBlm/gS5N1uqn9v4tgExycziBZei1F
         mC/Osn/firG2s6Sc5sb954PcQDcrDFcbA+EL2ybt5AMF+BiQmypmG/ALn2Jk5BIMp8/H
         QZb/aFYFolQ3KGaPzc9S1t4kafWti5s4xDXy7MKGo+jXv4EQGe9642k4O/tT9XPMYHb/
         qSMqpyhhdVxPdeDmyE1LIu5J57pzrBFUNAGfJCBY1gP1R/GsstcNWtQUENw1VIK5llJo
         Pf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONzzojRePq37xqITluKuxgMnGfoyFw7UZB2xd8qRqeg=;
        b=5nxHft9QU6seWYcV924cgSleAuSU2YkAd6+DVP/HU7IWxFH86wvnyUyXMZQkhEnxFY
         w5Wi4FkpWK0vXJMQxiEVoECD5vIltrPgAmNEyNr5fpHMLYa0Gf9Yy1n5GMDsAKzhfdfg
         UMqZdbAvDg7BXYq2aQ/H/Nhb8xShK7iy81nsLQirS2qynxITUDAGVE9H09Ar6kVfibNj
         RXjKII7KVD3zTHZKoWLm5rM7ucu6MirqJ+XNI6bHWx3fk+7jR0bZ19yHxC6JdBsSc/OX
         Jy7FCHyPCXAsFMm9EW377brT9FK+I/Q2j1F0W+EsIglriRrqyvKfL2hcEqCwlIaiBAvO
         /QWA==
X-Gm-Message-State: ACrzQf0Rj3Su8xtRjxL3lWOld2PdIX41mBWRIAIzF1QIxLAgh7AHDI0T
        IRWl/z7tBg46nHJ1WS1jiuw=
X-Google-Smtp-Source: AMsMyM4Ts6+x9ECdoG/fZRQDkLVO5/sgP9xDj5EHV/t80y3TgI+WHEQUHfwgLk4Jt2HpOVs4h1xGIQ==
X-Received: by 2002:a5d:6dcd:0:b0:235:f087:fec2 with SMTP id d13-20020a5d6dcd000000b00235f087fec2mr14938340wrz.444.1667402378925;
        Wed, 02 Nov 2022 08:19:38 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.186.241])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0022e66749437sm13043232wrq.93.2022.11.02.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:19:38 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next v4 3/6] bio: split pcpu cache part of bio_put into a helper
Date:   Wed,  2 Nov 2022 15:18:21 +0000
Message-Id: <e97ab2026a89098ee1bfdd09bcb9451fced95f87.1667384020.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1667384020.git.asml.silence@gmail.com>
References: <cover.1667384020.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Extract a helper out of bio_put for recycling into percpu caches.
It's a preparation patch without functional changes.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8afc3e78beff..f99d27566839 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -727,6 +727,28 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
 	bs->cache = NULL;
 }
 
+static inline void bio_put_percpu_cache(struct bio *bio)
+{
+	struct bio_alloc_cache *cache;
+
+	cache = per_cpu_ptr(bio->bi_pool->cache, get_cpu());
+	bio_uninit(bio);
+
+	if ((bio->bi_opf & REQ_POLLED) && !WARN_ON_ONCE(in_interrupt())) {
+		bio->bi_next = cache->free_list;
+		cache->free_list = bio;
+		cache->nr++;
+	} else {
+		put_cpu();
+		bio_free(bio);
+		return;
+	}
+
+	if (cache->nr > ALLOC_CACHE_MAX + ALLOC_CACHE_SLACK)
+		bio_alloc_cache_prune(cache, ALLOC_CACHE_SLACK);
+	put_cpu();
+}
+
 /**
  * bio_put - release a reference to a bio
  * @bio:   bio to release reference to
@@ -742,20 +764,10 @@ void bio_put(struct bio *bio)
 		if (!atomic_dec_and_test(&bio->__bi_cnt))
 			return;
 	}
-
-	if ((bio->bi_opf & REQ_ALLOC_CACHE) && !WARN_ON_ONCE(in_interrupt())) {
-		struct bio_alloc_cache *cache;
-
-		bio_uninit(bio);
-		cache = per_cpu_ptr(bio->bi_pool->cache, get_cpu());
-		bio->bi_next = cache->free_list;
-		cache->free_list = bio;
-		if (++cache->nr > ALLOC_CACHE_MAX + ALLOC_CACHE_SLACK)
-			bio_alloc_cache_prune(cache, ALLOC_CACHE_SLACK);
-		put_cpu();
-	} else {
+	if (bio->bi_opf & REQ_ALLOC_CACHE)
+		bio_put_percpu_cache(bio);
+	else
 		bio_free(bio);
-	}
 }
 EXPORT_SYMBOL(bio_put);
 
-- 
2.38.0

