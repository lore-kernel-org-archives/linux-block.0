Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF39C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKAPI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKAPH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:07:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C1B1E725
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PLmgUevMzzrLRuQx97jRlnGVQcnqlnKGWkKm3cCI3M0=; b=CwyOGoskjE+aWQ8ZiBlLYAz1Td
        zRUxGkWNGJ3w1UADQkUdCAZpEztBPuwRCITBqTfqgBjBU8bzHJzbnArlQlAfi9YIWrAGkgUwopNYe
        DCEWumWOgVd9TBf6lcRSnfkf36Whd0ZgZtliLJIQBtC49xWdeRlHqw0ys+YLhQJEZm7jeOJ9k08rz
        w5wyK82f2kpNWXG1mlyQD1An1uNezPCEH22s7/pFJZhruyaWV+bUBX79NJFOMLzH8TRPEEKvDePW/
        VmvpqZVCRvY9aiIrHBM+Ph3B7FvdTbc5sjHx8v1x4TlA7D3sxY2/LxBACsJqy/wjkd/78imn2DVgS
        AIn5OYBQ==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslN-005gkj-Vh; Tue, 01 Nov 2022 15:01:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 06/14] nvme: don't unquiesce the admin queue in nvme_kill_queues
Date:   Tue,  1 Nov 2022 16:00:42 +0100
Message-Id: <20221101150050.3510-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

None of the callers of nvme_kill_queues needs it to unquiesce the
admin queues, as all of them already do it themselves:

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
 5) nvme_remove_namespaces only calls nvme_kill_queues when the
    controller is in the DEAD state.  That can only happen in the PCIe
    driver, and only from nvme_remove. See item 2) above for the
    conditions there.

So it is safe to just remove the call to nvme_start_admin_queue in
nvme_kill_queues without replacement.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 871a8ab7ec199..bb62803de5b21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5135,10 +5135,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
-		nvme_start_admin_queue(ctrl);
-
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
 
-- 
2.30.2

