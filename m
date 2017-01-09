Return-Path: <nikita.yoush@cogentembedded.com>
Return-Path: <nikita.yoush@cogentembedded.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Artemi Ivanov <artemi.ivanov@cogentembedded.com>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: blk_queue_bounce_limit() broken for mask=0xffffffff on 64bit archs
Message-ID: <632ad7f3-e837-a17c-5ba7-ed9800ba3ec0@cogentembedded.com>
Date: Mon, 9 Jan 2017 23:48:11 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi

There is a use cases when architecture is 64-bit but hardware supports
only DMA to lower 4G of address space. E.g. NVMe device on RCar PCIe host.

For such cases, it looks proper to call blk_queue_bounce_limit() with
mask set to 0xffffffff - thus making block layer to use bounce buffers
for any addresses beyond 4G.  To support that, architecture provides
GFP_DMA zone that covers exactly low 4G on arm64.

However setting this limit does not work:

  if (b_pfn < (min_t(u64, 0xffffffffUL, BLK_BOUNCE_HIGH) >> PAGE_SHIFT))
      dma = 1;

When mask is 0xffffffff that condition is false

  q->limits.bounce_pfn = max(max_low_pfn, b_pfn);

this line is executed and replaces any limit with end of memory (on
64bit arch all memory is low).


Not sure how to fix this properly. Any hints?
