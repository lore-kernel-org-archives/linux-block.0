Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] block: zoned: fix harmless maybe-uninitialized warning
To: Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
References: <20161021154242.3707589-1-arnd@arndb.de>
CC: Shaun Tancheff <shaun@tancheff.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes
 Reinecke <hare@suse.de>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <4a2b4842-3849-ead5-f3e2-774a9778eda6@wdc.com>
Date: Mon, 24 Oct 2016 08:38:39 +0900
MIME-Version: 1.0
In-Reply-To: <20161021154242.3707589-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>


On 10/22/16 00:42, Arnd Bergmann wrote:
> The blkdev_report_zones produces a harmless warning when
> -Wmaybe-uninitialized is set, after gcc gets a little confused
> about the multiple 'goto' here:
> =

> block/blk-zoned.c: In function 'blkdev_report_zones':
> block/blk-zoned.c:188:13: error: 'nz' may be used uninitialized in this f=
unction [-Werror=3Dmaybe-uninitialized]
> =

> Moving the assignment to nr_zones makes this a little simpler
> while also avoiding the warning reliably. I'm removing the
> extraneous initialization of 'int ret' in the same patch, as
> that is semi-related and could cause an uninitialized use of
> that variable to not produce a warning.
> =

> Fixes: 6a0cb1bc106f ("block: Implement support for zoned block devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  block/blk-zoned.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> =

> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 667f95d86695..472211fa183a 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -80,7 +80,7 @@ int blkdev_report_zones(struct block_device *bdev,
>  	unsigned int i, n, nz;
>  	unsigned int ofst;
>  	void *addr;
> -	int ret =3D 0;
> +	int ret;
>  =

>  	if (!q)
>  		return -ENXIO;
> @@ -179,14 +179,12 @@ int blkdev_report_zones(struct block_device *bdev,
>  =

>  	}
>  =

> +	*nr_zones =3D nz;
>  out:
>  	bio_for_each_segment_all(bv, bio, i)
>  		__free_page(bv->bv_page);
>  	bio_put(bio);
>  =

> -	if (ret =3D=3D 0)
> -		*nr_zones =3D nz;
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
