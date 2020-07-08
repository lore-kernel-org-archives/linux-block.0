Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B7AC433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DD520672
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RmG9H1oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGHH7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH7a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 03:59:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28201C08C5DC
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 00:59:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so49373586ejc.3
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nrkWmuZbynTCM3f/uot82ff2fO71eir9goNysLeUz2E=;
        b=RmG9H1oOSBSNGo/T97+ya0G6yXyZCmXTHIM5aehQxamWs383yIiZwJwxh1HQ5CBeZ1
         CJi8BrLTX811AbY9Zs8DeWluHXXr4bU38RzynkigS48Iyvi1jAL7/mw4cyfxhnndvh/d
         zUKyKi9fenPYcENkF6Mdp+C+msaO/UhkX2fCmX0mkgna6dJirzRdWIQh++fMYZtvC9bz
         BH+dpgtvsp77UI1Q03opUrXhKiAxfWlT7O5xqGr54m2LYYyM3tU+3da8ucXl0WKlZdDF
         HJWBEPfykY+uWmBSJS55PI+1P2GI0Zcc2QaQeCBg9VRuGlnGf7O6tgAiLufHGcAZkpwn
         RfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nrkWmuZbynTCM3f/uot82ff2fO71eir9goNysLeUz2E=;
        b=b/UwuMdJYE2c2BoKpeIXR2RDiwrRCHuQk8LNbCGTMXfxBrGxE4Ib5p3PQwHN2/o8Fl
         Hca9TYPrI1hjGevUogOcUeeRs6S1xsrJ8jGcTgGEt3NwFHFpxeVepfv0Djn/1hWm/M9g
         qq45hHKgPdkDQZMMHx2MmrHFhcS6hH91cO7zPub1xq8djfBAb1keEORNSyUl2LLMMuXF
         X+CJBU7c9kQ1u6RjIyCVboG70cJFPb7/om7Eh9vyLiP8UQ+BJFXQXETMVWGgYnmZQX/e
         Q+c1lLruMMLsFRGbIAnND5hFnpiYg5dGnrnotFh/kHsJsJ50EPSx4H8xqQMTysAqUYf2
         bzUw==
X-Gm-Message-State: AOAM532vr7oAxlMEtlL+67e4pVIaK97rxIVAsId0PmSxFHgBV8EeLY0s
        9e1RTSDeZupwVcDSQqZ8/cbzfQ==
X-Google-Smtp-Source: ABdhPJz6fQHh44FVZ3nYKLo4pWFQDwYG6Ttpq89pfgkJ/Nb927v0oE90LAToh58TazOdqFHlL/u6Wg==
X-Received: by 2002:a17:906:7802:: with SMTP id u2mr52350656ejm.478.1594195168913;
        Wed, 08 Jul 2020 00:59:28 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b161:f409:fd1d:3a1f])
        by smtp.gmail.com with ESMTPSA id mj22sm1570858ejb.118.2020.07.08.00.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:59:28 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
Subject: [PATCH RFC 3/5] drbd: rename start_jif to start_ns
Date:   Wed,  8 Jul 2020 09:58:17 +0200
Message-Id: <20200708075819.4531-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let's rename start_jif to start_ns to reflect that bio_start_io_acct
returns ns presicion now.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/drbd/drbd_debugfs.c | 8 ++++----
 drivers/block/drbd/drbd_int.h     | 2 +-
 drivers/block/drbd/drbd_req.c     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index b3b9cd5628fd..672fd7e6587d 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -105,7 +105,7 @@ static void seq_print_one_request(struct seq_file *m, struct drbd_request *req,
 		(s & RQ_WRITE) ? "W" : "R");
 
 #define RQ_HDR_2 "\tstart\tin AL\tsubmit"
-	seq_printf(m, "\t%d", jiffies_to_msecs(now - req->start_jif));
+	seq_printf(m, "\t%llu", (ktime_get_ns() - req->start_ns) / NSEC_PER_MSEC);
 	seq_print_age_or_dash(m, s & RQ_IN_ACT_LOG, now - req->in_actlog_jif);
 	seq_print_age_or_dash(m, s & RQ_LOCAL_PENDING, now - req->pre_submit_jif);
 
@@ -161,7 +161,7 @@ static void seq_print_waiting_for_AL(struct seq_file *m, struct drbd_resource *r
 	seq_puts(m, "minor\tvnr\tage\t#waiting\n");
 	rcu_read_lock();
 	idr_for_each_entry(&resource->devices, device, i) {
-		unsigned long jif;
+		unsigned long ns;
 		struct drbd_request *req;
 		int n = atomic_read(&device->ap_actlog_cnt);
 		if (n) {
@@ -171,7 +171,7 @@ static void seq_print_waiting_for_AL(struct seq_file *m, struct drbd_resource *r
 			/* if the oldest request does not wait for the activity log
 			 * it is not interesting for us here */
 			if (req && !(req->rq_state & RQ_IN_ACT_LOG))
-				jif = req->start_jif;
+				ns = req->start_ns;
 			else
 				req = NULL;
 			spin_unlock_irq(&device->resource->req_lock);
@@ -179,7 +179,7 @@ static void seq_print_waiting_for_AL(struct seq_file *m, struct drbd_resource *r
 		if (n) {
 			seq_printf(m, "%u\t%u\t", device->minor, device->vnr);
 			if (req)
-				seq_printf(m, "%u\t", jiffies_to_msecs(now - jif));
+				seq_printf(m, "%llu\t", (ktime_get_ns() - ns) / NSEC_PER_MSEC);
 			else
 				seq_puts(m, "-\t");
 			seq_printf(m, "%u\n", n);
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index aacd2010b555..467d96316230 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -301,7 +301,7 @@ struct drbd_request {
 	struct list_head req_pending_local;
 
 	/* for generic IO accounting */
-	unsigned long start_jif;
+	unsigned long start_ns;
 
 	/* for DRBD internal statistics */
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index f705128b4f27..6ad6b4470ebd 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -245,7 +245,7 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 		start_new_tl_epoch(first_peer_device(device)->connection);
 
 	/* Update disk stats */
-	bio_end_io_acct(req->master_bio, req->start_jif);
+	bio_end_io_acct(req->master_bio, req->start_ns);
 
 	/* If READ failed,
 	 * have it be pushed back to the retry work queue,
@@ -1206,7 +1206,7 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio)
 	}
 
 	/* Update disk stats */
-	req->start_jif = bio_start_io_acct(req->master_bio);
+	req->start_ns = bio_start_io_acct(req->master_bio);
 
 	if (!get_ldev(device)) {
 		bio_put(req->private_bio);
-- 
2.17.1

