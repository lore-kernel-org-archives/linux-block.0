Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D1C47404
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 08:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D728206B6
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 08:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfJIIts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:49:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfJIIts (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Oct 2019 04:49:48 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 350FB3C13B73B972D256;
        Wed,  9 Oct 2019 16:49:46 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 16:49:40 +0800
Subject: Re: [PATCH V3 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20191008041821.2782-1-ming.lei@redhat.com>
 <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
 <549bf046-f617-4c4f-5bf1-17603cc5f832@huawei.com>
 <20191009083930.GE10549@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a30f6b45-0b89-7950-1e44-240630d89264@huawei.com>
Date:   Wed, 9 Oct 2019 09:49:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191009083930.GE10549@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>>> - steal bios from the request, and resubmit them via
>>>> generic_make_request(),
>>>> then these IO will be mapped to other live hctx for dispatch
>>>>
>>>> Please comment & review, thanks!
>>>>
>>>> John, I don't add your tested-by tag since V3 have some changes,
>>>> and I appreciate if you may run your test on V3.
>>>>
>>>
>>> Will do, Thanks
>>
>> Hi Ming,
>>
>> I got this warning once:
>>
>> [  162.558185] CPU10: shutdown
>> [  162.560994] psci: CPU10 killed.
>> [  162.593939] CPU9: shutdown
>> [  162.596645] psci: CPU9 killed.
>> [  162.625838] CPU8: shutdown
>> [  162.628550] psci: CPU8 killed.
>> [  162.685790] CPU7: shutdown
>> [  162.688496] psci: CPU7 killed.
>> [  162.725771] CPU6: shutdown
>> [  162.728486] psci: CPU6 killed.
>> [  162.753884] CPU5: shutdown
>> [  162.756591] psci: CPU5 killed.
>> [  162.785584] irq_shutdown
>> [  162.788277] IRQ 800: no longer affine to CPU4
>> [  162.793267] CPU4: shutdown
>> [  162.795975] psci: CPU4 killed.
>> [  162.849680] run queue from wrong CPU 13, hctx active
>> [  162.849692] CPU3: shutdown
>> [  162.854649] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted
>> 5.4.0-rc1-00012-gad025dd3d001 #1098
>> [  162.854653] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 -
>> V1.16.01 03/15/2019
>> [  162.857362] psci: CPU3 killed.
>> [  162.866039] Workqueue: kblockd blk_mq_run_work_fn
>> [  162.882281] Call trace:
>> [  162.884716]  dump_backtrace+0x0/0x150
>> [  162.888365]  show_stack+0x14/0x20
>> [  162.891668]  dump_stack+0xb0/0xf8
>> [  162.894970]  __blk_mq_run_hw_queue+0x11c/0x128
>> [  162.899400]  blk_mq_run_work_fn+0x1c/0x28
>> [  162.903397]  process_one_work+0x1e0/0x358
>> [  162.907393]  worker_thread+0x40/0x488
>> [  162.911042]  kthread+0x118/0x120
>> [  162.914257]  ret_from_fork+0x10/0x18
>
> What is the HBA? If it is Hisilicon SAS, it isn't strange, because
> this patch can't fix single hw queue with multiple private reply queue
> yet, that can be one follow-up job of this patchset.
>

Yes, hisi_sas. So, right, it is single queue today on mainline, but I 
manually made it multiqueue on my dev branch just to test this series. 
Otherwise I could not test it for that driver.

My dev branch is here, if interested:
https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4-mq

I am also going to retest NVMe.

Thanks,
John

> Thanks,
> Ming
>
> .
>


