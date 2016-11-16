Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33582 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbcKPGvN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 01:51:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id 144so9293690pfv.0
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2016 22:51:12 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH 5/5] nvmet: add support for the Write Zeroes command
Date: Tue, 15 Nov 2016 22:50:39 -0800
Message-Id: <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
In-Reply-To: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add support for handling write zeroes command on target.
Call into __blkdev_issue_zeroout, which the block layer expands into the
best suitable variant of zeroing the LBAs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 drivers/nvme/target/admin-cmd.c |  3 ++-
 drivers/nvme/target/io-cmd.c    | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

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
index ef52b1e..7d4b022 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -172,6 +172,37 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
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
+				GFP_KERNEL, &bio, false))
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+
+	if (bio) {
+		bio->bi_private = req;
+		bio->bi_end_io = nvmet_bio_done;
+		if (status) {
+			bio->bi_error = -EIO;
+			bio_endio(bio);
+		} else {
+			submit_bio(bio);
+		}
+	} else {
+		nvmet_req_complete(req, status);
+	}
+}
+
 int nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -209,6 +240,9 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
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

