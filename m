Return-Path: <SRS0=lwW3=BS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE297C433E1
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9287F20672
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 23:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930368;
	bh=zAUNWZzCI8ukKqTvNlnlscIEQVsbnvlQ1UoOIQ2chNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fFS+VDoGxLBgA59zAIhhyWIPGD53SpITvjvKgdySEikEIaVMs08BNFLaIvF23EPFz
	 0DaocUaNbyETGtv6FpohClVQ6mOqRYCNIHhJDfo0sAWOAg2NnF4xdPOueVKr32pCGk
	 bVIfobkMrx+P+9R3oA/SOQ93a+bOx6c0eRQgcfi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHHXi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgHHXi2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B973C207BB;
        Sat,  8 Aug 2020 23:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929908;
        bh=zAUNWZzCI8ukKqTvNlnlscIEQVsbnvlQ1UoOIQ2chNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS04zpqMqOn6EkiZANN3AMoNVsEZ4EyKA7mZt2hgMiZBwxoz01K2Lez4JHF7GWO0d
         XILuDlfzeLGB2j7V9ZZZ3Vt3p4wuW8q1+SLoPDpKgRmenGkHDixFRiJZg40LXI40md
         RIBNgdcl2Zmr4nyL+KX2BYrOTmUF3KPHuDxsHN+Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 46/58] iocost: Fix check condition of iocg abs_vdebt
Date:   Sat,  8 Aug 2020 19:37:12 -0400
Message-Id: <20200808233724.3618168-46-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
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
index ef193389fffe9..b5a9cfcd75e9d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1374,7 +1374,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * should have woken up in the last period and expire idle iocgs.
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
-		if (!waitqueue_active(&iocg->waitq) && iocg->abs_vdebt &&
+		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 		    !iocg_is_idle(iocg))
 			continue;
 
-- 
2.25.1

