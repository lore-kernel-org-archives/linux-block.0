Return-Path: <SRS0=z7Fj=3Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A9C35254
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 14:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FA0217F4
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 14:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgBEOIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:08:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2375 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbgBEOIR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Feb 2020 09:08:17 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B830912A42B455C449F3;
        Wed,  5 Feb 2020 14:08:15 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 5 Feb 2020 14:08:14 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Feb 2020
 14:08:15 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
From:   John Garry <john.garry@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <tom.leiming@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Keith Busch <kbusch@kernel.org>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
 <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
 <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
 <56502aa9-d4ad-5ede-5184-13f1817c77d7@huawei.com>
 <CACVXFVNiBOBdtwuW=q4aSmUMAnn6Gfpg6BGhcQu44s58NZ08Ww@mail.gmail.com>
 <20200201110539.03db5434@why> <87sgjutufz.fsf@nanos.tec.linutronix.de>
 <3db522f4-c0c3-ce0f-b0e3-57ee1176bbf8@huawei.com>
 <797432ab-1ef5-92e3-b512-bdcee57d1053@huawei.com>
 <CACVXFVOijCDjFa339Dyxnp9_0W5UjDyF-a42Dmo-6pogu+rp5Q@mail.gmail.com>
 <b0f35177-70f3-541d-996b-ebb364634225@huawei.com>
 <f759c5bca7de4b2af2e1cabd2f476e3c@kernel.org>
 <7ae71bf1-fd1f-d97e-1e72-646e2e6c8b3c@huawei.com>
Message-ID: <c8a31bf9-7e25-aff1-e0df-7d9106324b9f@huawei.com>
Date:   Wed, 5 Feb 2020 14:08:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7ae71bf1-fd1f-d97e-1e72-646e2e6c8b3c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/02/2020 18:16, John Garry wrote:
> On 03/02/2020 15:43, Marc Zyngier wrote:
>> On 2020-02-03 12:56, John Garry wrote:
>>
>> [...]
>>
>>>> Can you trigger it after disabling irqbalance?
>>>
>>> No, so tested by killing the irqbalance process and it ran for 25
>>> minutes without issue.
>>
>> OK, that's interesting.
>>
>> Can you find you whether irqbalance tries to move an interrupt to an 
>> offlined CPU?
>> Just putting a trace into git_set_affinity() should be enough.
>>
> 

Just an update here: I have tried this same test on a new model dev 
board and I don't experience the same issue. It's quite stable.

I'd like to get to the bottom of the issue reported, but I feel that the 
root cause may be a BIOS issue and I will get next to no BIOS support 
for that particular board. Hmmm.

Thanks,
John

