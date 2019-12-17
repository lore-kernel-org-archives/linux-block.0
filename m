Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C3C2D0BF
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E7C2467B
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Uibd2SRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfLQQJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:09:11 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:62168 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfLQQJK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576598950; x=1608134950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NVFC9qV2eoj93ZmYEaKEr4kRRmxcwtF4qCgUA1XgM8c=;
  b=Uibd2SRsT0lXIFVPheFrKDiW/MQjyLaEo7avuliqBE2gjL2aAGIbO9Mq
   gWZvAypsYVH6Yean+rh34UFUMQ7/k50Glh493ndI5rg6rbVtnup48LcJ9
   0JoTfT/d+e4n9HRGC3KSSPjb18N1FmgQAZjdzT1TUsoUeLT6wDZ3sj1Gn
   0=;
IronPort-SDR: aRO1wLh9GqAmNNqsU3pay3V9ZmFMs4xiqfcPlG864PHeqR5P2dbee9CuQQFkIOZkbpvnzYiCR+
 QfjSy1l0Ljog==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="9472487"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 17 Dec 2019 16:09:08 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 7C933A21FC;
        Tue, 17 Dec 2019 16:09:06 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Dec 2019 16:09:05 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:09:00 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 4/6] xen/blkback: Protect 'reclaim_memory()' with 'reclaim_lock'
Date:   Tue, 17 Dec 2019 17:07:46 +0100
Message-ID: <20191217160748.693-5-sjpark@amazon.com>
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

The 'reclaim_memory()' callback of blkback could race with
'xen_blkbk_probe()' and 'xen_blkbk_remove()'.  In the case, incompletely
linked 'backend_info' and 'blkif' might be exposed to the callback, thus
result in bad results including NULL dereference.  This commit fixes the
problem by applying the 'reclaim_lock' protection to those.

Note that this commit is separated for review purpose only.  As the
previous commit might result in race condition and might make bisect
confuse, please squash this commit into previous commit if possible.

Signed-off-by: SeongJae Park <sjpark@amazon.de>

---
 drivers/block/xen-blkback/xenbus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 4f6ea4feca79..20045827a391 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -492,6 +492,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 static int xen_blkbk_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
+	unsigned long flags;
 
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
 
@@ -504,6 +505,7 @@ static int xen_blkbk_remove(struct xenbus_device *dev)
 		be->backend_watch.node = NULL;
 	}
 
+	spin_lock_irqsave(&dev->reclaim_lock, flags);
 	dev_set_drvdata(&dev->dev, NULL);
 
 	if (be->blkif) {
@@ -512,6 +514,7 @@ static int xen_blkbk_remove(struct xenbus_device *dev)
 		/* Put the reference we set in xen_blkif_alloc(). */
 		xen_blkif_put(be->blkif);
 	}
+	spin_unlock_irqrestore(&dev->reclaim_lock, flags);
 
 	return 0;
 }
@@ -597,6 +600,7 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	int err;
 	struct backend_info *be = kzalloc(sizeof(struct backend_info),
 					  GFP_KERNEL);
+	unsigned long flags;
 
 	/* match the pr_debug in xen_blkbk_remove */
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
@@ -607,6 +611,7 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 		return -ENOMEM;
 	}
 	be->dev = dev;
+	spin_lock_irqsave(&dev->reclaim_lock, flags);
 	dev_set_drvdata(&dev->dev, be);
 
 	be->blkif = xen_blkif_alloc(dev->otherend_id);
@@ -614,8 +619,10 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 		err = PTR_ERR(be->blkif);
 		be->blkif = NULL;
 		xenbus_dev_fatal(dev, err, "creating block interface");
+		spin_unlock_irqrestore(&dev->reclaim_lock, flags);
 		goto fail;
 	}
+	spin_unlock_irqrestore(&dev->reclaim_lock, flags);
 
 	err = xenbus_printf(XBT_NIL, dev->nodename,
 			    "feature-max-indirect-segments", "%u",
@@ -838,6 +845,10 @@ static void reclaim_memory(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
 
+	/* Device is registered but not probed yet */
+	if (!be)
+		return;
+
 	be->blkif->buffer_squeeze_end = jiffies +
 		msecs_to_jiffies(buffer_squeeze_duration_ms);
 }
-- 
2.17.1

