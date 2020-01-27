Return-Path: <SRS0=/Ic2=3Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D23C32771
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4F621734
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 08:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XLcKm8FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgA0IUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:20:21 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:30718 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0IUV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 03:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580113221; x=1611649221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0bGMY0UnkD1SQDKudWK+VHlWYQo9kxn8xvkLvZ6+gw=;
  b=XLcKm8FAcgjV4pp0WWnzqFGlPql+ruqX6bDl1rXKLgY7VGN4vTseioDn
   HlBHN9j4sAakI3mE45ngq7M8hsrObyU5/fO00iZk+SJIHtEaztlDLv+H2
   hQWacGVt4/ddCe6LEIq6PhdqQF34+Yf5SqDR7A42/E/0ykDPiiTscUx55
   c=;
IronPort-SDR: nJ6CGo/h7Rj8evct5993fDuaqqM8Fs4H2y02wDFZ2uT5VCpoe44uYjQlucDgefYn99dFDE3SE8
 G+O8acrjKseA==
X-IronPort-AV: E=Sophos;i="5.70,369,1574121600"; 
   d="scan'208";a="14868091"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 Jan 2020 08:20:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 2F458C5A7D;
        Mon, 27 Jan 2020 08:20:16 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 27 Jan 2020 08:20:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.78) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 27 Jan 2020 08:20:11 +0000
From:   <sjpark@amazon.com>
To:     <jgross@suse.com>, <roger.pau@citrix.com>, <axboe@kernel.dk>
CC:     SeongJae Park <sjpark@amazon.de>, <konrad.wilk@oracle.com>,
        <pdurrant@amazon.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 5/5] xen/blkback: Consistently insert one empty line between functions
Date:   Mon, 27 Jan 2020 09:19:57 +0100
Message-ID: <20200127081957.21509-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127081812.21216-1-sjpark@amazon.com>
References: <20200127081812.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.78]
X-ClientProxiedBy: EX13D25UWB001.ant.amazon.com (10.43.161.245) To
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
index 55960190b774..42944d41aea0 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -467,7 +467,6 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 	device_remove_file(&dev->dev, &dev_attr_physical_device);
 }
 
-
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
 	if (vbd->bdev)
@@ -524,6 +523,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		handle, blkif->domid);
 	return 0;
 }
+
 static int xen_blkbk_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
@@ -607,6 +607,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	if (err)
 		dev_warn(&dev->dev, "writing feature-discard (%d)", err);
 }
+
 int xen_blkbk_barrier(struct xenbus_transaction xbt,
 		      struct backend_info *be, int state)
 {
@@ -691,7 +692,6 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	return err;
 }
 
-
 /*
  * Callback received when the hotplug scripts have placed the physical-device
  * node.  Read it and the mode node, and create a vbd.  If the frontend is
@@ -783,7 +783,6 @@ static void backend_changed(struct xenbus_watch *watch,
 	}
 }
 
-
 /*
  * Callback received when the frontend's state changes.
  */
@@ -858,7 +857,6 @@ static void frontend_changed(struct xenbus_device *dev,
 	}
 }
 
-
 /* Once a memory pressure is detected, squeeze free page pools for a while. */
 static unsigned int buffer_squeeze_duration_ms = 10;
 module_param_named(buffer_squeeze_duration_ms,
@@ -881,7 +879,6 @@ static void reclaim_memory(struct xenbus_device *dev)
 
 /* ** Connection ** */
 
-
 /*
  * Write the physical details regarding the block device to the store, and
  * switch to Connected state.
-- 
2.17.1

