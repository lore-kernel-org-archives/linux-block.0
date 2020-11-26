Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7880EC64E8A
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370DA21D40
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="EPdz6+Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgKZKre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388371AbgKZKre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:34 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8679AC0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:32 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id mc24so2253671ejb.6
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89v079U432pNB380YF5DCvbaMnPCcXZlFPoWl982ARA=;
        b=EPdz6+CwHOo3zXI3fcS+IB/TmT0SbtM6X+1QcHJxTOSCKFZzapNrQUIbIS40BLnbPL
         U7KU3jDWhwe6rjLAar55z05bbtrihbMXwkFGLdVcEfxEMlI8k3qOaN+wIZuC1XG7iqvX
         I/QUoOKYdkwu+ReWqjlQJ4qXSWT3ZlukgYAlwNPyjDKwZ3+/ShY8UXDiK99OpyvfrnIH
         Vvu5f7H8ttlBs+LVTRZ1eijvgd74Kss0wu3e8BP6gxjx1k7DEFTmeiBP/mfIJTsZ1pDF
         hLemGCxQKUPJkSupCWsdRVI1PzViuaxsGF6Lj6q9JvLPm5muKQmqXgamrouPncmNZf/T
         VCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89v079U432pNB380YF5DCvbaMnPCcXZlFPoWl982ARA=;
        b=XUyUxlR1I1eQoeg1FA5p00Y+uJIJEvQw2dhxZjuQEZ2wdyiABQ1WFf77L+hmOHl2DU
         N7Now6N4k9jdJHqNNhEA2jSbehxNUg/hAF+So8lO+vNvLFE2C2MuFvSnn2QtWqcHAG9H
         9paiVeiNhv+8bfRhbhdfZIge1jYb4uB+DPdA4k8L7NxZywbNDMk+7On3JyP3TwQ6kd0i
         1QbcuRqa1iptx3lRiBYOBBl732SF13FOhNXYP/7tnDx7sPky/wkBoDrT8ICcvae54bjz
         gl1Xqz+BXa9D0R2//EZeyPt9+ou95ULjuLo/HRaIKaUNMWYHYGhsOQXlth28soKVuG+k
         yePQ==
X-Gm-Message-State: AOAM533DmUZ3laTnendj70hus9z9pa9w8OGQOHsJMJXpyCh0/rFa2vCd
        znfsjAR4A2lTPHO6HTBbaavK4mgKr2w8zA==
X-Google-Smtp-Source: ABdhPJxlFirjF1XPWyzEcppZ9gGDiwRGfqAILNnQztMw76Pp693hYyJ7H4WF7FE0gmE5OUiTJ5lqhg==
X-Received: by 2002:a17:906:b53:: with SMTP id v19mr2118147ejg.250.1606387651154;
        Thu, 26 Nov 2020 02:47:31 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:30 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 7/8] block/rnbd: call kobject_put in the failure path
Date:   Thu, 26 Nov 2020 11:47:22 +0100
Message-Id: <20201126104723.150674-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Per the comment of kobject_init_and_add, we need to cleanup the memory
by call kobject_put.

Also we need to call kobject_del for the other failure cases if the
kobject_init_and_add doesn't fail.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c |  4 +++-
 drivers/block/rnbd/rnbd-srv-sysfs.c | 28 ++++++++++++++++------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 5d3c3c80dab4..e3c3270b0cee 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -450,9 +450,11 @@ static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
 
 	ret = kobject_init_and_add(&dev->kobj, &rnbd_dev_ktype, gd_kobj, "%s",
 				   "rnbd");
-	if (ret)
+	if (ret) {
 		rnbd_clt_err(dev, "Failed to create device sysfs dir, err: %d\n",
 			      ret);
+		kobject_put(&dev->kobj);
+	}
 
 	return ret;
 }
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 08ffb492ebfa..05ffe488ddc6 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -47,13 +47,17 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
 
 	ret = kobject_init_and_add(&dev->dev_kobj, &dev_ktype,
 				   rnbd_devs_kobj, dev_name);
-	if (ret)
+	if (ret) {
+		kobject_put(&dev->dev_kobj);
 		return ret;
+	}
 
 	dev->dev_sessions_kobj = kobject_create_and_add("sessions",
 							&dev->dev_kobj);
-	if (!dev->dev_sessions_kobj)
-		goto put_dev_kobj;
+	if (!dev->dev_sessions_kobj) {
+		ret = -ENOMEM;
+		goto free_dev_kobj;
+	}
 
 	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
 	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
@@ -64,7 +68,8 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
 
 put_sess_kobj:
 	kobject_put(dev->dev_sessions_kobj);
-put_dev_kobj:
+free_dev_kobj:
+	kobject_del(&dev->dev_kobj);
 	kobject_put(&dev->dev_kobj);
 	return ret;
 }
@@ -196,18 +201,17 @@ int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev)
 	ret = kobject_init_and_add(&sess_dev->kobj, &rnbd_srv_sess_dev_ktype,
 				   sess_dev->dev->dev_sessions_kobj, "%s",
 				   sess_dev->sess->sessname);
-	if (ret)
+	if (ret) {
+		kobject_put(&sess_dev->kobj);
 		return ret;
+	}
 
 	ret = sysfs_create_group(&sess_dev->kobj,
 				 &rnbd_srv_default_dev_session_attr_group);
-	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-	kobject_put(&sess_dev->kobj);
+	if (ret) {
+		kobject_del(&sess_dev->kobj);
+		kobject_put(&sess_dev->kobj);
+	}
 
 	return ret;
 }
-- 
2.25.1

