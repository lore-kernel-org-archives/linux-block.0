Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 15 Oct 2018 10:19:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 00/11] Convert floppy drivers to blk-mq
Message-ID: <20181015171905.GA23044@vader>
References: <cover.1539284959.git.osandov@fb.com>
 <alpine.LNX.2.21.1810141204260.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.21.1810141204260.8@nippy.intranet>
List-ID: <linux-block@vger.kernel.org>

On Sun, Oct 14, 2018 at 12:12:24PM +1100, Finn Thain wrote:
> On Thu, 11 Oct 2018, Omar Sandoval wrote:
> 
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Hi,
> > 
> > This series converts the various floppy drivers to blk-mq. Save for the
> > last one (floppy), they're compile-tested only. If I've Cc'd you, it's
> > because I think you might be able to test the changes. Please test if
> > you can, or let me know if there's a way to use QEMU/some other emulator
> > to test. The full series is available at [1]. Thanks!
> > 
> 
> I built your mq-conversions branch (425e985d1937) and asked Stan to test 
> this on his Centris 650. There are no regressions in the swim driver.

Thanks for testing :) I'm pretty impressed that it's still possible to
run Linux on those at all.
