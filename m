Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 03/11] scsi: sd_zbc: Fix sd_zbc_check_zones() error
 checks
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-4-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e45aba21-baf3-caab-de83-0c36925ebfdb@suse.de>
Date: Fri, 12 Oct 2018 09:35:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> The 32 bits overflow check for the zone size value is already done
> within sd_zbc_check_zones() with the test:
> 
> } else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
> 
> so there is no need to check again for an out of range value in
> sd_zbc_read_zones(). Simplify the code and fix sd_zbc_check_zones()
> error return to -EFBIG instead of -ENODEV if the zone size is too large.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd_zbc.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index ca73c46931c0..44b64b4a922a 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -373,7 +373,7 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
>    * Returns the zone size in number of blocks upon success or an error code
>    * upon failure.
>    */
> -static s64 sd_zbc_check_zones(struct scsi_disk *sdkp)
> +static s32 sd_zbc_check_zones(struct scsi_disk *sdkp)
>   {
>   	u64 zone_blocks = 0;
>   	sector_t max_lba, block = 0;
Does this have to be an 's32' ?
Seeing that it's overloaded with an error code, and never sent to any 
hardware, can't we just make it a simple 'int' ?

> @@ -472,7 +472,7 @@ static s64 sd_zbc_check_zones(struct scsi_disk *sdkp)
>   		if (sdkp->first_scan)
>   			sd_printk(KERN_NOTICE, sdkp,
>   				  "Zone size too large\n");
> -		ret = -ENODEV;
> +		ret = -EFBIG;
>   	} else {
>   		ret = zone_blocks;
>   	}
> @@ -668,8 +668,7 @@ static int sd_zbc_setup(struct scsi_disk *sdkp, u32 zone_blocks)
>   
>   int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
>   {
> -	int64_t zone_blocks;
> -	int ret;
> +	int ret, zone_blocks;
>   
>   	if (!sd_is_zoned(sdkp))
>   		/*
> @@ -688,12 +687,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
>   	 * an eventual last runt zone) that is a power of 2 are supported.
>   	 */
>   	zone_blocks = sd_zbc_check_zones(sdkp);
> -	ret = -EFBIG;
> -	if (zone_blocks != (u32)zone_blocks)
> -		goto err;
> -	ret = zone_blocks;
> -	if (ret < 0)
> +	if (zone_blocks < 0) {
> +		ret = zone_blocks;
>   		goto err;
> +	}
>   
>   	/* The drive satisfies the kernel restrictions: set it up */
>   	ret = sd_zbc_setup(sdkp, zone_blocks);
> 
Remaining bits are okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
