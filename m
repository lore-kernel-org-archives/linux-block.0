Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF09DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 11:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiAKL42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239324AbiAKL41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 06:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641902186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TouzFxCFH3VEOfWFXqt2XjHXvnvE0xfeuRgFSMyE9fM=;
        b=QUgCFWYOsmhLlJu5Yq4qe0UEqeHOh0swQn5rWMva6HnbXdBMpCTEbWUyd9O4Ww7eaFT0Ou
        TVuhpH7tSZoaVqGk4QwgySXTdB7fg8+nOOQWORB0tjzK63QC1WUsVXidSD+tNEW+pvjRGM
        k/giCxqhPtJXXcjIEQiylca1U66vOuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-wA--YSipOw2UJrqcDlgJOw-1; Tue, 11 Jan 2022 06:56:23 -0500
X-MC-Unique: wA--YSipOw2UJrqcDlgJOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9412B1006AA6;
        Tue, 11 Jan 2022 11:56:22 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D27FE84630;
        Tue, 11 Jan 2022 11:56:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 3/7] block: allow to bypass bio check before submitting bio
Date:   Tue, 11 Jan 2022 19:55:28 +0800
Message-Id: <20220111115532.497117-4-ming.lei@redhat.com>
In-Reply-To: <20220111115532.497117-1-ming.lei@redhat.com>
References: <20220111115532.497117-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have several cases in which bio is re-submitted to same queue, so
checking bio isn't needed, so add helper for such propose.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 10 +++++-----
 include/linux/blkdev.h |  7 ++++++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 471ffc834e3f..1e6ebc16b889 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -818,7 +818,7 @@ static void __submit_bio(struct bio *bio)
  * bio_list_on_stack[1] contains bios that were submitted before the current
  *	->submit_bio_bio, but that haven't been processed yet.
  */
-static void __submit_bio_noacct(struct bio *bio)
+static void __submit_bio_noacct_generic(struct bio *bio)
 {
 	struct bio_list bio_list_on_stack[2];
 
@@ -884,9 +884,9 @@ static void __submit_bio_noacct_mq(struct bio *bio)
  * systems and other upper level users of the block layer should use
  * submit_bio() instead.
  */
-void submit_bio_noacct(struct bio *bio)
+void __submit_bio_noacct(struct bio *bio, bool check)
 {
-	if (unlikely(!submit_bio_checks(bio)))
+	if (unlikely(check && !submit_bio_checks(bio)))
 		return;
 
 	/*
@@ -900,9 +900,9 @@ void submit_bio_noacct(struct bio *bio)
 	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
 		__submit_bio_noacct_mq(bio);
 	else
-		__submit_bio_noacct(bio);
+		__submit_bio_noacct_generic(bio);
 }
-EXPORT_SYMBOL(submit_bio_noacct);
+EXPORT_SYMBOL(__submit_bio_noacct);
 
 /**
  * submit_bio - submit a bio to the block device layer for I/O
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22746b2d6825..e02a73d7c277 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -599,7 +599,12 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
-void submit_bio_noacct(struct bio *bio);
+void __submit_bio_noacct(struct bio *bio, bool check);
+
+static inline void submit_bio_noacct(struct bio *bio)
+{
+	__submit_bio_noacct(bio, true);
+}
 
 extern int blk_lld_busy(struct request_queue *q);
 extern void blk_queue_split(struct bio **);
-- 
2.31.1

