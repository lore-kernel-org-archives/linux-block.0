Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB2C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DA060F92
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhIOHuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 03:50:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15418 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhIOHtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 03:49:15 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8XK06ch5zRBs0;
        Wed, 15 Sep 2021 15:43:48 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 15:47:55 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 15:47:54 +0800
Subject: Re: [PATCH v2 4/4] block, bfq: consider request size in
 bfq_asymmetric_scenario()
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-5-yukuai3@huawei.com>
 <8601F280-2F16-446A-95BA-37A07D1A1055@linaro.org>
 <143fa1a2-de5f-b18a-73d9-8e105844709c@huawei.com>
 <68A2B4C8-48A5-45F3-8782-2440C0028161@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <bfb69bec-0ac8-c76f-51b2-fca094050121@huawei.com>
Date:   Wed, 15 Sep 2021 15:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <68A2B4C8-48A5-45F3-8782-2440C0028161@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/15 15:36, Paolo Valente wrote:
> 
> 
>> Il giorno 7 set 2021, alle ore 13:29, yukuai (C) <yukuai3@huawei.com> ha scritto:
>>
>> On 2021/08/27 1:00, Paolo Valente wrote:
>>>> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>>>
>>>> There is a special case when bfq do not need to idle when more than
>>>> one groups is active:
>>>>
>>> Unfortunately, there is a misunderstanding here.  If more than one
>>> group is active, then idling is not needed only if a lot of symmetry
>>> conditions also hold:
>>> - all active groups have the same weight
>>> - all active groups contain the same number of active queues
>>
>> Hi, Paolo
>>
>> I didn't think of this contition.
>>
>> It's seems that if we want to idle when more than one group is active,
>> there are two additional conditions:
>>
>> - all dispatched requests have the same size
>> - all active groups contain the same number of active queues
>>
> 
> Also the weights and the I/O priorities of the queues inside the
> groups needs to be controlled, unfortunately.
> 
>> Thus we still need to track how many queues are active in each group.
>> The conditions seems to be too much, do you think is it worth it to
>> add support to idle when more than one group is active?
>>
> 
> I think I see your point.  The problem is that these states are
> dynamic.  So, if we suspend tracking all the above information while
> more than one group is active, then we are with no state in case only
> one group remains active.

Hi, Paolo

In this case, I'll drop the last two patches in the next iteration.

Thanks,
Kuai
