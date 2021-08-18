Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8365C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959176108D
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhHROpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239565AbhHROpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629297888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuvcYtFumwjyV+wo2LskpKtpPys22iiOt3Pdd+iWq6k=;
        b=Sx2uvthDnCZxsTlNyiEoqowXdzv7/WnSxve7qaQM94zy+SZwmbw4coYUUd0oVCx3ZIGXcx
        RUNoO9cP1ocA0DoLmpPGwz4/1TexzWAWpzVxuidnOD87u9P+nfSvweoJyjw40rqHshTh9v
        qwfPm/SWs3nIpid0G5XcuAmWFowrTmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Z-EzM46gMiKGbQidRJIH3g-1; Wed, 18 Aug 2021 10:44:47 -0400
X-MC-Unique: Z-EzM46gMiKGbQidRJIH3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0B2094DC8;
        Wed, 18 Aug 2021 14:44:45 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35B1F60BF4;
        Wed, 18 Aug 2021 14:44:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 1/3] genirq: add device_has_managed_msi_irq
Date:   Wed, 18 Aug 2021 22:44:26 +0800
Message-Id: <20210818144428.896216-2-ming.lei@redhat.com>
In-Reply-To: <20210818144428.896216-1-ming.lei@redhat.com>
References: <20210818144428.896216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Tested-by: Wen Xiong <wenxiong@us.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/msi.h |  5 +++++
 kernel/irq/msi.c    | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index a20dc66b9946..b4511c606072 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -59,10 +59,15 @@ struct platform_msi_priv_data;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
+bool device_has_managed_msi_irq(struct device *dev);
 #else
 static inline void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
 }
+static inline bool device_has_managed_msi_irq(struct device *dev)
+{
+	return false;
+}
 #endif
 
 typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 00f89d5bd6f6..167bc1d8bf4a 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -71,6 +71,24 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
+/**
+ * device_has_managed_msi_irq - Query if device has managed irq entry
+ * @dev:	Pointer to the device for which we want to query
+ *
+ * Return true if there is managed irq vector allocated on this device
+ */
+bool device_has_managed_msi_irq(struct device *dev)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, dev) {
+		if (desc->affinity && desc->affinity->is_managed)
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(device_has_managed_msi_irq);
+
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
-- 
2.31.1

