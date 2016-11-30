Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16841 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757922AbcK3U3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 15:29:34 -0500
From: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH V2 4/5] nvme: add support for the Write Zeroes command
Date: Wed, 30 Nov 2016 12:29:01 -0800
Message-Id: <1480537742-15190-4-git-send-email-chaitanya.kulkarni@hgst.com>
In-Reply-To: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Allow write zeroes operations (REQ_OP_WRITE_ZEROES) on the block
device, if the device supports optional command bit set for write
zeroes. Add support to setup write zeroes command. Set maximum possible
write zeroes sectors in one write zeroes command according to
nvme write zeroes command definition.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 44f8a53..16a315d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -272,6 +272,21 @@ static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_MQ_RQ_QUEUE_OK;
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
+	if (ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES)
+		blk_queue_max_write_zeroes_sectors(ns->queue,
+				((u32)(USHRT_MAX + 1) * bs) >> 9);
+
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-- 
1.8.3.1

