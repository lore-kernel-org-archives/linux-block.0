Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46387 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeC2WH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:26 -0400
Received: by mail-lf0-f66.google.com with SMTP id j68-v6so10302841lfg.13
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:25 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 25/37] lightnvm: add shorten OCSSD version in geo
Date: Fri, 30 Mar 2018 00:05:12 +0200
Message-Id: <20180329220524.30363-26-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Create a shorten version to use in the generic geometry.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 6 ++++++
 include/linux/lightnvm.h     | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index de4105544956..f7f7769e7588 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -299,6 +299,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	geo->major_ver_id = id->ver_id;
 	geo->minor_ver_id = 2;
 
+	/* Set compacted version for upper layers */
+	geo->version = NVM_OCSSD_SPEC_12;
+
 	geo->nr_chnls = src->num_ch;
 	geo->nr_luns = src->num_lun;
 	geo->all_luns = geo->nr_chnls * geo->nr_luns;
@@ -384,6 +387,9 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	geo->major_ver_id = id->mjr;
 	geo->minor_ver_id = id->mnr;
 
+	/* Set compacted version for upper layers */
+	geo->version = NVM_OCSSD_SPEC_20;
+
 	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
 		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
 				geo->major_ver_id, geo->minor_ver_id);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 7ed8b92d6744..a073c0c76260 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -23,6 +23,11 @@ enum {
 #define NVM_LUN_BITS (8)
 #define NVM_CH_BITS  (7)
 
+enum {
+	NVM_OCSSD_SPEC_12 = 12,
+	NVM_OCSSD_SPEC_20 = 20,
+};
+
 struct ppa_addr {
 	/* Generic structure for all addresses */
 	union {
@@ -266,6 +271,9 @@ struct nvm_geo {
 	u8	major_ver_id;
 	u8	minor_ver_id;
 
+	/* kernel short version */
+	u8	version;
+
 	/* instance specific geometry */
 	int nr_chnls;
 	int nr_luns;		/* per channel */
-- 
2.11.0
