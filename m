Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7005FC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFB22075B
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="qdkB2bHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfBKMZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40752 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfBKMZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id t14so7570348lfk.7
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 04:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=horUJaYN1AtPap9Tf3+ti1ICSvr2tumzRYfiNboXyUE=;
        b=qdkB2bHQC/o2xcAnKZMyX7sQM6OtYJVunYcRuZpTUU5MWef4Wu/5X7VcEHyruwl2DJ
         aiHkB/BV4PVUjVABDCT2ui+/3H+mkiJNGBqxNuEmOyTWkxP12wIopAZGOMRiUcra48EK
         pxEnFE38dJgZul2XO+jq3pY/NLMntCuolNkI0zVX1BtEtAI39DqbQeN0NyWAruQm7l/V
         aCGoxbQT+181G1LNP9mEO9dG9OSrDL3ZcUr+gg3HKc3H17d5WoN2vYAaAd2Jg/5AFJ1Y
         6qs5Y2L/EPuGcKFVgifa6vTSeQ+NRNq8UP6IaYfQl19F/RCb72C8GHIcOUZ/FxScDn+Q
         qIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=horUJaYN1AtPap9Tf3+ti1ICSvr2tumzRYfiNboXyUE=;
        b=XR1OOGfnk/YyEUzmw0yGoVkvl/SKcw5weocHXDJH0CxUOL2Q9A9z/Je9gK5TrzGnZn
         5uuJdiPzpN/2QAppKDhTa+BfSxotvr7nhtsWddXVUvzUtD2gZ/mAF/2qsL8zvI31ahde
         6yOUqPXgoKGa7yVg9uIZNlPWWtaS/1mRWBsi0Nj0Xsy2HaiDEfRpTRu92V/CPQkjb3A0
         KG35xLhokIREqso9iP/bBj6egrVZKC7aPiSQgIsnfJYxecbxRDKmTBVP9zf+sIT0Jw+d
         K/m9cn/TWYKj8Hk4SgnKWXYPXqEg0/GH4wAQJT4KxWrvxF8Q1UO9WupCAzx/9EV6nPRx
         E+TQ==
X-Gm-Message-State: AHQUAuZvZLAcRcxj5gcnIYQI9UymOa53DpCWP1HfdP5CcC+sNo4Jv0hp
        rEEMLvzHUZ+HRMy1QTVeixfnGzIyB8I=
X-Google-Smtp-Source: AHgI3IbygmPsrWZPYgAX+rA3ObHONfRmKTMYSb3mt49tm2O2rMaNdVESnZBVJbL2WBN8vSgxfmMalg==
X-Received: by 2002:ac2:5085:: with SMTP id f5mr21611025lfm.30.1549887928681;
        Mon, 11 Feb 2019 04:25:28 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:27 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 6/8] lightnvm: pblk: extend line wp balance check
Date:   Mon, 11 Feb 2019 13:25:07 +0100
Message-Id: <20190211122509.19910-7-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

pblk stripes writes of minimal write size across all non-offline chunks
in a line, which means that the maximum write pointer delta should not
exceed the minimal write size.

Extend the line write pointer balance check to cover this case, and
ignore the offline chunk wps.

This will render us a warning during recovery if something unexpected
has happened to the chunk write pointers (i.e. powerloss,  a spurious
chunk reset, ..).

Reported-by: Zhoujie Wu <zjwu@marvell.com>
Tested-by: Zhoujie Wu <zjwu@marvell.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 56 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 6761d2afa4d0..d86f580036d3 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -302,35 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
 	return (distance > line->left_msecs) ? line->left_msecs : distance;
 }
 
-static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
-				      struct pblk_line *line)
+/* Return a chunk belonging to a line by stripe(write order) index */
+static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
+						  struct pblk_line *line,
+						  int index)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_lun *rlun;
-	struct nvm_chk_meta *chunk;
 	struct ppa_addr ppa;
-	u64 line_wp;
-	int pos, i;
+	int pos;
 
-	rlun = &pblk->luns[0];
+	rlun = &pblk->luns[index];
 	ppa = rlun->bppa;
 	pos = pblk_ppa_to_pos(geo, ppa);
-	chunk = &line->chks[pos];
 
-	line_wp = chunk->wp;
+	return &line->chks[pos];
+}
 
-	for (i = 1; i < lm->blk_per_line; i++) {
-		rlun = &pblk->luns[i];
-		ppa = rlun->bppa;
-		pos = pblk_ppa_to_pos(geo, ppa);
-		chunk = &line->chks[pos];
+static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
+				      struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	int blk_in_line = lm->blk_per_line;
+	struct nvm_chk_meta *chunk;
+	u64 max_wp, min_wp;
+	int i;
 
-		if (chunk->wp > line_wp)
+	i = find_first_zero_bit(line->blk_bitmap, blk_in_line);
+
+	/* If there is one or zero good chunks in the line,
+	 * the write pointers can't be unbalanced.
+	 */
+	if (i >= (blk_in_line - 1))
+		return 0;
+
+	chunk = pblk_get_stripe_chunk(pblk, line, i);
+	max_wp = chunk->wp;
+	if (max_wp > pblk->max_write_pgs)
+		min_wp = max_wp - pblk->max_write_pgs;
+	else
+		min_wp = 0;
+
+	i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
+	while (i < blk_in_line) {
+		chunk = pblk_get_stripe_chunk(pblk, line, i);
+		if (chunk->wp > max_wp || chunk->wp < min_wp)
 			return 1;
-		else if (chunk->wp < line_wp)
-			line_wp = chunk->wp;
+
+		i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
 	}
 
 	return 0;
@@ -356,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	int ret;
 	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
 
-	if (pblk_line_wp_is_unbalanced(pblk, line))
+	if (pblk_line_wps_are_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
 
 	ppa_list = p.ppa_list;
-- 
2.19.1

