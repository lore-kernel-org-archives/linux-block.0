Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FD0C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 10:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJTK5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJTK5R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 06:57:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F2A52C4
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=W+GxbU8XddRKisDnJi5ZsT+m92/bzA7OGk+xp+QKoLQ=; b=HlaJlLNCJqPfFjRx2y2pnEqFHe
        6lgnkABvWfIFMt6AW2V7n9vVSgO0RSc+xyLYPa4pufnpZwIk1Oz73MWnkOM0NzDOXPig64cO5UaJw
        8Q6BczVENaiaWkLEHTxYRWdS4cDpKzxU0hPuhY3hlm8YTbHYuj/M6N2S+rVjNVvs1+mHvcIL8T79d
        MDpwPiq4tUnhi59PPtktSUZr31tYw++1PdAHshw+DeRR1guLUOfFPLhxqKvxxbszDcW7JuEZxdk0y
        QBj+/6U1jmePm48eyAhgUYi2dvHenfvIoG81V1smPZ1aeo8Ke5eojVAG150HfFVfu+wuWU2c8men+
        ICXQWA6w==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTEB-00DqrG-No; Thu, 20 Oct 2022 10:56:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Date:   Thu, 20 Oct 2022 12:56:07 +0200
Message-Id: <20221020105608.1581940-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This helper is pretty pointless now, and also in the way of per-tagset
quiesce.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7fdb744979c..0ab3a18fd9f85 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5104,17 +5104,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 		blk_mq_wait_quiesce_done(ns->queue->tag_set);
 }
 
-/*
- * Prepare a queue for teardown.
- *
- * This must forcibly unquiesce queues to avoid blocking dispatch.
- */
-static void nvme_set_queue_dying(struct nvme_ns *ns)
-{
-	blk_mark_disk_dead(ns->disk);
-	nvme_start_ns_queue(ns);
-}
-
 /**
  * nvme_kill_queues(): Ends all namespace queues
  * @ctrl: the dead controller that needs to end
@@ -5130,10 +5119,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		nvme_start_admin_queue(ctrl);
-
 	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
-		list_for_each_entry(ns, &ctrl->namespaces, list)
-			nvme_set_queue_dying(ns);
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			blk_mark_disk_dead(ns->disk);
+			nvme_start_ns_queue(ns);
+		}
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
-- 
2.30.2

