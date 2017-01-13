Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <632ad7f3-e837-a17c-5ba7-ed9800ba3ec0@cogentembedded.com>
References: <632ad7f3-e837-a17c-5ba7-ed9800ba3ec0@cogentembedded.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 13 Jan 2017 14:07:57 +0800
Message-ID: <CACVXFVPgmaBh5OqjfTfqdQ9k78PWsmozuRZpSG5gMg84m4sDwQ@mail.gmail.com>
Subject: Re: blk_queue_bounce_limit() broken for mask=0xffffffff on 64bit archs
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Artemi Ivanov <artemi.ivanov@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi,

On Tue, Jan 10, 2017 at 4:48 AM, Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> Hi
>
> There is a use cases when architecture is 64-bit but hardware supports
> only DMA to lower 4G of address space. E.g. NVMe device on RCar PCIe host.
>
> For such cases, it looks proper to call blk_queue_bounce_limit() with
> mask set to 0xffffffff - thus making block layer to use bounce buffers
> for any addresses beyond 4G.  To support that, architecture provides
> GFP_DMA zone that covers exactly low 4G on arm64.
>
> However setting this limit does not work:
>
>   if (b_pfn < (min_t(u64, 0xffffffffUL, BLK_BOUNCE_HIGH) >> PAGE_SHIFT))
>       dma = 1;
>
> When mask is 0xffffffff that condition is false

That should have been true in your case, since the b_pfn is smaller than
0xffffffff.

>
>   q->limits.bounce_pfn = max(max_low_pfn, b_pfn);
>
> this line is executed and replaces any limit with end of memory (on
> 64bit arch all memory is low).

I don't understand why max() is used? And why not min()?

Looks the above line just disables bounce for 64bit arch, doesn't it?

Thanks,
Ming

>
>
> Not sure how to fix this properly. Any hints?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
