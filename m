Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42421C33C9E
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 11:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E596206D3
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 11:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgBALcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:32:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57183 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBALcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Feb 2020 06:32:14 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixr09-0005Uf-Eu; Sat, 01 Feb 2020 12:31:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 15EEE103088; Sat,  1 Feb 2020 12:31:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <maz@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "chenxiang \(M\)" <chenxiang66@hisilicon.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
In-Reply-To: <20200201110539.03db5434@why>
References: <20200115114409.28895-1-ming.lei@redhat.com> <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com> <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com> <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com> <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com> <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com> <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com> <56502aa9-d4ad-5ede-5184-13f1817c77d7@huawei.com> <CACVXFVNiBOBdtwuW=q4aSmUMAnn6Gfpg6BGhcQu44s58NZ08Ww@mail.gmail.com> <20200201110539.03db5434@why>
Date:   Sat, 01 Feb 2020 12:31:44 +0100
Message-ID: <87sgjutufz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:
> On Sat, 1 Feb 2020 09:31:17 +0800
> Ming Lei <tom.leiming@gmail.com> wrote:
>> On Sat, Feb 1, 2020 at 2:02 AM John Garry <john.garry@huawei.com> wrote:
>> 
>> gic_set_affinity shouldn't have switched out, so looks like one gic
>> issue.
>
> Given that gic_set_affinity doesn't sleep, this looks pretty unlikely.
> And __irq_set_affinity() holds a spinlock with irq disabled, so I can't
> really explain how you'd get there. I've just booted a lockdep enabled
> v5.5 on my D05, moved SPIs around (because that's the only way to reach
> this code), and nothing caught fire.
>
> Either the stack trace isn't reliable (when I read things like
> "80d:00h:35m:42s" in the trace, I'm a bit suspicious), or CPU hotplug is
> doing something really funky here.

The hotplug code cannot end up in schedule either and it holds desc lock
as normal affinity setting. The other backtrace is more complete,

[  728.741808] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:80d:00h:35m:42s]
[  728.747895] rcu: 48-...0: (0 ticks this GP) idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=2626
[  728.757197] (detected by 63, t=5255 jiffies, g=40989, q=1890)
[  728.763018] Task dump for CPU 48:
[  728.766321] irqbalance      R  running task        0  1272      1 0x00000002
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

But the __switch_to() there definitely does not make any sense at all.

Thanks,

        tglx
