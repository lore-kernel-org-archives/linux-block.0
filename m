Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Hard lockup in blk_mq_free_request() / wbt_done() / wake_up_all()
To: Chris Boot <bootc@boo.tc>
References: <9788e0e6-a448-bf85-1f41-88f42dc0071d@boo.tc>
 <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
 <7080a91c-8d9a-6305-2b67-dc27a374327a@boo.tc>
 <d8ba8949-259a-c0c0-d476-710bcf69c266@kernel.dk>
 <9c444ab8-2e50-c42a-dae1-86954358218e@boo.tc>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <7dbe184d-5660-7b64-8027-bf4f82625ff2@I-love.SAKURA.ne.jp>
Date: Sat, 30 Jun 2018 22:12:33 +0900
MIME-Version: 1.0
In-Reply-To: <9c444ab8-2e50-c42a-dae1-86954358218e@boo.tc>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/06/20 21:45, Chris Boot wrote:
> Hi Jens,
> 
> I got an opportunity yesterday to do some testing. I can't get this
> system to crash with blk-mq disabled, or with blk-mq enabled but wbt
> disabled. I have a reproducer workload I can launch against the system
> and it seems to crash reliably with this, but I doubt I can share it
> with you.
> 
> I do, however, have a task state dump (SysRq+T) that I managed to get
> out of the server once it started locking up. It's pretty large, so I
> uploaded it to my Dropbox for now:
> 
> https://www.dropbox.com/s/fyo1ab6mmcqk8fq/crash-1.log.gz?dl=0
> 
> Hope this helps!

I'm not familiar with block layer, but checking Workqueue entries in SysRq-t.
blk_mq_timeout_work was stuck at RCU synchronization and wb_workfn was
stuck at wbt_wait() ?

----------------------------------------
[ 5376.011390] kworker/73:1H   D    0  1803      2 0x80000000
[ 5376.017418] Workqueue: kblockd blk_mq_timeout_work
[ 5376.022770] Call Trace:
[ 5376.025805]  ? __schedule+0x3dc/0x870
[ 5376.030009]  schedule+0x32/0x80
[ 5376.033737]  schedule_timeout+0x1e5/0x350
[ 5376.038298]  ? scsi_dispatch_cmd+0xe5/0x220 [scsi_mod]
[ 5376.043976]  ? scsi_queue_rq+0x4d2/0x600 [scsi_mod]
[ 5376.049425]  wait_for_completion+0x123/0x190
[ 5376.054270]  ? wake_up_q+0x70/0x70
[ 5376.058262]  __wait_rcu_gp+0x10f/0x140
[ 5376.062736]  synchronize_sched+0x59/0x80
[ 5376.067208]  ? call_rcu_bh+0x20/0x20
[ 5376.071350]  ? trace_raw_output_rcu_utilization+0x40/0x40
[ 5376.077312]  blk_mq_timeout_work+0x138/0x200
[ 5376.082152]  process_one_work+0x177/0x350
[ 5376.086692]  worker_thread+0x4d/0x3c0
[ 5376.090903]  kthread+0xf8/0x130
[ 5376.094588]  ? rescuer_thread+0x350/0x350
[ 5376.099128]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 5376.104745]  ? SyS_exit_group+0x10/0x10
[ 5376.109189]  ret_from_fork+0x35/0x40
----------------------------------------

----------------------------------------
[ 5391.381393] kworker/u225:0  D    0  9248      2 0x80000000
[ 5391.387404] Workqueue: writeback wb_workfn (flush-254:6)
[ 5391.393337] Call Trace:
[ 5391.396347]  ? __schedule+0x3dc/0x870
[ 5391.400533]  schedule+0x32/0x80
[ 5391.404253]  io_schedule+0x12/0x40
[ 5391.408188]  wbt_wait+0x277/0x350
[ 5391.412045]  ? remove_wait_queue+0x60/0x60
[ 5391.416706]  blk_mq_make_request+0x107/0x5f0
[ 5391.421510]  ? __split_and_process_bio+0x131/0x190 [dm_mod]
[ 5391.427687]  generic_make_request+0x123/0x2f0
[ 5391.432627]  ? submit_bio+0x6c/0x140
[ 5391.436734]  ? _cond_resched+0x16/0x40
[ 5391.441051]  submit_bio+0x6c/0x140
[ 5391.444987]  ? kmem_cache_alloc+0xda/0x1b0
[ 5391.449645]  ext4_io_submit+0x48/0x60 [ext4]
[ 5391.454489]  ext4_writepages+0x49c/0xe60 [ext4]
[ 5391.459594]  ? scsi_queue_rq+0x4d2/0x600 [scsi_mod]
[ 5391.465015]  ? update_load_avg+0x64f/0x6e0
[ 5391.469651]  ? do_writepages+0x1a/0x60
[ 5391.473932]  do_writepages+0x1a/0x60
[ 5391.478059]  __writeback_single_inode+0x3d/0x320
[ 5391.483226]  writeback_sb_inodes+0x221/0x4b0
[ 5391.488060]  __writeback_inodes_wb+0x87/0xb0
[ 5391.492897]  wb_writeback+0x288/0x320
[ 5391.497110]  ? cpumask_next+0x16/0x20
[ 5391.501346]  ? wb_workfn+0x37c/0x450
[ 5391.505461]  wb_workfn+0x37c/0x450
[ 5391.509461]  process_one_work+0x177/0x350
[ 5391.514002]  worker_thread+0x4d/0x3c0
[ 5391.518197]  kthread+0xf8/0x130
[ 5391.521870]  ? rescuer_thread+0x350/0x350
[ 5391.526403]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 5391.532029]  ? SyS_exit_group+0x10/0x10
[ 5391.536405]  ret_from_fork+0x35/0x40
----------------------------------------

Impossible to tell whether these threads made progress over time.
Please try https://akari.osdn.jp/capturing-kernel-messages.html#Tips5 .

But synchronize_rcu() in blk_mq_timeout_work() seems to be removed by
commit 12f5b93145450c75 ("blk-mq: Remove generation seqeunce") which went to
4.18-rc1. Thus, trying to reproduce with latest linux.git would be helpful.
