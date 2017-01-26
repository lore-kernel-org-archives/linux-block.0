Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56011 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751880AbdAZVAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 16:00:43 -0500
Subject: Re: [PATCH 5/5] blk-mq-sched: change ->dispatch_requests() to
 ->dispatch_request()
To: Omar Sandoval <osandov@osandov.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-6-git-send-email-axboe@fb.com>
 <20170126205401.GE21449@vader.DHCP.thefacebook.com>
CC: <linux-block@vger.kernel.org>, <bart.vanassche@sandisk.com>,
        <hch@lst.de>, <osandov@fb.com>, <paolo.valente@linaro.org>,
        <hare@suse.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <23e5ff92-f909-7d80-ac65-34913cd9310c@fb.com>
Date: Thu, 26 Jan 2017 13:59:23 -0700
MIME-Version: 1.0
In-Reply-To: <20170126205401.GE21449@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/26/2017 01:54 PM, Omar Sandoval wrote:
> On Thu, Jan 26, 2017 at 12:48:18PM -0700, Jens Axboe wrote:
>> When we invoke dispatch_requests(), the scheduler empties everything
>> into the passed in list. This isn't always a good thing, since it
>> means that we remove items that we could have potentially merged
>> with.
>>
>> Change the function to dispatch single requests at the time. If
>> we do that, we can backoff exactly at the point where the device
>> can't consume more IO, and leave the rest with the scheduler for
>> better merging and future dispatch decision making.
> 
> Hmm, I think I previously changed this from ->dispatch_request() to
> ->dispatch_requests() to support schedulers using software queues. My
> current mq-token stuff doesn't have a ->dispatch_requests() hook anymore
> after the sched_tags rework, but I think I'm going to need it again
> soon. Having the scheduler do blk_mq_flush_busy_ctxs() into its own
> private list and then handing the requests out one-by-one kinda sucks.
> (Plus, deferred issue wouldn't work with this, but it's not implemented,
> anyways :)
> 
> One idea: what if we have the scheduler get the driver tags inside of
> its ->dispatch_requests()? For example, __dd_dispatch_request() could
> first check whether it has a request to dispatch and then try to grab a
> driver tag. If it succeeds, it dispatches the request, and if it
> doesn't, it marks itself as needing restart.
> 
> With that, the scheduler will only return requests ready for
> ->queue_rq(), meaning we could get rid of the list reshuffling in
> blk_mq_dispatch_rq_list().

That'd work for the driver tags, but it would not work for the case
where the driver returns BUSY. So we'd only be covering some of the
cases. That may or may not matter... Hard to say. I appreciate having
the hook that dispatches them all for efficiency reasons, but from a
scheduler point of view, sending off one is generally simpler and it'll
be better for rotational storage since we depend so heavily on merging
to get good performance there.

I'm definitely open to alternatives. We can keep the dispatch_requests()
and pass in a dispatch count, ramping up the dispatch count or something
like that. Seems a bit fragile though, and hard to get right.


-- 
Jens Axboe

