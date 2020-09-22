Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBDDC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CB12395C
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tSGRoKdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVOQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:16:30 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:25964 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIVOQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600784189; x=1632320189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=I6FWFRPKOvHgCEvGqE3sI6rE2eUEbK6ToJxGZZYg2sI=;
  b=tSGRoKdzq48Eus/u0ZmdM2tk8rKJO20CgKd1MNUbvtlNPyRKMCWWP0ZV
   XViq0aPnnE50DKlMs6iRZg5crJGqTgyggyOmI7Q+DzBKLb1XR4NyEGXYI
   /hjZlqQ45sr3EnSqvDWmL0dbQOqnBIg6tNS3avD3bUnoReqzrJxREMfRS
   A=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="55537286"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 22 Sep 2020 14:16:26 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id B6EBFA1800;
        Tue, 22 Sep 2020 14:16:25 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.137) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 14:16:19 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] xen-blkfront: add a parameter for disabling of persistent grants
Date:   Tue, 22 Sep 2020 16:15:48 +0200
Message-ID: <20200922141549.26154-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922141549.26154-1-sjpark@amazon.com>
References: <20200922141549.26154-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.137]
X-ClientProxiedBy: EX13D12UWC001.ant.amazon.com (10.43.162.78) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Persistent grants feature provides high scalability.  On some small
systems, however, it could incur data copy overheads[1] and thus it is
required to be disabled.  It can be disabled from blkback side using a
module parameter, 'feature_persistent'.  But, it is impossible from
blkfront side.  For the reason, this commit adds a blkfront module
parameter for disabling of the feature.

[1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../ABI/testing/sysfs-driver-xen-blkfront     |  9 +++++++++
 drivers/block/xen-blkfront.c                  | 20 ++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
index c0a6cb7eb314..9c31334cb2e6 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
@@ -8,3 +8,12 @@ Description:
                 is 32 - higher value means more potential throughput but more
                 memory usage. The backend picks the minimum of the frontend
                 and its default backend value.
+
+What:           /sys/module/xen_blkfront/parameters/feature_persistent
+Date:           September 2020
+KernelVersion:  5.10
+Contact:        SeongJae Park <sjpark@amazon.de>
+Description:
+                Whether to enable the persistent grants feature or not.  Note
+                that this option only takes effect on newly created frontends.
+                The default is Y (enable).
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 91de2e0755ae..b2d3b1262404 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1866,8 +1866,8 @@ static int talk_to_blkback(struct xenbus_device *dev,
 		message = "writing protocol";
 		goto abort_transaction;
 	}
-	err = xenbus_printf(xbt, dev->nodename,
-			    "feature-persistent", "%u", 1);
+	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
+			info->feature_persistent);
 	if (err)
 		dev_warn(&dev->dev,
 			 "writing persistent grants feature to xenbus");
@@ -1941,6 +1941,13 @@ static int negotiate_mq(struct blkfront_info *info)
 	}
 	return 0;
 }
+
+/* Enable the persistent grants feature. */
+static bool feature_persistent = true;
+module_param(feature_persistent, bool, 0644);
+MODULE_PARM_DESC(feature_persistent,
+		"Enables the persistent grants feature");
+
 /**
  * Entry point to this code when a new device is created.  Allocate the basic
  * structures and the ring buffer for communication with the backend, and
@@ -2007,6 +2014,8 @@ static int blkfront_probe(struct xenbus_device *dev,
 	info->vdevice = vdevice;
 	info->connected = BLKIF_STATE_DISCONNECTED;
 
+	info->feature_persistent = feature_persistent ? 1 : 0;
+
 	/* Front end dir is a number, which is used as the id. */
 	info->handle = simple_strtoul(strrchr(dev->nodename, '/')+1, NULL, 0);
 	dev_set_drvdata(&dev->dev, info);
@@ -2316,9 +2325,10 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 	if (xenbus_read_unsigned(info->xbdev->otherend, "feature-discard", 0))
 		blkfront_setup_discard(info);
 
-	info->feature_persistent =
-		!!xenbus_read_unsigned(info->xbdev->otherend,
-				       "feature-persistent", 0);
+	if (info->feature_persistent)
+		info->feature_persistent =
+			!!xenbus_read_unsigned(info->xbdev->otherend,
+					       "feature-persistent", 0);
 
 	indirect_segments = xenbus_read_unsigned(info->xbdev->otherend,
 					"feature-max-indirect-segments", 0);
-- 
2.17.1

