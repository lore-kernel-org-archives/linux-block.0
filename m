Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61975C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400E6613BE
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbhDFHHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbhDFHHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEA8C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z1so15213959edb.8
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uK/8rpYP1RXWSF8rmgCpV40i0InJQwlPrCpDoA4JLng=;
        b=g17+Ca1jSg1gppoa0ftuVFCNbk/JN6e06c2yzfIMdb+Dyfmu/dT3jA1N1hVPr3B/oi
         cKWjgWvb9fkOYpJTbRFLQisMm3lztRwrNPO0l4XbLvUrWY2K0AqZSifCwES6kKydmamU
         GkHiRvo6gxKSiX9Glk3n+JjEVnEJLnlX4O4MChjLeyhLbNKOXv8j15TE9jcRLPgzRq27
         6barD05cft26DVcKQ4bmvAjNX6335zs6zkN1rXsj6rR7prow8vWhWJBUJdEVP9HNE+89
         YerE+l+1vp5cK5F8NAiPQjw/i5Zvs9axh+GDdJtxiu8nNZD242xmBBr5TL2huduRqSJO
         PKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uK/8rpYP1RXWSF8rmgCpV40i0InJQwlPrCpDoA4JLng=;
        b=LNUR71s6uUXv8GRYsuTY/Z+9lagd4DgdcpIOhTvYZj5QphlSnMuv7GtkkCoqGIqNIg
         U/wGOR5Pjm/yZXx0PGm5WzIYF/Duf6coiDmbDqwKr98IfHVUw2TITfHAFsE/kXw2GsvZ
         9SadU3fDILqYM0uHFTkzZv67RS9/aDe7RoBFbKvUD3HZRI6GWiwMME1fSqqUEPJ2sg4X
         +eXp/72jiSnpTcLtjurXHn8TIr/z94NID8a4AUXPw3+dZAt54KhQ9cha6HGyzHvu1Qyv
         cqP5orplnesvOErgV+gb2cn84bnPz2lM5oK290rtC6UPpDpkJfLd0+VCm0ztgglXTr8w
         HVcA==
X-Gm-Message-State: AOAM5336Z+LJ7vLpSUsZFsBPBC42X68BDvvVsEWoZEQw7QRZysLQBgvr
        JQatVNCycWWgN7oiFxcwEh2sDCaapzOQWhim
X-Google-Smtp-Source: ABdhPJzIHMQ3s8KwxYWd64J5ZcS626BQivTCh9ie8+yXE58HQOmTG3G6Kr50SEQFlUGmlgWTzfrd7Q==
X-Received: by 2002:a05:6402:1013:: with SMTP id c19mr3688819edu.213.1617692844277;
        Tue, 06 Apr 2021 00:07:24 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:24 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 06/19] block/rnbd: Kill rnbd_clt_destroy_default_group
Date:   Tue,  6 Apr 2021 09:07:03 +0200
Message-Id: <20210406070716.168541-7-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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

