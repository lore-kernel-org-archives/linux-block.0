Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EBFC00454
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D29A24671
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cTSKbM41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfLKPaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:30:09 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:61065 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387751AbfLKPaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576078207; x=1607614207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUa3rMrxmsbf7wqyelx7uKp4w0L5PGnWaAJKZ1+2hRA=;
  b=cTSKbM41K5a+TpaQu2fopTrSOifueqCyPZ1HkG+kaBqU9sgD8BOFjW+c
   Msa66gq/9iug/gF0j0UOq7wByZ465T0LMJXKpqvpO2iTY8+FrD+IykA/t
   PpD7nvTh8VKzBh73ZEArTRgYzb7g5tiOaboJHp4x/dZne5eFlzJ55s1qw
   c=;
IronPort-SDR: k+ahKTZHIO0ciIGn4hMaP6zVJRPspOxO/cgWgiMFZcQpLsQqkQ6c1rHpCPrZg2+A0/TfDf2Ix1
 0d4IQXOJvoNw==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="8046829"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Dec 2019 15:30:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 2B8E7A245B;
        Wed, 11 Dec 2019 15:30:05 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:30:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:30:03 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 15:30:01 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3 1/4] xenbus: move xenbus_dev_shutdown() into frontend code...
Date:   Wed, 11 Dec 2019 15:29:53 +0000
Message-ID: <20191211152956.5168-2-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152956.5168-1-pdurrant@amazon.com>
References: <20191211152956.5168-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

...and make it static

xenbus_dev_shutdown() is seemingly intended to cause clean shutdown of PV
frontends when a guest is rebooted. Indeed the function waits for a
conpletion which is only set by a call to xenbus_frontend_closed().

This patch removes the shutdown() method from backends and moves
xenbus_dev_shutdown() from xenbus_probe.c into xenbus_probe_frontend.c,
renaming it appropriately and making it static.

NOTE: In the case where the backend is running in a driver domain, the
      toolstack should have already terminated any frontends that may be
      using it (since Xen does not support re-startable PV driver domains)
      so xenbus_dev_shutdown() should never be called.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/xenbus/xenbus.h                |  2 --
 drivers/xen/xenbus/xenbus_probe.c          | 23 ---------------------
 drivers/xen/xenbus/xenbus_probe_backend.c  |  1 -
 drivers/xen/xenbus/xenbus_probe_frontend.c | 24 +++++++++++++++++++++-
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index d75a2385b37c..5f5b8a7d5b80 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -116,8 +116,6 @@ int xenbus_probe_devices(struct xen_bus_type *bus);
 
 void xenbus_dev_changed(const char *node, struct xen_bus_type *bus);
 
-void xenbus_dev_shutdown(struct device *_dev);
-
 int xenbus_dev_suspend(struct device *dev);
 int xenbus_dev_resume(struct device *dev);
 int xenbus_dev_cancel(struct device *dev);
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index c21be6e9d38a..5aa29396c9e3 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -281,29 +281,6 @@ int xenbus_dev_remove(struct device *_dev)
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_remove);
 
-void xenbus_dev_shutdown(struct device *_dev)
-{
-	struct xenbus_device *dev = to_xenbus_device(_dev);
-	unsigned long timeout = 5*HZ;
-
-	DPRINTK("%s", dev->nodename);
-
-	get_device(&dev->dev);
-	if (dev->state != XenbusStateConnected) {
-		pr_info("%s: %s: %s != Connected, skipping\n",
-			__func__, dev->nodename, xenbus_strstate(dev->state));
-		goto out;
-	}
-	xenbus_switch_state(dev, XenbusStateClosing);
-	timeout = wait_for_completion_timeout(&dev->down, timeout);
-	if (!timeout)
-		pr_info("%s: %s timeout closing device\n",
-			__func__, dev->nodename);
- out:
-	put_device(&dev->dev);
-}
-EXPORT_SYMBOL_GPL(xenbus_dev_shutdown);
-
 int xenbus_register_driver_common(struct xenbus_driver *drv,
 				  struct xen_bus_type *bus,
 				  struct module *owner, const char *mod_name)
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4faf44c..14876faff3b0 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -198,7 +198,6 @@ static struct xen_bus_type xenbus_backend = {
 		.uevent		= xenbus_uevent_backend,
 		.probe		= xenbus_dev_probe,
 		.remove		= xenbus_dev_remove,
-		.shutdown	= xenbus_dev_shutdown,
 		.dev_groups	= xenbus_dev_groups,
 	},
 };
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index a7d90a719cea..8a1650bbe18f 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -126,6 +126,28 @@ static int xenbus_frontend_dev_probe(struct device *dev)
 	return xenbus_dev_probe(dev);
 }
 
+static void xenbus_frontend_dev_shutdown(struct device *_dev)
+{
+	struct xenbus_device *dev = to_xenbus_device(_dev);
+	unsigned long timeout = 5*HZ;
+
+	DPRINTK("%s", dev->nodename);
+
+	get_device(&dev->dev);
+	if (dev->state != XenbusStateConnected) {
+		pr_info("%s: %s: %s != Connected, skipping\n",
+			__func__, dev->nodename, xenbus_strstate(dev->state));
+		goto out;
+	}
+	xenbus_switch_state(dev, XenbusStateClosing);
+	timeout = wait_for_completion_timeout(&dev->down, timeout);
+	if (!timeout)
+		pr_info("%s: %s timeout closing device\n",
+			__func__, dev->nodename);
+ out:
+	put_device(&dev->dev);
+}
+
 static const struct dev_pm_ops xenbus_pm_ops = {
 	.suspend	= xenbus_dev_suspend,
 	.resume		= xenbus_frontend_dev_resume,
@@ -146,7 +168,7 @@ static struct xen_bus_type xenbus_frontend = {
 		.uevent		= xenbus_uevent_frontend,
 		.probe		= xenbus_frontend_dev_probe,
 		.remove		= xenbus_dev_remove,
-		.shutdown	= xenbus_dev_shutdown,
+		.shutdown	= xenbus_frontend_dev_shutdown,
 		.dev_groups	= xenbus_dev_groups,
 
 		.pm		= &xenbus_pm_ops,
-- 
2.20.1

