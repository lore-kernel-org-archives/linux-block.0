Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC6C10F14
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 03:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D3A2177B
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 03:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QPIGeHZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfDQD1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:27:17 -0400
Received: from m50-132.163.com ([123.125.50.132]:49080 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbfDQD1R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 23:27:17 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 23:27:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=pa90oONOQE2aayBbcS
        fTUNDIb3aN4WNHk8cBOwnKV9k=; b=QPIGeHZjtRc8PxLcJ88ZoKfF4B54r3fRh2
        SXIHDXaOkiWPdFTskE/w7V7lwSPNuPT1XllxM8gB6XQmOVk3ORVdyWYZAcWQsKNt
        +j8ncjWEpohlqgOG+LvztIa249yqKFDBiDqJnYbmbZD9jeLzwSIIGn3EzpGp26fz
        SpsRC4SMc=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp2 (Coremail) with SMTP id DNGowAC3Xv98mbZcFKkoAA--.242S3;
        Wed, 17 Apr 2019 11:12:07 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: scsi: bsg-lib: drop device reference on error path
Date:   Wed, 17 Apr 2019 11:11:55 +0800
Message-Id: <1555470715-55702-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DNGowAC3Xv98mbZcFKkoAA--.242S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWxJr47ZrykuryxJr45Awb_yoWkGrX_CF
        y093s7Xrn5CFWfCF4YkFWUtr92gF4DXF1IvF4UtF93ZFyUGrZxJa1UZr15urZ8Ww4fu3W2
        v3ZrZFWfCr1SqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjwID3UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzweZclaD2NPpCgAAse
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function put_device is not called to drop the device reference taken
by get_device on error paths. This patch fixes the bug.

Fixes: cd2f076f1d7("bsg: convert to use blk-mq")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 block/bsg-lib.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 005e2b7..fe9e0cc 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -281,21 +281,24 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct bsg_set *bset =
 		container_of(q->tag_set, struct bsg_set, tag_set);
 	int ret;
+	blk_status_t status = BLK_STS_IOERR;
 
 	blk_mq_start_request(req);
 
 	if (!get_device(dev))
-		return BLK_STS_IOERR;
+		return status;
 
 	if (!bsg_prepare_job(dev, req))
-		return BLK_STS_IOERR;
+		goto out;
 
 	ret = bset->job_fn(blk_mq_rq_to_pdu(req));
 	if (ret)
-		return BLK_STS_IOERR;
+		goto out;
 
+	status = BLK_STS_OK;
+out:
 	put_device(dev);
-	return BLK_STS_OK;
+	return status;
 }
 
 /* called right after the request is allocated for the request_queue */
-- 
2.7.4


