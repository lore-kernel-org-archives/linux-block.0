Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B0EE49A5
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 09:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjHUJ56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Aug 2023 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjHUJ54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 05:57:56 -0400
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [IPv6:2001:41d0:203:375::17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43BBE7
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 02:57:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692611871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkDR5NLi5YNWQzKxCk4+sjUxTF0L3YdBSik5mAIut1w=;
        b=l5ybMqIqiUClbR21w3/Cb97G6tbSdSA0tJhEWUpmZkiEDxXXMER3F22eTiWGLZSu7ydzZj
        G+2+giVlTmmnohHbywwXsoBMdpk50xMSC1JkoCxAiqJiBJ40sHF/xusFIClHDZAR8xWw8f
        rp9qYb2Z5/OJmezHY6xS73PByAWlHDM=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 3/3] blk-mq: prealloc tags when increase tagset nr_hw_queues
Date:   Mon, 21 Aug 2023 17:56:02 +0800
Message-ID: <20230821095602.70742-3-chengming.zhou@linux.dev>
In-Reply-To: <20230821095602.70742-1-chengming.zhou@linux.dev>
References: <20230821095602.70742-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Just like blk_mq_alloc_tag_set(), it's better to prepare all tags before
using to map to queue ctxs in blk_mq_map_swqueue(), which now have to
consider empty set->tags[].

The good point is that we can fallback easily if increasing nr_hw_queues
fail, instead of just mapping to hctx[0] when fail in blk_mq_map_swqueue().

And the fallback path already has tags free & clean handling, so all
is good.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8d02bafff331..84adb3657b30 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4404,6 +4404,16 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
+
+	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
+		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
+			while (--i >= set->nr_hw_queues)
+				__blk_mq_free_map_and_rqs(set, i);
+			return -ENOMEM;
+		}
+		cond_resched();
+	}
+
 done:
 	set->nr_hw_queues = new_nr_hw_queues;
 	return 0;
-- 
2.41.0

