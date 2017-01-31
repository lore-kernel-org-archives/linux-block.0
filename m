Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 31 Jan 2017 08:32:58 -0700
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] lightnvm: 4.11 patches
Message-ID: <20170131153258.GA1515@kernel.dk>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 31 2017, Matias Bj�rling wrote:
> Hi Jens,
> 
> Here are the patches for the 4.11 window. The following changes have
> been made:
> 
>  - New ioctls for vectored I/Os. Now liblightnvm is fully supported and
>    applications can begin to use the liblightnvm API to integrate with
>    Open-Channel SSDs.
> 
>  - Merging of the general media manager with the lightnvm core. This
>    removes the need to instantiate the media manager before initializing
>    targets, and also eliminates the persistent metadata that was used
>    by gennvm.
> 
>  - Interface cleanups for target implementations. Enables pblk to be
>    simplified.
> 
>  - Fix memory leak on target creation failure.
> 
>  - Clean up end_io() path so that it follows the same approach as bio
>    structures to end ios.

Applied for 4.11, thanks.

-- 
Jens Axboe
