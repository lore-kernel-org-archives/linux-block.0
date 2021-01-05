Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C38C433E0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 11:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC0229C7
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 11:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbhAELkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 06:40:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2292 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbhAELkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 06:40:32 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D99Qf4h1Dz67VyY;
        Tue,  5 Jan 2021 19:35:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 5 Jan 2021 12:39:49 +0100
Received: from [10.47.9.197] (10.47.9.197) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 5 Jan 2021
 11:39:49 +0000
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared in
 hctx_may_queue
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
 <f8def27f-6709-143f-9864-8bc76e4ee052@huawei.com>
 <20210105022017.GA3594357@T590>
 <bcbe4b32-a819-8423-1849-e9a7db7fcde8@huawei.com>
 <20210105111850.GB3619109@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c4aa932f-6ede-ab58-0d66-a7d4a61010ff@huawei.com>
Date:   Tue, 5 Jan 2021 11:38:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210105111850.GB3619109@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.197]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/01/2021 11:18, Ming Lei wrote:
>>>> ot set normally..
>>> It always return true, and might just take a bit more CPU especially the tag queue
>>> depth of magsas_raid and hisi_sas_v3 is quite high.
>> Hi Ming,
>>
>> Right, but we actually tested by hacking the host tag queue depth to be
>> lower such that we should have tag contention, here is an extract from the
>> original series cover letter for my results:
>>
>> Tag depth 		4000 (default)		260**
>>
>> Baseline (v5.9-rc1):
>> none sched:		2094K IOPS		513K
>> mq-deadline sched:	2145K IOPS		1336K
>>
>> Final, host_tagset=0 in LLDD *, ***:
>> none sched:		2120K IOPS		550K
>> mq-deadline sched:	2121K IOPS		1309K
>>
>> Final ***:
>> none sched:		2132K IOPS		1185		
>> mq-deadline sched:	2145K IOPS		2097	
>>
>> Maybe my test did not expose the issue. Kashyap also tested this and
>> reported the original issue such that we needed this feature, so I'm
>> confused.

Hi Ming,

> How many LUNs are involved in above test with 260 depth?

For me, there was 12 SAS SSDs; for convenience here is the cover letter 
with details:
https://lore.kernel.org/linux-block/1597850436-116171-1-git-send-email-john.garry@huawei.com/

IIRC, for megaraid sas, Kashyap used many more LUNs for testing (64) and 
high fio depth (128) but did not reduce .can_queue, topic originally 
raised here:
https://lore.kernel.org/linux-block/29f8062c1fccace73c45252073232917@mail.gmail.com/

Thanks,
John


