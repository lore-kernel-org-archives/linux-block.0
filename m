Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683E1C48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A9B61359
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhFPNJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233218AbhFPNJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623848824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIkgsb2GruWXtknprN6c4/O3dDtMstZMPs68M+U4+/o=;
        b=MsKD02dZSVfy2HaxY74qQSm7DYE2njyQKnzJ0gZ97Dfkye5XfTufBWaWBvn9ZQjzbB7bGF
        sCmfWQYIJ71nBFdeOfSDrOpbwB4yObPjHADHooiccmv7dKovAy14ggyhO8hC61QSvy5hQR
        2WhyMOl0SHYUmond0mtqdCSst9sYivE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-SslDtkamOtGAtFJjL0R2lw-1; Wed, 16 Jun 2021 09:07:02 -0400
X-MC-Unique: SslDtkamOtGAtFJjL0R2lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1EDCA40DB;
        Wed, 16 Jun 2021 13:07:00 +0000 (UTC)
Received: from localhost (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4723860C13;
        Wed, 16 Jun 2021 13:06:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 3/4] block: add ->poll_bio to block_device_operations
Date:   Wed, 16 Jun 2021 21:05:32 +0800
Message-Id: <20210616130533.754248-4-ming.lei@redhat.com>
In-Reply-To: <20210616130533.754248-1-ming.lei@redhat.com>
References: <20210616130533.754248-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for supporting IO polling for bio based driver.

Add ->poll_bio callback so that bio driver can provide their own logic
for polling bio.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 18 +++++++++++++-----
 block/genhd.c          |  3 +++
 include/linux/blkdev.h |  2 ++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1e24c71c6738..a1552ec8d608 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1113,11 +1113,13 @@ EXPORT_SYMBOL(submit_bio);
  */
 int bio_poll(struct bio *bio, unsigned int flags)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct request_queue *q = disk->queue;
 	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
 	int ret;
 
-	if (cookie == BLK_QC_T_NONE || !blk_queue_poll(q))
+	if ((queue_is_mq(q) && cookie == BLK_QC_T_NONE) ||
+			!blk_queue_poll(q))
 		return 0;
 
 	if (current->plug)
@@ -1125,10 +1127,16 @@ int bio_poll(struct bio *bio, unsigned int flags)
 
 	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
 		return 0;
-	if (WARN_ON_ONCE(!queue_is_mq(q)))
-		ret = 0;	/* not yet implemented, should not happen */
-	else
+	if (!queue_is_mq(q)) {
+		if (disk->fops->poll_bio) {
+			ret = disk->fops->poll_bio(bio, flags);
+		} else {
+			WARN_ON_ONCE(1);
+			ret = 0;
+		}
+	} else {
 		ret = blk_mq_poll(q, cookie, flags);
+	}
 	blk_queue_exit(q);
 	return ret;
 }
diff --git a/block/genhd.c b/block/genhd.c
index 5f5628216295..042dfa5b3f79 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -471,6 +471,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 {
 	int ret;
 
+	/* ->poll_bio is only for bio based driver */
+	WARN_ON_ONCE(queue_is_mq(disk->queue) && disk->fops->poll_bio);
+
 	/*
 	 * The disk queue should now be all set with enough information about
 	 * the device for the elevator code to pick an adequate default
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fc0ba0b80776..6da6fb120148 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1858,6 +1858,8 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 struct block_device_operations {
 	void (*submit_bio)(struct bio *bio);
+	/* ->poll_bio is for bio driver only */
+	int (*poll_bio)(struct bio *bio, unsigned int flags);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
-- 
2.31.1

