Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7791C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 06:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D3D2196E
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 06:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfI3G7S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfI3G7S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 02:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ED8B18CB8ED;
        Mon, 30 Sep 2019 06:59:17 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F19F600CC;
        Mon, 30 Sep 2019 06:59:11 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] blk-mq: Avoid memory reclaim when allocating
 request map
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "mchristi@redhat.com" <mchristi@redhat.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
References: <20190930015213.8865-1-xiubli@redhat.com>
 <20190930015213.8865-2-xiubli@redhat.com>
 <BYAPR04MB58160630271A8E552F7FD5D8E7820@BYAPR04MB5816.namprd04.prod.outlook.com>
 <544c7d2a-6600-9a8a-2f75-03e1d3211912@redhat.com>
 <BYAPR04MB581605EF9377C18074099232E7820@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <9b2d0f57-71f6-bbc8-3f1e-51ce83d12c1d@redhat.com>
Date:   Mon, 30 Sep 2019 14:59:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB581605EF9377C18074099232E7820@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Mon, 30 Sep 2019 06:59:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/30 14:20, Damien Le Moal wrote:
> On 2019/09/29 22:50, Xiubo Li wrote:
>> On 2019/9/30 13:28, Damien Le Moal wrote:
>>> On 2019/09/29 18:52, xiubli@redhat.com wrote:
>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>
>>>> For some storage drivers, such as the nbd, when there has new socket
>>>> connections added, it will update the hardware queue number by calling
>>>> blk_mq_update_nr_hw_queues(), in which it will freeze all the queues
>>>> first. And then tries to do the hardware queue updating stuff.
>>>>
>>>> But int blk_mq_alloc_rq_map()-->blk_mq_init_tags(), when allocating
>>>> memory for tags, it may cause the mm do the memories direct reclaiming,
>>>> since the queues has been freezed, so if needs to flush the page cache
>>>> to disk, it will stuck in generic_make_request()-->blk_queue_enter() by
>>>> waiting the queues to be unfreezed and then cause deadlock here.
>>>>
>>>> Since the memory size requested here is a small one, which will make
>>>> it not that easy to happen with a large size, but in theory this could
>>>> happen when the OS is running in pressure and out of memory.
>>>>
>>>> Gabriel Krisman Bertazi has hit the similar issue by fixing it in
>>>> commit 36e1f3d10786 ("blk-mq: Avoid memory reclaim when remapping
>>>> queues"), but might forget this part.
>>>>
>>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>>> CC: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
>>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>>> ---
>>>>    block/blk-mq-tag.c | 5 +++--
>>>>    block/blk-mq-tag.h | 5 ++++-
>>>>    block/blk-mq.c     | 3 ++-
>>>>    3 files changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>> index 008388e82b5c..04ee0e4c3fa1 100644
>>>> --- a/block/blk-mq-tag.c
>>>> +++ b/block/blk-mq-tag.c
>>>> @@ -462,7 +462,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
>>>>    
>>>>    struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>>>>    				     unsigned int reserved_tags,
>>>> -				     int node, int alloc_policy)
>>>> +				     int node, int alloc_policy,
>>>> +				     gfp_t flags)
>>>>    {
>>>>    	struct blk_mq_tags *tags;
>>>>    
>>>> @@ -471,7 +472,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>>>>    		return NULL;
>>>>    	}
>>>>    
>>>> -	tags = kzalloc_node(sizeof(*tags), GFP_KERNEL, node);
>>>> +	tags = kzalloc_node(sizeof(*tags), flags, node);
>>>>    	if (!tags)
>>>>    		return NULL;
>>>>    
>>>> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
>>>> index 61deab0b5a5a..296e0bc97126 100644
>>>> --- a/block/blk-mq-tag.h
>>>> +++ b/block/blk-mq-tag.h
>>>> @@ -22,7 +22,10 @@ struct blk_mq_tags {
>>>>    };
>>>>    
>>>>    
>>>> -extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
>>>> +extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
>>>> +					    unsigned int reserved_tags,
>>>> +					    int node, int alloc_policy,
>>>> +					    gfp_t flags);
>>>>    extern void blk_mq_free_tags(struct blk_mq_tags *tags);
>>>>    
>>>>    extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 240416057f28..9c52e4dfe132 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2090,7 +2090,8 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>>>>    		node = set->numa_node;
>>>>    
>>>>    	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
>>>> -				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
>>>> +				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags),
>>>> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
>>> You added the gfp_t argument to blk_mq_init_tags() but you are only using that
>>> argument with a hardcoded value here. So why not simply call kzalloc_node() in
>>> that function with the flags GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY ? That
>>> would avoid needing to add the "gfp_t flags" argument and still fit with your
>>> patch 2 definition of BLK_MQ_GFP_FLAGS.
>> The blk_mq_init_tags() is defined in another separate file, which I think it means to provide a common way of initializing the tags stuff, and currently in this path it needs GFP_NOIO while in others in future it may not.
> blk_mq_alloc_rq_map() is currently the only user of blk_mq_init_tags(), so I do
> not see the point in doing this change now. If it is needed "in the future" then
> do it then.
>
> I do not mind the patch going in as is, but I really think that everything can
> be folded into your patch 2 without the addition of blk_mq_init_tags()
> additional argument.

Actually I do not object to folding it into patch 2 :-)

Just from the v2 I supposed that it would be easier to be reviewed by 
splitting it into a separate one.

Thanks,

BRs

>> Thanks,
>> BRs
>>
>>
>>>>    	if (!tags)
>>>>    		return NULL;
>>>>    
>>>>
>>
>

