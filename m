Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727277AbeJAGBJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Oct 2018 02:01:09 -0400
Subject: Re: [PATCH] bcache: correct dirty data statistics
To: Junhui Tang <tang.junhui.linux@gmail.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <CA+NNRhEk+aRdzfs5vDOwKLDznEZjVRE32n4M+L=wV5ySrpmRpQ@mail.gmail.com>
From: Coly Li <colyli@suse.de>
Message-ID: <89799b01-7b83-4a00-ee29-d9094ce07cb1@suse.de>
Date: Mon, 1 Oct 2018 07:26:09 +0800
MIME-Version: 1.0
In-Reply-To: <CA+NNRhEk+aRdzfs5vDOwKLDznEZjVRE32n4M+L=wV5ySrpmRpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 9/1/18 5:34 PM, Junhui Tang wrote:
>  From fb4bdec3fce8016e813b4b8da6e705fb65d910f2 Mon Sep 17 00:00:00 2001
> From: Tang Junhui <tang.junhui.linux@gmail.com>
> Date: Sun, 2 Sep 2018 01:22:22 +0800
> Subject: [PATCH] bcache: correct dirty data statistics
>
> When bcache device is clean, dirty keys may still exist after
> journal replay, so we need to count these dirty keys even
> device in clean status, otherwise after writeback, the amount
> of dirty data would be incorrect.
>
> Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
> ---

Nice catch. Added to my for-next, and CC stable@vger.kernel.org.

Thanks.

Coly Li

>   drivers/md/bcache/super.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 55a3764..c5f0f65 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1139,11 +1139,12 @@ int bch_cached_dev_attach(struct cached_dev
> *dc, struct cache_set *c,
>    }
>
>    if (BDEV_STATE(&dc->sb) == BDEV_STATE_DIRTY) {
> - bch_sectors_dirty_init(&dc->disk);
>    atomic_set(&dc->has_dirty, 1);
>    bch_writeback_queue(dc);
>    }
>
> + bch_sectors_dirty_init(&dc->disk);
> +
>    bch_cached_dev_run(dc);
>    bcache_device_link(&dc->disk, c, "bdev");
>    atomic_inc(&c->attached_dev_nr);
