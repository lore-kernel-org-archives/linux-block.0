Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeD3GYq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 02:24:46 -0400
Subject: Re: [PATCH 0/6] bcache fixes for device failure handling
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180424121446.130552-1-colyli@suse.de>
From: Coly Li <colyli@suse.de>
Message-ID: <c2ec71c1-cd34-56c2-f1a5-814b6a91f8e9@suse.de>
Date: Mon, 30 Apr 2018 14:24:37 +0800
MIME-Version: 1.0
In-Reply-To: <20180424121446.130552-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/4/24 8:14 PM, Coly Li wrote:
> Hi folks,
> 
> I receive bug reports from partners for the bcache cache device failure
> handling patch set (which is just merged into 4.17). Fortunately we are
> still in 4.17 merge window, so I ask helps for offering code review
> before I ask Jens to pick these fixes for 4.17-rc3.
> 
> The patches are well commneted IMHO and passes regression test by myself.
> Thanks for your help in advance.

Hi folks,

Can anybody help to offer Reivew-by: to these fixes ? Now it is already
4.17-rc3, we need these fixes go into 4.17 kernel with the patches to be
fixed. Even Acked-by: is helpful.

Thanks in advance.

Coly Li

> ---
> Coly Li (6):
>   bcache: store disk name in struct cache and struct cached_dev
>   bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()
>   bcache: count backing device I/O error for writeback I/O
>   bcache: add wait_for_kthread_stop() in bch_allocator_thread()
>   bcache: set dc->io_disable to true in conditional_stop_bcache_device()
>   bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set
> 
>  drivers/md/bcache/alloc.c     |  1 +
>  drivers/md/bcache/bcache.h    |  4 +++
>  drivers/md/bcache/debug.c     |  3 +-
>  drivers/md/bcache/io.c        |  8 ++---
>  drivers/md/bcache/request.c   |  5 +--
>  drivers/md/bcache/super.c     | 73 ++++++++++++++++++++++++++++++-------------
>  drivers/md/bcache/writeback.c |  4 ++-
>  7 files changed, 64 insertions(+), 34 deletions(-)
> 
