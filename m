Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7A7C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiCBMPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiCBMPU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 07:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 481B83ED00
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 04:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646223276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+c4wIxR54xQ3Ynz5V441Ek1YsLX4su3yjGkQCdZzAI=;
        b=WjNGWogXJLqumb3jQWgoClKrMrWjj515XEnV5c/ITzv1rH5ThM1vRicL9fCh09aAmICkDg
        LQ324/BZplgBhZcS0qZcgx1krzAE6/dxn2jC0dy0cbyEuy9bS2N3n7JgJSEougTlqUp3G8
        adgJ+jy+U00d3KsV58iMgPgcVoL1KUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-v8UlZTMQP3etY-1tpwWeBw-1; Wed, 02 Mar 2022 07:14:33 -0500
X-MC-Unique: v8UlZTMQP3etY-1tpwWeBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D551006AA5;
        Wed,  2 Mar 2022 12:14:32 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D1E7104B4C6;
        Wed,  2 Mar 2022 12:14:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/6] blk-mq: reconfigure poll after queue map is changed
Date:   Wed,  2 Mar 2022 20:14:04 +0800
Message-Id: <20220302121407.1361401-4-ming.lei@redhat.com>
In-Reply-To: <20220302121407.1361401-1-ming.lei@redhat.com>
References: <20220302121407.1361401-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

queue map can be changed when updating nr_hw_queues, so we need to
reconfigure queue's poll capability. Add one helper for doing this job.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 64fddb36c93c..57ae9df0f4dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4010,6 +4010,17 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	mutex_unlock(&q->sysfs_lock);
 }
 
+static void blk_mq_update_poll_flag(struct request_queue *q)
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
+	blk_mq_update_poll_flag(q);
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
 	INIT_LIST_HEAD(&q->requeue_list);
@@ -4512,6 +4521,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
+		blk_mq_update_poll_flag(q);
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
 
-- 
2.31.1

