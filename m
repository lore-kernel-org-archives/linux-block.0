Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC08C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 11:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70C161BC1
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 11:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhKQMC0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 07:02:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233413AbhKQMC0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 07:02:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B292D617E4;
        Wed, 17 Nov 2021 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637150367;
        bh=3VkAAaG7XekBNhPpSck/JA2xiaber5NXQa8cQ2pAVN0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g0Knyuo03AwutmPiAVFqaevkW6XvEIlCgJPE9+YQIgZ/2N1rwgEX0kd49fVHPsTXm
         PlhnVub/1VusBy8MVQt4719/8C/7CXqg0Wi5pgWPrwp24KfI5zJpIzWIhrvR2Zw3Z2
         IdCgnqDnTcPfcI2Bfz7/52s/YQSkQzlXE30kj4YIBqt3SJ6e1vC0HRj7j2nusORpjj
         02Bu5d63aBl89cRTVygPs1Un1oYeEFG0kjlhd4jy28zNf/NVrwxQiued200laePWcl
         oRBoUgy+8araG5wrjZS/sxXXFEo7CD2do7mlj3UXDicO2ievH4EzdlQzne7pJbgcAe
         a8b43Og58xWYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 840235C0AF4; Wed, 17 Nov 2021 03:59:27 -0800 (PST)
Date:   Wed, 17 Nov 2021 03:59:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>,
        fweisbec@gmail.com, hch@lst.de, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
Message-ID: <20211117115927.GZ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <0000000000007ee63e05d0e9c172@google.com>
 <097631ea-d781-c4e1-aa0e-d921a7a2e69e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097631ea-d781-c4e1-aa0e-d921a7a2e69e@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 08:42:39AM -0700, Jens Axboe wrote:
> On 11/16/21 8:41 AM, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit b60876296847e6cd7f1da4b8b7f0f31399d59aa1
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Fri Oct 15 21:03:52 2021 +0000
> > 
> >     block: improve layout of struct request
> 
> No functional changes in that patch, so looks like a fluky bisection.

I am seeing an intermittent (and rather strange) stall warnings on
v5.16-rc1.  This is a self-detected stall from the idle loop.  The
reason that this is strange is that the usual reason that a CPU stalls
in the idle loop is due to a long-running interrupt, in which case
you would expect other CPUs to detect the stall.

Reproduce using RCU's TRE07 scenario, except that the MTBF looks to be
several hundred hours.  But I ran this scenario long enough on v5.15-rc*
to be confident that this stall warning is a regression introduced
recently.

And the reason is that the CPU, despite being in the idle loop, is not
marked as idle from an RCU perspective (see the "idle=d59/0/0x1"):

 rcu:     0-...!: (13 ticks this GP) idle=d59/0/0x1 softirq=281261
/281261 fqs=1
  (t=2199037 jiffies g=249449 q=5)
 NMI backtrace for cpu 0
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc1 #4571
 Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module_el8.5.0+
746+bbd5d70c 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x33/0x42
  nmi_cpu_backtrace.cold.6+0x30/0x70
  ? lapic_can_unplug_cpu+0x70/0x70
  nmi_trigger_cpumask_backtrace+0xbf/0xd0
  rcu_dump_cpu_stacks+0xc0/0x120
  rcu_sched_clock_irq.cold.110+0x15a/0x312
  ? get_nohz_timer_target+0x60/0x190
  ? lock_timer_base+0x62/0x80
  ? account_process_tick+0xd4/0x160
  ? tick_sched_handle.isra.24+0x40/0x40
  update_process_times+0x8e/0xc0
  tick_sched_handle.isra.24+0x30/0x40
  tick_sched_timer+0x6a/0x80
  __hrtimer_run_queues+0xfc/0x2a0
  hrtimer_interrupt+0x105/0x220
  ? resched_curr+0x1e/0xc0
  __sysvec_apic_timer_interrupt+0x7a/0x160
  sysvec_apic_timer_interrupt+0x85/0xb0
  </IRQ>
  <TASK>
  asm_sysvec_apic_timer_interrupt+0x12/0x20
 RIP: 0010:default_idle+0xb/0x10
 Code: ff 48 89 df e8 16 5c 90 ff eb d7 e8 bf 82 ff ff cc cc cc cc
 cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d df 92 41 00 fb f4 <c3> 0f 1f 40
 00 65 48 8b 04 25 00 ad 01 00 f0 80 48 02 20 48 8b 10
 RSP: 0018:ffffffff9dc03e98 EFLAGS: 00000202
 RAX: ffffffff9d3ed200 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffff9da3e0a1 RDI: ffffffff9da683ae
 RBP: ffffffff9de86050 R08: 00000000e141ad57 R09: ffffa03c5f229d40
 R10: 0000000000002400 R11: 0000000000002400 R12: 0000000000000000
 R13: 0000000000000000 R14: ffffffffffffffff R15: ffffffff9dc14940
  ? __cpuidle_text_start+0x8/0x8
  ? __cpuidle_text_start+0x8/0x8
  default_idle_call+0x28/0xd0
  do_idle+0x1fb/0x290
  cpu_startup_entry+0x14/0x20
  start_kernel+0x659/0x680
  secondary_startup_64_no_verify+0xc2/0xcb
  </TASK>

The usual reason for this odd situation is that someone forgot an
irq_enter() or added an extra irq_exit().  Or likewise for a number of
similar functions that tell RCU to start/stop ignoring the current CPU:
nmi_enter(), nmi_exit(), rcu_*_enter(), rcu_*_exit(), and so on.

Adding the x86 list on CC.

							Thanx, Paul
