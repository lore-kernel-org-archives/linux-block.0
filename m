Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 7/8] blk-wbt: add general throttling mechanism
To: Jan Kara <jack@suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-8-git-send-email-axboe@fb.com>
 <20161108133930.GQ32353@quack2.suse.cz> <20161108154109.GA2834@kernel.dk>
 <20161109084034.GY32353@quack2.suse.cz>
 <85a891d5-0eec-a051-702f-9aac13e13b03@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, hch@lst.de
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <51810355-fba4-5939-4365-a2586033133c@kernel.dk>
Date: Wed, 9 Nov 2016 12:52:59 -0700
MIME-Version: 1.0
In-Reply-To: <85a891d5-0eec-a051-702f-9aac13e13b03@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/09/2016 09:07 AM, Jens Axboe wrote:
> On 11/09/2016 01:40 AM, Jan Kara wrote:
>>>> So for devices with write cache, you will completely drain the device
>>>> before waking anybody waiting to issue new requests. Isn't it too
>>>> strict?
>>>> In particular may_queue() will allow new writers to issue new writes
>>>> once
>>>> we drop below the limit so it can happen that some processes will be
>>>> effectively starved waiting in may_queue?
>>>
>>> It is strict, and perhaps too strict. In testing, it's the only method
>>> that's proven to keep the writeback caching devices in check. It will
>>> round robin the writers, if we have more, which isn't necessarily a bad
>>> thing. Each will get to do a burst of depth writes, then wait for a new
>>> one.
>>
>> Well, I'm more concerned about a situation where one writer does a
>> bursty write and blocks sleeping in may_queue(). Another writer
>> produces a steady flow of write requests so that never causes the
>> write queue to completely drain but that writer also never blocks in
>> may_queue() when it starts queueing after write queue has somewhat
>> drained because it never submits many requests in parallel. In such
>> case the first writer would get starved AFAIU.
>
> I see what you are saying. I can modify the logic to ensure that if we
> do have a waiter, we queue up others behind it. That should get rid of
> that concern.

I added that - if we currently have a waiter, we'll add ourselves to the
back of the waitqueue and wait.

-- 
Jens Axboe
