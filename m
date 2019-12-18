Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F8C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 10:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498FA2465E
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 10:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Myon/dg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLRKnd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:43:33 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:21363 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfLRKnd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 05:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576665813; x=1608201813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+zW5Xl7nIWaH59KtKB8TMfJ8+qGCgB0IlDIGxqn2j8U=;
  b=Myon/dg+lOX3FcaNQKg2+CFD5bYbrwt3b0TuuF0Swuv5Vy0awswWU8Wh
   ptyFQwxboSBL/sskwuCE9lDPlWSY5jCTKXebB9/vtsYDlymcXaslsW7eL
   hbdwk1qi4oIikDC1nVDkT72Ao9bTEhjG5HbInlVOq/MiVhnBaVPW2/Q1p
   o=;
IronPort-SDR: c0niSukasfQpNaphYn8H13G8sbDU0LWgOwvWZjYo8JngTn00Yd9CGiWJT1PR7ouInXEAfk34MW
 C/20QdjnyhWA==
X-IronPort-AV: E=Sophos;i="5.69,329,1571702400"; 
   d="scan'208";a="5820940"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Dec 2019 10:43:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 0119EA1927;
        Wed, 18 Dec 2019 10:43:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Dec 2019 10:43:20 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 10:43:15 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 2/5] xenbus/backend: Protect xenbus callback with lock
Date:   Wed, 18 Dec 2019 11:42:29 +0100
Message-ID: <20191218104232.9606-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218104232.9606-1-sjpark@amazon.com>
References: <20191218104232.9606-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D18UWA003.ant.amazon.com (10.43.160.238) To
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
 drivers/xen/xenbus/xenbus_probe_backend.c | 11 +++++++++--
 include/xen/xenbus.h                      |  2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

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
index 7e78ebef7c54..e862cb932cc4 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -251,12 +251,19 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
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
+		if (!spin_trylock_irqsave(&xdev->reclaim_lock, flags))
+			return 0;
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

