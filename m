Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ADFC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 10:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiFQKfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiFQKfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 06:35:19 -0400
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 03:35:18 PDT
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 195A96AA6A
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 03:35:18 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:44466.1879482578
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-110.80.1.46 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id D19602800C3;
        Fri, 17 Jun 2022 18:28:17 +0800 (CST)
X-189-SAVE-TO-SEND: +zhenggy@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id e3abd5973b9a41519fc97ed1e5384636 for paolo.valente@linaro.org;
        Fri, 17 Jun 2022 18:28:19 CST
X-Transaction-ID: e3abd5973b9a41519fc97ed1e5384636
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
From:   GuoYong Zheng <zhenggy@chinatelecom.cn>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        GuoYong Zheng <zhenggy@chinatelecom.cn>
Subject: [PATCH] bfq: Remove useless code in bfq_lookup_next_entity
Date:   Fri, 17 Jun 2022 18:28:04 +0800
Message-Id: <1655461684-19075-1-git-send-email-zhenggy@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is no need to judge entity is null or not here,
directly return entity is ok, so remove it.

Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
---
 block/bfq-wf2q.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index f8eb340..089d070 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1472,9 +1472,6 @@ static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
 			break;
 	}
 
-	if (!entity)
-		return NULL;
-
 	return entity;
 }
 
-- 
1.8.3.1

