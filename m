Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A984FC04A95
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiJYOks (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiJYOkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8679F4523A
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zsC5LCrtGDwY/PILkeG0NAllG5mtpvGF+RFlFdcpBBQ=; b=g6psAHcPtnVam3evf6cO+Y5RUj
        mwFDZiwy1CYo75FN/Sk74SoFisnAMfD07tQDcjLclj0mZuFSD0jlnGgKH1s1caPDIkJ7GVG/37bbL
        9NKOTNppOrVYKJVV9vV9bGvuhqLBIjlRDXr7uz4W9TzjTPWgw9S+5HAXf0UoH+1hFGbaaqXpYuJip
        zQj/MwmP9v4hw//CXCO4cYC2am1qcZHrhFz9zg55ydn0aNbYm4Gh1O8+TdPYU5wyq6arlEdtPDWD+
        Y9wk+onyeASirN7K3b44Nedh8DbC+rNLl78ECBUwksA9BewSdv9gJD1A9xUypL7kBU3jcMU/8zIXH
        glC9ZOZQ==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6N-005pnn-Rg; Tue, 25 Oct 2022 14:40:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 11/17] nvme-pci: don't unquiesce the I/O queues in nvme_remove_dead_ctrl
Date:   Tue, 25 Oct 2022 07:40:14 -0700
Message-Id: <20221025144020.260458-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
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
index bef98f6e1396c..3a26c9b2bf454 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2794,7 +2794,6 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
 	nvme_mark_namespaces_dead(&dev->ctrl);
-	nvme_start_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
-- 
2.30.2

