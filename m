Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB87C432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE19720833
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 11:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AdSiDDee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfK2Lbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:31:44 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:5689 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfK2Lbo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 06:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575027104; x=1606563104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mMhOHfzPWPTlT1F2YNHMoR0lHgdtufqIO3c7y6opQtU=;
  b=AdSiDDeeX1p0uLSk14CA3pK6BmTY3b0vpuEM5f2upXnFTCE0vmW8ja2H
   bYPk1RZ6d7bWXtHlTmKtGZwe5dAeK7QcXi8/w02p8UxqDUzG/XUq4WLl9
   sWO3v46/kaxrhN3jcDg2wb1h/ssoFLpjydD3DTdb48pohFNejoSSX5izT
   Y=;
IronPort-SDR: tCTMha4UmWWdKldyDrvAlDYY68CEDgb6gKIYIsC2/pdiXNN710kvSXEsC3MIFWRdVM2fK2ap+j
 uQsRzkoyT6Qg==
X-IronPort-AV: E=Sophos;i="5.69,257,1571702400"; 
   d="scan'208";a="6338463"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 29 Nov 2019 11:31:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id CEE4EA1803;
        Fri, 29 Nov 2019 11:31:38 +0000 (UTC)
Received: from EX13D32EUB003.ant.amazon.com (10.43.166.165) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 11:31:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D32EUB003.ant.amazon.com (10.43.166.165) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 11:31:37 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 29 Nov 2019 11:31:34 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] xen-blkback: allow module to be cleanly unloaded
Date:   Fri, 29 Nov 2019 11:31:31 +0000
Message-ID: <20191129113131.1954-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a module_exit() to perform the necessary clean-up. Also add
__module_get() and module_put() calls into xen_blkif_alloc() and
xen_blkif_free() respectively to make sure an in-use module cannot be
unloaded.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/xen-blkback/blkback.c |  8 ++++++++
 drivers/block/xen-blkback/common.h  |  3 +++
 drivers/block/xen-blkback/xenbus.c  | 15 +++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..e562a7e20c3c 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1504,5 +1504,13 @@ static int __init xen_blkif_init(void)
 
 module_init(xen_blkif_init);
 
+static void __exit xen_blkif_fini(void)
+{
+	xen_blkif_xenbus_fini();
+	xen_blkif_interface_fini();
+}
+
+module_exit(xen_blkif_fini);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("xen-backend:vbd");
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..49132b0adbbe 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -375,9 +375,12 @@ struct phys_req {
 	struct block_device	*bdev;
 	blkif_sector_t		sector_number;
 };
+
 int xen_blkif_interface_init(void);
+void xen_blkif_interface_fini(void);
 
 int xen_blkif_xenbus_init(void);
+void xen_blkif_xenbus_fini(void);
 
 irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
 int xen_blkif_schedule(void *arg);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b90dbcd99c03..f948584fcf66 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -173,6 +173,8 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 	init_completion(&blkif->drain_complete);
 	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
 
+	__module_get(THIS_MODULE);
+
 	return blkif;
 }
 
@@ -320,6 +322,8 @@ static void xen_blkif_free(struct xen_blkif *blkif)
 
 	/* Make sure everything is drained before shutting down */
 	kmem_cache_free(xen_blkif_cachep, blkif);
+
+	module_put(THIS_MODULE);
 }
 
 int __init xen_blkif_interface_init(void)
@@ -333,6 +337,12 @@ int __init xen_blkif_interface_init(void)
 	return 0;
 }
 
+void xen_blkif_interface_fini(void)
+{
+	kmem_cache_destroy(xen_blkif_cachep);
+	xen_blkif_cachep = NULL;
+}
+
 /*
  *  sysfs interface for VBD I/O requests
  */
@@ -1122,3 +1132,8 @@ int xen_blkif_xenbus_init(void)
 {
 	return xenbus_register_backend(&xen_blkbk_driver);
 }
+
+void xen_blkif_xenbus_fini(void)
+{
+	xenbus_unregister_driver(&xen_blkbk_driver);
+}
-- 
2.20.1

