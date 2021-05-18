Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64457C433B4
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 11:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B6D60BD3
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 11:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhERLos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 07:44:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4660 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348845AbhERLop (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 07:44:45 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkvFh1hG8z16QLQ;
        Tue, 18 May 2021 19:40:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 19:43:24 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 12:43:22 +0100
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        <linux-block@vger.kernel.org>, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com> <YKOiClSTyHl5lbXV@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com>
Date:   Tue, 18 May 2021 12:42:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YKOiClSTyHl5lbXV@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.99]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/05/2021 12:16, Ming Lei wrote:
> On Tue, May 18, 2021 at 10:44:43AM +0100, John Garry wrote:
>> On 14/05/2021 03:20, Ming Lei wrote:
>>> In case of shared sbitmap, request won't be held in plug list any more
>>> sine commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
>>> tagset"), this way makes request merge from flush plug list & batching
>>> submission not possible, so cause performance regression.
>>>
>>> Yanhui reports performance regression when running sequential IO
>>> test(libaio, 16 jobs, 8 depth for each job) in VM, and the VM disk
>>> is emulated with image stored on xfs/megaraid_sas.
>>>
>>> Fix the issue by recovering original behavior to allow to hold request
>>> in plug list.
>>
>> Hi Ming,
>>
>> Since testing v5.13-rc2, I noticed that this patch made the hang I was
>> seeing disappear:
>> https://lore.kernel.org/linux-scsi/3d72d64d-314f-9d34-e039-7e508b2abe1b@huawei.com/
>>
>> I don't think that problem is solved, though.
> 
> This kind of hang or lockup is usually related with cpu utilization, and
> this patch may reduce cpu utilization in submission context.

Right.

> 
>>
>> So I wonder about throughput performance (I had hoped to test before it was
>> merged). I only have 6x SAS SSDs at hand, but I see some significant changes
>> (good and bad) for mq-deadline for hisi_sas:
>> Before 620K (read), 300K IOPs (randread)
>> After 430K (read), 460-490K IOPs (randread)
> 
> 'Before 620K' could be caused by busy queue when batching submission isn't
> applied, so merge chance is increased. This patch applies batching
> submission, so queue becomes not busy enough.
> 
> BTW, what is the queue depth of sdev and can_queue of shost for your hisilision SAS?

sdev queue depth is 64 (see hisi_sas_slave_configure()) and host depth 
is 4096 - 96 (for reserved tags) = 4000

IIRC, megaraid sas and mpt3sas use 256 for SAS sdev queue depth

>   
>>
>> none IO sched is always about 450K (read) and 500K (randread)
>>
>> Do you guys have any figures? Are my results as expected?
> 
> In yanhui's virt workload(qemu, libaio, dio, high queue depth, single
> job), the patch can improve throughput much(>50%) when running
> sequential write(dio, libaio, 16 jobs) to XFS. And it is observed that
> IO merge is recovered to level of disabling host tags.
> 

Thanks,
John
