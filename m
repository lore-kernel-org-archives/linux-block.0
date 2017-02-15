Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:51670 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbdBOEMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2017 23:12:52 -0500
Subject: Re: [PATCH v4] mmc: sdio: check the buffer address for sdio API
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <1486428890-28187-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqS+OgmweTySyer422TfkWZrXMrQeuiymQ0HjqiZAdJzg@mail.gmail.com>
 <3ab69e5c-e661-3011-cab4-3066024ecf36@kernel.dk>
 <20170214193457.GZ27312@n2100.armlinux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <6e4cd1d2-9c35-fbce-e398-e7498514b930@rock-chips.com>
Date: Wed, 15 Feb 2017 12:12:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170214193457.GZ27312@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Russell,

On 2017/2/15 3:34, Russell King - ARM Linux wrote:
> On Tue, Feb 14, 2017 at 09:18:43AM -0700, Jens Axboe wrote:
>> The current situation seems like a bit of a mess. Why don't you have two
>> entry points, one for DMA and one for PIO. If the caller doesn't know if
>> he can use DMA, he'd better call the PIO variant. Either that, or audit
>> all callers and ensure they do the right thing wrt having a dma capable
>> buffer.
>
> It really shouldn't matter.  MMC interfaces are just like USB - you
> have a host controller, which interfaces what is a multi-lane serial
> bus to the system.  The SDIO card shouldn't care one bit whether
> the host controller is using DMA or PIO.
>
> However, I think that the DMA vs PIO thing is actually misleading here,
> that's really not the issue at all.
>
> Looking at the oops, I see it uses sdio_memcpy_toio().  Tracing that
> code leads me to here:
>
>                 for_each_sg(data.sg, sg_ptr, data.sg_len, i) {
>                         sg_set_page(sg_ptr, virt_to_page(buf + (i * seg_size)),
>                                         min(seg_size, left_size),
>                                         offset_in_page(buf + (i * seg_size)));
>
> so the buffer that is passed into sdio_memcpy_toio() gets passed into
> virt_to_page().
>
> Firstly, the fact that it's passed to virt_to_page() means that "buf"
> must _only_ _ever_ be a lowmem address.  It can't ever be a vmalloc
> address (virt_to_page() is invalid on anything but lowmem.)  Just like
> certain kernel interfaces, passing pointers to memory of different types
> from the one intended by the interface produces invalid results, and
> that seems to be what's happening here.
>
> Secondly, it's a scatterlist, and scatterlists can be passed to DMA
> mapping operations, which also implies that _if_ a host driver decides
> to use DMA on it, the buffer better be DMA-able.
>
> Thirdly, while PIO may work (or even appear to work) because _maybe_
> converting a vmalloc address to a ficticious struct page + offset, and
> then converting that back again _might_ result in hitting the correct
> memory, but it's not guaranteed to.
>

[1]:
If no DMA involved, the host drivers usually use memcpy or readl/writel
to transfer the data between MMIO address and buffer coming from the
caller. So, is it also not guaranteed when using memcpy or readl to
transfer data between MMIO address and vmalloc/heap buffer?

> I suspect that virt_to_page() + kmap_atomic() is likely to try to
> dereference a struct page pointer that does not point at a legal entry
> in the memmap arrays, and result in scribbling over some random part
> of kernel memory.

If that is the fact, so what I am concerned mostly is that by
seraching the APIs, sdio_writeb and sdio_readb, under the drivers/net
/wireless/, I could see almost all sdio based WLAN drivers passed in
a vmalloc area(actually when built as moudle, it should be located in
MODULE range which also be included as vmalloc area, no?) or heap
buffer.

I assume my question[1] above is fine, then thanks to none of the mmc
host drivers use DMA for sdio_writeb and sdio_readb since it only
request one byte which didn't be fetched from host FIFO and the host
controller HW didn't support this kind of request to use DMA(but may be
not in the future). Otherwise, it may result in scribbling over some
random part of kernel memory.

Actually we didn't see that issues before, so I think the actual
question should be if the buffer from heap or vmalloc will be used with 
DMA involved?


>
> So every way I look at this, the binary driver that Shawn downloaded
> is buggy, whether the host controller uses PIO or DMA.

So it's really more dangerous that we were/are taking risking of
scribbling over some memory belonging to other code even if using
PIO if it also not guaranteed to use heap/vmalloc buffer..

>
> I bet if Shawn tries running it against a modern kernel with
> CONFIG_DEBUG_VIRTUAL enabled, Shawn will get complaints backing up
> my claim.
>
