Return-Path: <SRS0=Wa/x=VC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58476C46499
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49821670
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562358755;
	bh=kKGSEqENuRUKk/uUHjETJ/Jtf1hqB16djJfPnhAmsGo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Su+ZgrPNsZlcM7L8S6r0C24lV8fD/c4oXNW700h8nERtljfbjZAcJM1+MGRUYqgH7
	 Zl5FOYyO9mZWkCF4Ndwg4fZ4OyX4pa1lgVx4P2dfrn09cuCXuU1utNaHRSJWqjbdRX
	 K7Uz00bQGtYUmJ/xAEOq+vgU3PMXcindWtgx7PPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGEUce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:32:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jul 2019 16:32:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so5085444pla.7;
        Fri, 05 Jul 2019 13:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3b4cKuNKKiQcE/sh1Kj/1ITgsHODRvYTQD//jYRx2DA=;
        b=tfkiTBQA7zkv1LpHyKX0Qv7psoSXRdl7rmSHqcJrIKKUdKt/5/qhLYnElR1CA8vCTf
         XIwch91wlle5+81U/xQH0ghVoyvnsGqWdeDr7SjgZy3MM2obFVk47T+LCwS3h/HIbwhT
         6FIeqz9WZNBBVquEimPqLYG1QqlCmPoncg/XtX9k1tmOKWEnH/6J2RSXbqGHhOtmond+
         v0UDOVkbC5e8C8GQuDhiRUNGo3co2PO5lBqs3kwYLQupcY7UVOn0BgZd3ci4CVN1vAwm
         v/zfHQjdlZViGOxADaztXX6P0/3aQV78tun/u+AfcEpBNvw0+yJxyaYIw+2jYXzVIwXe
         0ATg==
X-Gm-Message-State: APjAAAX0Es5F5A0GZEeObp4459+8QIwQ7pP2Ts1+zR38DwmpyFSHfRW7
        5yHlQ+4rmIuIMsbLWeohN8I=
X-Google-Smtp-Source: APXvYqxVZqNO854Twbw3y8zdpu7DMvmMYAU1EffN9udZm5KcVdm+ZvvCm3DPmvts6zUa7YOlEb5CNg==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr7233369plb.164.1562358753610;
        Fri, 05 Jul 2019 13:32:33 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j1sm11330773pfe.101.2019.07.05.13.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jul 2019 13:32:33 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blk-iolatency: fix STS_AGAIN handling
Date:   Fri,  5 Jul 2019 16:32:28 -0400
Message-Id: <20190705203228.77695-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The iolatency controller is based on rq_qos. It increments on
rq_qos_throttle() and decrements on either rq_qos_cleanup() or
rq_qos_done_bio(). a3fb01ba5af0 fixes the double accounting issue where
blk_mq_make_request() may call both rq_qos_cleanup() and
rq_qos_done_bio() on REQ_NO_WAIT. So checking STS_AGAIN prevents the
double decrement.

The above works upstream as the only way we can get STS_AGAIN is from
blk_mq_get_request() failing. The STS_AGAIN handling isn't a real
problem as bio_endio() skipping only happens on reserved tag allocation
failures which can only be caused by driver bugs and already triggers
WARN.

However, the fix creates a not so great dependency on how STS_AGAIN can
be propagated. Internally, we (Facebook) carry a patch that kills read
ahead if a cgroup is io congested or a fatal signal is pending. This
combined with chained bios progagate their bi_status to the parent is
not already set can can cause the parent bio to not clean up properly
even though it was successful. This consequently leaks the inflight
counter and can hang all IOs under that blkg.

To nip the adverse interaction early, this removes the rq_qos_cleanup()
callback in iolatency in favor of cleaning up always on the
rq_qos_done_bio() path.

Fixes: a3fb01ba5af0 ("blk-iolatency: only account submitted bios")
Debugged-by: Tejun Heo <tj@kernel.org>
Debugged-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 block/blk-iolatency.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index e8859350ab6e..c956eebf2d97 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -600,10 +600,6 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
 		return;
 
-	/* We didn't actually submit this bio, don't account it. */
-	if (bio->bi_status == BLK_STS_AGAIN)
-		return;
-
 	iolat = blkg_to_lat(bio->bi_blkg);
 	if (!iolat)
 		return;
@@ -622,6 +618,9 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 
 		inflight = atomic_dec_return(&rqw->inflight);
 		WARN_ON_ONCE(inflight < 0);
+		/* We didn't actually submit this bio, don't account for it. */
+		if (bio->bi_status == BLK_STS_AGAIN)
+			goto next;
 		if (iolat->min_lat_nsec == 0)
 			goto next;
 		iolatency_record_time(iolat, &bio->bi_issue, now,
@@ -639,27 +638,6 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	}
 }
 
-static void blkcg_iolatency_cleanup(struct rq_qos *rqos, struct bio *bio)
-{
-	struct blkcg_gq *blkg;
-
-	blkg = bio->bi_blkg;
-	while (blkg && blkg->parent) {
-		struct rq_wait *rqw;
-		struct iolatency_grp *iolat;
-
-		iolat = blkg_to_lat(blkg);
-		if (!iolat)
-			goto next;
-
-		rqw = &iolat->rq_wait;
-		atomic_dec(&rqw->inflight);
-		wake_up(&rqw->wait);
-next:
-		blkg = blkg->parent;
-	}
-}
-
 static void blkcg_iolatency_exit(struct rq_qos *rqos)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
@@ -671,7 +649,6 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 static struct rq_qos_ops blkcg_iolatency_ops = {
 	.throttle = blkcg_iolatency_throttle,
-	.cleanup = blkcg_iolatency_cleanup,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
 };
-- 
2.17.1

