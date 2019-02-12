Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C7C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5170D214DA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfBLNFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:05:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfBLNFG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 08:05:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98A32C0524E1;
        Tue, 12 Feb 2019 13:05:05 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC1105D9D1;
        Tue, 12 Feb 2019 13:05:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/4] genirq/affinity: add new callback for caculating set vectors
Date:   Tue, 12 Feb 2019 21:04:37 +0800
Message-Id: <20190212130439.14501-3-ming.lei@redhat.com>
In-Reply-To: <20190212130439.14501-1-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 12 Feb 2019 13:05:05 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently pre-caculated set vectors are provided by driver for
allocating & spread vectors. This way only works when drivers passes
same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
also requires driver to retry the allocating & spread.

As Bjorn and Keith mentioned, the current usage & interface for irq sets
is a bit awkward because the retrying should have been avoided by providing
one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
'max_vecs', number of the allocated vectors is unknown before calling
pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
pre-caculated.

Add a new callback of .calc_sets into 'struct irq_affinity' so that
driver can caculate set vectors after IRQ vector is allocated and
before spread IRQ vectors. Add 'priv' so that driver may retrieve
its private data via the 'struct irq_affinity'.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/interrupt.h |  4 ++++
 kernel/irq/affinity.c     | 13 +++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a20150627a32..7a27f6ba1f2f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -269,12 +269,16 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @set_vectors:	Number of affinitized sets
+ * @calc_sets:		Callback for caculating set vectors
+ * @priv:		Private data of @calc_sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
 	int	set_vectors[IRQ_MAX_SETS];
+	void	(*calc_sets)(struct irq_affinity *, int nvecs);
+	void	*priv;
 };
 
 /**
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index a97b7c33d2db..34abba63df4d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -264,11 +264,14 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
-	nr_sets = affd->nr_sets;
-	if (!nr_sets) {
+	if (affd->calc_sets) {
+		affd->calc_sets(affd, nvecs);
+		nr_sets = affd->nr_sets;
+	} else if (!affd->nr_sets) {
 		nr_sets = 1;
 		affd->set_vectors[0] = affvecs;
-	}
+	} else
+		nr_sets = affd->nr_sets;
 
 	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
 		int this_vecs = affd->set_vectors[i];
@@ -314,7 +317,9 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 	if (resv > minvec)
 		return 0;
 
-	if (affd->nr_sets) {
+	if (affd->calc_sets) {
+		set_vecs = vecs;
+	} else if (affd->nr_sets) {
 		int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-- 
2.9.5

