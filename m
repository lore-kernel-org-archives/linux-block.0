Return-Path: <SRS0=C1jc=Q6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77591C43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Feb 2019 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389E420661
	for <linux-block@archiver.kernel.org>; Sat, 23 Feb 2019 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957486;
	bh=jWe6/0ZD7tsY48E9UGu1H0gSMFg6USAvCPF8aKtvN3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EM3jgwa5wSs309mwxcCrZ2UcWXyJtrVyf4V9+O2YaQGvIS9J/acyewIygOhLYbu+l
	 wxXJN+PLSegx4UPLs0MOxC66Qh0ABlMkSlL496N4ISiBlR6x2+Ky4F7ihBuDgL9ka4
	 gXX/g4uoAfz3+rebHYPL+nEGUipUJqEcoNk1oo1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfBWV3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfBWVGC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C5720855;
        Sat, 23 Feb 2019 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955961;
        bh=jWe6/0ZD7tsY48E9UGu1H0gSMFg6USAvCPF8aKtvN3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewbIEoHnl5z5Ku1ity8rxIl3xjejTVH4rEaOpP4UAy8LSGsOcHTZ6oWlYJmCzzlw+
         PIF8zN/ACnsYI2IccheCM908Nnn8njIi4J/6qLFwIGRPBR4kuYZRJT1kbDdlLg3Hzm
         eab0L8cIGbQmQTNVAzE2fjHmg/qR2tHpS5snRGG4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 58/72] blk-mq: fix a hung issue when fsync
Date:   Sat, 23 Feb 2019 16:04:08 -0500
Message-Id: <20190223210422.199966-58-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit 85bd6e61f34dffa8ec2dc75ff3c02ee7b2f1cbce ]

Florian reported a io hung issue when fsync(). It should be
triggered by following race condition.

data + post flush         a flush

blk_flush_complete_seq
  case REQ_FSEQ_DATA
    blk_flush_queue_rq
    issued to driver      blk_mq_dispatch_rq_list
                            try to issue a flush req
                            failed due to NON-NCQ command
                            .queue_rq return BLK_STS_DEV_RESOURCE

request completion
  req->end_io // doesn't check RESTART
  mq_flush_data_end_io
    case REQ_FSEQ_POSTFLUSH
      blk_kick_flush
        do nothing because previous flush
        has not been completed
     blk_mq_run_hw_queue
                              insert rq to hctx->dispatch
                              due to RESTART is still set, do nothing

To fix this, replace the blk_mq_run_hw_queue in mq_flush_data_end_io
with blk_mq_sched_restart to check and clear the RESTART flag.

Fixes: bd166ef1 (blk-mq-sched: add framework for MQ capable IO schedulers)
Reported-by: Florian Stecker <m19@florianstecker.de>
Tested-by: Florian Stecker <m19@florianstecker.de>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 8b44b86779daa..87fc49daa2b49 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -424,7 +424,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
-	blk_mq_run_hw_queue(hctx, true);
+	blk_mq_sched_restart(hctx);
 }
 
 /**
-- 
2.19.1

