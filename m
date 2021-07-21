Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326FC636C9
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09CD6121E
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 09:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhGUIqO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236985AbhGUIhP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 04:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626859068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnQDxgpEgVhg0nj64vL8j+I6eBxUi23YSSf+M0pVv20=;
        b=EPB8NxuGpsIqxrEUgkMxTDBTSRBnQBvaf4Z6Idqs7/8Vle9iaT8r5DolHaDBDGbrQO5gLd
        hca2d4jrOuB1ilwZDw7IAhkNXMOWQXX9vmIZonRFF0RatrCNnr1KV/8H8SyuYOCsC58Raw
        Zt4/uj+kbH0/K1yN50/0DQVrz1wlIy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-UV5ahLSMOuWrr8u8JwDHcg-1; Wed, 21 Jul 2021 05:17:46 -0400
X-MC-Unique: UV5ahLSMOuWrr8u8JwDHcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C435C1084F56;
        Wed, 21 Jul 2021 09:17:44 +0000 (UTC)
Received: from localhost (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCDCE5D740;
        Wed, 21 Jul 2021 09:17:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 1/3] driver core: add device_has_managed_msi_irq
Date:   Wed, 21 Jul 2021 17:17:21 +0800
Message-Id: <20210721091723.1152456-2-ming.lei@redhat.com>
In-Reply-To: <20210721091723.1152456-1-ming.lei@redhat.com>
References: <20210721091723.1152456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

irq vector allocation with managed affinity may be used by driver, and
blk-mq needs this info for draining queue because genirq core will shutdown
managed irq when all CPUs in the affinity mask are offline.

The info of using managed irq is often produced by drivers, and it is
consumed by blk-mq, so different subsystems are involved in this info flow.

Address this issue by adding one helper of device_has_managed_msi_irq()
which is suggested by John Garry.

Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/base/core.c    | 15 +++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cadcade65825..41daf9fabdfb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -29,6 +29,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
+#include <linux/msi.h> /* for device_has_managed_irq */
 
 #include "base.h"
 #include "power/power.h"
@@ -4797,3 +4798,17 @@ int device_match_any(struct device *dev, const void *unused)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(device_match_any);
+
+bool device_has_managed_msi_irq(struct device *dev)
+{
+	struct msi_desc *desc;
+
+	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ)) {
+		for_each_msi_entry(desc, dev) {
+			if (desc->affinity && desc->affinity->is_managed)
+				return true;
+		}
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(device_has_managed_msi_irq);
diff --git a/include/linux/device.h b/include/linux/device.h
index 59940f1744c1..b1255524ce8b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -981,4 +981,6 @@ extern long sysfs_deprecated;
 #define sysfs_deprecated 0
 #endif
 
+bool device_has_managed_msi_irq(struct device *dev);
+
 #endif /* _DEVICE_H_ */
-- 
2.31.1

