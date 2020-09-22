Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69131C4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1C421D91
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbCTFiiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgIVCc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 22:32:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85188C061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b2so14383675qtp.8
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kx5MVQ6xbvL7SHYiOkls0hYmmDYxo6c0riPFgM+lrnY=;
        b=DbCTFiiKgwYTisI7zwDF25LFzr/TNByZUa+MYb1qTBrQcTqQm4ORV5/O9lfA+UJQGz
         +auGPrV8++8UwJrFvrctpmCmIWMmLl3M0sfKXJ7xOudTfk+vRw96qPBDZzdUBuT5jhIG
         EQfVZurfX8DpkhBD0em1XYsAyJk64++OkH78YJR/eQi8BfC6SJAkpkXqBJc419B/5CoQ
         ic0xIubgR9lJWVcBTLIMu3KB4wOTAZDCN24k0XLV17LRYGuxu+HNO16G1yGaU5vmtIoV
         JgX/mWKmSq6dCWB8ZtG62+KIyDnGTpTJL1xhDxB9fW3wikEiga2a6o5hfJS/XPiM+oCy
         R7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Kx5MVQ6xbvL7SHYiOkls0hYmmDYxo6c0riPFgM+lrnY=;
        b=dNUDssoLXdENPmH2jWPG8Bne6vVlp9tKRyBMBSIAQYuX9e0w2IXpugqBZuoXBz67rK
         NhKruMukO7mE/nzCJDTvjNfKQB2r5PJD1Tt3inY+Vl5wDQxRTbMP62CHp4hHkNhnKzXt
         ibSwfPtIZLh9KOPlJoZTHAKF4Q0pi9SuOZ8xYbPHVLbMKczIGoDkgP/xAUVKOjocQJ/c
         Rlivbanq/l0wodZDXTTyRxGBm3/nQw6+nIKsiMUTJWHwiNhFKp8SHIuWGOYEiuAmROg7
         7nknxxoMvRCj3T5yYOyn2CmIOqAFDi0kAd468uuxWr4ciWSqapcJlvKIpmN/DHdrrD7v
         GGKA==
X-Gm-Message-State: AOAM530D5NzhmOD+dKQsZSqZ9d2kDF7VNCQANnRs+uBMFfChF4ibBDdv
        PsmLZXDnCr/OOTtt0i80jhY=
X-Google-Smtp-Source: ABdhPJwRDDrM3bVoPqW8HIr2Xj7UzfZ1I3ZNuN8k4ylYbPXjcOuy7Qmicr1i6OuGmq6x2BBeJENvSw==
X-Received: by 2002:ac8:d01:: with SMTP id q1mr2768872qti.276.1600741977737;
        Mon, 21 Sep 2020 19:32:57 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d10sm10397116qkk.1.2020.09.21.19.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:32:57 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 3/6] block: use lcm_not_zero() when stacking chunk_sectors
Date:   Mon, 21 Sep 2020 22:32:48 -0400
Message-Id: <20200922023251.47712-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200922023251.47712-1-snitzer@redhat.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Like 'io_opt', blk_stack_limits() should stack 'chunk_sectors' using
lcm_not_zero() rather than min_not_zero() -- otherwise the final
'chunk_sectors' could result in sub-optimal alignment of IO to
component devices in the IO stack.

Also, if 'chunk_sectors' isn't a multiple of 'physical_block_size'
then it is a bug in the driver and the device should be flagged as
'misaligned'.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 76a7e03bcd6c..b2e1a929a6db 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -534,6 +534,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->io_min = max(t->io_min, b->io_min);
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
 
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
@@ -556,6 +557,13 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		ret = -1;
 	}
 
+	/* chunk_sectors a multiple of the physical block size? */
+	if ((t->chunk_sectors << 9) & (t->physical_block_size - 1)) {
+		t->chunk_sectors = 0;
+		t->misaligned = 1;
+		ret = -1;
+	}
+
 	t->raid_partial_stripes_expensive =
 		max(t->raid_partial_stripes_expensive,
 		    b->raid_partial_stripes_expensive);
@@ -594,10 +602,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
-	if (b->chunk_sectors)
-		t->chunk_sectors = min_not_zero(t->chunk_sectors,
-						b->chunk_sectors);
-
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
-- 
2.15.0

