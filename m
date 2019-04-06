Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF4EC10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CA4213A2
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara-com.20150623.gappssmtp.com header.i=@zadara-com.20150623.gappssmtp.com header.b="Y+ap6G5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDFNEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 09:04:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56025 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDFNEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 09:04:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so9366192wmf.5
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bpNdqGRz5FKa/8N1d72fnRhm1DEVAMVZK42Wx7lVhnY=;
        b=Y+ap6G5HZKiBRyTZqGAV+kLfIsCltx9aD4CQLZpBICEtFPY87MLAoMVfX04ugfITy7
         tC1HU/xRzoSYSYctNnR5s4LFYTwU5A9GSSVfWvmt0Uh17pctaRm84WHerAwdL79QH+cn
         FiC0xMofDP8mPQ2vLXv5BQl2KAc1MKFfpqgbqTtVcqkwIWH0frciuK+pk8Yo4/jjISBe
         Tll6JINQeQygxo6ByNd2bXaUred9cOckXsMC4su1YkdMWz9dYI93YOEHtfig5e/xEcrb
         3rIN2rIsB1DIsAV8eISubRAj9oCeObCrJAOFn7FFY/IlOsOjT5kmNl4jiFNypJu4KLee
         QJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bpNdqGRz5FKa/8N1d72fnRhm1DEVAMVZK42Wx7lVhnY=;
        b=LsBqx18eKazJ4FQ/+CRhBgsh7ULLU1lv/7ycmKqAJFrhGWnTB0mfqL5+Umvr4FYk1R
         odClJ67TQUKfcbY4fWD+Gb7A/OCzF0GWSN2XT6P2uSnIbJO2LB0j26oeGJXnTiDxiCqD
         Zlc/5U21xGc0P79NYhbo0hYdJLIDp7/0j4Y2Xie13oScnHQUfwLox73e9HzlgtdrqXRa
         5jgIKrw5u8T9u6LXaQpbmf7rpgp69aKrJG3i3fIYu9ul/wZRZWlIl9yY0MqYvIHUiS7N
         50T0WIjDVMYVbuZuNvJQ+77aj9qCFuxMf7APR6SigOd332evYqUTodMBz67WtnsL5b/T
         l6wQ==
X-Gm-Message-State: APjAAAWUot8YcFUVUJI+H43nc0URPKXcilKsrLjFjMwxhqUH2DCLJlM2
        iUClJEP0LaQ4kpMdNoxUCe/chUg75Bg=
X-Google-Smtp-Source: APXvYqxFAqdmRkX1M07/q+drL6y/pXSuh0bjmUQZuLVgGpJI0EJuvo7BZBXiMsVtkXTAvyIlp6gnVA==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr11152100wmh.32.1554555858816;
        Sat, 06 Apr 2019 06:04:18 -0700 (PDT)
Received: from localhost.localdomain ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id u2sm5545232wmc.45.2019.04.06.06.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Apr 2019 06:04:18 -0700 (PDT)
From:   Alex Lyakas <alex@zadara.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk
Subject: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
Date:   Sat,  6 Apr 2019 16:03:20 +0300
Message-Id: <1554555800-14392-1-git-send-email-alex@zadara.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit dac56212e8127dbc0bff7be35c508bc280213309 titled
"bio: skip atomic inc/dec of ->bi_cnt for most use cases"
made __bi_cnt dependent on the new BIO_REFFED flag.

bio_reset() does not reset __bi_cnt, but it does reset the BIO_REFFED flag.
But __bi_cnt depends now on the BIO_REFFED flag, so bio_reset()
needs to preserve this flag.

Signed-off-by: Alex Lyakas <alex@zadara.com>
---
 block/bio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b64cedc..96f8dca 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -301,11 +301,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 void bio_reset(struct bio *bio)
 {
 	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);
+	bool bio_reffed = bio_flagged(bio, BIO_REFFED);
 
 	bio_uninit(bio);
 
 	memset(bio, 0, BIO_RESET_BYTES);
 	bio->bi_flags = flags;
+
+	/* we are not resetting __bi_cnt, but it depends on correct BIO_REFFED */
+	if (bio_reffed)
+		bio_set_flag(bio, BIO_REFFED);
+
 	atomic_set(&bio->__bi_remaining, 1);
 }
 EXPORT_SYMBOL(bio_reset);
-- 
1.9.1

