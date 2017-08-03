Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] blk-mq-tag: check for NULL rq when iterating tags
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-2-git-send-email-axboe@kernel.dk>
 <1501792140.2922.14.camel@wdc.com>
 <549d568a-b32a-5d6c-7788-3f26a2ce58a2@kernel.dk>
 <b1c18f36-87ea-fee8-e88b-03ecdfdf22af@kernel.dk>
 <1501793402.2922.20.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5bb23d5d-2d09-333f-5570-a0f9925cd44c@kernel.dk>
Date: Thu, 3 Aug 2017 14:56:45 -0600
MIME-Version: 1.0
In-Reply-To: <1501793402.2922.20.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/03/2017 02:50 PM, Bart Van Assche wrote:
> On Thu, 2017-08-03 at 14:40 -0600, Jens Axboe wrote:
>> On 08/03/2017 02:35 PM, Jens Axboe wrote:
>>>> I agree with what you wrote in the description of this patch.
>>>> However, since I have not yet found the code that clears tags->rqs[],
>>>> would it be possible to show me that code?
>>>
>>> Since it's been a month since I wrote this code, I went and looked
>>> too.  My memory was that we set/clear it dynamically since we added
>>> scheduling, but looks like we don't clear it. The race is still valid
>>> for when someone runs a tag check in parallel with someone allocating
>>> a tag, since there's a window of time where the tag bit is set, but
>>> ->rqs[tag] isn't set yet. That's probably the race I hit, not the
>>> completion race mentioned in the change log.
>>
>> Rewrote the commit message:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=mq-inflight&id=1908e43118e688e41ac8656edcf3e7a150f3f5081
> 
> Hello Jens,
> 
> This is what I found in the updated commit:
> 
>     blk-mq-tag: check for NULL rq when iterating tags
>     
>     Since we introduced blk-mq-sched, the tags->rqs[] array has been
>     dynamically assigned. So we need to check for NULL when iterating,
>     since there's a window of time where the bit is set, but we haven't
>     dynamically assigned the tags->rqs[] array position yet.
>     
>     This is perfectly safe, since the memory backing of the request is
>     never going away while the device is alive.
> 
> Does this mean that blk_mq_tagset_busy_iter() can skip requests that it
> shouldn't skip and also that blk_mq_tagset_busy_iter() can pass a pointer to
> the previous request that was associated with a tag instead of the current
> request to its busy_tag_iter_fn argument? Shouldn't these races be fixed,
> e.g. by swapping the order in which the tag are set and tags->rqs[] are
> assigned such that the correct request pointer is passed to the
> busy_tag_iter_fn argument?

We can't swap them. We need to reserve a bit first, which entails
setting that bit. Once that's set, we can assign ->rqs[]. The race isn't
a big deal, and I don't want to add any code to prevent it, since that
would mean locking. Since we have the luxury of the request itself
always being valid memory, we can deal with stale info or having a NULL
because of the ordering. It's a conscious trade off.

-- 
Jens Axboe
