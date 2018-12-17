Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53542C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A992145D
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545062644;
	bh=g1cipyX/ml4CsEO/LzIRh5/VHCQ/oKWBZNNrqN2IJCY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HIDcIcrL5s0Oa9f9fsD65jYXsMWhKZjt0wx7d/u3R9mkqyn+dWqVkHDrHPXafswHA
	 rKZ5vd9U+5mFdRo+ITDxk/8FaHtAIy4gwtM+bR60O5r+VzS8EFwDLPMXMWWSKQVC6V
	 7NSYSgTRjBdfGf6V2HaXEMe6wW1xXEgaGNSBfPco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeLQQD6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:03:58 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41015 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeLQQD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 11:03:57 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so5365164ywc.8;
        Mon, 17 Dec 2018 08:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L5rGZCuzin7GjzYmFJwbDOmDQPDvurbU8ESwuOCO24c=;
        b=bea8MrlXnfd+yUZRDAbrVjszV486fIdELfmrRLq5X7fvxHfDASRuWnYO7SqlM8mo+w
         5sSzcXWuObnk4lzDQvJ/iLZ5vtg8meyHFvUDF/kXs3XDQszb2YuVItQD6ilL3VFUIwyg
         YbL02Qu41eQK8kVbFjGsvio4NHcTpK7SjeOmLcCb+ylUOxbajfAdHlLFQYmfxjXGGtQR
         5obZ5OfslaiQauH2zwGBkzQQ8na/VGQu8VE5zgfjDgTDAgHdG/2SdIdakJ6zcKbV41UC
         THtZeZ5sv+KLx8w6ud799ld6OHa+cGU5aak0XpVQXQGBes6tSl3sbEgS2N020SUItJgd
         8FHw==
X-Gm-Message-State: AA+aEWaj4oezgcCrZLc4YRp08StT2xrNYlKrQSh8k/c+dMKW3vrUA6A0
        +xyUikUxH2pwdk1H/UWT3aDIXR/g
X-Google-Smtp-Source: AFSGD/UFUPjAM5mtxlSqOVBxqstFvWl+qNgT2c1VtEdmY0Hzg7cqbprmNRcTCgaXG6pGSPE/Qi0nEQ==
X-Received: by 2002:a81:7242:: with SMTP id n63mr13774603ywc.495.1545062635218;
        Mon, 17 Dec 2018 08:03:55 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4525642ywb.34.2018.12.17.08.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 08:03:54 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v3] block: fix blk-iolatency accounting underflow
Date:   Mon, 17 Dec 2018 11:03:51 -0500
Message-Id: <20181217160351.27903-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The blk-iolatency controller measures the time from rq_qos_throttle() to
rq_qos_done_bio() and attributes this time to the first bio that needs
to create the request. This means if a bio is plug-mergeable or
bio-mergeable, it gets to bypass the blk-iolatency controller.

The recent series [1], to tag all bios w/ blkgs undermined how iolatency
was determining which bios it was charging and should process in
rq_qos_done_bio(). Because all bios are being tagged, this caused the
atomic_t for the struct rq_wait inflight count to underflow and result
in a stall.

This patch adds a new flag BIO_TRACKED to let controllers know that a
bio is going through the rq_qos path. blk-iolatency now checks if this
flag is set to see if it should process the bio in rq_qos_done_bio().

Overloading BLK_QUEUE_ENTERED works, but makes the flag rules confusing.
BIO_THROTTLED was another candidate, but the flag is set for all bios
that have gone through blk-throttle code. Overloading a flag comes with
the burden of making sure that when either implementation changes, a
change in setting rules for one doesn't cause a bug in the other. So
here, we unfortunately opt for adding a new flag.

[1] https://lore.kernel.org/lkml/20181205171039.73066-1-dennis@kernel.org/

Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c     | 2 +-
 block/blk-rq-qos.h        | 5 +++++
 include/linux/blk_types.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index bee092727cad..fc714ef402a6 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -593,7 +593,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	bool enabled = false;
 
 	blkg = bio->bi_blkg;
-	if (!blkg)
+	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
 		return;
 
 	iolat = blkg_to_lat(bio->bi_blkg);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index fd8a0c5debd3..58f62483b537 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -170,6 +170,11 @@ static inline void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
 
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
+	/*
+	 * BIO_TRACKED lets controllers know that a bio went through the
+	 * normal rq_qos path.
+	 */
+	bio_set_flag(bio, BIO_TRACKED);
 	if (q->rq_qos)
 		__rq_qos_throttle(q->rq_qos, bio);
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 46c005d601ac..fc99474ac968 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -228,6 +228,7 @@ struct bio {
 #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
 				 * of this bio. */
 #define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
+#define BIO_TRACKED 12		/* set if bio goes through the rq_qos path */
 
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
-- 
2.17.1

