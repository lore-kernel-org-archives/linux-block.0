Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: bio_check_eod() needs to consider partition
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "jiufei.xue@linux.alibaba.com" <jiufei.xue@linux.alibaba.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180313091819.26881-1-hch@lst.de>
 <7c4181b7-788f-bf90-8397-c09beceedcb7@kernel.dk>
 <1520958339.2638.8.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <315d98a1-7ade-4d8c-a71d-7716d27413ac@kernel.dk>
Date: Tue, 13 Mar 2018 10:37:05 -0700
MIME-Version: 1.0
In-Reply-To: <1520958339.2638.8.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/13/18 9:25 AM, Bart Van Assche wrote:
> On Tue, 2018-03-13 at 07:49 -0700, Jens Axboe wrote:
>> On 3/13/18 2:18 AM, Christoph Hellwig wrote:
>>> bio_check_eod() should check partiton size not the whole disk if
>>> bio->bi_partno is non-zero.  Does this by taking the call to bio_check_eod
>>> into blk_partition_remap.
>>
>> Applied, thanks.
> 
> Hello Christoph and Jens,
> 
> I think that this patch introduces a severe regression: with this patch applied
> a VM that I use for kernel testing doesn't boot anymore. If I revert this patch
> that VM boots fine again. This is what I see on the serial console with this
> patch applied:
> 
> virtio_blk virtio4: [vda] 41943040 512-byte logical blocks (21.5 GB/20.0 GiB)
>  vda: vda1
> attempt to access beyond end of device
> vda: rw=0, want=41940872, limit=41938944
> attempt to access beyond end of device
> vda: rw=0, want=41940872, limit=41938944

I've killed the patch for now, thanks for the quick test, Bart.

-- 
Jens Axboe
