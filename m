Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8703BC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0E121582
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LKKLj0oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfLQQIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:08:47 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31104 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQQIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576598926; x=1608134926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7iSJLJ2cAmxa8ncDmqLUwW8DH/s+lSnJW62cph+wv5U=;
  b=LKKLj0ooIewpkD7z0MUnk60kwQ/2hE3O+alL21wZvpz8TaI+5zQVghWU
   mVqQFkSa1st/Z6qtiteInMSoyIyI31Q3Beigg41NkKM52MTaV7SDzRzyn
   pqpE8Ebs8LmhLxZ6s1kF8EvHRrnoLIh4eflvVJAKRkGbhjidn2v0joufZ
   k=;
IronPort-SDR: H+7E2oqbzQDJhYHLZVbZ3mLGSBt5rsH/mxSWSNhny4Yz5F0CKlFL2triHMLfQosYHORtLD42Qy
 warUym0tFP+A==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="5642913"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Dec 2019 16:08:46 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 80819A22EE;
        Tue, 17 Dec 2019 16:08:45 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Dec 2019 16:08:45 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:08:39 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 2/6] xenbus/backend: Protect xenbus callback with lock
Date:   Tue, 17 Dec 2019 17:07:44 +0100
Message-ID: <20191217160748.693-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217160748.693-1-sjpark@amazon.com>
References: <20191217160748.693-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'reclaim_memory' callback can race with a driver code as this callback
will be called from any memory pressure detected context.  To deal with
the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
'reclaim_memory' callback is called, the lock of the device which passed
to the callback as its argument is locked.  Thus, drivers registering
their 'reclaim_memory' callback should protect the data that might race
with the callback with the lock by themselves.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/xen/xenbus/xenbus_probe.c         |  1 +
 drivers/xen/xenbus/xenbus_probe_backend.c | 10 ++++++++--
 include/xen/xenbus.h                      |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5b471889d723..b86393f172e6 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -472,6 +472,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 		goto fail;
 
 	dev_set_name(&xendev->dev, "%s", devname);
+	spin_lock_init(&xendev->reclaim_lock);
 
 	/* Register with generic device framework. */
 	err = device_register(&xendev->dev);
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 7e78ebef7c54..516aa64b9967 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -251,12 +251,18 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 static int backend_reclaim_memory(struct device *dev, void *data)
 {
 	const struct xenbus_driver *drv;
+	struct xenbus_device *xdev;
+	unsigned long flags;
 
 	if (!dev->driver)
 		return 0;
 	drv = to_xenbus_driver(dev->driver);
-	if (drv && drv->reclaim_memory)
-		drv->reclaim_memory(to_xenbus_device(dev));
+	if (drv && drv->reclaim_memory) {
+		xdev = to_xenbus_device(dev);
+		spin_trylock_irqsave(&xdev->reclaim_lock, flags);
+		drv->reclaim_memory(xdev);
+		spin_unlock_irqrestore(&xdev->reclaim_lock, flags);
+	}
 	return 0;
 }
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index c861cfb6f720..d9468313061d 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -76,6 +76,8 @@ struct xenbus_device {
 	enum xenbus_state state;
 	struct completion down;
 	struct work_struct work;
+	/* 'reclaim_memory' callback is called while this lock is acquired */
+	spinlock_t reclaim_lock;
 };
 
 static inline struct xenbus_device *to_xenbus_device(struct device *dev)
-- 
2.17.1

