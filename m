Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 28 Aug 2018 10:54:16 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
	Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Mike Snitzer <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH 0/2] scsi: revert two commits for avoiding host-wide
 host_busy counter for scsi_mq
Message-ID: <20180828175416.GA18173@vader>
References: <20180827072443.26920-1-ming.lei@redhat.com>
 <a0d4b20a-add0-8f47-b94d-070209477280@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a0d4b20a-add0-8f47-b94d-070209477280@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 27, 2018 at 08:52:34AM -0600, Jens Axboe wrote:
> On 8/27/18 1:24 AM, Ming Lei wrote:
> > Hi,
> > 
> > There is fundamental issue in commit 328728630d9f2bf1 (scsi: core: avoid
> > host-wide host_busy counter for scsi_mq) because SCSI's host busy counter
> > may not be same with counter of blk-mq's inflight tags, especially in case
> > of none io scheduler.
> > 
> > So please revert the two commits.
> 
> Please do, they break changing write cache mode on my SATA drives. You
> can add my tested-by and/or reported-by to this.

Jens, how does it break? Could we add a blktest for it?
