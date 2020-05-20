Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48457C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 11:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26715207C4
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 11:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5byfl2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgETL52 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 07:57:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgETL52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 07:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589975847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBME5VSXnFGx9scGEIfsYchYGWKkURWlktqEtdC0dks=;
        b=B5byfl2JPPHSXSgqs/6VWGHdOu3U85SrHSRJ1Pf9IGEyZL6363YaaDry16MKkw9lbKy+Jv
        2CU/3txpY9pV9Aom5KKCqW4nOZIHR8gPvQBmYsX70qdo/syEDUOyXwLXTX9ybO8k+8bP8U
        0zawvq8P2To9qTXtSqf52mtF9Qs5voQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-47cSIoHyM5KUADO2tn_ssQ-1; Wed, 20 May 2020 07:57:25 -0400
X-MC-Unique: 47cSIoHyM5KUADO2tn_ssQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BBA18FF660;
        Wed, 20 May 2020 11:57:24 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DFA8707B8;
        Wed, 20 May 2020 11:57:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 3/3] nvme-pci: make nvme reset more reliable
Date:   Wed, 20 May 2020 19:56:55 +0800
Message-Id: <20200520115655.729705-4-ming.lei@redhat.com>
In-Reply-To: <20200520115655.729705-1-ming.lei@redhat.com>
References: <20200520115655.729705-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During waiting for in-flight IO completion in reset handler, timeout
or controller failure still may happen, then the controller is deleted
and all inflight IOs are failed. This way is too violent.

Improve the reset handling by replacing nvme_wait_freeze with query
& check controller. If all ns queues are frozen, the controller is reset
successfully, otherwise check and see if the controller has been disabled.
If yes, break from the current recovery and schedule a fresh new reset.

This way avoids to failing IO & removing controller unnecessarily.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce0d1e79467a..b5aeed33a634 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/delay.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -1235,9 +1236,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * shutdown, so we return BLK_EH_DONE.
 	 */
 	switch (dev->ctrl.state) {
-	case NVME_CTRL_CONNECTING:
-		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-		/* fall through */
 	case NVME_CTRL_DELETING:
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
@@ -2393,7 +2391,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING) {
+		    dev->ctrl.state == NVME_CTRL_RESETTING ||
+		    dev->ctrl.state == NVME_CTRL_CONNECTING) {
 			freeze = true;
 			nvme_start_freeze(&dev->ctrl);
 		}
@@ -2504,12 +2503,29 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
+static bool nvme_wait_freeze_and_check(struct nvme_dev *dev)
+{
+	bool frozen;
+
+	while (true) {
+		frozen = nvme_frozen(&dev->ctrl);
+		if (frozen)
+			break;
+		if (!dev->online_queues)
+			break;
+		msleep(5);
+	}
+
+	return frozen;
+}
+
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev =
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
+	bool reset_done = true;
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
 		result = -ENODEV;
@@ -2606,8 +2622,9 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
-		nvme_dev_add(dev);
+		reset_done = nvme_wait_freeze_and_check(dev);
+		if (reset_done)
+			nvme_dev_add(dev);
 		nvme_unfreeze(&dev->ctrl);
 	}
 
@@ -2622,7 +2639,13 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	nvme_start_ctrl(&dev->ctrl);
+	/* New error happens during reset, so schedule a new reset */
+	if (!reset_done) {
+		dev_warn(dev->ctrl.device, "new error during reset\n");
+		nvme_reset_ctrl(&dev->ctrl);
+	} else {
+		nvme_start_ctrl(&dev->ctrl);
+	}
 	return;
 
  out_unlock:
-- 
2.25.2

