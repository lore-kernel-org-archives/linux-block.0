Return-Path: <ming.lei@redhat.com>
Date: Thu, 5 Apr 2018 07:28:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: BUG: KASAN: use-after-free in bt_for_each+0x1ea/0x29f
Message-ID: <20180404232808.GB12299@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi,

The following warning is observed once when running dbench on NVMe with
the linus tree(top commit is 642e7fd23353).

[ 1446.882043] ==================================================================
[ 1446.886884] BUG: KASAN: use-after-free in bt_for_each+0x1ea/0x29f
[ 1446.888045] Read of size 8 at addr ffff880055a60a00 by task dbench/13443
[ 1446.889660]
[ 1446.889892] CPU: 1 PID: 13443 Comm: dbench Not tainted 4.16.0_642e7fd23353_master+ #1
[ 1446.891007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[ 1446.892290] Call Trace:
[ 1446.892641]  <IRQ>
[ 1446.892937]  dump_stack+0xf0/0x191
[ 1446.893600]  ? dma_direct_map_page+0x6f/0x6f
[ 1446.894425]  ? show_regs_print_info+0xa/0xa
[ 1446.895247]  ? ext4_writepages+0x196d/0x1e6d
[ 1446.896063]  ? do_writepages+0x57/0xa3
[ 1446.896810]  print_address_description+0x6e/0x23b
[ 1446.897882]  ? bt_for_each+0x1ea/0x29f
[ 1446.898693]  kasan_report+0x247/0x285
[ 1446.899484]  bt_for_each+0x1ea/0x29f
[ 1446.900233]  ? blk_mq_tagset_busy_iter+0xa3/0xa3
[ 1446.901190]  ? generic_file_buffered_read+0x14b1/0x14b1
[ 1446.903097]  ? blk_mq_hctx_mark_pending.isra.0+0x5c/0x5c
[ 1446.904418]  ? bio_free+0x64/0xaa
[ 1446.905113]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1446.906332]  ? bio_put+0x7a/0x10e
[ 1446.906811]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1446.907527]  ? blk_mq_hctx_mark_pending.isra.0+0x5c/0x5c
[ 1446.908334]  blk_mq_queue_tag_busy_iter+0xd0/0xde
[ 1446.909023]  blk_mq_in_flight+0xb4/0xdb
[ 1446.909619]  ? blk_mq_exit_hctx+0x190/0x190
[ 1446.910281]  ? ext4_end_bio+0x25d/0x2a1
[ 1446.911713]  part_in_flight+0xc0/0x2ac
[ 1446.912470]  ? ext4_put_io_end_defer+0x277/0x277
[ 1446.913465]  ? part_dec_in_flight+0x8f/0x8f
[ 1446.914375]  ? __lock_acquire+0x38/0x8e5
[ 1446.915182]  ? bio_endio+0x3d9/0x41c
[ 1446.915936]  ? __rcu_read_unlock+0x134/0x180
[ 1446.916796]  ? lock_acquire+0x2ba/0x32d
[ 1446.917570]  ? blk_account_io_done+0xea/0x572
[ 1446.918424]  part_round_stats+0x167/0x1a3
[ 1446.919188]  ? part_round_stats_single.isra.1+0xc7/0xc7
[ 1446.920187]  blk_account_io_done+0x34d/0x572
[ 1446.921056]  ? blk_update_bidi_request+0x8f/0x8f
[ 1446.921923]  ? blk_mq_run_hw_queue+0x13d/0x187
[ 1446.922803]  blk_mq_end_request+0x3f/0xbf
[ 1446.923631]  nvme_complete_rq+0x305/0x348 [nvme_core]
[ 1446.924612]  ? nvme_delete_ctrl_sync+0x5c/0x5c [nvme_core]
[ 1446.925696]  ? nvme_pci_complete_rq+0x1f6/0x20c [nvme]
[ 1446.926673]  ? kfree+0x21c/0x2ab
[ 1446.927317]  ? nvme_pci_complete_rq+0x1f6/0x20c [nvme]
[ 1446.928239]  __blk_mq_complete_request+0x391/0x3ee
[ 1446.928938]  ? blk_mq_free_request+0x479/0x479
[ 1446.929588]  ? rcu_read_lock_bh_held+0x3a/0x3a
[ 1446.930321]  ? enqueue_hrtimer+0x252/0x29a
[ 1446.930938]  ? do_raw_spin_lock+0xd8/0xd8
[ 1446.931532]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1446.932425]  blk_mq_complete_request+0x10e/0x159
[ 1446.933341]  ? hctx_lock+0xe8/0xe8
[ 1446.933985]  ? lock_contended+0x680/0x680
[ 1446.934707]  ? lock_downgrade+0x338/0x338
[ 1446.935463]  nvme_process_cq+0x26a/0x34d [nvme]
[ 1446.936297]  ? nvme_init_hctx+0xa6/0xa6 [nvme]
[ 1446.937150]  nvme_irq+0x23/0x51 [nvme]
[ 1446.937864]  ? nvme_process_cq+0x34d/0x34d [nvme]
[ 1446.938713]  __handle_irq_event_percpu+0x29d/0x568
[ 1446.939516]  ? __irq_wake_thread+0x99/0x99
[ 1446.940241]  ? rcu_user_enter+0x72/0x72
[ 1446.940978]  ? do_timer+0x25/0x25
[ 1446.941650]  ? do_raw_spin_unlock+0x146/0x179
[ 1446.942514]  ? __lock_acquire+0x38/0x8e5
[ 1446.943305]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1446.944242]  ? lock_acquire+0x32d/0x32d
[ 1446.944995]  ? lock_contended+0x680/0x680
[ 1446.945718]  handle_irq_event_percpu+0x7c/0xf7
[ 1446.946438]  ? __handle_irq_event_percpu+0x568/0x568
[ 1446.947124]  ? rcu_user_exit+0xa/0xa
[ 1446.947781]  handle_irq_event+0x53/0x83
[ 1446.948553]  handle_edge_irq+0x1f2/0x279
[ 1446.949397]  handle_irq+0x1d8/0x1e9
[ 1446.950094]  do_IRQ+0x90/0x12d
[ 1446.950750]  common_interrupt+0xf/0xf
[ 1446.951507]  </IRQ>
[ 1446.951953] RIP: 0010:__blk_mq_get_tag+0x201/0x22d
[ 1446.952894] RSP: 0018:ffff880055b467a0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
[ 1446.954295] RAX: 0000000000000000 RBX: ffff88005952f648 RCX: 0000000000000000
[ 1446.955641] RDX: 0000000000000259 RSI: 0000000000000000 RDI: ffffed000ab68d06
[ 1446.956972] RBP: ffffed000ab68cf6 R08: 0000000000000007 R09: 0000000000000000
[ 1446.958356] R10: ffffed000a0ec0f2 R11: ffffed000a0ec0f1 R12: ffff88007f113978
[ 1446.959737] R13: ffff880055b46ce8 R14: dffffc0000000000 R15: ffff880058bf60c0
[ 1446.961184]  ? modules_open+0x5e/0x5e
[ 1446.961922]  ? blk_mq_unique_tag+0xc5/0xc5
[ 1446.962748]  ? lock_acquire+0x32d/0x32d
[ 1446.963534]  ? __rcu_read_unlock+0x134/0x180
[ 1446.964393]  ? rcu_read_lock_bh_held+0x3a/0x3a
[ 1446.965282]  blk_mq_get_tag+0x1ad/0x67a
[ 1446.966079]  ? __blk_mq_tag_idle+0x44/0x44
[ 1446.966891]  ? wait_woken+0x13c/0x13c
[ 1446.967638]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1446.968566]  ? lock_acquire+0x32d/0x32d
[ 1446.969310]  ? lock_downgrade+0x338/0x338
[ 1446.970092]  ? atomic_inc_below+0xaa/0xf6
[ 1446.970840]  ? rwb_wake_all+0x142/0x142
[ 1446.971579]  ? __lock_acquire+0x38/0x8e5
[ 1446.972345]  blk_mq_get_request+0x40b/0xb1c
[ 1446.973150]  ? blk_mq_poll_stats_bkt+0x42/0x42
[ 1446.974057]  ? do_raw_spin_unlock+0x146/0x179
[ 1446.974975]  ? do_raw_spin_trylock+0x115/0x115
[ 1446.975898]  ? blk_integrity_merge_bio+0x2e/0x146
[ 1446.976893]  ? preempt_count_sub+0x14/0xb5
[ 1446.977784]  ? preempt_count_sub+0x14/0xb5
[ 1446.978658]  ? __blk_mq_sched_bio_merge+0x2fb/0x31d
[ 1446.979679]  blk_mq_make_request+0x486/0xf76
[ 1446.980569]  ? __blk_mq_insert_request+0x44e/0x44e
[ 1446.981534]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1446.982526]  ? lock_acquire+0x32d/0x32d
[ 1446.983325]  ? __rcu_read_unlock+0x134/0x180
[ 1446.984200]  ? rcu_read_lock_bh_held+0x3a/0x3a
[ 1446.985112]  ? __lock_acquire+0x38/0x8e5
[ 1446.985864]  ? lock_acquire+0x32d/0x32d
[ 1446.986626]  ? kmem_cache_free+0x139/0x2c6
[ 1446.987473]  ? jbd2_journal_stop+0x8b0/0x8f9
[ 1446.988353]  ? __ext4_journal_stop+0x9e/0xcc
[ 1446.989225]  ? ext4_writepages+0x1949/0x1e6d
[ 1446.990113]  ? preempt_count_sub+0x14/0xb5
[ 1446.990964]  ? blk_queue_enter+0x52b/0x7e5
[ 1446.991814]  ? entry_SYSCALL_64_after_hwframe+0x42/0xb7
[ 1446.992895]  ? blk_exit_rl+0x3e/0x3e
[ 1446.993642]  ? ext4_io_submit_init+0x3a/0x3a
[ 1446.994529]  ? jbd2_journal_free_transaction+0x1b/0x1b
[ 1446.995575]  ? ext4_file_write_iter+0x59f/0x7d1
[ 1446.996505]  ? __vfs_write+0x2b4/0x32f
[ 1446.997276]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1446.998260]  ? jbd2__journal_start+0x102/0x494
[ 1446.999179]  ? lock_acquire+0x32d/0x32d
[ 1446.999979]  ? mpage_submit_page+0xc5/0xd5
[ 1447.000853]  ? debug_check_no_locks_freed+0x29/0x19a
[ 1447.001919]  ? __pagevec_release+0x49/0x4f
[ 1447.002798]  ? jbd2_journal_stop+0x8b0/0x8f9
[ 1447.003682]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.004670]  ? kmem_cache_free+0x27a/0x2c6
[ 1447.005532]  generic_make_request+0x26d/0x5f4
[ 1447.006444]  ? blk_put_request+0x81/0x81
[ 1447.007255]  ? kmem_cache_alloc+0x245/0x2af
[ 1447.008022]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.008852]  ? jbd2__journal_start+0x3f8/0x494
[ 1447.009657]  ? start_this_handle+0xa1e/0xa1e
[ 1447.010474]  ? kasan_unpoison_shadow+0xf/0x2e
[ 1447.011330]  ? kasan_kmalloc+0x61/0x8c
[ 1447.012031]  ? submit_bio+0x20c/0x253
[ 1447.012691]  submit_bio+0x20c/0x253
[ 1447.013318]  ? generic_make_request+0x5f4/0x5f4
[ 1447.014098]  ? ext4_journal_abort_handle.isra.1+0x13c/0x13c
[ 1447.015059]  ? ext4_end_io_rsv_work+0x410/0x410
[ 1447.015864]  ext4_io_submit+0xaa/0xc3
[ 1447.016584]  ext4_writepages+0x196d/0x1e6d
[ 1447.017439]  ? ext4_mark_inode_dirty+0x4de/0x4de
[ 1447.018392]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.019247]  ? __mark_inode_dirty+0x5ba/0x9a9
[ 1447.020112]  ? debug_check_no_locks_freed+0x29/0x19a
[ 1447.021037]  ? jbd2_journal_stop+0x8b0/0x8f9
[ 1447.021835]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.022736]  ? kmem_cache_free+0x27a/0x2c6
[ 1447.023498]  ? jbd2_journal_stop+0x8b0/0x8f9
[ 1447.024314]  ? unlock_page+0xf9/0x163
[ 1447.024983]  ? wake_up_page_bit+0x27a/0x27a
[ 1447.025749]  ? block_write_end+0xf0/0x129
[ 1447.026396]  ? __block_commit_write.isra.10+0x18d/0x18d
[ 1447.027152]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.027875]  ? balance_dirty_pages_ratelimited+0xd8d/0xf3d
[ 1447.028713]  ? lock_acquire+0x32d/0x32d
[ 1447.029360]  ? __lock_acquire+0x38/0x8e5
[ 1447.029969]  ? generic_write_end+0x20d/0x255
[ 1447.030787]  ? do_raw_spin_unlock+0x146/0x179
[ 1447.031667]  ? do_raw_spin_trylock+0x115/0x115
[ 1447.032584]  ? preempt_count_sub+0x14/0xb5
[ 1447.033406]  ? _raw_spin_unlock+0x2e/0x40
[ 1447.034214]  ? wbc_attach_and_unlock_inode+0x159/0x4c9
[ 1447.035061]  ? __writeback_single_inode+0xb20/0xb20
[ 1447.035835]  ? do_writepages+0x57/0xa3
[ 1447.036517]  do_writepages+0x57/0xa3
[ 1447.037075]  __filemap_fdatawrite_range+0x1ab/0x1fc
[ 1447.037904]  ? delete_from_page_cache_batch+0x731/0x731
[ 1447.038907]  file_write_and_wait_range+0x4a/0x77
[ 1447.039893]  ext4_sync_file+0x48a/0x807
[ 1447.040679]  ? ext4_getfsmap+0x591/0x591
[ 1447.041492]  ? file_update_time+0x22f/0x272
[ 1447.042340]  ? inode_owner_or_capable+0xb7/0xb7
[ 1447.043237]  ? dentry_needs_remove_privs+0x53/0x53
[ 1447.044207]  ? __rcu_read_unlock+0x134/0x180
[ 1447.045053]  ? generic_write_checks+0x1f9/0x24a
[ 1447.045978]  ? up_write+0xf8/0x14c
[ 1447.046668]  ? up_read+0x89/0x89
[ 1447.047330]  ? vfs_fsync_range+0xd7/0x114
[ 1447.048148]  ext4_file_write_iter+0x59f/0x7d1
[ 1447.049066]  ? ext4_write_checks+0xcc/0xcc
[ 1447.049908]  ? audit_signal_info+0x218/0x65a
[ 1447.050788]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.051779]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.052757]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.053731]  ? lock_acquire+0x32d/0x32d
[ 1447.054508]  ? rcu_read_lock_bh_held+0x3a/0x3a
[ 1447.055411]  ? kernel_sigaction+0x175/0x175
[ 1447.056261]  ? __rcu_read_unlock+0x134/0x180
[ 1447.057114]  ? rcu_read_lock_bh_held+0x3a/0x3a
[ 1447.058009]  ? __lock_acquire+0x38/0x8e5
[ 1447.058830]  __vfs_write+0x2b4/0x32f
[ 1447.059571]  ? kernel_read+0x94/0x94
[ 1447.060310]  ? lock_downgrade+0x338/0x338
[ 1447.061117]  ? ___might_sleep+0x155/0x338
[ 1447.061925]  ? __schedule_bug+0x111/0x111
[ 1447.062756]  ? debug_lockdep_rcu_enabled+0x26/0x52
[ 1447.063710]  ? rcu_sync_lockdep_assert+0xe/0x69
[ 1447.064619]  ? preempt_count_sub+0x14/0xb5
[ 1447.065462]  vfs_write+0x124/0x22a
[ 1447.066159]  ksys_pwrite64+0x6d/0x8e
[ 1447.066908]  ? ksys_pwrite64+0x8e/0x8e
[ 1447.067673]  do_syscall_64+0x1bf/0x406
[ 1447.068441]  ? syscall_return_slowpath+0x291/0x291
[ 1447.069383]  ? lockdep_sys_exit+0x16/0x8d
[ 1447.070186]  ? syscall_return_slowpath+0x239/0x291
[ 1447.071147]  ? lockdep_sys_exit+0x16/0x8d
[ 1447.072292]  ? prepare_exit_to_usermode+0x17a/0x1c4
[ 1447.073205]  ? enter_from_user_mode+0x2b/0x2b
[ 1447.074091]  ? trace_hardirqs_off_caller+0x1a/0x14a
[ 1447.075084]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 1447.076046]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[ 1447.076958] RIP: 0033:0x7fcd296ff553
[ 1447.077522] RSP: 002b:00007ffc110891c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
[ 1447.078844] RAX: ffffffffffffffda RBX: 0000000000729900 RCX: 00007fcd296ff553
[ 1447.080264] RDX: 0000000000010000 RSI: 000000000073c2b0 RDI: 0000000000000005
[ 1447.081673] RBP: 0000000000002706 R08: 0000000000010000 R09: 000000000073c2b0
[ 1447.083087] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcd29dfc678
[ 1447.084492] R13: 0000000000010000 R14: 0000000000010000 R15: 000000000073c2b0
[ 1447.085941]
[ 1447.086277] Allocated by task 13472:
[ 1447.087013]  kmem_cache_alloc+0x15e/0x2af
[ 1447.087837]  mempool_alloc+0x102/0x277
[ 1447.088615]  bvec_alloc+0xc8/0x137
[ 1447.089322]  bio_alloc_bioset+0x207/0x34c
[ 1447.090135]  ext4_bio_write_page+0x45b/0x7b7
[ 1447.091009]  mpage_submit_page+0x9e/0xd5
[ 1447.091807]  mpage_map_and_submit_buffers+0x31c/0x3ba
[ 1447.092865]  ext4_writepages+0x17e7/0x1e6d
[ 1447.093733]  do_writepages+0x57/0xa3
[ 1447.094492]  __filemap_fdatawrite_range+0x1ab/0x1fc
[ 1447.095485]  file_write_and_wait_range+0x4a/0x77
[ 1447.096418]  ext4_sync_file+0x48a/0x807
[ 1447.097189]  ext4_file_write_iter+0x59f/0x7d1
[ 1447.098079]  __vfs_write+0x2b4/0x32f
[ 1447.098807]  vfs_write+0x124/0x22a
[ 1447.099505]  ksys_pwrite64+0x6d/0x8e
[ 1447.100258]  do_syscall_64+0x1bf/0x406
[ 1447.101028]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[ 1447.102040]
[ 1447.102369] Freed by task 13469:
[ 1447.103024]  kmem_cache_free+0x139/0x2c6
[ 1447.103803]  bio_free+0x6d/0xaa
[ 1447.104435]  bio_put+0x7a/0x10e
[ 1447.105071]  ext4_end_bio+0x25d/0x2a1
[ 1447.105810]  bio_endio+0x3d9/0x41c
[ 1447.106498]  blk_update_request+0x3d8/0x617
[ 1447.107322]  blk_mq_end_request+0x2a/0xbf
[ 1447.108127]  nvme_complete_rq+0x305/0x348 [nvme_core]
[ 1447.109128]  __blk_mq_complete_request+0x391/0x3ee
[ 1447.110081]  blk_mq_complete_request+0x10e/0x159
[ 1447.111012]  nvme_process_cq+0x26a/0x34d [nvme]
[ 1447.111923]  nvme_irq+0x23/0x51 [nvme]
[ 1447.112690]  __handle_irq_event_percpu+0x29d/0x568
[ 1447.113656]  handle_irq_event_percpu+0x7c/0xf7
[ 1447.114510]  handle_irq_event+0x53/0x83
[ 1447.115055]  handle_edge_irq+0x1f2/0x279
[ 1447.115805]  handle_irq+0x1d8/0x1e9
[ 1447.116472]  do_IRQ+0x90/0x12d
[ 1447.117016]
[ 1447.117338] The buggy address belongs to the object at ffff880055a60040
[ 1447.117338]  which belongs to the cache biovec-(1<<(21-12)) of size 8192
[ 1447.119697] The buggy address is located 2496 bytes inside of
[ 1447.119697]  8192-byte region [ffff880055a60040, ffff880055a62040)
[ 1447.121885] The buggy address belongs to the page:
[ 1447.122786] page:ffffea0001569800 count:1 mapcount:0 mapping:0000000000000000 index:0xffff880055a643c0 compound_mapcount: 0
[ 1447.124793] flags: 0xfffffc0008100(slab|head)
[ 1447.125602] raw: 000fffffc0008100 0000000000000000 ffff880055a643c0 0000000100030002
[ 1447.126732] raw: ffffea0001448420 ffffea0001fe6620 ffff88005b67e340 0000000000000000
[ 1447.127831] page dumped because: kasan: bad access detected
[ 1447.128703]
[ 1447.128929] Memory state around the buggy address:
[ 1447.129677]  ffff880055a60900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1447.130719]  ffff880055a60980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1447.131856] >ffff880055a60a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1447.133192]                    ^
[ 1447.133866]  ffff880055a60a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1447.135332]  ffff880055a60b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1447.136764] ==================================================================



-- 
Ming
