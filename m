Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED9C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3D214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="rty9DMSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfA2Irz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:47:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfA2Irz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:47:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so16745342lja.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=C9svzEiZr9kw6t/LWZbdbQcKNuVhxD7bJthkMm/s6+Q=;
        b=rty9DMSzVoHo9A4/ZNJh8dP09HnUvRgCvzk9VgMduV++IT2+Knm/uvF3WiZoZcDcEV
         RdJ6fcF4W+HkOMXqBMedqQw0TgqFhCi1oDf/9PLngQNcTyUqNcJdPK2JnIZETjkOtc9g
         9Plow6seFCj+sHY+WVVWZUzBATtt1eiJAuXjj6m8zoA66DJpnM8wqzZfR3BJDI1NHf1i
         oHJ2r9g5TTzTJ+Q0ywrhON7FzRiAhhoc5ZhF5H06jyT8GSh6dhlj2UXZRaDG3aVi9kFJ
         tGK76c664XER/Rpwwigjb8iyimKyaShFkmr9F44/xZKYJeMmdB09i6fK6pbJDNaMzoXk
         /AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C9svzEiZr9kw6t/LWZbdbQcKNuVhxD7bJthkMm/s6+Q=;
        b=aA9/xsywsnpPLeZYBxmGs1bT/FGge2Tj/15YF2mPSAjk2QSgBEssd9FKQLXvwM5HfJ
         e6qPPl8Zgzd1KS0AaVdcfqEbm4/BnCH4r+o2IZueACek0lbt4yB/MIxUJ0csAnWZNCV9
         t5Ea8XF2Ygd8Do0X5LECktH4+58Imt8TlKMEPxyhCpzcfleRfi3q0LZbEyH8L8Vi6CuX
         QoTnazrHfx7F5bwUImYWe1l7j3W2sjdColSWCcACPRMOP97ZqVfPboBJv8AUT5lsQJAW
         ZbFhKOYx86bkv2psOXor0qC5trkqQSNXfadoVVYrQkRS/IdIyQO1ORb+C1Pj/IjPQgx3
         c4zg==
X-Gm-Message-State: AJcUukfc0PlaHgY0Iq8eAQidCE7DqL5yPZMt5P2H01dbLAz5ll6TrCi6
        Mp/doIKWwcsM1WyDz+5PGqMgrQ==
X-Google-Smtp-Source: ALg8bN7qYnhugcn+cuKakkGqvuRe79CiOo9sM1YfkFbZdQSef8htQXHUcwSUQwVHfiBuae6G7Z7BQg==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr19353883ljb.126.1548751672483;
        Tue, 29 Jan 2019 00:47:52 -0800 (PST)
Received: from ch-lap-hans.bredbandsbolaget.se (c-0bf2e055.03-91-6d6c6d4.bbcust.telenor.se. [85.224.242.11])
        by smtp.gmail.com with ESMTPSA id c22sm3418800lfd.88.2019.01.29.00.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:47:51 -0800 (PST)
From:   hans@owltronix.com
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     javier@javigon.com, Zhoujie Wu <zjwu@marvell.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: extend line wp balance check
Date:   Tue, 29 Jan 2019 09:47:37 +0100
Message-Id: <20190129084737.718-1-hans@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

pblk stripes writes of minimal write size across all non-offline chunks
in a line, which means that the maximum write pointer delta should not
exceed the minimal write size. Extend the line write pointer balance check
to cover this case.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

This patch applies on top of Zhoujie's V3 of 
"lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced

 drivers/lightnvm/pblk-recovery.c | 60 ++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 02d466e6925e..d86f580036d3 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
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
-	int pos, i, bit;
+	int pos;
 
-	bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
-	if (bit >= lm->blk_per_line)
-		return 0;
-	rlun = &pblk->luns[bit];
+	rlun = &pblk->luns[index];
 	ppa = rlun->bppa;
 	pos = pblk_ppa_to_pos(geo, ppa);
-	chunk = &line->chks[pos];
 
-	line_wp = chunk->wp;
+	return &line->chks[pos];
+}
 
-	for (i = bit + 1; i < lm->blk_per_line; i++) {
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
 
-		if (chunk->state & NVM_CHK_ST_OFFLINE)
-			continue;
+	i = find_first_zero_bit(line->blk_bitmap, blk_in_line);
+
+	/* If there is one or zero good chunks in the line,
+	 * the write pointers can't be unbalanced.
+	 */
+	if (i >= (blk_in_line - 1))
+		return 0;
 
-		if (chunk->wp > line_wp)
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
@@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	int ret;
 	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
 
-	if (pblk_line_wp_is_unbalanced(pblk, line))
+	if (pblk_line_wps_are_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
 
 	ppa_list = p.ppa_list;
-- 
2.17.1

