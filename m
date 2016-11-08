Return-Path: <hare@suse.de>
Subject: Re: [PATCH 5/7] pci/msi: Provide pci_alloc_irq_vectors_affinity()
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-6-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7cf222db-cb37-9ef3-29bf-00f36663ea6d@suse.de>
Date: Tue, 8 Nov 2016 09:17:33 +0100
MIME-Version: 1.0
In-Reply-To: <1478544462-9549-6-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 07:47 PM, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>
>
> This is a variant of pci_alloc_irq_vectors() that allows passing a
> struct irq_affinity to provide fine-grainded IRQ affinity control.
> For now this means being able to exclude vectors at the beginning or
> end of the MSI vector space, but it could also be used for any other
> quirks needed in the future (e.g. more vectors than CPUs, or exluding
> CPUs from the spreading).
>
> Signed-off-by: Christogh Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c   | 20 +++++++++++++-------
>  include/linux/pci.h | 24 +++++++++++++++++++-----
>  2 files changed, 32 insertions(+), 12 deletions(-)
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
