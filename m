Return-Path: <SRS0=/Ic2=3Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C8C32771
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 08:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB86C21569
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 08:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sl1XLumY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgA0ISz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:18:55 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64700 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0ISz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 03:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580113134; x=1611649134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dm2qM4W8b5BZdLKOsyrt63daqngTk+Y1qGr35fS4OsQ=;
  b=Sl1XLumYG4ZH2TttT2rvh1D+v24iWZ93U4dIxdb/3uyj5iv4MRXBVCXo
   q2eO6qnmnsSy7zbcxyvkgWfvsVqZIykSOjhlO2q/yOf81WiOitkxp2pF5
   jaGJ+4eEbykMNLEcEnb76tOH2jLEKqiXou5F2JfL0UVtfp7h+Vs1zSQx6
   s=;
IronPort-SDR: 8RkC+dRPpNCwzT4oTt6mIf+gDHsQWjpSZz9W0iuH2mB9IduHH3/j/VwwIVPHBKf6fOA/8AKhxt
 kPzbR7pnDsHQ==
X-IronPort-AV: E=Sophos;i="5.70,369,1574121600"; 
   d="scan'208";a="22599829"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 27 Jan 2020 08:18:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id BD122A2750;
        Mon, 27 Jan 2020 08:18:46 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 27 Jan 2020 08:18:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.8) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 27 Jan 2020 08:18:41 +0000
From:   <sjpark@amazon.com>
To:     <jgross@suse.com>, <roger.pau@citrix.com>, <axboe@kernel.dk>
CC:     SeongJae Park <sjpark@amazon.de>, <konrad.wilk@oracle.com>,
        <pdurrant@amazon.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 2/5] xenbus/backend: Protect xenbus callback with lock
Date:   Mon, 27 Jan 2020 09:18:09 +0100
Message-ID: <20200127081812.21216-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127081812.21216-1-sjpark@amazon.com>
References: <20200127081812.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.8]
X-ClientProxiedBy: EX13D11UWB004.ant.amazon.com (10.43.161.90) To
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

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/xen/xenbus/xenbus_probe.c         |  8 +++++++-
 drivers/xen/xenbus/xenbus_probe_backend.c | 10 ++++++++--
 include/xen/xenbus.h                      |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 378486b79f96..66975da4f3b6 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -239,7 +239,9 @@ int xenbus_dev_probe(struct device *_dev)
 		goto fail;
 	}
 
+	spin_lock(&dev->reclaim_lock);
 	err = drv->probe(dev, id);
+	spin_unlock(&dev->reclaim_lock);
 	if (err)
 		goto fail_put;
 
@@ -268,8 +270,11 @@ int xenbus_dev_remove(struct device *_dev)
 
 	free_otherend_watch(dev);
 
-	if (drv->remove)
+	if (drv->remove) {
+		spin_lock(&dev->reclaim_lock);
 		drv->remove(dev);
+		spin_unlock(&dev->reclaim_lock);
+	}
 
 	module_put(drv->driver.owner);
 
@@ -468,6 +473,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 		goto fail;
 
 	dev_set_name(&xendev->dev, "%s", devname);
+	spin_lock_init(&xendev->reclaim_lock);
 
 	/* Register with generic device framework. */
 	err = device_register(&xendev->dev);
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 3b5cb7a5a7e4..791f6fe01e91 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -250,12 +250,18 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
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
index 980952ea452b..89a889585ba0 100644
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

