Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/5] Five small zoned block device patches
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180615215521.27435-1-bart.vanassche@wdc.com>
 <df519ecb-f945-0600-78ab-b81d55125268@kernel.dk>
 <1e6d378396dd44b1eb6945acb94b6d3988d4d32f.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dc5afd29-8586-c048-3e00-3a9b17ca861b@kernel.dk>
Date: Sat, 16 Jun 2018 15:00:13 -0600
MIME-Version: 1.0
In-Reply-To: <1e6d378396dd44b1eb6945acb94b6d3988d4d32f.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/16/18 2:58 PM, Bart Van Assche wrote:
> On Sat, 2018-06-16 at 12:27 -0600, Jens Axboe wrote:
>> On 6/15/18 3:55 PM, Bart Van Assche wrote:
>>> Hello Jens,
>>>
>>> In this patch series there are five patches with small improvements for the
>>> zoned block device code. Please consider these patches for the upstream kernel.
>>
>> Looks fine to me. Are you thinking 4.18 or 4.19?
> 
> Hello Jens,
> 
> I'm fine with either kernel version. These patches do not change any
> functionality so queuing these patches is not urgent. However, the sooner
> these get upstream the lower the change that any bug fixes that touch the
> same code conflict with this patch series ...

I like them all as cleanups, but as cleanups I think we should queue them
up for 4.19. I'll do that.

-- 
Jens Axboe
