Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12487EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 09:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGTJz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGTJzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 05:55:25 -0400
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5AF0
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 02:55:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JYO8AUEVeiLXQ+In8VJ0iP6vrymxYYiCE/Q88t5iZP4=;
        b=liiR8izGugvChbiOGmEZhqTabseMc+coEaFVZ5k4Ogo9fbIoGLlfQ1geKeIz8glXgWY91Y
        dj28rtyKnEDI0VG8IhOUwCBpXputS2nRQ7JbRHf/feYmG0OWlPRok7mK1tCuV1plt8g56w
        YbvTIQ8SpR7Enxj8d5TXDFZdW6f6T9I=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH] blk-mq: delete dead struct blk_mq_hw_ctx->queued field
Date:   Thu, 20 Jul 2023 17:55:12 +0800
Message-ID: <20230720095512.1403123-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

This counter is not used anywhere, so delete it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/blk-mq.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 01e8c31db665..958ed7e89b30 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -393,8 +393,6 @@ struct blk_mq_hw_ctx {
 	 */
 	struct blk_mq_tags	*sched_tags;
 
-	/** @queued: Number of queued requests. */
-	unsigned long		queued;
 	/** @run: Number of dispatched requests. */
 	unsigned long		run;
 
-- 
2.41.0

