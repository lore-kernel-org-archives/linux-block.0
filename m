Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F23C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 11:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E183160E90
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 11:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbhIXLIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245163AbhIXLIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 07:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632481617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ORH9k57fY6j/849+t3lI2vFIklyw427diE3I4wD3Ay4=;
        b=C0ngxqNMoI/nKr8OJRBKXvZpwUWcHxY76aA87EgaHOCMAb0ChgqXlSGP7Yxp9MxT2bn9wq
        +qasKbqSSQUr2xxL3j8Ybw0jT5eohJCrINx5/XvDvjPvAliErcu5Ib7ujmeVH0aitfZHjF
        vfEn95yRs6Y4hOQqeW2ShJcSTHVGm4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-5ch72hx5NimO0cxGHW-S8A-1; Fri, 24 Sep 2021 07:06:55 -0400
X-MC-Unique: 5ch72hx5NimO0cxGHW-S8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD151922035;
        Fri, 24 Sep 2021 11:06:54 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0220560936;
        Fri, 24 Sep 2021 11:06:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yu Kuai <yukuai3@huawei.com>, tj@kernel.org
Subject: [PATCH] block: don't call rq_qos_ops->done_bio if the bio isn't tracked
Date:   Fri, 24 Sep 2021 19:07:04 +0800
Message-Id: <20210924110704.1541818-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rq_qos framework is only applied on request based driver, so:

1) rq_qos_done_bio() needn't to be called for bio based driver

2) rq_qos_done_bio() needn't to be called for bio which isn't tracked,
such as bios ended from error handling code.

Especially in bio_endio():

1) request queue is referred via bio->bi_bdev->bd_disk->queue, which
may be gone since request queue refcount may not be held in above two
cases

2) q->rq_qos may be freed in blk_cleanup_queue() when calling into
__rq_qos_done_bio()

Fix the potential kernel panic by not calling rq_qos_ops->done_bio if
the bio isn't tracked. This way is safe because both ioc_rqos_done_bio()
and blkcg_iolatency_done_bio() are nop if the bio isn't tracked.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Cc: tj@kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 5df3dd282e40..a6fb6a0b4295 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1466,7 +1466,7 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
-	if (bio->bi_bdev)
+	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACKED))
 		rq_qos_done_bio(bio->bi_bdev->bd_disk->queue, bio);
 
 	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-- 
2.31.1

