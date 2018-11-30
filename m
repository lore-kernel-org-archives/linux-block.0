Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C9C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240692146F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VRVVbdIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240692146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeLAEG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:58 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37421 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeLAEG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:57 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so10240222iti.2
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZECYVF1gJ/UytKVuamY/WF200Edf1Xru8F859yvniEc=;
        b=VRVVbdIqGnM2zcUr1aE2Cv9Q2sEVyi2OL5PJAdTs4jhL1bFeNZn3BBR1WQsrfN/sDQ
         1XR1QBJnqOCQH+01q+u8JOcAMK+Jdy27tiWhTVculFwtMqGL2UJTuYlqe5O1jALHR6nl
         0BbZFiBKpiTgezKV+/iByAeT1rEwZf56cYUezlHLzlv74sXYzE78mbyahdQ8janIxM9R
         fAfvcbyx1ZX/5WL0C0VgJSb5xkXM2Wpti+52cyj7HpckCJrpOR/G5Hd0Uwkd2yuPDfGd
         bhkJ4J04hVX20vg8OxRS3AApDbQNg/ew6sRGJxes3mKsl69uwNwVAnX2Zf5CpNjsIuj1
         0wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZECYVF1gJ/UytKVuamY/WF200Edf1Xru8F859yvniEc=;
        b=btLsWatsjv3rp/tF6c7gfGydipLhlxzeelkkIhz1Bt95eJsmXFA8RR010l3Lav0Sdd
         tHbxObGn9FrLnrA78kkIx3DjunsGSikFeb9Ssd7slAcb87d9z4CG/U96gVfY06Rh5ENZ
         /TaK6eF+4P5wCsdACNcEho4bzW/Bmyi2awxZpC/uHWgp8eJo5Ke1WpOOeqbjDZet9Hj0
         NrjQAp/4JlUbAcGoPV6UmFyqr/OdPRFlIeWnm88Q9aPSmUL3Y66jqt7G6/Y1nnbL24RC
         pciP2vB8vJxuynAQFVYmTedBEUwpZAEuBAC7Z1U6qdmhW5arEYVEVg9raRu+BtJd04PU
         /Rxg==
X-Gm-Message-State: AA+aEWY/OET4Hl9PCngcf9tRz8d3LT0L09hHyVUDByKevdMDQ9OAcBCV
        2uU6QOJP2KmGrHWJMMBE4yb9LFrMTVk=
X-Google-Smtp-Source: AFSGD/WgVG5dOPb2JGLFeoUpe/MN3aHF/ZaWKBSbKEsHSjuXk91FEFnS3290Ry/6CArh0+yToB9S5A==
X-Received: by 2002:a02:97fd:: with SMTP id v58mr5997280jaj.115.1543597021243;
        Fri, 30 Nov 2018 08:57:01 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/27] iomap: ensure that async polled IO is marked REQ_NOWAIT
Date:   Fri, 30 Nov 2018 09:56:26 -0700
Message-Id: <20181130165646.27341-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can't wait for polled events to complete, as they may require active
polling from whoever submitted it. If that is the same task that is
submitting new IO, we could deadlock waiting for IO to complete that
this task is supposed to be completing itself.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 16787b3b09fd..96d60b9b2bea 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1451,8 +1451,16 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 {
 	atomic_inc(&dio->ref);
 
-	if (dio->iocb->ki_flags & IOCB_HIPRI)
+	if (dio->iocb->ki_flags & IOCB_HIPRI) {
 		bio->bi_opf |= REQ_HIPRI;
+		/*
+		 * For async polled IO, we can't wait for requests to
+		 * complete, as they may also be polled and require active
+		 * reaping.
+		 */
+		if (!dio->wait_for_completion)
+			bio->bi_opf |= REQ_NOWAIT;
+	}
 
 	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
 	dio->submit.cookie = submit_bio(bio);
-- 
2.17.1

