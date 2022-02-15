Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F7FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 03:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiBODcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:32:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBODcv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 22:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9247AE95
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 19:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644895961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdjaUeeq1rkB92noBld5/AtSdEaxWWPpZYlpU/sLJKY=;
        b=gL8JBE3a9Ge5iCwiJ+9NFgM/I3s8BFNW7zUnJlbswGp+fgaPm2gcAq3KKYftmQ+E5jUgVs
        fMin0xyeimMHyYA1Kmg0ZcgydalxRhaa5M/29anInVf+oJsfOiaq1z+KSE5Gs+TXQ/RuDt
        8yS0+4f+3p5F0Ql9wZS2+fQOHnCb7/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-k5ThXAUwM6uNHIOxXXzXPw-1; Mon, 14 Feb 2022 22:32:38 -0500
X-MC-Unique: k5ThXAUwM6uNHIOxXXzXPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 233D1801B26;
        Tue, 15 Feb 2022 03:32:37 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 864715E272;
        Tue, 15 Feb 2022 03:32:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 2/8] block: move blk_crypto_bio_prep() out of blk-mq.c
Date:   Tue, 15 Feb 2022 11:30:44 +0800
Message-Id: <20220215033050.2730533-3-ming.lei@redhat.com>
In-Reply-To: <20220215033050.2730533-1-ming.lei@redhat.com>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

