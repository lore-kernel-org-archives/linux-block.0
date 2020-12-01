Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79BFC64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC96207FF
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Jj8HXdR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgLAM46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLAM46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 07:56:58 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C687C0617A6
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 04:56:17 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ck29so3056791edb.8
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 04:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVlFL/BwK+4pEy5h5pG2lUmBjku30Q9HUhNaXsgLU5k=;
        b=Jj8HXdR5H/mhKYMc/5WyObSK3cPEr9hW9cIupB+JtNxLHEet5G0+IdZep+hhxm09nc
         k6j2qgP1O44P4um+ewz40Vj/OmlceAO7hIYj9Yiwpo7TP6oRIutbVzbBnZuRmL20Frry
         SKaEGFn0dCihFyADELwQlagM1Is+j7Vo7gZfvYHEgJoFjP4HpKyfR7Vg4JbEGnLEmRgr
         PGjd3n6Oe/mp0IKM2Z9ul9Q/lEzZp/KiGcTBZS0nJzNUskrVWNCOOOIG1Y/feP6AJWKW
         XV4TG2/sgZUnsoorFTI4etgmrV6V9LDCIIZxfoUh1o5tQ2UBsE2cIW4X1ZSjUrOCIpKl
         DdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVlFL/BwK+4pEy5h5pG2lUmBjku30Q9HUhNaXsgLU5k=;
        b=ZPHTjGI+yUrEMB/Vwa7owli4woTkya+qad1CaL6B9N+VKBAKRgEzM3CbKgqgP1fk52
         jNiZ+/05c/CFnYEADhqrLgNXJoYOzKIEHtxvxBvEC4BuuCtWMVwZTjspVlxGoCaKVo+t
         qrHBztXIwdLA3BXDl0/NCAzNjmZcbueGHlHMB2CwDqsqsyKhyVcF/aRAdpO4Y55ElUCG
         6NDSff6Dus140gP2+BjgXlw9ZXSJolqeOvbKIvkBZWsG7b528454ctF83+PajL2vsnrP
         zCFv3MtiLgZlfwaCHwwZj2/UtzLNUnwRA4kWE/d4tEOIlF2P4kss3gKudasjBzPKSS6M
         IQ/g==
X-Gm-Message-State: AOAM532Uw4IW06dkIJzdIoi05rrEkF6GYx0eJuFglWeMAwq4AvDGEuyP
        4PNElx/mt1dQQlWNU90n9VI1m5ADoXvA89yf9AQ=
X-Google-Smtp-Source: ABdhPJwzwZgyhL2sV7A/5LmOrY88AXJK0UEXkWkHePO4ZiBsOgzSJVtAk1E8CEaDaw2TM1VxZA2I6g==
X-Received: by 2002:a05:6402:144f:: with SMTP id d15mr2917791edx.300.1606827376284;
        Tue, 01 Dec 2020 04:56:16 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:56:15 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 2/4] nvme: rename controller base dev_t char device
Date:   Tue,  1 Dec 2020 13:56:08 +0100
Message-Id: <20201201125610.17138-3-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Rename controller base dev_t char device in preparation for adding a
namespace char device.

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a965a8d28ba0..c23c891a8fb8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -85,7 +85,7 @@ static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
-static dev_t nvme_chr_devt;
+static dev_t nvme_ctrl_base_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
@@ -4470,7 +4470,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	device_initialize(&ctrl->ctrl_device);
 	ctrl->device = &ctrl->ctrl_device;
-	ctrl->device->devt = MKDEV(MAJOR(nvme_chr_devt), ctrl->instance);
+	ctrl->device->devt = MKDEV(MAJOR(nvme_ctrl_base_chr_devt),
+			ctrl->instance);
 	ctrl->device->class = nvme_class;
 	ctrl->device->parent = ctrl->dev;
 	ctrl->device->groups = nvme_dev_attr_groups;
@@ -4679,7 +4680,8 @@ static int __init nvme_core_init(void)
 	if (!nvme_delete_wq)
 		goto destroy_reset_wq;
 
-	result = alloc_chrdev_region(&nvme_chr_devt, 0, NVME_MINORS, "nvme");
+	result = alloc_chrdev_region(&nvme_ctrl_base_chr_devt, 0,
+			NVME_MINORS, "nvme");
 	if (result < 0)
 		goto destroy_delete_wq;
 
@@ -4700,7 +4702,7 @@ static int __init nvme_core_init(void)
 destroy_class:
 	class_destroy(nvme_class);
 unregister_chrdev:
-	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
+	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 destroy_delete_wq:
 	destroy_workqueue(nvme_delete_wq);
 destroy_reset_wq:
@@ -4715,7 +4717,7 @@ static void __exit nvme_core_exit(void)
 {
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
-	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
+	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
 	destroy_workqueue(nvme_wq);
-- 
2.17.1

