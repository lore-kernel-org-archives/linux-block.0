Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/7] genirq/affinity: Handle pre/post vectors in
 irq_calc_affinity_vectors()
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478654107-7384-1-git-send-email-hch@lst.de>
 <1478654107-7384-3-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6f4f8e0f-94bf-d9c0-f97e-cd629f4b8122@suse.de>
Date: Wed, 9 Nov 2016 08:04:32 +0100
MIME-Version: 1.0
In-Reply-To: <1478654107-7384-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/09/2016 02:15 AM, Christoph Hellwig wrote:
> Only calculate the affinity for the main I/O vectors, and skip the
> pre or post vectors specified by struct irq_affinity.
>
> Also remove the irq_affinity cpumask argument that has never been used.
> If we ever need it in the future we can pass it through struct
> irq_affinity.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c         |  8 ++++----
>  include/linux/interrupt.h |  4 ++--
>  kernel/irq/affinity.c     | 24 ++++++++++--------------
>  3 files changed, 16 insertions(+), 20 deletions(-)
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
