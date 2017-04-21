Return-Path: <axboe@kernel.dk>
Subject: Re: for-4.12/block branch
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1492788745.2550.1.camel@sandisk.com>
 <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
 <1492792278.2550.5.camel@sandisk.com>
 <b248fae1-c51f-be03-d27c-a9730b65132a@fb.com>
 <1492792852.2550.7.camel@sandisk.com>
 <5e5870a4-bbff-8486-f28c-49127a9c60a5@fb.com>
 <fae5b2be-b18e-cb1c-675e-79869f678c7e@kernel.dk>
 <1492794346.2550.12.camel@sandisk.com>
 <b57a4bf4-5c70-8c10-476c-105907b09510@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5e6c31e1-1176-178e-5af3-7bf6aa46a7c4@kernel.dk>
Date: Fri, 21 Apr 2017 11:12:59 -0600
MIME-Version: 1.0
In-Reply-To: <b57a4bf4-5c70-8c10-476c-105907b09510@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/21/2017 11:07 AM, Jens Axboe wrote:
> On 04/21/2017 11:05 AM, Bart Van Assche wrote:
>> On Fri, 2017-04-21 at 10:56 -0600, Jens Axboe wrote:
>>> On 04/21/2017 10:48 AM, Jens Axboe wrote:
>>>> I wonder if it's an imbalance in the preempt count. Looking at it, it
>>>> looks like we're not clearing the alloc data. But I would think that
>>>> would potentially cause much worse problems, but maybe we got lucky?
>>>>
>>>> Let me generate a cleanup patch for that.
>>>
>>> Something like the below.
>>> [ ... ]
>>> +static inline void blk_mq_init_alloc_data(struct blk_mq_alloc_data *data,
>>> +					  unsigned int flags)
>>> +{
>>> +	data->q = NULL;
>>> +	data->flags = flags;
>>> +	data->shallow_depth = 0;
>>> +	data->ctx = NULL;
>>> +	data->hctx = NULL;
>>> +}
>>
>> Hello Jens,
>>
>> Maybe I'm overlooking something but I don't see how this patch can make
>> a difference since the compiler zero-initializes struct members that have
>> not been mentioned explicitly as designated initializers? A common way
>> to zero-initialize a struct is as follows:
>>
>> struct <struct_name> <variable_name> = { };
> 
> Maybe my memory is bad, but we're explicitly setting flags, but not doing
> a zero fill after that.
> 
> 	struct foo foo { .member = bla };
> 
> vs
> 
> 	struct foo foo { .member = bla, };
> 
> But you must be right, because this would barf all over the place with stack
> garbage otherwise. I'll double check I get the same generated code here...

It is of course me smoking crack. I think my recollection dates back to some
bug gcc had in that area, either with suboptimal fill/init, or just not doing
it. In any case, the current code is fine, which is good.

-- 
Jens Axboe
