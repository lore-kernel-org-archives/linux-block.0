Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8A4C7EE29
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjEVW0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjEVW0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:07 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA38109
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:02 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53469299319so3939102a12.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794361; x=1687386361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qae/V+JAOQd+3eACKtAvOPY5UNzsheKRP7tCBDSFUQ=;
        b=QLk11XnGw4p+NUHmc4tdXY04CYLr5m9KfpHWEkmfGaiI/uRHMhUMYFEY851vy8USwZ
         g14dsDwm77Uq4ApE/xzMIrE3omySxdKJIaf5WmwFkdz4x/YeDO/Pk89aLxBZIvs63xdE
         U/wU1Nb5VM46gJp+KUII5pcpSjPi7uHi79/byDx78ypZVeuV9vWiiLzNZpzikcxZp4Cy
         76p3gdyWsgklsfO+ILcNJp5D7U/zcXRAiNNt44SgMrWz5J28f4s8y4CoKF1AojA+orJJ
         1qHJSUQPJ9IWmVVD8e/XXNfKgppIsG75zC6nlpJS2IVElrcMRfVuYQNAucwkC8tLZbIm
         H2EQ==
X-Gm-Message-State: AC+VfDxbXvNYrfzIAge53x7DTY3l7bkxAVAcLm/gexPQC3mWbGvedylu
        l6mrHmBbBxomvK69dn+P+vg=
X-Google-Smtp-Source: ACHHUZ5j0u5TKPR9eWz53QTyN1zfPTXFujvdyGWB1U/qTRsF9TampeTGXHGQvmPvs8gn5+bmuMEqow==
X-Received: by 2002:a05:6a20:8f02:b0:105:dafa:feb3 with SMTP id b2-20020a056a208f0200b00105dafafeb3mr14077127pzk.61.1684794361177;
        Mon, 22 May 2023 15:26:01 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 1/9] block: Use pr_info() instead of printk(KERN_INFO ...)
Date:   Mon, 22 May 2023 15:25:33 -0700
Message-ID: <20230522222554.525229-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to the modern style of printing kernel messages. Use %u instead
of %d to print unsigned integers.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
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
