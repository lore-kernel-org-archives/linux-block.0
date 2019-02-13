Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D985EC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE96D222A4
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 21:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbfBMV07 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:26:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfBMV06 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 16:26:58 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gu23K-0005xb-7I; Wed, 13 Feb 2019 22:26:46 +0100
Date:   Wed, 13 Feb 2019 22:26:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 4/5] nvme-pci: avoid irq allocation retrying via
 .calc_sets
In-Reply-To: <20190213151339.GE96272@google.com>
Message-ID: <alpine.DEB.2.21.1902132159230.1659@nanos.tec.linutronix.de>
References: <20190213105041.13537-1-ming.lei@redhat.com> <20190213105041.13537-5-ming.lei@redhat.com> <20190213151339.GE96272@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Feb 2019, Bjorn Helgaas wrote:

> On Wed, Feb 13, 2019 at 06:50:40PM +0800, Ming Lei wrote:
> > Currently pre-caculate each set vectors, and this way requires same
> > 'max_vecs' and 'min_vecs' passed to pci_alloc_irq_vectors_affinity(),
> > then nvme_setup_irqs() has to retry in case of allocation failure.
> 
> s/pre-caculate/precalculate/
> My usual "set vectors" question as on other patches.
> 
> > This usage & interface is a bit awkward because the retry should have
> > been avoided by providing one reasonable 'min_vecs'.
> > 
> > Implement the callback of .calc_sets, so that pci_alloc_irq_vectors_affinity()
> > can calculate each set's vector after IRQ vectors is allocated and
> > before spread IRQ, then NVMe's retry in case of irq allocation failure
> > can be removed.
> 
> s/irq/IRQ/

Let me rephrase that thing as well

  Subject: nvme-pci: Simplify interrupt allocation

  The NVME PCI driver contains a tedious mechanism for interrupt
  allocation, which is necessary to adjust the number and size of interrupt
  sets to the maximum available number of interrupts which depends on the
  underlying PCI capabilities and the available CPU resources.

  It works around the former short comings of the PCI and core interrupt
  allocation mechanims in combination with interrupt sets.

  The PCI interrupt allocation function allows to provide a maximum and a
  minimum number of interrupts to be allocated and tries to allocate as
  many as possible. This worked without driver interaction as long as there
  was only a single set of interrupts to handle.

  With the addition of support for multiple interrupt sets in the generic
  affinity spreading logic, which is invoked from the PCI interrupt
  allocation, the adaptive loop in the PCI interrupt allocation did not
  work for multiple interrupt sets. The reason is that depending on the
  total number of interrupts which the PCI allocation adaptive loop tries
  to allocate in each step, the number and the size of the interrupt sets
  need to be adapted as well. Due to the way the interrupt sets support was
  implemented there was no way for the PCI interrupt allocation code or the
  core affinity spreading mechanism to invoke a driver specific function
  for adapting the interrupt sets configuration.

  As a consequence the driver had to implement another adaptive loop around
  the PCI interrupt allocation function and calling that with maximum and
  minimum interrupts set to the same value. This ensured that the
  allocation either succeeded or immediately failed without any attempt to
  adjust the number of interrupts in the PCI code.

  The core code now allows drivers to provide a callback to recalculate the
  number and the size of interrupt sets during PCI interrupt allocation,
  which in turn allows the PCI interrupt allocation function to be called
  in the same way as with a single set of interrupts. The PCI code handles
  the adaptive loop and the interrupt affinity spreading mechanism invokes
  the driver callback to adapt the interrupt set configuration to the
  current loop value. This replaces the adaptive loop in the driver
  completely.

  Implement the NVME specific callback which adjusts the interrupt sets
  configuration and remove the adaptive allocation loop.

Thanks,

	tglx


