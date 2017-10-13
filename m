Return-Path: <axboe@kernel.dk>
Date: Fri, 13 Oct 2017 08:36:39 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 00/58] LightNVM updates for 4.15
Message-ID: <20171013143638.GA19833@kernel.dk>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 13 2017, Matias Bj�rling wrote:
> Hi Jens,
> 
> A couple of patches for 4.15.
> 
> Javier has improved garbage collection, statistics, memory pool usage,
> and added support for single LUN configurations. He also made a lot of
> bug fixes and cleanup patches.
> 
> Rakesh have been fixing up a lot of subsystem bugs with respect to
> loading and unloading pblk, cleanup of memory pools, and a couple of
> fixes spread across the lightnvm subsystem and pblk.
> 
> Hans has been looking into garbage collection, and shutting it
> down gracefully when pblk is unloaded.
> 
> Please pull from the for-4.15/for-jens branch or apply the patches
> posted with this thread:
> 
>    https://github.com/OpenChannelSSD/linux.git for-4.15/for-jens

Applied for 4.15, thanks.

-- 
Jens Axboe
