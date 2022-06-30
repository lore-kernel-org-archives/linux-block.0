Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 01:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiF3BqT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3BqS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 21:46:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A21822BE4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 18:46:17 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LYLkj6JTXz9sx5;
        Thu, 30 Jun 2022 09:45:33 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 09:46:15 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 09:46:14 +0800
Subject: Re: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
To:     Jens Axboe <axboe@kernel.dk>, Jason Yan <yanaijie@huawei.com>,
        <tj@kernel.org>, <jack@suse.cz>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>
References: <20220629070917.3113016-1-yanaijie@huawei.com>
 <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <ccbacbcd-1289-19b6-de87-ec59c1aef250@huawei.com>
Date:   Thu, 30 Jun 2022 09:46:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/06/30 1:09, Jens Axboe 写道:
> On 6/29/22 1:09 AM, Jason Yan wrote:
>> Two duplicated code segment refactors. No functional change.
>>
>> v2->v3: Fix indentation and add review tags.
>> v1->v2: Remove inline keyword of blkcg_iostat_update().
>>
>> Jason Yan (2):
>>    blk-cgroup: factor out blkcg_iostat_update()
>>    blk-cgroup: factor out blkcg_free_all_cpd()
>>
>>   block/blk-cgroup.c | 73 ++++++++++++++++++++++++----------------------
>>   1 file changed, 38 insertions(+), 35 deletions(-)
> 
> Like I told Yu, stop using the huawei email until your MTA
> misconfiguration issues are fixed. They end up in spam and risk getting
> lost. This series was one of them.
> 

Hi,

I'll try to push our IT to solve the issues, and in the meantime i'll
let my colleagues know about this. However, I'm afraid this can't be
avoid completely.

Thanks,
Kuai

