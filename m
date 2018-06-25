Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] scsi: avoid to hold host-wide counter of host_busy
 for scsi_mq
To: Ming Lei <ming.lei@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>
References: <20180624140327.28146-1-ming.lei@redhat.com>
 <20180624140327.28146-3-ming.lei@redhat.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <27a6f54a-49b5-460f-08fb-c7b9d2dc52ef@wdc.com>
Date: Mon, 25 Jun 2018 08:38:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180624140327.28146-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 06/24/18 07:04, Ming Lei wrote:
> It isn't necessary to check the host depth in scsi_queue_rq() any more
> since it has been respected by blk-mq before calling scsi_queue_rq() via
> getting driver tag.
> 
> Lots of LUNs may attach to same host, and per-host IOPS may reach millions
> level, so we should avoid to this expensive atomic operations on the
> hostwide counter in IO path.
> 
> This patch implemens scsi_host_busy() via blk_mq_tagset_busy_iter() for
> reading the count of busy IOs for scsi_mq.
> 
> It is observed that IOPS is increased by 15% in IO test on scsi_debug
> (32 LUNs, 32 submit queues, 1024 can_queue, libaio/dio) in one
> dual-socket system.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
