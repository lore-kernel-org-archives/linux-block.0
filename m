Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32910 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbcJFKLh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 06:11:37 -0400
Subject: Re: [PATCH v2 6/8] blk-mq: Rework blk_mq_realloc_hw_ctxs()
To: Alexander Gordeev <agordeev@redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
 <7459c980dd965b5f7b91e3bf1c3114d658535229.1475241231.git.agordeev@redhat.com>
 <259f9d8c-e552-7565-5e05-88a1c8430317@grimberg.me>
 <20161006082507.GB23960@agordeev.lab.eng.brq.redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8351125c-32f9-4fd5-1069-4b44a72a4dc8@grimberg.me>
Date: Thu, 6 Oct 2016 13:11:32 +0300
MIME-Version: 1.0
In-Reply-To: <20161006082507.GB23960@agordeev.lab.eng.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 06/10/16 11:25, Alexander Gordeev wrote:
> On Thu, Oct 06, 2016 at 12:47:26AM +0300, Sagi Grimberg wrote:
>>
>>> @@ -1908,33 +1909,36 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>> 		if (node == NUMA_NO_NODE)
>>> 			node = set->numa_node;
>>>
>>> -		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
>>> -					GFP_KERNEL, node);
>>> -		if (!hctxs[i])
>>> +		hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
>>> +		if (!hctx)
>>> 			break;
>>>
>>> -		if (blk_mq_init_hctx(q, set, hctxs[i], i, node)) {
>>> -			kfree(hctxs[i]);
>>> -			hctxs[i] = NULL;
>>> +		if (blk_mq_init_hctx(q, set, hctx, i, node)) {
>>> +			kfree(hctx);
>>> 			break;
>>> 		}
>>> -		blk_mq_hctx_kobj_init(hctxs[i]);
>>> +
>>> +		blk_mq_hctx_kobj_init(hctx);
>>> +		hctxs[i] = hctx;
>>> 	}
>>> 	for (j = i; j < q->nr_hw_queues; j++) {
>>> -		struct blk_mq_hw_ctx *hctx = hctxs[j];
>>> +		hctx = hctxs[i];
>>
>> Didn't you mean hctx[j]?
>
> Surely, I did.
> Thanks!

Maybe it would be cleaner to do:

	while (--i >= 0) {
		hctx = hctxs[i];
		...
	}
