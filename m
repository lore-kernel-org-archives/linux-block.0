Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A42C433DF
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0985020715
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTpvQu7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgE3Nw6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 09:52:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43959 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbgE3Nw6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 09:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590846775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNnr3qLTdHB28Ad+/AEnpk05q0jlMEs2ygmx4qV3lRM=;
        b=QTpvQu7lyC6EykeGX28985pYx/fC9ZwTMis3uk2LxwQvn86LuFc3iJq8EDb7FJp7c5g6Da
        e3QVUdloKbpLZhpgxCn8wvqhsCDVFco9jm2uDTw7VFtcamMgLq//UxNeD7gqxRKPCSW/4S
        xghV++RC/9ZZK4cZkVBh591AJvyxlXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-lLoCN4SXMfKt5oYqy0ODtA-1; Sat, 30 May 2020 09:52:50 -0400
X-MC-Unique: lLoCN4SXMfKt5oYqy0ODtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EDFB18FE860;
        Sat, 30 May 2020 13:52:49 +0000 (UTC)
Received: from localhost (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B04046ACF8;
        Sat, 30 May 2020 13:52:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH V2 3/3] nvme-pci: make nvme reset more reliable
Date:   Sat, 30 May 2020 21:52:21 +0800
Message-Id: <20200530135221.1152749-4-ming.lei@redhat.com>
In-Reply-To: <20200530135221.1152749-1-ming.lei@redhat.com>
References: <20200530135221.1152749-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During waiting for in-flight IO completion in reset handler, timeout
or controller failure still may happen, then the controller is deleted
and all inflight IOs are failed. This way is too violent: 1) the timeout
may be triggered exactly during nvme_wait_freeze() after controller is
recovered by one occasional event; 2) the claimed retry times isn't
respected.

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
 drivers/nvme/host/core.c |  3 ++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 50 +++++++++++++++++++++++++++++++++-------
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 469010607383..f4a00a85a47e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -45,9 +45,10 @@ static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
-static u8 nvme_max_retries = 5;
+u8 nvme_max_retries = 5;
 module_param_named(max_retries, nvme_max_retries, byte, 0644);
 MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
+EXPORT_SYMBOL_GPL(nvme_max_retries);
 
 static unsigned long default_ps_max_latency_us = 100000;
 module_param(default_ps_max_latency_us, ulong, 0644);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 459e5952ff5f..ba4c84f16a0b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -25,6 +25,8 @@ extern unsigned int nvme_io_timeout;
 extern unsigned int admin_timeout;
 #define ADMIN_TIMEOUT	(admin_timeout * HZ)
 
+extern u8 nvme_max_retries;
+
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e13c370de830..9b75f1d855f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/delay.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -106,6 +107,7 @@ struct nvme_dev {
 	unsigned long bar_mapped_size;
 	struct work_struct remove_work;
 	struct mutex shutdown_lock;
+	int successive_shutdown;
 	bool subsystem;
 	u64 cmb_size;
 	bool cmb_use_sqes;
@@ -1243,9 +1245,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * shutdown, so we return BLK_EH_DONE.
 	 */
 	switch (dev->ctrl.state) {
-	case NVME_CTRL_CONNECTING:
-		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-		/* fall through */
 	case NVME_CTRL_DELETING:
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
@@ -2383,11 +2382,13 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
+	dev->successive_shutdown++;
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING) {
+		    dev->ctrl.state == NVME_CTRL_RESETTING ||
+		    dev->ctrl.state == NVME_CTRL_CONNECTING) {
 			freeze = true;
 			nvme_start_freeze(&dev->ctrl);
 		}
@@ -2498,12 +2499,34 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
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
+
+		/*
+		 * controller may has been shutdown because of new timeout, so
+		 * break from the loop and report the event to reset handler.
+		 */
+		if (!dev->online_queues)
+			break;
+		msleep(3);
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
@@ -2600,23 +2623,34 @@ static void nvme_reset_work(struct work_struct *work)
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
 
 	/*
 	 * If only admin queue live, keep it to do further investigation or
 	 * recovery.
+	 *
+	 * Or we can't move on after retrying enough times.
 	 */
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE) ||
+	    (!reset_done && dev->successive_shutdown >= nvme_max_retries)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller live state\n");
 		result = -ENODEV;
 		goto out;
 	}
 
-	nvme_start_ctrl(&dev->ctrl);
+	/* New error happens during reset, so schedule a new reset */
+	if (!reset_done) {
+		dev_warn(dev->ctrl.device, "new error during reset\n");
+		nvme_reset_ctrl(&dev->ctrl);
+	} else {
+		dev->successive_shutdown = 0;
+		nvme_start_ctrl(&dev->ctrl);
+	}
 	return;
 
  out_unlock:
-- 
2.25.2

