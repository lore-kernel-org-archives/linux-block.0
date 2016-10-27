Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 27 Oct 2016 10:14:37 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 01/12] blk-mq: Do not invoke .queue_rq() for a stopped
 queue
Message-ID: <20161027081437.oasmbdo2se7smrb6@linux-x5ow.site>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <1debcf7f-c950-308b-d297-3e48a77e08d7@sandisk.com>
MIME-Version: 1.0
In-Reply-To: <1debcf7f-c950-308b-d297-3e48a77e08d7@sandisk.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Ming Lin <ming.l@ssi.samsung.com>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Doug Ledford <dledford@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Laurence Oberman <loberman@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 26, 2016 at 03:50:44PM -0700, Bart Van Assche wrote:
> The meaning of the BLK_MQ_S_STOPPED flag is "do not call
> .queue_rq()". Hence modify blk_mq_make_request() such that requests
> are queued instead of issued if a queue has been stopped.
> =

> Reported-by: Ming Lei <tom.leiming@gmail.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- =

Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
