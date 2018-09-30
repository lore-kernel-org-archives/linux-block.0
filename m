Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbeJAGA6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Oct 2018 02:00:58 -0400
Subject: Re: [PATCH] bcache: fix ioctl in flash device
To: Junhui Tang <tang.junhui.linux@gmail.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <CA+NNRhHMQDo8MZ7x=jiZnu8PdRD+pw_PE9CzH5-9oNQga92Wkw@mail.gmail.com>
From: Coly Li <colyli@suse.de>
Message-ID: <a07bf86d-341a-814b-a9d0-1f92b3375962@suse.de>
Date: Mon, 1 Oct 2018 07:25:56 +0800
MIME-Version: 1.0
In-Reply-To: <CA+NNRhHMQDo8MZ7x=jiZnu8PdRD+pw_PE9CzH5-9oNQga92Wkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 9/7/18 8:01 PM, Junhui Tang wrote:
>  From 799ad1d9443a28eb640c8dbc3abe8a224f3a1292 Mon Sep 17 00:00:00 2001
> From: Tang Junhui <tang.junhui.linux@gmail.com>
> Date: Sat, 8 Sep 2018 03:51:30 +0800
> Subject: [PATCH] bcache: fix ioctl in flash device
>
> When doing ioctl in flash device, it will call ioctl_dev() in super.c,
> then we should not to get cached device since flash only device has
> no backend device. This patch just move the jugement dc->io_disable
> to cached_dev_ioctl() to make ioctl in flash device correctly.
>
> Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>

Nice catch, I will add a Fixes: 0f0709e6bfc3c line in the commit log.

Have it in my for-next. Thanks.


Coly Li

> ---
>   drivers/md/bcache/request.c | 3 +++
>   drivers/md/bcache/super.c   | 4 ----
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 7dbe8b6..bafc85e 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1212,6 +1212,9 @@ static int cached_dev_ioctl(struct bcache_device
> *d, fmode_t mode,
>        unsigned int cmd, unsigned long arg)
>   {
>    struct cached_dev *dc = container_of(d, struct cached_dev, disk);
> +
> + if (dc->io_disable)
> + return -EIO;
>    return __blkdev_driver_ioctl(dc->bdev, mode, cmd, arg);
>   }
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 55a3764..ced830e 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -636,10 +636,6 @@ static int ioctl_dev(struct block_device *b, fmode_t mode,
>         unsigned int cmd, unsigned long arg)
>   {
>    struct bcache_device *d = b->bd_disk->private_data;
> - struct cached_dev *dc = container_of(d, struct cached_dev, disk);
> -
> - if (dc->io_disable)
> - return -EIO;
>
>    return d->ioctl(d, mode, cmd, arg);
>   }
