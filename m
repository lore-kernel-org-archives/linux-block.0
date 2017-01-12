Return-Path: <axboe@kernel.dk>
Date: Wed, 11 Jan 2017 20:52:14 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-block@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/2] Rename blk_queue_zone_size and bdev_zone_size
Message-ID: <20170112035214.GA27546@kernel.dk>
References: <20170112024253.5814-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170112024253.5814-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 12 2017, Damien Le Moal wrote:
> All block device data fields and functions returning a number of 512B
> sectors are by convention named xxx_sectors while names in the form
> of xxx_size are generally used for a number of bytes. The blk_queue_zone_size
> and bdev_zone_size functions were not following this convention so rename
> them.
> 
> This is a style fix and no functional change is introduced by this patch.

I agree, this cleans it up. Applied.

-- 
Jens Axboe
