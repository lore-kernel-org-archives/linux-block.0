Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D12C4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 06:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B4821D43
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 06:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c5Oa9jDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgIWGTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 02:19:23 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21096 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIWGTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 02:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600841963; x=1632377963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qIdI2Ar+FjlI0h5NCqVRr5Ean1G5IGrdck+ZoSf7G0w=;
  b=c5Oa9jDDccuvfyfRuSH9Krksx/ZUvGQ0gBmDj5i+/RIflRz8g4nx+eSJ
   tNB6BALvyelgRch8RKsyFiUTg7oGHcCQDZiT9reJGpGHbgFwofaoKj/IG
   v3EM8/CzQQ8PnXJ4jArHlwOEt2/4fe+qyn3TSWXwf/ZwlyVhF53ZBM1rm
   k=;
X-IronPort-AV: E=Sophos;i="5.77,293,1596499200"; 
   d="scan'208";a="77284083"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Sep 2020 06:19:14 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id B2778A1DEE;
        Wed, 23 Sep 2020 06:19:12 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.85) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Sep 2020 06:19:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] xen-blkback: add a parameter for disabling of persistent grants
Date:   Wed, 23 Sep 2020 08:18:39 +0200
Message-ID: <20200923061841.20531-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923061841.20531-1-sjpark@amazon.com>
References: <20200923061841.20531-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.85]
X-ClientProxiedBy: EX13D10UWB001.ant.amazon.com (10.43.161.111) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Persistent grants feature provides high scalability.  On some small
systems, however, it could incur data copy overheads[1] and thus it is
required to be disabled.  But, there is no option to disable it.  For
the reason, this commit adds a module parameter for disabling of the
feature.

[1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability

Signed-off-by: Anthony Liguori <aliguori@amazon.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---
 .../ABI/testing/sysfs-driver-xen-blkback      |  9 ++++++++
 drivers/block/xen-blkback/xenbus.c            | 22 ++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index ecb7942ff146..ac2947b98950 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -35,3 +35,12 @@ Description:
                 controls the duration in milliseconds that blkback will not
                 cache any page not backed by a grant mapping.
                 The default is 10ms.
+
+What:           /sys/module/xen_blkback/parameters/feature_persistent
+Date:           September 2020
+KernelVersion:  5.10
+Contact:        SeongJae Park <sjpark@amazon.de>
+Description:
+                Whether to enable the persistent grants feature or not.  Note
+                that this option only takes effect on newly created backends.
+                The default is Y (enable).
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b9aa5d1ac10b..8fc34211dc8b 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -474,6 +474,12 @@ static void xen_vbd_free(struct xen_vbd *vbd)
 	vbd->bdev = NULL;
 }
 
+/* Enable the persistent grants feature. */
+static bool feature_persistent = true;
+module_param(feature_persistent, bool, 0644);
+MODULE_PARM_DESC(feature_persistent,
+		"Enables the persistent grants feature");
+
 static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 			  unsigned major, unsigned minor, int readonly,
 			  int cdrom)
@@ -519,6 +525,8 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	if (q && blk_queue_secure_erase(q))
 		vbd->discard_secure = true;
 
+	vbd->feature_gnt_persistent = feature_persistent;
+
 	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
 		handle, blkif->domid);
 	return 0;
@@ -906,7 +914,8 @@ static void connect(struct backend_info *be)
 
 	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
+	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
+			be->blkif->vbd.feature_gnt_persistent);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "writing %s/feature-persistent",
 				 dev->nodename);
@@ -1067,7 +1076,6 @@ static int connect_ring(struct backend_info *be)
 {
 	struct xenbus_device *dev = be->dev;
 	struct xen_blkif *blkif = be->blkif;
-	unsigned int pers_grants;
 	char protocol[64] = "";
 	int err, i;
 	char *xspath;
@@ -1093,9 +1101,11 @@ static int connect_ring(struct backend_info *be)
 		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
 		return -ENOSYS;
 	}
-	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-persistent",
-					   0);
-	blkif->vbd.feature_gnt_persistent = pers_grants;
+	if (blkif->vbd.feature_gnt_persistent)
+		blkif->vbd.feature_gnt_persistent =
+			xenbus_read_unsigned(dev->otherend,
+					"feature-persistent", 0);
+
 	blkif->vbd.overflow_max_grants = 0;
 
 	/*
@@ -1118,7 +1128,7 @@ static int connect_ring(struct backend_info *be)
 
 	pr_info("%s: using %d queues, protocol %d (%s) %s\n", dev->nodename,
 		 blkif->nr_rings, blkif->blk_protocol, protocol,
-		 pers_grants ? "persistent grants" : "");
+		 blkif->vbd.feature_gnt_persistent ? "persistent grants" : "");
 
 	ring_page_order = xenbus_read_unsigned(dev->otherend,
 					       "ring-page-order", 0);
-- 
2.17.1

