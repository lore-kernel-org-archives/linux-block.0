Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54113 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751560AbdHGTyS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 15:54:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v77JsGVu144712
        for <linux-block@vger.kernel.org>; Mon, 7 Aug 2017 15:54:18 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2c6snr610v-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 07 Aug 2017 15:54:17 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
        Mon, 7 Aug 2017 13:54:12 -0600
Subject: Re: [PATCH 3/4] blk-mq: provide internal in-flight variant
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-4-git-send-email-axboe@kernel.dk>
 <20170804111728.GB15989@ming.t460p>
 <354f5e68-ecba-853d-c6e5-3f5d363a667c@kernel.dk>
 <20170804221946.GB24759@ming.t460p>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 7 Aug 2017 14:54:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170804221946.GB24759@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <78ef0062-6603-c956-530d-61f68f37c3a1@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/04/2017 05:19 PM, Ming Lei wrote:
> On Fri, Aug 04, 2017 at 07:55:41AM -0600, Jens Axboe wrote:
>> On 08/04/2017 05:17 AM, Ming Lei wrote:
>>> On Thu, Aug 03, 2017 at 02:01:55PM -0600, Jens Axboe wrote:
>>>> We don't have to inc/dec some counter, since we can just
>>>> iterate the tags. That makes inc/dec a noop, but means we
>>>> have to iterate busy tags to get an in-flight count.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>  block/blk-mq.c        | 24 ++++++++++++++++++++++++
>>>>  block/blk-mq.h        |  2 ++
>>>>  block/genhd.c         | 29 +++++++++++++++++++++++++++++
>>>>  include/linux/genhd.h | 25 +++----------------------
>>>>  4 files changed, 58 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 05dfa3f270ae..37035891e120 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -86,6 +86,30 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
>>>>  	sbitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
>>>>  }
>>>>  
>>>> +struct mq_inflight {
>>>> +	struct hd_struct *part;
>>>> +	unsigned int inflight;
>>>> +};
>>>> +
>>>> +static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>>>> +				  struct request *rq, void *priv,
>>>> +				  bool reserved)
>>>> +{
>>>> +	struct mq_inflight *mi = priv;
>>>> +
>>>> +	if (rq->part == mi->part)
>>>> +		mi->inflight++;
>>>> +}
>>>> +
>>>> +unsigned int blk_mq_in_flight(struct request_queue *q,
>>>> +			       struct hd_struct *part)
>>>> +{
>>>> +	struct mq_inflight mi = { .part = part, .inflight = 0 };
>>>> +
>>>> +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
>>>> +	return mi.inflight;
>>>> +}
>>>
>>> IMO it might not be as efficient as per-cpu variable.
>>>
>>> For example, NVMe on one 128-core system, if we use percpu variable,
>>> it is enough to read 128 local variable from each CPU for accounting
>>> one in_flight.
>>
>> IFF the system is configured with NR_CPUS=128. Most distros go
>> much bigger. On the other hand, we know that nr_queues will
>> never be bigger than the number of online cpus, not the number
>> of possible cpus.
> 
> We usually use for_each_possible_cpu() for aggregating CPU
> local counters, and num_possible_cpus() is the number of
> CPUs polulatable in system, which is much less than NR_CPUs:
> 
> include/linux/cpumask.h:
> *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
> 
>>
>>> But in this way of blk_mq_in_flight(), we need to do 128 
>>> sbitmap search, and one sbitmap search need to read at least
>>> 16 words of 'unsigned long',  and total 128*16 read.
>>
>> If that ends up being a problem, it hasn't in testing, then we
>> could always stuff an index in front of the full sbitmap.
>>
>>> So maybe we need to compare the two approaches first.
>>
>> We already did, back when this was originally posted. See the
>> thread from end may / start june and the results from Brian.
> 
> Can't find the compasison data between percpu accounting vs. mq-infilight
> in that thread.
> 
> Just saw Brian mentioned in patch log that percpu may reach
> 11.4M(I guess 'M' is missed) [1]:
> 
> 	"When running this on a Power system, to a single null_blk device
> 	with 80 submission queues, irq mode 0, with 80 fio jobs, I saw IOPs
> 	go from 1.5M IO/s to 11.4 IO/s."
> 
> But in link[2], he said mq-flight can reach 9.4M.
> 
> Could Brian explain it a bit? Maybe the two tests were run in
> different settings, don't know.

The 11.4M IOPs vs 9.4M IOPs runs cannot be directly compared, as they were
run on different systems with different NVMe devices.

The key comparison I kept coming back to in my measurements was:

N jobs run to 1 null_blk vs. N null_blk devices, each with 1 job

If the IOPs I get between the two is similar, that should show that
we don't have scaling issues in blk-mq. 

There were three variations of patches I tried with:

* per-cpu - Patch from me

* per-node-atomic - Patch from Ming

* mq-inflight - Patch from Jens

All of them provided a massive improvement in my environment. The mq-inflight
was only marginally better than the per node and it was most prominent in the
N null_blk each with 1 job. While the per-node atomic approach certainly
reduced cross node contention on the atomics, they are still atomics, which
have a bit of overhead, particularly on the Power platform. 

As for the difference between the percpu approach and the mq-inflight approach,
I didn't compare them directly in the same config, since I didn't think the
percpu approach would go anywhere after the initial discussion we had on the list.

I'll get some time on the test machine again and do a direct comparison between
in-flight and percpu to see if there are any significant difference.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
