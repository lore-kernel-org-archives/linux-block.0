Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C320C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEBA20848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCENyU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:64693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfCENyU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161551"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:18 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 3/8] lightnvm: pblk: Count all read errors in stats
Date:   Tue,  5 Mar 2019 14:51:15 +0100
Message-Id: <20190305135120.29284-4-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when unknown error occurs on read path there is only dmesg
information about it, but it is not counted in sysfs statistics.

We would also like to track the number of such a requests, so new type
of counter 'read_ctrl_errors" is added in that patch.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c  | 1 +
 drivers/lightnvm/pblk-init.c  | 1 +
 drivers/lightnvm/pblk-sysfs.c | 3 ++-
 drivers/lightnvm/pblk.h       | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 39280c1..64280e6 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd)
 		atomic_long_inc(&pblk->read_failed);
 		break;
 	default:
+		atomic_long_inc(&pblk->read_ctrl_errors);
 		pblk_err(pblk, "unknown read error:%d\n", rqd->error);
 	}
 #ifdef CONFIG_NVM_PBLK_DEBUG
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 81e8ed4..f4b6d8f2 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1230,6 +1230,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	atomic_long_set(&pblk->read_empty, 0);
 	atomic_long_set(&pblk->read_high_ecc, 0);
 	atomic_long_set(&pblk->read_failed_gc, 0);
+	atomic_long_set(&pblk->read_ctrl_errors, 0);
 	atomic_long_set(&pblk->write_failed, 0);
 	atomic_long_set(&pblk->erase_failed, 0);
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 7d8958d..922273c 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -94,11 +94,12 @@ static ssize_t pblk_sysfs_stats(struct pblk *pblk, char *page)
 	ssize_t sz;
 
 	sz = snprintf(page, PAGE_SIZE,
-			"read_failed=%lu, read_high_ecc=%lu, read_empty=%lu, read_failed_gc=%lu, write_failed=%lu, erase_failed=%lu\n",
+			"read_failed=%lu, read_high_ecc=%lu, read_empty=%lu, read_failed_gc=%lu, read_ctrl_errors=%lu, write_failed=%lu, erase_failed=%lu\n",
 			atomic_long_read(&pblk->read_failed),
 			atomic_long_read(&pblk->read_high_ecc),
 			atomic_long_read(&pblk->read_empty),
 			atomic_long_read(&pblk->read_failed_gc),
+			atomic_long_read(&pblk->read_ctrl_errors),
 			atomic_long_read(&pblk->write_failed),
 			atomic_long_read(&pblk->erase_failed));
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 381f074..6c82776 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -684,6 +684,7 @@ struct pblk {
 	atomic_long_t read_empty;
 	atomic_long_t read_high_ecc;
 	atomic_long_t read_failed_gc;
+	atomic_long_t read_ctrl_errors;
 	atomic_long_t write_failed;
 	atomic_long_t erase_failed;
 
-- 
2.9.5

