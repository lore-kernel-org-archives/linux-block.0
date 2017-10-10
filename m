Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 1/3] blk-stat: delete useless code
To: Shaohua Li <shli@kernel.org>, linux-block@vger.kernel.org
Cc: vgoyal@redhat.com, tj@kernel.org, Kernel-team@fb.com,
 Shaohua Li <shli@fb.com>, Omar Sandoval <osandov@fb.com>
References: <cover.1507337347.git.shli@fb.com>
 <74821887899a7d05c6429e03f0dc49a079c446b9.1507337347.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4b4db306-01a3-a138-26dd-38133703a8c3@kernel.dk>
Date: Tue, 10 Oct 2017 12:02:42 -0600
MIME-Version: 1.0
In-Reply-To: <74821887899a7d05c6429e03f0dc49a079c446b9.1507337347.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/06/2017 06:55 PM, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Fix two issues:
> - the per-cpu stat flush is unnecessary, nobody uses per-cpu stat except
>   sum it to global stat. We can do the calculation there. The flush just
>   wastes cpu time.
> - some fields are signed int/s64. I don't see the point.

Anecdotal, I had issues with the div yielding wrong results with
an unsigned type. But I don't remember what or why right now,
unfortunately, and this was before it was merged...

-- 
Jens Axboe
