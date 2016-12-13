Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933168AbcLMVxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 16:53:37 -0500
Subject: Re: [PATCHSET/RFC v2] blk-mq scheduling framework
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <9D1F7CB5-4043-448B-A553-D6A9804D5089@linaro.org>
 <20161213151739.GA32618@kernel.dk>
 <DB8071E8-E3C2-4DA1-9716-987D84C078C3@linaro.org>
 <a4a9d8fb-9239-da76-946c-4361785889ad@fb.com>
CC: <linux-block@vger.kernel.org>,
        Linux-Kernal <linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <b4a0fd3c-422e-2d23-bd8c-74bb0325b4fb@fb.com>
Date: Tue, 13 Dec 2016 14:51:27 -0700
MIME-Version: 1.0
In-Reply-To: <a4a9d8fb-9239-da76-946c-4361785889ad@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/13/2016 09:28 AM, Jens Axboe wrote:
>>> No worries, ask away if you have questions. As you might have seen, it's
>>> still a little bit of a moving target, but it's getting closer every
>>> day. I'll post a v3 later today hopefully that will be a good fix point
>>> for you. I'll need to add the io context setup etc, that's not there
>>> yet, as only cfq/bfq uses that.
>>>
>>
>> You anticipated the question that was worrying me more, how to handle
>> iocontexts :) I'll go on studying your patches while waiting for this
>> (last, right?) missing piece for bfq.
> 
> It's the last missing larger piece. We probably have a few hooks that
> BFQ/CFQ currently uses that aren't wired up yet in the elevator_ops for
> mq, so you'll probably have to do those as you go. I can take a look,
> but I would prefer if they be done one a as-needed basis. Perhaps we can
> get rid of some of them.

The current 'blk-mq-sched' branch has support for getting the IO
contexts setup, and assigned to requests. Only works off the task
io_context for now, we ignore anything set in the bio. But that's a
minor thing, generally it should work for you.

Note that the mq ops have different naming than the classic elevator
ops. For instance, the set_request/put_request are
get_rq_priv/put_rq_priv instead. Others are different as well. In
general, refer to mq-deadline.c for how the hooks work and you can
compare with deadline-iosched.c, since they are still very close.

Note that the io context linking uses the embedded queue lock,
q->queue_lock, whereas for other things you are free to use a lock
embedded in the your elevator data. Again, refer to mq-deadline, it uses
dd->lock to protect the hash/rbtree. If mq-deadline used io contexts, it
would manage those behind q->queue_lock.

-- 
Jens Axboe

