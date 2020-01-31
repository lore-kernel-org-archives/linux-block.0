Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E205CC2D0DB
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F12173E
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 18:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgAaSCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:02:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2345 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbgAaSCr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 13:02:47 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 71ED8FC64F6340F15B06;
        Fri, 31 Jan 2020 18:02:45 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 18:02:45 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 18:02:44 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>, <kbusch@kernel.org>,
        Marc Zyngier <maz@kernel.org>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
 <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
 <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
Message-ID: <56502aa9-d4ad-5ede-5184-13f1817c77d7@huawei.com>
Date:   Fri, 31 Jan 2020 18:02:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 31/01/2020 17:51, John Garry wrote:
> +- Keith

+ Marc, on rare chance that this is related to the GIC

> 
> On 31/01/2020 10:58, Ming Lei wrote:
>> On Fri, Jan 31, 2020 at 6:24 PM John Garry <john.garry@huawei.com> wrote:
>>>
>>>>> [  141.976109] Call trace:
>>>>> [  141.978550]  __switch_to+0xbc/0x218
>>>>> [  141.982029]  blk_mq_run_work_fn+0x1c/0x28
>>>>> [  141.986027]  process_one_work+0x1e0/0x358
>>>>> [  141.990025]  worker_thread+0x40/0x488
>>>>> [  141.993678]  kthread+0x118/0x120
>>>>> [  141.996897]  ret_from_fork+0x10/0x18
>>>>
>>>> Hi John,
>>>>
>>>> Thanks for your test!
>>>>
>>>
>>> Hi Ming,
>>>
>>>> Could you test the following patchset and only the last one is changed?
>>>>
>>>> https://github.com/ming1/linux/commits/my_for_5.6_block
>>>
>>> For SCSI testing, I will ask my colleague Xiang Chen to test when he
>>> returns to work. So I did not see this issue for my SCSI testing for
>>> your original v5, but I was only using 1x as opposed to maybe 20x SAS 
>>> disks.
>>>
>>> BTW, did you test NVMe? For some reason I could not trigger a scenario
>>> where we're draining the outstanding requests for a queue which is being
>>> deactivated - I mean, the queues were always already quiesced.
>>
>> I run cpu hotplug test on both NVMe and SCSI in KVM, and fio just runs
>> as expected.
>>
>> NVMe is often 1:1 mapping, so it might be a bit difficult to trigger
>> draining in-flight IOs.
> 
> I generally have a 4:1 mapping for my NVMe cards - so many CPUs.
> 
> But more alarming is that I see this on every run:
> 
> [  246.378744] psci: CPU6 killed (polled 0 ms)
> [  246.427955] irq_migrate_all_off_this_cpu: 3 callbacks suppressed
> [  246.427956] IRQ 822: no longer affine to CPU7
> [  246.438586] CPU7: shutdown
> [  246.441300] psci: CPU7 killed (polled 0 ms)
> [  247.015206] pcieport 0000:00:08.0: can't change power state from 
> D3cold to D0 (config space inaccessible)
> Jobs: 6[  267.503159] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  267.509244] rcu: 25-...0: (1 GPs behind) 
> idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=2626
> [  267.518283] (detected by 0, t=5255 jiffies, g=14001, q=1787)
> [  267.524016] Task dump for CPU 25:
> [  267.527318] irqbalance      R  running task        0  1275      1 
> 0x00000002
> [  267.534354] Call trace:
> [  267.536790]  __switch_to+0xbc/0x218
> [  267.540266]  0xffff800014c53d68
> Jobs: 6 (f=6): [R(6)][96.0%][r=0KiB/s[  278.195193] nvme nvme1: 
> controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> ,w=0KiB/s][r=0,w=0 IOPS][eta 00m:[  278.205197] nvme nvme0: controller 
> is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> Jobs: 6 (f=6): [R(6)][0.0%][r=0KiB/s,w=0KiB/s][r=0,w=0 IO[  330.523157] 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  330.529242] rcu: 25-...0: (1 GPs behind) 
> idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=10503
> [  330.538366] (detected by 0, t=21010 jiffies, g=14001, q=2318)
> [  330.544186] Task dump for CPU 25:
> [  330.547488] irqbalance      R  running task        0  1275      1 
> 0x00000002
> [  330.554523] Call trace:
> [  330.556958]  __switch_to+0xbc/0x218
> [  330.560434]  0xffff800014c53d68
> [  393.543155] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  393.549242] rcu: 25-...0: (1 GPs behind) 
> idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=18379
> [  393.558366] (detected by 8, t=36765 jiffies, g=14001, q=2385)
> [  393.564187] Task dump for CPU 25:
> [  393.567488] irqbalance      R  running task        0  1275      1 
> 0x00000002
> [  393.574523] Call trace:
> [  393.576960]  __switch_to+0xbc/0x218
> [  393.580435]  0xffff800014c53d68
> [  456.567156] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  456.573246] rcu: 25-...0: (1 GPs behind) 
> idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=26255
> [  456.582389] (detected by 90, t=52520 jiffies, g=14001, q=2397)
> [  456.588296] Task dump for CPU 25:
> [  456.591601] irqbalance      R  running task        0  1275      1 
> 0x00000002
> [  456.598638] Call trace:
> [  456.601078]  __switch_to+0xbc/0x218
> [  456.604556]  0xffff800014c53d68
> [  519.587152] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  519.593235] rcu: 25-...0: (1 GPs behind) 
> idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=34131
> [  519.602357] (detected by 90, t=68275 jiffies, g=14001, q=2405)
> [  519.608264] Task dump for CPU 25:
> [  519.611566] irqbalance      R  running task        0  1275      1 
> 0x00000002
> [  519.618601] Call trace:
> [  519.621036]  __switch_to+0xbc/0x218
> [  519.624511]  0xffff800014c53d68
> [  582.603153] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  582.609236] rcu: 25-...0: (1 GPs behind) 
> idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=42006
> [  582.618358] (detected by 90, t=84029 jiffies, g=14001, q=2409)
> [  582.624265] Task dump for CPU 25:
> [  582.627567] irqbalance      R  running task        0  1275      1 
> 0x00000002
> [  582.634601] Call trace:
> [  582.637036]  __switch_to+0xbc/0x218
> [  582.640511]  0xffff800014c53d68
> 
> 
> I tested v5.5 and I cannot see this, but your branch is based in 5.5-rc2 
> with lots of other stuff on top. The only thing I changed was 
> nvme.use_threaded_interrupts = 1.

Uhh, now I do with v5.5:

[  705.354601] CPU22: shutdown
[  705.357395] psci: CPU22 killed (polled 0 ms)
[  705.402837] CPU23: shutdown
[  705.405630] psci: CPU23 killed (polled 0 ms)
[  705.666716] CPU24: shutdown
[  705.669512] psci: CPU24 killed (polled 0 ms)
[  705.966753] CPU25: shutdown
[  705.969548] psci: CPU25 killed (polled 0 ms)
[  706.250771] CPU26: shutdown=2347MiB/s,w=0KiB/s][r=601k,w=0 IOPS][eta 
00m:13s]
[  706.253565] psci: CPU26 killed (polled 0 ms)
[  706.514728] CPU27: shutdown
[  706.517523] psci: CPU27 killed (polled 0 ms)
[  706.826708] CPU28: shutdown
[  706.829502] psci: CPU28 killed (polled 0 ms)
[  707.130916] CPU29: shutdown=2134MiB/s,w=0KiB/s][r=546k,w=0 IOPS][eta 
00m:12s]
[  707.133714] psci: CPU29 killed (polled 0 ms)
[  707.439066] CPU30: shutdown
[  707.441870] psci: CPU30 killed (polled 0 ms)
[  707.706727] CPU31: shutdown
[  707.709526] psci: CPU31 killed (polled 0 ms)
[  708.521853] pcieport 0000:00:08.0: can't change power state from 
D3cold to D0 (config space inaccessible)
[  728.741808] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:80d:00h:35m:42s]
[  728.747895] rcu: 48-...0: (0 ticks this GP) 
idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=2626
[  728.757197] (detected by 63, t=5255 jiffies, g=40989, q=1890)
[  728.763018] Task dump for CPU 48:
[  728.766321] irqbalance      R  running task        0  1272      1 
0x00000002
[  728.773358] Call trace:
[  728.775801]  __switch_to+0xbc/0x218
[  728.779283]  gic_set_affinity+0x16c/0x1d8
[  728.783282]  irq_do_set_affinity+0x30/0xd0
[  728.787365]  irq_set_affinity_locked+0xc8/0xf0
[  728.791796]  __irq_set_affinity+0x4c/0x80
[  728.795794]  write_irq_affinity.isra.7+0x104/0x120
[  728.800572]  irq_affinity_proc_write+0x1c/0x28
[  728.805008]  proc_reg_write+0x78/0xb8
[  728.808660]  __vfs_write+0x18/0x38
[  728.812050]  vfs_write+0xb4/0x1e0
[  728.815352]  ksys_write+0x68/0xf8
[  728.818655]  __arm64_sys_write+0x18/0x20
[  728.822567]  el0_svc_common.constprop.2+0x64/0x160
[  728.827345]  el0_svc_handler+0x20/0x80
[  728.831082]  el0_sync_handler+0xe4/0x188
[  728.834991]  el0_sync+0x140/0x180
[  738.993844] nvme nvme1: controller is down; will reset: 
CSTS=0xffffffff, PCI_STATUS=0xffff
[  791.761810] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:63d:14h:24m:13s]
[  791.767897] rcu: 48-...0: (0 ticks this GP) 
idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=10495
[  791.777281] (detected by 54, t=21010 jiffies, g=40989, q=2396)
[  791.783189] Task dump for CPU 48:
[  791.786491] irqbalance      R  running task        0  1272      1 
0x00000002
[  791.793528] Call trace:
[  791.795964]  __switch_to+0xbc/0x218
[  791.799441]  gic_set_affinity+0x16c/0x1d8
[  791.803439]  irq_do_set_affinity+0x30/0xd0
[  791.807522]  irq_set_affinity_locked+0xc8/0xf0
[  791.811953]  __irq_set_affinity+0x4c/0x80
[  791.815949]  write_irq_affinity.isra.7+0x104/0x120
[  791.820727]  irq_affinity_proc_write+0x1c/0x28
[  791.825158]  proc_reg_write+0x78/0xb8
[  791.828808]  __vfs_write+0x18/0x38
[  791.832197]  vfs_write+0xb4/0x1e0
[  791.835500]  ksys_write+0x68/0xf8
[  791.838802]  __arm64_sys_write+0x18/0x20
[  791.842712]  el0_svc_common.constprop.2+0x64/0x160
[  791.847490]  el0_svc_handler+0x20/0x80
[  791.851226]  el0_sync_handler+0xe4/0x188
[  791.855135]  el0_sync+0x140/0x180
Jobs: 6 (f=6): [R(6)][0.0%][r=0KiB/s


> 
> Note that I do see this with v5.5 for my hotplug test, as expected:
> [  280.221917] nvme nvme1: I/O 114 QID 19 timeout, completion polledta 
> 01m:50s]
> 
> ...so I'm not going insane.
> 

Thanks,John

