Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] scsi: revert two commits for avoiding host-wide
 host_busy counter for scsi_mq
To: Ming Lei <ming.lei@redhat.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>, Mike Snitzer
 <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Laurence Oberman <loberman@redhat.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
References: <20180827072443.26920-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a0d4b20a-add0-8f47-b94d-070209477280@kernel.dk>
Date: Mon, 27 Aug 2018 08:52:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180827072443.26920-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/27/18 1:24 AM, Ming Lei wrote:
> Hi,
> 
> There is fundamental issue in commit 328728630d9f2bf1 (scsi: core: avoid
> host-wide host_busy counter for scsi_mq) because SCSI's host busy counter
> may not be same with counter of blk-mq's inflight tags, especially in case
> of none io scheduler.
> 
> So please revert the two commits.

Please do, they break changing write cache mode on my SATA drives. You
can add my tested-by and/or reported-by to this.

-- 
Jens Axboe
