Subject: Re: [PATCH v3 1/8] blk-mq: use the right hctx when getting a driver
 tag fails
To: Ming Lei <minlei@redhat.com>, Omar Sandoval <osandov@osandov.com>
References: <cover.1491418411.git.osandov@fb.com>
 <d1b5da71a5cba1f17d4eaafb207547a4651f81a9.1491418411.git.osandov@fb.com>
 <20170406043108.GA29955@ming.t460p> <20170406075751.GA15461@vader>
 <20170406082330.GA3863@ming.t460p>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <000e804d-fa00-d248-a3ce-dcbebc34cda9@fb.com>
Date: Thu, 6 Apr 2017 13:29:26 -0600
MIME-Version: 1.0
In-Reply-To: <20170406082330.GA3863@ming.t460p>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/06/2017 02:23 AM, Ming Lei wrote:
> On Thu, Apr 06, 2017 at 12:57:51AM -0700, Omar Sandoval wrote:
>> On Thu, Apr 06, 2017 at 12:31:18PM +0800, Ming Lei wrote:
>>> On Wed, Apr 05, 2017 at 12:01:29PM -0700, Omar Sandoval wrote:
>>>> From: Omar Sandoval <osandov@fb.com>
>>>>
>>>> While dispatching requests, if we fail to get a driver tag, we mark the
>>>> hardware queue as waiting for a tag and put the requests on a
>>>> hctx->dispatch list to be run later when a driver tag is freed. However,
>>>> blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
>>>> queues if using a single-queue scheduler with a multiqueue device. If
>>>
>>> It can't perform well by using a SQ scheduler on a MQ device, so just be
>>> curious why someone wants to do that in this way,:-)
>>
>> I don't know why anyone would want to, but it has to work :) The only
>> reason we noticed this is because when the NBD device is created, it
>> only has a single queue, so we automatically assign mq-deadline to it.
>> Later, we update the number of queues, but it's still using mq-deadline.
>>
>>> I guess you mean that ops.mq.dispatch_request() may dispatch requests
>>> from other hardware queues in blk_mq_sched_dispatch_requests() instead
>>> of current hctx.
>>
>> Yup, that's right. It's weird, and I talked to Jens about just forcing
>> the MQ device into an SQ mode when using an SQ scheduler, but this way
>> works fine more or less.
> 
> Or just switch the elevator to the MQ default one when the device becomes
> MQ? Or let mq-deadline's .dispatch_request() just return reqs in current
> hctx?

No, that would be a really bad idea imho. First of all, I don't want
kernel driven scheduler changes. Secondly, the framework should work
with a non-direct mapping between hardware dispatch queues and
scheduling queues.

While we could force a single queue usage to make that a 1:1 mapping
always, that loses big benefits on eg nbd, which uses multiple hardware
queues to up the bandwidth. Similarly on nvme, for example, we still
scale better with N submission queues and 1 scheduling queue compared to
having just 1 submission queue.

>>> If that is true, it looks like a issue in usage of I/O scheduler, since
>>> the mq-deadline scheduler just queues requests in one per-request_queue
>>> linked list, for MQ device, the scheduler queue should have been per-hctx.
>>
>> That's an option, but that's a different scheduling policy. Again, I
>> agree that it's strange, but it's reasonable behavior.
> 
> IMO, the current mq-deadline isn't good/ready for MQ device, and it
> doesn't make sense to use it for MQ.

I don't think that's true at all. I do agree that it's somewhat quirky
since it does introduce scheduling dependencies between the hardware
queues, and we have to work at making that well understood and explicit,
as not to introduce bugs due to that. But in reality, all multiqueue
hardware we are deadling with are mapped to a single resource. As such,
it makes a lot of sense to schedule it as such. Hence I don't think that
a single queue deadline approach is necessarily a bad idea for even fast
storage.

-- 
Jens Axboe
