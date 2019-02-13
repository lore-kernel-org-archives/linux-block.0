Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E7C282CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1FE21901
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbfBMKvI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390325AbfBMKvG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 05:51:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B6A386675;
        Wed, 13 Feb 2019 10:51:06 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F3660466;
        Wed, 13 Feb 2019 10:51:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/5] genirq/affinity: store irq set vectors in 'struct irq_affinity'
Date:   Wed, 13 Feb 2019 18:50:38 +0800
Message-Id: <20190213105041.13537-3-ming.lei@redhat.com>
In-Reply-To: <20190213105041.13537-1-ming.lei@redhat.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 13 Feb 2019 10:51:06 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the array of irq set vectors is provided by driver.

irq_create_affinity_masks() can be simplied a bit by treating the
non-irq-set case as single irq set.

So move this array into 'struct irq_affinity', and pre-define the max
set number as 4, which should be enough for normal cases.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c   |  5 ++---
 include/linux/interrupt.h |  6 ++++--
 kernel/irq/affinity.c     | 18 +++++++++++-------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 022ea1ee63f8..0086bdf80ea1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2081,12 +2081,11 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int irq_sets[2];
 	struct irq_affinity affd = {
 		.pre_vectors = 1,
-		.nr_sets = ARRAY_SIZE(irq_sets),
-		.sets = irq_sets,
+		.nr_sets = 2,
 	};
+	int *irq_sets = affd.set_vectors;
 	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1ed1014c9684..a20150627a32 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -259,6 +259,8 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+#define	IRQ_MAX_SETS  4
+
 /**
  * struct irq_affinity - Description for automatic irq affinity assignements
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
@@ -266,13 +268,13 @@ struct irq_affinity_notify {
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
- * @sets:		Number of affinitized sets
+ * @set_vectors:	Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
-	int	*sets;
+	int	set_vectors[IRQ_MAX_SETS];
 };
 
 /**
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 9200d3b26f7d..b868b9d3df7f 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -244,7 +244,7 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
 	struct irq_affinity_desc *masks = NULL;
-	int i, nr_sets;
+	int i;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -253,6 +253,9 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
+	if (affd->nr_sets > IRQ_MAX_SETS)
+		return NULL;
+
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		return NULL;
@@ -264,12 +267,13 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
-	nr_sets = affd->nr_sets;
-	if (!nr_sets)
-		nr_sets = 1;
+	if (!affd->nr_sets) {
+		affd->nr_sets = 1;
+		affd->set_vectors[0] = affvecs;
+	}
 
-	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		int this_vecs = affd->set_vectors[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -316,7 +320,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 		int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->sets[i];
+			set_vecs += affd->set_vectors[i];
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);
-- 
2.9.5

