Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiGUFRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiGUFQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:16:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2387B79EC9
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eHUS2IgbSTkLqGQiCc5TY9gZT9uvQe/APN891Ex412U=; b=GSQv4HxiVPqzl9rpTtqUAaRdt1
        rFYgNuCthreY6wvyzPl0gxQKJrqS7SdYPEg9V+dmZJltcix3ViNDAwfLxgzmuWiu0zFtgfKADlW8G
        RiEzTnXe9vXzFgAOZuqcSfZR+XBctgRwalXVs9DmoNM1yAt477llsSOedGYQghpNKyQELu9KpdKDT
        cncZ/WTemZCDUO92jNl/krbKHGBtKsplecJm+0n0UJ5BuHdZTUTlY4y2W4IM/KluN/MCb0DejWFpn
        t718zxIwYiNTaHPto1b+l3sJ9mOQ77sC/YUBdmncE1HkbahNIHMuoU4foWbOp9RSYbMuOVl63UcpA
        XXVFXnSw==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOYT-00HDkN-K0; Thu, 21 Jul 2022 05:16:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/8] ublk: fold __ublk_create_dev into ublk_ctrl_add_dev
Date:   Thu, 21 Jul 2022 07:16:30 +0200
Message-Id: <20220721051632.1676890-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721051632.1676890-1-hch@lst.de>
References: <20220721051632.1676890-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __ublk_create_dev into its only caller to avoid the packing and
unpacking of the return value into an ERR_PTR.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index af70c18796e70..7d57cbecfc8a0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1017,23 +1017,6 @@ static int __ublk_alloc_dev_number(struct ublk_device *ub, int idx)
 	return err;
 }
 
-static struct ublk_device *__ublk_create_dev(int idx)
-{
-	struct ublk_device *ub = NULL;
-	int ret;
-
-	ub = kzalloc(sizeof(*ub), GFP_KERNEL);
-	if (!ub)
-		return ERR_PTR(-ENOMEM);
-
-	ret = __ublk_alloc_dev_number(ub, idx);
-	if (ret < 0) {
-		kfree(ub);
-		return ERR_PTR(ret);
-	}
-	return ub;
-}
-
 static void __ublk_destroy_dev(struct ublk_device *ub)
 {
 	spin_lock(&ublk_idr_lock);
@@ -1357,9 +1340,14 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (ret)
 		return ret;
 
-	ub = __ublk_create_dev(header->dev_id);
-	if (IS_ERR(ub)) {
-		ret = PTR_ERR(ub);
+	ret = -ENOMEM;
+	ub = kzalloc(sizeof(*ub), GFP_KERNEL);
+	if (!ub)
+		goto out_unlock;
+
+	ret = __ublk_alloc_dev_number(ub, header->dev_id);
+	if (ret < 0) {
+		kfree(ub);
 		goto out_unlock;
 	}
 
-- 
2.30.2

