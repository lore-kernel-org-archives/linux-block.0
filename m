Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC93C4332F
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiKAPIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiKAPIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:08:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD22D2251A
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+Ufifm1k1HpMzIHQoATSkCrRQA+hWQleQGdeWF3/Tzw=; b=rIzIPqzAjcUfTQi1SOO0l0QHVO
        rHgq0tBoUTLhRCR7w4WbVRbu39grwCG+ziZG7XHV/pd9wu7T+/aqJf0uKaqAbHsZxCHRDhBXgjeJd
        ts1u93rFmCWIbZ5DvBczEKIbD3vi1Ct7b3yMTzPfIXPLBbg7gennLOMpwBHE2ygxvavlH4lhhbZIC
        +WbxxNl0SIpVPUbwOGFeH1/e4TYlJ9G+O6+M41e4+Op3oGKzVE4O6Q4VfjVsB/UGYAoI0HbFfiDC8
        sqICAvK/SsowLLxqqGtdP1zuf8hB/xUIOnyY/Op7043VbPOAYZ4WQ1cXFL2mickpSSoc4jIFzS/Cb
        uaM5zqKA==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslT-005gn8-Tq; Tue, 01 Nov 2022 15:01:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 08/14] nvme-pci: don't unquiesce the I/O queues in nvme_remove_dead_ctrl
Date:   Tue,  1 Nov 2022 16:00:44 +0100
Message-Id: <20221101150050.3510-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme_remove_dead_ctrl schedules nvme_remove to be called, which will
call nvme_dev_disable and unquiesce the I/O queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 046fc02914a5a..159bc8918bbf0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2789,7 +2789,6 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
 	nvme_mark_namespaces_dead(&dev->ctrl);
-	nvme_start_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
-- 
2.30.2

