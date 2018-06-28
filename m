Return-Path: <jthumshirn@suse.de>
Date: Thu, 28 Jun 2018 09:27:08 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] blk-mq: use list_splice_tail() to insert requests
Message-ID: <20180628072708.o2l56feqtdfbqail@linux-x5ow.site>
References: <20180628031918.17694-1-ming.lei@redhat.com>
 <20180628031918.17694-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180628031918.17694-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

On Thu, Jun 28, 2018 at 11:19:16AM +0800, Ming Lei wrote:
> +	list_for_each_entry(rq, list, queuelist) {
>  		BUG_ON(rq->mq_ctx != ctx);
> -		list_del_init(&rq->queuelist);
> -		__blk_mq_insert_req_list(hctx, rq, false);
> +		trace_block_rq_insert(hctx->queue, rq);
>  	}

I wonder if we really need the above loop unconditionally. It does
some BUG_ON() sanity checking (which I hate but it was already there
so not your problem) and tracing of the request insertion.

So can we maybe only run this loop if tracing is enabled? Not sure if
this is possible though. Maybe Steven (Cced) can help here.

Byte,
     Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
