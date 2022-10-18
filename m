Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFCC433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJRJw1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJRJw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 05:52:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62204B14E7
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 02:52:24 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ms8KX2rXZz9t97;
        Tue, 18 Oct 2022 17:52:16 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:52:07 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To:     <paulmck@kernel.org>, Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <sagi@grimberg.me>, <kbusch@kernel.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <3bb8a547-b2e2-7654-55dc-e943ac9aa06d@huawei.com>
Date:   Tue, 18 Oct 2022 17:52:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/17 23:21, Paul E. McKenney wrote:
> On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
>> On Thu, Oct 13, 2022 at 05:44:49PM +0800, Chao Leng wrote:
>>> +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
>>> +	if (rcu) {
>>> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>> +			if (blk_queue_noquiesced(q))
>>> +				continue;
>>> +
>>> +			init_rcu_head(&rcu[i].head);
>>> +			init_completion(&rcu[i].completion);
>>> +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
>>> +			i++;
>>> +		}
>>> +
>>> +		for (i = 0; i < count; i++) {
>>> +			wait_for_completion(&rcu[i].completion);
>>> +			destroy_rcu_head(&rcu[i].head);
>>> +		}
>>> +		kvfree(rcu);
>>> +	} else {
>>> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
>>> +			synchronize_srcu(q->srcu);
>>> +	}
>>
>> Having to allocate a struct rcu_synchronize for each of the potentially
>> many queues here is a bit sad.
>>
>> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
>> last week, so I wonder if something like that would also be feasible
>> for SRCU, as that would come in really handy here.
> 
> There is start_poll_synchronize_srcu() and poll_state_synchronize_srcu(),
> but there would need to be an unsigned long for each srcu_struct from
> which an SRCU grace period was required.  This would be half the size
> of the "rcu" array above, but still maybe larger than you would like.
> 
> The resulting code might look something like this, with "rcu" now being
> a pointer to unsigned long:
> 
> 	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> 	if (rcu) {
> 		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> 			if (blk_queue_noquiesced(q))
> 				continue;
> 			rcu[i] = start_poll_synchronize_srcu(q->srcu);
> 			i++;
> 		}
> 
> 		for (i = 0; i < count; i++)
> 			if (!poll_state_synchronize_srcu(q->srcu))
> 				synchronize_srcu(q->srcu);
synchronize_srcu will restart a new period of grace.
Maybe it would be better like this:
			while (!poll_state_synchronize_srcu(q->srcu, rcu[i]))
				schedule_timeout_uninterruptible(1);
> 		kvfree(rcu);
> 	} else {
> 		list_for_each_entry(q, &set->tag_list, tag_set_list)
> 			synchronize_srcu(q->srcu);
> 	}
> 
> Or as Christoph suggested, just have a single srcu_struct for the
> whole group.
> 
> The main reason for having multiple srcu_struct structures is to
> prevent the readers from one from holding up the updaters from another.
> Except that by waiting for the multiple grace periods, you are losing
> that property anyway, correct?  Or is this code waiting on only a small
> fraction of the srcu_struct structures associated with blk_queue?
> 
> 							Thanx, Paul
> .
> 
