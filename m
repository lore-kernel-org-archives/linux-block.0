Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CFBC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 09:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188152070D
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfBOJxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:53:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52191 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfBOJxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 04:53:07 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guaAu-0007vQ-4W; Fri, 15 Feb 2019 10:52:52 +0100
Date:   Fri, 15 Feb 2019 10:52:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
In-Reply-To: <868syhs8tn.wl-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1902151051470.1646@nanos.tec.linutronix.de>
References: <20190214204755.819014197@linutronix.de> <20190214211759.699390983@linutronix.de> <868syhs8tn.wl-marc.zyngier@arm.com>
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

On Fri, 15 Feb 2019, Marc Zyngier wrote:
> On Thu, 14 Feb 2019 20:47:59 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >  drivers/nvme/host/pci.c |  108 ++++++++++++------------------------------------
> >  1 file changed, 28 insertions(+), 80 deletions(-)
> > 
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2041,41 +2041,32 @@ static int nvme_setup_host_mem(struct nv
> >  	return ret;
> >  }
> >  
> > -/* irq_queues covers admin queue */
> > -static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
> > +/*
> > + * nirqs is the number of interrupts available for write and read
> > + * queues. The core already reserved an interrupt for the admin queue.
> > + */
> > +static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
> >  {
> > -	unsigned int this_w_queues = write_queues;
> > -
> > -	WARN_ON(!irq_queues);
> > -
> > -	/*
> > -	 * Setup read/write queue split, assign admin queue one independent
> > -	 * irq vector if irq_queues is > 1.
> > -	 */
> > -	if (irq_queues <= 2) {
> > -		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
> > -		dev->io_queues[HCTX_TYPE_READ] = 0;
> > -		return;
> > -	}
> > +	struct nvme_dev *dev = affd->priv;
> > +	unsigned int nr_read_queues;
> >  
> >  	/*
> > -	 * If 'write_queues' is set, ensure it leaves room for at least
> > -	 * one read queue and one admin queue
> > -	 */
> > -	if (this_w_queues >= irq_queues)
> > -		this_w_queues = irq_queues - 2;
> > -
> > -	/*
> > -	 * If 'write_queues' is set to zero, reads and writes will share
> > -	 * a queue set.
> > -	 */
> > -	if (!this_w_queues) {
> > -		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues - 1;
> > -		dev->io_queues[HCTX_TYPE_READ] = 0;
> > -	} else {
> > -		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> > -		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues - 1;
> > -	}
> > +	 * If only one interrupt is available, combine write and read
> > +	 * queues. If 'write_queues' is set, ensure it leaves room for at
> > +	 * least one read queue.
> 
> [Full disclaimer: I only have had two coffees this morning, and it is
> only at the fourth that my brain is able to kick in...]
> 
> I don't know much about NVME, but I feel like there is a small
> disconnect between the code and the above comment, which says "leave
> room for at least one read queue"...
> 
> > +	 */
> > +	if (nrirqs == 1)
> > +		nr_read_queues = 0;
> > +	else if (write_queues >= nrirqs)
> > +		nr_read_queues = nrirqs - 1;
> 
> ... while this seem to ensure that we carve out one write queue out of
> the irq set. It looks like a departure from the original code, which
> would set nr_read_queues to 1 in that particular case.

Bah. right you are.

