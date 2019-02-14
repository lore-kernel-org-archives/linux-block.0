Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D659DC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FC920675
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfBNMX5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:23:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfBNMX5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 07:23:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8018A15554;
        Thu, 14 Feb 2019 12:23:56 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8D1611A1;
        Thu, 14 Feb 2019 12:23:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/4] genirq/affinity: add .calc_sets for improving IRQ allocation & spread
Date:   Thu, 14 Feb 2019 20:23:43 +0800
Message-Id: <20190214122347.17372-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 14 Feb 2019 12:23:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

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
before spread IRQ vectors.

V4:
	- re-writen changelogs by Thomas Gleixner
	- merge patch of removing 'const' into the patch
	for adding new callback
 
V3:
	- don't mark 'affd' as const in related functions
	- add sanity check on affd->nr_sets
	- remove the local variable of 'nr_sets' in irq_create_affinity_masks
	- set .nr_sets as 2 in nvme
	- update comment in msi.c

V2:
	- add .calc_sets instead of .setup_affinity() which is easy to
	be abused by drivers

Ming Lei (4):
  genirq/affinity: store interrupt sets size in 'struct irq_affinity'
  genirq/affinity: add new callback for caculating interrupt sets size
  nvme-pci: Simplify interrupt allocation
  PCI: Document .calc_sets as required in case of multiple interrupt
    sets

 drivers/nvme/host/pci.c   | 63 ++++++++++++-----------------------------------
 drivers/pci/msi.c         | 32 +++++++++++++-----------
 include/linux/interrupt.h | 13 +++++++---
 include/linux/pci.h       |  4 +--
 kernel/irq/affinity.c     | 26 ++++++++++++-------
 5 files changed, 62 insertions(+), 76 deletions(-)

-- 
2.9.5

