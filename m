Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD272C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 08:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98886619B6
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 08:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCWINg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 04:13:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5110 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCWINN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 04:13:13 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F4PG15s3LzYNJ3;
        Tue, 23 Mar 2021 16:11:21 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 23 Mar 2021 16:13:10 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 23
 Mar 2021 16:13:10 +0800
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <87a0ede6-b696-d34d-e74d-56429fe32ae7@huawei.com>
Date:   Tue, 23 Mar 2021 16:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/3/23 15:36, Sagi Grimberg wrote:
> 
>> I check it again. I still think the below patch can avoid the bug.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41 
> 
> I don't understand what you are saying...
> 
>>
>> The process:
>> 1.nvme_ns_head_submit_bio call srcu_read_lock(&head->srcu).
>> 2.nvme_ns_head_submit_bio will add the bio to current->bio_list instead of waiting for the frozen queue.
> 
> Nothing guarantees that you have a bio_list active at any point in time,
> in fact for a workload that submits one by one you will always drain
> that list directly in the submission...
submit_bio and nvme_requeue_work both guarantee current->bio_list.
The process:
1.submit_bio and  nvme_requeue_work will call submit_bio_noacct.
2.submit_bio_noacct will call __submit_bio_noacct because bio->bi_disk->fops->submit_bio = nvme_ns_head_submit_bio.
3.__submit_bio_noacct set current->bio_list, and then __submit_bio will call bio->bi_disk->fops->submit_bio(nvme_ns_head_submit_bio)
4.nvme_ns_head_submit_bio will add the bio to current->bio_list.
5.__submit_bio_noacct drain current->bio_list.
when drain current->bio_list, it will wait for the frozen queue but do not hold the head->srcu.
Because it call blk_mq_submit_bio directly instead of ->submit_bio(nvme_ns_head_submit_bio).
So it is safe.
> 
>> 3.nvme_ns_head_submit_bio call srcu_read_unlock(&head->srcu, srcu_idx).
>> So nvme_ns_head_submit_bio do not hold head->srcu long when the queue is frozen, can avoid deadlock.
>>
>> Sagi, suggest trying this patch.
> 
> The above reproduces with the patch applied on upstream nvme code.The new patch(blk_mq_submit_bio_direct) will cause the bug again.
Because it revert add the bio to current->bio_list.
Just try the upstream nvme code, and do not apply the new patch(blk_mq_submit_bio_direct).
> .
