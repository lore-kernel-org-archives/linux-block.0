Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F61EE4993
	for <linux-block@archiver.kernel.org>; Wed, 23 Aug 2023 15:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHWPT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjHWPT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2023 11:19:27 -0400
Received: from out-18.mta0.migadu.com (out-18.mta0.migadu.com [IPv6:2001:41d0:1004:224b::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BBE71
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 08:18:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692803914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqZNkS+a81hc+iMtsAHXvpxvEGTl1qxgb5RoMRXMYL4=;
        b=PzJYIuzFjqEmAVZDNBUmkYNUZdjAVz8QuaNz/S7YNBkU9R/hTDyxWsDpaarInCui3QpDDE
        4gqtczDckM8NMz+w1UTw87claYfVpkJilFLJGLTi0fRT0qEqafshefl6lYw0jMGYu9O3Dy
        U9lk0D38y4CdVDcbV+XBpCaoDseI/Ok=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v3 1/6] blk-mq-tag: support queue filter in bt_tags_iter()
Date:   Wed, 23 Aug 2023 23:17:58 +0800
Message-ID: <20230823151803.926382-2-chengming.zhou@linux.dev>
In-Reply-To: <20230823151803.926382-1-chengming.zhou@linux.dev>
References: <20230823151803.926382-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The only user of bt_for_each() is blk_mq_queue_tag_busy_iter(), which
need to filter queue when iterate the tags. In preparation of removing
bt_for_each(), support queue filter in bt_tags_iter().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..3cf3cf72cd54 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -329,6 +329,7 @@ struct bt_tags_iter_data {
 	busy_tag_iter_fn *fn;
 	void *data;
 	unsigned int flags;
+	struct request_queue *q;
 };
 
 #define BT_TAG_ITER_RESERVED		(1 << 0)
@@ -357,9 +358,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (!rq)
 		return true;
 
+	if (iter_data->q && iter_data->q != rq->q)
+		goto out;
+
 	if (!(iter_data->flags & BT_TAG_ITER_STARTED) ||
 	    blk_mq_request_started(rq))
 		ret = iter_data->fn(rq, iter_data->data);
+out:
 	if (!iter_static_rqs)
 		blk_mq_put_rq_ref(rq);
 	return ret;
-- 
2.41.0

