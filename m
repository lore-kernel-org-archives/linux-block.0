Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9772C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 13:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiGUNJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiGUNJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617798048B
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=j/8391EuedZfAXBlTVpXxZnrGzlsDnfBjmylvEwHXZM=; b=GfRn6NKx6ghGZwUl+1pnIFyTO0
        QOL9Ox6FYhom1ZwOyFBqx7U3DNSev/aooxkLpxaPLCFzhzpDWTeUuGvEIj9tGfBYPCMEQXBtlTWkE
        XRTp17JFNotT3V6Qr58STwRanVvze4J0s2mybzz0s58VP8aJw1GlFWw2VXI1xRB8zC1izVl42MTHY
        hZpt6SSIOYfd9Sqwkgipafq3cuz6hVedGzFZZY/E87CFpQ+ImmXrM4+7sazOSJYan8t2rPdR29nNa
        6eSFplwcRfa7heGtDu0GWpKj0aRfJo5Xeat0nhhMswOUl/jsAUv/GQv3jicoa+pLdaxhSmwtcKMrV
        HhKkTw6Q==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvr-006mxp-8s; Thu, 21 Jul 2022 13:09:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 6/8] ublk: fold __ublk_create_dev into ublk_ctrl_add_dev
Date:   Thu, 21 Jul 2022 15:09:14 +0200
Message-Id: <20220721130916.1869719-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __ublk_create_dev into its only caller to avoid the packing and
unpacking of the return value into an ERR_PTR.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2032d677b9f18..b8ac7b508029e 100644
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

