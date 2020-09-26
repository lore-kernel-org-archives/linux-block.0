Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112D1C4727D
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 02:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA1C20BED
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 02:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgIZCMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 22:12:15 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:16756 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgIZCMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 22:12:15 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id B9A404E142F;
        Sat, 26 Sep 2020 10:12:12 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] block: fix a typo for skd_main.c
Date:   Sat, 26 Sep 2020 10:11:59 +0800
Message-Id: <1601086321-1173-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkseSkNOGRlLHx4fVkpNS0pLQ01ISEhLT0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6Ixw5Sj8iFgE*PhU4PxJW
        FTRPFExVSlVKTUtKS0NNSEhIT0lKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTk9ONwY+
X-HM-Tid: 0a74c82e9fff9376kuwsb9a404e142f
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Modify the comment typo: "compliment" -> "complement".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/block/skd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ae6454c..e70e764
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2037,7 +2037,7 @@ static void skd_enable_interrupts(struct skd_device *skdev)
 	val = FIT_ISH_FW_STATE_CHANGE +
 	      FIT_ISH_COMPLETION_POSTED + FIT_ISH_MSG_FROM_DEV;
 
-	/* Note that the compliment of mask is written. A 1-bit means
+	/* Note that the complement of mask is written. A 1-bit means
 	 * disable, a 0 means enable. */
 	SKD_WRITEL(skdev, ~val, FIT_INT_MASK_HOST);
 	dev_dbg(&skdev->pdev->dev, "interrupt mask=0x%x\n", ~val);
-- 
2.7.4

