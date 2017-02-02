Subject: Re: [PATCH 0/6] block: fix blk-mq debugfs vs. blktrace
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <cover.1485902856.git.osandov@fb.com>
Cc: kernel-team@fb.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <6ec81ae3-159f-999f-a3ea-0a245b8f2366@fb.com>
Date: Thu, 2 Feb 2017 10:20:49 -0700
MIME-Version: 1.0
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/31/2017 03:53 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When I moved the blk-mq debugging information to debugfs, I didn't
> realize that blktrace also created directories in debugfs that
> conflicted with the blk-mq directories. This series fixes that.
> 
> Patch 1 adds a new debugfs helper needed for patch 6. Greg, could I get
> an ack on that if it makes sense? Jens and I went back and forth on this
> for a little while, but patch 6 has more of the rationale on why we
> decided that this approach was the cleanest.
> 
> Patches 2 and 3 are cleanups.
> 
> Patch 4 is the first part of the fix, making blk-mq and blktrace use the
> same top-level "block" directory.
> 
> Patches 5 and 6 make blk-mq and blktrace play nicely with each other
> w.r.t. the debugfs "block/$dev" directories.
> 
> I tested this with multiple configurations, so hopefully I didn't mess
> that up this time.
> 
> Applies to for-4.11/block.

Applied with Greg's ack on the first patch, thanks Omar.

-- 
Jens Axboe
