Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: use nanosecond resolution for iostat
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, stable@vger.kernel.org
References: <380a4e9ded4f0f81dacc343219cbc7e5b7d3be91.1537573435.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6e054549-7ffa-2c97-7cad-814cbb962444@kernel.dk>
Date: Fri, 21 Sep 2018 20:27:17 -0600
MIME-Version: 1.0
In-Reply-To: <380a4e9ded4f0f81dacc343219cbc7e5b7d3be91.1537573435.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/21/18 5:44 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Klaus Kusche reported that the I/O busy time in /proc/diskstats was not
> updating properly on 4.18. This is because we started using ktime to
> track elapsed time, and we convert nanoseconds to jiffies when we update
> the partition counter. However, this gets rounded down, so any I/Os that
> take less than a jiffy are not accounted for. Previously in this case,
> the value of jiffies would sometimes increment while we were doing I/O,
> so at least some I/Os were accounted for.
> 
> Let's convert the stats to use nanoseconds internally. We still report
> milliseconds as before, now more accurately than ever. The value is
> still truncated to 32 bits for backwards compatibility.

Thanks Omar, applied for 4.19.

-- 
Jens Axboe
