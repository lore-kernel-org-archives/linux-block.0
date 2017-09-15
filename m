Return-Path: <hare@suse.de>
Subject: Re: [PATCH V3 10/12] scsi: sd_zbc: Limit zone write locking to
 sequential zones
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20170915100645.17999-1-damien.lemoal@wdc.com>
 <20170915100645.17999-11-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4446858a-6fb3-23b9-5772-db1c32ccbeb3@suse.de>
Date: Fri, 15 Sep 2017 12:52:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170915100645.17999-11-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/15/2017 12:06 PM, Damien Le Moal wrote:
> Zoned block devices have no write constraints for conventional zones.
> So write locking of conventional zones is not necessary and can even
> hurt performance by unnecessarily operating the disk under low queue
> depth. To avoid this, use the disk request queue seq_zones bitmap to
> allow any write to be issued to conventional zones, locking only
> sequential zones.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/scsi/sd_zbc.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
Reviwed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
