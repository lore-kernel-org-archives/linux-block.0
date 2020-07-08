Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21DFC433E1
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4720672
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Y4FjnqkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGHH7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 03:59:29 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E5C08C5DC
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 00:59:29 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so40856508edb.3
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d1La/axhT/8d5t9Aiud14eTBdaZWaa7PgEVZl8V6a7I=;
        b=Y4FjnqkAa3dAXCGTBn4aKdECC3vAa4sYo1/cDYBmmbSTpZ/YDuIL33IS4GCNQeMc4X
         fYjFEql0UQuN/iocsdDsGOH5wGLIjpUy1hyWyFwqc8mqMWmUFhlgrlbtsquAam+Udxec
         qKGxL6LQXUDzhk9fi0wKcKcXEb8Ot2BWPLegN+EckKh2YPbZy/1WLwJ5WRF/xPsBVjbi
         8Aj6l+rKV8kdSQ87iZ5SQCfLsTVQoEaRheEWw4v9ykgc9raZwU9lHJeXQfCTOPnb6R5r
         b6femXPdiKKp+tKYyLBOd9histw5KzSMzJXAKRYvs6lJykvNYT04IrHn2Ngw0ee4IKh8
         FlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d1La/axhT/8d5t9Aiud14eTBdaZWaa7PgEVZl8V6a7I=;
        b=SNPjx6st9GWO0a74zkfdmt+0ChEtrtN+vC1KYBBNX40y3aVxD+BAPVxbUrxqM9UnBO
         T8zX5qBQM8GbF1nhI0oAW7VFvykzS7v/fE2NryB+1Ou90zzU0YRKs4ZbX1tVVI54x6/A
         OyhUr+z10IF0qBCRNXBtXtOHD5nubPlm4afposnfiugZQXt3ts9QHcU5ZRz1DcJ9rKFO
         laaAoEYz4Lb+Z5Nxx4zzX0Rf4F16Khajb4KweCY6Cbn08wxdQOEr79r8gAlGqiAxa1x8
         H5LLTJxoG2bsgwquBafhg4auJSFHwz9HH9msbVh7PZDCKHiGZzYwbSYpR33anRADCigO
         OzXQ==
X-Gm-Message-State: AOAM533ip5S2SoYWt1urSja9BAZme/8X0Qzty1FsCPzk3e/Xy9S5iA3A
        82l6FZC4pU+aiirx7M3+gxRHAw==
X-Google-Smtp-Source: ABdhPJy2Jb+wDl/LMTi0wrDGkP0jOSRoR3G+rxq7VueNcnI68JbJFWmNFwLIr6Ow3Xr+mVc99qtAgg==
X-Received: by 2002:a50:a451:: with SMTP id v17mr46534548edb.256.1594195167995;
        Wed, 08 Jul 2020 00:59:27 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b161:f409:fd1d:3a1f])
        by smtp.gmail.com with ESMTPSA id mj22sm1570858ejb.118.2020.07.08.00.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:59:27 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
Subject: [PATCH RFC 2/5] drbd: remove unused argument from drbd_request_prepare and __drbd_make_request
Date:   Wed,  8 Jul 2020 09:58:16 +0200
Message-Id: <20200708075819.4531-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
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
This had been sent before, now it is better to include it in the thread.

https://marc.info/?l=linux-block&m=159369644305325&w=2


 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/block/drbd/drbd_main.c |  3 +--
 drivers/block/drbd/drbd_req.c  | 11 ++++-------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index fe6cb99eb917..aacd2010b555 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1450,7 +1450,7 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 
 /* drbd_req */
 extern void do_submit(struct work_struct *ws);
-extern void __drbd_make_request(struct drbd_device *, struct bio *, unsigned long);
+extern void __drbd_make_request(struct drbd_device *, struct bio *);
 extern blk_qc_t drbd_submit_bio(struct bio *bio);
 extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
 extern int is_valid_ar_handle(struct drbd_request *, sector_t);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7c34cc0ad8cc..42f2a235417c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2293,7 +2293,6 @@ static void do_retry(struct work_struct *ws)
 	list_for_each_entry_safe(req, tmp, &writes, tl_requests) {
 		struct drbd_device *device = req->device;
 		struct bio *bio = req->master_bio;
-		unsigned long start_jif = req->start_jif;
 		bool expected;
 
 		expected =
@@ -2328,7 +2327,7 @@ static void do_retry(struct work_struct *ws)
 		/* We are not just doing submit_bio_noacct(),
 		 * as we want to keep the start_time information. */
 		inc_ap_bio(device);
-		__drbd_make_request(device, bio, start_jif);
+		__drbd_make_request(device, bio);
 	}
 }
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 674be09b2da9..f705128b4f27 100644
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

