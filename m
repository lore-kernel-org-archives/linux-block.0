Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F43C433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3206A61547
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 13:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhKRNPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:15:33 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26326 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhKRNPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 08:15:33 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hw0T358yLzbj1K;
        Thu, 18 Nov 2021 21:07:35 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 18 Nov 2021 21:12:31 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 18 Nov 2021 21:12:30 +0800
Subject: Re: [QUESTION] blk_mq_freeze_queue in elevator_init_mq
To:     Ming Lei <ming.lei@redhat.com>
CC:     <damien.lemoal@wdc.com>, <axboe@kernel.dk>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-block@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <houtao1@huawei.com>
References: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
 <YZS4FYxtxYAXjtFJ@T590> <d9ca8e57-55b8-96f8-e5fd-6103c8b1fa4b@huawei.com>
 <YZTXMZRxvb5Orsdo@T590>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <4187bb7c-ffc5-433e-4b8f-5f40ea99d447@huawei.com>
Date:   Thu, 18 Nov 2021 21:12:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YZTXMZRxvb5Orsdo@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/11/17 18:19, Ming Lei wrote:
> On Wed, Nov 17, 2021 at 05:00:22PM +0800, yangerkun wrote:
>>
>>
>> On 2021/11/17 16:06, Ming Lei wrote:
>>> On Wed, Nov 17, 2021 at 11:37:13AM +0800, yangerkun wrote:
>>>> Nowdays we meet the boot regression while enable lots of mtdblock
>>>
>>> What is your boot regression? Any dmesg log?
>>
>> The result is that when boot with 5.10 kernel compare with 4.4, 5.10
>> will consume about 1.6s more...
> 
> OK, I understand the issue now, and please try the attached patch
> which depends on the following one:

Hi, this patch can help solve the problem!

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.16&id=2a19b28f7929866e1cec92a3619f4de9f2d20005
> 
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 1f39f6e8ebb9..19a78d5516ba 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -694,12 +694,18 @@ void elevator_init_mq(struct request_queue *q)
>   	if (!e)
>   		return;
>   
> +	/*
> +	 * We are called before adding disk, when there isn't any FS I/O,
> +	 * so freezing queue plus canceling dispatch work is enough to
> +	 * drain any dispatch activities originated from passthrough
> +	 * requests, then no need to quiesce queue which may add long boot
> +	 * latency, especially when lots of disks are involved.
> +	 */
>   	blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue(q);
> +	blk_mq_cancel_work_sync(q);
>   
>   	err = blk_mq_init_sched(q, e);
>   
> -	blk_mq_unquiesce_queue(q);
>   	blk_mq_unfreeze_queue(q);
>   
>   	if (err) {
> 
> 
> 
> thanks,
> Ming
> 
> .
> 
