Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D5DC00454
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05D12465B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qyPDW5BJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfLKPaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:30:12 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:61065 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbfLKPaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576078210; x=1607614210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7nbgl2u0koiXf/XsA21xWuJDhFDTqL8hhIcGJQO/ns=;
  b=qyPDW5BJVD6pQ66zeAtBZ7VLqb+rQsjDhjQ/wzo3Ic7f/rjHgkAJCDu9
   BeOmFVy08PDKw2okSjbFi8UTxeT1QDK+10AmqfDntCaYMaFOJ0n/Zo3TX
   X+vwfLyHDsGoIhWzrZ+dkTudSbeQ0RVLTLCEdXkjqhvx5ZsSuJxJRGUo3
   0=;
IronPort-SDR: 4GuYu5bux2FjlFDxqmxuq57ilbkO5edyeI/1nMkdV9vzHCHfele8wzk9nIAxN04sSYwiqygnzs
 kyHNvVe+sbcw==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="8046840"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Dec 2019 15:30:09 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 32C03A2C58;
        Wed, 11 Dec 2019 15:30:08 +0000 (UTC)
Received: from EX13D32EUB002.ant.amazon.com (10.43.166.114) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:30:07 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUB002.ant.amazon.com (10.43.166.114) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:30:06 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 15:30:04 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH v3 2/4] xenbus: limit when state is forced to closed
Date:   Wed, 11 Dec 2019 15:29:54 +0000
Message-ID: <20191211152956.5168-3-pdurrant@amazon.com>
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

If a driver probe() fails then leave the xenstore state alone. There is no
reason to modify it as the failure may be due to transient resource
allocation issues and hence a subsequent probe() may succeed.

If the driver supports re-binding then only force state to closed during
remove() only in the case when the toolstack may need to clean up. This can
be detected by checking whether the state in xenstore has been set to
closing prior to device removal.

NOTE: Re-bind support is indicated by new boolean in struct xenbus_driver,
      which defaults to false. Subsequent patches will add support to
      some backend drivers.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - Introduce the 'allow_rebind' flag
 - Expand the commit comment
---
 drivers/xen/xenbus/xenbus_probe.c | 12 ++++++++++--
 include/xen/xenbus.h              |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5aa29396c9e3..378486b79f96 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -255,7 +255,6 @@ int xenbus_dev_probe(struct device *_dev)
 	module_put(drv->driver.owner);
 fail:
 	xenbus_dev_error(dev, err, "xenbus_dev_probe on %s", dev->nodename);
-	xenbus_switch_state(dev, XenbusStateClosed);
 	return err;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_probe);
@@ -276,7 +275,16 @@ int xenbus_dev_remove(struct device *_dev)
 
 	free_otherend_details(dev);
 
-	xenbus_switch_state(dev, XenbusStateClosed);
+	/*
+	 * If the toolstack has forced the device state to closing then set
+	 * the state to closed now to allow it to be cleaned up.
+	 * Similarly, if the driver does not support re-bind, set the
+	 * closed.
+	 */
+	if (!drv->allow_rebind ||
+	    xenbus_read_driver_state(dev->nodename) == XenbusStateClosing)
+		xenbus_switch_state(dev, XenbusStateClosed);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_remove);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..24228a102141 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -93,6 +93,7 @@ struct xenbus_device_id
 struct xenbus_driver {
 	const char *name;       /* defaults to ids[0].devicetype */
 	const struct xenbus_device_id *ids;
+	bool allow_rebind; /* avoid setting xenstore closed during remove */
 	int (*probe)(struct xenbus_device *dev,
 		     const struct xenbus_device_id *id);
 	void (*otherend_changed)(struct xenbus_device *dev,
-- 
2.20.1

