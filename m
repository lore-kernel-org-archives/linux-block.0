Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] fix blkcg offlining and destruction
To: Dennis Zhou <dennisszhou@gmail.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180831202244.21678-1-dennisszhou@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7b5ec635-c251-7ac3-bebd-2cfd687ffed6@kernel.dk>
Date: Fri, 31 Aug 2018 14:49:54 -0600
MIME-Version: 1.0
In-Reply-To: <20180831202244.21678-1-dennisszhou@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/31/18 2:22 PM, Dennis Zhou wrote:
> Hi everyone,
> 
> This is a split of an earlier series I sent out [1] containing the first
> 3 patches with fixes from feedback. This series tackles the first
> problem where blkcgs were not being destroyed.
> 
> There is a regression in blkcg destruction where references weren't
> properly put causing blkcgs to never be destroyed. Previously, blkgs
> were destroyed during offlining of the blkcg. This puts back the blkcg
> reference a blkg holds allowing blkcg ref to reach zero. Then,
> blkcg_css_free() is called as part of the final cleanup.
> 
> To address the problem, 0001 reverts the broken commit, 0002 delays
> blkg destruction until writeback has finished, and 0003 closes the
> window on a race condition between a css migration and dying, and
> blkg association. This should fix the issue where blkg_get() was getting
> called when a blkcg had already begun exiting. If a bio finds itself
> here, it will just fall back to root. Oddly enough at one point,
> blk-throttle was using policy data from and associating with potentially
> different blkgs, thus how this was exposed.
> 
> [1] https://lore.kernel.org/lkml/20180831015356.69796-1-dennisszhou@gmail.com/T
> 
> This patchset contains the following 3 patches:
>   0001-Revert-blk-throttle-fix-race-between-blkcg_bio_issue.patch
>   0002-blkcg-delay-blkg-destruction-until-after-writeback-h.patch
>   0003-blkcg-use-tryget-logic-when-associating-a-blkg-with-.patch
> 
> 0001 reverts the broken commit.
> 0002 delays blkg destruction until after writeback.
> 0003 fixes a race condition for ongoing IO and blkcg destruction.

Applied for 4.19, thanks Dennis.

-- 
Jens Axboe
