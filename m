Subject: Re: [PATCH] blk-mq: add random early detection I/O scheduler
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e9c15e2066177c3efdfe6d134cf9c80b5e8f8d1b.1491076459.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <cea23aca-e7b2-f35d-f064-d5e44a479977@fb.com>
Date: Sat, 1 Apr 2017 16:07:30 -0600
MIME-Version: 1.0
In-Reply-To: <e9c15e2066177c3efdfe6d134cf9c80b5e8f8d1b.1491076459.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/01/2017 01:55 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This patch introduces a new I/O scheduler based on the classic random
> early detection active queue management algorithm [1]. Random early
> detection is one of the simplest and most studied AQM algorithms for
> networking, but until now, it hasn't been applied to disk I/O
> scheduling.
> 
> When applied to network routers, RED probabilistically either marks
> packets with ECN or drops them, depending on the configuration. When
> dealing with disk I/O, POSIX does not have any mechanism with which to
> notify the caller that the disk is congested, so we instead only provide
> the latter strategy. Included in this patch is a minor change to the
> blk-mq to support this.

This is great work. If we combine this with a thin provisioning target,
we can even use this to save space on the backend. Better latencies,
AND lower disk utilization.

I'm tempted to just queue this up for this cycle and make it the default.

-- 
Jens Axboe
