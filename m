Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeJZKfr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Oct 2018 06:35:47 -0400
Date: Fri, 26 Oct 2018 10:00:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
Message-ID: <20181026020034.GA25933@ming.t460p>
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 25, 2018 at 05:09:32PM +0100, Rui Salvaterra wrote:
> Hi,
> 
> After commit 744889b7cbb56a64f957e65ade7cb65fe3f35714, I started
> getting this (-EIO, it seems) on my dmesg:
> 
> swapon: discard_swap(00000000c275f02d): -5
> 
> This is an 8 GB zram swap device. It's configured like this:
> 
> modprobe zram
> echo zstd > /sys/block/zram0/comp_algorithm
> echo 8297508864 > /sys/block/zram0/disksize
> mkswap /dev/zram0
> swapon -d -p 100 /dev/zram0
> 
> I should note that if I use --discard=pages instead of -d (both
> policies) at swapon, I don't get this error.
> Reverting the commit from v4.19 final fixes the error for me, but
> surely breaks something else. :)
> Let me know if you need any additional information.

The reason is that zram doesn't call blk_queue_split() in .make_request_fn, :-(

Then the similar logic in blk_queue_split() has to be duplicated somewhere,
such as __blkdev_issue_discard().

I will post a patch for you soon.

Thanks,
Ming
