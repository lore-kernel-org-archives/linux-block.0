Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F0C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763BB20848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfCENyW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:64693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfCENyV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161558"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:20 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 4/8] lightnvm: pblk: Ensure that erase is chunk aligned
Date:   Tue,  5 Mar 2019 14:51:16 +0100
Message-Id: <20190305135120.29284-5-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current pblk implementation of erase command there is a chance
that the sector bits are set to some random values for erase PPA.
This is unexpected situation, since erase shall be always chunk
aligned based on OCSSD 2.0 specification. This patch fixes that issue.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 7fbc99b..5408e32 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -162,6 +162,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 			*erase_ppa = ppa_list[i];
 			erase_ppa->a.blk = e_line->id;
+			erase_ppa->a.reserved = 0;
 
 			spin_unlock(&e_line->lock);
 
-- 
2.9.5

