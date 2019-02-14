Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4765C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB1621900
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbfBNM7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:59:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49526 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388917AbfBNM7l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 07:59:41 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guGbu-0006Ab-Q1; Thu, 14 Feb 2019 13:59:26 +0100
Date:   Thu, 14 Feb 2019 13:59:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 3/4] nvme-pci: Simplify interrupt allocation
In-Reply-To: <20190214122347.17372-4-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141358130.1561@nanos.tec.linutronix.de>
References: <20190214122347.17372-1-ming.lei@redhat.com> <20190214122347.17372-4-ming.lei@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Feb 2019, Ming Lei wrote:
> +static void nvme_calc_irq_sets(struct irq_affinity *affd, int nvecs)
> +{
> +	struct nvme_dev *dev = affd->priv;
> +
> +	nvme_calc_io_queues(dev, nvecs);
> +
> +	affd->set_size[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
> +	affd->set_size[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
> +	affd->nr_sets = 2;

That's not really correct.

> -		nvme_calc_io_queues(dev, irq_queues);
> -		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
> -		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
> -		if (!irq_sets[1])
> -			affd.nr_sets = 1;

-----------------------^^^^^^^^^^^^^^^^^^  				     

That happens when the number of interrupts becomes too small to have split
queues. I'll fix that up.

Thanks,

	tglx


