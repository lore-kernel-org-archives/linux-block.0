Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B103FC433E1
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9109221527
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 10:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DAvalicJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgFQKhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQKhl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 06:37:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03516C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 03:37:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so829262pjf.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxcWus7DvqskOYAGR2NZgYr+kARItr4Gp9oHt8X2bYQ=;
        b=DAvalicJKwxNB+R2yjh+tvzAUV9aP2YvwGT3GvhFlgEKqR6p633oGngUCz8NHnY3MZ
         mXdAEP7Eze34DV6EiPl7x2mmILT6lhcaLSmLKUo+9qpMBkjIkkDgHwKb8Be3ecANTHBE
         pP27DbiBmcBlzCgOYyuDQmhERdqM5fgqnvT1BYVa1yY8py7kq2OuT4MjJSW4Rw/tObUt
         7WNdFpi+Yfpy/gHEgAaEmwV3bWx5cqLqP+5rLJYxqtF+ilMgh3JimM5sZ6lpbJQdeWBL
         nnflDljq6J7U7ZTnlt0erWQo2+jZIJRjkiDo4pYsijMBYNZppHEwwsK+bUtD3k2hUcFf
         SEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxcWus7DvqskOYAGR2NZgYr+kARItr4Gp9oHt8X2bYQ=;
        b=pFANCxVY7uwEAeiJJutaX5817KGYjvKHs/2mvtMtzmtnAKYdaR+IY77Vi2pyuAFA9K
         tfehzJnh2/NK4PEBeloF2x28IW2LJ2XxLFv4zE0UW+Tg0eqb9GmydbUuoGP5tbHWr0K1
         USKIPk0QSMrercd5ojHqKCJLWQwiOSr0f+UYxQzgl2DDBVFJ0qLkaeENK73mlkabxdK2
         64MAtXEVn1adhj/g8ySqnzya2tEBRMlQtAwKLOJ7kn4WSsRsBjcINAXoSXVDbgLiBSsB
         keonl/xQZQI/gN3BxM1A684W5+v7BjvEnKwHdzM9HYRlkHdlEUoyVe8IBUAyO41EFM7U
         zjZQ==
X-Gm-Message-State: AOAM530GHVYPqqel7gir5dddsNVZ/Lz6CWzwLueZQ5PMFeiV/Wcd7XsQ
        1Tnzi1ERJpEarbtEaq042KHdKjRb5tuTIxU9
X-Google-Smtp-Source: ABdhPJy99TLE9lDbCycQTII1qX5sKN38XsqTFocwh9E4wMfor21sFsa1gy4qQc4yTWuCu4T+lQiXIA==
X-Received: by 2002:a17:90a:43c5:: with SMTP id r63mr6823061pjg.203.1592390258626;
        Wed, 17 Jun 2020 03:37:38 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.246])
        by smtp.gmail.com with ESMTPSA id u6sm10031776pfc.83.2020.06.17.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 03:37:38 -0700 (PDT)
From:   haris.iqbal@cloud.ionos.com
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH] Delay the initialization of rnbd_server module to late_initcall level
Date:   Wed, 17 Jun 2020 16:07:32 +0530
Message-Id: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

The rnbd_server module's communication manager initialization depends on the
registration of the "network namespace subsystem" of the RDMA CM agent module.
As such, when the kernel is configured to load the rnbd_server and the RDMA
cma module during initialization; and if the rnbd_server module is initialized
before RDMA cma module, a null ptr dereference occurs during the RDMA bind
operation.
This patch delays the initialization of the rnbd_server module to the
late_initcall level, since RDMA cma module uses module_init which puts it into
the device_initcall level.
---
 drivers/block/rnbd/rnbd-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 86e61523907b..213df05e5994 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
 	rnbd_srv_destroy_sysfs_files();
 }
 
-module_init(rnbd_srv_init_module);
+late_initcall(rnbd_srv_init_module);
 module_exit(rnbd_srv_cleanup_module);
-- 
2.25.1

