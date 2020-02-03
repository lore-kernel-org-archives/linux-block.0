Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF76C33CAC
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B682080D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgBCM4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:56:25 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2353 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbgBCM4Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 07:56:25 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A1C631525722C4BA05A5;
        Mon,  3 Feb 2020 12:56:23 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 12:56:23 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 12:56:22 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Ming Lei" <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Keith Busch <kbusch@kernel.org>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
 <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
 <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
 <56502aa9-d4ad-5ede-5184-13f1817c77d7@huawei.com>
 <CACVXFVNiBOBdtwuW=q4aSmUMAnn6Gfpg6BGhcQu44s58NZ08Ww@mail.gmail.com>
 <20200201110539.03db5434@why> <87sgjutufz.fsf@nanos.tec.linutronix.de>
 <3db522f4-c0c3-ce0f-b0e3-57ee1176bbf8@huawei.com>
 <797432ab-1ef5-92e3-b512-bdcee57d1053@huawei.com>
 <CACVXFVOijCDjFa339Dyxnp9_0W5UjDyF-a42Dmo-6pogu+rp5Q@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b0f35177-70f3-541d-996b-ebb364634225@huawei.com>
Date:   Mon, 3 Feb 2020 12:56:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CACVXFVOijCDjFa339Dyxnp9_0W5UjDyF-a42Dmo-6pogu+rp5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>>
>>> Jobs: 6 ([  519.858094] nvme nvme1: controller is down; will reset:
>>> CSTS=0xffffffff, PCI_STATUS=0xffff
>>>
>>> And some NVMe error also coincides with the hang. Another run has this:
>>>
>>>    [  247.015206] pcieport 0000:00:08.0: can't change power state from
>>>    D3cold to D0 (config space inaccessible)
>>>
>>> I did test v5.4 previously and did not see this, but that would have
>>> included the v4 patchset in the $subject. I'll test v5.4 without that
>>> patchset now.
>>
>> So v5.4 does have this issue also:
> 
> v5.5?

I am saying that both v5.4 and v5.5 have the issue. Below is the kernel 
hang snippet for v5.4.

> 
>>
>> [  705.669512] psci: CPU24 killed (polled 0 ms)
>> [  705.966753] CPU25: shutdown
>> [  705.969548] psci: CPU25 killed (polled 0 ms)
>> [  706.250771] CPU26: shutdown=2347MiB/s,w=0KiB/s][r=601k,w=0 IOPS][eta
>> 00m:13s]
>> [  706.253565] psci: CPU26 killed (polled 0 ms)
>> [  706.514728] CPU27: shutdown
>> [  706.517523] psci: CPU27 killed (polled 0 ms)
>> [  706.826708] CPU28: shutdown
>> [  706.829502] psci: CPU28 killed (polled 0 ms)
>> [  707.130916] CPU29: shutdown=2134MiB/s,w=0KiB/s][r=546k,w=0 IOPS][eta
>> 00m:12s]
>> [  707.133714] psci: CPU29 killed (polled 0 ms)
>> [  707.439066] CPU30: shutdown
>> [  707.441870] psci: CPU30 killed (polled 0 ms)
>> [  707.706727] CPU31: shutdown
>> [  707.709526] psci: CPU31 killed (polled 0 ms)
>> [  708.521853] pcieport 0000:00:08.0: can't change power state from
>> D3cold to D0 (config space inaccessible)
>> [  728.741808] rcu: INFO: rcu_preempt detected stalls on
>> CPUs/tasks:80d:00h:35m:42s]
>> [  728.747895] rcu: 48-...0: (0 ticks this GP)
>> idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=2626
>> [  728.757197] (detected by 63, t=5255 jiffies, g=40989, q=1890)
>> [  728.763018] Task dump for CPU 48:
>> [  728.766321] irqbalance      R  running task        0  1272      1
>> 0x00000002
>> [  728.773358] Call trace:
>> [  728.775801]  __switch_to+0xbc/0x218
>> [  728.779283]  gic_set_affinity+0x16c/0x1d8
>> [  728.783282]  irq_do_set_affinity+0x30/0xd0
>> [  728.787365]  irq_set_affinity_locked+0xc8/0xf0
>> [  728.791796]  __irq_set_affinity+0x4c/0x80
>> [  728.795794]  write_irq_affinity.isra.7+0x104/0x120
>> [  728.800572]  irq_affinity_proc_write+0x1c/0x28
>> [  728.805008]  proc_reg_write+0x78/0xb8
>> [  728.808660]  __vfs_write+0x18/0x38
>> [  728.812050]  vfs_write+0xb4/0x1e0
>> [  728.815352]  ksys_write+0x68/0xf8
>> [  728.818655]  __arm64_sys_write+0x18/0x20
>> [  728.822567]  el0_svc_common.constprop.2+0x64/0x160
>> [  728.827345]  el0_svc_handler+0x20/0x80
>> [  728.831082]  el0_sync_handler+0xe4/0x188
>> [  728.834991]  el0_sync+0x140/0x180
>> [  738.993844] nvme nvme1: controller is down; will reset:
>> CSTS=0xffffffff, PCI_STATUS=0xffff
>> [  791.761810] rcu: INFO: rcu_preempt detected stalls on
>> CPUs/tasks:63d:14h:24m:13s]
>> [  791.767897] rcu: 48-...0: (0 ticks this GP)
>> idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=10495
>> [  791.777281] (detected by 54, t=21010 jiffies, g=40989, q=2396)
>> [  791.783189] Task dump for CPU 48:
>> [  791.786491] irqbalance      R  running task        0  1272      1
>> 0x00000002
>> [  791.793528] Call trace:
>> [  791.795964]  __switch_to+0xbc/0x218
>> [  791.799441]  gic_set_affinity+0x16c/0x1d8
>> [  791.803439]  irq_do_set_affinity+0x30/0xd0
>> [  791.807522]  irq_set_affinity_locked+0xc8/0xf0
>> [  791.811953]  __irq_set_affinity+0x4c/0x80
>> [  791.815949]  write_irq_affinity.isra.7+0x104/0x120
>> [  791.820727]  irq_affinity_proc_write+0x1c/0x28
>> [  791.825158]  proc_reg_write+0x78/0xb8
>> [  791.828808]  __vfs_write+0x18/0x38
>> [  791.832197]  vfs_write+0xb4/0x1e0
>> [  791.835500]  ksys_write+0x68/0xf8
>> [  791.838802]  __arm64_sys_write+0x18/0x20
>> [  791.842712]  el0_svc_common.constprop.2+0x64/0x160
>> [  791.847490]  el0_svc_handler+0x20/0x80
>> [  791.851226]  el0_sync_handler+0xe4/0x188
>> [  791.855135]  el0_sync+0x140/0x180
>> Jobs: 6 (f=6): [R(6)][0.0%][r=0KiB/s
> 
> Can you trigger it after disabling irqbalance?

No, so tested by killing the irqbalance process and it ran for 25 
minutes without issue.

Thanks,
John
