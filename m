Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F3DC388F9
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015B921D24
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 17:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816985AbgJ0RLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:11:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:29276 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1816978AbgJ0RLe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 13:11:34 -0400
IronPort-SDR: H2yCnO/WDnb/xvPtqh8D1eTEvduEDVWXefZRd8PDrRZYzmcl5kDtexumzJ0g1AgVztasXaL/yV
 ivT5eXIHuEZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="168222119"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="168222119"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:11:33 -0700
IronPort-SDR: 3X0lBfBaTwhsYL+1XlNjFmW11F4zyn72edL6JVuLsl6W1Y9QHgirTDl5DRZVDH/ZQZzuBb1ujP
 JCx5RvDgKobw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="303830364"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2020 10:11:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 900E0179; Tue, 27 Oct 2020 19:11:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] xsysace: use platform_get_resource() and platform_get_irq_optional()
Date:   Tue, 27 Oct 2020 19:11:30 +0200
Message-Id: <20201027171130.56998-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use platform_get_resource() to fetch the memory resource and
platform_get_irq_optional() to get optional IRQ instead of
open-coded variants.

IRQ is not supposed to be changed at runtime, so there is
no functional change in ace_fsm_yieldirq().

On the other hand we now take first resources instead of last ones
to proceed. I can't imagine how broken should be firmware to have
a garbage in the first resource slots. But if it the case, it needs
to be documented.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/xsysace.c | 49 ++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 8d581c7536fb..eb8ef65778c3 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -443,22 +443,27 @@ static void ace_fix_driveid(u16 *id)
 #define ACE_FSM_NUM_STATES              11
 
 /* Set flag to exit FSM loop and reschedule tasklet */
-static inline void ace_fsm_yield(struct ace_device *ace)
+static inline void ace_fsm_yieldpoll(struct ace_device *ace)
 {
-	dev_dbg(ace->dev, "ace_fsm_yield()\n");
 	tasklet_schedule(&ace->fsm_tasklet);
 	ace->fsm_continue_flag = 0;
 }
 
+static inline void ace_fsm_yield(struct ace_device *ace)
+{
+	dev_dbg(ace->dev, "%s()\n", __func__);
+	ace_fsm_yieldpoll(ace);
+}
+
 /* Set flag to exit FSM loop and wait for IRQ to reschedule tasklet */
 static inline void ace_fsm_yieldirq(struct ace_device *ace)
 {
 	dev_dbg(ace->dev, "ace_fsm_yieldirq()\n");
 
-	if (!ace->irq)
-		/* No IRQ assigned, so need to poll */
-		tasklet_schedule(&ace->fsm_tasklet);
-	ace->fsm_continue_flag = 0;
+	if (ace->irq > 0)
+		ace->fsm_continue_flag = 0;
+	else
+		ace_fsm_yieldpoll(ace);
 }
 
 static bool ace_has_next_request(struct request_queue *q)
@@ -1053,12 +1058,12 @@ static int ace_setup(struct ace_device *ace)
 		ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ);
 
 	/* Now we can hook up the irq handler */
-	if (ace->irq) {
+	if (ace->irq > 0) {
 		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
 		if (rc) {
 			/* Failure - fall back to polled mode */
 			dev_err(ace->dev, "request_irq failed\n");
-			ace->irq = 0;
+			ace->irq = rc;
 		}
 	}
 
@@ -1110,7 +1115,7 @@ static void ace_teardown(struct ace_device *ace)
 
 	tasklet_kill(&ace->fsm_tasklet);
 
-	if (ace->irq)
+	if (ace->irq > 0)
 		free_irq(ace->irq, ace);
 
 	iounmap(ace->baseaddr);
@@ -1123,11 +1128,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
 	int rc;
 	dev_dbg(dev, "ace_alloc(%p)\n", dev);
 
-	if (!physaddr) {
-		rc = -ENODEV;
-		goto err_noreg;
-	}
-
 	/* Allocate and initialize the ace device structure */
 	ace = kzalloc(sizeof(struct ace_device), GFP_KERNEL);
 	if (!ace) {
@@ -1153,7 +1153,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
 	dev_set_drvdata(dev, NULL);
 	kfree(ace);
 err_alloc:
-err_noreg:
 	dev_err(dev, "could not initialize device, err=%i\n", rc);
 	return rc;
 }
@@ -1176,10 +1175,11 @@ static void ace_free(struct device *dev)
 
 static int ace_probe(struct platform_device *dev)
 {
-	resource_size_t physaddr = 0;
 	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
+	resource_size_t physaddr;
+	struct resource *res;
 	u32 id = dev->id;
-	int irq = 0;
+	int irq;
 	int i;
 
 	dev_dbg(&dev->dev, "ace_probe(%p)\n", dev);
@@ -1190,12 +1190,15 @@ static int ace_probe(struct platform_device *dev)
 	if (of_find_property(dev->dev.of_node, "8-bit", NULL))
 		bus_width = ACE_BUS_WIDTH_8;
 
-	for (i = 0; i < dev->num_resources; i++) {
-		if (dev->resource[i].flags & IORESOURCE_MEM)
-			physaddr = dev->resource[i].start;
-		if (dev->resource[i].flags & IORESOURCE_IRQ)
-			irq = dev->resource[i].start;
-	}
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	physaddr = res->start;
+	if (!physaddr)
+		return -ENODEV;
+
+	irq = platform_get_irq_optional(dev, 0);
 
 	/* Call the bus-independent setup code */
 	return ace_alloc(&dev->dev, id, physaddr, irq, bus_width);
-- 
2.28.0

