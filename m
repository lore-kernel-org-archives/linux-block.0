Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49535 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752043AbdATO00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 09:26:26 -0500
Date: Fri, 20 Jan 2017 07:26:18 -0700
From: Jens Axboe <axboe@fb.com>
To: Paolo Valente <paolo.valente@linaro.org>
CC: <linux-block@vger.kernel.org>,
        Linux-Kernal <linux-kernel@vger.kernel.org>, <osandov@fb.com>
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline
 IO scheduler
Message-ID: <20170120142618.GA18162@kernel.dk>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <2B1CBA75-606E-48FA-A2FC-A435FBB3968E@linaro.org>
 <048a5a0a-1793-4698-4bc0-213d36fad161@fb.com>
 <8191D993-76A7-47F9-AF5D-585B0EA1718B@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <8191D993-76A7-47F9-AF5D-585B0EA1718B@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 20 2017, Paolo Valente wrote:
> 
> > Il giorno 17 gen 2017, alle ore 03:47, Jens Axboe <axboe@fb.com> ha scritto:
> > 
> > On 12/22/2016 09:49 AM, Paolo Valente wrote:
> >> 
> >>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
> >>> 
> >>> This is basically identical to deadline-iosched, except it registers
> >>> as a MQ capable scheduler. This is still a single queue design.
> >>> 
> >> 
> >> One last question (for today ...):in mq-deadline there are no
> >> "schedule dispatch" or "unplug work" functions.  In blk, CFQ and BFQ
> >> do these schedules/unplugs in a lot of cases.  What's the right
> >> replacement?  Just doing nothing?
> > 
> > You just use blk_mq_run_hw_queue() or variants thereof to kick off queue
> > runs.
> > 
> 
> Hi Jens,
> I'm working on this right now.  I have a pair of quick questions about
> performance.
> 
> In the blk version of bfq, if the in-service bfq_queue happen to have
> no more budget when the bfq dispatch function is invoked, then bfq:
> returns no request (NULL), immediately expires the in-service
> bfq_queue, and schedules a new dispatch.  The third step is taken so
> that, if other bfq_queues have requests, then a new in-service
> bfq_queue will be selected on the upcoming new dispatch, and a new
> request will be provided right away.
> 
> My questions are: is this dispatch-schedule step still needed with
> blk-mq, to avoid a stall?  If it is not needed to avoid a stall, would
> it still be needed to boost throughput, because it would force an
> immediate, next dispatch?

Generally that step is only needed if you don't dispatch a request for
that invocation, yet you have requests to dispatch. For that case, you
must ensure that the queues are run at some point in the future. So I'm
inclined to answer yes to your question, though it depends on exactly
how it happens. If you have the queue run in the code, comment it like
that, and we can always revisit.

> BTW, bfq-mq survived its first request completion.  I will provide you
> with a link to a github branch as soon as bfq-mq seems able to stand
> up with a minimal workload.

Congratulations, that's a nice milestone!

-- 
Jens Axboe

