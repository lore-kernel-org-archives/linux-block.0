Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:44316 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdLAREd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Dec 2017 12:04:33 -0500
Received: by mail-wm0-f42.google.com with SMTP id t8so4705065wmc.3
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2017 09:04:32 -0800 (PST)
Message-ID: <1512147869.8698.21.camel@gmail.com>
Subject: blk-mq + bfq:  udevd hang on usb2 storages
From: Alban Browaeys <alban.browaeys@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Date: Fri, 01 Dec 2017 18:04:29 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I initially reported as https://bugzilla.kernel.org/show_bug.cgi?id=198
023 .

I have now bisected this issue to commit a6a252e6491443c1c1 "blk-mq-
sched: decide how to handle flush rq via RQF_FLUSH_SEQ".

This is with an USB stick Sandisk Cruzer (USB Version:  2.10) I
regressed with.
systemctl restart systemd-udevd restores sanity.

PS: With an USB3 Lexar (USB Version:  3.00) I get more severe an issue
(not bisected) where I find no way out of reboot. My report to bugzilla
has logs when I was swapping between the these keys. The logs attached
there mixes what looks like two different behaviors.

Thanks,

Alban



Logs with this Sandisk device :

- after plugging I get (after a few seconds to let detection proceed):

nov. 30 18:04:32 cyclope kernel: systemd-udevd   D    0  1154    397 0x00000100
nov. 30 18:04:32 cyclope kernel: Call Trace:
nov. 30 18:04:32 cyclope kernel:  ? __schedule+0x7cc/0x1e10
nov. 30 18:04:32 cyclope kernel:  ? find_get_pages_range_tag+0x1520/0x1520
nov. 30 18:04:32 cyclope kernel:  ? pci_mmcfg_check_reserved+0x100/0x100
nov. 30 18:04:32 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 30 18:04:32 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 30 18:04:32 cyclope kernel:  ? __lock_acquire.isra.33+0x35a/0x1c70
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? blk_lld_busy+0x40/0x40
nov. 30 18:04:32 cyclope kernel:  ? lockdep_rcu_suspicious+0x150/0x150
nov. 30 18:04:32 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 30 18:04:32 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 30 18:04:32 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 30 18:04:32 cyclope kernel:  schedule+0xe2/0x380
nov. 30 18:04:32 cyclope kernel:  ? wait_on_page_bit_common+0x279/0x730
nov. 30 18:04:32 cyclope kernel:  ? __schedule+0x1e10/0x1e10
nov. 30 18:04:32 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 30 18:04:32 cyclope kernel:  ? lock_release+0x10b0/0x10b0
nov. 30 18:04:32 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 30 18:04:32 cyclope kernel:  io_schedule+0x17/0x60
nov. 30 18:04:32 cyclope kernel:  wait_on_page_bit_common+0x47d/0x730
nov. 30 18:04:32 cyclope kernel:  ? __page_cache_alloc+0x340/0x340
nov. 30 18:04:32 cyclope kernel:  ? reuse_swap_page+0x220/0x8f0
nov. 30 18:04:32 cyclope kernel:  ? swp_swapcount+0x450/0x450
nov. 30 18:04:32 cyclope kernel:  ? lockdep_rcu_suspicious+0x150/0x150
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 30 18:04:32 cyclope kernel:  ? page_cache_tree_insert+0x2d0/0x2d0
nov. 30 18:04:32 cyclope kernel:  ? force_page_cache_readahead+0x1bd/0x320
nov. 30 18:04:32 cyclope kernel:  ? force_page_cache_readahead+0x1bd/0x320
nov. 30 18:04:32 cyclope kernel:  generic_file_read_iter+0x8a7/0x2760
nov. 30 18:04:32 cyclope kernel:  ? filemap_range_has_page+0x2e0/0x2e0
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 30 18:04:32 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 30 18:04:32 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 30 18:04:32 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 30 18:04:32 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 30 18:04:32 cyclope kernel:  ? sched_clock_cpu+0x18/0x170
nov. 30 18:04:32 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 30 18:04:32 cyclope kernel:  ? lock_acquire+0x190/0x3e0
nov. 30 18:04:32 cyclope kernel:  ? aa_file_perm+0xdb/0xb80
nov. 30 18:04:32 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 30 18:04:32 cyclope kernel:  ? lock_release+0x10b0/0x10b0
nov. 30 18:04:32 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 30 18:04:32 cyclope kernel:  ? __bpf_prog_run32+0xad/0x110
nov. 30 18:04:32 cyclope kernel:  ? __bpf_prog_run64+0x110/0x110
nov. 30 18:04:32 cyclope kernel:  ? aa_file_perm+0x1db/0xb80
nov. 30 18:04:32 cyclope kernel:  ? aa_path_link+0x480/0x480
nov. 30 18:04:32 cyclope kernel:  ? seccomp_run_filters+0x132/0x220
nov. 30 18:04:32 cyclope kernel:  ? populate_seccomp_data+0xa90/0xa90
nov. 30 18:04:32 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 30 18:04:32 cyclope kernel:  ? __fsnotify_update_child_dentry_flags.part.1+0x250/0x250
nov. 30 18:04:32 cyclope kernel:  ? __lock_acquire.isra.33+0x35a/0x1c70
nov. 30 18:04:32 cyclope kernel:  ? __seccomp_filter+0x94/0xcf0
nov. 30 18:04:32 cyclope kernel:  ? do_seccomp+0x2200/0x2200
nov. 30 18:04:32 cyclope kernel:  __vfs_read+0x513/0x7d0
nov. 30 18:04:32 cyclope kernel:  ? vfs_copy_file_range+0x980/0x980
nov. 30 18:04:32 cyclope kernel:  ? block_llseek+0x60/0xc0
nov. 30 18:04:32 cyclope kernel:  vfs_read+0xf4/0x2f0
nov. 30 18:04:32 cyclope kernel:  ? up_write+0x62/0x110
nov. 30 18:04:32 cyclope kernel:  SyS_read+0xc7/0x1d0
nov. 30 18:04:32 cyclope kernel:  ? kernel_write+0x130/0x130
nov. 30 18:04:32 cyclope kernel:  ? kernel_write+0x130/0x130
nov. 30 18:04:32 cyclope kernel:  do_syscall_64+0x218/0x5f0
nov. 30 18:04:32 cyclope kernel:  ? syscall_return_slowpath+0x2d0/0x2d0
nov. 30 18:04:32 cyclope kernel:  ? syscall_return_slowpath+0x151/0x2d0
nov. 30 18:04:32 cyclope kernel:  ? prepare_exit_to_usermode+0x200/0x200
nov. 30 18:04:32 cyclope kernel:  ? prepare_exit_to_usermode+0xcd/0x200
nov. 30 18:04:32 cyclope kernel:  ? perf_trace_sys_enter+0x1030/0x1030
nov. 30 18:04:32 cyclope kernel:  ? __put_user_4+0x1c/0x30
nov. 30 18:04:32 cyclope kernel:  entry_SYSCALL64_slow_path+0x25/0x25
nov. 30 18:04:32 cyclope kernel: RIP: 0033:0x7f1fad232330
nov. 30 18:04:32 cyclope kernel: RSP: 002b:00007ffd1d6eca68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
nov. 30 18:04:32 cyclope kernel: RAX: ffffffffffffffda RBX: 0000560d12ebfdf0 RCX: 00007f1fad232330
nov. 30 18:04:32 cyclope kernel: RDX: 0000000000000040 RSI: 0000560d12ebff48 RDI: 000000000000000f
nov. 30 18:04:32 cyclope kernel: RBP: 0000000773ef0000 R08: 00007f1fad21c308 R09: 0000000000000070
nov. 30 18:04:32 cyclope kernel: R10: 000000000000006e R11: 0000000000000246 R12: 0000000000000040
nov. 30 18:04:32 cyclope kernel: R13: 0000560d12ebff20 R14: 0000560d12ebfe40 R15: 0000560d12ebff38


- when I unplug (from a previous session):

nov. 29 23:28:19 cyclope kernel: sysrq: SysRq : Show Blocked State
nov. 29 23:28:19 cyclope kernel:   task                        PC stack   pid father
nov. 29 23:28:19 cyclope kernel: kworker/0:1     D    0    33      2 0x80000000
nov. 29 23:28:19 cyclope kernel: Workqueue: usb_hub_wq hub_event [usbcore]
nov. 29 23:28:19 cyclope kernel: Call Trace:
nov. 29 23:28:19 cyclope kernel:  ? __schedule+0x7cc/0x1e10
nov. 29 23:28:19 cyclope kernel:  ? pci_mmcfg_check_reserved+0x100/0x100
nov. 29 23:28:19 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 29 23:28:19 cyclope kernel:  ? prepare_to_wait_event+0x1b2/0x810
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? prepare_to_wait_exclusive+0x380/0x380
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  schedule+0xe2/0x380
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  ? __schedule+0x1e10/0x1e10
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 29 23:28:19 cyclope kernel:  ? rq_clock+0xf0/0xf0
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 29 23:28:19 cyclope kernel:  blk_mq_freeze_queue_wait+0x18f/0x380
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? blk_mq_poll_stats_fn+0x220/0x220
nov. 29 23:28:19 cyclope kernel:  ? __mutex_unlock_slowpath+0xe1/0x880
nov. 29 23:28:19 cyclope kernel:  ? wait_for_completion+0x710/0x710
nov. 29 23:28:19 cyclope kernel:  ? lock_release+0x10a0/0x10a0
nov. 29 23:28:19 cyclope kernel:  ? __blk_mq_delay_run_hw_queue+0x12a/0x1a0
nov. 29 23:28:19 cyclope kernel:  ? finish_wait+0x360/0x360
nov. 29 23:28:19 cyclope kernel:  blk_cleanup_queue+0x25b/0x540
nov. 29 23:28:19 cyclope kernel:  __scsi_remove_device+0xda/0x2a0 [scsi_mod]
nov. 29 23:28:19 cyclope kernel:  scsi_forget_host+0x58/0x1b0 [scsi_mod]
nov. 29 23:28:19 cyclope kernel:  scsi_remove_host+0xd0/0x200 [scsi_mod]
nov. 29 23:28:19 cyclope kernel:  usb_stor_disconnect+0xe5/0x200 [usb_storage]
nov. 29 23:28:19 cyclope kernel:  usb_unbind_interface+0x1b9/0xa60 [usbcore]
nov. 29 23:28:19 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 29 23:28:19 cyclope kernel:  ? rpm_suspend+0x12d0/0x12d0
nov. 29 23:28:19 cyclope kernel:  ? usb_autoresume_device+0x40/0x40 [usbcore]
nov. 29 23:28:19 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 29 23:28:19 cyclope kernel:  ? rq_clock+0xf0/0xf0
nov. 29 23:28:19 cyclope kernel:  device_release_driver_internal+0x277/0x530
nov. 29 23:28:19 cyclope kernel:  bus_remove_device+0x2b1/0x570
nov. 29 23:28:19 cyclope kernel:  device_del+0x517/0x9c0
nov. 29 23:28:19 cyclope kernel:  ? kfree+0xea/0x210
nov. 29 23:28:19 cyclope kernel:  ? __device_links_no_driver+0x280/0x280
nov. 29 23:28:19 cyclope kernel:  ? usb_remove_ep_devs+0x32/0x70 [usbcore]
nov. 29 23:28:19 cyclope kernel:  ? remove_intf_ep_devs+0xe3/0x190 [usbcore]
nov. 29 23:28:19 cyclope kernel:  usb_disable_device+0x1c6/0x6b0 [usbcore]
nov. 29 23:28:19 cyclope kernel:  usb_disconnect+0x221/0x760 [usbcore]
nov. 29 23:28:19 cyclope kernel:  hub_event+0x13e2/0x37d0 [usbcore]
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? hub_port_debounce+0x330/0x330 [usbcore]
nov. 29 23:28:19 cyclope kernel:  ? __lock_acquire.isra.34+0x35a/0x1c50
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? lockdep_rcu_suspicious+0x150/0x150
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock_cpu+0x18/0x170
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  ? lock_acquire+0x190/0x3e0
nov. 29 23:28:19 cyclope kernel:  ? process_one_work+0x9f8/0x1b20
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  ? lock_release+0x10a0/0x10a0
nov. 29 23:28:19 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 29 23:28:19 cyclope kernel:  process_one_work+0xae5/0x1b20
nov. 29 23:28:19 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 29 23:28:19 cyclope kernel:  ? queue_delayed_work_on+0x40/0x40
nov. 29 23:28:19 cyclope kernel:  ? _raw_spin_unlock_irq+0x1f/0x30
nov. 29 23:28:19 cyclope kernel:  ? finish_task_switch+0x1d3/0x6f0
nov. 29 23:28:19 cyclope kernel:  ? finish_task_switch+0x1aa/0x6f0
nov. 29 23:28:19 cyclope kernel:  ? wq_worker_waking_up+0xc0/0xc0
nov. 29 23:28:19 cyclope kernel:  ? preempt_notifier_dec+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? __schedule+0x7d4/0x1e10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? __lock_acquire.isra.34+0x35a/0x1c50
nov. 29 23:28:19 cyclope kernel:  ? lockdep_rcu_suspicious+0x150/0x150
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  ? worker_thread+0x426/0x1800
nov. 29 23:28:19 cyclope kernel:  ? lock_acquire+0x190/0x3e0
nov. 29 23:28:19 cyclope kernel:  ? worker_thread+0x426/0x1800
nov. 29 23:28:19 cyclope kernel:  ? print_unlock_imbalance_bug+0x140/0x140
nov. 29 23:28:19 cyclope kernel:  ? lock_release+0x10a0/0x10a0
nov. 29 23:28:19 cyclope kernel:  ? alloc_worker+0x2f0/0x2f0
nov. 29 23:28:19 cyclope kernel:  worker_thread+0x208/0x1800
nov. 29 23:28:19 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 29 23:28:19 cyclope kernel:  ? process_one_work+0x1b20/0x1b20
nov. 29 23:28:19 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 29 23:28:19 cyclope kernel:  ? _raw_spin_unlock_irq+0x1f/0x30
nov. 29 23:28:19 cyclope kernel:  ? finish_task_switch+0x1d3/0x6f0
nov. 29 23:28:19 cyclope kernel:  ? finish_task_switch+0x1aa/0x6f0
nov. 29 23:28:19 cyclope kernel:  ? preempt_notifier_dec+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? __schedule+0x7d4/0x1e10
nov. 29 23:28:19 cyclope kernel:  ? pci_mmcfg_check_reserved+0x100/0x100
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock_cpu+0x104/0x170
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  ? schedule+0xe2/0x380
nov. 29 23:28:19 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 29 23:28:19 cyclope kernel:  ? __schedule+0x1e10/0x1e10
nov. 29 23:28:19 cyclope kernel:  ? do_wait_intr+0x320/0x320
nov. 29 23:28:19 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 29 23:28:19 cyclope kernel:  ? process_one_work+0x1b20/0x1b20
nov. 29 23:28:19 cyclope kernel:  kthread+0x30d/0x3d0
nov. 29 23:28:19 cyclope kernel:  ? kthread_create_worker_on_cpu+0xc0/0xc0
nov. 29 23:28:19 cyclope kernel:  ret_from_fork+0x1f/0x30
nov. 29 23:28:19 cyclope kernel: systemd-udevd   D    0  1166    398 0x00000100
nov. 29 23:28:19 cyclope kernel: Call Trace:
nov. 29 23:28:19 cyclope kernel:  ? __schedule+0x7cc/0x1e10
nov. 29 23:28:19 cyclope kernel:  ? find_get_pages_tag+0x13c0/0x13c0
nov. 29 23:28:19 cyclope kernel:  ? pci_mmcfg_check_reserved+0x100/0x100
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? __lock_acquire.isra.34+0x35a/0x1c50
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? blk_lld_busy+0x40/0x40
nov. 29 23:28:19 cyclope kernel:  ? lockdep_rcu_suspicious+0x150/0x150
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  schedule+0xe2/0x380
nov. 29 23:28:19 cyclope kernel:  ? wait_on_page_bit_common+0x279/0x730
nov. 29 23:28:19 cyclope kernel:  ? __schedule+0x1e10/0x1e10
nov. 29 23:28:19 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 29 23:28:19 cyclope kernel:  ? lock_release+0x10a0/0x10a0
nov. 29 23:28:19 cyclope kernel:  ? do_raw_spin_trylock+0x180/0x180
nov. 29 23:28:19 cyclope kernel:  io_schedule+0x17/0x60
nov. 29 23:28:19 cyclope kernel:  wait_on_page_bit_common+0x47d/0x730
nov. 29 23:28:19 cyclope kernel:  ? __page_cache_alloc+0x340/0x340
nov. 29 23:28:19 cyclope kernel:  ? reuse_swap_page+0x220/0x8f0
nov. 29 23:28:19 cyclope kernel:  ? swp_swapcount+0x450/0x450
nov. 29 23:28:19 cyclope kernel:  ? lockdep_rcu_suspicious+0x150/0x150
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? page_cache_tree_insert+0x2a0/0x2a0
nov. 29 23:28:19 cyclope kernel:  ? force_page_cache_readahead+0x1bd/0x320
nov. 29 23:28:19 cyclope kernel:  ? force_page_cache_readahead+0x1bd/0x320
nov. 29 23:28:19 cyclope kernel:  generic_file_read_iter+0x8a7/0x2760
nov. 29 23:28:19 cyclope kernel:  ? filemap_range_has_page+0x2e0/0x2e0
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock+0x5/0x10
nov. 29 23:28:19 cyclope kernel:  ? sched_clock_cpu+0x18/0x170
nov. 29 23:28:19 cyclope kernel:  ? find_held_lock+0x39/0x1c0
nov. 29 23:28:19 cyclope kernel:  ? lock_acquire+0x190/0x3e0
nov. 29 23:28:19 cyclope kernel:  ? aa_file_perm+0xdb/0xb80
nov. 29 23:28:19 cyclope kernel:  ? lock_downgrade+0x690/0x690
nov. 29 23:28:19 cyclope kernel:  ? lock_release+0x10a0/0x10a0
nov. 29 23:28:19 cyclope kernel:  ? tsc_resume+0x10/0x10
nov. 29 23:28:19 cyclope kernel:  ? __bpf_prog_run32+0xad/0x110
nov. 29 23:28:19 cyclope kernel:  ? __bpf_prog_run64+0x110/0x110
nov. 29 23:28:19 cyclope kernel:  ? aa_file_perm+0x1db/0xb80
nov. 29 23:28:19 cyclope kernel:  ? aa_path_link+0x480/0x480
nov. 29 23:28:19 cyclope kernel:  ? seccomp_run_filters+0x132/0x220
nov. 29 23:28:19 cyclope kernel:  ? populate_seccomp_data+0xa90/0xa90
nov. 29 23:28:19 cyclope kernel:  ? graph_lock+0xd0/0xd0
nov. 29 23:28:19 cyclope kernel:  ? __fsnotify_update_child_dentry_flags.part.1+0x250/0x250
nov. 29 23:28:19 cyclope kernel:  ? __lock_acquire.isra.34+0x35a/0x1c50
nov. 29 23:28:19 cyclope kernel:  ? __seccomp_filter+0x94/0xcf0
nov. 29 23:28:19 cyclope kernel:  ? do_seccomp+0x2200/0x2200
nov. 29 23:28:19 cyclope kernel:  __vfs_read+0x513/0x7d0
nov. 29 23:28:19 cyclope kernel:  ? vfs_copy_file_range+0x980/0x980
nov. 29 23:28:19 cyclope kernel:  ? block_llseek+0x60/0xc0
nov. 29 23:28:19 cyclope kernel:  vfs_read+0xf4/0x2f0
nov. 29 23:28:19 cyclope kernel:  ? up_write+0x62/0x110
nov. 29 23:28:19 cyclope kernel:  SyS_read+0xc7/0x1d0
nov. 29 23:28:19 cyclope kernel:  ? kernel_write+0x130/0x130
nov. 29 23:28:19 cyclope kernel:  ? kernel_write+0x130/0x130
nov. 29 23:28:19 cyclope kernel:  do_syscall_64+0x218/0x5f0
nov. 29 23:28:19 cyclope kernel:  ? syscall_return_slowpath+0x2d0/0x2d0
nov. 29 23:28:19 cyclope kernel:  ? syscall_return_slowpath+0x151/0x2d0
nov. 29 23:28:19 cyclope kernel:  ? prepare_exit_to_usermode+0x200/0x200
nov. 29 23:28:19 cyclope kernel:  ? prepare_exit_to_usermode+0xcd/0x200
nov. 29 23:28:19 cyclope kernel:  ? perf_trace_sys_enter+0xfe0/0xfe0
nov. 29 23:28:19 cyclope kernel:  ? __put_user_4+0x1c/0x30
nov. 29 23:28:19 cyclope kernel:  entry_SYSCALL64_slow_path+0x25/0x25
nov. 29 23:28:19 cyclope kernel: RIP: 0033:0x7efc0cd5b330
nov. 29 23:28:19 cyclope kernel: RSP: 002b:00007ffe3770c4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
nov. 29 23:28:19 cyclope kernel: RAX: ffffffffffffffda RBX: 000055bee6b74c60 RCX: 00007efc0cd5b330
nov. 29 23:28:19 cyclope kernel: RDX: 0000000000000040 RSI: 000055bee6b74db8 RDI: 000000000000000f
nov. 29 23:28:19 cyclope kernel: RBP: 0000000773ef0000 R08: 00007efc0cd45278 R09: 0000000000000070
nov. 29 23:28:19 cyclope kernel: R10: 000000000000006e R11: 0000000000000246 R12: 0000000000000040
nov. 29 23:28:19 cyclope kernel: R13: 000055bee6b74d90 R14: 000055bee6b74cb0 R15: 000055bee6b74da8
