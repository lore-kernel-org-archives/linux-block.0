Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B8C43219
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 10:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiJTK5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 06:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiJTK5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 06:57:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCDA1E09AF
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aFs0HE9gO0EtsI+1aqU/2h60fWe7lmlrgndFaOvNRj8=; b=s1vfLNhiPlK6jVLpVxYFcSB+gR
        Ig2vlUmi3nK/9HnhusSxd1sQQVrgFyYyS2GQwr1RCa0f7LnKoViXXIns9lXkwNgRFrw+MGmEDoYKh
        o8gI/NIo5qJ2MLgt+WaqbHWScP319s7dGai2clUXDidojXO6oXQwuilwqOCxw8uQ9GrOlK1HyVqEo
        jzT2i1eOR83EAAtIyxEslfuds7Gp/qmdulieccSY+Uy3jLiUXPejWyc1PCpSB3b++JvhYoFbqFei7
        HTMhT73YNlYZ0NI/Ryhfsb6qHDSwCuBYK4qzS/6KyqOQ28zhwIWCo5SYL6CxJ7dgqoyr4EH7ImJAC
        jAo3hG9g==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTE4-00DqmB-IQ; Thu, 20 Oct 2022 10:56:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Date:   Thu, 20 Oct 2022 12:56:06 +0200
Message-Id: <20221020105608.1581940-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The NVME_NS_DEAD flag is only set in nvme_set_queue_dying, which is
called in a loop over all namespaces in nvme_kill_queues.  Switch it
to a controller flag checked and set outside said loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 16 +++++++---------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a74212a4f1a5f..fa7fdb744979c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4330,7 +4330,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
-	if (test_bit(NVME_NS_DEAD, &ns->flags))
+	if (test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
 		goto out;
 
 	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
@@ -4404,7 +4404,8 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
+		if (ns->head->ns_id > nsid ||
+		    test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
@@ -5110,9 +5111,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
-	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-		return;
-
 	blk_mark_disk_dead(ns->disk);
 	nvme_start_ns_queue(ns);
 }
@@ -5129,14 +5127,14 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		nvme_start_admin_queue(ctrl);
 
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_set_queue_dying(ns);
-
+	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
+		list_for_each_entry(ns, &ctrl->namespaces, list)
+			nvme_set_queue_dying(ns);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee65..82989a3322130 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= 0,
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
+	NVME_CTRL_NS_DEAD     		= 3,
 };
 
 struct nvme_ctrl {
@@ -483,7 +484,6 @@ struct nvme_ns {
 	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
-#define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
-- 
2.30.2

