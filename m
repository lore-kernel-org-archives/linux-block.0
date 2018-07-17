Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: issue directly if hw queue isn't busy in case of
 'none'
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20180710010331.27479-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f68b107b-f5e2-18ff-e4ce-0b86a42c4efe@kernel.dk>
Date: Tue, 17 Jul 2018 16:04:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180710010331.27479-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/9/18 7:03 PM, Ming Lei wrote:
> In case of 'none' io scheduler, when hw queue isn't busy, it isn't
> necessary to enqueue request to sw queue and dequeue it from
> sw queue because request may be submitted to hw queue asap without
> extra cost, meantime there shouldn't be much request in sw queue,
> and we don't need to worry about effect on IO merge.
> 
> There are still some single hw queue SCSI HBAs(HPSA, megaraid_sas, ...)
> which may connect high performance devices, so 'none' is often required
> for obtaining good performance.
> 
> This patch improves IOPS and decreases CPU unilization on megaraid_sas,
> per Kashyap's test.

Looks reasonable to me, applied for 4.19.

-- 
Jens Axboe
