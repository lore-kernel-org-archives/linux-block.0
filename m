Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/2] blk-mq: add a first_vec argument to
 blk_mq_pci_map_queues
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478473646-12524-1-git-send-email-hch@lst.de>
 <1478473646-12524-3-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c9322061-cbd0-8347-6581-d0a91c8b144f@suse.de>
Date: Mon, 7 Nov 2016 10:37:16 +0100
MIME-Version: 1.0
In-Reply-To: <1478473646-12524-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 12:07 AM, Christoph Hellwig wrote:
> This allows skipping the first N IRQ vectors in case they are used for
> control or admin interrupts.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-pci.c         | 6 ++++--
>  drivers/nvme/host/pci.c    | 2 +-
>  include/linux/blk-mq-pci.h | 3 ++-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
With this patch smartpqi doesn't compile anymore; it still uses the old
interface.
So to get this merged you probably should send a patch for that one, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
