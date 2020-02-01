Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2912EC33C9E
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 11:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C0C206F0
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580555146;
	bh=MmnUad1/SVXDshe3b4fWDYgahKsmS7jd9ndtexZNX1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aC4a7dmdXQ+wd4A9o8nljwC2MHf3AtkP8ht6II8YybqRNqpnHqTb38wLeOreNY6bh
	 OUJdJUr1Sff7SoF2cHxuzLFh0P3tCjFwzjeArM6Ple9T6RIdBS20DfyTh7hHd+xr8L
	 eWt3i5J9R1x/KvSzRQE9fs/SnNeMGf81w581YUZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgBALFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgBALFp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Feb 2020 06:05:45 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C585E206E3;
        Sat,  1 Feb 2020 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580555143;
        bh=MmnUad1/SVXDshe3b4fWDYgahKsmS7jd9ndtexZNX1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtXJ8xe8xdZflLpv0RyAEjzqpy+sitAXGrettxvyDOEI67jh3fmWcqMdZurJ1PS7p
         g7619DQKlzmR7iWv/Ouj5zJRoB80/1QwQo/OdUwC9/k0j6yni6LyqfUd3T/1Rn9WCk
         ggmFEU+e71+TIdm4dhimUihVwkiG/Opck14StcWo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1ixqar-002Ujj-IK; Sat, 01 Feb 2020 11:05:41 +0000
Date:   Sat, 1 Feb 2020 11:05:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
Message-ID: <20200201110539.03db5434@why>
In-Reply-To: <CACVXFVNiBOBdtwuW=q4aSmUMAnn6Gfpg6BGhcQu44s58NZ08Ww@mail.gmail.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
        <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
        <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
        <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
        <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
        <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
        <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
        <56502aa9-d4ad-5ede-5184-13f1817c77d7@huawei.com>
        <CACVXFVNiBOBdtwuW=q4aSmUMAnn6Gfpg6BGhcQu44s58NZ08Ww@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tom.leiming@gmail.com, john.garry@huawei.com, ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org, bvanassche@acm.org, hare@suse.com, hch@lst.de, tglx@linutronix.de, chenxiang66@hisilicon.com, kbusch@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 1 Feb 2020 09:31:17 +0800
Ming Lei <tom.leiming@gmail.com> wrote:

> On Sat, Feb 1, 2020 at 2:02 AM John Garry <john.garry@huawei.com> wrote:
> >
> > On 31/01/2020 17:51, John Garry wrote:  
> > > +- Keith  
> >
> > + Marc, on rare chance that this is related to the GIC
> >  
> > >
> > > On 31/01/2020 10:58, Ming Lei wrote:  
> > >> On Fri, Jan 31, 2020 at 6:24 PM John Garry <john.garry@huawei.com> wrote:  
> > >>>  
> > >>>>> [  141.976109] Call trace:
> > >>>>> [  141.978550]  __switch_to+0xbc/0x218
> > >>>>> [  141.982029]  blk_mq_run_work_fn+0x1c/0x28
> > >>>>> [  141.986027]  process_one_work+0x1e0/0x358
> > >>>>> [  141.990025]  worker_thread+0x40/0x488
> > >>>>> [  141.993678]  kthread+0x118/0x120
> > >>>>> [  141.996897]  ret_from_fork+0x10/0x18  
> > >>>>
> > >>>> Hi John,
> > >>>>
> > >>>> Thanks for your test!
> > >>>>  
> > >>>
> > >>> Hi Ming,
> > >>>  
> > >>>> Could you test the following patchset and only the last one is changed?
> > >>>>
> > >>>> https://github.com/ming1/linux/commits/my_for_5.6_block  
> > >>>
> > >>> For SCSI testing, I will ask my colleague Xiang Chen to test when he
> > >>> returns to work. So I did not see this issue for my SCSI testing for
> > >>> your original v5, but I was only using 1x as opposed to maybe 20x SAS
> > >>> disks.
> > >>>
> > >>> BTW, did you test NVMe? For some reason I could not trigger a scenario
> > >>> where we're draining the outstanding requests for a queue which is being
> > >>> deactivated - I mean, the queues were always already quiesced.  
> > >>
> > >> I run cpu hotplug test on both NVMe and SCSI in KVM, and fio just runs
> > >> as expected.
> > >>
> > >> NVMe is often 1:1 mapping, so it might be a bit difficult to trigger
> > >> draining in-flight IOs.  
> > >
> > > I generally have a 4:1 mapping for my NVMe cards - so many CPUs.
> > >
> > > But more alarming is that I see this on every run:
> > >
> > > [  246.378744] psci: CPU6 killed (polled 0 ms)
> > > [  246.427955] irq_migrate_all_off_this_cpu: 3 callbacks suppressed
> > > [  246.427956] IRQ 822: no longer affine to CPU7
> > > [  246.438586] CPU7: shutdown
> > > [  246.441300] psci: CPU7 killed (polled 0 ms)
> > > [  247.015206] pcieport 0000:00:08.0: can't change power state from
> > > D3cold to D0 (config space inaccessible)
> > > Jobs: 6[  267.503159] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  267.509244] rcu: 25-...0: (1 GPs behind)
> > > idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=2626
> > > [  267.518283] (detected by 0, t=5255 jiffies, g=14001, q=1787)
> > > [  267.524016] Task dump for CPU 25:
> > > [  267.527318] irqbalance      R  running task        0  1275      1
> > > 0x00000002
> > > [  267.534354] Call trace:
> > > [  267.536790]  __switch_to+0xbc/0x218
> > > [  267.540266]  0xffff800014c53d68
> > > Jobs: 6 (f=6): [R(6)][96.0%][r=0KiB/s[  278.195193] nvme nvme1:
> > > controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> > > ,w=0KiB/s][r=0,w=0 IOPS][eta 00m:[  278.205197] nvme nvme0: controller
> > > is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> > > Jobs: 6 (f=6): [R(6)][0.0%][r=0KiB/s,w=0KiB/s][r=0,w=0 IO[  330.523157]
> > > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  330.529242] rcu: 25-...0: (1 GPs behind)
> > > idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=10503
> > > [  330.538366] (detected by 0, t=21010 jiffies, g=14001, q=2318)
> > > [  330.544186] Task dump for CPU 25:
> > > [  330.547488] irqbalance      R  running task        0  1275      1
> > > 0x00000002
> > > [  330.554523] Call trace:
> > > [  330.556958]  __switch_to+0xbc/0x218
> > > [  330.560434]  0xffff800014c53d68
> > > [  393.543155] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  393.549242] rcu: 25-...0: (1 GPs behind)
> > > idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=18379
> > > [  393.558366] (detected by 8, t=36765 jiffies, g=14001, q=2385)
> > > [  393.564187] Task dump for CPU 25:
> > > [  393.567488] irqbalance      R  running task        0  1275      1
> > > 0x00000002
> > > [  393.574523] Call trace:
> > > [  393.576960]  __switch_to+0xbc/0x218
> > > [  393.580435]  0xffff800014c53d68
> > > [  456.567156] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  456.573246] rcu: 25-...0: (1 GPs behind)
> > > idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=26255
> > > [  456.582389] (detected by 90, t=52520 jiffies, g=14001, q=2397)
> > > [  456.588296] Task dump for CPU 25:
> > > [  456.591601] irqbalance      R  running task        0  1275      1
> > > 0x00000002
> > > [  456.598638] Call trace:
> > > [  456.601078]  __switch_to+0xbc/0x218
> > > [  456.604556]  0xffff800014c53d68
> > > [  519.587152] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  519.593235] rcu: 25-...0: (1 GPs behind)
> > > idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=34131
> > > [  519.602357] (detected by 90, t=68275 jiffies, g=14001, q=2405)
> > > [  519.608264] Task dump for CPU 25:
> > > [  519.611566] irqbalance      R  running task        0  1275      1
> > > 0x00000002
> > > [  519.618601] Call trace:
> > > [  519.621036]  __switch_to+0xbc/0x218
> > > [  519.624511]  0xffff800014c53d68
> > > [  582.603153] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  582.609236] rcu: 25-...0: (1 GPs behind)
> > > idle=11e/1/0x4000000000000000 softirq=1175/1177 fqs=42006
> > > [  582.618358] (detected by 90, t=84029 jiffies, g=14001, q=2409)
> > > [  582.624265] Task dump for CPU 25:
> > > [  582.627567] irqbalance      R  running task        0  1275      1
> > > 0x00000002
> > > [  582.634601] Call trace:
> > > [  582.637036]  __switch_to+0xbc/0x218
> > > [  582.640511]  0xffff800014c53d68
> > >
> > >
> > > I tested v5.5 and I cannot see this, but your branch is based in 5.5-rc2
> > > with lots of other stuff on top. The only thing I changed was
> > > nvme.use_threaded_interrupts = 1.  
> >
> > Uhh, now I do with v5.5:
> >
> > [  705.354601] CPU22: shutdown
> > [  705.357395] psci: CPU22 killed (polled 0 ms)
> > [  705.402837] CPU23: shutdown
> > [  705.405630] psci: CPU23 killed (polled 0 ms)
> > [  705.666716] CPU24: shutdown
> > [  705.669512] psci: CPU24 killed (polled 0 ms)
> > [  705.966753] CPU25: shutdown
> > [  705.969548] psci: CPU25 killed (polled 0 ms)
> > [  706.250771] CPU26: shutdown=2347MiB/s,w=0KiB/s][r=601k,w=0 IOPS][eta
> > 00m:13s]
> > [  706.253565] psci: CPU26 killed (polled 0 ms)
> > [  706.514728] CPU27: shutdown
> > [  706.517523] psci: CPU27 killed (polled 0 ms)
> > [  706.826708] CPU28: shutdown
> > [  706.829502] psci: CPU28 killed (polled 0 ms)
> > [  707.130916] CPU29: shutdown=2134MiB/s,w=0KiB/s][r=546k,w=0 IOPS][eta
> > 00m:12s]
> > [  707.133714] psci: CPU29 killed (polled 0 ms)
> > [  707.439066] CPU30: shutdown
> > [  707.441870] psci: CPU30 killed (polled 0 ms)
> > [  707.706727] CPU31: shutdown
> > [  707.709526] psci: CPU31 killed (polled 0 ms)
> > [  708.521853] pcieport 0000:00:08.0: can't change power state from
> > D3cold to D0 (config space inaccessible)
> > [  728.741808] rcu: INFO: rcu_preempt detected stalls on
> > CPUs/tasks:80d:00h:35m:42s]
> > [  728.747895] rcu: 48-...0: (0 ticks this GP)
> > idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=2626
> > [  728.757197] (detected by 63, t=5255 jiffies, g=40989, q=1890)
> > [  728.763018] Task dump for CPU 48:
> > [  728.766321] irqbalance      R  running task        0  1272      1
> > 0x00000002
> > [  728.773358] Call trace:
> > [  728.775801]  __switch_to+0xbc/0x218
> > [  728.779283]  gic_set_affinity+0x16c/0x1d8  
> ...
> 
> gic_set_affinity shouldn't have switched out, so looks like one gic
> issue.

Given that gic_set_affinity doesn't sleep, this looks pretty unlikely.
And __irq_set_affinity() holds a spinlock with irq disabled, so I can't
really explain how you'd get there. I've just booted a lockdep enabled
v5.5 on my D05, moved SPIs around (because that's the only way to reach
this code), and nothing caught fire.

Either the stack trace isn't reliable (when I read things like
"80d:00h:35m:42s" in the trace, I'm a bit suspicious), or CPU hotplug is
doing something really funky here.

	M.
-- 
Jazz is not dead. It just smells funny...
