Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0FFC3B1AC
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E190247B7
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixr1uzWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfLMPgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:36:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46112 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLMPgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 10:36:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so1730173pgb.13;
        Fri, 13 Dec 2019 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxUD+VmkH1xxeAkPK92Cf10G5edui36/X8Za7R/dfvU=;
        b=Ixr1uzWSZhFf+lN6eqJRIzN6Nk/Q8MV4OUDFeqLklPVBvYba8reW18kTv4gIt2ty7W
         YFl4vqgRekirFS4RrCr28ScdT33deONmVd7zkU6xVyc+pjs87f8I9KQSebt2RinCiIiJ
         IfsHoNp5B9Ph+o7K1MKkspCPMOY4lSrYC654aGCs18gfIgwl29eKV9qlUoT3BDhB9au/
         creQfHb91b5xQ36j0Sl3Vr7OGSEXrM0cP+Re4OLVvxeOzKspYWT8Yso1bdSDNp2MZ7St
         R2iaDm9wu9Ez8nhDb4+Ailbv3qEUPdfnayJsJGNSy650S5txnbwbgw3OJG1/RK52m3K4
         zZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxUD+VmkH1xxeAkPK92Cf10G5edui36/X8Za7R/dfvU=;
        b=C+8ruMvR2TbKDlPLGXnByYm8tJsKp2x80+HO5IBsvncujsVOKyOWzz3Z3amQ2W79aG
         JN6z7rhM8M/DGZFYwv/jNVbCMR1vEol9oHAVCs0SfW0RSC1mX8fXtBa0ezeIclMy+IhF
         5lm/THd6PB3ISINDAZ43nwnxKezJrhM+IDWZM8dR66LtgZBps/XTwmGuyB4mil5+Yiax
         6r6qKcTlTRCi9rQ04iNbGPU03o6yL/NUoRFWPgdAv8yGXF5TcQdxda5l1CfyirvKHnpW
         cJhafRDJnVG0btb1kOeNDxuMhMudAV6aqT0dNNmd3gy5btje0Yn3R2TjDSYyR2V7t4YL
         p8Jg==
X-Gm-Message-State: APjAAAVHWaRqw1QhnCwE1QiRdz73wNVX3YQaLhGRGxtY612nxBrDunm0
        C5d7hDbSVnaa61dBZOulJRY=
X-Google-Smtp-Source: APXvYqxeZnSOB6LMFmDPGKrs65/NbWggTkEtyDaKTMLASFru59pOpOU1EFfyJv/RlrSyRw6JhLA9uw==
X-Received: by 2002:a65:6245:: with SMTP id q5mr17688689pgv.347.1576251366306;
        Fri, 13 Dec 2019 07:36:06 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id w131sm12039217pfc.16.2019.12.13.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:36:05 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/4] xenbus/backend: Add memory pressure handler callback
Date:   Fri, 13 Dec 2019 15:35:43 +0000
Message-Id: <20191213153546.17425-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213153546.17425-1-sjpark@amazon.de>
References: <20191213153546.17425-1-sjpark@amazon.de>
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

