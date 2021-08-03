Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF75C4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531D860EBC
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 11:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhHCLay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:30:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12440 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhHCLax (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 07:30:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GfCJW70cgzckR6;
        Tue,  3 Aug 2021 19:27:07 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 19:30:41 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 3 Aug 2021 19:30:40 +0800
Subject: Re: [PATCH 1/3] block, bfq: do not idle if only one cgroup is
 activated
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210714094529.758808-1-yukuai3@huawei.com>
 <20210714094529.758808-2-yukuai3@huawei.com>
 <7DF40BD4-8F57-4C2E-88A9-CBC3DA2A891E@linaro.org>
 <c0b97b5b-c961-6d9f-7033-6da194c6b220@huawei.com>
 <8D4774E6-0DEB-4DC4-B28B-13F5A933E12F@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <1fe2b6cb-d770-d53f-2a17-fdce480d7be0@huawei.com>
Date:   Tue, 3 Aug 2021 19:30:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8D4774E6-0DEB-4DC4-B28B-13F5A933E12F@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/03 15:07, Paolo Valente wrote:
> 
> 
>> Il giorno 31 lug 2021, alle ore 09:10, yukuai (C) <yukuai3@huawei.com> ha scritto:
>>
>> On 2021/07/24 15:12, Paolo Valente wrote:
>>>> Il giorno 14 lug 2021, alle ore 11:45, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>>>
>>>> If only one group is activated, specifically
>>>> 'bfqd->num_groups_with_pending_reqs == 1', there is no need to guarantee
>>>> the same share of the throughput of queues in the same group.
>>>>
>>>> Thus change the condition from '> 0' to '> 1' in
>>>> bfq_asymmetric_scenario().
>>> I see your point, and I agree with your goal.  Yet, your change seems
>>> not to suffer from the following problem.
>>> In addition to the groups that are created explicitly, there is the
>>> implicit root group.  So, when bfqd->num_groups_with_pending_reqs ==
>>> 1, there may be both active processes in the root group and active
>>> processes in the only group created explicitly.  In this case, idling
>>> is needed to preserve service guarantees.
>>> Probably your idea should be improved by making sure that there is
>>> pending I/O only from either the root group or the explicit group.
>>> Thanks,
>>> Paolo
>>
>>
>> Hi, Paolo
>>
> 
> Hi
> 
>> I'm trying to add support to judge if root group have pending rqs, the
>> implementation involve setting and clearing the busy state.
>>
> 
> I wouldn't use the busy state, as it does not take in-flight requests
> into account.  For I/O control, the latter are as important as the
> ones still queued in the scheduler.  For this reason, I take in-flight
> requests into account when counting
> bfqd->num_groups_with_pending_reqs.
> 
> See, e.g., this
> 
> 	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
> 		...
> 		bfq_weights_tree_remove(bfqd, bfqq);
> 	}
> 
> in bfq_completed_request.
> 
> I would replicate the same logic in deciding whether the root group
> has pending I/O.
> 

Hi, Paolo

Thanks for your advice, I'll send a new patchset soon.

Kuai
