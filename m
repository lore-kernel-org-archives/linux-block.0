Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BD3C43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4E6215EA
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="w6zy5RcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUJMT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:12:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38099 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfFUJML (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 05:12:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so4515841lfa.5
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGWPck9wpyZRR3E02z/BR5xB8SDUTdEAXPWir9EA+Iw=;
        b=w6zy5RcYtlwpn9uZXBTPnNqk13OWqgW/Z2IEW/b5Va7tVCdbZbgJ0Cnouiv1j8bK7K
         bWDV6rGP+wes+RvdAIhBg3cRGlsDMwzbX/6Pfp6zyqHpiYqTGnTFvLM0Pg65iaGyGe9S
         wL+Qtd2PN1OIZ6m+5zeoMcbz9V58AEbYH7Ozo007qVRWkc4c0o/JWGYAueBfZWH3kyVJ
         GiMfrOUImqgt+6PJ9Mmm3Q25GZAXsoP7p0h+TeEEOa9HMFuROrH4kUTSFef/409yBtpA
         SZksPiF4DLQ6yesYrrSClVK54ohgnvbcEUQAx3MFCpdpHzGuDwlT14kmhEqQv6OX076f
         LdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGWPck9wpyZRR3E02z/BR5xB8SDUTdEAXPWir9EA+Iw=;
        b=Beru1fdCY3DE0VCn9FyCkHdkT6qBGehq4Fuli7HyNgHL34LFFIkszfc8+DX+eJnbpi
         wZdv/oQwB+8BouDrK9HjTM9RNGVEK7aca9Moj964Jfxomy86xOtwJGj4w9g6qYyX/5t8
         Hi3WHFZDXkcCniBP3ro+Q6yg9/WuvG/H5pX1cbOvscx2ngWva8unUavV5kZ4WDdXhNpL
         iCBzpLBlK3UCXFergk16QmMFbNiRC1idLm2tdza1/rJNNJc0rXanFGl6V88g9eh8/38V
         pkjm3FhTQZszHSiQX9jrM1aQMMMahQUlBR68GPA9OdVig/dJ0jhgQDWfHnGDcH9kfG7a
         aipQ==
X-Gm-Message-State: APjAAAUHePAXLBl+d/TnpjSwvmFhBKb5mVXjihdHuUh2G7W7CHzxxQZs
        eqR0zbQY0zlClDAXi0K8UQ9ElA==
X-Google-Smtp-Source: APXvYqwEQaPtv/AT8pgQU9n75IZ6a1nGoS44tadH/5E9dMkzEJyY5mAnoUx0dj0rJvAXeL1ic/ruZA==
X-Received: by 2002:a19:d5:: with SMTP id 204mr1954825lfa.66.1561108328971;
        Fri, 21 Jun 2019 02:12:08 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id z26sm303178ljz.64.2019.06.21.02.12.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:12:08 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 1/2] lightnvm: pblk: fix freeing of merged pages
Date:   Fri, 21 Jun 2019 11:11:59 +0200
Message-Id: <20190621091200.23168-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621091200.23168-1-mb@lightnvm.io>
References: <20190621091200.23168-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

bio_add_pc_page() may merge pages when a bio is padded due to a flush.
Fix iteration over the bio to free the correct pages in case of a merge.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 773537804319..f546e6f28b8a 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -323,14 +323,16 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 			 int nr_pages)
 {
-	struct bio_vec bv;
-	int i;
+	struct bio_vec *bv;
+	struct page *page;
+	int i, e, nbv = 0;
 
-	WARN_ON(off + nr_pages != bio->bi_vcnt);
-
-	for (i = off; i < nr_pages + off; i++) {
-		bv = bio->bi_io_vec[i];
-		mempool_free(bv.bv_page, &pblk->page_bio_pool);
+	for (i = 0; i < bio->bi_vcnt; i++) {
+		bv = &bio->bi_io_vec[i];
+		page = bv->bv_page;
+		for (e = 0; e < bv->bv_len; e += PBLK_EXPOSED_PAGE_SIZE, nbv++)
+			if (nbv >= off)
+				mempool_free(page++, &pblk->page_bio_pool);
 	}
 }
 
-- 
2.19.1

