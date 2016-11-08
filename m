Return-Path: <helgaas@kernel.org>
Date: Tue, 8 Nov 2016 14:59:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] pci: Remove the irq_affinity mask from struct pci_dev
Message-ID: <20161108205949.GB14322@bhelgaas-glaptop.roam.corp.google.com>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-7-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478544462-9549-7-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

s/pci/PCI/ (in subject)

On Mon, Nov 07, 2016 at 10:47:41AM -0800, Christoph Hellwig wrote:
> This has never been used, and now is totally unreferenced.  Nuke it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7090f5f..f2ba6ac 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -333,7 +333,6 @@ struct pci_dev {
>  	 * directly, use the values stored here. They might be different!
>  	 */
>  	unsigned int	irq;
> -	struct cpumask	*irq_affinity;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
>  
>  	bool match_driver;		/* Skip attaching driver */
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
