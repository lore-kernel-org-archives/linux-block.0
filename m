Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CAC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725952183F
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfB0RSR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:18:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:25365 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RSQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:18:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129819575"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 09:18:14 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 11/13] lightnvm: pblk: Remove unused smeta_ssec field
Date:   Wed, 27 Feb 2019 18:14:40 +0100
Message-Id: <20190227171442.11853-12-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190227171442.11853-1-igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Smeta_ssec field in pblk_line is set once and
never used, since it was replaced by function
pblk_line_smeta_start(). This patch removes
this no longer needed field

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c | 1 -
 drivers/lightnvm/pblk.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 2e424c0275c1..fa4dc05608ff 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1165,7 +1165,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	off = bit * geo->ws_opt;
 	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
 	line->sec_in_line -= lm->smeta_sec;
-	line->smeta_ssec = off;
 	line->cur_sec = off + lm->smeta_sec;
 
 	if (init && pblk_line_smeta_write(pblk, line, off)) {
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a92377530930..b266563508e6 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -464,7 +464,6 @@ struct pblk_line {
 	int meta_line;			/* Metadata line id */
 	int meta_distance;		/* Distance between data and metadata */
 
-	u64 smeta_ssec;			/* Sector where smeta starts */
 	u64 emeta_ssec;			/* Sector where emeta starts */
 
 	unsigned int sec_in_line;	/* Number of usable secs in line */
-- 
2.17.1

