Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33D3C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37E020848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCENy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:64693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfCENy0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161577"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:24 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 6/8] lightnvm: pblk: Set proper read stutus in bio
Date:   Tue,  5 Mar 2019 14:51:18 +0100
Message-Id: <20190305135120.29284-7-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently in case of read errors, bi_status is not set properly which
leads to returning inproper data to higher layer. This patch fix that
by setting proper status in case of read errors

Patch also removes unnecessary warn_once(), which does not make sense
in that place, since user bio is not used for interation with drive
and thus bi_status will not be set here.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-read.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 1f9b319..6569746 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
 }
 
-static void pblk_end_user_read(struct bio *bio)
+static void pblk_end_user_read(struct bio *bio, int error)
 {
-#ifdef CONFIG_NVM_PBLK_DEBUG
-	WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
-#endif
+	if (error && error != NVM_RSP_WARN_HIGHECC)
+		bio_io_error(bio);
 	bio_endio(bio);
 }
 
@@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct bio *bio = (struct bio *)r_ctx->private;
 
-	pblk_end_user_read(bio);
+	pblk_end_user_read(bio, rqd->error);
 	__pblk_end_io_read(pblk, rqd, true);
 }
 
@@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	rqd->bio = NULL;
 	rqd->nr_ppas = nr_secs;
 
-	bio_endio(bio);
+	pblk_end_user_read(bio, rqd->error);
 	__pblk_end_io_read(pblk, rqd, false);
 }
 
-- 
2.9.5

