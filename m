Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE94CC433FE
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFB061502
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhJEPbT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbhJEPbS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:31:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BAAC06174E
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:29:28 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j15so22238984ila.6
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nc1FgnD/mSYqMld6sjsRt6tVpmIMdZPD5t5JRK+GtPQ=;
        b=ruSR8ca4l8fkTchOCj9w2x/+8imPlkfn1vNHg+Qo62P64JV/TGOAYBmy5yShly/sYC
         nNscVaNY1sO6xzm5NloCxyS4mz83lAbOZBmii+ZfOdyvrOaJYF60PBsOVVdprYH/ndDT
         rNxO/CodUXFonCcAJw5vdF9IAWH5v0uMjrDLvq0yYftjgFI09aPK10zqkSQs4sD5KGSt
         GxdEweYQ7VFevtOHFqOLfHy0YgnSCQs3DIrhA31qeqFjPahY1zI5fpnhupsBa14Eh/PY
         IdHy/5nf5F1wx5PA3l/EB4rNVBzzB4a3/j3fk/QcHnFzwSpEAim5bwJtV12YoNRmsYJ1
         Xn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nc1FgnD/mSYqMld6sjsRt6tVpmIMdZPD5t5JRK+GtPQ=;
        b=CpnzOpZ6tH60ZPCpriRE4zjzn+ZLcSth6JS4JzhGJSAXY1VFP+4H+iRYe+PLPjVOWd
         mlhqlR6KCrZFAmY8p5RkMbH0iY9VIXUv0MH4xs+zkozax8TI/t0z1KzpmUpt+HQKhCtK
         FdPRY+g0eV9FFVVh1xoMMnuwWKDM6Qw8SEdRE+o5LNhrrbiH2PJzbfaWwYQ/aAxm3ADM
         Mh2p0uClyRQ6f4iU7ZDRJGPbgCqGR4QmScGuBFJpdJYSRbJUWMek9VMTOTzBm/PkYHZQ
         9TqdSydZlqJa6crart7408s7TA0+JiVKhUU1wlWHq0qHwd5X3QxJMrgqDdXha4zt1IwL
         /ZJA==
X-Gm-Message-State: AOAM531CoAGWHyhD3Bmcol3VCsch9jjtona5DeoZXffJ/POitsN3JFlJ
        PDKbguxdqFRTbsB8XIJkNM1qqoIcr3rvHDlVR3c=
X-Google-Smtp-Source: ABdhPJyuMOaPh9ixqHeXqV4CV7cXW6VBecVooyEvjiqtaR4o7vPrY6GmVHCekm52jhQ1B6ANaqOo9g==
X-Received: by 2002:a05:6e02:190a:: with SMTP id w10mr3378933ilu.2.1633447767565;
        Tue, 05 Oct 2021 08:29:27 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m5sm6317762ild.45.2021.10.05.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:29:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     tj@kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: inherit request start time from bio for BLK_CGROUP
Date:   Tue,  5 Oct 2021 09:29:22 -0600
Message-Id: <20211005152922.57326-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005152922.57326-1-axboe@kernel.dk>
References: <20211005152922.57326-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Doing high IOPS testing with blk-cgroups enabled spends ~15-20% of the
time just doing ktime_get_ns() -> readtsc. We essentially read and
set the start time twice, one for the bio and then again when that bio
is mapped to a request.

Given that the time between the two is very short, inherit the bio
start time instead of reading it again. This cuts 1/3rd of the overhead
of the time keeping.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a8c437afc2c3..a40c94505680 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -718,7 +718,14 @@ void blk_mq_start_request(struct request *rq)
 	trace_block_rq_issue(rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		rq->io_start_time_ns = ktime_get_ns();
+		u64 start_time;
+#ifdef CONFIG_BLK_CGROUP
+		if (rq->bio)
+			start_time = bio_issue_time(&rq->bio->bi_issue);
+		else
+#endif
+			start_time = ktime_get_ns();
+		rq->io_start_time_ns = start_time;
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
-- 
2.33.0

