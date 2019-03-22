Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D8C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E520883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfCVOws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:52:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:1215 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfCVOws (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:52:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593417"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:52:38 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 10/16] lightnvm: pblk: kick writer on write recovery path
Date:   Fri, 22 Mar 2019 15:48:37 +0100
Message-Id: <20190322144843.9602-11-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322144843.9602-1-igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of write recovery path, there is a chance that writer thread
is not active, so for sanity it would be good to always kick it.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 6593dea..4e63f9b 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -228,6 +228,7 @@ static void pblk_submit_rec(struct work_struct *work)
 	mempool_free(recovery, &pblk->rec_pool);
 
 	atomic_dec(&pblk->inflight_io);
+	pblk_write_kick(pblk);
 }
 
 
-- 
2.9.5

