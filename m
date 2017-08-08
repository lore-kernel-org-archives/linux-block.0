Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 8 Aug 2017 15:28:07 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com
Subject: Re: [PATCH 1/6] blk-mq-tag: check for NULL rq when iterating tags
Message-ID: <20170808222807.GC4072@vader.DHCP.thefacebook.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-2-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501859062-11120-2-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:04:17AM -0600, Jens Axboe wrote:
> Since we introduced blk-mq-sched, the tags->rqs[] array has been
> dynamically assigned. So we need to check for NULL when iterating,
> since there's a window of time where the bit is set, but we haven't
> dynamically assigned the tags->rqs[] array position yet.
> 
> This is perfectly safe, since the memory backing of the request is
> never going away while the device is alive.

Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
