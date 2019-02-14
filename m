Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEACC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D42920656
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 23:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfBNX4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:56:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNX4E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 18:56:04 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guQrB-0004g2-Ji; Fri, 15 Feb 2019 00:55:53 +0100
Date:   Fri, 15 Feb 2019 00:55:53 +0100 (CET)
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
In-Reply-To: <20190214224136.GA18764@ming.t460p>
Message-ID: <alpine.DEB.2.21.1902150053160.1646@nanos.tec.linutronix.de>
References: <20190214204755.819014197@linutronix.de> <20190214211759.699390983@linutronix.de> <20190214224136.GA18764@ming.t460p>
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

On Fri, 15 Feb 2019, Ming Lei wrote:
> > +	 * If only one interrupt is available, combine write and read
> > +	 * queues. If 'write_queues' is set, ensure it leaves room for at
> > +	 * least one read queue.
> > +	 */
> > +	if (nrirqs == 1)
> > +		nr_read_queues = 0;
> > +	else if (write_queues >= nrirqs)
> > +		nr_read_queues = nrirqs - 1;
> > +	else
> > +		nr_read_queues = nrirqs - write_queues;
> > +
> > +	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > +	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > +	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> > +	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
> > +	affd->nr_sets = nr_read_queues ? 2 : 1;
> >  }
> 
> .calc_sets is called only if more than .pre_vectors is available,
> then dev->io_queues[HCTX_TYPE_DEFAULT] may not be set in case of
> (nvecs == affd->pre_vectors + affd->post_vectors).

Hmm, good catch. The delta patch below should fix that, but I have to go
through all the possible cases in pci_alloc_irq_vectors_affinity() once
more with brain awake.

Thanks,

	tglx

8<---------------------

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2092,6 +2092,10 @@ static int nvme_setup_irqs(struct nvme_d
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
+	/* Initialize for the single interrupt case */
+	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
+	dev->io_queues[HCTX_TYPE_READ] = 0;
+
 	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
