Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD2C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 11:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiCCLfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiCCLfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 06:35:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69B56233;
        Thu,  3 Mar 2022 03:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mgzMmQwg19eCVR+TiX9LOt7Z9P3DfcIpv3PTTjjkpYw=; b=YmpSRqQez/xW6HdyCWetkFssjn
        VfeBUwbA+Y22x3N+1lVtIyObx32OAI+y1DyXMEJIZ4YWEYEd5eWlm1CTX3/2uaqJXqN5aR2tEXgxP
        5ctFGItE08dW67ouZlIaegQBBKryFNasUvga5gEWHxsFw0QNPW9vXZXq+KdlfxpHe8af7yikAdAix
        qkk9vKkes52ovNIq8QV+htT3MZA2O3GpURU6lNGibQGmACa4jB/7uFckFwxficRyS4zJsdLPb6UJt
        b/0uDrL/D7awwN9w7FZPznou7AT2HXSbI8w94/ZBmE4Ro8JLfv39eDICTM/3pRpQHUjiV2UzIM6kz
        YqzRJMxA==;
Received: from [91.93.38.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjhN-006Dek-HM; Thu, 03 Mar 2022 11:32:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-security-module@vger.kernel.org
Subject: [PATCH 4/5] pktcdvd: stop using bdevname
Date:   Thu,  3 Mar 2022 14:32:22 +0300
Message-Id: <20220303113223.326220-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303113223.326220-1-hch@lst.de>
References: <20220303113223.326220-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index be749c686feb7..623df4141ff3f 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2471,11 +2471,9 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 {
 	struct pktcdvd_device *pd = m->private;
 	char *msg;
-	char bdev_buf[BDEVNAME_SIZE];
 	int states[PACKET_NUM_STATES];
 
-	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
-		   bdevname(pd->bdev, bdev_buf));
+	seq_printf(m, "Writer %s mapped to %pg:\n", pd->name, pd->bdev);
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
@@ -2532,7 +2530,6 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	int i;
-	char b[BDEVNAME_SIZE];
 	struct block_device *bdev;
 	struct scsi_device *sdev;
 
@@ -2545,8 +2542,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		if (!pd2)
 			continue;
 		if (pd2->bdev->bd_dev == dev) {
-			pkt_err(pd, "%s already setup\n",
-				bdevname(pd2->bdev, b));
+			pkt_err(pd, "%pg already setup\n", pd2->bdev);
 			return -EBUSY;
 		}
 		if (pd2->pkt_dev == dev) {
@@ -2581,7 +2577,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	}
 
 	proc_create_single_data(pd->name, 0, pkt_proc, pkt_seq_show, pd);
-	pkt_dbg(1, pd, "writer mapped to %s\n", bdevname(bdev, b));
+	pkt_dbg(1, pd, "writer mapped to %pg\n", bdev);
 	return 0;
 
 out_mem:
-- 
2.30.2

