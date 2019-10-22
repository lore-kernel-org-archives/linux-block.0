Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751F9CA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7D2075A
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfJVRmf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:42:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJVRmf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 13:42:35 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f5:c26b:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3523128DB6C;
        Tue, 22 Oct 2019 18:42:31 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] blk-mq: remove needless goto from blk_mq_get_driver_tag
Date:   Tue, 22 Oct 2019 14:41:08 -0300
Message-Id: <20191022174108.15554-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only usage of the label "done" is when (rq->tag != -1) at the
begging of the function. Rather than jumping to label, we can just
remove this label and execute the code at the "if". Besides that,
the code that would be executed after the label "done" is the return of
the logical expression (rq->tag != -1) but since we are already inside
the if, we now that this is true. Remove the label and replace the goto
with the proper result of the label.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Hello,

I've used `blktest` to check if this change add any regression. I have
used `./check block` and I got the same results with and without this
patch (a bunch of "passed" and three "not run" because of the virtual
scsi capabilities). Please let me know if there would be a better way to
test changes at block stack.

This commit was rebase at linux-block/for-5.5/block.

Thanks,
	André
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8538dc415499..1e067b78ab97 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1036,7 +1036,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 	bool shared;
 
 	if (rq->tag != -1)
-		goto done;
+		return true;
 
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
@@ -1051,7 +1051,6 @@ bool blk_mq_get_driver_tag(struct request *rq)
 		data.hctx->tags->rqs[rq->tag] = rq;
 	}
 
-done:
 	return rq->tag != -1;
 }
 
-- 
2.23.0

