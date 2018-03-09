Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Fri, 9 Mar 2018 16:01:41 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Ming Lei <ming.lei@redhat.com>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V4 0/4] SCSI: fix selection of reply(hw) queue
In-Reply-To: <20180309033218.23042-1-ming.lei@redhat.com>
Message-ID: <alpine.LRH.2.21.1803091559580.7679@math.ut.ee>
References: <20180309033218.23042-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

> V4:
> 	- splitted from previous patchset
> 	- handle virtio-scsi by force_blk_mq
> 
> Ming Lei (4):
>   scsi: hpsa: fix selection of reply queue
>   scsi: megaraid_sas: fix selection of reply queue
>   scsi: introduce force_blk_mq
>   scsi: virtio_scsi: fix IO hang caused by irq vector automatic affinity

Works on HP DL360G6 with integrated smartarray, with no visible 
regressions.

-- 
Meelis Roos (mroos@linux.ee)
