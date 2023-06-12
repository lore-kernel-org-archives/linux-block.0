Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E10C88CB2
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 20:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFLUdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjFLUdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:22 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC62BE56
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:20 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b3c5389fa2so11486525ad.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602000; x=1689194000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lGvwSDI7LLN74ZAuyT/VMv3HlxsqUq48elrI1Vl7fQ=;
        b=kVc/BLFZ8jzruqtT4OI0oTRkVy/esyoCEeK6RIkqwF5UpJp3w3WTlfvURwhhmcESTg
         KSfUN7ByBWVFO8wffS5bXUdhS4yZVgLgHrfUyayLJ4DU4Oszj8Sx1SDPqjhSCf38uVVj
         cZj1OBN1PW1GvZIzLNPDm4zKKvmu38ld+XTOfO4o72ns2S5KZBFyD8adpn2ADVLBLVwt
         /O+3avUku8DKySY//CWBczJRrD2q2BWzcmySfNOj/03Us0tFxWnZ+LEjZuOpeFoIq4sb
         4tbcvmzT32xkSisYUlTLo7dgjcql4Mi8/69dPgwp3omoSoxJUNHYzEagfFiSK4rLPe+C
         imxA==
X-Gm-Message-State: AC+VfDyJMF2db2tbjrGggtSw2mzWgA3Jxp9j3gFnQKqWkYkJRKQCh0rN
        tWR/jchMNXjwrG4a+galA0Q=
X-Google-Smtp-Source: ACHHUZ5h2SezzJYr202WZSuEJZKjzMjwqZpE01jUZI77FaEJLxcrDWtN6vXu0eBDrQDSSF002FtMwQ==
X-Received: by 2002:a17:902:f68a:b0:1ac:8062:4f31 with SMTP id l10-20020a170902f68a00b001ac80624f31mr9136199plg.37.1686602000334;
        Mon, 12 Jun 2023 13:33:20 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v6 1/8] block: Use pr_info() instead of printk(KERN_INFO ...)
Date:   Mon, 12 Jun 2023 13:33:07 -0700
Message-Id: <20230612203314.17820-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
References: <20230612203314.17820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to the modern style of printing kernel messages. Use %u instead
of %d to print unsigned integers.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Sandeep Dhavale <dhavale@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..1d8d2ae7bdf4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -127,8 +127,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 
 	if ((max_hw_sectors << 9) < PAGE_SIZE) {
 		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_hw_sectors);
+		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);
 	}
 
 	max_hw_sectors = round_down(max_hw_sectors,
@@ -248,8 +247,7 @@ void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments
 {
 	if (!max_segments) {
 		max_segments = 1;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_segments);
+		pr_info("%s: set to minimum %u\n", __func__, max_segments);
 	}
 
 	q->limits.max_segments = max_segments;
@@ -285,8 +283,7 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
 	if (max_size < PAGE_SIZE) {
 		max_size = PAGE_SIZE;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_size);
+		pr_info("%s: set to minimum %u\n", __func__, max_size);
 	}
 
 	/* see blk_queue_virt_boundary() for the explanation */
@@ -740,8 +737,7 @@ void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
 {
 	if (mask < PAGE_SIZE - 1) {
 		mask = PAGE_SIZE - 1;
-		printk(KERN_INFO "%s: set to minimum %lx\n",
-		       __func__, mask);
+		pr_info("%s: set to minimum %lx\n", __func__, mask);
 	}
 
 	q->limits.seg_boundary_mask = mask;
