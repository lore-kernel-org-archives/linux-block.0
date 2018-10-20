Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] block: fixes for always associate blkg
To: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
 kernel-team@fb.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181020185612.51587-1-dennis@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bcc8829d-e7ba-1f4b-e4eb-32deed97ffa8@kernel.dk>
Date: Sat, 20 Oct 2018 15:40:22 -0600
MIME-Version: 1.0
In-Reply-To: <20181020185612.51587-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/20/18 12:56 PM, Dennis Zhou wrote:
> Hi everyone,
> 
> It was reported in [1] that blk_get_rl() cleanup patch was causing a
> null pointer dereference. After some back and forth debugging with
> Valdis, it turns out I wasn't properly handling association with
> recursive calls to make_request().
> 
> Another issue was identified with the blk_get_rl() update as it is
> possible under certain circumstances that a blkg cannot be allocated
> when called in blk_get_rl(). This could result in the blkcg_root being
> returned. However, the blkcg_root is a special case where all blkgs
> share the request_queue's request_list.
> 
> The original series can be found at [2].
> 
> [1] https://lore.kernel.org/lkml/13987.1539646128@turing-police.cc.vt.edu/
> [2] https://lore.kernel.org/lkml/20180911184137.35897-1-dennisszhou@gmail.com/
> 
> This patchset contains the following 2 patches:
>   0001-blkcg-fix-edge-case-for-blk_get_rl-under-memory-pres.patch
>   0002-blkcg-reassociate-bios-when-make_request-is-called-r.patch
> 
> 0001 addresses an edge case where a blkg cannot be created and can
> possibly return a blkg associated with the blkcg_root. 0002 fixes the
> stale association when make_request() is called recursively.

Thanks Dennis, applied.

-- 
Jens Axboe
