Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05175C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 09:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiGZJUf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiGZJUe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 05:20:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92032B7C3
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 02:20:33 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsWWB3TB6zWf9S;
        Tue, 26 Jul 2022 17:16:38 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:20:25 +0800
Received: from [10.174.177.235] (10.174.177.235) by
 dggpeml500009.china.huawei.com (7.185.36.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:20:24 +0800
Message-ID: <060259de-0168-bd31-ee31-72acbc93bd2b@huawei.com>
Date:   Tue, 26 Jul 2022 17:20:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] blk-mq: run queue after issuing the last request of the
 plug list
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
CC:     Yu Kuai <yukuai3@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <hch@lst.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <Yt9HkP2mzH0ZTL1l@T590>
 <ba2b30f2-66d9-3acb-787d-fae1894fa5a6@huawei.com> <Yt9SMuSlCtwwzyEz@T590>
 <f91f136c-f109-3027-a666-29fe882d3426@huawei.com> <Yt9ZOFtzm9kfKWhc@T590>
 <6b070c7d-473a-cc96-def3-49826ca08aea@huawei.com> <Yt9duWU0Ez/uZIym@T590>
 <e77fbe38-3cf5-2074-4875-eb3e1df55807@huawei.com> <Yt9qjRc9CpdqtrgT@T590>
 <3f9d5423-ec40-ba8d-05c1-8f5634a5c792@huawei.com> <Yt+aSH86dVCA1vux@T590>
From:   Yufen Yu <yuyufen@huawei.com>
In-Reply-To: <Yt+aSH86dVCA1vux@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.235]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/7/26 15:39, Ming Lei wrote:
> On Tue, Jul 26, 2022 at 01:01:41PM +0800, Yufen Yu wrote:
>>
>>>
>>
>> hi Ming,
>>
>> Here rq2 fail from blk_mq_plug_issue_direct() in blk_mq_flush_plug_list(),
>> not blk_mq_sched_insert_requests
> 
> OK, just wondering why Yufen's patch touches
> blk_mq_sched_insert_requests().
> 
> Here the issue is in blk_mq_plug_issue_direct() itself, it is wrong to use last
> request of plug list to decide if run queue is needed since all the remained
> requests in plug list may be from other hctxs, and the simplest fix could be pass
> run_queue as true always to blk_mq_request_bypass_insert().
> 


OK, thanks for your suggestion and I will send v2.

Thanks,
Yufen

> 
> Thanks,
> Ming
> 
> .
