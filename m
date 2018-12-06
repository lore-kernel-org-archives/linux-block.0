Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0318AC65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60D120850
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60D120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeLFQsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:48:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44120 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeLFQsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:48:24 -0500
Received: from [191.13.27.189] (helo=calabresa.spo.virtua.com.br)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gUwp4-0000io-90; Thu, 06 Dec 2018 16:48:22 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/4] nvme: create slaves/holder entries for multipath devices
Date:   Thu,  6 Dec 2018 14:48:10 -0200
Message-Id: <20181206164812.30925-3-cascardo@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206164812.30925-1-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This allows tools like distro installers easily track the relationship.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[cascardo: only add disk when there is ns->head]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 drivers/nvme/host/core.c      |  5 +++--
 drivers/nvme/host/multipath.c | 13 +++++++++++--
 drivers/nvme/host/nvme.h      | 12 ++++++++----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ce7fc9df378..1dc29795f1ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -371,7 +371,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	nvme_mpath_remove_nshead(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
 	cleanup_srcu_struct_quiesced(&head->srcu);
@@ -3120,7 +3120,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
 
-	nvme_mpath_add_disk(ns, id);
+	nvme_mpath_add_ns(ns, id);
 	nvme_fault_inject_init(ns);
 	kfree(id);
 
@@ -3144,6 +3144,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+		nvme_mpath_remove_ns(ns);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 		if (blk_get_integrity(ns->disk))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ec310b1b9267..174c64643592 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -500,7 +500,7 @@ static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
+void nvme_mpath_add_ns(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		mutex_lock(&ns->ctrl->ana_lock);
@@ -513,9 +513,18 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		nvme_mpath_set_live(ns);
 		mutex_unlock(&ns->head->lock);
 	}
+
+	if (ns->head->disk)
+		bd_link_disk_holder(&ns->disk->part0, ns->head->disk);
+}
+
+void nvme_mpath_remove_ns(struct nvme_ns *ns)
+{
+	if (ns->head->disk)
+		bd_unlink_disk_holder(&ns->disk->part0, ns->head->disk);
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_remove_nshead(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae77eb16fd1f..365262d11e53 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -470,8 +470,9 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
-void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_ns(struct nvme_ns *ns, struct nvme_id_ns *id);
+void nvme_mpath_remove_ns(struct nvme_ns *ns);
+void nvme_mpath_remove_nshead(struct nvme_ns_head *head);
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
@@ -515,11 +516,14 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 {
 	return 0;
 }
-static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
+static inline void nvme_mpath_add_ns(struct nvme_ns *ns,
 		struct nvme_id_ns *id)
 {
 }
-static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_remove_ns(struct nvme_ns *ns)
+{
+}
+static inline void nvme_mpath_remove_nshead(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
-- 
2.19.1

