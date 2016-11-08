Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932655AbcKHVVD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 16:21:03 -0500
Date: Tue, 8 Nov 2016 15:20:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] genirq/affinity: Handle pre/post vectors in
 irq_create_affinity_masks()
Message-ID: <20161108212059.GE14322@bhelgaas-glaptop.roam.corp.google.com>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478544462-9549-4-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 07, 2016 at 10:47:38AM -0800, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>
> 
> Only calculate the affinity for the main I/O vectors, and skip the
> pre or post vectors specified by struct irq_affinity.
> 
> Also remove the irq_affinity cpumask argument that has never been used.
> If we ever need it in the future we can pass it through struct
> irq_affinity.
> 
> Signed-off-by: Christogh Hellwig <hch@lst.de>

s/Christogh/Christoph/ (also above, and maybe other patches too?)

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c         |  4 ++--
>  include/linux/interrupt.h |  4 ++--
>  kernel/irq/affinity.c     | 46 +++++++++++++++++++++++++---------------------
>  3 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index c58d3c2..1761b8a 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -558,7 +558,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity)
>  	u16 control;
>  
>  	if (affinity) {
> -		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
> +		masks = irq_create_affinity_masks(nvec, NULL);
>  		if (!masks)
>  			pr_err("Unable to allocate affinity masks, ignoring\n");
>  	}
> @@ -697,7 +697,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  	int ret, i;
>  
>  	if (affinity) {
> -		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
> +		masks = irq_create_affinity_masks(nvec, NULL);
>  		if (!masks)
>  			pr_err("Unable to allocate affinity masks, ignoring\n");

Not caused by this patch, but can we use dev_err() here and above?
