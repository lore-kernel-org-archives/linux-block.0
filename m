Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E1C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67DC2183F
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfB0RR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:17:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:25365 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RR6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:17:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:17:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129819467"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 09:17:56 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
Date:   Wed, 27 Feb 2019 18:14:35 +0100
Message-Id: <20190227171442.11853-7-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190227171442.11853-1-igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current pblk implementation of erase command
there is a chance tha sector bits are set to some
random values for erase PPA. This is unexpected
situation, since erase shall be always chunk
aligned. This patch fixes that issue

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c | 1 +
 drivers/lightnvm/pblk-map.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a98b2255f963..78b1eea4ab67 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
 
 		ppa = pblk->luns[bit].bppa; /* set ch and lun */
 		ppa.a.blk = line->id;
+		ppa.a.reserved = 0;
 
 		atomic_dec(&line->left_eblks);
 		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 79df583ea709..aea46b4ec40f 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 			*erase_ppa = ppa_list[i];
 			erase_ppa->a.blk = e_line->id;
+			erase_ppa->a.reserved = 0;
 
 			spin_unlock(&e_line->lock);
 
@@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		atomic_dec(&e_line->left_eblks);
 		*erase_ppa = pblk->luns[bit].bppa; /* set ch and lun */
 		erase_ppa->a.blk = e_line->id;
+		erase_ppa->a.reserved = 0;
 	}
 
 	return 0;
-- 
2.17.1

