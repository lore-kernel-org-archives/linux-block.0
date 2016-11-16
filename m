Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33926 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbcKPGvK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 01:51:10 -0500
Received: by mail-pf0-f193.google.com with SMTP id y68so9295279pfb.1
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2016 22:51:10 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH 4/5] nvme: add support for the Write Zeroes command
Date: Tue, 15 Nov 2016 22:50:38 -0800
Message-Id: <1479279039-25818-5-git-send-email-chaitanya.kulkarni@hgst.com>
In-Reply-To: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Allow write zeroes operations (REQ_OP_WRITE_ZEROES) on the queue
if device supports optinal command bit set for write zeroes.
Add support to setup write zeroes command.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3fcd1f4..d1ebb2c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -272,6 +272,21 @@ static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return 0;
 }
 
+static inline void nvme_setup_write_zeroes(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd)
+{
+	struct nvme_write_zeroes_cmd *write_zeroes = &cmnd->write_zeroes;
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	write_zeroes->opcode = nvme_cmd_write_zeroes;
+	write_zeroes->nsid = cpu_to_le32(ns->ns_id);
+	write_zeroes->slba =
+		cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	write_zeroes->length =
+		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	write_zeroes->control = 0;
+}
+
 static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -325,6 +340,8 @@ int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		nvme_setup_flush(ns, cmd);
 	else if (req_op(req) == REQ_OP_DISCARD)
 		ret = nvme_setup_discard(ns, req, cmd);
+	else if (req_op(req) == REQ_OP_WRITE_ZEROES)
+		nvme_setup_write_zeroes(ns, req, cmd);
 	else
 		nvme_setup_rw(ns, req, cmd);
 
@@ -943,6 +960,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 
 	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
+
+	if (ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES)
+		queue_flag_set_unlocked(QUEUE_FLAG_WRITE_ZEROES, ns->queue);
+
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-- 
1.8.3.1

