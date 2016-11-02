Subject: Re: [PATCH v5 0/14] Fix race conditions related to stopping block
 layer queues
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, James Bottomley
 <jejb@linux.vnet.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Mike Snitzer <snitzer@redhat.com>,
 Doug Ledford <dledford@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Ming Lei <tom.leiming@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Laurence Oberman <loberman@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <cfd115a1-78e1-7ed5-3c19-42334a5dbe72@fb.com>
Date: Wed, 2 Nov 2016 12:52:54 -0600
MIME-Version: 1.0
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/28/2016 06:18 PM, Bart Van Assche wrote:
> Hello Jens,
>
> Multiple block drivers need the functionality to stop a request queue
> and to wait until all ongoing request_fn() / queue_rq() calls have
> finished without waiting until all outstanding requests have finished.
> Hence this patch series that introduces the blk_mq_quiesce_queue()
> function. The dm-mq, SRP and NVMe patches in this patch series are three
> examples of where these functions are useful. These patches have been
> tested on top of kernel v4.9-rc2. The following tests have been run to
> verify this patch series:
> - Mike's mptest suite that stress-tests dm-multipath.
> - My own srp-test suite that stress-tests SRP on top of dm-multipath.
> - fio on top of the NVMeOF host driver that was connected to the NVMeOF
>   target driver on the same host.
> - Laurence verified the previous version (v3) of this patch series by
>   running it through the Red Hat SRP and NVMe test suites.
>
> The changes compared to the third version of this patch series are:
> - Added a blk_mq_stop_hw_queues() call in blk_mq_quiesce_queue() as
>   requested by Ming Lei.
> - Modified scsi_unblock_target() such that it waits until
>   .queuecommand() finished. Unexported scsi_wait_for_queuecommand().
> - Reordered the two NVMe patches.
> - Added a patch that avoids that blk_mq_requeue_work() restarts stopped
>   queues.
> - Added a patch that removes blk_mq_cancel_requeue_work().

Bart, I have applied the series, except patches 11+12. I don't mind
taking them through the block tree, but they can go through the SCSI
tree as well. Let me know what folks think.

-- 
Jens Axboe
