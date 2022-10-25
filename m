Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0226ECDFA1
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiJYOkp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1653E8112E
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FcOTAzbhpn3Jj3N5dofmETSpJuQKA24JO2Fa2JkIzF8=; b=bkuPOcFvPVv8ThY4vjpkCZQZbG
        v6bokO++he/X7WkzmeumPCJrLPhlJxnqF/iFClN0teoJODNW8bTifpFeZKxeiEG+//AphQiFIj+nB
        xKtPDZrf9BhhEEkcBPaKTHpMLFF7znYSaM/R3PaHJ+zxrdA1ZUT/9hvCA7Ln6kRyKJfCBLiuPXQZt
        2eamuPDb9Vk74smnst++IG2Ihot96bI2KCJrut+pjtpUl+UhGCKE+bUf0p28nf35m8XyzTdq/FZ3t
        /bN2gns+m204Kg/5Vc0eAHtTk6AC2dgEd4je1qpOESzeTzX/7UdEXZbDrXw2jafZbkjaw8NGafXIt
        XtNV8lEQ==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6O-005po1-Gl; Tue, 25 Oct 2022 14:40:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 12/17] nvme-pci: don't unquiesce the I/O queues in apple_nvme_reset_work
Date:   Tue, 25 Oct 2022 07:40:15 -0700
Message-Id: <20221025144020.260458-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

apple_nvme_reset_work schedules apple_nvme_remove, to be called, which
will call apple_nvme_disable and unquiesce the I/O queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 14bee207316a0..44e7daf93e19c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1154,7 +1154,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	nvme_get_ctrl(&anv->ctrl);
 	apple_nvme_disable(anv, false);
 	nvme_mark_namespaces_dead(&anv->ctrl);
-	nvme_start_queues(&anv->ctrl);
 	if (!queue_work(nvme_wq, &anv->remove_work))
 		nvme_put_ctrl(&anv->ctrl);
 }
-- 
2.30.2

