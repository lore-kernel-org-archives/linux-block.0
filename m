Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661E1C433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 11:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E68A61100
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 11:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhIILPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:15:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15312 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhIILPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 07:15:32 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H4xG63Wjwz8svJ;
        Thu,  9 Sep 2021 19:13:50 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 19:14:21 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 19:14:20 +0800
Subject: Re: [PATCH] block: check the existence of tags[hctx_idx] in
 blk_mq_clear_rq_mapping()
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20210909090054.492923-1-houtao1@huawei.com>
 <YTnRsxec3JfPINmu@T590>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <96dd1720-343f-64db-42e9-788baec4b466@huawei.com>
Date:   Thu, 9 Sep 2021 19:14:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YTnRsxec3JfPINmu@T590>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 9/9/2021 5:19 PM, Ming Lei wrote:
> Hello Hou,
>
> On Thu, Sep 09, 2021 at 05:00:54PM +0800, Hou Tao wrote:
>> According to commit 4412efecf7fd ("Revert "blk-mq: remove code for
>> dealing with remapping queue""), for some devices queue hctx may not
>> being mapped, and tagset->tags[hctx_idx] will be released and be NULL.
>>
>> If an IO scheduler is used on these devices, blk_mq_clear_rq_mapping()
>> will be called for all hctxs in blk_mq_sched_free_requests() during
>> scheduler switch, and these will be oops. So checking the existence of
>> tags[hctx_idx] before going on in blk_mq_clear_rq_mapping().
> unmapped hctx should be caused by blk_mq_update_nr_hw_queues() only,
> but scheduler tags is updated there too, so not sure it is one real
> issue, did you observe such kernel panic? any kernel log?
Not a real issue, just find the potential "problem" during code review.

But is the case below possible ?
There is an unmapped hctx and a freed tags[hctx_idx] after
blk_mq_update_nr_hw_queues(), and IO scheduler is used. When
switching IO scheduler to none, the previous schedule tag
on each hctx will be freed in blk_mq_sched_free_requests().
blk_mq_sched_free_requests() will call blk_mq_free_rqs(), and

blk_mq_free_rqs() will access the NULLed tags[hctx_idx].

Regards,

Tao

>
> Thanks,
> Ming
>
> .
