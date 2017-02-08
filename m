Return-Path: <scott.bauer@intel.com>
Date: Wed, 8 Feb 2017 15:12:21 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org, hch@lst.de,
	Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] block: sed-opal: reduce stack size of ioctl handler
Message-ID: <20170208221221.GA10983@sbauer-Z170X-UD5>
References: <20170208211546.2789607-1-arnd@arndb.de>
 <20170208215827.GA9733@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208215827.GA9733@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 08, 2017 at 02:58:28PM -0700, Scott Bauer wrote:
> On Wed, Feb 08, 2017 at 10:15:28PM +0100, Arnd Bergmann wrote:
> > When CONFIG_KASAN is in use, the sed_ioctl function uses unusually large stack,
> > as each possible ioctl argument gets its own stack area plus redzone:
> > 
> > block/sed-opal.c: In function 'sed_ioctl':
> > block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > 
> > Moving the copy_from_user() calls into the individual functions has little
> > effect on readablility, but significantly reduces the stack size, with the
> > largest individual function (opal_enable_disable_shadow_mbr) now at
> > reasonable 456 bytes.
> > 
> > Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> Hi Arnd,
> 
> Thank you for the report. We want to keep the function calls agnostic to userland.
> In the future we will have in-kernel callers and I don't want to have to do any
> get_fs(KERNEL_DS) wizardry.
> 
> Instead I think we can use a union to lessen the stack burden. I tested this patch just now
> with config_ksasan and was able to build.

Nack on this patch, it only really masks the issue. Keith pointed out we have a call chain
up to this ioctl then deeper down into nvme then the block layer. If we use 25% of the stack
just for this function it's still too dangerous and we'll run into corruption later on and not
remember this fix. I'll come up with another solution.
