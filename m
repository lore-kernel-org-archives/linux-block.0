Return-Path: <hare@suse.de>
Subject: Re: [PATCH V3 07/12] scsi: sd_zbc: Use well defined macros
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20170915100645.17999-1-damien.lemoal@wdc.com>
 <20170915100645.17999-8-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bb1206b5-73a8-6778-7d1d-c52e93b92fb1@suse.de>
Date: Fri, 15 Sep 2017 12:45:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170915100645.17999-8-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/15/2017 12:06 PM, Damien Le Moal wrote:
> instead of open coding, use the min() macro to calculate a report zones
> reply buffer length in sd_zbc_check_zone_size() and the round_up()
> macro for calculating the number of zones in sd_zbc_setup().
> 
> No functional change is introduced by this patch.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/sd_zbc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
