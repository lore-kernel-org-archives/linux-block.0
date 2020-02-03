Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF48C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696FB20838
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 18:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgBCSQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:16:52 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2361 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbgBCSQw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 13:16:52 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D46D9E1EFA830788AD8E;
        Mon,  3 Feb 2020 18:16:48 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 18:16:48 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 18:16:48 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <tom.leiming@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
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
 <b0f35177-70f3-541d-996b-ebb364634225@huawei.com>
 <f759c5bca7de4b2af2e1cabd2f476e3c@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7ae71bf1-fd1f-d97e-1e72-646e2e6c8b3c@huawei.com>
Date:   Mon, 3 Feb 2020 18:16:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f759c5bca7de4b2af2e1cabd2f476e3c@kernel.org>
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

On 03/02/2020 15:43, Marc Zyngier wrote:
> On 2020-02-03 12:56, John Garry wrote:
> 
> [...]
> 
>>> Can you trigger it after disabling irqbalance?
>>
>> No, so tested by killing the irqbalance process and it ran for 25
>> minutes without issue.
> 
> OK, that's interesting.
> 
> Can you find you whether irqbalance tries to move an interrupt to an 
> offlined CPU?
> Just putting a trace into git_set_affinity() should be enough.
> 

Hi Marc,

I should have mentioned this already, but this board is the same D06 
which I reported had the CPU0 hotplug issue from broken FW, if you remember:

https://lore.kernel.org/linux-arm-kernel/fd70f499-83b4-2fdd-d043-ea9ab8f2c636@huawei.com/

That's why I'm not including CPU0 in my hotplug testing. Other CPUs were 
fine. And it doesn't look like that issue.

Apart from that, I tried as you suggested, with this change:

+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1143,6 +1143,9 @@ static int gic_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,
  	int enabled;
  	u64 val;

+	pr_err("%s irq%d mask_val=%*pbl cpu_online_mask=%*pbl force=%d 
cpumask_any_and=%d\n", __func__, d->irq, cpumask_pr_args(mask_val),
cpumask_pr_args(cpu_online_mask), force, pumask_any_and(cpu_online_mask, 
mask_val));

  	if (force)
  		cpu = cpumask_first(mask_val);
  	else
@@ -1176,6 +1179,9 @@ static int gic_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,

  	irq_data_update_effective_affinity(d, cpumask_of(cpu));

+	pr_err("%s1 irq%d mask_val=%*pbl cpu_online_mask=%*pbl force=%d 
cpumask_any_and=%d cpu=%d\n", __func__,	d->irq, 
cpumask_pr_args(mask_val), cpumask_pr_args(cpu_online_mask), force, 
cpumask_any_and(cpu_online_mask, mask_val), cpu);
+
  	return IRQ_SET_MASK_OK_DONE;
  }

And see this:

polled 0 ms)
[  947.551340] GICv3: gic_set_affinity irq5 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44
[  947.560986] GICv3: gic_set_affinity1 irq5 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44 cpu=44
[  947.571321] GICv3: gic_set_affinity irq8 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44
[  947.580963] GICv3: gic_set_affinity1 irq8 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44 cpu=44
[  947.591581] IRQ 819: no longer affine to CPU43
[  947.596149] CPU43: shutdown
[  947.598945] psci: CPU43 killed (polled 0 ms)
[  947.607029] GICv3: gic_set_affinity irq5 mask_val=29-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44
Jobs: 6 (f=6): [R(6)][0.0%][r=0KiB/[  968.614971] rcu: INFO: rcu_preempt 
detected stalls on CPUs/tasks:
[  968.621062] rcu: 66-...0: (0 ticks this GP) 
idle=d9a/1/0x4000000000000000 softirq=3654/3654 fqs=2625
[  968.630365] (detected by 69, t=5256 jiffies, g=51577, q=1884)
[  968.636187] Task dump for CPU 66:
[  968.639490] irqbalance      R  running task        0  1577      1 
0x00000002
[  968.646527] Call trace:
[  968.648970]  __switch_to+0xbc/0x218
[  968.652450]  irq_do_set_affinity+0x30/0xd0
[  968.656534]  irq_set_affinity_locked+0xc8/0xf0
[  968.660965]  __irq_set_affinity+0x4c/0x80
[  968.664963]  write_irq_affinity.isra.7+0x104/0x120
[  968.669741]  irq_affinity_proc_write+0x1c/0x28
[  968.674175]  proc_reg_write+0x78/0xb8
[  968.677827]  __vfs_write+0x18/0x38
[  968.681217]  vfs_write+0xb4/0x1e0
[  968.684519]  ksys_write+0x68/0xf8
[  968.687822]  __arm64_sys_write+0x18/0x20
[  968.691733]  el0_svc_common.constprop.2+0x64/0x160
[  968.696511]  el0_svc_handler+0x20/0x80
[  968.700247]  el0_sync_handler+0xe4/0x188
[  968.704157]  el0_sync+0x140/0x180

and this on a 2nd run:

[  215.468476] CPU42: shutdown
[  215.471272] psci: CPU42 killed (polled 0 ms)
[  215.723714] GICv3: gic_set_affinity irq5 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44
[  215.733360] GICv3: gic_set_affinity1 irq5 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44 cpu=44
[  215.743696] GICv3: gic_set_affinity irq8 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44
[  215.753338] GICv3: gic_set_affinity1 irq8 mask_val=24-47 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=44 cpu=44
[  215.763835] IRQ 426: no longer affine to CPU43
[  215.768412] IRQ 819: no longer affine to CPU43
[  215.773023] CPU43: shutdown
Jobs: 6 (f=6): [R(6)][76.9%][r=13[  215.775834] psci: CPU43 killed 
(polled 0 ms)
[  216.604779] GICv3: gic_set_affinity irq10 mask_val=53 
cpu_online_mask=0,44-95 force=0 cpumask_any_and=53
[  217.223461] pcieport 0000:00:08.0: can't change power state from 
D3cold to D0 (config space inaccessible)
[  237.615383] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:2d:17h:39m:00s]
[  237.621469] rcu: 58-...0: (1 GPs behind) 
idle=b5e/1/0x4000000000000000 softirq=1908/1908 fqs=2626
[  237.630525] (detected by 44, t=5254 jiffies, g=12137, q=191)
[  237.636260] Task dump for CPU 58:
[  237.639563] irqbalance      R  running task        0  1567      1 
0x00000002
[  237.646599] Call trace:
[  237.649037]  __switch_to+0xbc/0x218
[  237.652513]  0xffff80001529bd68
[  239.283412] nvme nvme1: controller is down; will reset: 
CSTS=0xffffffff, PCI_STATUS=0xffff
[  300.635382] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:03d:01h:02m:56s]
[  300.641466] rcu: 58-...0: (1 GPs behind) 
idle=b5e/1/0x4000000000000000 softirq=1908/1908 fqs=10503
[  300.650589] (detected by 44, t=21010 jiffies, g=12137, q=698)
[  300.656410] Task dump for CPU 58:
[  300.659712] irqbalance      R  running task        0  1567      1 
0x00000002
[  300.666747] Call trace:

Info about irq5 and irq10 after booting:

john@ubuntu:~$ ls /proc/irq/5
affinity_hint       effective_affinity_list  smp_affinity       spurious
effective_affinity  node                     smp_affinity_list  uart-pl011
john@ubuntu:~$ more /proc/irq/5/smp_affinity_list
24-47
john@ubuntu:~$ ls /proc/irq/10
affinity_hint            ehci_hcd:usb1  ohci_hcd:usb3  smp_affinity_list
effective_affinity       ehci_hcd:usb2  ohci_hcd:usb4  spurious
effective_affinity_list  node           smp_affinity
john@ubuntu:~$ more /proc/irq/10/smp_affinity_list
71

Thanks,
John
