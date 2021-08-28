Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39050C432BE
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0855F60F58
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhH1Cnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 22:43:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18982 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhH1Cnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 22:43:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GxLPl4Rjjzbg1m;
        Sat, 28 Aug 2021 10:39:07 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 10:42:59 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 10:42:59 +0800
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
CC:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
 <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
 <e2571b1b-2dde-9b6d-8373-579fdee1218c@huawei.com>
 <b9b243b2-4eaf-9acf-fccb-f028c359a2a9@acm.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <27232c95-c6cb-f6c6-929b-0ecf0b527daa@huawei.com>
Date:   Sat, 28 Aug 2021 10:42:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b9b243b2-4eaf-9acf-fccb-f028c359a2a9@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/8/28 10:19, Bart Van Assche wrote:
> On 8/27/21 6:45 PM, Leizhen (ThunderTown) wrote:
>> On 2021/8/27 11:13, Jens Axboe wrote:
>>> On 8/26/21 8:48 PM, Bart Van Assche wrote:
>>>> With the patch series that is available at
>>>> https://github.com/bvanassche/linux/tree/block-for-next the same test reports
>>>> 1090 K IOPS or only 1% below the v5.11 result. I will post that series on the
>>>> linux-block mailing list after I have finished testing that series.
>>>
>>> OK sounds good. I do think we should just do the revert at this point,
>>> any real fix is going to end up being bigger than I'd like at this
>>> point. Then we can re-introduce the feature once we're happy with the
>>> results.
>>
>> Yes, It's already rc7 and it's no longer good for big changes. Revert is the
>> best solution, and apply my patch is a compromise solution.
> 
> Please take a look at the patch series that is available at
> https://github.com/bvanassche/linux/tree/block-for-next. Performance for
> that patch series is significantly better than with your patch.

Yes, this patch is better than mine. However, Jens prefers to avoid the risk of
functional stability in v5.14. v5.15 doesn't need my patch or revert.

I'll test your patch this afternoon. I don't have the environment yet.

> 
> Thanks,
> 
> Bart.
> .
> 
