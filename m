Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5199FC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2FD2082C
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gmRCNG4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfDANkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:40:52 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:54000 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfDANkw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 09:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1554126048;
        bh=xcOVAO9FLT1t00ieWMJbhPMwJrUEO08yI+we8Q/1fxo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        b=gmRCNG4zC5FSv6GLpCphur7XMf4NNbV66NbHSASBRBO9tvtHgrBKOvyHNLRw/gYgb
         0A9edxvdEAYZa4L4y83F1a6LKwLZTzUZKWFgn+hEyvTPiPxYeT35tHu6G45BmsNMuz
         nBA+VdHJOPqAiI4AoaB6vU1Y3U5ByaBEkFoMyWJE=
X-QQ-mid: esmtp2t1554126047t091lyvd9
Received: from localhost.localdomain (unknown [221.220.250.87])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 01 Apr 2019 21:40:37 +0800 (CST)
X-QQ-SSF: 01000000000000F0FH3000000000000
X-QQ-FEAT: oMsKLsS2kt+xD9VPsVfLijVxk8e6wMej7+E6U47JgAb6tlSXHBs0M52EZ3OG9
        1C6sWQ6UN42fVD6939rYcD6SEcaXNSbZnUdwKUVDKxzlXBh/vdQfILu6y+GjjAKr7fzvGwu
        jhg3B97q8kd+pKPX4Z/a5QpmF1pGhPDqmcBPkNDlKplo3rao6d5OqomrAnuXg24X/UkYMVX
        iIqBOGZL0+UUD4X+oYwCNj8XH+9cBy9ynIYCoB7R0XmANioDys/DW6ZIZW8FiARR6JYNcxy
        /mCVYGrc5qtkg+xtuEcUdXcvs=
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH] block: use blk_free_flush_queue() to free hctx->fq in blk_mq_init_hctx
Date:   Mon,  1 Apr 2019 21:40:36 +0800
Message-Id: <20190401134036.8377-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kfree() can leak the hctx->fq->flush_rq field.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b49969..f3b0d33bdf88 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2332,7 +2332,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	return 0;
 
  free_fq:
-	kfree(hctx->fq);
+	blk_free_flush_queue(hctx->fq);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
-- 
2.20.1



