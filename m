Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B4DC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CF92184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfCNQIU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:08:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:61624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfCNQIT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:08:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073078"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:08:17 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 09/18] lightnvm: pblk: kick writer on write recovery path
Date:   Thu, 14 Mar 2019 17:04:19 +0100
Message-Id: <20190314160428.3559-10-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of write recovery path, there is a chance that writer thread
is not active, so for sanity it would be good to always kick it.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
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

