Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67631C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C025206C2
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfBFIIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:08:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:55944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfBFIIL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 03:08:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F2BFABE6;
        Wed,  6 Feb 2019 08:08:09 +0000 (UTC)
Subject: Re: [PATCH] bcache: fix a race between register and allocator thread
To:     Junhui Tang <tang.junhui.linux@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <CA+NNRhHC=uCwPgjec2JyE-BcFARFsDc9mX28Qxke_b3=eZ76Gg@mail.gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <7df5e6ee-3198-decc-cb1e-f5cbd9e164b1@suse.de>
Date:   Wed, 6 Feb 2019 16:08:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+NNRhHC=uCwPgjec2JyE-BcFARFsDc9mX28Qxke_b3=eZ76Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/1/24 4:09 下午, Junhui Tang wrote:
> From d75d1b51aeedcc9349571be084c5f51d8f7e7612 Mon Sep 17 00:00:00 2001
> From: Tang Junhui <tang.junhui.linux@gmail.com>
> Date: Thu, 24 Jan 2019 16:01:35 +0800
> Subject: [PATCH] bcache: fix a race between register and allocator thread
> 
> when register a new cache device, allocator get stucked,
> the call trace is bellow:
> Sangfor:EDS/eds-fe5192de /sf # cat /proc/3642/task/*/stack
> [<ffffffffa02b01c8>] bch_bucket_alloc+0x178/0x2b0 [bcache]
> [<ffffffffa02c737d>] bch_prio_write+0x18d/0x320 [bcache]
> [<ffffffffa02b0042>] bch_allocator_thread+0x432/0x440 [bcache]
> [<ffffffff810a1430>] kthread+0xc0/0xd0
> [<ffffffff8173def7>] ret_from_fork+0x77/0xb0
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> There is a race between register and allocator thread:
> register thread                       allocator thread
> run_cache_set
> =>bch_initial_gc_finish
>   alloc prio buckets
> =>bch_cache_allocator_start
>   start allocator thread             bch_allocator_thread
> =>bch_prio_write                     =>invalidate_buckets
>   write prio using prio buckets        fill bucket into ca->free_inc
> =>SET_CACHE_SYNC
>   set cache sync mode                 =>bch_prio_write
>                                         since cache sync mode is set,
>                                         write prio to bucket, and the
>                                         prio bucket has been used in
>                                         register thread, no bucket can
>                                         used. so the allocator thread
>                                         stuck here.
> In this patch, register thread wait for the allocator thread to finish
> work, then write prio to buckets and set cache to sync mode.
> 
> Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
> ---
>  drivers/md/bcache/super.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index fa4058e..818d2f1 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1852,13 +1852,28 @@ static void run_cache_set(struct cache_set *c)
>   bch_initial_gc_finish(c);
> 
>   err = "error starting allocator thread";
> - for_each_cache(ca, c, i)
> - if (bch_cache_allocator_start(ca))
> - goto err;
> -
>   mutex_lock(&c->bucket_lock);
> - for_each_cache(ca, c, i)
> + for_each_cache(ca, c, i) {
> + DEFINE_WAIT(wait);
> +
> + if (bch_cache_allocator_start(ca)) {
> + mutex_unlock(&c->bucket_lock);
> + goto err;
> + }
> +
> + for (;;) {
> + prepare_to_wait(&c->bucket_wait, &wait,
> + TASK_UNINTERRUPTIBLE);
> + if (!fifo_empty(&ca->free_inc))
> + break;
> + mutex_unlock(&c->bucket_lock);
> + schedule();
> + mutex_lock(&c->bucket_lock);
> + }
> +
> + finish_wait(&c->bucket_wait, &wait);
>   bch_prio_write(ca);
> + }
>   mutex_unlock(&c->bucket_lock);
> 
>   err = "cannot allocate new UUID bucket";
> 

Hi Junhui,

It seems your patch losts all indent format. Could you please to handle
it and resend the peroper format again ?

Thanks.

-- 

Coly Li
