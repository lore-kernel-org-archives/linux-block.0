Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE2AECDFA1
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiJYOku (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiJYOkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB5539B97
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3Io0eBhCr/FHLmHpxgYZ1taiPGcCUyVAts23z2QYtk0=; b=rNKjumSaZ9VgWKIpZ3j8ghQRDL
        Jcs/qKn4B+u+Cc7st4Qf+FnU400fpDQJtrDBfIZ+I948mEIMUlaHoSl6B0qkEmMguULGcGzg+kjmh
        0JdA8IwGravTEVdOoVWDEDZgkExTW5W26ktu0cooGdrdZZaRcOP4lZw9Zh+QQPaLCXrmJXMrApJlv
        qLVqHG8nQec3K5i+GK8WE/NMRbvDtS9Z36nzy69v5sau7InBRTGkrj8wBPU3SAHtMqlFMnmHUe9Oe
        GK/LI1Rfu7NgmMB7krvS7TgGY+KDw0w0PRc1P9hXbuZl9fg8lhzT+lkbEcNCc8q/8kFYkFA3yOgQL
        MkAsrM9w==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6N-005pn9-07; Tue, 25 Oct 2022 14:40:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 08/17] nvme: don't unquiesce the admin queue in nvme_kill_queues
Date:   Tue, 25 Oct 2022 07:40:11 -0700
Message-Id: <20221025144020.260458-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are 4 callers of nvme_kill_queues:

 1) nvme_reset_work explicit call nvme_start_admin_queue toward the
    beginning of the function.  The extra call to nvme_start_admin_queue
    in nvme_reset_work this won't do anything as
    NVME_CTRL_ADMIN_Q_STOPPED will already be cleared.
 2) nvme_remove calls nvme_dev_disable with shutdown flag set to true at
    the very beginning of the function if the PCIe device was not present,
    which is the precondition for the call to nvme_kill_queues.
    nvme_dev_disable already calls nvme_start_admin_queue toward the
    end of the function when the shutdown flag is set to true, so the
    admin queue is already enabled at this point.
 3) nvme_remove_dead_ctrl schedules a workqueue to unbind the driver,
    which will end up in nvme_remove, which calls nvme_dev_disable with
    the shutdown flag.  This case will call nvme_start_admin_queue a bit
    later than before.
 4) apple_nvme_remove uses the same sequence as nvme_remove_dead_ctrl
     above.

So it is safe to just remove the call to nvme_start_admin_queue in
nvme_kill_queues without replacement.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99eabbe7fac98..d4d25f1dd6dba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5121,9 +5121,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
-		nvme_start_admin_queue(ctrl);
-
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
 
-- 
2.30.2

