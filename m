Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D487C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C3120848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfCENy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:64693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfCENy2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161584"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:27 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 7/8] lightnvm: pblk: warn about opened chunk on factory init
Date:   Tue,  5 Mar 2019 14:51:19 +0100
Message-Id: <20190305135120.29284-8-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we creating pblk instance with factory flag, there is a
possibility that some chunks are in open state, which does not allow
to issue erase request to them directly, based on OCSSD 2.0 spec.
Still most of the controllers allows for such a transition, but it is
not guaranteed that the particular drive will do so. This patch adds
the proper warning during pblk factory creation to let user know about
number of chunks in such a state, which can potentially be a reason
of erase failures.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c | 14 ++++++++++++++
 drivers/lightnvm/pblk-init.c | 14 +++++++++++---
 drivers/lightnvm/pblk.h      |  1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 64280e6..4f16596 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -161,6 +161,20 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
 	return meta + ch_off + lun_off + chk_off;
 }
 
+int pblk_count_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *meta)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int i, cnt = 0;
+
+	for (i = 0; i < geo->all_luns; i++) {
+		if (meta[i].state == NVM_CHK_ST_OPEN)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
 			   u64 paddr)
 {
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 97b4c6e..f590f62 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1028,12 +1028,12 @@ static int pblk_line_meta_init(struct pblk *pblk)
 	return 0;
 }
 
-static int pblk_lines_init(struct pblk *pblk)
+static int pblk_lines_init(struct pblk *pblk, bool factory_init)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *line;
 	void *chunk_meta;
-	int nr_free_chks = 0;
+	int nr_free_chks = 0, nr_opened_chks;
 	int i, ret;
 
 	ret = pblk_line_meta_init(pblk);
@@ -1054,6 +1054,14 @@ static int pblk_lines_init(struct pblk *pblk)
 		goto fail_free_luns;
 	}
 
+	if (factory_init) {
+		nr_opened_chks = pblk_count_opened_chunks(pblk, chunk_meta);
+		if (nr_opened_chks) {
+			pblk_warn(pblk, "There are %d opened chunks\n",
+				  nr_opened_chks);
+		}
+	}
+
 	pblk->lines = kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
 								GFP_KERNEL);
 	if (!pblk->lines) {
@@ -1245,7 +1253,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		goto fail;
 	}
 
-	ret = pblk_lines_init(pblk);
+	ret = pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
 	if (ret) {
 		pblk_err(pblk, "could not initialize lines\n");
 		goto fail_free_core;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 6c82776..c2f07ec 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -795,6 +795,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk);
 struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
 					      struct nvm_chk_meta *lp,
 					      struct ppa_addr ppa);
+int pblk_count_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *_meta);
 void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
-- 
2.9.5

