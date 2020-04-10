Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE93FC2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 03:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAF2206C0
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 03:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490799;
	bh=IrjETOVg0CsI3Oifk08UPiZ54HyekBJSt5pMNZD3T4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxfzKu0+S9I3LPN8YPaLpYr+E0VlX/tz65+w8cxAuNpUA/icVHEKeF46U9KZ7VJUq
	 Do0cGonpfBxENi+dWMLTCbTSK1YY3aU9HqPgs1InrdjF7zaW0V7mNPG2yibiJqGPcc
	 1qghxNktuuQ/dCBtnZDc+HNqfycCam58RMGdSPCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgDJDuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgDJDus (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 23:50:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B52F2137B;
        Fri, 10 Apr 2020 03:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490648;
        bh=IrjETOVg0CsI3Oifk08UPiZ54HyekBJSt5pMNZD3T4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PT/Bb9Ni8u91GpWm1Q1bm119l/sVhguRxApF8DgnsVGaxx40nt5krfk7vuxyByFxF
         7L+5IrSvUDvrvBXzwUtIAFCQMd2e76k+HA/zoqK0pDOS+Sy/MfHcHHE4IeopNJ7wzr
         K6zeGWLjDIN67rYyaqk+0kRbnsDk1etKXQ1kYU8o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/22] null_blk: fix spurious IO errors after failed past-wp access
Date:   Thu,  9 Apr 2020 23:50:25 -0400
Message-Id: <20200410035044.9698-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035044.9698-1-sashal@kernel.org>
References: <20200410035044.9698-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit ff77042296d0a54535ddf74412c5ae92cb4ec76a ]

Steps to reproduce:

	BLKRESETZONE zone 0

	// force EIO
	pwrite(fd, buf, 4096, 4096);

	[issue more IO including zone ioctls]

It will start failing randomly including IO to unrelated zones because of
->error "reuse". Trigger can be partition detection as well if test is not
run immediately which is even more entertaining.

The fix is of course to clear ->error where necessary.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index b4078901dbcb9..b12e373aa956a 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -622,6 +622,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 	if (tag != -1U) {
 		cmd = &nq->cmds[tag];
 		cmd->tag = tag;
+		cmd->error = BLK_STS_OK;
 		cmd->nq = nq;
 		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
 			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
@@ -1399,6 +1400,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		cmd->timer.function = null_cmd_timer_expired;
 	}
 	cmd->rq = bd->rq;
+	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
 
 	blk_mq_start_request(bd->rq);
-- 
2.20.1

