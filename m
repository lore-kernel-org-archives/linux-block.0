Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33447C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 11:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiAKL4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:56:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239120AbiAKL4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 06:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641902181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OD/1WSLEb6NUilWAxrxunOrjPI6K/IXqB+pIMe7mo7U=;
        b=exumRdEYHbmOQkHM/nPIojg7Sw04u3WTdX+KfYPi7bLsFtJPqIb60lzNZbe9avGLQhmrf8
        Q/PjIeuxgFjwA4fnLI2I4yJttxFuV9Idl/3WC+yWbd1LTCsdB6Ak3YEL5Y3SPqxdXCvyyF
        Kmyo7RwqtPzn8OPfFlHpYd4oaDCVqVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-sSho-T44OJ6tB3JD-fvJVQ-1; Tue, 11 Jan 2022 06:56:20 -0500
X-MC-Unique: sSho-T44OJ6tB3JD-fvJVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 749F51083F60;
        Tue, 11 Jan 2022 11:56:19 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A02C77D93E;
        Tue, 11 Jan 2022 11:56:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 2/7] block: move blk_crypto_bio_prep() out of blk-mq.c
Date:   Tue, 11 Jan 2022 19:55:27 +0800
Message-Id: <20220111115532.497117-3-ming.lei@redhat.com>
In-Reply-To: <20220111115532.497117-1-ming.lei@redhat.com>
References: <20220111115532.497117-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_crypto_bio_prep() is called for both bio based and blk-mq drivers,
so move it out of blk-mq.c, then we can unify this kind of handling.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 18 ++++++------------
 block/blk-mq.c   |  3 ---
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cca7fbe2a43b..471ffc834e3f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -785,26 +785,20 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	return false;
 }
 
-static void __submit_bio_fops(struct gendisk *disk, struct bio *bio)
+static void __submit_bio(struct bio *bio)
 {
 	if (blk_crypto_bio_prep(&bio)) {
-		if (likely(bio_queue_enter(bio) == 0)) {
+		struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+		if (!disk->fops->submit_bio) {
+			blk_mq_submit_bio(bio);
+		} else if (likely(bio_queue_enter(bio) == 0)) {
 			disk->fops->submit_bio(bio);
 			blk_queue_exit(disk->queue);
 		}
 	}
 }
 
-static void __submit_bio(struct bio *bio)
-{
-	struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-	if (!disk->fops->submit_bio)
-		blk_mq_submit_bio(bio);
-	else
-		__submit_bio_fops(disk, bio);
-}
-
 /*
  * The loop in this function may be a bit non-obvious, and so deserves some
  * explanation:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a6d4780580fc..73c376e27c5a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2786,9 +2786,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
-	if (unlikely(!blk_crypto_bio_prep(&bio)))
-		return;
-
 	blk_queue_bounce(q, &bio);
 	if (blk_may_split(q, bio))
 		__blk_queue_split(q, &bio, &nr_segs);
-- 
2.31.1

