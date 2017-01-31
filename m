Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:53760
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751992AbdAaMSM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:18:12 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 07/12] lightnvm: reduce number of nvm_id groups to one
Date: Tue, 31 Jan 2017 13:17:15 +0100
Message-ID: <20170131121720.10971-8-matias@cnexlabs.com>
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The number of configuration groups has been limited to one in current
code, even if there is support for up to four. With the introduction
of the open-channel SSD 1.3 specification, only a single
group is exposed onwards. Reflect this in the nvm_id structure.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/block/null_blk.c     |  3 +-
 drivers/lightnvm/core.c      | 12 ++----
 drivers/nvme/host/lightnvm.c | 87 +++++++++++++++++++++-----------------------
 include/linux/lightnvm.h     |  3 +-
 4 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index c0e14e5..e666095 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -460,7 +460,6 @@ static int null_lnvm_id(struct nvm_dev *dev, struct nvm_id *id)
 
 	id->ver_id = 0x1;
 	id->vmnt = 0;
-	id->cgrps = 1;
 	id->cap = 0x2;
 	id->dom = 0x1;
 
@@ -479,7 +478,7 @@ static int null_lnvm_id(struct nvm_dev *dev, struct nvm_id *id)
 
 	sector_div(size, bs); /* convert size to pages */
 	size >>= 8; /* concert size to pgs pr blk */
-	grp = &id->groups[0];
+	grp = &id->grp;
 	grp->mtype = 0;
 	grp->fmtype = 0;
 	grp->num_ch = 1;
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 0842c85..80cd767 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -884,7 +884,7 @@ static int nvm_init_mlc_tbl(struct nvm_dev *dev, struct nvm_id_group *grp)
 static int nvm_core_init(struct nvm_dev *dev)
 {
 	struct nvm_id *id = &dev->identity;
-	struct nvm_id_group *grp = &id->groups[0];
+	struct nvm_id_group *grp = &id->grp;
 	struct nvm_geo *geo = &dev->geo;
 	int ret;
 
@@ -988,20 +988,14 @@ static int nvm_init(struct nvm_dev *dev)
 		goto err;
 	}
 
-	pr_debug("nvm: ver:%x nvm_vendor:%x groups:%u\n",
-			dev->identity.ver_id, dev->identity.vmnt,
-							dev->identity.cgrps);
+	pr_debug("nvm: ver:%x nvm_vendor:%x\n",
+			dev->identity.ver_id, dev->identity.vmnt);
 
 	if (dev->identity.ver_id != 1) {
 		pr_err("nvm: device not supported by kernel.");
 		goto err;
 	}
 
-	if (dev->identity.cgrps != 1) {
-		pr_err("nvm: only one group configuration supported.");
-		goto err;
-	}
-
 	ret = nvm_core_init(dev);
 	if (ret) {
 		pr_err("nvm: could not initialize core structures.\n");
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ad54ec9..733992a 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -248,50 +248,48 @@ static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
 {
 	struct nvme_nvm_id_group *src;
 	struct nvm_id_group *dst;
-	int i, end;
-
-	end = min_t(u32, 4, nvm_id->cgrps);
-
-	for (i = 0; i < end; i++) {
-		src = &nvme_nvm_id->groups[i];
-		dst = &nvm_id->groups[i];
-
-		dst->mtype = src->mtype;
-		dst->fmtype = src->fmtype;
-		dst->num_ch = src->num_ch;
-		dst->num_lun = src->num_lun;
-		dst->num_pln = src->num_pln;
-
-		dst->num_pg = le16_to_cpu(src->num_pg);
-		dst->num_blk = le16_to_cpu(src->num_blk);
-		dst->fpg_sz = le16_to_cpu(src->fpg_sz);
-		dst->csecs = le16_to_cpu(src->csecs);
-		dst->sos = le16_to_cpu(src->sos);
-
-		dst->trdt = le32_to_cpu(src->trdt);
-		dst->trdm = le32_to_cpu(src->trdm);
-		dst->tprt = le32_to_cpu(src->tprt);
-		dst->tprm = le32_to_cpu(src->tprm);
-		dst->tbet = le32_to_cpu(src->tbet);
-		dst->tbem = le32_to_cpu(src->tbem);
-		dst->mpos = le32_to_cpu(src->mpos);
-		dst->mccap = le32_to_cpu(src->mccap);
-
-		dst->cpar = le16_to_cpu(src->cpar);
-
-		if (dst->fmtype == NVM_ID_FMTYPE_MLC) {
-			memcpy(dst->lptbl.id, src->lptbl.id, 8);
-			dst->lptbl.mlc.num_pairs =
-					le16_to_cpu(src->lptbl.mlc.num_pairs);
-
-			if (dst->lptbl.mlc.num_pairs > NVME_NVM_LP_MLC_PAIRS) {
-				pr_err("nvm: number of MLC pairs not supported\n");
-				return -EINVAL;
-			}
-
-			memcpy(dst->lptbl.mlc.pairs, src->lptbl.mlc.pairs,
-						dst->lptbl.mlc.num_pairs);
+
+	if (nvme_nvm_id->cgrps != 1)
+		return -EINVAL;
+
+	src = &nvme_nvm_id->groups[0];
+	dst = &nvm_id->grp;
+
+	dst->mtype = src->mtype;
+	dst->fmtype = src->fmtype;
+	dst->num_ch = src->num_ch;
+	dst->num_lun = src->num_lun;
+	dst->num_pln = src->num_pln;
+
+	dst->num_pg = le16_to_cpu(src->num_pg);
+	dst->num_blk = le16_to_cpu(src->num_blk);
+	dst->fpg_sz = le16_to_cpu(src->fpg_sz);
+	dst->csecs = le16_to_cpu(src->csecs);
+	dst->sos = le16_to_cpu(src->sos);
+
+	dst->trdt = le32_to_cpu(src->trdt);
+	dst->trdm = le32_to_cpu(src->trdm);
+	dst->tprt = le32_to_cpu(src->tprt);
+	dst->tprm = le32_to_cpu(src->tprm);
+	dst->tbet = le32_to_cpu(src->tbet);
+	dst->tbem = le32_to_cpu(src->tbem);
+	dst->mpos = le32_to_cpu(src->mpos);
+	dst->mccap = le32_to_cpu(src->mccap);
+
+	dst->cpar = le16_to_cpu(src->cpar);
+
+	if (dst->fmtype == NVM_ID_FMTYPE_MLC) {
+		memcpy(dst->lptbl.id, src->lptbl.id, 8);
+		dst->lptbl.mlc.num_pairs =
+				le16_to_cpu(src->lptbl.mlc.num_pairs);
+
+		if (dst->lptbl.mlc.num_pairs > NVME_NVM_LP_MLC_PAIRS) {
+			pr_err("nvm: number of MLC pairs not supported\n");
+			return -EINVAL;
 		}
+
+		memcpy(dst->lptbl.mlc.pairs, src->lptbl.mlc.pairs,
+					dst->lptbl.mlc.num_pairs);
 	}
 
 	return 0;
@@ -321,7 +319,6 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id *nvm_id)
 
 	nvm_id->ver_id = nvme_nvm_id->ver_id;
 	nvm_id->vmnt = nvme_nvm_id->vmnt;
-	nvm_id->cgrps = nvme_nvm_id->cgrps;
 	nvm_id->cap = le32_to_cpu(nvme_nvm_id->cap);
 	nvm_id->dom = le32_to_cpu(nvme_nvm_id->dom);
 	memcpy(&nvm_id->ppaf, &nvme_nvm_id->ppaf,
@@ -622,7 +619,7 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 		return 0;
 
 	id = &ndev->identity;
-	grp = &id->groups[0];
+	grp = &id->grp;
 	attr = &dattr->attr;
 
 	if (strcmp(attr->name, "version") == 0) {
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index faa0fbf..ce0b2da 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -200,11 +200,10 @@ struct nvm_addr_format {
 struct nvm_id {
 	u8	ver_id;
 	u8	vmnt;
-	u8	cgrps;
 	u32	cap;
 	u32	dom;
 	struct nvm_addr_format ppaf;
-	struct nvm_id_group groups[4];
+	struct nvm_id_group grp;
 } __packed;
 
 struct nvm_target {
-- 
2.9.3

