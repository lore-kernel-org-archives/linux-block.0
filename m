Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 05/16] dm: always defer request allocation to the owner of
 the request_queue
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-6-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b8b5b5ad-f782-2a2e-9a7e-cef8e4b5806b@suse.de>
Date: Tue, 24 Jan 2017 09:29:22 +0100
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-6-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 04:29 PM, Christoph Hellwig wrote:
> DM already calls blk_mq_alloc_request on the request_queue of the
> underlying device if it is a blk-mq device.  But now that we allow drivers
> to allocate additional data and initialize it ahead of time we need to do
> the same for all drivers.   Doing so and using the new cmd_size
> infrastructure in the block layer greatly simplifies the dm-rq and mpath
> code, and should also make arbitrary combinations of SQ and MQ devices
> with SQ or MQ device mapper tables easily possible as a further step.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-core.h          |   1 -
>  drivers/md/dm-mpath.c         | 132 ++++------------------
>  drivers/md/dm-rq.c            | 251 ++++++++++--------------------------------
>  drivers/md/dm-rq.h            |   2 +-
>  drivers/md/dm-target.c        |   7 --
>  drivers/md/dm.c               |  18 +--
>  drivers/md/dm.h               |   3 +-
>  include/linux/device-mapper.h |   3 -
>  8 files changed, 81 insertions(+), 336 deletions(-)
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
