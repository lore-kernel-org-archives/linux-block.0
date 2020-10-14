Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC5C433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 01:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DD621D7F
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 01:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgJNBcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 21:32:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbgJNBcn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 21:32:43 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 3E51DDEB758DD8C8C171;
        Wed, 14 Oct 2020 09:32:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 09:32:40 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 14
 Oct 2020 09:32:39 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
CC:     Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <6f9f59be-5d83-390e-b3cf-b5955ffa7259@huawei.com>
Date:   Wed, 14 Oct 2020 09:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/10/14 6:36, Sagi Grimberg wrote:
> 
>>>> This may just reduce the probability. The concurrency of timeout and teardown will cause the same request
>>>> be treated repeatly, this is not we expected.
>>>
>>> That is right, not like SCSI, NVME doesn't apply atomic request completion, so
>>> request may be completed/freed from both timeout & nvme_cancel_request().
>>>
>>> .teardown_lock still may cover the race with Sagi's patch because teardown
>>> actually cancels requests in sync style.
>> In extreme scenarios, the request may be already retry success(rq state change to inflight).
>> Timeout processing may wrongly stop the queue and abort the request.
>> teardown_lock serialize the process of timeout and teardown, but do not avoid the race.
>> It might not be safe.
> 
> Not sure I understand the scenario you are describing.
> 
> what do you mean by "In extreme scenarios, the request may be already retry success(rq state change to inflight)"?
> 
> What will retry the request? only when the host will reconnect
> the request will be retried.
If irq interrupt the timeout work, and cause the timeout work pause long time(more than 100ms).
The reconnect may already success, and start requests. And then timeout work continue run to
wrongly stop queue and cancel the request.
The probability of this happening is very low.
> 
> We can call nvme_sync_queues in the last part of the teardown, but
> I still don't understand the race here.
> .
