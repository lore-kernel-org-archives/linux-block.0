Return-Path: <shan.hai@oracle.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
To: Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang"
 <jianchao.w.wang@oracle.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <f6fcc94b-412c-1552-477e-ba0b0927006c@oracle.com>
 <20180410100422.GA14432@ming.t460p>
From: Shan Hai <shan.hai@oracle.com>
Message-ID: <f246c624-09f5-4a37-7e83-8e4fd27ee23a@oracle.com>
Date: Tue, 10 Apr 2018 20:04:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180410100422.GA14432@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2018年04月10日 18:04, Ming Lei wrote:
> On Tue, Apr 10, 2018 at 03:59:30PM +0800, jianchao.wang wrote:
>> Hi Bart
>>
>> On 04/10/2018 09:34 AM, Bart Van Assche wrote:
>>> If a completion occurs after blk_mq_rq_timed_out() has reset
>>> rq->aborted_gstate and the request is again in flight when the timeout
>>> expires then a request will be completed twice: a first time by the
>>> timeout handler and a second time when the regular completion occurs
>> Would you please detail more here about why the request could be completed twice ?
>>
>> Is it the scenario you described as below in https://marc.info/?l=linux-block&m=151796816127318
>>
>> The following race can occur between the code that resets the timer
>> and completion handling:
>> - The code that handles BLK_EH_RESET_TIMER resets aborted_gstate.
>> - A completion occurs and blk_mq_complete_request() calls
>>    __blk_mq_complete_request().
>> - The timeout code calls blk_add_timer() and that function sets the
>>    request deadline and adjusts the timer.
>> - __blk_mq_complete_request() frees the request tag.
>> - The timer fires and the timeout handler gets called for a freed
>>    request.
>> If yes, how does the timeout handler get the freed request when the tag has been freed ?
> Thinking of this patch further.
>
> The issue may not be a double completion issue, and it may be the
> following behaviour which breaks NVMe or other drivers easily:
>
> 1) there is long delay(synchronize_rcu()) between setting rq->aborted_gstate
> and handling the timeout by blk_mq_rq_timed_out().
>
> 2) during the long delay, the rq may be completed by hardware, then
> if the following timeout is handled as BLK_EH_RESET_TIMER, it is
> driver's bug, and driver's .timeout() may be confused about this
> behaviour, I guess.
>
> In theory this behaviour should exist in all these approaches,
> but just easier to trigger if long delay is introduced before handling
> timeout.

Or think it as below?


                    C                           C                C
+-----------------------------+---------------+-----------+
S                                   T F              E

Request life time line:
S: start
T: timed out
F: found (by timer), inflight but timed out because of a long delay
E: completed by timeout handler
C: regular completion

normal request completion time range: (S, T)
completion in (T, F) is fine since it's not inflight anymore
race window time range: (F, E)

if the delayed request is completed in (F, E) range then it could be 
completed
twice by the regular completion first and then the timeout handler.

Thanks
Shan Hai
> Thanks,
> Ming
