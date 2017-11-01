Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Rework drivers/cdrom/Makefile
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20171030160219.13019-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <219ea283-2025-3cd9-6927-d18e7776e5ff@kernel.dk>
Date: Wed, 1 Nov 2017 08:41:05 -0600
MIME-Version: 1.0
In-Reply-To: <20171030160219.13019-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/2017 10:02 AM, Bart Van Assche wrote:
> Instead of referring from inside drivers/cdrom/Makefile to all the
> drivers that use this driver, let these drivers select the cdrom
> driver. This change makes the cdrom build code follow the approach
> that is used for most other drivers, namely refer from the higher
> layers to the lower layer instead of from the lower layer to the
> higher layers.

Looks good, thanks Bart.

-- 
Jens Axboe
