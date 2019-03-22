Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3DCC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AF020883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfCVOwS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:52:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:1170 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbfCVOwS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:52:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593334"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:52:16 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 08/16] lightnvm: pblk: remove internal IO timeout
Date:   Fri, 22 Mar 2019 15:48:35 +0100
Message-Id: <20190322144843.9602-9-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322144843.9602-1-igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
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
index f7e383e..65916f0 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -282,12 +282,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 
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

