Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1788C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 22:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiDNWFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbiDNWFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 18:05:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7DDA88BA
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=k6NBfYzAd2WmsybA+vOmDDqG9b5IkTPrTwi3L9jIhCI=; b=w6JDhInE4CRD/3A37ZPldjJh7V
        d1N8P7AqPFUhN+Jt8QDA070CdmhyuPhCCsT9L+ygo6/7tvf4CKJseAwOOgak9XqSBqqw1ZHeYsptB
        Nhq7RFQ3Dr5io7iNu2uBVMvs8lgaeVCSBiv4NZQrWg2U5ByuVTZ48/wdKW8bp6iHJqy1syIQOb/T5
        RV4CfXPX31bdmgladhnoMHN9900sV1zx/TyWlKNJvJLSrE6++zyqpke2W2GGv2XgfNqXSCOlkTugR
        l6qBLEyZe9LgjMy7UQeRbYTf8ojngtaeQ9BLogry6UmXqbWsp30kMAz1Vl7CgiKKpBNNj0CX4vJKU
        yh23ZOoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf7Xo-007R0J-Da; Thu, 14 Apr 2022 22:02:28 +0000
Date:   Thu, 14 Apr 2022 15:02:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     shinichiro.kawasaki@wdc.com, Klaus Jensen <its@irrelevant.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-block@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey folks,

While enhancing kdevops [0] to embrace automation of testing with
blktests for ZNS I ended up spotting a possible false positive RCU stall
when running zbd/006 after zbd/005. The curious thing though is that
this possible RCU stall is only possible when using the qemu
ZNS drive, not when using nbd. In so far as kdevops is concerned
it creates ZNS drives for you when you enable the config option
CONFIG_QEMU_ENABLE_NVME_ZNS=y. So picking any of the ZNS drives
suffices. When configuring blktests you can just enable the zbd
guest, so only a pair of guests are reated the zbd guest and the
respective development guest, zbd-dev guest. When using
CONFIG_KDEVOPS_HOSTS_PREFIX="linux517" this means you end up with
just two guests:

  * linux517-blktests-zbd
  * linux517-blktests-zbd-dev

The RCU stall can be triggered easily as follows:

make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=y and blktests
make
make bringup # bring up guests
make linux # build and boot into v5.17-rc7
make blktests # build and install blktests

Now let's ssh to the guest while leaving a console attached
with `sudo virsh vagrant_linux517-blktests-zbd` in a window:

ssh linux517-blktests-zbd
sudo su -
cd /usr/local/blktests
export TEST_DEVS=/dev/nvme9n1
i=0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; then echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=$i+1; done;

The above should never fail, but you should eventually see an RCU
stall candidate on the console. The full details can be observed on the
gist [1] but for completeness I list some of it below. It may be a false
positive at this point, not sure.

[493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
[493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
[493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
[493336.981666] nvme nvme9: Abort status: 0x0
[493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
[493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[493425.817272] rcu:    4-....: (0 ticks this GP) idle=c48/0/0x0 softirq=11316030/11316030 fqs=939  (false positive?)
[493425.819275]         (detected by 7, t=14522 jiffies, g=31237493, q=6271)
[493425.820683] Sending NMI from CPU 7 to CPUs 0:
[493425.821917] NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xb/0x10
[493425.822797] Sending NMI from CPU 7 to CPUs 1:
[493425.825449] NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0xb/0x10
[493425.826424] Sending NMI from CPU 7 to CPUs 2:
[493425.829057] NMI backtrace for cpu 2 skipped: idling at native_safe_halt+0xb/0x10
[493425.830019] Sending NMI from CPU 7 to CPUs 3:
[493425.832656] NMI backtrace for cpu 3
[493425.832673] CPU: 3 PID: 0 Comm: swapper/3 Kdump: loaded Tainted: G E     5.17.0-rc7 #1
[493425.832677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[493425.832685] RIP: 0010:native_queued_spin_lock_slowpath+0x28/0x200
[493425.832707] Code: 00 00 0f 1f 44 00 00 41 54 55 53 48 89 fb 66 90 ba <etc>
[493425.832709] RSP: 0018:ffffb481c0148f00 EFLAGS: 00000002
[493425.832712] RAX: 0000000000000001 RBX: ffffffff9b2c4f00 RCX: 0000000000000000
[493425.832714] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff9b2c4f00
[493425.832714] RBP: ffff8f8037cee7c0 R08: 0001c9d05bf762ee R09: 7fffffffffffffff
[493425.832716] R10: ffffffff9b2060c0 R11: 000000000000819d R12: 0000000000000246
[493425.832717] R13: ffffffff9b2c4f00 R14: ffff8f8037cee838 R15: ffffffff9b206108
[493425.832718] FS:  0000000000000000(0000) GS:ffff8f8037cc0000(0000) knlGS:0000000000000000
[493425.832719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[493425.832721] CR2: 00007fad480b44c4 CR3: 00000001032d8002 CR4: 0000000000770ee0
[493425.832724] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[493425.832725] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[493425.832726] PKRU: 55555554
[493425.832733] Call Trace:
[493425.832742]  <IRQ>
[493425.832749]  _raw_spin_lock_irqsave+0x44/0x50
[493425.832756]  rcu_core+0xd3/0x750
[493425.832771]  ? kvm_clock_get_cycles+0x14/0x30
[493425.832780]  ? ktime_get+0x35/0x90
[493425.832789]  __do_softirq+0xec/0x2ea
[493425.832796]  __irq_exit_rcu+0xbc/0x110
[493425.832804]  sysvec_apic_timer_interrupt+0xa2/0xd0
[493425.832811]  </IRQ>
[493425.832812]  <TASK>
[493425.832812]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[493425.832816] RIP: 0010:native_safe_halt+0xb/0x10
[493425.832819] Code: 65 ff ff ff 7f 5b c3 65 48 8b 04 25 c0 cb 01 00 f0 <etc>
[493425.832821] RSP: 0018:ffffb481c009bef0 EFLAGS: 00000206
[493425.832822] RAX: ffffffff9a8dba90 RBX: 0000000000000003 RCX: 0000000000000000
[493425.832823] RDX: 0000000000000000 RSI: ffffffff9b0f7c8e RDI: ffffffff9b0d564d
[493425.832825] RBP: ffff8f7f008a8000 R08: 0001c0c4a6b05dd9 R09: 0000000000000000
[493425.832826] R10: 00000001075920c2 R11: 0000000000000001 R12: 0000000000000000
[493425.832827] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[493425.832829]  ? mwait_idle+0x80/0x80
[493425.832846]  default_idle+0xa/0x10
[493425.832848]  default_idle_call+0x33/0xe0
[493425.832850]  do_idle+0x210/0x2a0
[493425.832859]  cpu_startup_entry+0x19/0x20
[493425.832862]  secondary_startup_64_no_verify+0xc3/0xcb
[493425.832881]  </TASK>
[493425.833607] Sending NMI from CPU 7 to CPUs 4:
[493425.894551] NMI backtrace for cpu 4 skipped: idling at native_safe_halt+0xb/0x10
[493425.895524] Sending NMI from CPU 7 to CPUs 5:
[493425.897668] NMI backtrace for cpu 5
[493425.897673] CPU: 5 PID: 0 Comm: swapper/5 Kdump: loaded Tainted: G E     5.17.0-rc7 #1
[493425.897676] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[493425.897678] RIP: 0010:native_queued_spin_lock_slowpath+0x13/0x200
[493425.897687] Code: c0 75 c5 4d 89 50 08 4c 89 c0 c3 0f 0b 66 2e 0f 1f <etc>
[493425.897689] RSP: 0018:ffffb481c01a0f00 EFLAGS: 00000002
[493425.897692] RAX: 0000000000000001 RBX: ffffffff9b2c4f00 RCX: 0000000000000000
[493425.897694] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff9b2c4f00
[493425.897695] RBP: ffff8f8037d6e7c0 R08: 0001c9d05bf75cd7 R09: 7fffffffffffffff
[493425.897696] R10: ffffffff9b2060c0 R11: 0000000000007459 R12: 0000000000000246
[493425.897697] R13: ffffffff9b2c4f00 R14: ffff8f8037d6e838 R15: ffffffff9b206108
[493425.897698] FS:  0000000000000000(0000) GS:ffff8f8037d40000(0000) knlGS:0000000000000000
[493425.897700] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[493425.897702] CR2: 00007f9956af9d38 CR3: 00000001069c6001 CR4: 0000000000770ee0
[493425.897705] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[493425.897706] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[493425.897707] PKRU: 55555554
[493425.897708] Call Trace:
[493425.897711]  <IRQ>
[493425.897715]  _raw_spin_lock_irqsave+0x44/0x50
[493425.897721]  rcu_core+0xd3/0x750
[493425.897727]  ? kvm_clock_get_cycles+0x14/0x30
[493425.897731]  ? ktime_get+0x35/0x90
[493425.897735]  __do_softirq+0xec/0x2ea
[493425.897740]  __irq_exit_rcu+0xbc/0x110
[493425.897745]  sysvec_apic_timer_interrupt+0xa2/0xd0
[493425.897750]  </IRQ>
[493425.897751]  <TASK>
[493425.897752]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[493425.897756] RIP: 0010:native_safe_halt+0xb/0x10
[493425.897758] Code: 65 ff ff ff 7f 5b c3 65 48 8b 04 25 c0 cb 01 00 f0 <etc>
[493425.897760] RSP: 0018:ffffb481c00abef0 EFLAGS: 00000206
[493425.897762] RAX: ffffffff9a8dba90 RBX: 0000000000000005 RCX: 0000000000000000
[493425.897763] RDX: 0000000000000000 RSI: ffffffff9b0f7c8e RDI: ffffffff9b0d564d
[493425.897764] RBP: ffff8f7f008ade00 R08: 0001c0c4a6b3512d R09: 0000000000000001
[493425.897765] R10: 000000000001c400 R11: 0000000000000000 R12: 0000000000000000
[493425.897766] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[493425.897767]  ? mwait_idle+0x80/0x80
[493425.897771]  default_idle+0xa/0x10
[493425.897773]  default_idle_call+0x33/0xe0
[493425.897776]  do_idle+0x210/0x2a0
[493425.897782]  cpu_startup_entry+0x19/0x20
[493425.897784]  secondary_startup_64_no_verify+0xc3/0xcb
[493425.897790]  </TASK>
[493425.898650] Sending NMI from CPU 7 to CPUs 6:
[493425.958744] NMI backtrace for cpu 6 skipped: idling at native_safe_halt+0xb/0x10
[493425.959718] NMI backtrace for cpu 7
[493425.961758] CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G E     5.17.0-rc7 #1
[493425.963599] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[493425.965345] Call Trace:
[493425.966192]  <IRQ>
[493425.966951]  dump_stack_lvl+0x48/0x5e
[493425.967921]  nmi_cpu_backtrace.cold+0x30/0x77
[493425.968777]  ? lapic_can_unplug_cpu+0x80/0x80
[493425.969477]  nmi_trigger_cpumask_backtrace+0x12a/0x150
[493425.970354]  rcu_dump_cpu_stacks+0xd8/0x100
[493425.971049]  rcu_sched_clock_irq+0xa23/0xb70
[493425.971726]  update_process_times+0x93/0xc0
[493425.972394]  tick_sched_handle+0x22/0x60
[493425.973045]  tick_sched_timer+0x84/0xb0
[493425.973677]  ? can_stop_idle_tick+0xd0/0xd0
[493425.974354]  __hrtimer_run_queues+0x127/0x2c0
[493425.975031]  hrtimer_interrupt+0x106/0x220
[493425.975683]  __sysvec_apic_timer_interrupt+0x7c/0x160
[493425.976429]  sysvec_apic_timer_interrupt+0x9d/0xd0
[493425.977150]  </IRQ>
[493425.977602]  <TASK>
[493425.978066]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[493425.978829] RIP: 0010:native_safe_halt+0xb/0x10
[493425.979520] Code: 65 ff ff ff 7f 5b c3 65 48 8b 04 25 c0 cb 01 00 f0 <etc>
[493425.981866] RSP: 0018:ffffb481c00bbef0 EFLAGS: 00000206
[493425.982672] RAX: ffffffff9a8dba90 RBX: 0000000000000007 RCX: 0000000000000001
[493425.983644] RDX: 0000000000000002 RSI: ffffffff9b0f7c8e RDI: ffffffff9b0d564d
[493425.984619] RBP: ffff8f7f00934680 R08: 0001c9c79fd7ad0b R09: 0000000000000000
[493425.985588] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[493425.986672] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[493425.987650]  ? mwait_idle+0x80/0x80
[493425.988258]  default_idle+0xa/0x10
[493425.988842]  default_idle_call+0x33/0xe0
[493425.989480]  do_idle+0x210/0x2a0
[493425.990063]  cpu_startup_entry+0x19/0x20
[493425.990706]  secondary_startup_64_no_verify+0xc3/0xcb
[493425.991455]  </TASK>
[493426.706021] nvme nvme9: 8/0/0 default/read/poll queues
[493452.960178] run blktests zbd/005 at 2022-04-14 20:06:23
[493485.422746] run blktests zbd/006 at 2022-04-14 20:06:55
[493517.203362] nvme nvme9: I/O 516 QID 8 timeout, aborting
[493517.205394] nvme nvme9: Abort status: 0x0

[0] https://github.com/mcgrof/kdevops
[1] https://gist.github.com/mcgrof/5647efdc01bdb4715cfd9b2852fb13ce

  Luis
