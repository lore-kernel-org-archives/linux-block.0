Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: Re: [BUG] Deadlock in blk_mq_register_disk error path
To: Jens Axboe <axboe@kernel.dk>, Jinpu Wang <jinpu.wang@profitbricks.com>,
	<linux-block@vger.kernel.org>
References: <CAMGffEmw8ako59nAkDfpHWH06xAngkKR0YYpxF24LwZMjA9P2g@mail.gmail.com>
 <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <30d05b8b-7707-a0bf-f55b-65325f55b7d8@sandisk.com>
Date: Mon, 15 Aug 2016 08:53:32 -0700
MIME-Version: 1.0
In-Reply-To: <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 08/02/2016 10:21 AM, Jens Axboe wrote:
> On 08/02/2016 06:58 AM, Jinpu Wang wrote:
>> Hi Jens,
>>
>> I found in blk_mq_register_disk, we blk_mq_disable_hotplug which in
>> turn mutex_lock(&all_q_mutex);
>>   queue_for_each_hw_ctx(q, hctx, i) {
>>                 ret = blk_mq_register_hctx(hctx);
>>                 if (ret)
>>                         break; /// if about error out, we will call
>> unregister below
>>         }
>>
>>         if (ret)
>>                 blk_mq_unregister_disk(disk);
>>
>> In blk_mq_unregister_disk, we will try to disable_hotplug again, which
>> leads to dead lock.
>>
>> Did I miss anything?
> 
> Nope, your analysis looks correct. This should fix it:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=6316338a94b2319abe9d3790eb9cdc56ef81ac1a

Hi Jens,

Will that patch be included in stable kernels? I just encountered a
deadlock with kernel v4.7 that looks similar.

Thank you,

Bart.

INFO: task kworker/u64:6:136 blocked for more than 480 seconds.
      Tainted: G        W       4.7.0-dbg+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u64:6   D ffff88016f677bb0     0   136      2 0x00000000
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 [<ffffffff81622307>] schedule+0x37/0x90
 [<ffffffff81622630>] schedule_preempt_disabled+0x10/0x20
 [<ffffffff81624414>] mutex_lock_nested+0x144/0x350
 [<ffffffff8130bbf2>] blk_mq_disable_hotplug+0x12/0x20
 [<ffffffff8130d239>] blk_mq_register_disk+0x29/0x120
 [<ffffffff81301bb6>] blk_register_queue+0xb6/0x160
 [<ffffffff81310709>] add_disk+0x219/0x4a0
 [<ffffffff8147def0>] sd_probe_async+0x100/0x1b0
 [<ffffffff81088be5>] async_run_entry_fn+0x45/0x140
 [<ffffffff8107f169>] process_one_work+0x1f9/0x6a0
 [<ffffffff8107f659>] worker_thread+0x49/0x490
 [<ffffffff81085e5a>] kthread+0xea/0x100
 [<ffffffff81627f3f>] ret_from_fork+0x1f/0x40
3 locks held by kworker/u64:6/136:
 #0:  ("events_unbound"){.+.+.+}, at: [<ffffffff8107f0ea>] process_one_work+0x17a/0x6a0
 #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8107f0ea>] process_one_work+0x17a/0x6a0
 #2:  (all_q_mutex){+.+.+.}, at: [<ffffffff8130bbf2>] blk_mq_disable_hotplug+0x12/0x20
INFO: task 02:8101 blocked for more than 480 seconds.
      Tainted: G        W       4.7.0-dbg+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
02              D ffff88039b747968     0  8101      1 0x00000004
Call Trace:
 [<ffffffff81622307>] schedule+0x37/0x90
 [<ffffffff81307aa1>] blk_mq_freeze_queue_wait+0x51/0xb0
 [<ffffffff81309fca>] blk_mq_update_tag_set_depth+0x3a/0xb0
 [<ffffffff8130a472>] blk_mq_init_allocated_queue+0x432/0x450
 [<ffffffff8130a4c5>] blk_mq_init_queue+0x35/0x60
 [<ffffffff814705b7>] scsi_mq_alloc_queue+0x17/0x50
 [<ffffffff81471429>] scsi_alloc_sdev+0x2b9/0x350
 [<ffffffff81471efb>] scsi_probe_and_add_lun+0x98b/0xe50
 [<ffffffff81472eea>] __scsi_scan_target+0x5ca/0x6b0
 [<ffffffff814730b1>] scsi_scan_target+0xe1/0xf0
 [<ffffffffa0637856>] srp_create_target+0xf06/0x13d4 [ib_srp]
 [<ffffffff8143a993>] dev_attr_store+0x13/0x20
 [<ffffffff812599b0>] sysfs_kf_write+0x40/0x50
 [<ffffffff81258d07>] kernfs_fop_write+0x137/0x1c0
 [<ffffffff811d3933>] __vfs_write+0x23/0x140
 [<ffffffff811d4b80>] vfs_write+0xb0/0x190
 [<ffffffff811d5e54>] SyS_write+0x44/0xa0
 [<ffffffff81627d25>] entry_SYSCALL_64_fastpath+0x18/0xa8
8 locks held by 02/8101:
 #0:  (sb_writers#4){.+.+.+}, at: [<ffffffff811d7b82>] __sb_start_write+0xb2/0xf0
 #1:  (&of->mutex){+.+.+.}, at: [<ffffffff81258cd1>] kernfs_fop_write+0x101/0x1c0
 #2:  (s_active#363){.+.+.+}, at: [<ffffffff81258cda>] kernfs_fop_write+0x10a/0x1c0
 #3:  (&host->add_target_mutex){+.+.+.}, at: [<ffffffffa0636a84>] srp_create_target+0x134/0x13d4 [ib_srp]
 #4:  (&shost->scan_mutex){+.+.+.}, at: [<ffffffff8147305d>] scsi_scan_target+0x8d/0xf0
 #5:  (cpu_hotplug.lock){++++++}, at: [<ffffffff810624fd>] get_online_cpus+0x2d/0x80
 #6:  (all_q_mutex){+.+.+.}, at: [<ffffffff8130a38a>] blk_mq_init_allocated_queue+0x34a/0x450
 #7:  (&set->tag_list_lock){+.+...}, at: [<ffffffff8130a3ba>] blk_mq_init_allocated_queue+0x37a/0x450
