Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB5C433ED
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D8F60FF0
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 12:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhERMxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 08:53:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3586 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbhERMxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 08:53:24 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fkwmt5hP0zsRpM;
        Tue, 18 May 2021 20:49:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 20:52:03 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 13:52:01 +0100
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        <linux-block@vger.kernel.org>, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com> <YKOiClSTyHl5lbXV@T590>
 <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com> <YKOsQ4StDThlbMko@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <12a651a2-5a0e-15dc-ec40-fc3c57265cd2@huawei.com>
Date:   Tue, 18 May 2021 13:51:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YKOsQ4StDThlbMko@T590>
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

On 18/05/2021 13:00, Ming Lei wrote:
>>> 'Before 620K' could be caused by busy queue when batching submission isn't
>>> applied, so merge chance is increased. This patch applies batching
>>> submission, so queue becomes not busy enough.
>>>
>>> BTW, what is the queue depth of sdev and can_queue of shost for your hisilision SAS?
>> sdev queue depth is 64 (see hisi_sas_slave_configure()) and host depth is
>> 4096 - 96 (for reserved tags) = 4000
> OK, so queue depth should get IO merged if there are too many requests
> queued.
> 
> What is the same read test result without shared tags? still 430K?

I never left a driver switch in place to disable it.

I can forward-port "reply-map" support, which is not too difficult and I 
will let you know the result.

> And what is your exact read test script? And how many cpu cores in
> your system?

64 CPUs, 16x hw queues.

[global]
rw=read
direct=1
ioengine=libaio
iodepth=128
numjobs=1
bs=4k
group_reporting=1
runtime=4500
loops = 10000

[job1]
filename=/dev/sda:
[job1]
filename=/dev/sdc:
[job1]
filename=/dev/sde:
[job1]
filename=/dev/sdf:
[job1]
filename=/dev/sdg:
[job1]
filename=/dev/sdh:

Thanks,
John
