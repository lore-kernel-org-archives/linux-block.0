Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D3CC433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 12:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DBC20702
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 12:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="a74F5Uiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgGAMjw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgGAMjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 08:39:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B147EC03E979
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 05:39:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b15so19542530edy.7
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ipdB2i7ibhCad/VO5r4zs//Ta+EMMsKIp2Eo4tcET/Q=;
        b=a74F5Uiyo86yrxUZNacooIXbEsslb7dzafue0cTCoeDKzEuLgTHHY3pyEGqRnFYK94
         DOlYF7Hrk+Rz63Hx8ZkCKOGlf4HDuCNAf33WV4U6wTuWoY4ptM7mqiFQHI7aILVVqtgu
         rQzj5vY0yjrsVVpa0rtlN0Px+Bmp3qXAYurYt4lhozJOCyvz2sFo3pUJ1zP6zAv2ZzmH
         HugdY8nfJTwvfFIpshzMZr/fVXdgm/T1Lk/TawN/4Kp9uFZ2k/2SozjIkFQ4uX3ouh9i
         TuBXB2LkaMyPZtq76jkQERyO9t+88NufgO5eIcbP792GhJf1K3atcoy1ljaBTt7iTyTy
         LCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ipdB2i7ibhCad/VO5r4zs//Ta+EMMsKIp2Eo4tcET/Q=;
        b=A/dJatLwzf/gGmcqDnG1/zEbyf/wMIb0ifRIFz1fKlp1cDIj7YM/cjTgFcNRUE5hIg
         rBIwhMTtjE41DvveE31SW4bIlWx8FR0Wzg9xmbEyGgz6VUQea6J/gwrgu1qCic8dcia0
         aC4Lc4bFcoh1BDSPzl+UnXrPDrV8BtFEP8cvtfN/Zz1oobcMchh3sAcZotMO6mZnsCoj
         FTOGPx9YHPu+PJ17dpBYLiJr7KLcj0zNoS/2ytadQ6TE/flnyzRuBt9goVWafPLeOmK6
         CAdnJKowGBgUBFPOTO7hPq2y0D4wMBHac3/1U6KPDJ2Sb3xW+A6GhSaxINhUxE5QdQo8
         U+eA==
X-Gm-Message-State: AOAM533xqA86rouTJ5CDD93CA8FLDhZos94GM8oiKkwCv62HuL0gn/+n
        Esyn2SSOzK2cpAzRpFpjBjkwr3fSOjOCNg==
X-Google-Smtp-Source: ABdhPJxzqH3rXBPIrV3haWYGUnWam/2ouh25kSyNysiTvKCYVWdM5nAyN9mo2ueEIwSnaY1+iwCevw==
X-Received: by 2002:aa7:d3cd:: with SMTP id o13mr28151009edr.176.1593607190373;
        Wed, 01 Jul 2020 05:39:50 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:48f3:8a00:2d1a:d73b:b882:b3])
        by smtp.gmail.com with ESMTPSA id p18sm4635381ejm.55.2020.07.01.05.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:39:49 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] drbd: remove unused argument from drbd_request_prepare and __drbd_make_request
Date:   Wed,  1 Jul 2020 14:38:32 +0200
Message-Id: <20200701123832.3868-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can remove start_jif since it is not used by drbd_request_prepare,
then remove it from __drbd_make_request further.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/block/drbd/drbd_main.c |  3 +--
 drivers/block/drbd/drbd_req.c  | 11 ++++-------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 33d0831c99b6..512888514c9e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1450,7 +1450,7 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 
 /* drbd_req */
 extern void do_submit(struct work_struct *ws);
-extern void __drbd_make_request(struct drbd_device *, struct bio *, unsigned long);
+extern void __drbd_make_request(struct drbd_device *, struct bio *);
 extern blk_qc_t drbd_make_request(struct request_queue *q, struct bio *bio);
 extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
 extern int is_valid_ar_handle(struct drbd_request *, sector_t);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 45fbd526c453..2aff9a3f06e3 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2292,7 +2292,6 @@ static void do_retry(struct work_struct *ws)
 	list_for_each_entry_safe(req, tmp, &writes, tl_requests) {
 		struct drbd_device *device = req->device;
 		struct bio *bio = req->master_bio;
-		unsigned long start_jif = req->start_jif;
 		bool expected;
 
 		expected =
@@ -2327,7 +2326,7 @@ static void do_retry(struct work_struct *ws)
 		/* We are not just doing generic_make_request(),
 		 * as we want to keep the start_time information. */
 		inc_ap_bio(device);
-		__drbd_make_request(device, bio, start_jif);
+		__drbd_make_request(device, bio);
 	}
 }
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c80a2f1c3c2a..991d9ba1a5e7 100644
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
 blk_qc_t drbd_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct drbd_device *device = (struct drbd_device *) q->queuedata;
-	unsigned long start_jif;
 
 	blk_queue_split(q, &bio);
 
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

