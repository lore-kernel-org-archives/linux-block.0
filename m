Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA04C433E6
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6522F2225E
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 18:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhADSpf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:45:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2290 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADSpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jan 2021 13:45:34 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D8kwt13g2z67SPh;
        Tue,  5 Jan 2021 02:41:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Jan 2021 19:44:52 +0100
Received: from [10.47.2.42] (10.47.2.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 4 Jan 2021
 18:44:51 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <kashyap.desai@broadcom.com>,
        <linuxarm@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
 <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
 <33e41110-b3b2-ac16-f131-de1679ce8238@acm.org>
 <7bdd562d-b258-43a2-0de0-966091086cff@huawei.com>
 <e56e8831-4a74-8411-6c04-3a65aff855f4@huawei.com>
 <0ab85ab8-c5c7-01aa-6b39-da731b3db829@acm.org>
 <d22efcd3-274a-15c5-9e4a-248037789c4d@huawei.com>
 <c0d127a9-9320-6e1c-4e8d-412aa9ea9ca6@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1bcc1d9e-6a32-1e00-0d32-f5b7325b2f8c@huawei.com>
Date:   Mon, 4 Jan 2021 18:43:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c0d127a9-9320-6e1c-4e8d-412aa9ea9ca6@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.42]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/01/2021 17:22, Bart Van Assche wrote:
> On 1/4/21 7:33 AM, John Garry wrote:
>> On 23/12/2020 15:47, Bart Van Assche wrote:
>>> I propose to change the order in which blk_mq_sched_free_requests(q) and
>>> blk_mq_debugfs_unregister(q) are called. Today blk_mq_sched_free_requests(q)
>>> is called by blk_cleanup_queue() before blk_put_queue() is called.
>>> blk_put_queue() calls blk_release_queue() if the last reference is dropped.
>>> blk_release_queue() calls blk_mq_debugfs_unregister(). I prefer removing the
>>> debugfs attributes earlier over modifying the tag iteration functions
>>> because I think removing the debugfs attributes earlier is less risky.
>> But don't we already have this following path to remove the per-hctx debugfs
>> dir earlier than blk_mq_sched_free_requests() or blk_release_queue():
>>
>> blk_cleanup_queue() -> blk_mq_exit_queue() -> blk_mq_exit_hw_queues() ->
>> blk_mq_debugfs_unregister_hctx() ->
>> blk_mq_debugfs_unregister_hctx(hctx->debugfs_dir)
>>
>> Having said that, I am not sure how this is related directly to the problem
>> I mentioned. In that problem, above, we trigger the
>> blk_mq_tagset_busy_iter() from the SCSI host sysfs file, and the
>> use-after-free comes about from disabling the elevator (and freeing the
>> sched requests) in parallel.
> Hi John,

Hi Bart,

> 
> Right, what I proposed is unrelated to the use-after-free triggered by
> disabling I/O scheduling.
> 
> Regarding the races triggered by disabling I/O scheduling: can these be
> fixed by quiescing all request queues associated with a tag set before
> changing the I/O scheduler instead of only the request queue for which the
> I/O scheduler is changed? I think we already do this before updating the
> number of hardware queues.

For changing the number of HW queues, I figure that we have no choice 
but to quiesce all request queues associated.

But maybe there is still some locking we could use to avoid that here.

Please let me consider it a bit more.

Thanks,
John

