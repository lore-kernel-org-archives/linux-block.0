Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEBAC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 03:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiBODdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:33:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBODdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 22:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4A3910D7
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 19:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644895991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6v8AdoPCZAfiRHRZvijqYmWWBwxyvVZcwrHMIpmp84=;
        b=fubS0Kt8uNUet/pcXnpTsCHjx7byl7Lg0HXTfEzuQhV0cqTjO1cHVXpMtBOq3C1CGmY/vY
        SHUY4SjTK3Zp7f0zWHDK+w9CNmlGcOcv4oQsNPO9uLRTUMoGFdry0EF+7vu1yJNbUCOm5Z
        rj9dd8TG23+aNJ9lXczdaFGTzBinfuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-yFEZ0azUPaexRU7EO56O0A-1; Mon, 14 Feb 2022 22:33:06 -0500
X-MC-Unique: yFEZ0azUPaexRU7EO56O0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E31CB801B0C;
        Tue, 15 Feb 2022 03:33:04 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 395FC10595A9;
        Tue, 15 Feb 2022 03:32:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/8] block: don't check bio in blk_throtl_dispatch_work_fn
Date:   Tue, 15 Feb 2022 11:30:46 +0800
Message-Id: <20220215033050.2730533-5-ming.lei@redhat.com>
In-Reply-To: <20220215033050.2730533-1-ming.lei@redhat.com>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio has been checked already before throttling, so no need to check
it again before dispatching it from throttle queue.

Add one local helper of submit_bio_noacct_nocheck() for this purpose.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c     | 35 ++++++++++++++++++++++-------------
 block/blk-throttle.c |  2 +-
 block/blk.h          |  1 +
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5248b94d276b..f97cb8b23610 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -874,20 +874,8 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 	current->bio_list = NULL;
 }
 
-/**
- * submit_bio_noacct - re-submit a bio to the block device layer for I/O
- * @bio:  The bio describing the location in memory and on the device.
- *
- * This is a version of submit_bio() that shall only be used for I/O that is
- * resubmitted to lower level drivers by stacking block drivers.  All file
- * systems and other upper level users of the block layer should use
- * submit_bio() instead.
- */
-void submit_bio_noacct(struct bio *bio)
+static inline void __submit_bio_noacct_nocheck(struct bio *bio)
 {
-	if (unlikely(!submit_bio_checks(bio)))
-		return;
-
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
@@ -901,8 +889,29 @@ void submit_bio_noacct(struct bio *bio)
 	else
 		__submit_bio_noacct(bio);
 }
+
+/**
+ * submit_bio_noacct - re-submit a bio to the block device layer for I/O
+ * @bio:  The bio describing the location in memory and on the device.
+ *
+ * This is a version of submit_bio() that shall only be used for I/O that is
+ * resubmitted to lower level drivers by stacking block drivers.  All file
+ * systems and other upper level users of the block layer should use
+ * submit_bio() instead.
+ */
+void submit_bio_noacct(struct bio *bio)
+{
+	if (unlikely(!submit_bio_checks(bio)))
+		return;
+	__submit_bio_noacct_nocheck(bio);
+}
 EXPORT_SYMBOL(submit_bio_noacct);
 
+void submit_bio_noacct_nocheck(struct bio *bio)
+{
+	__submit_bio_noacct_nocheck(bio);
+}
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 73640d80e99e..8770768f1000 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1218,7 +1218,7 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 	if (!bio_list_empty(&bio_list_on_stack)) {
 		blk_start_plug(&plug);
 		while ((bio = bio_list_pop(&bio_list_on_stack)))
-			submit_bio_noacct(bio);
+			submit_bio_noacct_nocheck(bio);
 		blk_finish_plug(&plug);
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index b2516cb4f98e..ebaa59ca46ca 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -46,6 +46,7 @@ void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
+void submit_bio_noacct_nocheck(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
-- 
2.31.1

