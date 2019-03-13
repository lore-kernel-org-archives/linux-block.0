Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D346AC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A646B20854
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p5b07SSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfCMR4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:56:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCMR4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/R2oveCB78kgTGka2826A64alCrXBxKYXReG6xCOjsg=; b=p5b07SSmWnHMf8fLXCKuYUdr+q
        lqH+sffWVbkFtQdpXoDCYAsQU3vUpjzVbvd3heyRDWliyCJVtDmaS3xwa75RRENQa3F9OHrHioi+o
        HviGsfzJqfCI7aUjHv2eFq2mBxtx9mPkMt6z7IXn6krjZBjmaM8F4Mt1UZ3661lcdy/3otMJ/QXzu
        Dki2fliqCg9extofbGaUSbxJTbocYONh79ugatfh/l078on89qkH1/Yje3eOzR7TTAgoEfxYLZJCm
        UVnbj0M5RbzclA2GhbX5xfdBG2khkOs4/7nj648Yr0tRjQnT6nkFO7n1B8G6JUuanFYLgbE+t9byd
        afBmYaCg==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486q-00027O-97; Wed, 13 Mar 2019 17:56:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 16/17] nvmet: ignore EOPNOTSUPP for discard
Date:   Wed, 13 Mar 2019 18:55:09 +0100
Message-Id: <20190313175510.20725-17-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe DSM is a pure hint, so if the underlying device / file system
does not support discard-like operations we should not fail the
operation but rather return success.

Fixes: 3b031d15995f ("nvmet: add error log support for bdev backend")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/io-cmd-bdev.c | 8 ++++----
 drivers/nvme/target/io-cmd-file.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 71dfedbadc26..a065dbfc43b1 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -194,11 +194,11 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
-
-	if (ret)
+	if (ret && ret != -EOPNOTSUPP) {
 		req->error_slba = le64_to_cpu(range->slba);
-
-	return blk_to_nvme_status(req, errno_to_blk_status(ret));
+		return blk_to_nvme_status(req, errno_to_blk_status(ret));
+	}
+	return NVME_SC_SUCCESS;
 }
 
 static void nvmet_bdev_execute_discard(struct nvmet_req *req)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 517522305e5c..3e43212d3c1c 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -297,7 +297,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 		}
 
 		ret = vfs_fallocate(req->ns->file, mode, offset, len);
-		if (ret) {
+		if (ret && ret != -EOPNOTSUPP) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, ret);
 			break;
-- 
2.20.1

