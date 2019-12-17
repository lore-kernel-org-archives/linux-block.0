Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C90C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B7021582
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bUbNcwA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfLQQLU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:11:20 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14523 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfLQQLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576599079; x=1608135079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+VnO6drUSeisUZRUWMUBisA9nUpj40JofIdvVB89+ew=;
  b=bUbNcwA3VQJQ00rDNGcyn7iss6VJGTQ5wjqx2h0qVKAs5dLPd2FZSUSX
   LnTODZoWjYnn07J81lkHTVtIWfXqCBBerx6KqhZhZis2CAfY3w8WNoid/
   dwvkjHvAjbMDdFXkwb9aOJQEfnAOqK87TV4zydX+7msBDAG2KWj3mek+M
   o=;
IronPort-SDR: oakdvpc6tP7QoLFiXVDReppeVEr/xrXgwlA2mbkjYORo6gnDp1GOdsOuE2pVvJrWhx3/hliMWe
 xl0vGcKKLquQ==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="15423396"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 17 Dec 2019 16:11:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 5E620A1D0C;
        Tue, 17 Dec 2019 16:11:05 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Dec 2019 16:11:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:10:59 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 6/6] xen/blkback: Consistently insert one empty line between functions
Date:   Tue, 17 Dec 2019 17:10:41 +0100
Message-ID: <20191217161041.1433-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217160748.693-1-sjpark@amazon.com>
References: <20191217160748.693-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D16UWC001.ant.amazon.com (10.43.162.117) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

The number of empty lines between functions in the xenbus.c is
inconsistent.  This trivial style cleanup commit fixes the file to
consistently place only one empty line.

Acked-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/xenbus.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 20045827a391..453f97dd533d 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -432,7 +432,6 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 	device_remove_file(&dev->dev, &dev_attr_physical_device);
 }
 
-
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
 	if (vbd->bdev)
@@ -489,6 +488,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		handle, blkif->domid);
 	return 0;
 }
+
 static int xen_blkbk_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
@@ -575,6 +575,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	if (err)
 		dev_warn(&dev->dev, "writing feature-discard (%d)", err);
 }
+
 int xen_blkbk_barrier(struct xenbus_transaction xbt,
 		      struct backend_info *be, int state)
 {
@@ -663,7 +664,6 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	return err;
 }
 
-
 /*
  * Callback received when the hotplug scripts have placed the physical-device
  * node.  Read it and the mode node, and create a vbd.  If the frontend is
@@ -755,7 +755,6 @@ static void backend_changed(struct xenbus_watch *watch,
 	}
 }
 
-
 /*
  * Callback received when the frontend's state changes.
  */
@@ -830,7 +829,6 @@ static void frontend_changed(struct xenbus_device *dev,
 	}
 }
 
-
 /* Once a memory pressure is detected, squeeze free page pools for a while. */
 static unsigned int buffer_squeeze_duration_ms = 10;
 module_param_named(buffer_squeeze_duration_ms,
@@ -855,7 +853,6 @@ static void reclaim_memory(struct xenbus_device *dev)
 
 /* ** Connection ** */
 
-
 /*
  * Write the physical details regarding the block device to the store, and
  * switch to Connected state.
-- 
2.17.1

