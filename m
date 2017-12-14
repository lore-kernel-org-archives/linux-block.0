Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/6] blk-mq: protect completion path with RCU
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, oleg@redhat.com,
        peterz@infradead.org, kernel-team@fb.com, osandov@fb.com,
        linux-block@vger.kernel.org, hch@lst.de
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-2-tj@kernel.org>
 <402aea05-8d04-99e2-5e31-803d2423283d@oracle.com>
 <20171213161312.GS3919388@devbig577.frc2.facebook.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <6e83e240-6ea3-c1cf-6fb6-d9ecbc4d946a@oracle.com>
Date: Thu, 14 Dec 2017 10:09:42 +0800
MIME-Version: 1.0
In-Reply-To: <20171213161312.GS3919388@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 12/14/2017 12:13 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Dec 13, 2017 at 11:30:48AM +0800, jianchao.wang wrote:
>>> +	} else {
>>> +		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
>>> +		if (!blk_mark_rq_complete(rq))
>>> +			__blk_mq_complete_request(rq);
>>> +		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
>>
>> The __blk_mq_complete_request() could be executed in irq context. There should not be any 
>> sleeping operations in it. If just synchronize with the timeout path to ensure the aborted_gstate
>> to be seen, only rcu is needed here ,as well as the blk_mq_timeout_work.
> 
> Sure, but it's just a lot cleaner to use the same to protect both
> issue and completion; otherwise, whoever who wants to synchronize
> against them have to do awkward double rcu locking.
> 
It's fair. Thanks for your detailed response. That's really appreciated.
> Thanks.
> 
