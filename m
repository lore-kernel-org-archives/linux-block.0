Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239DCC43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D3E2176D
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X4RnpPqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLRSh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:37:56 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:58890 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfLRShz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 13:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576694275; x=1608230275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Xpzt6vDQRDOijp8HV3H/w1zG6CWqztMhFIxNrpBJVT0=;
  b=X4RnpPqXbiTyXVZL8nAzUSw4FPwJpcwAVdfBohIPO0tiGPO3m0ABztUq
   J7GgA9kxfdjCz4aq5ATgSULEAiYiw4lwq06pnGe1Q62/yPK2viyl+Aa9v
   mXYHl5EF6qyqQTfySbLhQrrWNtlSud0yfiaysPQXO11so0mS9N7J8+XmC
   s=;
IronPort-SDR: XumbSHl7NofUH0IrubD4nexBoYveeVSBcTWZqS4Vl14pPxC3jLPKPlQS8+AezuOdkY6oTi3YJW
 uAxTCQuOiC6g==
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="9153445"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 18 Dec 2019 18:37:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 6C3FBA1F54;
        Wed, 18 Dec 2019 18:37:53 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 18:37:52 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 18:37:47 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 2/5] xenbus/backend: Protect xenbus callback with lock
Date:   Wed, 18 Dec 2019 19:37:15 +0100
Message-ID: <20191218183718.31719-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218183718.31719-1-sjpark@amazon.com>
References: <20191218183718.31719-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.109]
X-ClientProxiedBy: EX13D10UWB003.ant.amazon.com (10.43.161.106) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

A driver's 'reclaim_memory' callback can race with 'probe' or 'remove'
because it will be called whenever memory pressure is detected.  To
avoid such race, this commit embeds a spinlock in each 'xenbus_device'
and make 'xenbus' to hold the lock while the corresponded callbacks are
running.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/xen/xenbus/xenbus_probe.c         |  8 +++++++-
 drivers/xen/xenbus/xenbus_probe_backend.c | 10 ++++++++--
 include/xen/xenbus.h                      |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5b471889d723..9ed556ba4fd4 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -232,7 +232,9 @@ int xenbus_dev_probe(struct device *_dev)
 		return err;
 	}
 
+	spin_lock(&dev->reclaim_lock);
 	err = drv->probe(dev, id);
+	spin_unlock(&dev->reclaim_lock);
 	if (err)
 		goto fail;
 
@@ -260,8 +262,11 @@ int xenbus_dev_remove(struct device *_dev)
 
 	free_otherend_watch(dev);
 
-	if (drv->remove)
+	if (drv->remove) {
+		spin_lock(&dev->reclaim_lock);
 		drv->remove(dev);
+		spin_unlock(&dev->reclaim_lock);
+	}
 
 	free_otherend_details(dev);
 
@@ -472,6 +477,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 		goto fail;
 
 	dev_set_name(&xendev->dev, "%s", devname);
+	spin_lock_init(&xendev->reclaim_lock);
 
 	/* Register with generic device framework. */
 	err = device_register(&xendev->dev);
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 7e78ebef7c54..bc61372e00a1 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -251,12 +251,18 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 static int backend_reclaim_memory(struct device *dev, void *data)
 {
 	const struct xenbus_driver *drv;
+	struct xenbus_device *xdev;
 
 	if (!dev->driver)
 		return 0;
 	drv = to_xenbus_driver(dev->driver);
-	if (drv && drv->reclaim_memory)
-		drv->reclaim_memory(to_xenbus_device(dev));
+	if (drv && drv->reclaim_memory) {
+		xdev = to_xenbus_device(dev);
+		if (!spin_trylock(&xdev->reclaim_lock))
+			return 0;
+		drv->reclaim_memory(xdev);
+		spin_unlock(&xdev->reclaim_lock);
+	}
 	return 0;
 }
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index c861cfb6f720..45cd61cb6e86 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -76,6 +76,7 @@ struct xenbus_device {
 	enum xenbus_state state;
 	struct completion down;
 	struct work_struct work;
+	spinlock_t reclaim_lock;
 };
 
 static inline struct xenbus_device *to_xenbus_device(struct device *dev)
-- 
2.17.1

