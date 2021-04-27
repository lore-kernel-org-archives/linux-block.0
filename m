Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20701C433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D3861107
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhD0Bri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 21:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234598AbhD0Bri (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 21:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619488015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydqXCEqaHrMULF6OsUXgXGuQ+CnZkFw+IHI1Ce/+yVs=;
        b=YSZUKmdckPbZ+MVieZ8b23o2k2eQ2m+8TIgzbchtpUg1O4q1/Gl94vLLNfcI8RphEI3+ZO
        8yv6oj23qxQ2P36ZWFQYZryCyelpnVQzUSqNNGYXrj+rGT94BWup4xGGY5h6VHs4i7wyke
        q7KLkru9mAuEQ6fTPToHOX6QY+tnv5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-rsqMnCQNOdSr68y2HYNhTA-1; Mon, 26 Apr 2021 21:46:53 -0400
X-MC-Unique: rsqMnCQNOdSr68y2HYNhTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 105DA1083007;
        Tue, 27 Apr 2021 01:46:10 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 111E7100164C;
        Tue, 27 Apr 2021 01:46:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] blk-mq: complete request locally if the completion is from tagset iterator
Date:   Tue, 27 Apr 2021 09:45:39 +0800
Message-Id: <20210427014540.2747282-3-ming.lei@redhat.com>
In-Reply-To: <20210427014540.2747282-1-ming.lei@redhat.com>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rq->ref is not held when running a remote completion, and iteration
over tagset request pool is possible when another remote completion
is pending, so there is potential request UAF if request is completed
remotely from our tagset iterator helper.

Fix it by completing request locally if the completion is from tagset
iterator.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c     | 5 ++++-
 block/blk-mq.c         | 8 ++++++++
 include/linux/blkdev.h | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 100fa44d52a6..773aea4db90c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -284,8 +284,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
 	    !blk_mq_request_started(rq))
 		ret = true;
-	else
+	else {
+		rq->rq_flags |= RQF_ITERATING;
 		ret = iter_data->fn(rq, iter_data->data, reserved);
+		rq->rq_flags &= ~RQF_ITERATING;
+	}
 	if (!iter_static_rqs)
 		blk_mq_put_rq_ref(rq);
 	return ret;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4bd6c11bd8bc..ae06e5b3f215 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -654,6 +654,14 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	if (rq->cmd_flags & REQ_HIPRI)
 		return false;
 
+	/*
+	 * Complete the request locally if it is being completed via tagset
+	 * iterator helper for avoiding UAF because rq->ref isn't held when
+	 * running remote completion via IPI or softirq
+	 */
+	if (rq->rq_flags & RQF_ITERATING)
+		return false;
+
 	if (blk_mq_complete_need_ipi(rq)) {
 		blk_mq_complete_send_ipi(rq);
 		return true;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f2e77ba97550..3b9bc4381dab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -102,6 +102,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
 /* ->timeout has been called, don't expire again */
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
+/* The request is being iterated by blk-mq iterator API */
+#define RQF_ITERATING		((__force req_flags_t)(1 << 22))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.29.2

