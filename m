Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08342C4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 02:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4ADD610CC
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 02:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhHNCNu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 22:13:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8411 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhHNCNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 22:13:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GmkPs28pwz87Gg;
        Sat, 14 Aug 2021 10:09:21 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 14 Aug 2021 10:13:20 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 14 Aug 2021 10:13:20 +0800
Subject: Re: questions about sane_behavior in cgroup v1
To:     Tejun Heo <tj@kernel.org>
CC:     linux-block <linux-block@vger.kernel.org>
References: <7ecceefb-ba98-399f-38b0-5a7717a51649@huawei.com>
 <YRacB4mYCIw+CQTl@mtj.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <83635fef-7409-693f-09a7-86705a52a0b0@huawei.com>
Date:   Sat, 14 Aug 2021 10:13:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YRacB4mYCIw+CQTl@mtj.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/14 0:21, Tejun Heo wrote:
> On Fri, Aug 13, 2021 at 05:25:12PM +0800, yukuai (C) wrote:
>> We want to support that configuration in parent cgroup will work on
>> child cgroup in cgroup v1. The feature was once supported and was
>> reverted in commit 67e9c74b8a87 ("cgroup: replace __DEVEL__sane_behavior
>> with cgroup2 fs type").
>>
>> Switching to cgroup v2 can support that, however, the cost is too high
>> because all of our products are using v1, and there's a big difference
>> in usage between v1 and v2.
>>
>> My question is that why is the feature reverted in cgroup v1? Is it
>> because there are some severe problems? If not, we'll try to backport
>> the feature to cgroup v1 again.
> 
> Because __DEVEL__sane_behavior, as the name clearly indicates, was a
> temporary development vehicle to gradually implement cgroup2 and not
> an official user-facing feature.
> 
> I have a hard time imagining backporting and maintaining that being
> less painful than moving the users to cgroup2 but that's for you guys
> to decide.

Hi, Tejun

Thanks for your response.

Best regards
Kuai
