Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923AFC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C8820848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfCENyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:64693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfCENyb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161590"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:29 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 8/8] lightnvm: Inherit mdts from the parent nvme device
Date:   Tue,  5 Mar 2019 14:51:20 +0100
Message-Id: <20190305135120.29284-9-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Current lightnvm and pblk implementation does not care about NVMe max
data transfer size, which can be smaller than 64*K=256K. There are
existing NVMe controllers which NVMe max data transfer size is lower
that 256K (for example 128K, which happens for existing NVMe
controllers which are NVMe spec compliant). Such a controllers are not
able to handle command which contains 64 PPAs, since the the size of
DMAed buffer will be above the capabilities of such a controller.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/core.c      | 9 +++++++--
 drivers/nvme/host/lightnvm.c | 1 +
 include/linux/lightnvm.h     | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5f82036..c01f83b 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	struct nvm_target *t;
 	struct nvm_tgt_dev *tgt_dev;
 	void *targetdata;
+	unsigned int mdts;
 	int ret;
 
 	switch (create->conf.type) {
@@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->private_data = targetdata;
 	tqueue->queuedata = targetdata;
 
-	blk_queue_max_hw_sectors(tqueue,
-			(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
+	mdts = (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
+	if (dev->geo.mdts) {
+		mdts = min_t(u32, dev->geo.mdts,
+				(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
+	}
+	blk_queue_max_hw_sectors(tqueue, mdts);
 
 	set_capacity(tdisk, tt->capacity(targetdata));
 	add_disk(tdisk);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 949e29e..4f20a10 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -977,6 +977,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
 	geo->ext = ns->ext;
+	geo->mdts = ns->ctrl->max_hw_sectors;
 
 	dev->q = q;
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 5d865a5..d3b0270 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -358,6 +358,7 @@ struct nvm_geo {
 	u16	csecs;		/* sector size */
 	u16	sos;		/* out-of-band area size */
 	bool	ext;		/* metadata in extended data buffer */
+	u32	mdts;		/* Max data transfer size*/
 
 	/* device write constrains */
 	u32	ws_min;		/* minimum write size */
-- 
2.9.5

