Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6484C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 07:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiAJHzx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 02:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241250AbiAJHwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 02:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641801151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6sF2DpwLz6hAxaWKNWPZM+HKrL3v6YqPW+yDRTPSPo=;
        b=Wytw9LAHOdyL5dSr8WlSQ3sPNp9WH+FFL5MgR3nRcvrtfd13zFZ8eUfgO7ZmnUnSjev/WT
        GaEPkCldHNTJ2hxAVx6VcEPCnyr1cLdoifp6BOCAMYnvp6fELg6mM45lfudwWCKfp+1hHT
        WA1TmMkuoZCI+wLQ8wxesXP5XYeVSgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-EUVq5ttKMCa4TFl8tr8e2g-1; Mon, 10 Jan 2022 02:52:27 -0500
X-MC-Unique: EUVq5ttKMCa4TFl8tr8e2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A150618397A7;
        Mon, 10 Jan 2022 07:52:26 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CADAB5ED4F;
        Mon, 10 Jan 2022 07:52:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>, lining <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Subject: [PATCH 1/2] block: add resubmit_bio_noacct()
Date:   Mon, 10 Jan 2022 15:51:40 +0800
Message-Id: <20220110075141.389532-2-ming.lei@redhat.com>
In-Reply-To: <20220110075141.389532-1-ming.lei@redhat.com>
References: <20220110075141.389532-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add block layer API of resubmit_bio_noacct() for handling blk-throttle
iops limit correctly. Typical use case is that bio split, and it isn't
good to export blk_throtl_charge_bio_split() for drivers, so add new API
for serving such purpose.

Cc: lining <lining2020x@163.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chunguang Xu <brookxu@tencent.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 12 ++++++++++++
 block/blk-merge.c      |  4 +---
 include/linux/blkdev.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fd029c86d6ac..733fec7dc5d6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -910,6 +910,18 @@ void submit_bio_noacct(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
+/*
+ * Usually for submitting one bio which has been checked by
+ * submit_bio_checks already. The typical use case is for handling
+ * blk-throttle iops limit correctly.
+ */
+void resubmit_bio_noacct(struct bio *bio)
+{
+	submit_bio_noacct(bio);
+	blk_throtl_charge_bio_split(bio);
+}
+EXPORT_SYMBOL(resubmit_bio_noacct);
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4de34a332c9f..acc786d872e6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -366,10 +366,8 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 
 		bio_chain(split, *bio);
 		trace_block_split(split, (*bio)->bi_iter.bi_sector);
-		submit_bio_noacct(*bio);
+		resubmit_bio_noacct(*bio);
 		*bio = split;
-
-		blk_throtl_charge_bio_split(*bio);
 	}
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22746b2d6825..cce2db9fae1f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -600,6 +600,7 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 void submit_bio_noacct(struct bio *bio);
+void resubmit_bio_noacct(struct bio *bio);
 
 extern int blk_lld_busy(struct request_queue *q);
 extern void blk_queue_split(struct bio **);
-- 
2.31.1

