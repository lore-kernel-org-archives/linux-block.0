Return-Path: <SRS0=7fUu=SB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA7AC10F05
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18222064A
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908276;
	bh=UBUpu6CHsAXE6Y9gaosXDi2xrU+30MmJXmJiVHk0K8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1HoP0tXZrnube0Nuu7FN5N01haGIrvx7WXeGySZvdL7Z1QmqlIWGAtgP2hhSm48Qm
	 YKOBK5LswlWV/FLqShNrnBpiriepjt5ttLm9FwTWSG0WUTblrDXxVjQ0zzL4u0TCIq
	 3JiREgQ5YtpdOHLPgMdxAt1YYaVrKQPHMQm14Ytw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfC3AvO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbfC3AvN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EE4A218D3;
        Sat, 30 Mar 2019 00:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907072;
        bh=UBUpu6CHsAXE6Y9gaosXDi2xrU+30MmJXmJiVHk0K8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vO7nK9BSXp4stdXXxpGjxTTtbE2WekWlXFXyxcInFQornDrFxJkFo6KLCdrGXeKDl
         JqcOlZlTivRKNDDGNguSvNDGevuQvFA+8YsIZrHfuQXdLPsHidBUZV5hXjEQYVeprX
         xv5tcmteeBfu9Gp/eDdpn1N9nDMU+cEdAvo+UHQk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 18/67] paride/pf: cleanup queues when detection fails
Date:   Fri, 29 Mar 2019 20:49:58 -0400
Message-Id: <20190330005047.25998-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 6ce59025f1182125e75c8d121daf44056b65dd1f ]

The driver allocates queues for all the units it potentially
supports. But if we fail to detect any drives, then we fail
loading the module without cleaning up those queues. This is
now evident with the switch to blk-mq, though the bug has
been there forever as far as I can tell.

Also fix cleanup through regular module exit.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/paride/pf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index e92e7a8eeeb2..103b617cdc31 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -761,8 +761,12 @@ static int pf_detect(void)
 		return 0;
 
 	printk("%s: No ATAPI disk detected\n", name);
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
+	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
+		blk_cleanup_queue(pf->disk->queue);
+		pf->disk->queue = NULL;
+		blk_mq_free_tag_set(&pf->tag_set);
 		put_disk(pf->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }
@@ -1047,13 +1051,15 @@ static void __exit pf_exit(void)
 	int unit;
 	unregister_blkdev(major, name);
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		if (!pf->present)
-			continue;
-		del_gendisk(pf->disk);
+		if (pf->present)
+			del_gendisk(pf->disk);
+
 		blk_cleanup_queue(pf->disk->queue);
 		blk_mq_free_tag_set(&pf->tag_set);
 		put_disk(pf->disk);
-		pi_release(pf->pi);
+
+		if (pf->present)
+			pi_release(pf->pi);
 	}
 }
 
-- 
2.19.1

