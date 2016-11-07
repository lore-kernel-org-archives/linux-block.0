Return-Path: <hare@suse.de>
Subject: Re: [PATCH 1/2] irq,pci: allow drivers to specify complex affinity
 requirement
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478473646-12524-1-git-send-email-hch@lst.de>
 <1478473646-12524-2-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <249e2534-5a68-9bd0-e0e4-a9d4d42aa51d@suse.de>
Date: Mon, 7 Nov 2016 09:36:40 +0100
MIME-Version: 1.0
In-Reply-To: <1478473646-12524-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 12:07 AM, Christoph Hellwig wrote:
> Some drivers (various network and RDMA adapter for example) have a MSI-X
> vector layout where most of the vectors are used for I/O queues and should
> have CPU affinity assigned to them, but some (usually 1 but sometimes more)
> at the beginning or end are used for low-performance admin or configuration
> work and should not have any explicit affinity assigned to them.
> 
> This adds a new irq_affinity structure passed through a variant of
> pci_irq_alloc_vectors that allows to specify these requirements (and is
> extensible to any future quirks in that area) so that the core IRQ
> affinity algorithm can take this quirks into account.
> 
> It also removes the unused irq_affinity mask in struct pci_dev.  If we
> ever need that sort of functionality it should be passed through
> struct irq_affinity.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c         | 61 ++++++++++++++++++++++++--------------------
>  include/linux/interrupt.h | 26 ++++++++++++++++---
>  include/linux/pci.h       | 14 ++++++----
>  kernel/irq/affinity.c     | 65 ++++++++++++++++++++++++-----------------------
>  4 files changed, 98 insertions(+), 68 deletions(-)
> 
Good idea.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
