Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA18C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE732084A
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAYJyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:54:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfAYJyE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:54:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E81787F6B0;
        Fri, 25 Jan 2019 09:54:03 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A7D160F93;
        Fri, 25 Jan 2019 09:53:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] genirq/affinity: introduce .setup_affinity to support allocating interrupt sets
Date:   Fri, 25 Jan 2019 17:53:42 +0800
Message-Id: <20190125095347.17950-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 25 Jan 2019 09:54:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The current support for allocating interrupt sets requires that same 'max_vec'
and 'min_vec' is passed to pci_alloc_irq_vectors_affinity(), then driver has to
try to allocate again and again until it succeeds.

This patch introduces .setup_affinity callback, and we can use it to
re-caculate interrupt sets and build affinity for each set after
irq vectors are allocated.

Turns out both genirq/affinity and nvme code get simplified a lot.

Please review and comment!

Ming Lei (5):
  genirq/affinity: move allocation of 'node_to_cpumask' to
    irq_build_affinity_masks
  genirq/affinity: allow driver to setup managed IRQ's affinity
  genirq/affinity: introduce irq_build_affinity()
  nvme-pci: simplify nvme_setup_irqs() via .setup_affinity callback
  genirq/affinity: remove support for allocating interrupt sets

 drivers/nvme/host/pci.c   |  97 +++++++++++++++++++++--------------------
 drivers/pci/msi.c         |  14 ------
 include/linux/interrupt.h |  42 ++++++++++++------
 kernel/irq/affinity.c     | 108 ++++++++++++++++++++++++----------------------
 4 files changed, 133 insertions(+), 128 deletions(-)

-- 
2.9.5

