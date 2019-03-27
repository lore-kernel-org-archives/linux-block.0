Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A11C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22FB2087C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfC0MmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:42:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:33640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbfC0MmE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 08:42:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 05:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="137680447"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2019 05:42:01 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v3 06/10] lightnvm: pblk: remove internal IO timeout
Date:   Wed, 27 Mar 2019 13:38:57 +0100
Message-Id: <20190327123901.12323-7-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190327123901.12323-1-igor.j.konopko@intel.com>
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently during pblk padding, there is internal IO timeout introduced,
which is smaller than default NVMe timeout. This can lead to various
use-after-free issues. Since in case of any IO timeouts NVMe and block
layer will handle timeout by themselves and report it back to use,
there is no need to keep this internal timeout in pblk.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 7 +------
 drivers/lightnvm/pblk.h          | 2 --
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 6765d7c..a9085b0 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -290,12 +290,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 
 fail_complete:
 	kref_put(&pad_rq->ref, pblk_recov_complete);
-
-	if (!wait_for_completion_io_timeout(&pad_rq->wait,
-				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
-		pblk_err(pblk, "pad write timed out\n");
-		ret = -ETIME;
-	}
+	wait_for_completion(&pad_rq->wait);
 
 	if (!pblk_line_is_full(line))
 		pblk_err(pblk, "corrupted padded line: %d\n", line->id);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index e284a93..3a84c8a 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -43,8 +43,6 @@
 
 #define PBLK_CACHE_NAME_LEN (DISK_NAME_LEN + 16)
 
-#define PBLK_COMMAND_TIMEOUT_MS 30000
-
 /* Max 512 LUNs per device */
 #define PBLK_MAX_LUNS_BITMAP (4)
 
-- 
2.9.5

