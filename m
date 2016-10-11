Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Tue, 11 Oct 2016 18:44:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v2 6/7] SRP transport: Port srp_wait_for_queuecommand()
 to scsi-mq
Message-ID: <20161011164417.GB18822@lst.de>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
 <8ce2910d-fde0-724f-a61f-8fbd7fbf499d@grimberg.me>
 <619e3ffc-2123-4cb0-361a-4025ba47b991@sandisk.com>
MIME-Version: 1.0
In-Reply-To: <619e3ffc-2123-4cb0-361a-4025ba47b991@sandisk.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>,
 James Bottomley <jejb@linux.vnet.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Doug Ledford <dledford@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 05, 2016 at 02:51:50PM -0700, Bart Van Assche wrote:
> There are multiple direct blk_*() calls in other SCSI transport drivers. So 
> my proposal is to wait with moving this code into scsi_lib.c until there is 
> a second user of this code.

I still don't think these low-level difference for blk-mq vs legacy
request belong into a scsi LLDD.  So I concur with Sagi that this
should go into the core SCSI code.

In fact I suspect we should just call it directly from
scsi_internal_device_block, and maybe even scsi_internal_device_unblock
for case of setting the device offline.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
