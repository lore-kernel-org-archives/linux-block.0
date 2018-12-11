Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D6C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF412087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="FxvvClA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF412087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbeLKTRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42245 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeLKTRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so11620184lfh.9
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZQ05pd/DYjcwuL9XXbPWfkpS7Sp4JOpwfteFuJIygo=;
        b=FxvvClA9cQfAubxbDAgtvRwIAmlxsmj1UmtpQFJtjzwQFaXN+XByf3lRndQBu3nT4S
         tcb+YqigqYFQDKvaBGwE3cEYFTuWDhcjhQF13HioIE+bUHpbvJayyOhlqFY4l1MLqR3m
         wZUrY0wAAMGvfdMKDCejzpLAWUKcvzBB3tBtKv4PluuKSxuPfiyxgpuVP3bCy7lVBR9B
         kW8nXkW2FNV8xPUopBNRdD14+6mTSB3ad9kutWB7JEKfYQWb7mPzWCgw/2lL+omrs6e5
         RZnNrjyyBv0gnnb7FvU9o2AxUN2SrTf2qONwLu8Cmpv/+rvLeKx/PG2QN0hM33wZQupy
         Hz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZQ05pd/DYjcwuL9XXbPWfkpS7Sp4JOpwfteFuJIygo=;
        b=TAj8PsAjSB5ihQ2IXpKUFVVyPIliaibvxI+SyYR+WyWaP6U2Pzp3fVBABccvv5Fl5C
         PrzKIwMql7mkzKWtJSfl9yiChjSZZZZ2OwINO96QVBN+BnXNoMX0tFxsZlclaVQxNFXo
         1FBmJt9F38P4+X70FrMxdjJOg5cC4jlGjAT3OdxZOFL2hgVnR2AX9euohXCHN2W4wZ2P
         fWtTotZrH7oGHvV9R7LJeuNCbiQITpVTJpjfN3hs5FSEBqFF9oapcd4wFsK0QBI9QZ4s
         jPpPvPDsMZwF6VrwGlL7dBzQGUmFPrxqLBo4QWvDFHuy+BfSD0WqFPiGrYmuJj+bs1a6
         f4fA==
X-Gm-Message-State: AA+aEWZyawew9+guu2UMw3tedRdS+aBdxzUhuxvXw+mBeOZPHKGcfb1j
        Lp6NAaTxGG7nWqR4BxKerI0wKg==
X-Google-Smtp-Source: AFSGD/XoRz+ExZr+V1Ej1p2fCOyGx6jG0U8Z6KflkM+pER4l+MNtqZeCaQlt0DhDvtq8WUtc6q+spw==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr9657551lfg.89.1544555825446;
        Tue, 11 Dec 2018 11:17:05 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:04 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 05/21] lightnvm: pblk: account for write error sectors in emeta
Date:   Tue, 11 Dec 2018 20:16:11 +0100
Message-Id: <20181211191627.15542-6-mb@lightnvm.io>
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

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Lines inflicted with write errors lines might be recovered
if they have not been recycled after write error garbage collection.

Ensure that the emeta accounting of valid lbas is correct
for such lines to avoid recovery inconsistencies.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3ddd16f47106..750f04b8a227 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -105,14 +105,20 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 }
 
 /* Map remaining sectors in chunk, starting from ppa */
-static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
+static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa,
+		int rqd_ppas)
 {
 	struct pblk_line *line;
 	struct ppa_addr map_ppa = *ppa;
+	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+	__le64 *lba_list;
 	u64 paddr;
 	int done = 0;
+	int n = 0;
 
 	line = pblk_ppa_to_line(pblk, *ppa);
+	lba_list = emeta_to_lbas(pblk, line->emeta->buf);
+
 	spin_lock(&line->lock);
 
 	while (!done)  {
@@ -121,10 +127,17 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 		if (!test_and_set_bit(paddr, line->map_bitmap))
 			line->left_msecs--;
 
+		if (n < rqd_ppas && lba_list[paddr] != addr_empty)
+			line->nr_valid_lbas--;
+
+		lba_list[paddr] = addr_empty;
+
 		if (!test_and_set_bit(paddr, line->invalid_bitmap))
 			le32_add_cpu(line->vsc, -1);
 
 		done = nvm_next_ppa_in_chk(pblk->dev, &map_ppa);
+
+		n++;
 	}
 
 	line->w_err_gc->has_write_err = 1;
@@ -202,7 +215,7 @@ static void pblk_submit_rec(struct work_struct *work)
 
 	pblk_log_write_err(pblk, rqd);
 
-	pblk_map_remaining(pblk, ppa_list);
+	pblk_map_remaining(pblk, ppa_list, rqd->nr_ppas);
 	pblk_queue_resubmit(pblk, c_ctx);
 
 	pblk_up_rq(pblk, c_ctx->lun_bitmap);
-- 
2.17.1

