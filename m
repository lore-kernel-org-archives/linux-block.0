Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915FCC4338F
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 07:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761CD6103B
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 07:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhGaHKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Jul 2021 03:10:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7770 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhGaHKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 03:10:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GcFcR4tVPzYjf6;
        Sat, 31 Jul 2021 15:04:07 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 15:10:02 +0800
Received: from [10.174.178.91] (10.174.178.91) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 31 Jul 2021 15:10:01 +0800
Subject: Re: [PATCH 1/3] block, bfq: do not idle if only one cgroup is
 activated
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210714094529.758808-1-yukuai3@huawei.com>
 <20210714094529.758808-2-yukuai3@huawei.com>
 <7DF40BD4-8F57-4C2E-88A9-CBC3DA2A891E@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c0b97b5b-c961-6d9f-7033-6da194c6b220@huawei.com>
Date:   Sat, 31 Jul 2021 15:10:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7DF40BD4-8F57-4C2E-88A9-CBC3DA2A891E@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/07/24 15:12, Paolo Valente wrote:
> 
> 
>> Il giorno 14 lug 2021, alle ore 11:45, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>
>> If only one group is activated, specifically
>> 'bfqd->num_groups_with_pending_reqs == 1', there is no need to guarantee
>> the same share of the throughput of queues in the same group.
>>
>> Thus change the condition from '> 0' to '> 1' in
>> bfq_asymmetric_scenario().
> 
> I see your point, and I agree with your goal.  Yet, your change seems
> not to suffer from the following problem.
> 
> In addition to the groups that are created explicitly, there is the
> implicit root group.  So, when bfqd->num_groups_with_pending_reqs ==
> 1, there may be both active processes in the root group and active
> processes in the only group created explicitly.  In this case, idling
> is needed to preserve service guarantees.
> 
> Probably your idea should be improved by making sure that there is
> pending I/O only from either the root group or the explicit group.
> 
> Thanks,
> Paolo


Hi, Paolo

I'm trying to add support to judge if root group have pending rqs, the
implementation involve setting and clearing the busy state.

I'm thinking about setting busy in __bfq_activate_entity() if
bfq_entity_to_bfqq() return valid bfqq, however I'm not sure where to
clear the busy state.

On the other hand, do you think the way I record rq size info in patch 2
is OK? If so, I can do this the similar way: say that root group doesn't
have any pending requests if bfq haven't dispatch rq from root group for
a period of time.

Thanks
Kuai
