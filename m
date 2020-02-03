Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78330C3524D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBAC20721
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBCKa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:30:56 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727511AbgBCKaz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 05:30:55 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9D00ABCFE4ADD639FE20;
        Mon,  3 Feb 2020 10:30:51 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 10:30:51 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 10:30:51 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Ming Lei" <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Keith Busch <kbusch@kernel.org>
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
Message-ID: <3db522f4-c0c3-ce0f-b0e3-57ee1176bbf8@huawei.com>
Date:   Mon, 3 Feb 2020 10:30:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87sgjutufz.fsf@nanos.tec.linutronix.de>
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

On 01/02/2020 11:31, Thomas Gleixner wrote:
> Marc Zyngier <maz@kernel.org> writes:
>> On Sat, 1 Feb 2020 09:31:17 +0800
>> Ming Lei <tom.leiming@gmail.com> wrote:
>>> On Sat, Feb 1, 2020 at 2:02 AM John Garry <john.garry@huawei.com> wrote:
>>>
>>> gic_set_affinity shouldn't have switched out, so looks like one gic
>>> issue.
>>
>> Given that gic_set_affinity doesn't sleep, this looks pretty unlikely.
>> And __irq_set_affinity() holds a spinlock with irq disabled, so I can't
>> really explain how you'd get there. I've just booted a lockdep enabled
>> v5.5 on my D05, moved SPIs around (because that's the only way to reach
>> this code), and nothing caught fire.
>>
>> Either the stack trace isn't reliable (when I read things like
>> "80d:00h:35m:42s" in the trace, I'm a bit suspicious), or CPU hotplug is
>> doing something really funky here.
> 
> The hotplug code cannot end up in schedule either and it holds desc lock
> as normal affinity setting. The other backtrace is more complete,
> 
> [  728.741808] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:80d:00h:35m:42s]
> [  728.747895] rcu: 48-...0: (0 ticks this GP) idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=2626
> [  728.757197] (detected by 63, t=5255 jiffies, g=40989, q=1890)
> [  728.763018] Task dump for CPU 48:
> [  728.766321] irqbalance      R  running task        0  1272      1 0x00000002
> [  728.773358] Call trace:
> [  728.775801]  __switch_to+0xbc/0x218
> [  728.779283]  gic_set_affinity+0x16c/0x1d8
> [  728.783282]  irq_do_set_affinity+0x30/0xd0
> [  728.787365]  irq_set_affinity_locked+0xc8/0xf0
> [  728.791796]  __irq_set_affinity+0x4c/0x80
> [  728.795794]  write_irq_affinity.isra.7+0x104/0x120
> [  728.800572]  irq_affinity_proc_write+0x1c/0x28
> [  728.805008]  proc_reg_write+0x78/0xb8
> [  728.808660]  __vfs_write+0x18/0x38
> [  728.812050]  vfs_write+0xb4/0x1e0
> [  728.815352]  ksys_write+0x68/0xf8
> [  728.818655]  __arm64_sys_write+0x18/0x20
> [  728.822567]  el0_svc_common.constprop.2+0x64/0x160
> [  728.827345]  el0_svc_handler+0x20/0x80
> [  728.831082]  el0_sync_handler+0xe4/0x188
> [  728.834991]  el0_sync+0x140/0x180
> 
> But the __switch_to() there definitely does not make any sense at all.

I have put a full kernel log here for another run (hang snippet at end), 
including scripts:

https://pastebin.com/N4Gi5it6

This does not look good:

Jobs: 6 ([  519.858094] nvme nvme1: controller is down; will reset: 
CSTS=0xffffffff, PCI_STATUS=0xffff

And some NVMe error also coincides with the hang. Another run has this:

  [  247.015206] pcieport 0000:00:08.0: can't change power state from
  D3cold to D0 (config space inaccessible)

I did test v5.4 previously and did not see this, but that would have 
included the v4 patchset in the $subject. I'll test v5.4 without that 
patchset now.

Thanks,
John



[  487.442928] CPU32: shutdown=2149MiB/s,w=0KiB/s][r=550k,w=0 IOPS][eta 
00m:11s]
[  487.445722] psci: CPU32 killed (polled 0 ms)
[  487.762957] CPU33: shutdown
[  487.765752] psci: CPU33 killed (polled 0 ms)
[  488.054863] CPU34: shutdown
[  488.057659] psci: CPU34 killed (polled 0 ms)
[  488.342910] CPU35: shutdown=2137MiB/s,w=0KiB/s][r=547k,w=0 IOPS][eta 
00m:10s]
[  488.345704] psci: CPU35 killed (polled 0 ms)
Jobs: 6[  509.614051] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:
[  509.620140] rcu:     0-...0: (1 GPs behind) 
idle=896/1/0x4000000000000000 softirq=7411/7412 fqs=2626
[  509.629087] rcu:     36-...!: (0 ticks this GP) 
idle=ad2/1/0x4000000000000000 softirq=2631/2631 fqs=2627
[  509.638398]  (detected by 74, t=5257 jiffies, g=24921, q=1785)
[  509.644218] Task dump for CPU 0:
[  509.647435] irqbalance      R  running task        0  1308      1 
0x00000002
[  509.654472] Call trace:
[  509.656913]  __switch_to+0xbc/0x218
[  509.660392]  0xffff800017043d68
[  509.663521] Task dump for CPU 36:
[  509.666824] cpuhp/36        R  running task        0   192      2 
0x0000002a
[  509.673860] Call trace:
[  509.676295]  __switch_to+0xbc/0x218
[  509.679776]  page_wait_table+0x1500/0x1800
Jobs: 6 ([  519.858094] nvme nvme1: controller is down; will reset: 
CSTS=0xffffffff, PCI_STATUS=0xffff
Jobs: 6 (f=6[  572.634049] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:6s]
[  572.640136] rcu:     0-...0: (1 GPs behind) 
idle=896/1/0x4000000000000000 softirq=7411/7412 fqs=10499
[  572.649171] rcu:     36-...!: (0 ticks this GP) 
idle=ad2/1/0x4000000000000000 softirq=2631/2631 fqs=10500
[  572.658561]  (detected by 51, t=21012 jiffies, g=24921, q=2275)
[  572.664469] Task dump for CPU 0:
[  572.667685] irqbalance      R  running task        0  1308      1 
0x00000002
[  572.674723] Call trace:
[  572.677164]  __switch_to+0xbc/0x218
[  572.680641]  0xffff800017043d68
[  572.683772] Task dump for CPU 36:
[  572.687076] cpuhp/36        R  running task        0   192      2 
0x0000002a
[  572.694112] Call trace:
[  572.696547]  __switch_to+0xbc/0x218
[  572.700027]  page_wait_table+0x1500/0x1800
[  635.654053] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  635.660141] rcu:     0-...0: (1 GPs behind) 
idle=896/1/0x4000000000000000 softirq=7411/7412 fqs=18372
[  635.669175] rcu:     36-...!: (0 ticks this GP) 
idle=ad2/1/0x4000000000000000 softirq=2631/2631 fqs=18373
[  635.678576]  (detected by 92, t=36768 jiffies, g=24921, q=2279)
[  635.684482] Task dump for CPU 0:
[  635.687699] irqbalance      R  running task        0  1308      1 
0x00000002
[  635.694735] Call trace:
[  635.697172]  __switch_to+0xbc/0x218
[  635.700648]  0xffff800017043d68
[  635.703778] Task dump for CPU 36:
[  635.707081] cpuhp/36        R  running task        0   192      2 
0x0000002a
[  635.714117] Call trace:
[  635.716552]  __switch_to+0xbc/0x218
[  635.720030]  page_wait_table+0x1500/0x1800
[  698.674054] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  698.680141] rcu:     0-...0: (1 GPs behind) 
idle=896/1/0x4000000000000000 softirq=7411/7412 fqs=26242
[  698.689174] rcu:     36-...!: (0 ticks this GP) 
idle=ad2/1/0x4000000000000000 softirq=2631/2631 fqs=26242
[  698.698563]  (detected by 81, t=52522 jiffies, g=24921, q=2281)
[  698.704469] Task dump for CPU 0:
[  698.707684] irqbalance      R  running task        0  1308      1 
0x00000002
[  698.714721] Call trace:
[  698.717158]  __switch_to+0xbc/0x218
[  698.720634]  0xffff800017043d68
[  698.723764] Task dump for CPU 36:
[  698.727066] cpuhp/36        R  running task        0   192      2 
0x0000002a
[  698.734101] Call trace:
[  698.736536]  __switch_to+0xbc/0x218
[  698.740013]  page_wait_table+0x1500/0x1800
[  761.694053] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  761.700136] rcu:     0-...0: (1 GPs behind) 
idle=896/1/0x4000000000000000 softirq=7411/7412 fqs=34111
[  761.709169] rcu:     36-...!: (0 ticks this GP) 
idle=ad2/1/0x4000000000000000 44]  __switch_to+0xbc/0x218
[  761.740620]  0xffff800017043d68
[  761.743749] Task dump for CPU 36:
[  761.747051] cpuhp/36        R  running task        0   192      2 
0x0000002a
[  761.754087] Call trace:
[  761.756521]  __switch_to+0xbc/0x218
[  761.759998]  page_wait_table+0x1500/0x1800

