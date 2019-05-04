Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630CAC43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358EF2084A
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="eirepp7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfEDSii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40544 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfEDSih (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id o16so6513277lfl.7
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lUEIM6HxDnO0WA4JO+7E8AtWBSweRsdO5Jk/5jbRNk=;
        b=eirepp7rCDa4s4xp9B9alMSTJW8zT3BZDnviazcRBoQtnmPVWmbHWx/MKyMKZfzniH
         lCbbp14h3V5zZ6/pxwX3qaUxuybRn+rsSGzH5s7azheoJNHuA+bKeSHXPMjt0QY0qUgd
         z3DSyplKba5KP3lYnBIJNJCe3mFH/VozvNOa58iHAkppdDhZvaaaK62tN3n8WTkXunrg
         NOfTB7TbeClqosR8YYRn/Ih3zeMsGJIU0YF+aCgzfMm5RwCsNHesir599y05Ojpyk/ft
         s8O++kiMtbe6vSo5WuvLmjIgQ/Xfk+z6+IqMzcgu9tV8L1H9TQCJIoe9vEaxbqzgBpFP
         EM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lUEIM6HxDnO0WA4JO+7E8AtWBSweRsdO5Jk/5jbRNk=;
        b=joLaNhnhfleHp1dQB+vC+FQ7HCm0pSp44h6SaTziyG/jSD8MaPliwYBdhRKQM+2aof
         KQcysK8GXXpeZ+Bxb3xPbYFn3rpPzcIrpIQk5hx2RM7FISEPE0Gm32TId2ylOc/rfe+3
         M5NC8znrNvvlvT0B2ys7TdiwWbUWTT3PhWtPWdZ0WOSMr2Ze7SIvXKgzufBbmed93ZH+
         hZ1majxY09GmM8jkIz6/8/77hKLsfD/quaTj1PJTldefeZyEZE61GtsGIQqZNzVu0V3Z
         3CttMDH3QqCwhnl287LDZSbW5dGaDAeUczJ/A6J6tHUG6oLgEBncXer2qX/puatlGRrR
         qbUQ==
X-Gm-Message-State: APjAAAVZaZglb+Q0pctIzgHr8DmbbzrL2vQUZhSVZv1w4H/yPacRD+9V
        ho5ynPq+xVzt76KtJ+Zf7k77xw==
X-Google-Smtp-Source: APXvYqwbJccRkqhPgXwF38teXbsvsMsVyU3UOO3SbQBiPhc3j3Gja4qxPs2Eg02/ToEQp9jf90JfZg==
X-Received: by 2002:a19:4811:: with SMTP id v17mr8039906lfa.10.1556995114808;
        Sat, 04 May 2019 11:38:34 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:34 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/26] lightnvm: pblk: set proper read status in bio
Date:   Sat,  4 May 2019 20:37:54 +0200
Message-Id: <20190504183811.18725-10-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently in case of read errors, bi_status is not set properly which
leads to returning inproper data to layers above. This patch fix that
by setting proper status in case of read errors.

Also remove unnecessary warn_once(), which does not make sense
in that place, since user bio is not used for interation with drive
and thus bi_status will not be set here.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index b8eb6bdb983b..7b7a04a80d67 100644
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
 
@@ -298,7 +297,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	rqd->bio = NULL;
 	rqd->nr_ppas = nr_secs;
 
-	bio_endio(bio);
+	pblk_end_user_read(bio, rqd->error);
 	__pblk_end_io_read(pblk, rqd, false);
 }
 
-- 
2.19.1

