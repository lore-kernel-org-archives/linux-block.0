Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C4C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255BC20869
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nA2HJCmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfBAH4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:56:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfBAH4a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 02:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kkgzxq8ORu1uCVdKYmF6T0ORP3BLW1zjK7WACfAQ5oo=; b=nA2HJCmHcYD+t+FLeOxWlHxVUZ
        w+HBVXXGWNvOiGouWUg+SlMhhBfKwF+2MlfWltTKjL0wPzXAl0WfJEELkK8BRPVdWY/2O22DRIwP0
        PAciu2sX/yBcjnkk9Et6dvZiphqQsW/UIfbEc32GSxJcGQ1lQaZsLU9CW6M3MR8MzOcNJHqGVRFXp
        ijGp5tsWMQXIY/k/aWj3eGNNOBJdNqmqfxWCnu8fC8gLEn0ImUAzE3HZfTh/rDBNeQN/3gjkrztsn
        Kikw6jb17a/Xdw71BDuCkVEyA1TFpF/vyqqhnxN2CVpbkXmg42HJWWU4OjAnXwxBB0pxNI1qe3hdm
        GAqsAHog==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpTgY-0005sO-Sg; Fri, 01 Feb 2019 07:56:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] block: remove req->special
Date:   Fri,  1 Feb 2019 08:55:56 +0100
Message-Id: <20190201075557.9249-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201075557.9249-1-hch@lst.de>
References: <20190201075557.9249-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 1 -
 include/linux/blkdev.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ba37b9e15e9..502cbf964a3b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -331,7 +331,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
 #endif
-	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
 	WRITE_ONCE(rq->deadline, 0);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 338604dff7d0..fd1450d53f1c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -216,8 +216,6 @@ struct request {
 	unsigned short write_hint;
 	unsigned short ioprio;
 
-	void *special;		/* opaque pointer available for LLD use */
-
 	unsigned int extra_len;	/* length of alignment and padding */
 
 	enum mq_rq_state state;
-- 
2.20.1

