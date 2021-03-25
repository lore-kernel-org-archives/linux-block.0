Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B14C433F7
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B6E61A28
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhCYPag (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhCYPaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27FFC06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hq27so3577947ejc.9
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFSHDt2a4UMse8UCqMOLtSx70A+SNRfPmGCXQKYuQAY=;
        b=B6lvjLGJhz46UeOGa+no3lzcScrGXVykmssvYbyLWJRmj4Ar/Va3bujwxn0qZ6Q5gW
         1bg3ZvYFz5RGJ9b0XiEwdtbSEhw6vUO19WGUUPVL1TJnDErsGaPDxckR/FCSJiQ7OzRP
         e2ZXOmp5lCQPJ43nyYsCtuqDs2umYHB06JZV1ls5LfMXLA2o46hufEBqbiOEUvdrH/1n
         jbpOo58JAt06tO03yTQ9kD1dmzbgfQQ/x6bkyijO2yP9aKcwMMRt8Cw0zow6p55A0b9p
         eSGX0DfN0ik6VIZnBCLAOCOETCVhj/7FAYCdpGsx9035ov7Y3yjA7gdaP6VnjS6XXZre
         i1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFSHDt2a4UMse8UCqMOLtSx70A+SNRfPmGCXQKYuQAY=;
        b=RvLIc3EIwLfs1nwdMhtokjP9e5rshMX/iAV1RNwebH3GJfOXPusw6mCHyR34/luaZe
         dlLLWHo1N3tMtJLtg3n1nwS5099seWaME5BfdAgDUeeVYim0kAgfucGtcjx8Ve2J0r5V
         f4sAgsArw4SW1hMWToKoZyJ2czlhZU0RtlHLv8Gunp0f8v4gEnpuVZaNJLZQEyhpWCXA
         RhdnN0kRu9KcQ1pO4ZBMcND+W/ZPVck6SzvVaXgWBQ17Q0bW9hYCt/ejf1IOVvz2Y1Uy
         nPhO4/5vFcJ0MseJuiPdUM/GwlX3arPiosybvkCotvmkUsqWBA757bMy6x+MjFZZ23EC
         Wxww==
X-Gm-Message-State: AOAM5303sIDWSN3n6lKHIAOIRA+Sa3wnp9jQ86tCn1hh2mebgYgdTMhF
        rLIz0oWNzLW+Fli9mPiZwwNObQdVN2+4R9jo
X-Google-Smtp-Source: ABdhPJz/AxgB0/42zozbGF8ga7rbdC8tMSLJSEJLkouQGzQViJX4NJja5eXIMbCQh2W0xhcEMn5Rdg==
X-Received: by 2002:a17:906:414e:: with SMTP id l14mr9681156ejk.406.1616686200197;
        Thu, 25 Mar 2021 08:30:00 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:00 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 12/24] block/rnbd: Kill destroy_device_cb
Date:   Thu, 25 Mar 2021 16:28:59 +0100
Message-Id: <20210325152911.1213627-13-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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
---
 drivers/block/rnbd/rnbd-srv.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 447fb0718525..895e9c313ff0 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -183,8 +183,10 @@ static int process_rdma(struct rtrs_srv *sess,
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
@@ -203,18 +205,9 @@ static void destroy_device(struct rnbd_srv_dev *dev)
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

