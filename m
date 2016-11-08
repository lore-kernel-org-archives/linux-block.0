Return-Path: <hare@suse.de>
Subject: Re: [PATCH 6/7] pci: Remove the irq_affinity mask from struct pci_dev
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-7-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3318118c-d77a-7fda-6b18-94b9db418fbe@suse.de>
Date: Tue, 8 Nov 2016 09:17:56 +0100
MIME-Version: 1.0
In-Reply-To: <1478544462-9549-7-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 07:47 PM, Christoph Hellwig wrote:
> This has never been used, and now is totally unreferenced.  Nuke it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
