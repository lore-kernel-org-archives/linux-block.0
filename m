Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497C7C43460
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7E9610CC
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhDSHi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbhDSHiZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D3C061760
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mh2so29801824ejb.8
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UV5euG+BoTE43f7Ueiuj3a/UPU6dlpNgwx7fSpiSFBs=;
        b=dCV4Y9Fw2A8c6eMnrZEyj0ZIdwZXrtdzpG+3YcKb33x8GYf9/95plbzZmTMGVTw+J5
         02UlMoluZOmPXnjGZLrVs97Djs62m3/VNovcRfLEWmISwlEn2qlMFUd2txmtAVJdOSzl
         DjkC2blGIDh/8mYnsgl6G/amuNz/Igm9UMm6gm4UmzAcHfIuQpPEM/IoubplSwbyOv1b
         1VzMdONECPy2JPoj9NgqgnUhEdjsSwKitkAaHb82+It7q13z1GRMudJvV1nHpHsXgW6L
         LHKfJevZKlaImN6MfRsx2eSFrsi1FCRLmrw+42p0rbOebatNwvoZkSghGm4cCo3q0Q4D
         ovHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UV5euG+BoTE43f7Ueiuj3a/UPU6dlpNgwx7fSpiSFBs=;
        b=ccLRuLTu49lg7UCk9O9bJtrf96/AJfuQMHwyN6KtXm0k8ty3LJutMkb37TfFbVqoWC
         gaFOdTT1f/uLNEiQAHdEX3fXBO9+Y7ainloHUzFhw5R7HaYm9Zit0Eel4aqV5QPOLcGa
         CUKQgw+0LE1gSuo1jYMOM2ugpDjDV0qzbKB6uPr+oed0hZOTQFvOrTuhoQiNfnQeMgzV
         LNDjEVH2Nb8KMnEtBfD1d2M6KB/8AgBxWZjMBpkMEgyIUFTuPN7/0aZA26l8vgbEfrPj
         D940DfS53PbQ6jQd86AxA2b5ESQRw+ILyKlVc/KX3MWvqRh5pr6REqM1E8JJ7QUWP+AH
         IU3Q==
X-Gm-Message-State: AOAM5322bcEIOwU9rEfD8eS0aiW2DT6cfB4glhK6sJRZ7DhZAqDju6An
        ON5SgHxnT8pCqslDytZq7I0L4Y0++MVHZ9al
X-Google-Smtp-Source: ABdhPJx5CLN4jDnVYk7xYqQAdF0uN2HdD3BE/7NXFhH60t5q+Y7YEjN41Bi3l4Cx+UWXrxulQb5PxQ==
X-Received: by 2002:a17:906:49d3:: with SMTP id w19mr20706452ejv.116.1618817873964;
        Mon, 19 Apr 2021 00:37:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:53 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv5 for-next 07/19] block/rnbd: Kill destroy_device_cb
Date:   Mon, 19 Apr 2021 09:37:10 +0200
Message-Id: <20210419073722.15351-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

We can use destroy_device directly since destroy_device_cb is just the
wrapper of destroy_device.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-srv.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index a6a68d44f517..a4fd9f167c18 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -178,8 +178,10 @@ static int process_rdma(struct rtrs_srv *sess,
 	return err;
 }
 
-static void destroy_device(struct rnbd_srv_dev *dev)
+static void destroy_device(struct kref *kref)
 {
+	struct rnbd_srv_dev *dev = container_of(kref, struct rnbd_srv_dev, kref);
+
 	WARN_ONCE(!list_empty(&dev->sess_dev_list),
 		  "Device %s is being destroyed but still in use!\n",
 		  dev->id);
@@ -198,18 +200,9 @@ static void destroy_device(struct rnbd_srv_dev *dev)
 		kfree(dev);
 }
 
-static void destroy_device_cb(struct kref *kref)
-{
-	struct rnbd_srv_dev *dev;
-
-	dev = container_of(kref, struct rnbd_srv_dev, kref);
-
-	destroy_device(dev);
-}
-
 static void rnbd_put_srv_dev(struct rnbd_srv_dev *dev)
 {
-	kref_put(&dev->kref, destroy_device_cb);
+	kref_put(&dev->kref, destroy_device);
 }
 
 void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
-- 
2.25.1

