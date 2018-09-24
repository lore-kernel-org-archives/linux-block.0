Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 24 Sep 2018 10:31:48 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org
Subject: Re: [PATCH] block: use nanosecond resolution for iostat
Message-ID: <20180924173148.GA24295@vader>
References: <380a4e9ded4f0f81dacc343219cbc7e5b7d3be91.1537573435.git.osandov@fb.com>
 <6e054549-7ffa-2c97-7cad-814cbb962444@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6e054549-7ffa-2c97-7cad-814cbb962444@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 21, 2018 at 08:27:17PM -0600, Jens Axboe wrote:
> On 9/21/18 5:44 PM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Klaus Kusche reported that the I/O busy time in /proc/diskstats was not
> > updating properly on 4.18. This is because we started using ktime to
> > track elapsed time, and we convert nanoseconds to jiffies when we update
> > the partition counter. However, this gets rounded down, so any I/Os that
> > take less than a jiffy are not accounted for. Previously in this case,
> > the value of jiffies would sometimes increment while we were doing I/O,
> > so at least some I/Os were accounted for.
> > 
> > Let's convert the stats to use nanoseconds internally. We still report
> > milliseconds as before, now more accurately than ever. The value is
> > still truncated to 32 bits for backwards compatibility.
> 
> Thanks Omar, applied for 4.19.

Thanks, Jens. I also just pushed a regression test to blktests.
