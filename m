Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3725C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9DE222E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfBPRZy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:25:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54730 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbfBPRZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 12:25:54 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gv3ig-0001ia-MY; Sat, 16 Feb 2019 18:25:42 +0100
Message-Id: <20190216171306.403545970@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 Feb 2019 18:13:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: [patch v6 0/7] genirq/affinity: Overhaul the multiple interrupt sets
 support
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the final update to the series with a few corner cases fixes
vs. V5 which can be found here:

   https://lkml.kernel.org/r/20190214204755.819014197@linutronix.de

The series applies against:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

and is also available from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.irq

Changes vs. V5:

  - Change the invocation for the driver callback so it is invoked even
    when there are no interrupts left to spread out. That ensures that the
    driver can adjust to the situation (in case of NVME a single interrupt)

  - Make sure the callback is invoked in the legacy irq fallback case so
    the driver is not in a stale state from a failed MSI[X} allocation
    attempt.

  - Fix the adjustment logic in the NVME driver as pointed out by Ming and
    Marc, plus another corner case I found during testing.

  - Simplify the unmanaged set support

Thanks,

	tglx

8<-------------
 drivers/nvme/host/pci.c         |  117 +++++++++++++---------------------------
 drivers/pci/msi.c               |   39 +++++--------
 drivers/scsi/be2iscsi/be_main.c |    2 
 include/linux/interrupt.h       |   35 ++++++++---
 include/linux/pci.h             |    4 -
 kernel/irq/affinity.c           |  116 ++++++++++++++++++++++++---------------
 6 files changed, 153 insertions(+), 160 deletions(-)


