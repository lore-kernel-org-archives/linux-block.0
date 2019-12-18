Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF78C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157E4227BF
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p+wRJAJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLRSjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:39:42 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:58340 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfLRSjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 13:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576694382; x=1608230382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8gVj8C/9BXkDKDUOd3ONU8KnhL+tF0LxKmRk3s9rxUQ=;
  b=p+wRJAJlBv9imnDy3zl3rRCqIiAa1en2riV6+tdl/uzqzBm8ZkOh4p/6
   IRN/+P+lOimlzhQExxYFj5X3r1B7QRWvCThYlQf4quFLr6omRndOQsHLW
   MEoXh0V2l4jTq/ksHr91W2bobPrWRNQvpr4nc+y45mCYG5sSWaXqKUqrt
   k=;
IronPort-SDR: 30n7usQVNfk8p4hBJNaLX+oCVM4RmEcO8RcG0HfxJY/P2W7m3UJzBHxEzPzmvKkDmlhbn9VeJ+
 he5p6adFuUMg==
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="14317361"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 Dec 2019 18:39:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 4EEAAA27A9;
        Wed, 18 Dec 2019 18:39:27 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Dec 2019 18:39:26 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.173) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 18:39:21 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 5/5] xen/blkback: Consistently insert one empty line between functions
Date:   Wed, 18 Dec 2019 19:39:08 +0100
Message-ID: <20191218183908.32243-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218183718.31719-1-sjpark@amazon.com>
References: <20191218183718.31719-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.173]
X-ClientProxiedBy: EX13D28UWB003.ant.amazon.com (10.43.161.60) To
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
index 24172c180f5f..c7f820db190a 100644
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
@@ -572,6 +572,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	if (err)
 		dev_warn(&dev->dev, "writing feature-discard (%d)", err);
 }
+
 int xen_blkbk_barrier(struct xenbus_transaction xbt,
 		      struct backend_info *be, int state)
 {
@@ -656,7 +657,6 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	return err;
 }
 
-
 /*
  * Callback received when the hotplug scripts have placed the physical-device
  * node.  Read it and the mode node, and create a vbd.  If the frontend is
@@ -748,7 +748,6 @@ static void backend_changed(struct xenbus_watch *watch,
 	}
 }
 
-
 /*
  * Callback received when the frontend's state changes.
  */
@@ -823,7 +822,6 @@ static void frontend_changed(struct xenbus_device *dev,
 	}
 }
 
-
 /* Once a memory pressure is detected, squeeze free page pools for a while. */
 static unsigned int buffer_squeeze_duration_ms = 10;
 module_param_named(buffer_squeeze_duration_ms,
@@ -846,7 +844,6 @@ static void reclaim_memory(struct xenbus_device *dev)
 
 /* ** Connection ** */
 
-
 /*
  * Write the physical details regarding the block device to the store, and
  * switch to Connected state.
-- 
2.17.1

