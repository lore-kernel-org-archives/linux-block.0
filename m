Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Check partition alignment on zoned block devices
To: Damien Le Moal <damien.lemoal@wdc.com>
References: <1480494139-1658-1-git-send-email-damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b35953aa-09c2-6cf3-4a79-7ec6af77e156@kernel.dk>
Date: Wed, 30 Nov 2016 08:20:55 -0700
MIME-Version: 1.0
In-Reply-To: <1480494139-1658-1-git-send-email-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/30/2016 01:22 AM, Damien Le Moal wrote:
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

Let's try and keep the ZONED ifdefs to a minimum, I absolutely hate
having those sprinkled throughout the code. Less of an issue in the
headers.

bdev_is_zoned() is safe to call without the ifdef, and let's kill it
around the part_zone_aligned() function too. There's no need for either
one of the ifdefs below, as far as I can tell.

-- 
Jens Axboe
