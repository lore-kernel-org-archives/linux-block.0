Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 29 Sep 2018 15:24:35 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 4.19-rc6
Message-ID: <20180929222435.GD23365@kroah.com>
References: <7a9020a9-171b-3ef0-cb49-0c157ca9902b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a9020a9-171b-3ef0-cb49-0c157ca9902b@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 29, 2018 at 03:12:25PM -0600, Jens Axboe wrote:
> Hi Greg,
> 
> A set of fixes that should go into this release. This pull request
> contains:
> 
> - A fix (hopefully) for the persistent grants for xen-blkfront. A
>   previous fix from this series wasn't complete, hence reverted, and
>   this one should hopefully be it. (Boris Ostrovsky)
> 
> - Fix for an elevator drain warning with SMR devices, which is triggered
>   when you switch schedulers (Damien)
> 
> - bcache deadlock fix (Guoju Fang)
> 
> - Fix for the block unplug tracepoint, which has had the timer/explicit
>   flag reverted since 4.11 (Ilya)
> 
> - Fix a regression in this series where the blk-mq timeout hook is
>   invoked with the RCU read lock held, hence preventing it from blocking
>   (Keith)
> 
> - NVMe pull from Christoph, with a single multipath fix (Susobhan Dey)
> 
> Please pull!
> 
> 
>   git://git.kernel.dk/linux-block.git tags/for-linus-20180929

Now pulled, thanks.

greg k-h
