Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF21C433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5604264E31
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 12:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBGMuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Feb 2021 07:50:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12146 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGMuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Feb 2021 07:50:04 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DYTTW2GyCz164w6;
        Sun,  7 Feb 2021 20:47:59 +0800 (CST)
Received: from [10.174.179.198] (10.174.179.198) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 20:49:11 +0800
Subject: Re: question about relative control for sync io using bfq
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
 <7E41BC22-33EA-4D0F-9EBD-3AB0824E3F2E@linaro.org>
 <7c28a80f-dea9-d701-0399-a22522c4509b@huawei.com>
 <554AE702-9A13-4FB5-9B29-9AF11F09CE5B@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <97ce5ede-0f7e-ce63-7a92-01c3356f4e44@huawei.com>
Date:   Sun, 7 Feb 2021 20:49:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <554AE702-9A13-4FB5-9B29-9AF11F09CE5B@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.198]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021/02/05 15:49, Paolo Valente wrote:
> 
> 
>> Il giorno 29 gen 2021, alle ore 09:28, yukuai (C) <yukuai3@huawei.com> ha scritto:
>>
>> Hi,
>>
>> Thanks for your response, and my apologize for the delay, my tmie
>> is very limited recently.
>>
> 
> I do know that problem ...
> 
>> On 2021/01/22 18:09, Paolo Valente wrote:
>>> Hi,
>>> this is a core problem, not of BFQ but of any possible solution that
>>> has to provide bandwidth isolation with sync I/O.  One of the examples
>>
>> I'm not sure about this, so I test it with iocost in mq and cfq in sq,
>> result shows that they do can provide bandwidth isolation with sync I/O
>> without significant performance degradation.
> 
> Yep, that means just that, with your specific workload, bandwidth
> isolation gets guaranteed without idling.  So that's exactly one of
> the workloads for which I'm suggesting my handling of a special case.
> 
> 
>>> is the one I made for you in my other email.  At any rate, the problem
>>> that you report seems to occur with just one group.  We may think of
>>> simply changing my condition
>>> bfqd->num_groups_with_pending_reqs > 0
>>> to
>>> bfqd->num_groups_with_pending_reqs > 1
>>
>> We aredy tried this, the problem will dispeare if only one group is
>> active. And I think this modification is reasonable because
>> bandwidth isolation is not necessary in this case.
>>
> 
> Thanks for your feedback. I'll consider submitting this change.
> 
>> However, considering the common case, when more than one
>> group is active, and one of the group is issuing sync IO, I think
>> we need to find a way to prevent the preformance degradation.
> 
> I agree.  What do you think of my suggestion for solving the problem?
> Might you help with that?

Hi

Do you mead the suggestion that you mentioned in another email:
"a varied_rq_size flag, similar to the varied_weights flag" ?
I'm afraid that's just a circumvention plan, not a solution to the
special case.

By the way, I'm glad if there is anything I can help, however it'll
wait for a few days cause the Spring Festival is coming.

Thanks,
Yu Kuai

> 
> Thanks,
> Paolo
> 
>>> If this simple solution does solve the problem you report, then I
>>> could run my batch of tests to check whether it causes some
>>> regression.
>>> What do you think?
>>> Thanks.
>>> Paolo
>>
>> Thanks
>> Yu Kuai
>>> .
> 
> .
> 
