Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079EDC433EB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA597619BB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhC3Hil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhC3HiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C64C0613DB
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o19so17039447edc.3
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnARvf2OVorx0aWtIbfM1m/ZXt63MvsBP7Ym4cjRdv4=;
        b=WZ0QBYBa3XXBbh3tval7m1MJ0is9okRYJzU7+PbRvqDtWn5y5tt2/AelU3yS5e+ibo
         9Ec6CNhHwIrgNjKAF8NoifRbEhg47QRz5TBzxHsVe/SqXbOKhmcU2N6fx49p7dMHFJnE
         +XSfLJchg2Q9qr1peDCw/r4rjDef0u7R/YSCZwyupeFRm8Ak2T+m0QswLDVf1sMBPsDE
         gvFx5nha8396OD7YkLAJBF/v+7PJ9Mf6A1fNIK8RbB6+/t5N+YOt4ajqK5fQ8D8+UY8F
         DCaAo1UlS4TTl7F0NReY0pdeGrG0djtkqWx149idVM8rlsHTkEJofrS4+kj5IbI1yyOj
         XvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnARvf2OVorx0aWtIbfM1m/ZXt63MvsBP7Ym4cjRdv4=;
        b=HLb+9kXPeW5E0R2s4PpkekJKcYUZMiv07g60nB18r2IYoChFW9697rqYofmGGlnlBf
         tsEbNlQc9B8bflvl959v4M10S83zs4Crq3YU4NesGEF9fYpwD6vYo06J2IAAkczuW5c1
         oLD+7dy4Og92yDL2dezBu4l7x6rHyEkIj/AqVhWvw72ibYqBKU3g8SXo6QbAQNEu0ZG3
         9fjy730UqQO9L/GNbyhHwOm0dRtgZmZKQkucNMmOx5IhUxmNwno9/EzO0eiz5KyI8oie
         uVzM2ryDVOZcfERten/QwQMLPJ1/70S1oIMukBwAllogHYGybYHheW6TzWxwfVcrghcQ
         sWMA==
X-Gm-Message-State: AOAM533dBWztN5C+kujBNbfXqlGFy4AD9Odl6PoggUgEH0MseuXfBxR7
        1b1vB5gobaaYvwb0PUWjOvdEd/W+RnI7vBFC
X-Google-Smtp-Source: ABdhPJyX7Jaa7KtBPyoJdhBEHjb/GGFrHdci5RBF9hjG4JuzCHsIJMuSHKTj3+N641l5l7g7RUWMFA==
X-Received: by 2002:a50:fe08:: with SMTP id f8mr31943019edt.217.1617089885700;
        Tue, 30 Mar 2021 00:38:05 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:05 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 11/24] block/rnbd: Kill rnbd_clt_destroy_default_group
Date:   Tue, 30 Mar 2021 09:37:39 +0200
Message-Id: <20210330073752.1465613-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need to have it since we can call sysfs_remove_group in the
rnbd_clt_destroy_sysfs_files.

Then rnbd_clt_destroy_sysfs_files is paired with it's counterpart
rnbd_clt_create_sysfs_files.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 drivers/block/rnbd/rnbd-clt.c       | 1 -
 drivers/block/rnbd/rnbd-clt.h       | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index d83415875960..2452eb67547c 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -639,13 +639,9 @@ int rnbd_clt_create_sysfs_files(void)
 	return err;
 }
 
-void rnbd_clt_destroy_default_group(void)
-{
-	sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
-}
-
 void rnbd_clt_destroy_sysfs_files(void)
 {
+	sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
 	kobject_del(rnbd_devs_kobj);
 	kobject_put(rnbd_devs_kobj);
 	device_destroy(rnbd_dev_class, MKDEV(0, 0));
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index d8b9c552271c..fce0f345f796 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1692,7 +1692,6 @@ static void rnbd_destroy_sessions(void)
 	struct rnbd_clt_dev *dev, *tn;
 
 	/* Firstly forbid access through sysfs interface */
-	rnbd_clt_destroy_default_group();
 	rnbd_clt_destroy_sysfs_files();
 
 	/*
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 5ecbe8dedf24..d2a709f5d7ed 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -168,7 +168,6 @@ int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize);
 int rnbd_clt_create_sysfs_files(void);
 
 void rnbd_clt_destroy_sysfs_files(void);
-void rnbd_clt_destroy_default_group(void);
 
 void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev);
 
-- 
2.25.1

