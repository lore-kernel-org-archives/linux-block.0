Return-Path: <nikita.yoush@cogentembedded.com>
Return-Path: <nikita.yoush@cogentembedded.com>
Subject: Re: blk_queue_bounce_limit() broken for mask=0xffffffff on 64bit
 archs
To: Ming Lei <tom.leiming@gmail.com>
References: <632ad7f3-e837-a17c-5ba7-ed9800ba3ec0@cogentembedded.com>
 <CACVXFVPgmaBh5OqjfTfqdQ9k78PWsmozuRZpSG5gMg84m4sDwQ@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Artemi Ivanov <artemi.ivanov@cogentembedded.com>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <303d9c92-d38e-7456-abeb-e1e5af9a3200@cogentembedded.com>
Date: Fri, 13 Jan 2017 09:10:37 +0300
MIME-Version: 1.0
In-Reply-To: <CACVXFVPgmaBh5OqjfTfqdQ9k78PWsmozuRZpSG5gMg84m4sDwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


>> There is a use cases when architecture is 64-bit but hardware supports
>> only DMA to lower 4G of address space. E.g. NVMe device on RCar PCIe host.
>>
>> For such cases, it looks proper to call blk_queue_bounce_limit() with
>> mask set to 0xffffffff - thus making block layer to use bounce buffers
>> for any addresses beyond 4G.  To support that, architecture provides
>> GFP_DMA zone that covers exactly low 4G on arm64.
>>
>> However setting this limit does not work:
>>
>>   if (b_pfn < (min_t(u64, 0xffffffffUL, BLK_BOUNCE_HIGH) >> PAGE_SHIFT))
>>       dma = 1;
>>
>> When mask is 0xffffffff that condition is false
> 
> That should have been true in your case, since the b_pfn is smaller than
> 0xffffffff.

b_pfn is exactly 0xffffffffUL >> SHIFT, thus contition is false

>>   q->limits.bounce_pfn = max(max_low_pfn, b_pfn);
>>
>> this line is executed and replaces any limit with end of memory (on
>> 64bit arch all memory is low).
> 
> I don't understand why max() is used? And why not min()?
> 
> Looks the above line just disables bounce for 64bit arch, doesn't it?

Effectively yes. And I don't understand logic behind this code.

Nikita
