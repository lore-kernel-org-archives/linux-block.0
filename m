Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820A4C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8BE208C3
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTENeTiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLKE1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:27:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41037 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfLKE1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 23:27:11 -0500
Received: by mail-pj1-f66.google.com with SMTP id ca19so8395515pjb.8;
        Tue, 10 Dec 2019 20:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7ypUOuVnqBd5be1hKp8bDLVVBRRPeaRQV9mQbkGU3s=;
        b=gTENeTiCkWr99yApgh/4VAIyoKDT3J7JznhYgYA4yoRd3lIV7Jm+5BL8ZWoTvA7zRp
         z9pynE4SbT7H+qeti2O+huH/QLAOHUl79cPlwnOC8jDVV7lx8IoXTxHIGs3rhJvAAMQa
         Yc6x1Rvg1pAjEwIvVGdP7984KVM3/BVxsgQNuP6LZ7fkAqAkavw1uX8LJtV2j+Zp6Lb5
         1awdDwCJI3o1m3td6EweC4s2Bl/AsVBEc+qxdVSUDqSpEWAbA3tf9WnGg8pegcAPS9R4
         5PjvVVq/2M5E9jWv0ThPdLHenPImUhlT90qLM1HLA+JaSUhSUgxpC8QDPSSX8C4XEFZT
         Jocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7ypUOuVnqBd5be1hKp8bDLVVBRRPeaRQV9mQbkGU3s=;
        b=mPi10sG4Z2nKcucE1v//XK+C/AaPOr2rjvYGNZ99xKs8r6gTYD1kmuvyKjcsN+bkoK
         G5JFoNafhr2puUkfl19yrliOCLPyfTZUiuvlEzKx9mbvQl/gv0BjYiih+qucnPAhvk9O
         4TPOXMntQWYjRq+zVGTTUhWdaaMKgXpBbJfFKDbDq9BBfgdUJPAusYZGABjck1mcKa5f
         EgQ82OKMi9hDb/3C6kdTqwbWjeNO9Dff5QY8OTvIfVkmzy/CfjLzv97ItYsQcUbg2XaS
         xpzWgBGsY/a3YbR8n+7fnqZXTyuieOpIa8uyXbiTerG/okKdyIiuzlPgI9fl91hqEloI
         kHdA==
X-Gm-Message-State: APjAAAUggu6AZpUTYUvdOzapGeWHQ3y52nCaEia+W8i+m6m9+wwm6Xqd
        nzQn8U5yTGT0XFFFPWob7N4=
X-Google-Smtp-Source: APXvYqxmdkRJdHXU4kf3uFrsdx5z19XOW4pKdUEplSPaVl+4BRm2wt+R0nQkpS14IKgOpvMW5oYY+g==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr1200544pjh.105.1576038430640;
        Tue, 10 Dec 2019 20:27:10 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id r62sm692916pfc.89.2019.12.10.20.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 20:27:09 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] xenbus/backend: Add memory pressure handler callback
Date:   Wed, 11 Dec 2019 04:26:57 +0000
Message-Id: <20191211042657.6037-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211042428.5961-1-sjpark@amazon.de>
References: <20191211042428.5961-1-sjpark@amazon.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack
flexibility.

To mitigate such problems, this commit adds a memory reclaim callback to
'xenbus_driver'.  If a memory pressure is detected, 'xenbus' requests
every backend driver to volunarily release its memory.

Note that it would be able to improve the callback facility for more
sophisticated handlings of general pressures.  For example, it would be
possible to monitor the memory consumption of each device and issue the
release requests to only devices which causing the pressure.  Also, the
callback could be extended to handle not only memory, but general
resources.  Nevertheless, this version of the implementation defers such
sophisticated goals as a future work.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++
 include/xen/xenbus.h                      |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4faf44c..aedbe2198de5 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -248,6 +248,35 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 	return NOTIFY_DONE;
 }
 
+static int xenbus_backend_reclaim(struct device *dev, void *data)
+{
+	struct xenbus_driver *drv;
+
+	if (!dev->driver)
+		return 0;
+	drv = to_xenbus_driver(dev->driver);
+	if (drv && drv->reclaim)
+		drv->reclaim(to_xenbus_device(dev));
+	return 0;
+}
+
+/*
+ * Returns 0 always because we are using shrinker to only detect memory
+ * pressure.
+ */
+static unsigned long xenbus_backend_shrink_count(struct shrinker *shrinker,
+				struct shrink_control *sc)
+{
+	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL,
+			xenbus_backend_reclaim);
+	return 0;
+}
+
+static struct shrinker xenbus_backend_shrinker = {
+	.count_objects = xenbus_backend_shrink_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static int __init xenbus_probe_backend_init(void)
 {
 	static struct notifier_block xenstore_notifier = {
@@ -264,6 +293,9 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
+	if (register_shrinker(&xenbus_backend_shrinker))
+		pr_warn("shrinker registration failed\n");
+
 	return 0;
 }
 subsys_initcall(xenbus_probe_backend_init);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..196260017666 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -104,6 +104,7 @@ struct xenbus_driver {
 	struct device_driver driver;
 	int (*read_otherend_details)(struct xenbus_device *dev);
 	int (*is_ready)(struct xenbus_device *dev);
+	void (*reclaim)(struct xenbus_device *dev);
 };
 
 static inline struct xenbus_driver *to_xenbus_driver(struct device_driver *drv)
-- 
2.17.1

