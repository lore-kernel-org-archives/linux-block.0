Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A33AC433DF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 05:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609D3207FC
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 05:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgG0F4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:56:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbgG0F4M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 01:56:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C129B3B47A385A0E7F0;
        Mon, 27 Jul 2020 13:55:54 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 13:55:53 +0800
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Ming Lei <ming.lei@redhat.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        <linux-nvme@lists.infradead.org>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
 <20200727035033.GD1129253@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <79ab699e-3f50-26c0-3c85-1962ae4dedac@huawei.com>
Date:   Mon, 27 Jul 2020 13:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200727035033.GD1129253@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/7/27 11:50, Ming Lei wrote:
> On Mon, Jul 27, 2020 at 11:33:43AM +0800, Chao Leng wrote:
>>
>>
>> On 2020/7/27 10:08, Ming Lei wrote:
>>>> It is at the end and contains exactly what is needed to synchronize. Not
>>> The sync is simply single global synchronize_rcu(), and why bother to add
>>> extra >=40bytes for each hctx.
>>>
>>>> sure what you mean by reuse hctx->srcu?
>>> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
>>> to each hctx for just simulating one single synchronize_rcu().
>>
>> To sync srcu together, the extra bytes must be needed, seperate blocking
>> and non blocking queue to two hctx may be a not good choice.
>>
>> There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
>> Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
>> not need if which do not need batch sync srcu, I still think it's better
>> for the SRCU to provide the batch synchronization interface.
> 
> The 'struct rcu_synchronize' can be allocated from heap or even stack(
> if no too many NSs), which is just one shot sync and the API is supposed
> to be called in slow path. No need to allocate it as long lifetime variable.
> Especially 'struct srcu_struct' has already been too fat.

Stack is not suitable, stack can not provide so many space for
many name space. Heap maybe a choice, but need to add abnormal treat
when alloc memory failed, Thus io pause time can not be ensured.
So the extra space may must be needed for batch srcu sync.
