Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH v4 0/12] Fix race conditions related to stopping block
 layer queues
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <529affae-3470-b1ae-8873-35de53628e8c@fb.com>
Date: Wed, 26 Oct 2016 17:28:55 -0600
MIME-Version: 1.0
In-Reply-To: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ming Lin <ming.l@ssi.samsung.com>, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>, Doug Ledford <dledford@redhat.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Laurence Oberman <loberman@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 10/26/2016 04:49 PM, Bart Van Assche wrote:
> Hello Jens,
>
> Multiple block drivers need the functionality to stop a request queue
> and to wait until all ongoing request_fn() / queue_rq() calls have
> finished without waiting until all outstanding requests have finished.
> Hence this patch series that introduces the blk_mq_quiesce_queue()
> function. The dm-mq, SRP and NVMe patches in this patch series are three
> examples of where these functions are useful. These patches have been
> tested on top of kernel v4.9-rc1. The following tests have been run to
> verify this patch series:
> - Mike's mptest suite that stress-tests dm-multipath.
> - My own srp-test suite that stress-tests SRP on top of dm-multipath.
> - fio on top of the NVMeOF host driver that was connected to the NVMeOF
>   target driver on the same host.
> - Laurence verified the previous version (v3) of this patch series by
>   running it through the Red Hat SRP and NVMe test suites.

This looks pretty good, I'll run some testing on it tomorrow and do a
full review, hopefully we can get it applied sooner rather than later
for the next series.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
