Return-Path: <SRS0=lwW3=BS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13119C433E0
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F4C20656
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930238;
	bh=II2jU+hdZxVqYC9gS6Z+ZKE+DZDH2JmlXDJESTVV82k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JdQEzMQ46t2nuz7vCj1phx1zI6NHVjOUuwruH6t6AxaTnifgDEKMTai6U42sWBIsp
	 TvFtJFk1BtY4vVt0/Ddmm+jbliXh05gOZ72suyyAngHLt+JLU2pjoPp1B+69uDyXdT
	 vRVl4adqOipohIAbqF7WfzST2xL0G0dJvZdJvLmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgHHXjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgHHXjc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Aug 2020 19:39:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3C020829;
        Sat,  8 Aug 2020 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929972;
        bh=II2jU+hdZxVqYC9gS6Z+ZKE+DZDH2JmlXDJESTVV82k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lRJEHC6/nt+QD12oQcf1s1goVsi5di8odf722nuS8m2jUbc/LpBc2vyDFjpl/vvU
         6zCK3vumxgEHwClCSrC7LTrh1Lh4JogbNlMleR+dRfuBlqJn69RMu3kGZFXS6es0xO
         fYhE6jVFc6S2yAk0VMJVZPCGzU/YtD203VUhPzKw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 33/40] iocost: Fix check condition of iocg abs_vdebt
Date:   Sat,  8 Aug 2020 19:38:37 -0400
Message-Id: <20200808233844.3618823-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233844.3618823-1-sashal@kernel.org>
References: <20200808233844.3618823-1-sashal@kernel.org>
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
index 4d2bda812d9b4..dcc6685d5becc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1377,7 +1377,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * should have woken up in the last period and expire idle iocgs.
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
-		if (!waitqueue_active(&iocg->waitq) && iocg->abs_vdebt &&
+		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 		    !iocg_is_idle(iocg))
 			continue;
 
-- 
2.25.1

