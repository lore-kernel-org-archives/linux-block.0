Return-Path: <hare@suse.de>
Subject: Re: [PATCH 1/6] bcache: store disk name in struct cache and struct
 cached_dev
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20180502144659.118628-1-colyli@suse.de>
 <20180502144659.118628-2-colyli@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <69378646-abec-1ea2-4e72-1aa8a7131f05@suse.de>
Date: Thu, 3 May 2018 07:51:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180502144659.118628-2-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/02/2018 04:46 PM, Coly Li wrote:
> Current code uses bdevname() or bio_devname() to reference gendisk
> disk name when bcache needs to display the disk names in kernel message.
> It was safe before bcache device failure handling patch set merged in,
> because when devices are failed, there was deadlock to prevent bcache
> printing error messages with gendisk disk name. But after the failure
> handling patch set merged, the deadlock is fixed, so it is possible
> that the gendisk structure bdev->hd_disk is released when bdevname() is
> called to reference bdev->bd_disk->disk_name[]. This is why I receive
> bug report of NULL pointers deference panic.
> 
> This patch stores gendisk disk name in a buffer inside struct cache and
> struct cached_dev, then print out the offline device name won't reference
> bdev->hd_disk anymore. And this patch also avoids extra function calls
> of bdevname() and bio_devnmae().
> 
> Changelog:
> v2, call bdevname() earlier in register_bdev()
> v1, first version with segguestion from Junhui Tang.
> 
> Fixes: c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev")
> Fixes: 5138ac6748e38 ("bcache: fix misleading error message in bch_count_io_errors()")
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/bcache.h  |  4 ++++
>   drivers/md/bcache/debug.c   |  3 +--
>   drivers/md/bcache/io.c      |  8 +++-----
>   drivers/md/bcache/request.c |  5 +----
>   drivers/md/bcache/super.c   | 44 +++++++++++++++++++++-----------------------
>   5 files changed, 30 insertions(+), 34 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
