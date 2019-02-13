Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F2C0044B
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68972222C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 20:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390598AbfBMU4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:56:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47672 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbfBMU4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 15:56:52 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gu1a8-0005T4-Qm; Wed, 13 Feb 2019 21:56:37 +0100
Date:   Wed, 13 Feb 2019 21:56:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <20190213150407.GB96272@google.com>
Message-ID: <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
References: <20190213105041.13537-1-ming.lei@redhat.com> <20190213105041.13537-2-ming.lei@redhat.com> <20190213150407.GB96272@google.com>
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

> On Wed, Feb 13, 2019 at 06:50:37PM +0800, Ming Lei wrote:
> > Currently all parameters in 'affd' are read-only, so 'affd' is marked
> > as const in both pci_alloc_irq_vectors_affinity() and irq_create_affinity_masks().
> 
> s/all parameters in 'affd'/the contents of '*affd'/
> 
> > We have to ask driver to re-caculate set vectors after the whole IRQ
> > vectors are allocated later, and the result needs to be stored in 'affd'.
> > Also both the two interfaces are core APIs, which should be trusted.
> 
> s/re-caculate/recalculate/
> s/stored in 'affd'/stored in '*affd'/
> s/both the two/both/
> 
> This is a little confusing because you're talking about both "IRQ
> vectors" and these other "set vectors", which I think are different
> things.  I assume the "set vectors" are cpumasks showing the affinity
> of the IRQ vectors with some CPUs?

I think we should drop the whole vector wording completely.

The driver does not care about vectors, it only cares about a block of
interrupt numbers. These numbers are kernel managed and the interrupts just
happen to have a CPU vector assigned at some point. Depending on the CPU
architecture the underlying mechanism might not even be named vector.

> AFAICT, *this* patch doesn't add anything that writes to *affd.  I
> think the removal of "const" should be in the same patch that makes
> the removal necessary.

So this should be:

   The interrupt affinity spreading mechanism supports to spread out
   affinities for one or more interrupt sets. A interrupt set contains one
   or more interrupts. Each set is mapped to a specific functionality of a
   device, e.g. general I/O queues and read I/O queus of multiqueue block
   devices.

   The number of interrupts per set is defined by the driver. It depends on
   the total number of available interrupts for the device, which is
   determined by the PCI capabilites and the availability of underlying CPU
   resources, and the number of queues which the device provides and the
   driver wants to instantiate.

   The driver passes initial configuration for the interrupt allocation via
   a pointer to struct affinity_desc.

   Right now the allocation mechanism is complex as it requires to have a
   loop in the driver to determine the maximum number of interrupts which
   are provided by the PCI capabilities and the underlying CPU resources.
   This loop would have to be replicated in every driver which wants to
   utilize this mechanism. That's unwanted code duplication and error
   prone.

   In order to move this into generic facilities it is required to have a
   mechanism, which allows the recalculation of the interrupt sets and
   their size, in the core code. As the core code does not have any
   knowledge about the underlying device, a driver specific callback will
   be added to struct affinity_desc, which will be invoked by the core
   code. The callback will get the number of available interupts as an
   argument, so the driver can calculate the corresponding number and size
   of interrupt sets.

   To support this, two modifications for the handling of struct
   affinity_desc are required:

   1) The (optional) interrupt sets size information is contained in a
      separate array of integers and struct affinity_desc contains a
      pointer to it.

      This is cumbersome and as the maximum number of interrupt sets is
      small, there is no reason to have separate storage. Moving the size
      array into struct affinity_desc avoids indirections makes the code
      simpler.

   2) At the moment the struct affinity_desc pointer which is handed in from
      the driver and passed through to several core functions is marked
      'const'.

      With the upcoming callback to recalculate the number and size of
      interrupt sets, it's necessary to remove the 'const'
      qualifier. Otherwise the callback would not be able to update the
      data.

   Move the set size array into struct affinity_desc as a first preparatory
   step. The removal of the 'const' qualifier will be done when adding the
   callback.

IOW, The first patch moves the set array into the struct itself.

The second patch introduces the callback and removes the 'const'
qualifier. I wouldn't mind to have the same changelog duplicated (+/- the
last two paragraphs which need some update of course).

Thanks,

	tglx
