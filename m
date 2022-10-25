Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF19EECDFA1
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiJYOkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163478112D
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2mpDjVdFpU1lYjcPmKrhMb9Fa8SDVixa54EUiiVNGzY=; b=M/8/u6EQO1lJKWNb/NlfEbBj8k
        rNm6e7MON9sjY6ewJqTWJra1dlFvWpHp5s+hAoEa7AEM3QhcEnpk3VUD27Ak2cU1kBMaKn+zf/ctE
        x8wWDS6YwpfDMUNCG9FsU4YFuqN34hvOENra7GGN9brNTef0yJOBPnHNwukrP4KNUbBrf9kMaOm0y
        tQ7WGQQ96QnVWYf/fU6Rf0Hg50PvOCsB8yH9xy3IrJEO2ZKRGm3Dwoc48RIlvRqUhkDm1y0bMkxp+
        YdlGntc5XRthqYiHWp2xV8IvLjNN3gYj+szG696a+cDyNKCA2/A71h8Q4ECpAsnMriRfjBmKxa4iw
        r8J4PNGQ==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6L-005pmC-In; Tue, 25 Oct 2022 14:40:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 03/17] nvme-pci: don't warn about the lack of I/O queues for admin controllers
Date:   Tue, 25 Oct 2022 07:40:06 -0700
Message-Id: <20221025144020.260458-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Admin controllers never have I/O queues, so don't warn about that fact.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 51513d263d77a..ec034d4dd9eff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2917,7 +2917,8 @@ static void nvme_reset_work(struct work_struct *work)
 			nvme_dbbuf_set(dev);
 			nvme_unfreeze(&dev->ctrl);
 		} else {
-			dev_warn(dev->ctrl.device, "IO queues lost\n");
+			if (dev->ctrl.cntrltype != NVME_CTRL_ADMIN)
+				dev_warn(dev->ctrl.device, "IO queues lost\n");
 			nvme_kill_queues(&dev->ctrl);
 			nvme_remove_namespaces(&dev->ctrl);
 			nvme_free_tagset(dev);
@@ -2931,7 +2932,9 @@ static void nvme_reset_work(struct work_struct *work)
 			nvme_pci_alloc_tag_set(dev);
 			nvme_dbbuf_set(dev);
 		} else {
-			dev_warn(dev->ctrl.device, "IO queues not created\n");
+			if (dev->ctrl.cntrltype != NVME_CTRL_ADMIN)
+				dev_warn(dev->ctrl.device,
+					 "IO queues not created\n");
 		}
 	}
 
-- 
2.30.2

