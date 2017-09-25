Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc3
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <299fd2d3-1cc6-f08e-88d3-b2976ff6a3dd@kernel.dk>
Message-ID: <6d1b873a-31ba-0f3c-140e-a2901c36c404@kernel.dk>
Date: Mon, 25 Sep 2017 12:43:16 -0600
MIME-Version: 1.0
In-Reply-To: <299fd2d3-1cc6-f08e-88d3-b2976ff6a3dd@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/25/2017 09:31 AM, Jens Axboe wrote:
> Hi Linus,
> 
> A round of fixes for this series. This pull request contains:
> 
> - Two sets of NVMe pull requests from Christoph:
> 
> 	- Fixes for the Fibre Channel host/target to fix spec
> 	  compliance
> 	- Allow a zero keep alive timeout
> 	- Make the debug printk for broken SGLs work better
> 	- Fix queue zeroing during initialization
> 	- Set of RDMA and FC fixes
> 	- Target div-by-zero fix
> 
> - bsg double-free fix.
> 
> - ndb unknown ioctl fix from Josef.
> 
> - Buffered vs O_DIRECT page cache inconsistency fix. Has been floating
>   around for a long time, well reviewed. From Lukas.
> 
> - brd overflow fix from Mikulas.
> 
> - Fix for a loop regression in this merge window, where using a union
>   for two members of the loop_cmd turned out to be a really bad idea.
>   From Omar.
> 
> - Fix for an iostat regression fix in this series, using the wrong API
>   to get at the block queue. From Shaohua.
> 
> - Fix for a potential blktrace delection deadlock. From Waiman.
> 
> This is a reworked pull request, without the writeback series. The
> only oddball in here is the older buffered vs DIO bug fix, which
> isn't a strict regression, but something that arguably should have
> gone in a long time ago.
> 
> Please pull!
> 
> 
>   git://git.kernel.dk/linux-block.git for-linus

Just a heads up that I force pushed this out again. With the rebase,
I had 8 patches from the NVMe tree with me as a committer, but without
my signed-off-by. I corrected that. Diffstat and everything is the
same as before, just added sign offs.

-- 
Jens Axboe
