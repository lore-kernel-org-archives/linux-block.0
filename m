Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A52DC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJRJw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJRJw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 05:52:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7CB14D5
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 02:52:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ms8KX56gCz9t8P;
        Tue, 18 Oct 2022 17:52:16 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:52:19 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <sagi@grimberg.me>, <kbusch@kernel.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <b9fd5ed5-0312-f5ba-2831-e46516a5ae49@huawei.com>
Date:   Tue, 18 Oct 2022 17:52:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221017133906.GA24492@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/17 21:39, Christoph Hellwig wrote:
> On Thu, Oct 13, 2022 at 05:44:49PM +0800, Chao Leng wrote:
>> +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
>> +	if (rcu) {
>> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +			if (blk_queue_noquiesced(q))
>> +				continue;
>> +
>> +			init_rcu_head(&rcu[i].head);
>> +			init_completion(&rcu[i].completion);
>> +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
>> +			i++;
>> +		}
>> +
>> +		for (i = 0; i < count; i++) {
>> +			wait_for_completion(&rcu[i].completion);
>> +			destroy_rcu_head(&rcu[i].head);
>> +		}
>> +		kvfree(rcu);
>> +	} else {
>> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +			synchronize_srcu(q->srcu);
>> +	}
> 
> Having to allocate a struct rcu_synchronize for each of the potentially
> many queues here is a bit sad.
> 
> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
> last week, so I wonder if something like that would also be feasible
> for SRCU, as that would come in really handy here.
Using start_poll_synchronize_rcu will reduce some memory.
This is a good idea.
> 
> .
> 
