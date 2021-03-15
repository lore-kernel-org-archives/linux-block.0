Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCEAC433DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Mar 2021 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85BB64E12
	for <linux-block@archiver.kernel.org>; Mon, 15 Mar 2021 01:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCOBTk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Mar 2021 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCOBTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Mar 2021 21:19:19 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39319C061574;
        Sun, 14 Mar 2021 18:19:19 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j7so8100316qtx.5;
        Sun, 14 Mar 2021 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Sqt+b6Mu59peMloIVI7xzaYZwvMRd5WGREUImc3KC0=;
        b=Ak5un/D/dqfo2vpzRExKhLFmwM7Lp2Vwp3ebr28m/ymYAe7HMacoZFmEXRP/IAXrn7
         7l4XmSlbrpxogZ7JnZHf5qMOGTsG1kXhavNgU2IwZVG6p+JttNiRT1Yg0EZSmWfdf72c
         GlhJfMdRoXqIRO01SG6RmHJ2FUix2iUUE04X+pkKVeD5/DkKCKcf6+R+ZxusknJk0U5+
         RHeyE+vIIJ69trMwH5WcXhbguzjVihX3bg59225EjzOX4uwNTsYVvt0M7I0LRv5kMiKP
         o5mvRxQxLV7UhNhIKisYhd8cb13wXDNEwMcmTWmrxRDBChxnBeSTg5gE86coTVd7n4BR
         LVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Sqt+b6Mu59peMloIVI7xzaYZwvMRd5WGREUImc3KC0=;
        b=BUDc+NZAUL0BhygsMDXNuAcFzROoD0WBvH7YKmpb9rXP3IR1bafS80G5cnhNGEVkb4
         ngB+QgEK+5wtd/QxiC9FU94c9KgvssAVQMggjxnuGetMxbMXk7bY7EhPYr82jPk6P8xR
         tBKmz0zzMacSmQ3wJWTBv8tcNp4TZx3TpDRzVIDjAlPutGSzgTEgxy0y2ldDuo+AN5MV
         UaxVYWxYZSHnrZ13H90AiHKBAlHUEFTH/+WaeegKa8iGSUZRg2N+U44xdfNR8IGvKq17
         EuGach64xaL1EHQSjicZIIfCK84GzcWd/a9fIQl266D6Ajxo4m9kTwqCbIKhfo2qSsoF
         3jxw==
X-Gm-Message-State: AOAM533zMZXBHCGHWJpfpEv9P+OPM2eFtJ+LQOVFN/6s1jzu5WUWab3t
        BX+1f6hF1HkDlmC/1y4QtR/q6FeDCelnA9+y
X-Google-Smtp-Source: ABdhPJxn1mbmsfNwG+WGJ1POgSb3IU1XizJULcsF97M5kMIgIB7Phvy3GelIXBEL9kCwjbSo09L45w==
X-Received: by 2002:ac8:431e:: with SMTP id z30mr20839521qtm.216.1615771158411;
        Sun, 14 Mar 2021 18:19:18 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.69])
        by smtp.gmail.com with ESMTPSA id h7sm11083518qkk.41.2021.03.14.18.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 18:19:17 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] block: Few spelling fixes in the file blk-merge.c
Date:   Mon, 15 Mar 2021 06:48:49 +0530
Message-Id: <20210315011849.3964886-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



s/trival/trivial/
s/attributs/attributes/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 block/blk-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..a39327e38276 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -283,7 +283,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
-	 * big IO can be trival, disable iopoll when split needed.
+	 * big IO can be trivial, disable iopoll when split needed.
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;

@@ -675,7 +675,7 @@ void blk_rq_set_mixed_merge(struct request *rq)
 	/*
 	 * @rq will no longer represent mixable attributes for all the
 	 * contained bios.  It will just track those of the first one.
-	 * Distributes the attributs to each bio.
+	 * Distributes the attributes to each bio.
 	 */
 	for (bio = rq->bio; bio; bio = bio->bi_next) {
 		WARN_ON_ONCE((bio->bi_opf & REQ_FAILFAST_MASK) &&
--
2.30.2

