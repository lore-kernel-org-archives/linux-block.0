Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E038C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 14:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C8464E2A
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 14:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBJOm2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 09:42:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2530 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBJOmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 09:42:14 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbMjW1d9Vz67lrV;
        Wed, 10 Feb 2021 22:34:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Feb 2021 15:41:30 +0100
Received: from [10.210.168.117] (10.210.168.117) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 14:41:29 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
From:   John Garry <john.garry@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <kashyap.desai@broadcom.com>,
        <linuxarm@huawei.com>, <pragalla@codeaurora.org>
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
 <760304b3-dcbc-5b9d-0c70-627b7ff5b4eb@huawei.com>
Message-ID: <fbeb7dc0-8091-51a2-78e1-5f563a3ed53d@huawei.com>
Date:   Wed, 10 Feb 2021 14:39:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <760304b3-dcbc-5b9d-0c70-627b7ff5b4eb@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.117]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+

On 04/01/2021 18:37, John Garry wrote:

Hi Bart,

> 
>> Right, what I proposed is unrelated to the use-after-free triggered by
>> disabling I/O scheduling.
>>
>> Regarding the races triggered by disabling I/O scheduling: can these be
>> fixed by quiescing all request queues associated with a tag set before
>> changing the I/O scheduler instead of only the request queue for which 
>> the
>> I/O scheduler is changed? I think we already do this before updating the
>> number of hardware queues.
> 
> Maybe quiescing all request queues could solve the issue in 
> blk_mq_queue_tag_busy_iter(), as that issue involves interaction of 2x 
> request queues.
> 
> But the blk_mq_tagset_busy_iter() issue, above, it is related to only a 
> single request queue, so not sure how it could help.
> 
> But let me consider this more.

I have looked at this proposal again, that being to quiesce all (other) 
request queues prior to freeing the IO scheduler tags+requests. I tried 
this and it seems to work (changes not shown), in terms of solving the 
issue of blk_mq_queue_tag_busy_iter() and freeing the requests+tags 
racing. However, I am still not sure if it is acceptable to quiesce all 
request queues like this just when changing IO scheduler, even if it is 
done elsewhere.

In addition, this still leaves the blk_mq_tagset_busy_iter() issue; that 
being that freeing requests+tags can race against that same function. 
There is nothing to stop blk_mq_tagset_busy_iter() taking a reference to 
a request and that request being freed in parallel when switching IO 
scheduler, however unlikely.

Solving that becomes trickier. As Ming pointed out, that function can be 
called from softirq and even hard irq context - like 
ufshcd_tmv_handler() -> blk_mq_tagset_busy_iter() -  so there is a 
locking context issue.

Thanks,
John
