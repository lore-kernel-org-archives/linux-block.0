Return-Path: <hare@suse.de>
Subject: Re: [PATCH V3 05/12] scsi: sd_zbc: Fix comments and indentation
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20170915100645.17999-1-damien.lemoal@wdc.com>
 <20170915100645.17999-6-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fc5f811e-423a-3cf9-4f96-63acae37264d@suse.de>
Date: Fri, 15 Sep 2017 12:44:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170915100645.17999-6-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/15/2017 12:06 PM, Damien Le Moal wrote:
> Fix comments style (do not use documented comment style) and add some
> comments to clarify some functions. Also fix some functions signature
> indentation and remove a useless blank line in sd_zbc_read_zones().
> 
> No functional change is introduced by this patch.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/scsi/scsi_lib.c |  5 +++-
>  drivers/scsi/sd_zbc.c   | 67 ++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 19 deletions(-)
> 
Actually you should've used kernel-doc style to format the comments;
just to keep the 0-day bot happy....

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
