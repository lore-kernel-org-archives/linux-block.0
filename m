Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42805 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbeBUJ1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:20 -0500
Received: by mail-wr0-f195.google.com with SMTP id k9so2432255wre.9
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:20 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 09/20] lightnvm: use generic identify structure
Date: Wed, 21 Feb 2018 10:26:47 +0100
Message-Id: <1519205218-26994-10-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Create a generic identify structure to collect the identify information
before knowing the spec. version. This forces different version paths to
cast the structure to their spec structure, thus making the code less
error prone and more maintainable.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 9c1f8225c4e1..70dc4740f0d3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -170,6 +170,12 @@ struct nvme_nvm_id12 {
 	__u8			resv2[2880];
 } __packed;
 
+/* Generic identification structure */
+struct nvme_nvm_id {
+	__u8			ver_id;
+	__u8			resv[4095];
+} __packed;
+
 struct nvme_nvm_bb_tbl {
 	__u8	tblid[4];
 	__le16	verid;
@@ -279,9 +285,10 @@ static void nvme_nvm_set_addr_12(struct nvm_addr_format_12 *dst,
 	dst->sec_mask = ((1ULL << dst->sec_len) - 1) << dst->sec_offset;
 }
 
-static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
+static int nvme_nvm_setup_12(struct nvme_nvm_id *gen_id,
 			     struct nvm_dev_geo *dev_geo)
 {
+	struct nvme_nvm_id12 *id = (struct nvme_nvm_id12 *)gen_id;
 	struct nvme_nvm_id12_grp *src;
 	int sec_per_pg, sec_per_pl, pg_per_blk;
 
@@ -380,9 +387,11 @@ static void nvme_nvm_set_addr_20(struct nvm_addr_format *dst,
 	dst->sec_mask = ((1ULL << dst->sec_len) - 1) << dst->sec_offset;
 }
 
-static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
+static int nvme_nvm_setup_20(struct nvme_nvm_id *gen_id,
 			     struct nvm_dev_geo *dev_geo)
 {
+	struct nvme_nvm_id20 *id = (struct nvme_nvm_id20 *)gen_id;
+
 	dev_geo->major_ver_id = id->mjr;
 	dev_geo->minor_ver_id = id->mnr;
 
@@ -427,19 +436,19 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 static int nvme_nvm_identity(struct nvm_dev *nvmdev)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
-	struct nvme_nvm_id12 *id;
+	struct nvme_nvm_id *nvme_nvm_id;
 	struct nvme_nvm_command c = {};
 	int ret;
 
 	c.identity.opcode = nvme_nvm_admin_identity;
 	c.identity.nsid = cpu_to_le32(ns->head->ns_id);
 
-	id = kmalloc(sizeof(struct nvme_nvm_id12), GFP_KERNEL);
-	if (!id)
+	nvme_nvm_id = kmalloc(sizeof(struct nvme_nvm_id), GFP_KERNEL);
+	if (!nvme_nvm_id)
 		return -ENOMEM;
 
 	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, (struct nvme_command *)&c,
-				id, sizeof(struct nvme_nvm_id12));
+				nvme_nvm_id, sizeof(struct nvme_nvm_id));
 	if (ret) {
 		ret = -EIO;
 		goto out;
@@ -449,22 +458,21 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev)
 	 * The 1.2 and 2.0 specifications share the first byte in their geometry
 	 * command to make it possible to know what version a device implements.
 	 */
-	switch (id->ver_id) {
+	switch (nvme_nvm_id->ver_id) {
 	case 1:
-		ret = nvme_nvm_setup_12(id, &nvmdev->dev_geo);
+		ret = nvme_nvm_setup_12(nvme_nvm_id, &nvmdev->dev_geo);
 		break;
 	case 2:
-		ret = nvme_nvm_setup_20((struct nvme_nvm_id20 *)id,
-							&nvmdev->dev_geo);
+		ret = nvme_nvm_setup_20(nvme_nvm_id, &nvmdev->dev_geo);
 		break;
 	default:
 		dev_err(ns->ctrl->device, "OCSSD revision not supported (%d)\n",
-							id->ver_id);
+							nvme_nvm_id->ver_id);
 		ret = -EINVAL;
 	}
 
 out:
-	kfree(id);
+	kfree(nvme_nvm_id);
 	return ret;
 }
 
-- 
2.7.4
