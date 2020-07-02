Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A0C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 13:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D17620672
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 13:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="PwcqrbBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgGBN1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgGBN1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 09:27:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C1C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 06:27:21 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so23851069edr.2
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBaUOzBUmZvfHz2BrgXV4tbsfNQDmUh4O5tah2+TEQA=;
        b=PwcqrbBbcthT5ztTfKZdLaQXrCUSB09PnEybMbNBDsdwdafapuB/4ZJ/MeR4BSj8+r
         LIsgCccpJJ3oNIOWxGmSqnrhGjX0sZH15eEQkJuIHEHHSbAcdTyeeYI4Etn65pQGNCJX
         tzeG6WNEuHCFw/gdvgqubPclNCVDcQOUMeqR8/8okgJP1UfdQY7qjryQ2blar78tfcGC
         Xsh4vxZlwNBmxNohs40cUv0aQcfSgpsm7p1U0iUoVO/9QliX4sGyYNBXxdbPMEi0YewK
         Q4XFX7Tle8swndJF/t9Z/afPxDXjuBwwfije73RFx91SW+7XIxlqSh1GH0vo7C16DJQI
         e0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBaUOzBUmZvfHz2BrgXV4tbsfNQDmUh4O5tah2+TEQA=;
        b=n/x0mmO6STM+VrjuO1gWayEm/8oUbrw4iZ/+7gRuaoGt5dAeKY8v3vt9UUTXrwxleS
         UWZ2iS93QpFePbMUoQZ1e4Gii2jBp0XMO7q0Psrkl6VyLXMFiI09mKEqOx60AMNNdpgi
         qJTI/QSNaURrFoRw2mo3k00AzFfybHccfzKm0m5G7lUH1hGaXqM5qKGvu0cmzUVw/cfL
         54zkQe4Uetn1yBie4If9uZpdLu3FjsvDJV/qTEHokRH1ZkR/+rfzdJbpBhzTJwwiO8Lt
         k0/0tx9YHEZuA6dLMpaIxM2ygzrHXSBx3IM6USwVzflJfMLd6UfXETxNb7S/E29FGNmB
         qn4g==
X-Gm-Message-State: AOAM531m3TkbFB1nHYWke1DWlgP/cx4lVvMvCGAG4yF37A2n5iqIadi6
        4Bxz6rQC/FjL8oxIP+a34UIq00Id4dcFc6PB
X-Google-Smtp-Source: ABdhPJxuv8V0d1zbj/MJOSdSMlHsXnv7nD5lQU09cPL917aGicFfOhxR6EORhHGv4b7puk9tBV0pTg==
X-Received: by 2002:a50:cd1a:: with SMTP id z26mr36023142edi.120.1593696439901;
        Thu, 02 Jul 2020 06:27:19 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:2968:e1c0:a871:b69c])
        by smtp.gmail.com with ESMTPSA id m13sm6863457ejc.1.2020.07.02.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 06:27:19 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2] drbd: remove unused argument from drbd_request_prepare and __drbd_make_request
Date:   Thu,  2 Jul 2020 15:27:02 +0200
Message-Id: <20200702132702.6914-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701123832.3868-1-guoqing.jiang@cloud.ionos.com>
References: <20200701123832.3868-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can remove start_jif since it is not used by drbd_request_prepare,
then remove it from __drbd_make_request further.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
V2:
1. rebased with latest for-next branch

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

