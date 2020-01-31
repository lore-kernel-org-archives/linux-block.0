Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC3C35240
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4736B2465B
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAaRvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:51:10 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbgAaRvK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 12:51:10 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7C13E19125CC133BF037;
        Fri, 31 Jan 2020 17:51:07 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 17:51:07 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 17:51:06 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>, <kbusch@kernel.org>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
 <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
Date:   Fri, 31 Jan 2020 17:51:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+- Keith

On 31/01/2020 10:58, Ming Lei wrote:
> On Fri, Jan 31, 2020 at 6:24 PM John Garry <john.garry@huawei.com> wrote:
>>
>>>> [  141.976109] Call trace:
>>>> [  141.978550]  __switch_to+0xbc/0x218
>>>> [  141.982029]  blk_mq_run_work_fn+0x1c/0x28
>>>> [  141.986027]  process_one_work+0x1e0/0x358
>>>> [  141.990025]  worker_thread+0x40/0x488
>>>> [  141.993678]  kthread+0x118/0x120
>>>> [  141.996897]  ret_from_fork+0x10/0x18
>>>
>>> Hi John,
>>>
>>> Thanks for your test!
>>>
>>
>> Hi Ming,
>>
>>> Could you test the following patchset and only the last one is changed?
>>>
>>> https://github.com/ming1/linux/commits/my_for_5.6_block
>>
>> For SCSI testing, I will ask my colleague Xiang Chen to test when he
>> returns to work. So I did not see this issue for my SCSI testing for
>> your original v5, but I was only using 1x as opposed to maybe 20x SAS disks.
>>
>> BTW, did you test NVMe? For some reason I could not trigger a scenario
>> where we're draining the outstanding requests for a queue which is being
>> deactivated - I mean, the queues were always already quiesced.
> 
> I run cpu hotplug test on both NVMe and SCSI in KVM, and fio just runs
> as expected.
> 
> NVMe is often 1:1 mapping, so it might be a bit difficult to trigger
> draining in-flight IOs.

I generally have a 4:1 mapping for my NVMe cards - so many CPUs.

But more alarming is that I see this on every run:

[  246.378744] psci: CPU6 killed (polled 0 ms)
[  246.427955] irq_migrate_all_off_this_cpu: 3 callbacks suppressed
[  246.427956] IRQ 822: no longer affine to CPU7
[  246.438586] CPU7: shutdown
[  246.441300] psci: CPU7 killed (polled 0 ms)
[  247.015206] pcieport 0000:00:08.0: can't change power state from 
D3cold to D0 (config space inaccessible)
Jobs: 6[  267.503159] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:
[  267.509244] rcu: 25-...0: (1 GPs behind) 
idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=2626
[  267.518283] (detected by 0, t=5255 jiffies, g=14001, q=1787)
[  267.524016] Task dump for CPU 25:
[  267.527318] irqbalance      R  running task        0  1275      1 
0x00000002
[  267.534354] Call trace:
[  267.536790]  __switch_to+0xbc/0x218
[  267.540266]  0xffff800014c53d68
Jobs: 6 (f=6): [R(6)][96.0%][r=0KiB/s[  278.195193] nvme nvme1: 
controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
,w=0KiB/s][r=0,w=0 IOPS][eta 00m:[  278.205197] nvme nvme0: controller 
is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
Jobs: 6 (f=6): [R(6)][0.0%][r=0KiB/s,w=0KiB/s][r=0,w=0 IO[  330.523157] 
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  330.529242] rcu: 25-...0: (1 GPs behind) 
idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=10503
[  330.538366] (detected by 0, t=21010 jiffies, g=14001, q=2318)
[  330.544186] Task dump for CPU 25:
[  330.547488] irqbalance      R  running task        0  1275      1 
0x00000002
[  330.554523] Call trace:
[  330.556958]  __switch_to+0xbc/0x218
[  330.560434]  0xffff800014c53d68
[  393.543155] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  393.549242] rcu: 25-...0: (1 GPs behind) 
idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=18379
[  393.558366] (detected by 8, t=36765 jiffies, g=14001, q=2385)
[  393.564187] Task dump for CPU 25:
[  393.567488] irqbalance      R  running task        0  1275      1 
0x00000002
[  393.574523] Call trace:
[  393.576960]  __switch_to+0xbc/0x218
[  393.580435]  0xffff800014c53d68
[  456.567156] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  456.573246] rcu: 25-...0: (1 GPs behind) 
idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=26255
[  456.582389] (detected by 90, t=52520 jiffies, g=14001, q=2397)
[  456.588296] Task dump for CPU 25:
[  456.591601] irqbalance      R  running task        0  1275      1 
0x00000002
[  456.598638] Call trace:
[  456.601078]  __switch_to+0xbc/0x218
[  456.604556]  0xffff800014c53d68
[  519.587152] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  519.593235] rcu: 25-...0: (1 GPs behind) 
idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=34131
[  519.602357] (detected by 90, t=68275 jiffies, g=14001, q=2405)
[  519.608264] Task dump for CPU 25:
[  519.611566] irqbalance      R  running task        0  1275      1 
0x00000002
[  519.618601] Call trace:
[  519.621036]  __switch_to+0xbc/0x218
[  519.624511]  0xffff800014c53d68
[  582.603153] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  582.609236] rcu: 25-...0: (1 GPs behind) 
idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=42006
[  582.618358] (detected by 90, t=84029 jiffies, g=14001, q=2409)
[  582.624265] Task dump for CPU 25:
[  582.627567] irqbalance      R  running task        0  1275      1 
0x00000002
[  582.634601] Call trace:
[  582.637036]  __switch_to+0xbc/0x218
[  582.640511]  0xffff800014c53d68


I tested v5.5 and I cannot see this, but your branch is based in 5.5-rc2 
with lots of other stuff on top. The only thing I changed was 
nvme.use_threaded_interrupts = 1.

Note that I do see this with v5.5 for my hotplug test, as expected:
[  280.221917] nvme nvme1: I/O 114 QID 19 timeout, completion polledta 
01m:50s]

...so I'm not going insane.

Thanks,
John
