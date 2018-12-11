Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E799CC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E5020880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="lzOEtcYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E5020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLKTRE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41917 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeLKTRC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so14030630ljc.8
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAAvZB5EbkafXfB/nQ8jKNvQ2dQs06mVyegUe1IKNXs=;
        b=lzOEtcYAkliKJkbxwBrdhYEMD+GTwp2RMPuopkhSqBjw4wEJpQCYlBgBF/lDitqViW
         /08yLQWhRdNLo4g3XqeQrciKXNP95mZcALPOG2CvMCDIthp6Knf9dIqKC39Rybu4MV4g
         pKoC0nuZ+VduwOqk5eO/jgFKue7E+Fse60QBN1rroTsirPC2y2q7LYQlUhwiid/1KE/f
         Qb3ztOYU7I5WK/pL4EYCwS2n18FuXYvpEWYWWrF1phL6UPX3l0Sr88/g9Cl9QBr3uZEI
         GyNWjfqnPEoAAFYXoPrBjLxuJZl6pLDtbpoeChbP6b1lQB4yLaHpADk2tEAKZPT45n+n
         +dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAAvZB5EbkafXfB/nQ8jKNvQ2dQs06mVyegUe1IKNXs=;
        b=tQjpSYfrprj8skVmNfPLrb28t/hY9aJrBA5giE0GTTSsPSCqP1GwiTf4ddA8vr8wcL
         Al4iI4MzNi43HbcWlfZ3T6R+rF7WqJbfJXatEH6IV1bNSjst2qyHaBhj0zoE2HnPrn3v
         sadDtpGKVcBBtH6jrnU4Fowa2AYWPHXxKBcXSZAEddo+9f7W3BPRMCFG0dPTRtQDdhxj
         UKskf/OaBPgYeVEhfYUhKhIzhp+qcKtOtNHTnGL2XHALHjaAbYTTIlWuhpeF/XAmIHSL
         WVTB0ZtTRhp2ace6qt+aKxMoLXz1nMuC0CimQSknirsw1eV8LL9asxXkhGa1ErZCyyIz
         5FrA==
X-Gm-Message-State: AA+aEWZ6Jzq6/+q58MTXewskOW8qHJ/adQNMi8JEkLpYyyGXYBmcVwM0
        OrWSSklIn51ug5JNvhMOvUfLDw==
X-Google-Smtp-Source: AFSGD/XDHUA/r76FNrnzaaEtoXbTWySAe7CO33Ssv7XIEK3Xe/KMdAcZSzA2DvPP+UK172BOCF1QdQ==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr10215088ljd.137.1544555820306;
        Tue, 11 Dec 2018 11:17:00 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:16:59 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhoujie Wu <zjwu@marvell.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/21] lightnvm: pblk: ignore the smeta oob area scan
Date:   Tue, 11 Dec 2018 20:16:07 +0100
Message-Id: <20181211191627.15542-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhoujie Wu <zjwu@marvell.com>

The smeta area l2p mapping is empty, and actually the
recovery procedure only need to restore data sector's l2p
mapping. So ignore the smeta oob scan.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 5740b7509bd8..0fbd30e0a587 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -334,6 +334,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 			       struct pblk_recov_alloc p)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
 	struct pblk_sec_meta *meta_list;
@@ -342,12 +343,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	__le64 *lba_list;
-	u64 paddr = 0;
+	u64 paddr = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
 	bool padded = false;
 	int rq_ppas, rq_len;
 	int i, j;
 	int ret;
-	u64 left_ppas = pblk_sec_in_open_line(pblk, line);
+	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
 
 	if (pblk_line_wp_is_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
-- 
2.17.1

