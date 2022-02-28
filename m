Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiB1JGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiB1JGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 04:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D65DA3BFA0
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646039146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVtPW13fRoRQ5xy/yV5gPhJfiV3P89r+fg+RfUUTEJQ=;
        b=GvdXm8ma8pK71UqVcJx2YZQUag8f+1mUMiS3Z6NI3KZ3LeJGXd00hAInkMlGa+yntX/o/r
        XvxglzSp60fhdBPPBr813irWtIV2V02CWYGOa1H6pQcdK/OLpwNwH8CqMvVVbHWR+dAksX
        jYVMbDJqFn394OZYS1goOwWfPB6gwe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-ZWxcNAV4OYWrdTJkJsCmpA-1; Mon, 28 Feb 2022 04:05:41 -0500
X-MC-Unique: ZWxcNAV4OYWrdTJkJsCmpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E33721854E21;
        Mon, 28 Feb 2022 09:05:40 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB4D67AB68;
        Mon, 28 Feb 2022 09:05:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/6] blk-mq: re-config poll after queue map is changed
Date:   Mon, 28 Feb 2022 17:04:27 +0800
Message-Id: <20220228090430.1064267-4-ming.lei@redhat.com>
In-Reply-To: <20220228090430.1064267-1-ming.lei@redhat.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

queue map can be changed when updating nr_hw_queues, so we need to
re-config queue's poll capability. Add one helper for doing this job.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 361903f07c84..5ce6a8289cff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4010,6 +4010,17 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	mutex_unlock(&q->sysfs_lock);
 }
 
+static void blk_mq_config_poll(struct request_queue *q)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	if (set->nr_maps > HCTX_TYPE_POLL &&
+	    set->map[HCTX_TYPE_POLL].nr_queues)
+		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
+}
+
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q)
 {
@@ -4044,9 +4055,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
-	if (set->nr_maps > HCTX_TYPE_POLL &&
-	    set->map[HCTX_TYPE_POLL].nr_queues)
-		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+	blk_mq_config_poll(q);
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
 	INIT_LIST_HEAD(&q->requeue_list);
@@ -4512,6 +4521,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
+		blk_mq_config_poll(q);
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
 
-- 
2.31.1

