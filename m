Return-Path: <axboe@kernel.dk>
Subject: Re: [416 PATCH 00/13] Bcache changes for 4.16
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20180108202130.31303-1-mlyle@lyle.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0692a21d-8465-9c1e-93a5-cf96dfb36cda@kernel.dk>
Date: Mon, 8 Jan 2018 13:42:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180108202130.31303-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/8/18 1:21 PM, Michael Lyle wrote:
> Jens,
> 
> Please pick up the following reviewed changes for 4.16.  There's some
> small cleanliness changes, a few minor bug fixes (some in preparation
> for larger work), and ongoing work on writeback performance:
> 
>  11 files changed, 303 insertions(+), 133 deletions(-)
> 
> Coly Li (2):
>       bcache: reduce cache_set devices iteration by devices_max_used
>       bcache: fix misleading error message in bch_count_io_errors()
> 
> Kent Overstreet (2):
>       bcache: Fix, improve efficiency of closure_sync()
>       bcache: mark closure_sync() __sched
> 
> Michael Lyle (3):
>       bcache: writeback: properly order backing device IO
>       bcache: allow quick writeback when backing idle
>       bcache: fix writeback target calc on large devices
> 
> Rui Hua (1):
>       bcache: ret IOERR when read meets metadata error
> 
> Tang Junhui (3):
>       bcache: stop writeback thread after detaching
>       bcache: segregate flash only volume write streams
>       bcache: fix wrong return value in bch_debug_init()
> 
> Vasyl Gomonovych (1):
>       bcache: Use PTR_ERR_OR_ZERO()
> 
> Zhai Zhaoxuan (1):
>       bcache: fix unmatched generic_end_io_acct() & generic_start_io_acct()

Looks good, thanks Mike. Applied for 4.16.

-- 
Jens Axboe
