Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D1C433E0
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 11:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FAF23104
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 11:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbhAFLkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:40:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2296 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhAFLkH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 06:40:07 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D9nNy6sn1z67Xxf;
        Wed,  6 Jan 2021 19:35:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 6 Jan 2021 12:39:25 +0100
Received: from [10.210.170.66] (10.210.170.66) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 6 Jan 2021 11:39:24 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared in
 hctx_may_queue
To:     Ming Lei <ming.lei@redhat.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
 <f8def27f-6709-143f-9864-8bc76e4ee052@huawei.com>
 <20210105022017.GA3594357@T590>
 <bcbe4b32-a819-8423-1849-e9a7db7fcde8@huawei.com>
 <20210105111850.GB3619109@T590>
 <c4aa932f-6ede-ab58-0d66-a7d4a61010ff@huawei.com>
 <20210106012839.GA3821988@T590>
Message-ID: <5430c277-92ab-b24d-6479-2e8c16b0c667@huawei.com>
Date:   Wed, 6 Jan 2021 11:38:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210106012839.GA3821988@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.66]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/01/2021 01:28, Ming Lei wrote:
>>> How many LUNs are involved in above test with 260 depth?
>> For me, there was 12 SAS SSDs; for convenience here is the cover letter with
>> details:
>> https://lore.kernel.org/linux-block/1597850436-116171-1-git-send-email-john.garry@huawei.com/
>>
>> IIRC, for megaraid sas, Kashyap used many more LUNs for testing (64) and
>> high fio depth (128) but did not reduce .can_queue, topic originally raised
>> here:
>> https://lore.kernel.org/linux-block/29f8062c1fccace73c45252073232917@mail.gmail.com/
> OK, in both tests, nr_luns are big enough wrt. 260 depth. Maybe that is
> why very low IOPS is observed in 'Final(hosttag=1)' with 260 depth.
> 
> I'd suggest to run your previous test again after applying this patch,
> and see if difference can be observed.

Hi Ming,

I tested and didn't see a noticeable difference with the fix when using 
the reducing tag queue depth. I got ~500K IOPs with tag queue depth of 
260, as opposed to 2M with full tag queue depth. However I was doubtful 
on this test method before. Regardless, your change and this feature 
still look proper.

@Kashyap, it would be great if you guys could test this also on that 
same setup you described previously:

https://lore.kernel.org/linux-block/29f8062c1fccace73c45252073232917@mail.gmail.com/

Thanks,
John
