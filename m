Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA17C34357
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7002D2473E
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPQHCu78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLMNCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:02:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35125 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLMNCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 08:02:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id w23so1188661pjd.2;
        Fri, 13 Dec 2019 05:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxUD+VmkH1xxeAkPK92Cf10G5edui36/X8Za7R/dfvU=;
        b=GPQHCu78Xrr1/A8JC4eIZflNvkPhPoIpyCbA1lUi7KEIi1tX/nXbPhKYzB1/tgT5dg
         hF7my/P3XQxI4B5TBnhiJeW5kYzjZlYY7dIHuGFzSFNT/IS6D0q51CCfCPROtMjzqoTw
         lHMCvZizgR+oxSHhMS0mu3DDiScOWpHwCevJ8qafgtsvOtf3+vACj5c7CCDNSWXjagSa
         bGJPMaGjJcjpupr9TXJEIJIReyOD6rY06JeczCa4RahX6gyimSg+H6+1fjLbhQJ2QQNd
         cRKEhUDEpDnW0ii97I+uPvLdgbvF74dwb6iQj83dofqtrbEfQ2IeiFzS9EwxANNEdNJa
         PsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxUD+VmkH1xxeAkPK92Cf10G5edui36/X8Za7R/dfvU=;
        b=Lf632yMXaSHMMc9UneBOp47dT6WBdQev0lJav1RBw0SxlGQv5DBjhxIaSXKS4IVNNP
         J5COWQvsNPxIKpRux3vaUgFDq7QXresQVIhRr5vmNIVIuf+K2lHjSW3sNShZPD20qVvC
         v4hklg4twXOa2Uavu0guvCk0lCFnmf7+bvwR+ygiDEYmAABQ+cwtiW1uMvvQWE51ibcI
         RWSLAD/2Okcyod7b83vmCV7/2haygSBwEDBtIOq4E4Kgp3TdHr3QF5/jyTadwN3mzGRe
         11/G0qR60h6ZPfwP+H+JKzbtJHMFM/fwoakhGGG/5mIFOpu6JH35+KPRvGYCyOOfEBWa
         09rQ==
X-Gm-Message-State: APjAAAUrtVDW1NCS3QAA1uOIIlO77vDB+8tmlsAM2b7xFL4TbtuDStgo
        cJwn617zHyCsLKhiUpqoJrM=
X-Google-Smtp-Source: APXvYqxE/Ac2824bFf20oZ8b1DfKFM1E4WD0jgI8CVJA/sd5exSlCoqpGrIsLq6AGBPaXEwcjeHpxw==
X-Received: by 2002:a17:902:bd98:: with SMTP id q24mr13563102pls.78.1576242161936;
        Fri, 13 Dec 2019 05:02:41 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id k3sm10872278pgc.3.2019.12.13.05.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 05:02:41 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] xenbus/backend: Add memory pressure handler callback
Date:   Fri, 13 Dec 2019 13:02:09 +0000
Message-Id: <20191213130211.24011-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213130211.24011-1-sjpark@amazon.de>
References: <20191213130211.24011-1-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
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

