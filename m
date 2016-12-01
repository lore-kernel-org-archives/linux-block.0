Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3] block: Check partition alignment on zoned block
 devices
To: Damien Le Moal <damien.lemoal@wdc.com>, Jens Axboe <axboe@kernel.dk>
References: <1480573523-30381-1-git-send-email-damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0bea3cc0-f30e-3625-27d4-a39fee03a781@suse.de>
Date: Thu, 1 Dec 2016 07:50:51 +0100
MIME-Version: 1.0
In-Reply-To: <1480573523-30381-1-git-send-email-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/01/2016 07:25 AM, Damien Le Moal wrote:
> Both blkdev_report_zones and blkdev_reset_zones can operate on a partition of
> a zoned block device. However, the first and last zones reported for a
> partition make sense only if the partition start sector and size are aligned
> on the device zone size. The same applies for zone reset. Resetting the first
> or the last zone of a partition straddling zones may impact neighboring
> partitions. Finally, if a partition start sector is not at the beginning of a
> sequential zone, it will be impossible to write to the first sectors of the
> partition on a host-managed device.
> Avoid all these problems and incoherencies by ignoring partitions that are not
> zone aligned.
> 
> Note: If CONFIG_BLK_DEV_ZONED is disabled, bdev_is_zoned() will still report
> the correct disk zoning type (host-aware, host-managed or none) but
> bdev_zone_size() will always return 0 for zoned block devices (i.e. the zone
> size is unknown). So test this as a way to ensure that a zoned block device is
> being handled as such. As a result, for a host-aware devices, unaligned zone
> partitions will be accepted with CONFIG_BLK_DEV_ZONED disabled. That is, the
> disk will be treated as a regular block device (as it should). If zoned block
> device support is enabled, only aligned partitions will be accepted.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/partition-generic.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 71d9ed9..a60ac7f 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -430,6 +430,57 @@ static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
>  	return 0;
>  }
>  
> +static bool part_zone_aligned(struct gendisk *disk,
> +			      struct block_device *bdev,
> +			      sector_t from, sector_t size)
> +{
> +	unsigned int zone_size = bdev_zone_size(bdev);
> +
> +	/*
> +	 * If this function is called, then the disk is a zoned block device
> +	 * (host-aware or host-managed). This can be detected even if the
> +	 * zoned block device support is disabled (CONFIG_BLK_DEV_ZONED not
> +	 * set). In this case, however, only host-aware devices will be seen
> +	 * as a block device is not created for host-managed devices. Without
> +	 * zoned block device support, host-aware drives can still be used as
> +	 * regular block devices (no zone operation) and their zone size will
> +	 * be reported as 0. Allow this case.
> +	 */
> +	if (!zone_size)
> +		return true;
> +
> +	/*
> +	 * Check partition start and size alignement. If the drive has a
> +	 * smaller last runt zone, ignore it and allow the partition to
> +	 * use it. Check the zone size too: it should be a power of 2 number
> +	 * of sectors.
> +	 */
> +	WARN_ON_ONCE(!is_power_of_2(zone_size));
> +	if (!is_power_of_2(zone_size)) {
Can be merged into 'if (WARN_ON_ONCE(! ...'

> +		u32 rem;
> +
> +		div_u64_rem(from, zone_size, &rem);
> +		if (rem)
> +			return false;
> +		if ((from + size) < get_capacity(disk)) {
> +			div_u64_rem(size, zone_size, &rem);
> +			if (rem)
> +				return false;
> +		}
> +
> +	} else {
> +
> +		if (from & (zone_size - 1))
> +			return false;
> +		if ((from + size) < get_capacity(disk) &&
> +		    (size & (zone_size - 1)))
> +			return false;
> +
> +	}
> +
> +	return true;
> +}
> +
>  int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  {
>  	struct parsed_partitions *state = NULL;
> @@ -529,6 +580,21 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  			}
>  		}
>  
> +		/*
> +		 * On a zoned block device, partitions should be aligned on the
> +		 * device zone size (i.e. zone boundary crossing not allowed).
> +		 * Otherwise, resetting the write pointer of the last zone of
> +		 * one partition may impact the following partition.
> +		 */
> +		if (bdev_is_zoned(bdev) &&
> +		    !part_zone_aligned(disk, bdev, from, size)) {
> +			printk(KERN_WARNING
> +			       "%s: p%d start %llu+%llu is not zone aligned\n",
> +			       disk->disk_name, p, (unsigned long long) from,
> +			       (unsigned long long) size);
> +			continue;
> +		}
> +
>  		part = add_partition(disk, p, from, size,
>  				     state->parts[p].flags,
>  				     &state->parts[p].info);
> 
Otherwise looks good.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
