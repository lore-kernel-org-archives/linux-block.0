Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether to
 continue or not
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20181108160609.27568-1-axboe@kernel.dk>
 <20181108160609.27568-3-axboe@kernel.dk>
 <1541694515.196084.218.camel@acm.org>
 <8a340d9c-da15-90c9-760e-fb80fb2871b6@kernel.dk>
 <1541698519.196084.225.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c4ce645a-1e09-02eb-ca41-088e83a55cd8@kernel.dk>
Date: Thu, 8 Nov 2018 10:47:35 -0700
MIME-Version: 1.0
In-Reply-To: <1541698519.196084.225.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 11/8/18 10:35 AM, Bart Van Assche wrote:
> On Thu, 2018-11-08 at 09:31 -0700, Jens Axboe wrote:
>> On 11/8/18 9:28 AM, Bart Van Assche wrote:
>>> On Thu, 2018-11-08 at 09:06 -0700, Jens Axboe wrote:
>>>> --- a/block/blk-mq-debugfs.c
>>>> +++ b/block/blk-mq-debugfs.c
>>>> @@ -424,13 +424,15 @@ struct show_busy_params {
>>>>   * Note: the state of a request may change while this function is in progress,
>>>>   * e.g. due to a concurrent blk_mq_finish_request() call.
>>>>   */
>>>> -static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>>> +static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>>>  {
>>>
>>> Please update the kdoc header above hctx_show_busy_rq() such that it reflects
>>> the new behavior. I'm referring to the "will be called for each request" part.
>>> Otherwise this patch looks fine to me.
>>
>> Took a look at the comment, and what do you want changed? There's no change
>> in behavior for hctx_show_busy_rq(), it loops all requests just like before.
>> We just return true to ensure we continue iterating.
> 
> Oops, I added my reply below the wrong function. I wanted to refer to the
> following comment above blk_mq_queue_tag_busy_iter():
> 
>  * @fn:		Pointer to the function that will be called for each request
> 
> Additionally, how about similar comments above bt_for_each(), bt_tags_for_each()
> blk_mq_all_tag_busy_iter() and blk_mq_tagset_busy_iter()? I think this patch
> affects all these functions.

Fair enough, I'll add a documentation patch. Didn't consider it a big deal
since this is how it's always worked internally, but we haven't exposed
this break/continue functionality outside the sbitmap core until now.

-- 
Jens Axboe
