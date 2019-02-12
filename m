Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D3CC4151A
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2669214DA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfBLNFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:05:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfBLNFW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 08:05:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCF7BA7875;
        Tue, 12 Feb 2019 13:05:21 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55991101E845;
        Tue, 12 Feb 2019 13:05:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/4] genirq/affinity: Document .calc_sets as required in case of multiple sets
Date:   Tue, 12 Feb 2019 21:04:39 +0800
Message-Id: <20190212130439.14501-5-ming.lei@redhat.com>
In-Reply-To: <20190212130439.14501-1-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 12 Feb 2019 13:05:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now NVMe has implemented the .calc_sets callback for caculating each
set's vectors.

For other cases of multiple irq sets, it isn't a good way to pre-caculate
each set's vectors before allocating IRQ vectors because NVMe's same issue
exists too.

Document .calc_sets as required explicitly for multiple sets.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/pci/msi.c         | 4 ++--
 include/linux/interrupt.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4c0b47867258..9f91fa713141 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1039,7 +1039,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	 * If the caller is passing in sets, we can't support a range of
 	 * vectors. The caller needs to handle that.
 	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
+	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(dev->msi_enabled))
@@ -1097,7 +1097,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	 * If the caller is passing in sets, we can't support a range of
 	 * supported vectors. The caller needs to handle that.
 	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
+	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(dev->msix_enabled))
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 7a27f6ba1f2f..a053f7fb0ff1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -269,7 +269,8 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @set_vectors:	Number of affinitized sets
- * @calc_sets:		Callback for caculating set vectors
+ * @calc_sets:		Callback for caculating set vectors, required for
+ * 			multiple irq sets.
  * @priv:		Private data of @calc_sets
  */
 struct irq_affinity {
-- 
2.9.5

