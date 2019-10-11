Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D274FECE58E
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 08:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43B421D82
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 08:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJKIvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:51:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726508AbfJKIvw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Oct 2019 04:51:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0036650C08F214BEEE84;
        Fri, 11 Oct 2019 16:51:49 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 16:51:46 +0800
Subject: Re: [PATCH V3 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20191008041821.2782-1-ming.lei@redhat.com>
 <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
 <549bf046-f617-4c4f-5bf1-17603cc5f832@huawei.com>
 <20191009083930.GE10549@ming.t460p>
 <a30f6b45-0b89-7950-1e44-240630d89264@huawei.com>
 <20191010103016.GA22976@ming.t460p>
 <41b9185d-f780-f08f-dd63-9ad02a6976d4@huawei.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2c0b5542-de7c-ff84-0aae-086cfd6075b7@huawei.com>
Date:   Fri, 11 Oct 2019 09:51:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <41b9185d-f780-f08f-dd63-9ad02a6976d4@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/2019 12:21, John Garry wrote:
>
>>
>> As discussed before, tags of hisilicon V3 is HBA wide. If you switch
>> to real hw queue, each hw queue has to own its independent tags.
>> However, that isn't supported by V3 hardware.
>
> I am generating the tag internally in the driver now, so that hostwide
> tags issue should not be an issue.
>
> And, to be clear, I am not paying too much attention to performance, but
> rather just hotplugging while running IO.
>
> An update on testing:
> I did some scripted overnight testing. The script essentially loops like
> this:
> - online all CPUS
> - run fio binded on a limited bunch of CPUs to cover a hctx mask for 1
> minute
> - offline those CPUs
> - wait 1 minute (> SCSI or NVMe timeout)
> - and repeat
>
> SCSI is actually quite stable, but NVMe isn't. For NVMe I am finding
> some fio processes never dying with IOPS @ 0. I don't see any NVMe
> timeout reported. Did you do any NVMe testing of this sort?
>

Yeah, so for NVMe, I see some sort of regression, like this:
Jobs: 1 (f=1): [_R] [0.0% done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta 
1158037877d:17h:18m:22s]

I have tested against vanilla 5.4 rc1 without problem.

If you can advise some debug to add, then I'd appreciate it. If not, 
I'll try to add some debug to the new paths introduced in this series to 
see if anything I hit coincides with the error state, so will at least 
have a hint...

Thanks,
John


>
>>
>> See previous discussion:
>>
>> https://marc.info/?t=155928863000001&r=1&w=2
>>
>>
>> Thanks,
>> Ming


