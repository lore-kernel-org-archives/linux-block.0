Return-Path: <linux+axboe=kernel.dk@armlinux.org.uk>
Date: Tue, 14 Feb 2017 19:34:57 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4] mmc: sdio: check the buffer address for sdio API
Message-ID: <20170214193457.GZ27312@n2100.armlinux.org.uk>
References: <1486428890-28187-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqS+OgmweTySyer422TfkWZrXMrQeuiymQ0HjqiZAdJzg@mail.gmail.com>
 <3ab69e5c-e661-3011-cab4-3066024ecf36@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ab69e5c-e661-3011-cab4-3066024ecf36@kernel.dk>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 14, 2017 at 09:18:43AM -0700, Jens Axboe wrote:
> The current situation seems like a bit of a mess. Why don't you have two
> entry points, one for DMA and one for PIO. If the caller doesn't know if
> he can use DMA, he'd better call the PIO variant. Either that, or audit
> all callers and ensure they do the right thing wrt having a dma capable
> buffer.

It really shouldn't matter.  MMC interfaces are just like USB - you
have a host controller, which interfaces what is a multi-lane serial
bus to the system.  The SDIO card shouldn't care one bit whether
the host controller is using DMA or PIO.

However, I think that the DMA vs PIO thing is actually misleading here,
that's really not the issue at all.

Looking at the oops, I see it uses sdio_memcpy_toio().  Tracing that
code leads me to here:

                for_each_sg(data.sg, sg_ptr, data.sg_len, i) {
                        sg_set_page(sg_ptr, virt_to_page(buf + (i * seg_size)),
                                        min(seg_size, left_size),
                                        offset_in_page(buf + (i * seg_size)));

so the buffer that is passed into sdio_memcpy_toio() gets passed into
virt_to_page().

Firstly, the fact that it's passed to virt_to_page() means that "buf"
must _only_ _ever_ be a lowmem address.  It can't ever be a vmalloc
address (virt_to_page() is invalid on anything but lowmem.)  Just like
certain kernel interfaces, passing pointers to memory of different types
from the one intended by the interface produces invalid results, and
that seems to be what's happening here.

Secondly, it's a scatterlist, and scatterlists can be passed to DMA
mapping operations, which also implies that _if_ a host driver decides
to use DMA on it, the buffer better be DMA-able.

Thirdly, while PIO may work (or even appear to work) because _maybe_
converting a vmalloc address to a ficticious struct page + offset, and
then converting that back again _might_ result in hitting the correct
memory, but it's not guaranteed to.

I suspect that virt_to_page() + kmap_atomic() is likely to try to
dereference a struct page pointer that does not point at a legal entry
in the memmap arrays, and result in scribbling over some random part
of kernel memory.

So every way I look at this, the binary driver that Shawn downloaded
is buggy, whether the host controller uses PIO or DMA.

I bet if Shawn tries running it against a modern kernel with
CONFIG_DEBUG_VIRTUAL enabled, Shawn will get complaints backing up
my claim.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
