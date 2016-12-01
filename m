Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4] block: Check partition alignment on zoned block
 devices
To: Damien Le Moal <damien.lemoal@wdc.com>
References: <1480575625-32134-1-git-send-email-damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <475c6798-5be1-4842-857e-2ad35056ede6@kernel.dk>
Date: Thu, 1 Dec 2016 07:57:31 -0700
MIME-Version: 1.0
In-Reply-To: <1480575625-32134-1-git-send-email-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/01/2016 12:00 AM, Damien Le Moal wrote:
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
> Note: Even with CONFIG_BLK_DEV_ZONED disabled, bdev_is_zoned() will report the
> correct disk zoning type (host-aware, host-managed or none) but
> bdev_zone_size() will always return 0 for zoned block devices (i.e. the zone
> size is unknown). So test this as a way to ensure that a zoned block device is
> being handled as such. As a result, for a host-aware devices, unaligned zone
> partitions will be accepted with CONFIG_BLK_DEV_ZONED disabled. That is, the
> disk will be treated as a regular block device (as it should). If zoned block
> device support is enabled, only aligned partitions will be accepted.

Thanks Damien, applied.

-- 
Jens Axboe
