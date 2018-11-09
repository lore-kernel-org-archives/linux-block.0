Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCHSET v2 0/2] Add queue_is_busy helper
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20181108160609.27568-1-axboe@kernel.dk>
 <4d006d91-449b-0b5b-cb1f-9dea90569093@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8a7b1a9b-7dfc-723f-6b9e-f6b6f5c4cde7@oracle.com>
Date: Fri, 9 Nov 2018 10:08:02 +0800
MIME-Version: 1.0
In-Reply-To: <4d006d91-449b-0b5b-cb1f-9dea90569093@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 11/9/18 9:53 AM, jianchao.wang wrote:
> Hi Jens
> 
> On 11/9/18 12:06 AM, Jens Axboe wrote:
>> DM currently uses atomic inc/dec to maintain a busy count of
>> IO on a given device. For the dm-mq path, we can replace this
>> with helper that just checks the state of the tags on the device.
>>
>> First patch is a prep patch that allows the iteration helpers
>> to return true/false, like we support internally in sbitmap.
>> For a busy check we don't care about how many requests are
>> busy, just if some are or not. Hence we can stop iterating
>> tags as soon as we find one that is allocated.
> 
> If we don't care about how many requests are busy, why not check
> sb->map[idex].word directly ? It could be more efficient.
> 

Oh, we need to check rq->q for the tag shared case.

> Thanks
> Jianchao
> 
