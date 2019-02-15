Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A6C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583C8222DD
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 23:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394283AbfBOXAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:00:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53897 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388553AbfBOXAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 18:00:45 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gumT8-0005pQ-0r; Sat, 16 Feb 2019 00:00:30 +0100
Date:   Sat, 16 Feb 2019 00:00:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
In-Reply-To: <alpine.DEB.2.21.1902150053160.1646@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1902152242120.1683@nanos.tec.linutronix.de>
References: <20190214204755.819014197@linutronix.de> <20190214211759.699390983@linutronix.de> <20190214224136.GA18764@ming.t460p> <alpine.DEB.2.21.1902150053160.1646@nanos.tec.linutronix.de>
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

On Fri, 15 Feb 2019, Thomas Gleixner wrote:

> On Fri, 15 Feb 2019, Ming Lei wrote:
> > > +	 * If only one interrupt is available, combine write and read
> > > +	 * queues. If 'write_queues' is set, ensure it leaves room for at
> > > +	 * least one read queue.
> > > +	 */
> > > +	if (nrirqs == 1)
> > > +		nr_read_queues = 0;
> > > +	else if (write_queues >= nrirqs)
> > > +		nr_read_queues = nrirqs - 1;
> > > +	else
> > > +		nr_read_queues = nrirqs - write_queues;
> > > +
> > > +	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > > +	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > > +	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> > > +	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
> > > +	affd->nr_sets = nr_read_queues ? 2 : 1;
> > >  }
> > 
> > .calc_sets is called only if more than .pre_vectors is available,
> > then dev->io_queues[HCTX_TYPE_DEFAULT] may not be set in case of
> > (nvecs == affd->pre_vectors + affd->post_vectors).
> 
> Hmm, good catch. The delta patch below should fix that, but I have to go
> through all the possible cases in pci_alloc_irq_vectors_affinity() once
> more with brain awake.

The existing logic in the driver is somewhat strange. If there is only a
single interrupt available, i.e. no separation of admin and I/O queue, then
dev->io_queues[HCTX_TYPE_DEFAULT] is still set to 1.

Now with the callback scheme (independent of my changes) that breaks in
various ways:

  1) irq_create_affinity_masks() bails out early:

	if (nvecs == affd->pre_vectors + affd->post_vectors)
		return NULL;

     So the callback won't be invoked and the last content of
     dev->io_queues is preserved. By chance this might end up with

	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
	dev->io_queues[HCTX_TYPE_READ] = 0;

    but that does not happen by design.


 2) pci_alloc_irq_vectors_affinity() has the following flow:

    __pci_enable_msix_range()
      for (...) {
            __pci_enable_msix()
      }

    If that fails because MSIX is not supported, then the affinity
    spreading code has not been called yet and neither the callback.
    Now it goes on and tries MSI, which is the same as the above.

    When that fails because MSI is not supported, same situation as above
    and the code tries to allocate the legacy interrupt.

    Now with the initial initialization that case is covered, but not the
    following error case:

      Assume MSIX is enabled, but __pci_enable_msix() fails with -ENOMEM
      after having called irq_create_affinity_masks() and subsequently the
      callback with maxvecs.

      Then pci_alloc_irq_vectors_affinity() will try MSI and fail _BEFORE_
      the callback is invoked.

      The next step is to install the leagcy interrupt, but that does not
      invoke the affinity code and neither the callback.

      At the end dev->io_queues[*] are still initialized with the failed
      attempt of enabling MSIX based on maxvecs.

      Result: inconsistent state ...

I have an idea how to fix that, but that's again a task for brain being
awake. Will take care of that tomorrow morning.

Thanks,

	tglx


    


 


    
