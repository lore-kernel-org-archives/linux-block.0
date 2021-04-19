Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54CC43462
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD886102A
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhDSHiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhDSHiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C78DC061763
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so51315507ejc.10
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zL6gQYZ5yMQsIXTOxSRsFVO1XenlLGr+TV3FCZ4q0tY=;
        b=aVp3V2QEidHmsDKKeDoP/IX+pQfya8dzvZJAHzhYp6Ums2++UwvB3YiK2+gYQ1XRgP
         bkaJBx5bEhVx+JkJ1+qmLR5SXrSzDzmHrffS1l/2k0OYJgpDf6jVuGNsHB194yoGEqez
         wj0PlKT+FZSt1sw+pdOn7IlLQRqSUhsh7FkRr4lXugxzSJ/LOFtZtub3FNljsMdbrQOm
         oP8x7H7ipqxzHDJ+5b1iXyfJqhAEnUsIYdBUn64d2XqPrqhwbqqAna6GUFSv6WtUuRde
         gJQXSCIAO8PiiXr1jLyQu4HqItAGfq6SV/ffBjpmvXMN+azy969dJ7fRtCsTCbnxGjmI
         OT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zL6gQYZ5yMQsIXTOxSRsFVO1XenlLGr+TV3FCZ4q0tY=;
        b=FQwjd99yYXnuJEWkulbleF/USdPBmk+1ZCOqa8GIEGoLQGExf+6xkXH7aVQLts5B2O
         gIrVEelFD88gQKSuwVrscSf+0KZklmqU8wgWNp7eVPGIu0Ua3fy6SDXv7hMvGHbOgYAK
         EL+p/bMCUiNs5cP8aQ0If77MMGwI27TRZ7M0W1c0dEXkyftwrGaPlpH063BLgWHLjwo1
         P1M5U8DUnfuSwgpx42ajg3UpUY7SnrkIjHm93+cKFxAUdOwRx+16FwtkmOhennzD8eTL
         LQUOzlLHTf1Zn1vwfLY8xjxYoYoD2/MZrHfocA0zUv3sUF85lfGltC4Go3q8Lr2fyV1g
         Wenw==
X-Gm-Message-State: AOAM532KhDvjpexmnTSwXr5zGwCstdJYsHT1q38tMrz8M5sge22fj/J7
        pMiQl654qKs4fAI0Fm3cZgPbjUHkKPlvme7d
X-Google-Smtp-Source: ABdhPJw9oNWPwSdEbiMmOtXy2vufk1fqTp0BMBlfuJFVVXg64SZmEhh+NsJ5jxpzAqY1VrmG6y5dSw==
X-Received: by 2002:a17:906:32cb:: with SMTP id k11mr21144705ejk.158.1618817873171;
        Mon, 19 Apr 2021 00:37:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:52 -0700 (PDT)
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
Subject: [PATCHv5 for-next 06/19] block/rnbd: Kill rnbd_clt_destroy_default_group
Date:   Mon, 19 Apr 2021 09:37:09 +0200
Message-Id: <20210419073722.15351-7-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 drivers/block/rnbd/rnbd-clt.c       | 1 -
 drivers/block/rnbd/rnbd-clt.h       | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index d4aa6bfc9555..58c2cc0725b6 100644
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
index f864f06a49b3..4e687ec88721 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1675,7 +1675,6 @@ static void rnbd_destroy_sessions(void)
 	struct rnbd_clt_dev *dev, *tn;
 
 	/* Firstly forbid access through sysfs interface */
-	rnbd_clt_destroy_default_group();
 	rnbd_clt_destroy_sysfs_files();
 
 	/*
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 537d499dad3b..714d426b449b 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -159,7 +159,6 @@ int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize);
 int rnbd_clt_create_sysfs_files(void);
 
 void rnbd_clt_destroy_sysfs_files(void);
-void rnbd_clt_destroy_default_group(void);
 
 void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev);
 
-- 
2.25.1

