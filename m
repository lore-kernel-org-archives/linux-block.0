Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C957C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626662253D
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTeEvw4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfLLPgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:36:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfLLPgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 10:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MdwMtjdXysd3qg5N7D2Yv7o6zLHdpUZ1BRg8FiQcPiI=; b=tTeEvw4Pur9lwdoZkVfH6dnUaq
        csfvudcby4vwc2sxS034qJpX6wL6H881lPBew8eJfKrPoCnv7IXpatNc5bInHWnvZe7ESMG2pOtUa
        ZzDxsVJlKkFXeJKR+WgISbssjdaMd95dtOpdu4ZBPd5tGs9UqCvdoyuqb2dnjhVDvW/+hQSiKhtRv
        gnf3Gvc4z0oDxSeTi+7AeeVvCu3BRAbq42kc6W/ZoDkWaQoIEP/zmNEF6e2Qc6HSHDdynFLppIIL8
        SSS5upTfffvJJu+7+ELXT7shMaxSw651Ibodq+iZcT/Uf4ygynKpDrVSkas1op0tafc4KKDjDyvk5
        TqqYAeNQ==;
Received: from [2001:4bb8:188:2b00:20e6:8b5a:ed96:f9da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifQVd-0007Ij-8G; Thu, 12 Dec 2019 15:36:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, liangchen.linux@gmail.com,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 1/7] bcache: cached_dev_free needs to put the sb page
Date:   Thu, 12 Dec 2019 16:35:58 +0100
Message-Id: <20191212153604.19540-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212153604.19540-1-hch@lst.de>
References: <20191212153604.19540-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liang Chen <liangchen.linux@gmail.com>

Same as cache device, the buffer page needs to be put while
freeing cached_dev.  Otherwise a page would be leaked every
time a cached_dev is stopped.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 77e9869345e7..a573ce1d85aa 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1275,6 +1275,9 @@ static void cached_dev_free(struct closure *cl)
 
 	mutex_unlock(&bch_register_lock);
 
+	if (dc->sb_bio.bi_inline_vecs[0].bv_page)
+		put_page(bio_first_page_all(&dc->sb_bio));
+
 	if (!IS_ERR_OR_NULL(dc->bdev))
 		blkdev_put(dc->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 
-- 
2.20.1

