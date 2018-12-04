Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B1C07E85
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BA620672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Z10VZR7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BA620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLDR7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:59:15 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40611 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDR7P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:59:15 -0500
Received: by mail-yw1-f68.google.com with SMTP id r130so7335324ywg.7
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=JFjeMkzQnvt65WEN65pEXIU7mUFoHGUxDprOdq3GdMc=;
        b=Z10VZR7AltmR99fgUrNlg7bMI3R9gi2H3SSZBRJEKakqVFueUr6VWNK0CpNsadNlkJ
         l1u5vIud9MGgCKTnFiUPxcNmKkVFYcZoilEUbHJW0PNs/aYoUpUS9hlSpQ+mhpX24gDX
         b05KfLrdYJA+uuHg+HitxUMXsI3xgzZ1SI34o1fXn7MUsxyFeUwxuqy2IDPZCTAbJ9BK
         jAX7ld/f4Y5fwUmOSXTY4zLDg9yiml/pDKArAG/rUAn3JeD6EXjhHv2zCBcJdh1vd8Di
         FctCRroPbro3Qh0LWELdH6GONz/1zp0SwrXUdenewsd5CPDBko7HlC34k+YrPY/rZ+ln
         XICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=JFjeMkzQnvt65WEN65pEXIU7mUFoHGUxDprOdq3GdMc=;
        b=qdNGJRBKEgm05nYpvHcYTPwbiIeLdH6+mlc7p3QgybisVQoqkHqwMy9U75MOxDkxSA
         elmT/FlH6mYXUqEdmdTUavmUGAU92J08K8WVBfakqtr6NUXqYxF9TPpdoVGikulSEIzh
         IXXG6k5Gz4VRSxnhCa1WISyaVy4w71pCQd6slaP++e4LdjRTjfNa+k5YOxz9xZ9arMe7
         eD99Exd+DVgRfrboL/W6LOMYBkQDC19DLvJ2kBP2AVYIuwTyHOugThxZYyxp818rerfT
         GodrJtRI0VEay98aAxfQdqZYMxoYyH8zWCZUQM6o7wXactv6/uZfBDpzDdkTFxCP+T9i
         RjoQ==
X-Gm-Message-State: AA+aEWb8/rVPlG7z22/2UPw1weCZPDVnfgNJfpRpfeqH7YIXHJPnyCUA
        G3tAzhYYv3reyLn8CLK9xnBAQw==
X-Google-Smtp-Source: AFSGD/UAf0G0QCSBSR3IpX5Fvy4gTOjixuaZogDnHc5nBdYFjZAiNrihVNryutKt9zU9jeIk6z7CTQ==
X-Received: by 2002:a81:ac44:: with SMTP id z4mr21124157ywj.178.1543946354278;
        Tue, 04 Dec 2018 09:59:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m67sm5397105ywb.54.2018.12.04.09.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:59:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCH 3/3] block: convert io-latency to use rq_qos_wait
Date:   Tue,  4 Dec 2018 12:59:04 -0500
Message-Id: <20181204175904.8486-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181204175904.8486-1-josef@toxicpanda.com>
References: <20181204175904.8486-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have this common helper, convert io-latency over to use it
as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 5f7f1773be61..ac74b41f4131 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -262,15 +262,15 @@ static inline void iolat_update_total_lat_avg(struct iolatency_grp *iolat,
 				   stat->rqs.mean);
 }
 
-static inline bool iolatency_may_queue(struct iolatency_grp *iolat,
-				       wait_queue_entry_t *wait,
-				       bool first_block)
+static void iolat_cleanup_cb(struct rq_wait *rqw, void *private_data)
 {
-	struct rq_wait *rqw = &iolat->rq_wait;
+	atomic_dec(&rqw->inflight);
+	wake_up(&rqw->wait);
+}
 
-	if (first_block && waitqueue_active(&rqw->wait) &&
-	    rqw->wait.head.next != &wait->entry)
-		return false;
+static bool iolat_acquire_inflight(struct rq_wait *rqw, void *private_data)
+{
+	struct iolatency_grp *iolat = private_data;
 	return rq_wait_inc_below(rqw, iolat->rq_depth.max_depth);
 }
 
@@ -281,8 +281,6 @@ static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
 {
 	struct rq_wait *rqw = &iolat->rq_wait;
 	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
-	DEFINE_WAIT(wait);
-	bool first_block = true;
 
 	if (use_delay)
 		blkcg_schedule_throttle(rqos->q, use_memdelay);
@@ -299,20 +297,7 @@ static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
 		return;
 	}
 
-	if (iolatency_may_queue(iolat, &wait, first_block))
-		return;
-
-	do {
-		prepare_to_wait_exclusive(&rqw->wait, &wait,
-					  TASK_UNINTERRUPTIBLE);
-
-		if (iolatency_may_queue(iolat, &wait, first_block))
-			break;
-		first_block = false;
-		io_schedule();
-	} while (1);
-
-	finish_wait(&rqw->wait, &wait);
+	rq_qos_wait(rqw, iolat, iolat_acquire_inflight, iolat_cleanup_cb);
 }
 
 #define SCALE_DOWN_FACTOR 2
-- 
2.14.3

