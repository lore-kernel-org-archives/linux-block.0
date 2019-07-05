Return-Path: <SRS0=Wa/x=VC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F4C468A7
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 21:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFB220449
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 21:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562360955;
	bh=zy4SXhrp9jiZqBkC6elc4q0hK9jGGrlY0sGqHRcDNGw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vJ3gIHCkerdkqUfm7BrKq1c3cGouLCerY76yaylhAEpaVA2PJimvVX9j22a4GZolZ
	 H20hcF0pBpAbaHn0V6n1jQ02YoyPG5RXpkbL1vC48y9sp371Tj8WbxM38mc0021AFx
	 OEBvC7aKuZSMJM+u9NrNtj4PH0LZYRWaNtkCSO5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfGEVJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:09:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41658 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGEVJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jul 2019 17:09:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so4776658pgj.8;
        Fri, 05 Jul 2019 14:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0V9sHkDoDZ2ti13DRCJKAl1jtpHUiUPra2GCaGAZam0=;
        b=fEyryHs1jqPC6ANz6uHtLQOvlWSbFF9aD8BhPXAzSEfpwC/eZWy+4MDdsVmkOcokFe
         gfCpOKoBYBvcWo+yT3TMUB74O2oIqDF9aL76MAL4odJvg57eQPljwE+awUQfhSeRH4va
         vKzfXBkZXAj+1Ii6CXwg57U0QUwENd1MtjJwKnlNYE4EPzguMAOQ1xc3KIMbBzDTtbu0
         QW5JWXmRYqDUQPee7WWB9LQ4HAPc1rKEJPrHLwuyHuMssvW+RM5z6yzWUYyzTNtguLg7
         RIDMNSplaOwQWkWhGPsRzTczsF+lrYbV0CY8fqyFNqId/kJYcgxb06vPJ5IZ0hpPOWfM
         JQzw==
X-Gm-Message-State: APjAAAWES0dM6yzyRuC3eKfi69QPcIb4SBCW5fgBPopiRUb1OR6CzeBj
        BiEiPoCFlXC0oUe7vJXQ44+mHlQj
X-Google-Smtp-Source: APXvYqyIXUmSRc7ObN8oWAQnw8hhZMyOLg5PIN6p5ZqbAyIuYYBzNNBgl2bM1LDN7PmMmzeY0fCQ6A==
X-Received: by 2002:a63:1657:: with SMTP id 23mr7149268pgw.98.1562360954138;
        Fri, 05 Jul 2019 14:09:14 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t11sm11018194pgb.33.2019.07.05.14.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jul 2019 14:09:13 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v2] blk-iolatency: fix STS_AGAIN handling
Date:   Fri,  5 Jul 2019 17:09:09 -0400
Message-Id: <20190705210909.82263-1-dennis@kernel.org>
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
 block/blk-iolatency.c | 51 ++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index e8859350ab6e..d973c38ee4fd 100644
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
@@ -622,40 +618,22 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 
 		inflight = atomic_dec_return(&rqw->inflight);
 		WARN_ON_ONCE(inflight < 0);
-		if (iolat->min_lat_nsec == 0)
-			goto next;
-		iolatency_record_time(iolat, &bio->bi_issue, now,
-				      issue_as_root);
-		window_start = atomic64_read(&iolat->window_start);
-		if (now > window_start &&
-		    (now - window_start) >= iolat->cur_win_nsec) {
-			if (atomic64_cmpxchg(&iolat->window_start,
-					window_start, now) == window_start)
-				iolatency_check_latencies(iolat, now);
+		/*
+		 * If bi_status is BLK_STS_AGAIN, the bio wasn't actually
+		 * submitted, so do not account for it.
+		 */
+		if (iolat->min_lat_nsec && bio->bi_status != BLK_STS_AGAIN) {
+			iolatency_record_time(iolat, &bio->bi_issue, now,
+					      issue_as_root);
+			window_start = atomic64_read(&iolat->window_start);
+			if (now > window_start &&
+			    (now - window_start) >= iolat->cur_win_nsec) {
+				if (atomic64_cmpxchg(&iolat->window_start,
+					     window_start, now) == window_start)
+					iolatency_check_latencies(iolat, now);
+			}
 		}
-next:
-		wake_up(&rqw->wait);
-		blkg = blkg->parent;
-	}
-}
-
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
 		wake_up(&rqw->wait);
-next:
 		blkg = blkg->parent;
 	}
 }
@@ -671,7 +649,6 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 static struct rq_qos_ops blkcg_iolatency_ops = {
 	.throttle = blkcg_iolatency_throttle,
-	.cleanup = blkcg_iolatency_cleanup,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
 };
-- 
2.17.1

