Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F369C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 03:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76C121873
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 03:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeLSDZd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:25:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25759 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeLSDZd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 22:25:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36E7E356CD;
        Wed, 19 Dec 2018 03:25:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D0555DD65;
        Wed, 19 Dec 2018 03:25:26 +0000 (UTC)
Date:   Wed, 19 Dec 2018 11:25:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Dennis Zhou <dennis@kernel.org>
Subject: block: percpu ref (blkg_release) <= 0 (0) after switching to atomic
Message-ID: <20181219032520.GA4451@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 19 Dec 2018 03:25:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens and Dennis,

The following warning can be triggered on for-4.21/block when running
xfstests generic/475(xfs), and it is introduced by recent Dennis's patches.

test disk: virtio-blk
scratch: nvme-pci disk

[  979.359696] ------------[ cut here ]------------
[  979.360800] percpu ref (blkg_release) <= 0 (0) after switching to atomic
[  979.360870] WARNING: CPU: 13 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0
[  979.363815] Modules linked in: dm_mod xfs libcrc32c iTCO_wdt iTCO_vendor_support crc32c_intel usb_storage i2c_i801 lpc_ich i2c_core mfd_core virtio_scsi nvme nvme_core qemu_fw_cfg ip_tables
[  979.366810] CPU: 13 PID: 0 Comm: swapper/13 Not tainted 4.20.0-rc6+ #542
[  979.368017] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[  979.369525] RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0
[  979.370389] Code: 43 d8 4c 89 bd 58 ff ff ff 41 c6 45 00 f8 48 8d 78 10 e8 87 6e c8 ff 48 8b 73 e8 4c 89 fa 48 c7 c7 80 35 62 82 e8 ec ca 91 ff <0f> 0b 48 8d 43 d8 4c 8d 68 18 4c 89 ef e8 62 6e c8 ff 48 8b 43 f0
[  979.372972] RSP: 0018:ffff888126a076b0 EFLAGS: 00010286
[  979.373716] RAX: 0000000000000000 RBX: ffff88811d465e30 RCX: 0000000000000000
[  979.374723] RDX: ffffed1024d40e8b RSI: 0000000000000000 RDI: ffffed1024d40eb3
[  979.375721] RBP: ffff888126a07810 R08: dffffc0000000000 R09: fffffbfff04c46b6
[  979.376719] R10: ffffed1023a8cbc2 R11: fffffbfff05a5dcc R12: 1ffff11024d40ed9
[  979.377716] R13: ffffed1024d40eed R14: ffff88811d465e10 R15: 0000000000000000
[  979.378719] FS:  0000000000000000(0000) GS:ffff888126a00000(0000) knlGS:0000000000000000
[  979.379842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  979.380636] CR2: 000055762ef5ce00 CR3: 000000026f078002 CR4: 0000000000760ee0
[  979.381642] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  979.382639] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  979.383642] PKRU: 55555554
[  979.384049] Call Trace:
[  979.384405]  <IRQ>
[  979.384746]  ? percpu_ref_exit+0x4c/0x4c
[  979.385310]  ? lock_acquire+0x280/0x2f3
[  979.385877]  ? rcu_process_callbacks+0xaad/0xf72
[  979.386535]  ? lock_downgrade+0x338/0x338
[  979.387128]  ? lockdep_hardirqs_on+0x26b/0x278
[  979.387780]  ? trace_hardirqs_on+0x169/0x19e
[  979.388386]  ? rcu_get_gp_kthreads_prio+0xc/0xc
[  979.389063]  rcu_process_callbacks+0xb9f/0xf72
[  979.389726]  ? percpu_ref_exit+0x4c/0x4c
[  979.390294]  ? rcu_preempt_deferred_qs+0x86/0x86
[  979.390979]  ? kvm_clock_read+0x14/0x23
[  979.391518]  ? kvm_sched_clock_read+0x5/0xd
[  979.392128]  ? check_chain_key+0x150/0x1aa
[  979.392770]  ? do_raw_spin_trylock+0x156/0x1a2
[  979.393393]  ? mark_held_locks+0x28/0x7f
[  979.393970]  ? _raw_spin_unlock_irq+0x29/0x4c
[  979.394590]  ? lockdep_hardirqs_on+0x26b/0x278
[  979.395233]  ? trace_hardirqs_on+0x169/0x19e
[  979.395854]  ? __bpf_trace_preemptirq_template+0x5/0x5
[  979.396566]  ? do_raw_spin_trylock+0x1a2/0x1a2
[  979.397204]  ? cpu_load_update_active+0x168/0x1ab
[  979.397885]  ? debug_show_all_locks+0x354/0x354
[  979.398536]  ? preempt_count_sub+0x14/0xc4
[  979.399134]  ? _raw_spin_unlock_irq+0x3a/0x4c
[  979.399765]  ? run_timer_softirq+0x2fb/0x33e
[  979.400368]  ? expire_timers+0x34f/0x34f
[  979.400956]  ? timerqueue_add+0xc7/0xe1
[  979.401500]  ? match_held_lock+0x84/0x2db
[  979.402090]  ? pvclock_clocksource_read+0x121/0x205
[  979.402799]  ? pvclock_read_flags+0x37/0x37
[  979.403387]  ? trace_hardirqs_off+0x169/0x19e
[  979.404023]  ? rcu_pm_notify+0x64/0x64
[  979.404571]  ? kvm_clock_read+0x14/0x23
[  979.405132]  ? kvm_sched_clock_read+0x5/0xd
[  979.405737]  ? check_chain_key+0x150/0x1aa
[  979.406329]  ? mark_held_locks+0x28/0x7f
[  979.406903]  ? __do_softirq+0x18a/0x6ad
[  979.407456]  ? preempt_count_sub+0x14/0xc4
[  979.408058]  ? rcu_lockdep_current_cpu_online+0x100/0x147
[  979.408834]  ? rcu_pm_notify+0x64/0x64
[  979.409367]  ? __lock_is_held+0x2a/0x87
[  979.409967]  __do_softirq+0x360/0x6ad
[  979.410512]  ? __irqentry_text_end+0x1fb69a/0x1fb69a
[  979.411223]  ? ktime_get+0x1a0/0x242
[  979.411763]  ? ktime_get_real_ts64+0x275/0x275
[  979.412388]  ? _raw_spin_unlock_irqrestore+0x3d/0x6b
[  979.413091]  ? lockdep_hardirqs_off+0x140/0x14a
[  979.413760]  ? trace_hardirqs_off+0x169/0x19e
[  979.414387]  ? nr_iowait_cpu+0xa3/0xcf
[  979.414941]  ? irq_exit+0x13/0x11d
[  979.415431]  ? lockdep_hardirqs_off+0x140/0x14a
[  979.416089]  ? trace_hardirqs_off+0x169/0x19e
[  979.416723]  ? trace_hardirqs_on_caller+0x1a6/0x1a6
[  979.417403]  ? rcu_pm_notify+0x64/0x64
[  979.417951]  ? __lock_is_held+0x2a/0x87
[  979.418517]  irq_exit+0x7e/0x11d
[  979.419008]  smp_apic_timer_interrupt+0x3e1/0x432
[  979.419683]  ? smp_call_function_single_interrupt+0x3b8/0x3b8
[  979.420492]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  979.421164]  ? lockdep_hardirqs_off+0x11c/0x14a
[  979.421824]  ? trace_hardirqs_off_caller+0x16f/0x1a6
[  979.422519]  ? trace_hardirqs_off+0x19e/0x19e
[  979.423150]  ? trace_hardirqs_off+0x19e/0x19e
[  979.423795]  ? kvm_clock_read+0x14/0x23
[  979.424353]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  979.425054]  apic_timer_interrupt+0xf/0x20
[  979.425636]  </IRQ>
[  979.425966] RIP: 0010:native_safe_halt+0x2/0x3
[  979.426586] Code: 63 02 df f0 83 44 24 fc 00 48 89 df e8 bb 73 5f ff 48 8b 03 a8 08 74 0b 65 81 25 2d 93 1c 7e ff ff ff 7f 5b 5d 41 5c c3 fb f4 <c3> f4 c3 0f 1f 44 00 00 41 57 41 56 48 b8 00 00 00 00 00 fc ff df
[  979.429149] RSP: 0018:ffff8881073c7cf8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[  979.430201] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8119db2b
[  979.431195] RDX: 1ffffffff065e441 RSI: 0000000000000007 RDI: ffff8881073b4d5c
[  979.432185] RBP: 1ffff11020e78fa0 R08: dffffc0000000000 R09: 0000000000000001
[  979.433175] R10: ffffed1024d7fc48 R11: ffffed1024d7fc47 R12: 0000000000000000
[  979.434162] R13: dffffc0000000000 R14: 1ffff11020e78fbc R15: 0000000000000000
[  979.435180]  ? lockdep_hardirqs_on+0x26b/0x278
[  979.435842]  default_idle+0x165/0x2a0
[  979.436361]  ? __sched_text_end+0x1/0x1
[  979.436934]  ? mark_tsc_async_resets+0x25/0x25
[  979.437549]  ? trace_hardirqs_on_caller+0x1a6/0x1a6
[  979.438277]  do_idle+0x16b/0x2e9
[  979.438765]  ? arch_cpu_idle_exit+0x28/0x28
[  979.439358]  ? schedule_idle+0x3b/0x44
[  979.439927]  cpu_startup_entry+0x1d/0x1f
[  979.440478]  start_secondary+0x338/0x36c
[  979.441053]  ? set_cpu_sibling_map+0x8a3/0x8a3
[  979.441742]  secondary_startup_64+0xa4/0xb0
[  979.442376] irq event stamp: 1890071
[  979.442899] hardirqs last  enabled at (1890070): [<ffffffff811bc221>] vprintk_emit+0x276/0x553
[  979.444084] hardirqs last disabled at (1890071): [<ffffffff810045e5>] trace_hardirqs_off_thunk+0x1a/0x1c
[  979.445380] softirqs last  enabled at (1890048): [<ffffffff810f0314>] irq_enter+0x4c/0x73
[  979.446500] softirqs last disabled at (1890049): [<ffffffff810f03b9>] irq_exit+0x7e/0x11d
[  979.447618] ---[ end trace 181fb562d15b7328 ]---
[  979.456959] XFS (sdc): Unmounting Filesystem
_check_dmesg: something found in dmesg (see /var/lib/xfstests/results//generic/475.dmesg)

Ran: generic/475
Failures: generic/475
Failed 1 of 1 tests


Thanks,
Ming
