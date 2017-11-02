Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 07:38:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171102233835.GA27370@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
 <20171101014611.GA8200@ming.t460p>
 <59F9FE28-F31A-47FD-A3FD-90CE1DB38FB2@kernel.dk>
 <20171101020312.GA9527@ming.t460p>
 <e6c4aa07-6427-bbee-ba14-fcba5e4f29ac@kernel.dk>
 <1509638224.2484.14.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509638224.2484.14.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 02, 2017 at 03:57:05PM +0000, Bart Van Assche wrote:
> On Wed, 2017-11-01 at 08:21 -0600, Jens Axboe wrote:
> > Fixed that up, and applied these two patches as well.
> 
> Hello Jens,
> 
> Recently I noticed that a test system sporadically hangs during boot (Dell
> PowerEdge R720 that boots from a hard disk connected to a MegaRAID SAS adapter)
> and also that srp-tests systematically hangs. Reverting the two patches from
> this series fixes both issues. I'm not sure there is another solution than
> reverting the two patches from this series.

Then we need to find the root cause, instead of using sort of workaround
as before.

For SCSI, the restart is always run from scsi_end_request(), and this
kind of restart from all hctx isn't necessary at all.

> 
> Bart.
> 
> 
> BTW, the following appeared in the kernel log when I tried to run srp-tests
> against a kernel with the two patches from this series applied:
> 
> INFO: task kworker/19:1:209 blocked for more than 480 seconds.
> INFO: task kworker/19:1:209 blocked for more than 480 seconds.
>       Tainted: G        W       4.14.0-rc7-dbg+ #1
>       Tainted: G        W       4.14.0-rc7-dbg+ #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/19:1    D    0   209      2 0x80000000
> kworker/19:1    D    0   209      2 0x80000000
> Workqueue: srp_remove srp_remove_work [ib_srp]
> Workqueue: srp_remove srp_remove_work [ib_srp]
> Call Trace:
> Call Trace:
>  __schedule+0x2fa/0xbb0
>  __schedule+0x2fa/0xbb0
>  schedule+0x36/0x90
>  schedule+0x36/0x90
>  async_synchronize_cookie_domain+0x88/0x130
>  async_synchronize_cookie_domain+0x88/0x130
>  ? finish_wait+0x90/0x90
>  ? finish_wait+0x90/0x90
>  async_synchronize_full_domain+0x18/0x20
>  async_synchronize_full_domain+0x18/0x20
>  sd_remove+0x4d/0xc0 [sd_mod]
>  sd_remove+0x4d/0xc0 [sd_mod]
>  device_release_driver_internal+0x160/0x210
>  device_release_driver_internal+0x160/0x210
>  device_release_driver+0x12/0x20
>  device_release_driver+0x12/0x20
>  bus_remove_device+0x100/0x180
>  bus_remove_device+0x100/0x180
>  device_del+0x1d8/0x340
>  device_del+0x1d8/0x340
>  __scsi_remove_device+0xfc/0x130
>  __scsi_remove_device+0xfc/0x130
>  scsi_forget_host+0x25/0x70
>  scsi_forget_host+0x25/0x70
>  scsi_remove_host+0x79/0x120
>  scsi_remove_host+0x79/0x120
>  srp_remove_work+0x90/0x1d0 [ib_srp]
>  srp_remove_work+0x90/0x1d0 [ib_srp]
>  process_one_work+0x20a/0x660
>  process_one_work+0x20a/0x660
>  worker_thread+0x3d/0x3b0
>  worker_thread+0x3d/0x3b0
>  kthread+0x13a/0x150
>  kthread+0x13a/0x150
>  ? process_one_work+0x660/0x660
>  ? process_one_work+0x660/0x660
>  ? kthread_create_on_node+0x40/0x40
>  ? kthread_create_on_node+0x40/0x40
>  ret_from_fork+0x27/0x40
>  ret_from_fork+0x27/0x40
> 
> Showing all locks held in the system:
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/170:
> 1 lock held by khungtaskd/170:
>  #0:  (tasklist_lock){.+.+}, at: [<ffffffff810c125d>] debug_show_all_locks+0x3d/0x1a0
>  #0:  (tasklist_lock){.+.+}, at: [<ffffffff810c125d>] debug_show_all_locks+0x3d/0x1a0
> 4 locks held by kworker/19:1/209:
> 4 locks held by kworker/19:1/209:
>  #0:  ("%s"("srp_remove")){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #0:  ("%s"("srp_remove")){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&target->remove_work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&target->remove_work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #2:  (&shost->scan_mutex){+.+.}, at: [<ffffffff814807bf>] scsi_remove_host+0x1f/0x120
>  #2:  (&shost->scan_mutex){+.+.}, at: [<ffffffff814807bf>] scsi_remove_host+0x1f/0x120
>  #3:  (&dev->mutex){....}, at: [<ffffffff814501a9>] device_release_driver_internal+0x39/0x210
>  #3:  (&dev->mutex){....}, at: [<ffffffff814501a9>] device_release_driver_internal+0x39/0x210
> 2 locks held by kworker/u66:0/1927:
> 2 locks held by kworker/u66:0/1927:
>  #0:  ("events_unbound"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #0:  ("events_unbound"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&entry->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&entry->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
> 2 locks held by kworker/5:0/2047:
> 2 locks held by kworker/5:0/2047:
>  #0:  ("kaluad"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #0:  ("kaluad"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&(&pg->rtpg_work)->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&(&pg->rtpg_work)->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
> 
> 
> =============================================
> 
> =============================================
> 
> INFO: task kworker/19:1:209 blocked for more than 480 seconds.
> INFO: task kworker/19:1:209 blocked for more than 480 seconds.
>       Tainted: G        W       4.14.0-rc7-dbg+ #1
>       Tainted: G        W       4.14.0-rc7-dbg+ #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/19:1    D    0   209      2 0x80000000
> kworker/19:1    D    0   209      2 0x80000000
> Workqueue: srp_remove srp_remove_work [ib_srp]
> Workqueue: srp_remove srp_remove_work [ib_srp]
> Call Trace:
> Call Trace:
>  __schedule+0x2fa/0xbb0
>  __schedule+0x2fa/0xbb0
>  schedule+0x36/0x90
>  schedule+0x36/0x90
>  async_synchronize_cookie_domain+0x88/0x130
>  async_synchronize_cookie_domain+0x88/0x130
>  ? finish_wait+0x90/0x90
>  ? finish_wait+0x90/0x90
>  async_synchronize_full_domain+0x18/0x20
>  async_synchronize_full_domain+0x18/0x20
>  sd_remove+0x4d/0xc0 [sd_mod]
>  sd_remove+0x4d/0xc0 [sd_mod]
>  device_release_driver_internal+0x160/0x210
>  device_release_driver_internal+0x160/0x210
>  device_release_driver+0x12/0x20
>  device_release_driver+0x12/0x20
>  bus_remove_device+0x100/0x180
>  bus_remove_device+0x100/0x180
>  device_del+0x1d8/0x340
>  device_del+0x1d8/0x340
>  __scsi_remove_device+0xfc/0x130
>  __scsi_remove_device+0xfc/0x130
>  scsi_forget_host+0x25/0x70
>  scsi_forget_host+0x25/0x70
>  scsi_remove_host+0x79/0x120
>  scsi_remove_host+0x79/0x120
>  srp_remove_work+0x90/0x1d0 [ib_srp]
>  srp_remove_work+0x90/0x1d0 [ib_srp]
>  process_one_work+0x20a/0x660
>  process_one_work+0x20a/0x660
>  worker_thread+0x3d/0x3b0
>  worker_thread+0x3d/0x3b0
>  kthread+0x13a/0x150
>  kthread+0x13a/0x150
>  ? process_one_work+0x660/0x660
>  ? process_one_work+0x660/0x660
>  ? kthread_create_on_node+0x40/0x40
>  ? kthread_create_on_node+0x40/0x40
>  ret_from_fork+0x27/0x40
>  ret_from_fork+0x27/0x40
> 
> Showing all locks held in the system:
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/170:
> 1 lock held by khungtaskd/170:
>  #0:  (tasklist_lock){.+.+}, at: [<ffffffff810c125d>] debug_show_all_locks+0x3d/0x1a0
>  #0:  (tasklist_lock){.+.+}, at: [<ffffffff810c125d>] debug_show_all_locks+0x3d/0x1a0
> 4 locks held by kworker/19:1/209:
> 4 locks held by kworker/19:1/209:
>  #0:  ("%s"("srp_remove")){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #0:  ("%s"("srp_remove")){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&target->remove_work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&target->remove_work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #2:  (&shost->scan_mutex){+.+.}, at: [<ffffffff814807bf>] scsi_remove_host+0x1f/0x120
>  #2:  (&shost->scan_mutex){+.+.}, at: [<ffffffff814807bf>] scsi_remove_host+0x1f/0x120
>  #3:  (&dev->mutex){....}, at: [<ffffffff814501a9>] device_release_driver_internal+0x39/0x210
>  #3:  (&dev->mutex){....}, at: [<ffffffff814501a9>] device_release_driver_internal+0x39/0x210
> 2 locks held by kworker/u66:0/1927:
> 2 locks held by kworker/u66:0/1927:
>  #0:  ("events_unbound"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #0:  ("events_unbound"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&entry->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&entry->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
> 2 locks held by kworker/5:0/2047:
> 2 locks held by kworker/5:0/2047:
>  #0:  ("kaluad"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #0:  ("kaluad"){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&(&pg->rtpg_work)->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
>  #1:  ((&(&pg->rtpg_work)->work)){+.+.}, at: [<ffffffff81083b85>] process_one_work+0x195/0x660
> 
> 
> =============================================
> 
> =============================================

-- 
Ming
