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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF958C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8428B222C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMcrM/a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfLKSKq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:10:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33389 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKSKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 13:10:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so9235247pjb.0;
        Wed, 11 Dec 2019 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CBFLhKYtbh2VNxkOJ2giC+Rjy+sK84fG3vM0BZU3YDk=;
        b=QMcrM/a96I5Df0ev6kPioTowBPg7nQtSm25XTPzV65EE/zQ3OmHVEy0LDH1zwUwlEL
         WocnaZHNhWvI505kCWkRM7qEqPoSCuxqWy3L4IZTn/VBcOAE0s9oWz//mECw6uFQSqv7
         Vkg5IamM1U2zAwps7yvMkYYeY92CEHV/n0FqAfsU9bCe762GpCg1cnhPn2bTXCdoUz0X
         R/YEMYmM2MnLsL+akDxFpEOhsLzlzPFVL5pIUjmfzT+3xv12DgEKrQWVnW6RfDDltrhn
         U6Ifr4h64BP5I7iuey/Qnxead+Q+Gwh8m0qZddJNc543r4mdPM3cR6Hxq3P2AaRPx6CD
         +u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CBFLhKYtbh2VNxkOJ2giC+Rjy+sK84fG3vM0BZU3YDk=;
        b=c1sJ3hAbBPv6Wvqz0JDKaQkEBz1Zlzfv9eUcMPprq7d0EzF1JHkv+LlGWz7rQuNqh4
         mnIOi4NK+AboQnrNVQD7XN6CiVCUYowicSRFKYdH/JuCVvstrlCaisxy4WGJTvNPA8av
         LFrRgKAnbXfvymGFNW8SCVwbP/YJDAN3FeBOhjOkx4jnMhYMF9jgCeYao5iW98zISCQs
         X8rSH3azyn9JC6idYyuTAujeHOK/0zCL+ejr3AYhovXmkS5CSfDcpjE0LCCF5Edsj+oF
         zf2ze7W5K6isCujyjHJf8b1I/LEDhLi2Rg8lYx+4hR5un3HLgp6e+UwPh+hlGUsjHfa7
         9GSw==
X-Gm-Message-State: APjAAAWJ3bk/GeuudAr2g0+hjw4VqujiYSHAjZti7JrPjwQ5yRAs0VNe
        5vn5McyGeuucW2KfPssUsLo=
X-Google-Smtp-Source: APXvYqz35OSt4NjHe0So4NySEyGwPj/l9mTgQdCNzqEjQgdPCD/iwfZ5caUyI2FonkHxWKhbHyr5Sw==
X-Received: by 2002:a17:902:d907:: with SMTP id c7mr4778687plz.40.1576087845001;
        Wed, 11 Dec 2019 10:10:45 -0800 (PST)
Received: from localhost.localdomain (campus-094-212.ucdavis.edu. [168.150.94.212])
        by smtp.gmail.com with ESMTPSA id x33sm3552651pga.86.2019.12.11.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:10:44 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] xenbus/backend: Add memory pressure handler callback
Date:   Wed, 11 Dec 2019 18:10:14 +0000
Message-Id: <20191211181016.14366-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211181016.14366-1-sjpark@amazon.de>
References: <20191211181016.14366-1-sjpark@amazon.de>
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
index b0bed4faf44c..7e78ebef7c54 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -248,6 +248,35 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 	return NOTIFY_DONE;
 }
 
+static int backend_reclaim_memory(struct device *dev, void *data)
+{
+	const struct xenbus_driver *drv;
+
+	if (!dev->driver)
+		return 0;
+	drv = to_xenbus_driver(dev->driver);
+	if (drv && drv->reclaim_memory)
+		drv->reclaim_memory(to_xenbus_device(dev));
+	return 0;
+}
+
+/*
+ * Returns 0 always because we are using shrinker to only detect memory
+ * pressure.
+ */
+static unsigned long backend_shrink_memory_count(struct shrinker *shrinker,
+				struct shrink_control *sc)
+{
+	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL,
+			backend_reclaim_memory);
+	return 0;
+}
+
+static struct shrinker backend_memory_shrinker = {
+	.count_objects = backend_shrink_memory_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static int __init xenbus_probe_backend_init(void)
 {
 	static struct notifier_block xenstore_notifier = {
@@ -264,6 +293,9 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
+	if (register_shrinker(&backend_memory_shrinker))
+		pr_warn("shrinker registration failed\n");
+
 	return 0;
 }
 subsys_initcall(xenbus_probe_backend_init);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..c861cfb6f720 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -104,6 +104,7 @@ struct xenbus_driver {
 	struct device_driver driver;
 	int (*read_otherend_details)(struct xenbus_device *dev);
 	int (*is_ready)(struct xenbus_device *dev);
+	void (*reclaim_memory)(struct xenbus_device *dev);
 };
 
 static inline struct xenbus_driver *to_xenbus_driver(struct device_driver *drv)
-- 
2.17.1

