Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 06/16] mmc: core: replace waitqueue with worker
To: Adrian Hunter <adrian.hunter@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-7-linus.walleij@linaro.org>
 <00989e26-cdb9-48d7-2e46-ae6ef66e59a7@intel.com>
 <CACRpkdYOyEs8vxmPt1kGiKJrw8+16DyD8Nn=ke6mgxPaCQynCw@mail.gmail.com>
 <3fc89f9f-fbcf-113d-3644-b6c9dae003f0@intel.com>
 <8f1f3d4c-410c-2632-c776-4ced363bdb0d@kernel.dk>
 <e4b2c4bc-8627-2234-354d-c986f69b220f@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@linaro.org>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <97f2a4ea-0802-9f23-6ac7-b9d6c6afbfcc@kernel.dk>
Date: Mon, 13 Mar 2017 08:19:50 -0600
MIME-Version: 1.0
In-Reply-To: <e4b2c4bc-8627-2234-354d-c986f69b220f@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 03/13/2017 03:25 AM, Adrian Hunter wrote:
> On 11/03/17 00:05, Jens Axboe wrote:
>> On 03/10/2017 07:21 AM, Adrian Hunter wrote:
>>>> Essentially I take out that thread and replace it with this one worker
>>>> introduced in this very patch. I agree the driver can block in many ways
>>>> and that is why I need to have it running in process context, and this
>>>> is what the worker introduced here provides.
>>>
>>> The last time I looked at the blk-mq I/O scheduler code, it pulled up to
>>> qdepth requests from the I/O scheduler and left them on a local list while
>>> running ->queue_rq().  That means blocking in ->queue_rq() leaves some
>>> number of requests in limbo (not issued but also not in the I/O scheduler)
>>> for that time.
>>
>> Look again, if we're not handling the requeued dispatches, we pull one
>> at the time from the scheduler.
>>
> 
> That's good :-)
> 
> Now the next thing ;-)
> 
> It looks like we either set BLK_MQ_F_BLOCKING and miss the possibility of
> issuing synchronous requests immediately, or we don't set BLK_MQ_F_BLOCKING
> in which case we are never allowed to sleep in ->queue_rq().  Is that true?

Only one of those statements is true - if you don't set BLK_MQ_F_BLOCKING,
then you may never block in your ->queue_rq() function. But if you do set it,
it does not preclude immediate issue of sync requests.

-- 
Jens Axboe
