Return-Path: <SRS0=lwW3=BS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E7FC433E1
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A503D2075D
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929823;
	bh=VhMqv89aKVSu2wYlMStOJnpTIrVpsgyXhjWZ+wheO74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MvOv69BpquwEfNJjYGN0y5sEmrWxVR01gTx40KsLr/5bwEqa366PZaysXryUcHLO3
	 PVKTxugr7Auux0/7b1U8W/Xv3lOls5xybMcn1KoGoJ24ZVBw42EzY6gHKAChlpaPlV
	 dTtG3MlA/80LmLTv8zsfBc4N2qiOOAEnHIL9WJjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHHXhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgHHXhB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Aug 2020 19:37:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E5820716;
        Sat,  8 Aug 2020 23:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929820;
        bh=VhMqv89aKVSu2wYlMStOJnpTIrVpsgyXhjWZ+wheO74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ky6WeChsqEawuDw1mmG92iHgu7i+/iUlxiIfDTPZwmqeXf5eDO1y9+ODREArt7TZG
         wQgChest0TzUrymihfGhtIpt36aufCca3zBU2ID8sg+RKRi1PvSMPGZb3kiEUK1RjK
         wI8MOBzujLMStFKpoShcV2s5ruNDew2uXh3Gv5RU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 54/72] iocost: Fix check condition of iocg abs_vdebt
Date:   Sat,  8 Aug 2020 19:35:23 -0400
Message-Id: <20200808233542.3617339-54-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit d9012a59db54442d5b2fcfdfcded35cf566397d3 ]

We shouldn't skip iocg when its abs_vdebt is not zero.

Fixes: 0b80f9866e6b ("iocost: protect iocg->abs_vdebt with iocg->waitq.lock")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8ac4aad66ebc3..86ba6fd254e1d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1370,7 +1370,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * should have woken up in the last period and expire idle iocgs.
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
-		if (!waitqueue_active(&iocg->waitq) && iocg->abs_vdebt &&
+		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 		    !iocg_is_idle(iocg))
 			continue;
 
-- 
2.25.1

