Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C9C433EC
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C6861A3A
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCYPae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCYPaB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2903C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e14so3553026ejz.11
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnARvf2OVorx0aWtIbfM1m/ZXt63MvsBP7Ym4cjRdv4=;
        b=D8wg2YPxnrT0S0QdgH0NimU1/ikJagM+/z+j9LAionXVXon2jlauvPPSalKXtHA14d
         kBOUjfyZ5KYa7O6IYZAtiQXevt0sogpy+Gu+/3OuMNDhBkZZZACHjJWAsKyX8kDoTpNx
         SlQgVlQ+I0lMPGy9OXTvXHJC1ytIUOx3MEYLey1Y3W7Fa2jBdfhzX3ImWSH7l4hwgiG5
         1upm/8yVL4BMY6rAwoPAeG1OewbcMIvIhfog5lG3M2os85v64NpHMmTEl4q+jiEQJeTW
         L1r01i4hjzqaI42t+8Xjmx/kiK3arZGX9JrjPqhz0e+UIxNjnNhVntw13xKPMr8FzUk6
         My6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnARvf2OVorx0aWtIbfM1m/ZXt63MvsBP7Ym4cjRdv4=;
        b=njQuY+TyxAQ83btUuo4lj6i4Lo4Z9JoSwf+sKAeEUQwU6Z7liRU2llrl4QMrlFBzQ3
         iWbdA5DK7MdTrnf/FjYByf83dYBYLj/YBFAYovO5L/EWPVE3zzc9lX1XKrAwmcXAIZ9N
         lR1oO1Zp17mwl46M3hLOsefS/aNlRwGUQ5tLTi9byoz0NfQjeLtqvyfS7wJsEwv7sOWL
         Y1WrhEFHC1CvlIKasXeUNcX1xYuJszP5ZIl7vUzPQHrZAFeyiuKv7TZUbiiYXtGRQZI3
         hilM2MRbI8aLP+vzD0XVIUVCbpVVUatnRZTtXG4jINeLgBfFnPiEOqcTeVjzJuRXTlnH
         afMw==
X-Gm-Message-State: AOAM533a9HiEz9bJS5MvS+GRnZVUaBVORSCTyf1XGtTjHLEKg5FqO+Qg
        x956mLLinipOPlm9ktUSncRJqmuMgs1IdXWC
X-Google-Smtp-Source: ABdhPJz9QvG9Ck35dp1UIq3abXX2+EDOUp3DJ3gEKB7Qw5lzEsIpXiQXh41zV80tysuldsEOzdSgEA==
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr10153683ejg.330.1616686199547;
        Thu, 25 Mar 2021 08:29:59 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:59 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 11/24] block/rnbd: Kill rnbd_clt_destroy_default_group
Date:   Thu, 25 Mar 2021 16:28:58 +0100
Message-Id: <20210325152911.1213627-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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

