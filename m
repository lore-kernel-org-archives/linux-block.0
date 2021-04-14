Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EDFC43600
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973556121E
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbhDNMYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhDNMYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639FC061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w23so23445961edx.7
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UV5euG+BoTE43f7Ueiuj3a/UPU6dlpNgwx7fSpiSFBs=;
        b=LdsGqy/WVwChKNMrbZoJyNViIpfpCdA+4+DDHiTiBFMGAySb5ziGrbGKKEp47Pfka5
         t0rpofpmIoHey7ZjZlOl2CAcKCEoczxIB0ZUg2enfR5G+JpAn50n9jxEoDFSmd8WxVzC
         fhz5hvLeEuVLDwj2fnymWtA3FAfSUfby23pwnE2TMofjPPRs7vCXv3QT8G8h8PMu7VBQ
         p+njnXXCYHt0eYzd+G3HtzSGUZrsNF3+KSWYo8Sz786U5URhcv1HYE3gGGuOeG8JGNiS
         IPwdZ2FOdEtW4uteGOib3Rg0cI014MiLG9+gBq+q42cPV8LrIHESZMKrhy2KuzPTj4Hw
         lPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UV5euG+BoTE43f7Ueiuj3a/UPU6dlpNgwx7fSpiSFBs=;
        b=EhRi3oZEEbP5i/fSZMZeobpvC6bxc/B4h8JA5Un/cY/lETB4e5xP+iVVKUJLYH3LzP
         NdtNwcOVZvUsWNlJzzR4fv/Om3THWfYagtPQ4b+yi1XdNxVsroCvEZJ/HvH0XhRrouJi
         hrt3mqnQv6HwqYLi8Cp7HxnbotLjmrLeLaQzfShAmHlX+0W1+RAH67OrZOlTnxweeUF9
         TZDOuH5Tlw9Jfg7DYxGgHeQ5gjSCQGO6gqnFUMYxDNfo7QZRDX0i1vanWaFqJqD5ldpf
         ddaxYjYR2Zb5DYXoDlUcSkj6IaLT961HgfVR8iPJg9ObAOBlWVM2P5c/evge7vbi1DqK
         YKVQ==
X-Gm-Message-State: AOAM532TFLJGFbDn00dUHHehan0GRqDKtSeh3o/jlfH4TEysHDhFHEoP
        MxOPDL0DJRSbylavLY+ckFnKp4Qj5TMBvDb6
X-Google-Smtp-Source: ABdhPJy52HvdRuZdIKgHKr2G3bE+wUrrOnvohta3bEbg4zzdcfq+z5Byx+pcCtPDb1lC0LKWKW/GGA==
X-Received: by 2002:a05:6402:17c6:: with SMTP id s6mr41341590edy.319.1618403055021;
        Wed, 14 Apr 2021 05:24:15 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:14 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv4 for-next 07/19] block/rnbd: Kill destroy_device_cb
Date:   Wed, 14 Apr 2021 14:23:50 +0200
Message-Id: <20210414122402.203388-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
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

