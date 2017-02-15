Return-Path: <linux+axboe=kernel.dk@armlinux.org.uk>
Date: Wed, 15 Feb 2017 09:55:39 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4] mmc: sdio: check the buffer address for sdio API
Message-ID: <20170215095539.GB27312@n2100.armlinux.org.uk>
References: <1486428890-28187-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqS+OgmweTySyer422TfkWZrXMrQeuiymQ0HjqiZAdJzg@mail.gmail.com>
 <3ab69e5c-e661-3011-cab4-3066024ecf36@kernel.dk>
 <20170214193457.GZ27312@n2100.armlinux.org.uk>
 <6e4cd1d2-9c35-fbce-e398-e7498514b930@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6e4cd1d2-9c35-fbce-e398-e7498514b930@rock-chips.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 15, 2017 at 12:12:47PM +0800, Shawn Lin wrote:
> Hi Russell,
> 
> On 2017/2/15 3:34, Russell King - ARM Linux wrote:
> >On Tue, Feb 14, 2017 at 09:18:43AM -0700, Jens Axboe wrote:
> >>The current situation seems like a bit of a mess. Why don't you have two
> >>entry points, one for DMA and one for PIO. If the caller doesn't know if
> >>he can use DMA, he'd better call the PIO variant. Either that, or audit
> >>all callers and ensure they do the right thing wrt having a dma capable
> >>buffer.
> >
> >It really shouldn't matter.  MMC interfaces are just like USB - you
> >have a host controller, which interfaces what is a multi-lane serial
> >bus to the system.  The SDIO card shouldn't care one bit whether
> >the host controller is using DMA or PIO.
> >
> >However, I think that the DMA vs PIO thing is actually misleading here,
> >that's really not the issue at all.
> >
> >Looking at the oops, I see it uses sdio_memcpy_toio().  Tracing that
> >code leads me to here:
> >
> >                for_each_sg(data.sg, sg_ptr, data.sg_len, i) {
> >                        sg_set_page(sg_ptr, virt_to_page(buf + (i * seg_size)),
> >                                        min(seg_size, left_size),
> >                                        offset_in_page(buf + (i * seg_size)));
> >
> >so the buffer that is passed into sdio_memcpy_toio() gets passed into
> >virt_to_page().
> >
> >Firstly, the fact that it's passed to virt_to_page() means that "buf"
> >must _only_ _ever_ be a lowmem address.  It can't ever be a vmalloc
> >address (virt_to_page() is invalid on anything but lowmem.)  Just like
> >certain kernel interfaces, passing pointers to memory of different types
> >from the one intended by the interface produces invalid results, and
> >that seems to be what's happening here.
> >
> >Secondly, it's a scatterlist, and scatterlists can be passed to DMA
> >mapping operations, which also implies that _if_ a host driver decides
> >to use DMA on it, the buffer better be DMA-able.
> >
> >Thirdly, while PIO may work (or even appear to work) because _maybe_
> >converting a vmalloc address to a ficticious struct page + offset, and
> >then converting that back again _might_ result in hitting the correct
> >memory, but it's not guaranteed to.
> >
> 
> [1]:
> If no DMA involved, the host drivers usually use memcpy or readl/writel
> to transfer the data between MMIO address and buffer coming from the
> caller. So, is it also not guaranteed when using memcpy or readl to
> transfer data between MMIO address and vmalloc/heap buffer?

The point here is, if buf is a vmalloc address:

	v = kmap_atomic(virt_to_page(buf))

v may be _anything_ at all.  The kmap_atomic() will be done by the MMC
host driver, the virt_to_page() is done by the code I quoted above.

v may be a lowmem page address.  v may be somewhere in userspace.  v may
be some device mapping.  v may be (if you're lucky) the same address as
"buf".  There's no guarantees what it will be.

Note that the scatterlist above does _not_ store the virtual address
that was passed into it, but only the struct page, offset and length.
So, drivers can not know what the original virtual address was.

> >I suspect that virt_to_page() + kmap_atomic() is likely to try to
> >dereference a struct page pointer that does not point at a legal entry
> >in the memmap arrays, and result in scribbling over some random part
> >of kernel memory.
> 
> If that is the fact, so what I am concerned mostly is that by
> seraching the APIs, sdio_writeb and sdio_readb, under the drivers/net
> /wireless/, I could see almost all sdio based WLAN drivers passed in
> a vmalloc area(actually when built as moudle, it should be located in
> MODULE range which also be included as vmalloc area, no?) or heap
> buffer.

sdio_readb() and sdio_writeb() convey the data in the command stream,
not the data stream.  Firstly, sdio_writeb() takes the actual value to
be written, so the memory storage is irrelevant (on many platforms, it
will be passed as a value in CPU registers.)  Eventually, it's written
into the MMC command structure as the command argument, which typically
ends up being written to a host controller register.

In the case of sdio_readb(), the returned value comes from the command
status, which is typically read from registers in the host controller.
mmc_io_rw_direct_host() writes the value to the passed address.  Hence,
the host controller, again, never sees the address.

> I assume my question[1] above is fine, then thanks to none of the mmc
> host drivers use DMA for sdio_writeb and sdio_readb since it only
> request one byte which didn't be fetched from host FIFO and the host
> controller HW didn't support this kind of request to use DMA(but may be
> not in the future). Otherwise, it may result in scribbling over some
> random part of kernel memory.

See above, your understanding of how sdio_readb() and sdio_writeb() is
not correct.  These are single value transfer functions, using
mmc_io_rw_direct() as the underlying method of access, and do not
transfer anything over the data lines.

These functions are quite different from sdio_memcpy_toio(),
sdio_memcpy_fromio(), sdio_readsb() and sdio_writesb(), which are
multiple value transfer functions, and these perform the transfer using
the data lines.  These use sdio_io_rw_ext_helper(), which then uses
mmc_io_rw_extended() to perform the transfer.  The code I quoted in my
original email is from mmc_io_rw_extended().

The command path is entirely separate from the data path in most MMC
host controllers.  The command path is commonly PIO, the data path is
commonly DMA, but host controllers _may_ choose PIO for small transfers
or when they have no DMA support.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
