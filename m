Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq breaks suspend even with runtime PM patch
To: Mike Galbraith <efault@gmx.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5912148.iRCpNe8Dyb@natalenko.name>
 <1501391551.17388.31.camel@gmx.de> <1662218.y9oETEnj5A@natalenko.name>
 <20170808162252.GC23338@kroah.com> <1502210041.7877.5.camel@gmx.de>
 <20170808164400.GC7415@kroah.com> <1502211054.7877.9.camel@gmx.de>
 <1502217234.9604.26.camel@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f454297b-1557-4e81-0e78-e40fd9c444c7@kernel.dk>
Date: Tue, 8 Aug 2017 12:35:07 -0600
MIME-Version: 1.0
In-Reply-To: <1502217234.9604.26.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/08/2017 12:33 PM, Mike Galbraith wrote:
> On Tue, 2017-08-08 at 18:50 +0200, Mike Galbraith wrote:
>> On Tue, 2017-08-08 at 09:44 -0700, Greg KH wrote:
>>>
>>> Should these go back farther than 4.12?  Looks like they apply cleanly
>>> to 4.9, didn't look older than that...
>>
>> I met prerequisites at 4.11...
> 
> FWIW, I took/modified 2d0364c8c1a9.  Dunno if the suspend regression
> exists in 4.11 though, without which you'll likely want nothing.

It does exist, the only change here is that we default people to
scsi-mq in 4.12+. Honestly, nobody complained since we've had scsi-mq,
so I could pivot both ways on whether we really need the changes in
earlier versions or not.

-- 
Jens Axboe
