Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Message-Id: <201805100637.w4A6bDET092699@www262.sakura.ne.jp>
Subject: Re: inconsistent lock state in =?ISO-2022-JP?B?ZnNfcmVjbGFpbV9hY3F1aXJl?=
 =?ISO-2022-JP?B?ICgyKQ==?=
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: syzbot <syzbot+63833431f68be871fb95@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Dmitry Vyukov <dvyukov@google.com>
MIME-Version: 1.0
Date: Thu, 10 May 2018 15:37:13 +0900
References: <0000000000003b8d3a056bd3b073@google.com> <CACT4Y+a2mP6w4fw60_B8_2_KQps09bEQbi9jp_3ORkS6As7omA@mail.gmail.com>
In-Reply-To: <CACT4Y+a2mP6w4fw60_B8_2_KQps09bEQbi9jp_3ORkS6As7omA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
List-ID: <linux-block@vger.kernel.org>

Dmitry Vyukov wrote:
> On Thu, May 10, 2018 at 7:57 AM, syzbot
> <syzbot+63833431f68be871fb95@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    036db8bd9637 Merge branch 'for-4.17-fixes' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=146dab5b800000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=31f4b3733894ef79
> > dashboard link: https://syzkaller.appspot.com/bug?extid=63833431f68be871fb95
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+63833431f68be871fb95@syzkaller.appspotmail.com
> 
> 
> Tetsuo thinks this is block layer problem.
> +block maintainers
> 
Thanks for CC'ing me.

First kobject_uevent(&dev->kobj, KOBJ_REMOVE) trigger from process context
failed because memory allocation was failed by fault injection.

ioctl(BLKPG, { .op = BLKPG_DEL_PARTITION } ) {
  blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd, unsigned long arg) {
    blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg) {
      delete_partition(disk, partno) {
        device_del(part_to_dev(part)) {
          kobject_uevent(&dev->kobj, KOBJ_REMOVE) {
            kobject_uevent_env(kobj, action, NULL) {
              /* "kobj->state_remove_uevent_sent = 1;" was not done. */
            }
          }
        }
      }
    }
  }
}

----------------------------------------
[  138.052996] FAULT_INJECTION: forcing a failure.
[  138.052996] name failslab, interval 1, probability 0, space 0, times 0
[  138.064786] CPU: 0 PID: 10555 Comm: syz-executor6 Not tainted 4.17.0-rc4+ #39
[  138.072083] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  138.081450] Call Trace:
[  138.084060]  dump_stack+0x1b9/0x294
[  138.097798]  should_fail.cold.4+0xa/0x1a
[  138.140503]  __should_failslab+0x124/0x180
[  138.144759]  should_failslab+0x9/0x14
[  138.148578]  kmem_cache_alloc_trace+0x2cb/0x780
[  138.168726]  kobject_uevent_env+0x20f/0xea0
[  138.177573]  kobject_uevent+0x1f/0x30
[  138.181397]  device_del+0x6c9/0xb70
[  138.201979]  delete_partition+0x21d/0x2a0
[  138.223857]  blkpg_ioctl+0x3c5/0xc40
[  138.248487]  blkdev_ioctl+0x1753/0x2020
[  138.295797]  block_ioctl+0xee/0x130
[  138.303785]  do_vfs_ioctl+0x1cf/0x16a0
[  138.336915]  ksys_ioctl+0xa9/0xd0
[  138.340387]  __x64_sys_ioctl+0x73/0xb0
[  138.344289]  do_syscall_64+0x1b1/0x800
[  138.368357]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  138.373566] RIP: 0033:0x455979
[  138.376768] RSP: 002b:00007f35a9be2c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  138.384500] RAX: ffffffffffffffda RBX: 00007f35a9be36d4 RCX: 0000000000455979
[  138.391791] RDX: 0000000020000180 RSI: 0000000000001269 RDI: 0000000000000013
[  138.399084] RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
[  138.406374] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
[  138.413660] R13: 00000000000001a8 R14: 00000000006f6860 R15: 0000000000000000
----------------------------------------

Therefore, kobject_uevent(&dev->kobj, KOBJ_REMOVE) is later triggered from
RCU callback context.

rcu_process_callbacks(struct softirq_action *unused) {
  __rcu_process_callbacks(rsp) {
    invoke_rcu_callbacks(struct rcu_state *rsp, struct rcu_data *rdp) {
      rcu_do_batch(rsp, rdp) {
        delete_partition_rcu_cb(struct rcu_head *head) {
          put_device(part_to_dev(part)) {
            kobject_put(&dev->kobj) {
              kref_put(&kobj->kref, kobject_release) {
                kobject_cleanup(kobj) {
                  /* send "remove" if the caller did not do it but sent "add" */
                  if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
                    pr_debug("kobject: '%s' (%p): auto cleanup 'remove' event\n",
                             kobject_name(kobj), kobj);
                    kobject_uevent(kobj, KOBJ_REMOVE) {
                      kobject_uevent_env(kobj, action, NULL) {
                        /* GFP_KERNEL memory allocation and mutex_lock() */
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

----------------------------------------
[  138.454065] 
[  138.455760] ================================
[  138.460158] WARNING: inconsistent lock state
[  138.464656] 4.17.0-rc4+ #39 Not tainted
[  138.468617] --------------------------------
[  138.473019] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  138.479167] syz-executor3/10560 [HC0[0]:SC1[1]:HE1:SE0] takes:
[  138.479683] EXT4-fs (sda1): re-mounted. Opts: minixdf,
[  138.485141] 000000001180cb72 (fs_reclaim){+.?.}, at: fs_reclaim_acquire.part.82+0x0/0x30
[  138.485169] {SOFTIRQ-ON-W} state was registered at:
[  138.485181]   lock_acquire+0x1dc/0x520
[  138.485189]   fs_reclaim_acquire.part.82+0x24/0x30
[  138.485197]   fs_reclaim_acquire+0x14/0x20
[  138.485207]   kmem_cache_alloc_node_trace+0x39/0x770
[  138.485226]   alloc_worker+0xbd/0x2e0
[  138.525645]   init_rescuer.part.25+0x1f/0x190
[  138.530161]   workqueue_init+0x51f/0x7d0
[  138.534232]   kernel_init_freeable+0x2ad/0x58e
[  138.538829]   kernel_init+0x11/0x1b3
[  138.542590]   ret_from_fork+0x3a/0x50
[  138.546384] irq event stamp: 8616
[  138.549857] hardirqs last  enabled at (8616): [<ffffffff876ef414>] _raw_spin_unlock_irqrestore+0x74/0xc0
[  138.559582] hardirqs last disabled at (8615): [<ffffffff876ef4d4>] _raw_spin_lock_irqsave+0x74/0xc0
[  138.568774] softirqs last  enabled at (7446): [<ffffffff87a00778>] __do_softirq+0x778/0xaf5
[  138.577287] softirqs last disabled at (8601): [<ffffffff81476281>] irq_exit+0x1d1/0x200
[  138.585418] 
[  138.585418] other info that might help us debug this:
[  138.592075]  Possible unsafe locking scenario:
[  138.592075] 
[  138.598129]        CPU0
[  138.600689]        ----
[  138.603248]   lock(fs_reclaim);
[  138.606519]   <Interrupt>
[  138.609264]     lock(fs_reclaim);
[  138.612711] 
[  138.612711]  *** DEADLOCK ***
[  138.612711] 
[  138.618759] 2 locks held by syz-executor3/10560:
[  138.623492]  #0: 0000000099a775e3 (&(ptlock_ptr(page))->rlock#2){+.+.}, at: unmap_page_range+0x99b/0x2200
[  138.633221]  #1: 00000000bbb25b9d (rcu_callback){....}, at: rcu_process_callbacks+0xa2c/0x15f0
[  138.642079] 
[  138.642079] stack backtrace:
[  138.646573] CPU: 0 PID: 10560 Comm: syz-executor3 Not tainted 4.17.0-rc4+ #39
[  138.654016] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  138.663353] Call Trace:
[  138.665925]  <IRQ>
[  138.668069]  dump_stack+0x1b9/0x294
[  138.684269]  print_usage_bug.cold.59+0x320/0x41a
[  138.693146]  mark_lock+0x1034/0x19e0
[  138.721057]  __lock_acquire+0x1622/0x5140
[  138.778250]  lock_acquire+0x1dc/0x520
[  138.802815]  fs_reclaim_acquire.part.82+0x24/0x30
[  138.811440]  fs_reclaim_acquire+0x14/0x20
[  138.815570]  kmem_cache_alloc_trace+0x2d/0x780
[  138.834889]  kobject_uevent_env+0x20f/0xea0
[  138.839204]  kobject_uevent+0x1f/0x30
[  138.842999]  kobject_put+0x1fb/0x280
[  138.846698]  put_device+0x20/0x30
[  138.850251]  delete_partition_rcu_cb+0x147/0x1b0
[  138.859241]  rcu_process_callbacks+0x941/0x15f0
[  138.889242]  __do_softirq+0x2e0/0xaf5
[  138.934031]  irq_exit+0x1d1/0x200
[  138.937500]  smp_apic_timer_interrupt+0x17e/0x710
[  138.968983]  apic_timer_interrupt+0xf/0x20
[  138.973204]  </IRQ>
----------------------------------------

Since put_device() might sleep, it is not safe to invoke via call_rcu().

----------------------------------------
void put_device(struct device *dev)
{
	/* might_sleep(); */
	if (dev)
		kobject_put(&dev->kobj);
}

static void delete_partition_rcu_cb(struct rcu_head *head)
{
	struct hd_struct *part = container_of(head, struct hd_struct, rcu_head);

	part->start_sect = 0;
	part->nr_sects = 0;
	part_stat_set_all(part, 0);
	put_device(part_to_dev(part));
}

void __delete_partition(struct percpu_ref *ref)
{
	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
	call_rcu(&part->rcu_head, delete_partition_rcu_cb);
}
----------------------------------------
