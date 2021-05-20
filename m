Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37321C433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B680610A8
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 08:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhETIYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 04:24:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4766 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETIYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 04:24:36 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm2hw0gHYzqVBw;
        Thu, 20 May 2021 16:19:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 16:23:01 +0800
Received: from [10.47.87.246] (10.47.87.246) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 09:22:59 +0100
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        <linux-block@vger.kernel.org>, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com> <YKOiClSTyHl5lbXV@T590>
 <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com> <YKOsQ4StDThlbMko@T590>
 <12a651a2-5a0e-15dc-ec40-fc3c57265cd2@huawei.com>
 <676e9667-3022-7fde-4518-e82eb0503ec8@huawei.com> <YKRaGT5PjCvH+12p@T590>
 <aa667e0d-0b42-08c2-35e1-387e2e92dc43@huawei.com> <YKW6G1flax9vkfIR@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ad6318cf-d0ef-4385-c25a-3128bf458602@huawei.com>
Date:   Thu, 20 May 2021 09:21:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YKW6G1flax9vkfIR@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.246]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/05/2021 02:23, Ming Lei wrote:
>> BTW, recently we have seen 2x optimisation/improvement for shared sbitmap
>> which were under/related to nr_hw_queues == 1 check - this patch and the
>> changing of the default IO sched.
> You mean you saw 2X improvement in your hisilicon SAS compared with
> non-shared sbitmap? In Yanhui's virt test, we just bring back the perf
> to non-shared sbitmap's level.
> 

Sorry, I meant one improvement is using mq-deadline by default, and 
other improvement is the change in this patch. I didn't mean a double in 
throughput.

Thanks,
John
