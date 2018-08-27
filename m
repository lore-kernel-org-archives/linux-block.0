Return-Path: <martin.petersen@oracle.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] scsi: revert two commits for avoiding host-wide host_busy counter for scsi_mq
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180827072443.26920-1-ming.lei@redhat.com>
Date: Mon, 27 Aug 2018 13:00:53 -0400
In-Reply-To: <20180827072443.26920-1-ming.lei@redhat.com> (Ming Lei's message
	of "Mon, 27 Aug 2018 15:24:41 +0800")
Message-ID: <yq1va7v68xm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Ming,

> There is fundamental issue in commit 328728630d9f2bf1 (scsi: core: avoid
> host-wide host_busy counter for scsi_mq) because SCSI's host busy counter
> may not be same with counter of blk-mq's inflight tags, especially in case
> of none io scheduler.
>
> So please revert the two commits.

Applied to 4.19/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
