Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A46CC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 14:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA3F23A04
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbhAUOXp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbhAUOX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 09:23:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B30C061757
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 06:22:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c2so2414618edr.11
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CERj7KX7K7JrIuOWQ4oCgUXlbuWovrpN34BQcQ4mS0k=;
        b=a9DGwPU6YuxjdiXy7bPZGmuW3CRORweTSSDax0eZONL7sOJpHHSJ0hgTGdra9cfAB6
         UlyYKmbjsO6uej0cqbY7ee2hmntsFkLH9eZwXvBY9MguKkEPh4bHnL/iwcswLX6RLukF
         QnQNbyaa3W0x0OVAtWmuvLkvm6x+qBwP7XJQsU+5R8ggiQu+03d+vYrXKSbSR+99zko6
         LhuR1hAaU/WPo/qk4iGUV0B0VlrI7U56BHze2YlrKEd2iZ7qUZaIq6fNwz0miZiTN5hV
         KIfnpuGTDcWmTSHrC0stZpe/WoCjGTN6rnHRYoEFoCFCL0nafGeqqS1dGlMkkvBUyYlK
         dRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CERj7KX7K7JrIuOWQ4oCgUXlbuWovrpN34BQcQ4mS0k=;
        b=ql1q2mVq72T0GGYFvG7cp+J2SKIqANB9Fx4E4EFoIua87EGiZcOl0LMax9/exejTH3
         vHo5Z0g2gpoXIaNBJ4F6/W5KOvnTTz+TaMbhkT4Ko3ktX8VIZkyzQ3doGkFhFsRv3mer
         np+qguGdpvlqGuNw3g9hASZyAYfaN09TH9AvVBnvGc2mlnwMyLH+TAqFmHH1RLUIhSND
         xpC2Mc0ikN3g46ulWnW21ZK75kaVx0YLao68TIvLH1OeyDBn5XYxpkB6vSvnVvMA5XQM
         xby9KY3HsAs7YpDCyfOpazVZhvCahpHozd9eWBrw/sEyvPe+ps3B29QIyQHtcU2LvLmn
         0SzQ==
X-Gm-Message-State: AOAM532d3khPcaYWcdRFw4cDQWL/JoK72HjU7iz1ywpoO6Z4/3Fxsrxa
        iz2GRLBQ9PXtvbB6fGSkgZGdlw==
X-Google-Smtp-Source: ABdhPJzzcFoJ1Sc53EmjDpU1L67A0MtbbKiS5vfFPW1i5Jmk6+i953CLLAopcb/AM2SXCf6cHXXcjA==
X-Received: by 2002:a05:6402:160f:: with SMTP id f15mr11332273edv.348.1611238941391;
        Thu, 21 Jan 2021 06:22:21 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
        by smtp.gmail.com with ESMTPSA id f20sm2868405edd.47.2021.01.21.06.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 06:22:20 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
Subject: [PATCH RESEND] drbd: remove unused argument from drbd_request_prepare and __drbd_make_request
Date:   Thu, 21 Jan 2021 15:21:50 +0100
Message-Id: <20210121142150.12998-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can remove start_jif since it is not used by drbd_request_prepare,
then remove it from __drbd_make_request further.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/block/drbd/drbd_main.c |  3 +--
 drivers/block/drbd/drbd_req.c  | 11 ++++-------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 8f879e5c2f67..8faa31a17b8f 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1449,7 +1449,7 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 
 /* drbd_req */
 extern void do_submit(struct work_struct *ws);
-extern void __drbd_make_request(struct drbd_device *, struct bio *, unsigned long);
+extern void __drbd_make_request(struct drbd_device *, struct bio *);
 extern blk_qc_t drbd_submit_bio(struct bio *bio);
 extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
 extern int is_valid_ar_handle(struct drbd_request *, sector_t);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1c8c18b2a25f..7e5fcce812e1 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2288,7 +2288,6 @@ static void do_retry(struct work_struct *ws)
 	list_for_each_entry_safe(req, tmp, &writes, tl_requests) {
 		struct drbd_device *device = req->device;
 		struct bio *bio = req->master_bio;
-		unsigned long start_jif = req->start_jif;
 		bool expected;
 
 		expected =
@@ -2323,7 +2322,7 @@ static void do_retry(struct work_struct *ws)
 		/* We are not just doing submit_bio_noacct(),
 		 * as we want to keep the start_time information. */
 		inc_ap_bio(device);
-		__drbd_make_request(device, bio, start_jif);
+		__drbd_make_request(device, bio);
 	}
 }
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 330f851cb8f0..5e5602af9643 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1188,7 +1188,7 @@ static void drbd_queue_write(struct drbd_device *device, struct drbd_request *re
  * Returns ERR_PTR(-ENOMEM) if we cannot allocate a drbd_request.
  */
 static struct drbd_request *
-drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long start_jif)
+drbd_request_prepare(struct drbd_device *device, struct bio *bio)
 {
 	const int rw = bio_data_dir(bio);
 	struct drbd_request *req;
@@ -1416,9 +1416,9 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 		complete_master_bio(device, &m);
 }
 
-void __drbd_make_request(struct drbd_device *device, struct bio *bio, unsigned long start_jif)
+void __drbd_make_request(struct drbd_device *device, struct bio *bio)
 {
-	struct drbd_request *req = drbd_request_prepare(device, bio, start_jif);
+	struct drbd_request *req = drbd_request_prepare(device, bio);
 	if (IS_ERR_OR_NULL(req))
 		return;
 	drbd_send_and_submit(device, req);
@@ -1596,19 +1596,16 @@ void do_submit(struct work_struct *ws)
 blk_qc_t drbd_submit_bio(struct bio *bio)
 {
 	struct drbd_device *device = bio->bi_disk->private_data;
-	unsigned long start_jif;
 
 	blk_queue_split(&bio);
 
-	start_jif = jiffies;
-
 	/*
 	 * what we "blindly" assume:
 	 */
 	D_ASSERT(device, IS_ALIGNED(bio->bi_iter.bi_size, 512));
 
 	inc_ap_bio(device);
-	__drbd_make_request(device, bio, start_jif);
+	__drbd_make_request(device, bio);
 	return BLK_QC_T_NONE;
 }
 
-- 
2.17.1

