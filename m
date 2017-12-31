Return-Path: <mail@maciej.szmigiero.name>
Subject: Re: [v2,4/6] pktcdvd: Check queue type before attaching to a queue
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "osandov@fb.com" <osandov@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>
References: <20170531214350.31157-5-bart.vanassche@sandisk.com>
 <d237f623-ce22-6360-306f-3460ddba25ef@maciej.szmigiero.name>
 <1514681596.11082.1.camel@wdc.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <4deef041-201d-a76b-b68e-e518135fffd7@maciej.szmigiero.name>
Date: Sun, 31 Dec 2017 02:23:54 +0100
MIME-Version: 1.0
In-Reply-To: <1514681596.11082.1.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 31.12.2017 01:53, Bart Van Assche wrote:
> On Sat, 2017-12-30 at 22:41 +0100, Maciej S. Szmigiero wrote:
>> This commit causes a NULL pointer dereference when adding a pktcdvd
>> mapping.
>>
>> Reproducing it is simple:
>> # pktsetup 1 /dev/cdrom 
>>
>> Specifically, the NULL dereference happens inside bdev_get_queue(bdev),
>> which is supposed to return bdev->bd_disk->queue, but in this case
>> bdev->bd_disk is NULL.
> 
> Would it be possible to test the two attached patches?

I've tested 4.14.10 with both applied and can confirm that the NULL
pointer dereference when adding a pktcdvd mapping no longer happens
then.

> Thanks,
> 
> Bart.
> 

Thanks,
Maciej
