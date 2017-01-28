Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdA1Jcr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 04:32:47 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/5] nvme/scsi: don't rely on BLK_MAX_CDB
Date: Sat, 28 Jan 2017 09:32:49 +0100
Message-Id: <1485592373-29837-2-git-send-email-hch@lst.de>
In-Reply-To: <1485592373-29837-1-git-send-email-hch@lst.de>
References: <1485592373-29837-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The NVMe SCSI emulation doesn't use BLOCK_PC requests, so BLK_MAX_CDB
doesn't have a meaning for it.  Instead opencode the value of 16
and refactor the code a bit so that related checks are next to each
other and we only need to use the value in one place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index a5c09e7..0a5687a 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -2347,12 +2347,14 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 {
-	u8 cmd[BLK_MAX_CDB];
+	u8 cmd[16];
 	int retcode;
 	unsigned int opcode;
 
 	if (hdr->cmdp == NULL)
 		return -EMSGSIZE;
+	if (hdr->cmd_len > sizeof(cmd))
+		return -EINVAL;
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
 
@@ -2451,8 +2453,6 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr)
 		return -EFAULT;
 	if (hdr.interface_id != 'S')
 		return -EINVAL;
-	if (hdr.cmd_len > BLK_MAX_CDB)
-		return -EINVAL;
 
 	/*
 	 * A positive return code means a NVMe status, which has been
-- 
2.1.4

