Return-Path: <fthain@telegraphics.com.au>
Date: Sun, 14 Oct 2018 12:12:24 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Omar Sandoval <osandov@osandov.com>
cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
    kernel-team@fb.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
    Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 00/11] Convert floppy drivers to blk-mq
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
Message-ID: <alpine.LNX.2.21.1810141204260.8@nippy.intranet>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 11 Oct 2018, Omar Sandoval wrote:

> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> This series converts the various floppy drivers to blk-mq. Save for the
> last one (floppy), they're compile-tested only. If I've Cc'd you, it's
> because I think you might be able to test the changes. Please test if
> you can, or let me know if there's a way to use QEMU/some other emulator
> to test. The full series is available at [1]. Thanks!
> 

I built your mq-conversions branch (425e985d1937) and asked Stan to test 
this on his Centris 650. There are no regressions in the swim driver.

-- 

> Changes from v1:
> 
> - Drop "swim3: end whole request on error" and "floppy: end whole
>   request on error".
> - Handle errors on individual bios correctly in the other drivers.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Laurent Vivier <lvivier@redhat.com>
> 
> 1: https://github.com/osandov/linux/tree/mq-conversions.
> 
> Omar Sandoval (11):
>   swim: fix cleanup on setup error
>   swim: convert to blk-mq
>   swim3: add real error handling in setup
>   swim3: convert to blk-mq
>   amiflop: fold headers into C file
>   amiflop: clean up on errors during setup
>   amiflop: convert to blk-mq
>   ataflop: fold headers into C file
>   ataflop: fix error handling during setup
>   ataflop: convert to blk-mq
>   floppy: convert to blk-mq
> 
>  arch/m68k/include/asm/atafd.h    |  13 --
>  arch/m68k/include/asm/atafdreg.h |  80 --------
>  drivers/block/amiflop.c          | 328 +++++++++++++++++++------------
>  drivers/block/ataflop.c          | 283 +++++++++++++++-----------
>  drivers/block/floppy.c           |  74 ++++---
>  drivers/block/swim.c             | 114 ++++++-----
>  drivers/block/swim3.c            | 219 ++++++++++-----------
>  include/linux/amifd.h            |  63 ------
>  include/linux/amifdreg.h         |  82 --------
>  9 files changed, 590 insertions(+), 666 deletions(-)
>  delete mode 100644 arch/m68k/include/asm/atafd.h
>  delete mode 100644 arch/m68k/include/asm/atafdreg.h
>  delete mode 100644 include/linux/amifd.h
>  delete mode 100644 include/linux/amifdreg.h
> 
> 
