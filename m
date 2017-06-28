Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX V2] block, bfq: update wr_busy_queues if needed on
 a queue split
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, Linux-Kernal <linux-kernel@vger.kernel.org>,
 ulf.hansson@linaro.org, broonie@kernel.org
References: <20170619114316.2587-1-paolo.valente@linaro.org>
 <8520D3AF-C161-439F-A7E8-A6B7202DA2D9@linaro.org>
 <e070788e-8a62-024d-7aac-8f8801722ffe@kernel.dk>
 <4AFF2E52-DCE4-4DC7-9CB0-849EEED3A9AB@linaro.org>
 <3b5987e2-fa11-af94-27f4-5760612c0f22@kernel.dk>
 <70E1F6F9-407A-4A43-9FC3-D6EBE2980026@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5489829a-1840-cb0c-cfda-d496959aae0a@kernel.dk>
Date: Wed, 28 Jun 2017 06:42:48 -0600
MIME-Version: 1.0
In-Reply-To: <70E1F6F9-407A-4A43-9FC3-D6EBE2980026@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 11:39 PM, Paolo Valente wrote:
> 
>> Il giorno 27 giu 2017, alle ore 20:29, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 06/27/2017 12:27 PM, Paolo Valente wrote:
>>>
>>>> Il giorno 27 giu 2017, alle ore 16:41, Jens Axboe <axboe@kernel.dk> ha scritto:
>>>>
>>>> On 06/27/2017 12:09 AM, Paolo Valente wrote:
>>>>>
>>>>>> Il giorno 19 giu 2017, alle ore 13:43, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>>>>>
>>>>>> This commit fixes a bug triggered by a non-trivial sequence of
>>>>>> events. These events are briefly described in the next two
>>>>>> paragraphs. The impatiens, or those who are familiar with queue
>>>>>> merging and splitting, can jump directly to the last paragraph.
>>>>>>
>>>>>> On each I/O-request arrival for a shared bfq_queue, i.e., for a
>>>>>> bfq_queue that is the result of the merge of two or more bfq_queues,
>>>>>> BFQ checks whether the shared bfq_queue has become seeky (i.e., if too
>>>>>> many random I/O requests have arrived for the bfq_queue; if the device
>>>>>> is non rotational, then random requests must be also small for the
>>>>>> bfq_queue to be tagged as seeky). If the shared bfq_queue is actually
>>>>>> detected as seeky, then a split occurs: the bfq I/O context of the
>>>>>> process that has issued the request is redirected from the shared
>>>>>> bfq_queue to a new non-shared bfq_queue. As a degenerate case, if the
>>>>>> shared bfq_queue actually happens to be shared only by one process
>>>>>> (because of previous splits), then no new bfq_queue is created: the
>>>>>> state of the shared bfq_queue is just changed from shared to non
>>>>>> shared.
>>>>>>
>>>>>> Regardless of whether a brand new non-shared bfq_queue is created, or
>>>>>> the pre-existing shared bfq_queue is just turned into a non-shared
>>>>>> bfq_queue, several parameters of the non-shared bfq_queue are set
>>>>>> (restored) to the original values they had when the bfq_queue
>>>>>> associated with the bfq I/O context of the process (that has just
>>>>>> issued an I/O request) was merged with the shared bfq_queue. One of
>>>>>> these parameters is the weight-raising state.
>>>>>>
>>>>>> If, on the split of a shared bfq_queue,
>>>>>> 1) a pre-existing shared bfq_queue is turned into a non-shared
>>>>>> bfq_queue;
>>>>>> 2) the previously shared bfq_queue happens to be busy;
>>>>>> 3) the weight-raising state of the previously shared bfq_queue happens
>>>>>> to change;
>>>>>> the number of weight-raised busy queues changes. The field
>>>>>> wr_busy_queues must then be updated accordingly, but such an update
>>>>>> was missing. This commit adds the missing update.
>>>>>>
>>>>>
>>>>> Hi Jens,
>>>>> any idea of the possible fate of this fix?
>>>>
>>>> I sort of missed this one. It looks trivial enough for 4.12, or we
>>>> can defer until 4.13. What do you think?
>>>>
>>>
>>> It should actually be something trivial, and hopefully correct,
>>> because a further throughput improvement (for BFQ), which depends on
>>> this fix, is now working properly, and we didn't see any regression so
>>> far.  In addition, since this improvement is virtually ready for
>>> submission, further steps may be probably easier if this fix gets in
>>> sooner (whatever the luck of the improvement will be).
>>
>> OK, let's queue it up for 4.13 then.
>>
> 
> My arguments was in favor of 4.12 actually.  Maybe you did mean 4.12
> here?

You were talking about further improvements and new development on top
of this, so I assumed you meant 4.13. However, further development is
not the main criteria or concern for whether this fix should go into
4.12 or not. The main concern is if this fixes something that is crucial
to have in 4.12. It's late in the cycle, I'd rather not push anything
that isn't a regression fix at this point.

-- 
Jens Axboe
