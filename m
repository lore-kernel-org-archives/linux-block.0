Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 7/8] blk-wbt: add general throttling mechanism
To: Jan Kara <jack@suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-8-git-send-email-axboe@fb.com>
 <20161108133930.GQ32353@quack2.suse.cz> <20161108154109.GA2834@kernel.dk>
 <20161109084034.GY32353@quack2.suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, hch@lst.de
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <85a891d5-0eec-a051-702f-9aac13e13b03@kernel.dk>
Date: Wed, 9 Nov 2016 09:07:08 -0700
MIME-Version: 1.0
In-Reply-To: <20161109084034.GY32353@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/09/2016 01:40 AM, Jan Kara wrote:
>>> So for devices with write cache, you will completely drain the device
>>> before waking anybody waiting to issue new requests. Isn't it too strict?
>>> In particular may_queue() will allow new writers to issue new writes once
>>> we drop below the limit so it can happen that some processes will be
>>> effectively starved waiting in may_queue?
>>
>> It is strict, and perhaps too strict. In testing, it's the only method
>> that's proven to keep the writeback caching devices in check. It will
>> round robin the writers, if we have more, which isn't necessarily a bad
>> thing. Each will get to do a burst of depth writes, then wait for a new
>> one.
>
> Well, I'm more concerned about a situation where one writer does a
> bursty write and blocks sleeping in may_queue(). Another writer
> produces a steady flow of write requests so that never causes the
> write queue to completely drain but that writer also never blocks in
> may_queue() when it starts queueing after write queue has somewhat
> drained because it never submits many requests in parallel. In such
> case the first writer would get starved AFAIU.

I see what you are saying. I can modify the logic to ensure that if we
do have a waiter, we queue up others behind it. That should get rid of
that concern.

> Also I'm not sure why such logic for devices with writeback cache is
> needed. Sure the disk is fast to accept writes but if that causes long
> read latencies, we should scale down the writeback limits so that we
> eventually end up submitting only one write request anyway -
> effectively the same thing as limit=0 - won't we?

Basically we want to avoid getting into that situation. The problem with
write caching is that it takes a while for you to notice that anything
is wrong, and when you do, you are way down in the hole. That causes the
first violations to be pretty bad.

I'm fine with playing with this logic and improving it, but I'd rather
wait for a 2nd series for that.

-- 
Jens Axboe
