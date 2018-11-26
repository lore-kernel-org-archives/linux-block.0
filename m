Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A453C43610
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0393920659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="08LOPMzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0393920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeK0Dkl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33126 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeK0Dkl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:41 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so7482672itk.0
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZECYVF1gJ/UytKVuamY/WF200Edf1Xru8F859yvniEc=;
        b=08LOPMzsRDOo83TfkVDlEi/iJuRLKf2GrSp6f9MjEgiY+PZYAQnsqSR5HLrX1sBgoy
         2hgXGpDBOcRia8qBI0Hd131S87KgppoJHaSUpiSa2V9uB70bUHolxWygL4EsM2KjF8Dt
         kGyPhvLV1H6lf5vlrFGGn9VQO4OdZRojKDJxaxMYhibOtX1HvfWIYP0Gp9UweszraMv4
         wEsrWIOHG6/tQxM6WqaaRoovtInllQ9JlOWpILBJAeUZh3V5BJX2UEorxgkX17dg6L0p
         Ra0UoXyGUhynREvEmNu6gp+7ev7BMpaRSGidas7xTC+5cX89Bw52uUfI2PTXpHPE9RNV
         iG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZECYVF1gJ/UytKVuamY/WF200Edf1Xru8F859yvniEc=;
        b=g8x7RCyNBlLSy/y8Nvi0dJFYGjLCFgY4e4Si6U7sZDftosdlMblxW4l34hyJ8Q5h/i
         TaZkAm/Rh4wjppzC8d3userDcbRe5rzylwXy7NEIhVmpM2wnzIURudHlhG7W3ThbdXlH
         J2wFTBvyJa1gUkV58KK4inm6rSaz56R2U9dxEbmgXpfNv8Q4UxiKBvx0b+YgcHAlSyhp
         Coq6X0DZouwcLkO3ZKaauo9TDowSEDQE+FMUDSlh9CtRpWi9awx4w2rXRx7ED+Wnl3SV
         1k4W3L/USdvp2mcKEgoCibiPNxZpw2Mzm3yejgBZO1CBE+bGe9w+SUfk99AV5f/Y0BpM
         2uJA==
X-Gm-Message-State: AA+aEWZ6wv016tAwvGCEsOfl0T6tYFY4q6ClwUsoHysCKygSXv4qdRFa
        UVS6SV6crdDrUQGXxAMTd5j72QzstHI=
X-Google-Smtp-Source: AJdET5eHoC1ioxXSqVwH0514iId5+vubvjql+khkf/Y9BTi1ZrNv6tbrhsvUyT49skUGkvyDGlbtWQ==
X-Received: by 2002:a24:da06:: with SMTP id z6-v6mr23077915itg.178.1543250761799;
        Mon, 26 Nov 2018 08:46:01 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/20] iomap: ensure that async polled IO is marked REQ_NOWAIT
Date:   Mon, 26 Nov 2018 09:45:31 -0700
Message-Id: <20181126164544.5699-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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

