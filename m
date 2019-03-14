Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB18DC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0AC2184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCNQJF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:25400 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQJF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073285"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:09:03 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 14/18] lightnvm: pblk: GC error handling
Date:   Thu, 14 Mar 2019 17:04:24 +0100
Message-Id: <20190314160428.3559-15-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when there is an IO error (or similar) on GC read path, pblk
still moves this line to free state, what leads to data mismatch issue.

This patch adds a handling for such an error - after that changes this
line will be returned to closed state so it can be still in use
for reading - at least we will be able to return error status to user
when user tries to read such a data.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c | 8 ++++++++
 drivers/lightnvm/pblk-gc.c   | 5 ++---
 drivers/lightnvm/pblk-read.c | 1 -
 drivers/lightnvm/pblk.h      | 2 ++
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 4d5cd99..6817f8f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1786,6 +1786,14 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
+	if (line->w_err_gc->has_gc_err) {
+		spin_unlock(&line->lock);
+		pblk_err(pblk, "line %d had errors during GC\n", line->id);
+		pblk_put_line_back(pblk, line);
+		line->w_err_gc->has_gc_err = 0;
+		return;
+	}
+
 	line->state = PBLK_LINESTATE_FREE;
 	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 					line->state);
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index e23b192..63ee205 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -59,7 +59,7 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
 	wake_up_process(gc->gc_writer_ts);
 }
 
-static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
+void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct list_head *move_list;
@@ -98,8 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
 	/* Read from GC victim block */
 	ret = pblk_submit_read_gc(pblk, gc_rq);
 	if (ret) {
-		pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
-								line->id, ret);
+		line->w_err_gc->has_gc_err = 1;
 		goto out;
 	}
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 54422a2..6a77c24 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -475,7 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 	if (pblk_submit_io_sync(pblk, &rqd)) {
 		ret = -EIO;
-		pblk_err(pblk, "GC read request failed\n");
 		goto err_free_bio;
 	}
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 5d1040a..52002f5 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -427,6 +427,7 @@ struct pblk_smeta {
 
 struct pblk_w_err_gc {
 	int has_write_err;
+	int has_gc_err;
 	__le64 *lba_list;
 };
 
@@ -909,6 +910,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk);
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
 			      int *gc_active);
 int pblk_gc_sysfs_force(struct pblk *pblk, int force);
+void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line);
 
 /*
  * pblk rate limiter
-- 
2.9.5

