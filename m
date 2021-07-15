Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAEBC636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45F3613DB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhGOUdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:33:33 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:33307 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhGOUda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:30 -0400
Received: by mail-pj1-f50.google.com with SMTP id v18-20020a17090ac912b0290173b9578f1cso6282072pjt.0;
        Thu, 15 Jul 2021 13:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1KwOJ6umUCy2K0J3TLENj+wX1hWd8L1ks+9PNQ/Acrk=;
        b=OFsSqllSbt/o2a8KkTYs9JxJBkhiGmqrqyfYdTxFUy935re9Tn9wmT7CczgdeTxcde
         xO6MCCC9U3JnDh7CQy4aP1Kt/l3g370esYHONMn2sFVmcjq2Bgqn91Ijdy7HZqo+erkH
         w/yqyoU7Zq/KbtiBX1D9lgpNZd681D/zL/meK8CHpFx2fLYxBQ4Qp0qh80f7Oy6GeZmj
         3JvGMJA2v1Pj1V27dxWVf1AHOH3KCBXUbHwKh8LnpQ0IGie7oZNMZEN2MB3b36V0fIGD
         hUAON19d0eGoQHGNjuv6RgsY7zuBQYNhWAnXKLfHK4vIYrtNV4ZUW/kMpmhtWXen3H/X
         n0cQ==
X-Gm-Message-State: AOAM531HXRG7awzviExb5fqdO5Frx225V/uU28r/pBrhYHJnF0jRWDv5
        kRvV6WZ5x6zrAtpbq+iW5Yw=
X-Google-Smtp-Source: ABdhPJwGIVv+EMwdqfQP25rza1L82fXMAhxJfahzI12uulAVpuRsHsreJqWM6lODLASxbIMLG3W6Nw==
X-Received: by 2002:a17:90a:a112:: with SMTP id s18mr11868443pjp.191.1626381036290;
        Thu, 15 Jul 2021 13:30:36 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id i198sm7455498pfe.215.2021.07.15.13.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:30:35 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 2/5] bcache: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 13:30:22 -0700
Message-Id: <20210715203025.2018218-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715203025.2018218-1-mcgrof@kernel.org>
References: <20210715203025.2018218-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

This driver doesn't do any unwinding with blk_cleanup_disk()
even on errors after add_disk() and so we follow that
tradition.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/bcache/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 70ee7a22b2a3..85da34e234d6 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1077,7 +1077,9 @@ int bch_cached_dev_run(struct cached_dev *dc)
 		closure_sync(&cl);
 	}
 
-	add_disk(d->disk);
+	ret = add_disk(d->disk);
+	if (ret)
+		goto out;
 	bd_link_disk_holder(dc->bdev, dc->disk.disk);
 	/*
 	 * won't show up in the uevent file, use udevadm monitor -e instead
@@ -1526,10 +1528,11 @@ static void flash_dev_flush(struct closure *cl)
 
 static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 {
+	int err = -ENOMEM;
 	struct bcache_device *d = kzalloc(sizeof(struct bcache_device),
 					  GFP_KERNEL);
 	if (!d)
-		return -ENOMEM;
+		goto err_ret;
 
 	closure_init(&d->cl, NULL);
 	set_closure_fn(&d->cl, flash_dev_flush, system_wq);
@@ -1543,9 +1546,12 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 	bcache_device_attach(d, c, u - c->uuids);
 	bch_sectors_dirty_init(d);
 	bch_flash_dev_request_init(d);
-	add_disk(d->disk);
+	err = add_disk(d->disk);
+	if (err)
+		goto err;
 
-	if (kobject_add(&d->kobj, &disk_to_dev(d->disk)->kobj, "bcache"))
+	err = kobject_add(&d->kobj, &disk_to_dev(d->disk)->kobj, "bcache");
+	if (err)
 		goto err;
 
 	bcache_device_link(d, c, "volume");
@@ -1559,7 +1565,8 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 	return 0;
 err:
 	kobject_put(&d->kobj);
-	return -ENOMEM;
+err_ret:
+	return err;
 }
 
 static int flash_devs_run(struct cache_set *c)
-- 
2.27.0

