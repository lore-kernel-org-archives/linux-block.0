Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38521 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeBEMPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Feb 2018 07:15:41 -0500
Received: by mail-lf0-f68.google.com with SMTP id g72so41381762lfg.5
        for <linux-block@vger.kernel.org>; Mon, 05 Feb 2018 04:15:41 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 4/4] nvme: lightnvm: add late setup of block size and metadata
Date: Mon,  5 Feb 2018 13:15:05 +0100
Message-Id: <20180205121505.27563-5-mb@lightnvm.io>
In-Reply-To: <20180205121505.27563-1-mb@lightnvm.io>
References: <20180205121505.27563-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The nvme driver sets up the size of the nvme namespace in two steps.
First it initializes the device with standard logical block and
metadata sizes, and then sets the correct logical block and metadata
size. Due to the OCSSD 2.0 specification relies on the namespace to
expose these sizes for correct initialization, let it be updated
appropriately on the LightNVM side as well.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/core.c     | 2 ++
 drivers/nvme/host/lightnvm.c | 8 ++++++++
 drivers/nvme/host/nvme.h     | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f837d666cbd4..740ceb28067c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1379,6 +1379,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
 	nvme_update_disk_info(disk, ns, id);
+	if (ns->ndev)
+		nvme_nvm_update_nvm_info(ns);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk)
 		nvme_update_disk_info(ns->head->disk, ns, id);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a9c010655ccc..8d4301854811 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -814,6 +814,14 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
 	}
 }
 
+void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
+{
+	struct nvm_dev *ndev = ns->ndev;
+
+	ndev->identity.csecs = ndev->geo.sec_size = 1 << ns->lba_shift;
+	ndev->identity.sos = ndev->geo.oob_size = ns->ms;
+}
+
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 {
 	struct request_queue *q = ns->queue;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ea1aa5283e8e..1ca08f4993ba 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -451,12 +451,14 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_NVM
+void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
 int nvme_nvm_register_sysfs(struct nvme_ns *ns);
 void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
 int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
 #else
+static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 				    int node)
 {
-- 
2.11.0
