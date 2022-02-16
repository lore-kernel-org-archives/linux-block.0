Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EF2C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 04:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiBPEqX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:46:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbiBPEqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 23:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABBE8F4639
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 20:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644986770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdjaUeeq1rkB92noBld5/AtSdEaxWWPpZYlpU/sLJKY=;
        b=BZHG8bZGDqs2mPp88MjYso4xIUJPylATRCMtgC0vXKMgOKoTiZB4999BCpw0Xav6UGfbA9
        OI0m7XW5Q8h3KJX/Rdw2+NT/XKvjsCjoeING1Ph6+fN8kReafhy5xh6HsVq6u3WmftZb/p
        l+/60xan/DSjoL4DIG5LnXfzn3o+T3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-C1Fn2uX_NBqwouQ1i2woOA-1; Tue, 15 Feb 2022 23:46:05 -0500
X-MC-Unique: C1Fn2uX_NBqwouQ1i2woOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAEDA2F46;
        Wed, 16 Feb 2022 04:46:03 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0C7A5DB94;
        Wed, 16 Feb 2022 04:45:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 2/8] block: move blk_crypto_bio_prep() out of blk-mq.c
Date:   Wed, 16 Feb 2022 12:45:08 +0800
Message-Id: <20220216044514.2903784-3-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-1-ming.lei@redhat.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_crypto_bio_prep() is called for both bio based and blk-mq drivers,
so move it out of blk-mq.c, then we can unify this kind of handling.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 21 ++++++++-------------
 block/blk-mq.c   |  3 ---
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d4a023667ac1..f03fff1fa391 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -783,24 +783,19 @@ noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	return false;
 }
 
-static void __submit_bio_fops(struct gendisk *disk, struct bio *bio)
-{
-	if (blk_crypto_bio_prep(&bio)) {
-		if (likely(bio_queue_enter(bio) == 0)) {
-			disk->fops->submit_bio(bio);
-			blk_queue_exit(disk->queue);
-		}
-	}
-}
-
 static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	if (!disk->fops->submit_bio)
+	if (unlikely(!blk_crypto_bio_prep(&bio)))
+		return;
+
+	if (!disk->fops->submit_bio) {
 		blk_mq_submit_bio(bio);
-	else
-		__submit_bio_fops(disk, bio);
+	} else if (likely(bio_queue_enter(bio) == 0)) {
+		disk->fops->submit_bio(bio);
+		blk_queue_exit(disk->queue);
+	}
 }
 
 /*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6c59ffe765fd..dc62a47ceb26 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2788,9 +2788,6 @@ void blk_mq_submit_bio(struct bio *bio)
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

