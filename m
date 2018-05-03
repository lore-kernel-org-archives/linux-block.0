Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 3 May 2018 18:03:17 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: general protection fault in wb_workfn
Message-ID: <20180503160317.xsbgbp4jqd46zcil@quack2.suse.cz>
References: <000000000000e563d7056a35bbb3@google.com>
 <00db9c75-e498-5324-622b-685e6888601e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <00db9c75-e498-5324-622b-685e6888601e@I-love.SAKURA.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon 23-04-18 19:09:51, Tetsuo Handa wrote:
> On 2018/04/20 1:05, syzbot wrote:
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN
> > Dumping ftrace buffer:
> > �� (ftrace buffer empty)
> > Modules linked in:
> > CPU: 0 PID: 28 Comm: kworker/u4:2 Not tainted 4.16.0-rc7+ #368
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: writeback wb_workfn
> > RIP: 0010:dev_name include/linux/device.h:981 [inline]
> > RIP: 0010:wb_workfn+0x1a2/0x16b0 fs/fs-writeback.c:1936
> > RSP: 0018:ffff8801d951f038 EFLAGS: 00010206
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81bf6ea5
> > RDX: 000000000000000a RSI: ffffffff87b44840 RDI: 0000000000000050
> > RBP: ffff8801d951f558 R08: 1ffff1003b2a3def R09: 0000000000000004
> > R10: ffff8801d951f438 R11: 0000000000000004 R12: 0000000000000100
> > R13: ffff8801baee0dc0 R14: ffff8801d951f530 R15: ffff8801baee10d8
> > FS:� 0000000000000000(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
> > CS:� 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000047ff80 CR3: 0000000007a22006 CR4: 00000000001626f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> > �process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
> > �process_scheduled_works kernel/workqueue.c:2173 [inline]
> > �worker_thread+0xa4b/0x1990 kernel/workqueue.c:2252
> > �kthread+0x33c/0x400 kernel/kthread.c:238
> > �ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
> 
> This report says that wb->bdi->dev == NULL
> 
>   static inline const char *dev_name(const struct device *dev)
>   {
>     /* Use the init name until the kobject becomes available */
>     if (dev->init_name)
>       return dev->init_name;
>   
>     return kobject_name(&dev->kobj);
>   }
> 
>   void wb_workfn(struct work_struct *work)
>   {
>   (...snipped...)
>      set_worker_desc("flush-%s", dev_name(wb->bdi->dev));
>   (...snipped...)
>   }
> 
> immediately after ioctl(LOOP_CTL_REMOVE) was requested. It is plausible
> because ioctl(LOOP_CTL_REMOVE) sets bdi->dev to NULL after returning from
> wb_shutdown().
> 
> loop_control_ioctl(LOOP_CTL_REMOVE) {
>   loop_remove(lo) {
>     del_gendisk(lo->lo_disk) {
>       bdi_unregister(disk->queue->backing_dev_info) {
>         bdi_remove_from_list(bdi);
>         wb_shutdown(&bdi->wb);
>         cgwb_bdi_unregister(bdi);
>         if (bdi->dev) {
>           bdi_debug_unregister(bdi);
>           device_unregister(bdi->dev);
>           bdi->dev = NULL;
>         }
>       }
>     }
>   }
> }
> 
> For some reason wb_shutdown() is not waiting for wb_workfn() to complete
> ( or something queues again after WB_registered bit was cleared ) ?
> 
> Anyway, I think that this is block layer problem rather than fs layer
> problem.

Thanks for the analysis. I think I can see where is the problem -
wb_workfn() can requeue the work while wb_shutdown() is running I'll send a
patch shortly.

> By the way, I got a newbie question regarding commit 5318ce7d46866e1d ("bdi:
> Shutdown writeback on all cgwbs in cgwb_bdi_destroy()"). It uses clear_bit()
> to clear WB_shutting_down bit so that threads waiting at wait_on_bit() will
> wake up. But clear_bit() itself does not wake up threads, does it? Who wakes
> them up (e.g. by calling wake_up_bit()) after clear_bit() was called?

Yeah, that's a bug. Thanks for fixing it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
