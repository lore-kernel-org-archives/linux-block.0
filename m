Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA6C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F8C2176D
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731001;
	bh=AiHOas8FpZ+35GyVOzSMP/dUHuS5mXTYhtblJ3qlYeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdehTy+9Q9tnlgxoEugcptHPNAemk8Zni251Jv7zIqoDg6ucejW8fv9paVfTmvXcv
	 XFXvIb7iqSyQMTLMxN1bWrgmr1fzmAgM6GQzCa9YzqCqPRstDck5aNkTtKtN3tr/2x
	 1XY1rsYWenIVGh4uEI0VlI/d3/wS/F8EmiHpFhTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgDXMXT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgDXMXT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA1C21569;
        Fri, 24 Apr 2020 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730998;
        bh=AiHOas8FpZ+35GyVOzSMP/dUHuS5mXTYhtblJ3qlYeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipv/rp2N8Rp3Uq+pwD/I//v2eejjgONxhjiBq94EzBmN7IeNO233gSRjigbrz4JUZ
         hzmXDlZaeOx85kjU2LeGk/r2udy8FKMOW7msLj8OWGzbt0UkBjA9B/+AFUoQXwszNj
         llm09J5qumtsT9uuTVANIXPM3zIBkbaeu2Cjw3mM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 36/38] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when no budget
Date:   Fri, 24 Apr 2020 08:22:34 -0400
Message-Id: <20200424122237.9831-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit 5fe56de799ad03e92d794c7936bf363922b571df ]

If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
dispatch loop, but the request may keep the driver tag, evaulated
in 'nxt' in the previous loop iteration.

Fix by putting the driver tag for that request.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 37ff8dfb8ab9f..2c3a1b2e07537 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1205,8 +1205,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+			blk_mq_put_driver_tag(rq);
 			break;
+		}
 
 		if (!blk_mq_get_driver_tag(rq)) {
 			/*
-- 
2.20.1

