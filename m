Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq breaks suspend even with runtime PM patch
To: Greg KH <gregkh@linuxfoundation.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Mike Galbraith <efault@gmx.de>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5912148.iRCpNe8Dyb@natalenko.name>
 <1501391551.17388.31.camel@gmx.de> <1662218.y9oETEnj5A@natalenko.name>
 <20170808162252.GC23338@kroah.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <843d7ee7-63b9-d34c-6d91-dea0b940d330@kernel.dk>
Date: Tue, 8 Aug 2017 10:33:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170808162252.GC23338@kroah.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/08/2017 10:22 AM, Greg KH wrote:
> On Sun, Jul 30, 2017 at 03:50:15PM +0200, Oleksandr Natalenko wrote:
>> Hello Mike et al.
>>
>> On neděle 30. července 2017 7:12:31 CEST Mike Galbraith wrote:
>>> FWIW, first thing I'd do is update that 4.12.0 to 4.12.4, and see if
>>> stable fixed it.
>>
>> My build already includes v4.12.4.
>>
>>> If not, I'd find these two commits irresistible.
>>>
>>> 5f042e7cbd9eb blk-mq: Include all present CPUs in the default queue mapping
>>> 4b855ad37194f blk-mq: Create hctx for each present CPU
>>
>> I've applied these 2 commits, and cannot reproduce the issue anymore. Looks 
>> like a perfect hit, thanks!
>>
>>> 'course applying random upstream bits does come with some risk, trying
>>> a kernel already containing them has less "entertainment" potential. 
>>
>> Should you consider applying them to v4.12.x stable series? CC'ing Greg just 
>> in case.
> 
> I can queue these up if I get an ack from the developers/maintainers
> that it is ok to do so...

You can add those two commits to stable.

-- 
Jens Axboe
