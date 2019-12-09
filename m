Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD3C00454
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF5F2073D
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kYUAXLOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLITnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:43:43 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4479 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLITnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 14:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575920622; x=1607456622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZE8Q93B/xx3iZvNs636Is5jtO2+LQkQ6Lgs21sPQn/A=;
  b=kYUAXLOOKNoUpnw7AAP5pXj2jv0qnOAVZYL/TFrXrnv6KIon4zWeSIrT
   xHJLh3B5sYE63rrc2ecy8yhGTy8gz3+wpsCzutOGRMkRDig8SwJ5XeXsI
   yCTlp4wnA6AXd09k8yMC5v4J/ojLjFImn1PV+wWneaPdaNgebyV9wl3MC
   8=;
IronPort-SDR: DqI3zjyrOzxNYdeRltiX532bxf3sUW/N/wlytvrCz+1pyT/fux9KBZDaFvtx4cvvK10MayqtRC
 +GVxKnIid+5A==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="8315187"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 09 Dec 2019 19:43:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 2A552A1CAF;
        Mon,  9 Dec 2019 19:43:39 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 19:43:38 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 19:43:33 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <sjpark@amazon.com>
CC:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <roger.pau@citrix.com>,
        <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v4 1/2] xenbus/backend: Add memory pressure handler callback
Date:   Mon, 9 Dec 2019 20:43:04 +0100
Message-ID: <20191209194305.20828-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209194305.20828-1-sjpark@amazon.com>
References: <20191209194305.20828-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D30UWC003.ant.amazon.com (10.43.162.122) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lacks a
flexibility.

To mitigate such problems, this commit adds a memory reclaim callback to
'xenbus_driver'.  Using this facility, 'xenbus' would be able to monitor
a memory pressure and request specific domains of specific backend
drivers which causing the given pressure to voluntarily release its
memory.

That said, this commit simply requests every callback registered driver
to release its memory for every domain, rather than issueing the
requests to the drivers and domain in charge.  Such things would be a
future work.  Also, this commit focuses on memory only.  However, it
would be ablt to be extended for general resources.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
 include/xen/xenbus.h                      |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4faf44c..cd5fd1cd8de3 100644
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
+		drv->reclaim(to_xenbus_device(dev), DOMID_INVALID);
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
index 869c816d5f8c..52aaf4f78400 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -104,6 +104,7 @@ struct xenbus_driver {
 	struct device_driver driver;
 	int (*read_otherend_details)(struct xenbus_device *dev);
 	int (*is_ready)(struct xenbus_device *dev);
+	unsigned (*reclaim)(struct xenbus_device *dev, domid_t domid);
 };
 
 static inline struct xenbus_driver *to_xenbus_driver(struct device_driver *drv)
-- 
2.17.1

