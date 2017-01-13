Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 3/4] nvme: use blk_rq_payload_bytes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-4-git-send-email-hch@lst.de>
Cc: Dexuan Cui <decui@microsoft.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bd744e72-35ca-4b98-e037-0abe30a5059d@suse.de>
Date: Fri, 13 Jan 2017 12:43:55 +0100
MIME-Version: 1.0
In-Reply-To: <1484306953-3194-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 01/13/2017 12:29 PM, Christoph Hellwig wrote:
> The new blk_rq_payload_bytes generalizes the payload length hacks
> that nvme_map_len did before.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/fc.c   |  5 ++---
>  drivers/nvme/host/nvme.h |  8 --------
>  drivers/nvme/host/pci.c  | 19 ++++++++-----------
>  drivers/nvme/host/rdma.c | 13 +++++--------
>  4 files changed, 15 insertions(+), 30 deletions(-)
> 
[ .. ]
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
