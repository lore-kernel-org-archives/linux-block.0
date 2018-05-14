Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Laurence Oberman <loberman@redhat.com>
References: <20180511122933.27155-1-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
Date: Mon, 14 May 2018 16:21:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180511122933.27155-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

Please refer to my test log and analysis.

[  229.872622] nvme nvme0: I/O 164 QID 1 timeout, reset controller
[  229.872649] nvme nvme0: EH 0: before shutdown
[  229.872683] nvme nvme0: I/O 165 QID 1 timeout, reset controller
[  229.872700] nvme nvme0: I/O 166 QID 1 timeout, reset controller
[  229.872716] nvme nvme0: I/O 167 QID 1 timeout, reset controller
[  229.872733] nvme nvme0: I/O 169 QID 1 timeout, reset controller
[  229.872750] nvme nvme0: I/O 173 QID 1 timeout, reset controller
[  229.872766] nvme nvme0: I/O 174 QID 1 timeout, reset controller
[  229.872783] nvme nvme0: I/O 178 QID 1 timeout, reset controller
[  229.872800] nvme nvme0: I/O 182 QID 1 timeout, aborting
[  229.872900] nvme nvme0: I/O 185 QID 1 timeout, aborting
[  229.872975] nvme nvme0: I/O 190 QID 1 timeout, reset controller
[  229.872990] nvme nvme0: I/O 191 QID 1 timeout, aborting
[  229.873021] nvme nvme0: I/O 5 QID 2 timeout, aborting
[  229.873096] nvme nvme0: I/O 40 QID 2 timeout, aborting
[  229.874041] nvme nvme0: Abort status: 0x0
[  229.874064] nvme nvme0: Abort status: 0x0
[  229.874078] nvme nvme0: Abort status: 0x0
[  229.874092] nvme nvme0: Abort status: 0x0
[  229.874106] nvme nvme0: Abort status: 0x0
[  230.060698] nvme nvme0: EH 0: after shutdown, top eh: 1
[  290.840592] nvme nvme0: I/O 18 QID 0 timeout, disable controller
[  290.840746] nvme nvme0: EH 1: before shutdown

[  290.992650] ------------[ cut here ]------------
[  290.992751] Trying to free already-free IRQ 133
[  290.992783] WARNING: CPU: 6 PID: 227 at /home/will/u04/source_code/linux-stable/kernel/irq/manage.c:1549 __free_irq+0xf6/0x420
[  290.993394] CPU: 6 PID: 227 Comm: kworker/u16:4 Kdump: loaded Not tainted 4.17.0-rc3+ #37
[  290.993402] Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
[  290.993418] Workqueue: nvme-reset-wq nvme_eh_work
[  290.993436] RIP: 0010:__free_irq+0xf6/0x420
...
[  290.993541] Call Trace:
[  290.993581]  free_irq+0x4c/0xa0
[  290.993600]  pci_free_irq+0x18/0x30
[  290.993615]  nvme_dev_disable+0x20b/0x720
[  290.993745]  nvme_eh_work+0xdd/0x4b0
[  290.993866]  process_one_work+0x3ca/0xaa0
[  290.993960]  worker_thread+0x89/0x6c0
[  290.994017]  kthread+0x18d/0x1e0
[  290.994061]  ret_from_fork+0x24/0x30
[  338.912379] INFO: task kworker/u16:4:227 blocked for more than 30 seconds.
[  338.913348]       Tainted: G        W         4.17.0-rc3+ #37
[  338.913549] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  338.913809] kworker/u16:4   D    0   227      2 0x80000000
[  338.913842] Workqueue: nvme-reset-wq nvme_eh_work
[  338.913857] Call Trace:
[  338.914002]  schedule+0x52/0xe0
[  338.914019]  schedule_preempt_disabled+0x14/0x20
[  338.914029]  __mutex_lock+0x5b4/0xca0
[  338.914228]  nvme_eh_work+0x11a/0x4b0
[  338.914344]  process_one_work+0x3ca/0xaa0
[  338.914440]  worker_thread+0x89/0x6c0
[  338.914496]  kthread+0x18d/0x1e0
[  338.914542]  ret_from_fork+0x24/0x30
[  338.914648]

Here is the deadlock scenario.

nvme_eh_work // EH0
  -> nvme_reset_dev //hold reset_lock
    -> nvme_setup_io_queues
      -> nvme_create_io_queues
        -> nvme_create_queue
          -> set nvmeq->cq_vector
          -> adapter_alloc_cq
          -> adapter_alloc_sq
             irq has not been requested
             io timeout 
                                    nvme_eh_work //EH1
                                      -> nvme_dev_disable
                                        -> quiesce the adminq //----> here !
                                        -> nvme_suspend_queue
                                          print out warning Trying to free already-free IRQ 133
                                        -> nvme_cancel_request // complete the timeout admin request
                                      -> require reset_lock
          -> adapter_delete_cq
            -> adapter_delete_queue // submit to the adminq which has been quiesced.
              -> nvme_submit_sync_cmd
                -> blk_execute_rq
                  -> wait_for_completion_io_timeout
                  hang_check is true, so there is no hung task warning for this context

EH0 submit cq delete admin command, but it will never be completed or timed out, because the admin request queue has
been quiesced, so the reset_lock cannot be released, and EH1 cannot get reset_lock and make things forward.

Thanks
Jianchao
