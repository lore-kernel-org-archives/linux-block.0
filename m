Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB9C2D0C5
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4852077B
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 08:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPza1JEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfLJIGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:06:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38215 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfLJIGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 03:06:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so18893374wrh.5;
        Tue, 10 Dec 2019 00:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QwGsEms4piE9a2DBjMxlpqS/fTzaKgAUBvTe2FzVG7A=;
        b=lPza1JEHlTNKLzFDCDRnVo7HF92gkuhkIa1h7FjUOXfSbg8cJNbwj22lMhzGmLWQM9
         EuWz/6RijlKpCghZcVe3rWIOXVZ+A9aqVJpF6BsEL2ih8fTyYXlYEfgwFVcxcG+UZh0b
         In2tw6g7OqQrdDqrIU2uDeX8GfA7NdmDamY7upGqhCceTUDRnF0kmdlKLR3NJx75Co12
         CMcB9hXFxUxJer4fTd1qBw5yf9v4G/6MTQPWhgB+sRzuVRo/hUuVXnquQbiWhxJixdCw
         1ambSMWkD03j7VE0keCQ0T8J0Bl0P7Q38teIHMQNLfq/p+ufiRsQ8xEwzGBeKIMMBmRP
         bhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QwGsEms4piE9a2DBjMxlpqS/fTzaKgAUBvTe2FzVG7A=;
        b=WJou7sMHGbjW+91tCbnsA7ddzFBa/0TmMhEvNFeHkkSLZV0delqg5eNJ3lq8IyPF1l
         WfAG7i9XfD8p/yazG38UHWmjGhNP+pBxb4ppqWnOHly5uhNbny28BcQS/2YofXDKgD3B
         vETP4BFp3g08XQtsTQ1dG9GnY3UC27Qcrg9b/NfWz4a09UOAzRsQ78i+8rgTDpeV/Opo
         5RA+pwXY8gYrWazwC92W5H4r1eSPTvL7pjNNGw/gjPAEnHUwTr1zbgjOSJKhbnAQBgGO
         2k1XvSA3gD1K4K/xXvDhq2TeRpvCzVCPVqp7ye1TVoA6NCFizGPYCnn4f4si6WmlSv4X
         /RVw==
X-Gm-Message-State: APjAAAVLVuZjdb/JzJ7Fuwa7dPdpKCds8pWTwBeQzM+2jF09MO+h1wbV
        mp2/3j4MosZANOqkWKy7mA0=
X-Google-Smtp-Source: APXvYqyeW1Ot1SkJg8uOlMtOudbd9EEcZEGOP8qLc0yzxcBnOs2OKqXQe5RAMyAarTVhuIvkXVwDXw==
X-Received: by 2002:adf:e812:: with SMTP id o18mr1543550wrm.127.1575965204034;
        Tue, 10 Dec 2019 00:06:44 -0800 (PST)
Received: from localhost.localdomain (x2f7fae7.dyn.telefonica.de. [2.247.250.231])
        by smtp.gmail.com with ESMTPSA id a16sm2342587wrt.37.2019.12.10.00.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 00:06:43 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sjpark@amazon.com
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, roger.pau@citrix.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v5 1/2] xenbus/backend: Add memory pressure handler callback
Date:   Tue, 10 Dec 2019 08:06:27 +0000
Message-Id: <20191210080628.5264-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210080628.5264-1-sjpark@amazon.de>
References: <20191210080628.5264-1-sjpark@amazon.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack a
flexibility.

To mitigate such problems, this commit adds a memory reclaim callback to
'xenbus_driver'.  Using this facility, 'xenbus' would be able to monitor
a memory pressure and request specific devices of specific backend
drivers which causing the given pressure to voluntarily release its
memory.

That said, this commit simply requests every callback registered driver
to release its memory for every domain, rather than issueing the
requests to the drivers and the domain in charge.  Such things will be
done in a futur.  Also, this commit focuses on memory only.  However, it
would be ablt to be extended for general resources.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
 include/xen/xenbus.h                      |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4faf44c..5a5ba29e39df 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -248,6 +248,34 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 	return NOTIFY_DONE;
 }
 
+static int xenbus_backend_reclaim(struct device *dev, void *data)
+{
+	struct xenbus_driver *drv;
+	if (!dev->driver)
+		return -ENOENT;
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
@@ -264,6 +292,9 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
+	if (register_shrinker(&xenbus_backend_shrinker))
+		pr_warn("shrinker registration failed\n");
+
 	return 0;
 }
 subsys_initcall(xenbus_probe_backend_init);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..cdb075e4182f 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -104,6 +104,7 @@ struct xenbus_driver {
 	struct device_driver driver;
 	int (*read_otherend_details)(struct xenbus_device *dev);
 	int (*is_ready)(struct xenbus_device *dev);
+	unsigned (*reclaim)(struct xenbus_device *dev);
 };
 
 static inline struct xenbus_driver *to_xenbus_driver(struct device_driver *drv)
-- 
2.17.1

