Return-Path: <jthumshirn@suse.de>
Date: Thu, 20 Sep 2018 09:35:27 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v9 1/8] blk-mq: Document the functions that iterate over
 requests
Message-ID: <20180920073527.GB5637@linux-x5ow.site>
References: <20180919224530.222469-1-bvanassche@acm.org>
 <20180919224530.222469-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180919224530.222469-2-bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 19, 2018 at 03:45:23PM -0700, Bart Van Assche wrote:
> Make it easier to understand the purpose of the functions that iterate
> over requests by documenting their purpose. Fix three minor spelling
> mistakes in comments in these functions.

[...]

>  
> +/*
> + * Call function @fn(@hctx, rq, @data, @reserved) for each request queued on
> + * @hctx that has been assigned a driver tag. @reserved indicates whether @bt
> + * is the breserved_tags member or the bitmap_tags member of struct
> + * blk_mq_tags.
> + */
>  static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
>  			busy_iter_fn *fn, void *data, bool reserved)

One minor nit and only if you have to re-send the series, can you
please also add the usual kernel-doc headers to the comments, i.e.:


/**
 * bt_for_each() - run callback on each hctx with a driver tag
 * @hctx:	the hardware context
 * @bt:		the sbitmap_queue
 * @fn:		the callback function to run
 * @data:	the data for the callback function
 * @reserved:	is reserved or not
 *
 * Call function @fn(@hctx, rq, @data, @reserved) for each request queued on
 * @hctx that has been assigned a driver tag. @reserved indicates whether @bt
 * is the breserved_tags member or the bitmap_tags member of struct
 * blk_mq_tags.
 */
static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
  			busy_iter_fn *fn, void *data, bool reserved)


Otherwise:
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
