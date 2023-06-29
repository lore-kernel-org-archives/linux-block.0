Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266D8C001B1
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 11:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjF2LH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjF2LHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 07:07:25 -0400
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975D1FE8
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 04:07:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688036842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/O8YJWAa7A//A8YJ1hLAuWA8H/d3IRDfJMQYLuFl59Q=;
        b=mbIzMFKmGOLPlHTie0bZkFzRR4kKsmNBsTYTIAcXDY9PhKLh+AWN83tEAps+QrlCmHpQJ5
        6vPVir4H9Ri7Ue7A0rX45a+10TN8gVkVcHKOdW31Bm1xjWYh2rKJU5FdRDZn+3xBXxdoKu
        lTL8df0btTRLK09OBxfpmKmt+c9Wkm4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 4/4] blk-mq: delete unused completion_data in struct request
Date:   Thu, 29 Jun 2023 19:03:59 +0800
Message-Id: <20230629110359.1111832-5-chengming.zhou@linux.dev>
In-Reply-To: <20230629110359.1111832-1-chengming.zhou@linux.dev>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

After global search, I found "completion_data" in struct request
is not used anywhere, so just clean it up by the way.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/blk-mq.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 96644d6f8d18..ab790eba5fcf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -158,13 +158,11 @@ struct request {
 
 	/*
 	 * The rb_node is only used inside the io scheduler, requests
-	 * are pruned when moved to the dispatch queue. So let the
-	 * completion_data share space with the rb_node.
+	 * are pruned when moved to the dispatch queue.
 	 */
 	union {
 		struct rb_node rb_node;	/* sort/lookup */
 		struct bio_vec special_vec;
-		void *completion_data;
 	};
 
 	/*
-- 
2.39.2

