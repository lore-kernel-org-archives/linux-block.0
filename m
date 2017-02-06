Subject: Re: [PATCH] blk-mq-sched: (un)register elevator when (un)registering
 queue
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <ff62b5d76fa68f6595446d2a6c4aa13db4113d71.1486414181.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <a500ef13-7a40-acc6-25ad-14726c74a07c@fb.com>
Date: Mon, 6 Feb 2017 13:56:05 -0700
MIME-Version: 1.0
In-Reply-To: <ff62b5d76fa68f6595446d2a6c4aa13db4113d71.1486414181.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/06/2017 01:52 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> I noticed that when booting with a default blk-mq I/O scheduler, the
> /sys/block/*/queue/iosched directory was missing. However, switching
> after boot did create the directory. This is because we skip the initial
> elevator register/unregister when we don't have a ->request_fn(), but we
> should still do it for the ->mq_ops case.

Good catch Omar, applied.

-- 
Jens Axboe
