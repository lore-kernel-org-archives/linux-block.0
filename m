Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180710010331.27479-1-ming.lei@redhat.com>
In-Reply-To: <20180710010331.27479-1-ming.lei@redhat.com>
MIME-Version: 1.0
Date: Tue, 17 Jul 2018 21:11:09 +0530
Message-ID: <3cc3e03901dc1a63ef32e036182521af@mail.gmail.com>
Subject: RE: [PATCH] blk-mq: issue directly if hw queue isn't busy in case of 'none'
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Tuesday, July 10, 2018 6:34 AM
> To: Jens Axboe
> Cc: linux-block@vger.kernel.org; Ming Lei; Kashyap Desai; Laurence
Oberman;
> Omar Sandoval; Christoph Hellwig; Bart Van Assche; Hannes Reinecke
> Subject: [PATCH] blk-mq: issue directly if hw queue isn't busy in case
of 'none'
>
> In case of 'none' io scheduler, when hw queue isn't busy, it isn't
> necessary to enqueue request to sw queue and dequeue it from
> sw queue because request may be submitted to hw queue asap without
> extra cost, meantime there shouldn't be much request in sw queue,
> and we don't need to worry about effect on IO merge.
>
> There are still some single hw queue SCSI HBAs(HPSA, megaraid_sas, ...)
> which may connect high performance devices, so 'none' is often required
> for obtaining good performance.

This Patch is tested on my setup and seeing very good performance
improvement.  Just use one R0 VD from configuration -

Without upstream fix and RHEL7.5 kernel -
IOPS goes 840K and CPU utilization goes upto 11%.

After applying another block layer fix -
IOPS goes 1066K and CPU utilization goes up to 6%.

Overall performance improvement is 30% performance and 80% less cpu
utilization.

Any review comments ?

Kashyap

>
> This patch improves IOPS and decreases CPU unilization on megaraid_sas,
> per Kashyap's test.
>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
