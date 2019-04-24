Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F03C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD360218B0
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116994;
	bh=A8DnE8KRb0LOjpot/GtLTMRzgmaEW43z05ksHucui8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=omGxsvQiHV7uVX3cGXnf1CYBin97hUeir/PPZi/rfKFht55Xdo/XKo9yZIS/K24Tg
	 Sv+7cDOBfegooQQ/6egXj69dlHdpKHGY1o4XmYCkcIDVvaMfayGbsyxBR9oegMVP27
	 23OCkbCdHrYPUwE2qWsJGQAl35ROj1c2YxoK/wgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfDXOkU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731913AbfDXOkR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B37F21907;
        Wed, 24 Apr 2019 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116816;
        bh=A8DnE8KRb0LOjpot/GtLTMRzgmaEW43z05ksHucui8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mq/CI1/1cYbOP8OkherXjHvMrLe/pMHH/GT3KJW0QF1SEgctE24ZLG3MRm31IvZPV
         pzE/yV/R5azZn4gAoO1jBSW2NwTptCxhwLzgnvYSC4F2ZKjHdfM/R+BYyNiqNpr3WJ
         ZTVSAiv7o0+maB+kdm7+yF7bQ9c8LFf+R7JT0C3s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shenghui Wang <shhuiw@foxmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/52] block: use blk_free_flush_queue() to free hctx->fq in blk_mq_init_hctx
Date:   Wed, 24 Apr 2019 10:38:46 -0400
Message-Id: <20190424143911.28890-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

[ Upstream commit b9a1ff504b9492ad6beb7d5606e0e3365d4d8499 ]

kfree() can leak the hctx->fq->flush_rq field.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7d53f2314d7c..414656796ecf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2236,7 +2236,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	return 0;
 
  free_fq:
-	kfree(hctx->fq);
+	blk_free_flush_queue(hctx->fq);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
-- 
2.19.1

