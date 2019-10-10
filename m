Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2552DC4360C
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 11:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B5206B6
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 11:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfJJLVv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:21:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56968 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfJJLVv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 07:21:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15C6B5AB97971BB34398;
        Thu, 10 Oct 2019 19:21:49 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 10 Oct 2019
 19:21:45 +0800
Subject: Re: [PATCH V3 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20191008041821.2782-1-ming.lei@redhat.com>
 <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
 <549bf046-f617-4c4f-5bf1-17603cc5f832@huawei.com>
 <20191009083930.GE10549@ming.t460p>
 <a30f6b45-0b89-7950-1e44-240630d89264@huawei.com>
 <20191010103016.GA22976@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <41b9185d-f780-f08f-dd63-9ad02a6976d4@huawei.com>
Date:   Thu, 10 Oct 2019 12:21:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191010103016.GA22976@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/2019 11:30, Ming Lei wrote:
>> Yes, hisi_sas. So, right, it is single queue today on mainline, but I
>> > manually made it multiqueue on my dev branch just to test this series.
>> > Otherwise I could not test it for that driver.
>> >
>> > My dev branch is here, if interested:
>> > https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4-mq
> Your conversion shouldn't work given you do not change .can_queue in the
> patch of 'hisi_sas_v3: multiqueue support'.

Ah, I missed that, but I don't think that it will make a difference 
really since I'm only using a single disk, so I don't think that 
can_queue really comes into play. But....

>
> As discussed before, tags of hisilicon V3 is HBA wide. If you switch
> to real hw queue, each hw queue has to own its independent tags.
> However, that isn't supported by V3 hardware.

I am generating the tag internally in the driver now, so that hostwide 
tags issue should not be an issue.

And, to be clear, I am not paying too much attention to performance, but 
rather just hotplugging while running IO.

An update on testing:
I did some scripted overnight testing. The script essentially loops like 
this:
- online all CPUS
- run fio binded on a limited bunch of CPUs to cover a hctx mask for 1 
minute
- offline those CPUs
- wait 1 minute (> SCSI or NVMe timeout)
- and repeat

SCSI is actually quite stable, but NVMe isn't. For NVMe I am finding 
some fio processes never dying with IOPS @ 0. I don't see any NVMe 
timeout reported. Did you do any NVMe testing of this sort?

Thanks,
John

>
> See previous discussion:
>
> https://marc.info/?t=155928863000001&r=1&w=2
>
>
> Thanks,
> Ming
>
> .
>


