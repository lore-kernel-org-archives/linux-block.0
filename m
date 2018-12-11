Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B54C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8883A20851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544569282;
	bh=2fkjqC+32K93gERFoGqtP9cTKCt3i/cd1qUFDq6aAQA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LkQReanhFKDFdaK8/RS1req0t/47C1HnW5MP/YlXLlUwRXAyU9Z5f2U5y+davbkUQ
	 gbzkAKgobzhWvrgAr8o6aa1xohp/Rl7kfJxs3swH7zm9FgxpkF/iEXYBqV3zKlX+e6
	 YUSqxxHtPCRCi0YKOurX+n43B/nFzJJXOhrATVic=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8883A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLKXBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:01:21 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34378 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKXBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:01:21 -0500
Received: by mail-yb1-f196.google.com with SMTP id k136so3787079ybk.1;
        Tue, 11 Dec 2018 15:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GaHalUQN5CBpxDu6FDNAS9ymKp2tTj7f/LYcrudYJgE=;
        b=peot/HoX9uykDgUGvQKg9x6DEtqpPlUu6EeU7dmnQBgQ88AgPC8DvxIQAl7wvD6y1V
         pO3mcyDFnrQPA6EJuVI3WTsHL5Qq3xGbLqG5Jmyrb7Yi0aKaDLNET8tTXZBscTHgzB1B
         TyPjAh6EwBM1CD+7GsD/HRp5n0EmmpropsTsYsvdb0vp7NAg4+ZIVFd6QECJPXSdKM0u
         BfRmj25V1dG5mip50IEIHjjW/IqhCKZlng1UTTqcbXBo5CfxhLFUJsn/THb8V1fAUrs/
         IPYg7eu4i6YbWhL6/K0jV8cgWGF8qHqeRF7ntWn78CrHahwk5BenACH/JxMIB9jxx/8x
         Xt5w==
X-Gm-Message-State: AA+aEWYQznHIZBNmI180tqa/SCiq49Lk1JTDJpVrfEbUCNOeQgUUXS+Q
        rod8y8ALDVFbVsvX7/+qcWY=
X-Google-Smtp-Source: AFSGD/ViLF9UGxJyhqvghhqcfWbjGK744cVcF5Hx3acGBOl3FId+FYeIqX68YuKU7PsJlX1r602Jrw==
X-Received: by 2002:a25:5bd6:: with SMTP id p205mr17894621ybb.283.1544569280779;
        Tue, 11 Dec 2018 15:01:20 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q187sm4957156ywb.40.2018.12.11.15.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 15:01:19 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v2] block: fix iolat timestamp and restore accounting semantics
Date:   Tue, 11 Dec 2018 18:01:14 -0500
Message-Id: <20181211230114.65967-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The blk-iolatency controller measures the time from rq_qos_throttle() to
rq_qos_done_bio() and attributes this time to the first bio that needs
to create the request. This means if a bio is plug-mergeable or
bio-mergeable, it gets to bypass the blk-iolatency controller.

The recent series, to tag all bios w/ blkgs in [1] changed the timing
incorrectly as well. First, the iolatency controller was tagging bios
and using that information if it should process it in rq_qos_done_bio().
However, now that all bios are tagged, this caused the atomic_t for the
struct rq_wait inflight count to underflow resulting in a stall. Second,
now the timing was using the duration a bio from generic_make_request()
rather than the timing mentioned above.

This patch fixes these issues by reusing the BLK_QUEUE_ENTERED flag to
determine if a bio has entered the request layer and is responsible for
starting a request. Stacked drivers don't recurse through
blk_mq_make_request(), so the overhead of using time between
generic_make_request() and the blk_mq_get_request() should be minimal.
blk-iolatency now checks if this flag is set to determine if it should
process the bio in rq_qos_done_bio().

[1] https://lore.kernel.org/lkml/20181205171039.73066-1-dennis@kernel.org/

Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
v2:
- Switched to reusing BIO_QUEUE_ENTERED rather than adding a second
  timestamp to the bio struct.

 block/blk-iolatency.c |  2 +-
 block/blk-mq.c        | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index bee092727cad..e408282bdc4c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -593,7 +593,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	bool enabled = false;
 
 	blkg = bio->bi_blkg;
-	if (!blkg)
+	if (!blkg || !bio_flagged(bio, BIO_QUEUE_ENTERED))
 		return;
 
 	iolat = blkg_to_lat(bio->bi_blkg);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9690f4f8de7e..05ac940e6671 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1920,6 +1920,17 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	struct request *same_queue_rq = NULL;
 	blk_qc_t cookie;
 
+	/*
+	 * The flag BIO_QUEUE_ENTERED is used for two purposes.  First, it
+	 * determines if a bio is being split and has already entered the queue.
+	 * This happens in blk_queue_split() where we can recursively call
+	 * generic_make_request().  The second use is to mark bios that will
+	 * call rq_qos_throttle() and subseqently blk_mq_get_request().  These
+	 * are the bios that fail plug-merging and bio-merging with the primary
+	 * use case for this being the blk-iolatency controller.
+	 */
+	bio_clear_flag(bio, BIO_QUEUE_ENTERED);
+
 	blk_queue_bounce(q, &bio);
 
 	blk_queue_split(q, &bio);
@@ -1934,6 +1945,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	if (blk_mq_sched_bio_merge(q, bio))
 		return BLK_QC_T_NONE;
 
+	bio_set_flag(bio, BIO_QUEUE_ENTERED);
 	rq_qos_throttle(q, bio);
 
 	rq = blk_mq_get_request(q, bio, &data);
-- 
2.17.1

