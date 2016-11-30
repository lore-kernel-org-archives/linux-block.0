Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47323 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757998AbcK3U3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 15:29:34 -0500
From: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH V2 5/5] nvmet: add support for the Write Zeroes command
Date: Wed, 30 Nov 2016 12:29:02 -0800
Message-Id: <1480537742-15190-5-git-send-email-chaitanya.kulkarni@hgst.com>
In-Reply-To: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add support for handling write zeroes command on target.
Call into __blkdev_issue_zeroout, which the block layer expands into the
best suitable variant of zeroing the LBAs. Allow write zeroes operation
to deallocate the LBAs when calling __blkdev_issue_zeroout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 drivers/nvme/target/admin-cmd.c |  3 ++-
 drivers/nvme/target/io-cmd.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fe4c48..ec1ad2a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -237,7 +237,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
 	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
-	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM);
+	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
+			NVME_CTRL_ONCS_WRITE_ZEROES);
 
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index ef52b1e..b3d21b0 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -172,6 +172,32 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_execute_write_zeroes(struct nvmet_req *req)
+{
+	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
+	struct bio *bio = NULL;
+	u16 status = NVME_SC_SUCCESS;
+	sector_t sector;
+	sector_t nr_sector;
+
+	sector = le64_to_cpu(write_zeroes->slba) <<
+		(req->ns->blksize_shift - 9);
+	nr_sector = (((sector_t)le32_to_cpu(write_zeroes->length)) <<
+		(req->ns->blksize_shift - 9)) + 1;
+
+	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
+				GFP_KERNEL, &bio, true))
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+
+	if (bio) {
+		bio->bi_private = req;
+		bio->bi_end_io = nvmet_bio_done;
+		submit_bio(bio);
+	} else {
+		nvmet_req_complete(req, status);
+	}
+}
+
 int nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -209,6 +235,9 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
 		req->data_len = le32_to_cpu(cmd->dsm.nr + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
+	case nvme_cmd_write_zeroes:
+		req->execute = nvmet_execute_write_zeroes;
+		return 0;
 	default:
 		pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-- 
1.8.3.1

