Return-Path: <axboe@kernel.dk>
Date: Mon, 26 Jun 2017 16:29:21 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: mb@lightnvm.io, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 00/20] LightNVM: pblk patches for 4.13
Message-ID: <20170626222920.GA9175@kernel.dk>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 26 2017, Javier Gonz�lez wrote:
> Hi Matias,
> 
> Here you have the pblk patchset for this window.
> 
> Apart from small fixes for LightNVM core and pblk, there are three
> relevant changes:
> 
>  - Metadata for each line is no longer issued on a separate workqueue,
>    but instead, all I/Os are scheduled on the write thread. This allows
>    to have more control over LUN collisions. The result is that we can
>    use the full bandwidth of the device for user data. In the 4.12 pblk,
>    we use ~25% of the bandwidth for metadata.
> 
>  - The rate-limiter and GC have been tuned to keep the GC writer busy.
>    Also, capacity per line is guaranteed for GC I/O as we reach
>    capacity.
> 
>  - We have now a FTL state machine. This allows to fail gracefully to
>    user space in case of irrecoverable errors. This state machine will
>    be the base for the pblk's FTL log.
> 
> The patches apply into your for-4.13/core. You can also find them in:

Nope, they do not. Patch #7 fails, because it's not on top of the
bio_set changes that went in a week or two ago. I hand applied that one,
didn't find issues with the rest.

But please remember to ensure that it applies on top of the current
branch.

-- 
Jens Axboe
