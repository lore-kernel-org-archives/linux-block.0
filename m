Return-Path: <shli@kernel.org>
Date: Wed, 18 Oct 2017 22:13:52 -0700
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 0/3] block/loop: handle discard/zeroout error
Message-ID: <20171019051352.dkmnbx36krrvdagc@kernel.org>
References: <cover.1507072136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1507072136.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 07:52:42AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Fix some problems when setting up loop device with a block device as back file
> and create/mount ext4 in the loop device.

Jens,
can you look at these patches?

Thanks,
Shaohua
> 
> Thanks,
> Shaohua
> 
> Shaohua Li (3):
>   block/loop: don't hijack error number
>   block/loop: use FALLOC_FL_ZERO_RANGE for REQ_OP_WRITE_ZEROES
>   block: don't print message for discard error
> 
>  block/blk-core.c     | 2 ++
>  drivers/block/loop.c | 9 ++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> -- 
> 2.9.5
> 
