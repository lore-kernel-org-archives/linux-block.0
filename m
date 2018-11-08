Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether to
 continue or not
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20181108160609.27568-1-axboe@kernel.dk>
 <20181108160609.27568-3-axboe@kernel.dk>
 <1541694515.196084.218.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8a340d9c-da15-90c9-760e-fb80fb2871b6@kernel.dk>
Date: Thu, 8 Nov 2018 09:31:48 -0700
MIME-Version: 1.0
In-Reply-To: <1541694515.196084.218.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 11/8/18 9:28 AM, Bart Van Assche wrote:
> On Thu, 2018-11-08 at 09:06 -0700, Jens Axboe wrote:
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -424,13 +424,15 @@ struct show_busy_params {
>>   * Note: the state of a request may change while this function is in progress,
>>   * e.g. due to a concurrent blk_mq_finish_request() call.
>>   */
>> -static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>> +static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>  {
> 
> Please update the kdoc header above hctx_show_busy_rq() such that it reflects
> the new behavior. I'm referring to the "will be called for each request" part.
> Otherwise this patch looks fine to me.

Took a look at the comment, and what do you want changed? There's no change
in behavior for hctx_show_busy_rq(), it loops all requests just like before.
We just return true to ensure we continue iterating.

-- 
Jens Axboe
