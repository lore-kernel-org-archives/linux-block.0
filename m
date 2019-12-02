Return-Path: <SRS0=iG2v=ZY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF322C432C3
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8320D2084F
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 11:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CQcTSaZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLBLlz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:41:55 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:3526 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfLBLly (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Dec 2019 06:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575286914; x=1606822914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8XvxZ0fNsu10HOeFwxMLW9YLhKZXhrIK9PCbhCy7tY=;
  b=CQcTSaZDEdK2ucoIpNV8mjPj/MkGuMvFTRbENZhUkk1fDhw9LQbtmOMR
   hrVdbQ4M/VyilIsbIxBYWpTfxAM9W1Tujg15PHxwB3baG/Ti1ugsPbdHo
   sZUkf6DClKUaIV8rrgfS/D/OgtLbxR5vG9opHHpo/8yvp1j92Axnw2xxt
   w=;
IronPort-SDR: h8rgTEIu4Hn1eGWLtLSNN3T19Ltbix9FJSB1ccXh7x8ZIZv4dovNIfCqkAO08bnxFRgfN1p+zi
 dyCgPP7V05Eg==
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="2606754"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Dec 2019 11:41:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id CE644A0603;
        Mon,  2 Dec 2019 11:41:40 +0000 (UTC)
Received: from EX13D32EUB002.ant.amazon.com (10.43.166.114) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:41:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D32EUB002.ant.amazon.com (10.43.166.114) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:41:39 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Dec 2019 11:41:36 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 2/2] xen-blkback: allow module to be cleanly unloaded
Date:   Mon, 2 Dec 2019 11:41:17 +0000
Message-ID: <20191202114117.1264-3-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191202114117.1264-1-pdurrant@amazon.com>
References: <20191202114117.1264-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a module_exit() to perform the necessary clean-up.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: "Roger Pau Monné" <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
 drivers/block/xen-blkback/blkback.c |  8 ++++++++
 drivers/block/xen-blkback/common.h  |  3 +++
 drivers/block/xen-blkback/xenbus.c  | 11 +++++++++++
 3 files changed, 22 insertions(+)

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
index b90dbcd99c03..e8c5c54e1d26 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -333,6 +333,12 @@ int __init xen_blkif_interface_init(void)
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
@@ -1122,3 +1128,8 @@ int xen_blkif_xenbus_init(void)
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

