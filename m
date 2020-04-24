Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F64C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745552084D
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgDXNRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:17:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgDXNRv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 09:17:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31851ABC2;
        Fri, 24 Apr 2020 13:17:49 +0000 (UTC)
Subject: Re: [PATCH V8 05/11] blk-mq: support rq filter callback when
 iterating rqs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-6-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <69c1f94f-1363-5c58-0168-3dc07fe91ea1@suse.de>
Date:   Fri, 24 Apr 2020 15:17:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> Now request is thought as in-flight only when its state is updated as
> MQ_RQ_IN_FLIGHT, which is done by dirver via blk_mq_start_request().
> 

driver

> Actually from blk-mq's view, one rq can be thought as in-flight
> after its tag is >= 0.
> 
Well, and that we should clarify to avoid any misunderstanding.
To my understanding, 'in-flight' are request which are submitted to
the LLD. IE we'll have a lifetime rule like

internal_tag >= tag > in-flight

If the existence of a 'tag' would be equivalent to 'in-flight' we could
do away with all the convoluted code managing the MQ_RQ_IN_FLIGHT state, 
wouldn't we?

> Passing one rq filter callback so that we can iterating requests very
> flexiable.
> 

flexible

> Meantime blk_mq_all_tag_busy_iter is defined as public, which will be
> called from blk-mq internally.
> 
Maybe:

Implement blk_mq_all_tag_busy_iter() which accepts a 'busy_fn' argument
to filter over which commands to iterate, and make the existing 
blk_mq_tag_busy_iter() a wrapper for the new function.

> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c | 39 +++++++++++++++++++++++++++------------
>   block/blk-mq-tag.h |  4 ++++
>   2 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 586c9d6e904a..2e43b827c96d 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -255,6 +255,7 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
>   struct bt_tags_iter_data {
>   	struct blk_mq_tags *tags;
>   	busy_tag_iter_fn *fn;
> +	busy_rq_iter_fn *busy_rq_fn;
>   	void *data;
>   	bool reserved;
>   };
> @@ -274,7 +275,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	 * test and set the bit before assining ->rqs[].
>   	 */
>   	rq = tags->rqs[bitnr];
> -	if (rq && blk_mq_request_started(rq))
> +	if (rq && iter_data->busy_rq_fn(rq, iter_data->data, reserved))
>   		return iter_data->fn(rq, iter_data->data, reserved);
>   
>   	return true;
> @@ -294,11 +295,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>    *		bitmap_tags member of struct blk_mq_tags.
>    */
>   static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
> -			     busy_tag_iter_fn *fn, void *data, bool reserved)
> +			     busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> +			     void *data, bool reserved)
>   {
>   	struct bt_tags_iter_data iter_data = {
>   		.tags = tags,
>   		.fn = fn,
> +		.busy_rq_fn = busy_rq_fn,
>   		.data = data,
>   		.reserved = reserved,
>   	};
> @@ -310,19 +313,30 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
>   /**
>    * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
>    * @tags:	Tag map to iterate over.
> - * @fn:		Pointer to the function that will be called for each started
> - *		request. @fn will be called as follows: @fn(rq, @priv,
> - *		reserved) where rq is a pointer to a request. 'reserved'
> - *		indicates whether or not @rq is a reserved request. Return
> - *		true to continue iterating tags, false to stop.
> + * @fn:		Pointer to the function that will be called for each request
> + * 		when .busy_rq_fn(rq) returns true. @fn will be called as
> + * 		follows: @fn(rq, @priv, reserved) where rq is a pointer to a
> + * 		request. 'reserved' indicates whether or not @rq is a reserved
> + * 		request. Return true to continue iterating tags, false to stop.
> + * @busy_rq_fn: Pointer to the function that will be called for each request,
> + * 		@busy_rq_fn's type is same with @fn. Only when @busy_rq_fn(rq,
> + * 		@priv, reserved) returns true, @fn will be called on this rq.
>    * @priv:	Will be passed as second argument to @fn.
>    */
> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> -		busy_tag_iter_fn *fn, void *priv)
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> +		void *priv)
>   {
>   	if (tags->nr_reserved_tags)
> -		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
> -	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
> +		bt_tags_for_each(tags, &tags->breserved_tags, fn, busy_rq_fn,
> +				priv, true);
> +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, busy_rq_fn, priv, false);
> +}
> +
> +static bool blk_mq_default_busy_rq(struct request *rq, void *data,
> +		bool reserved)
> +{
> +	return blk_mq_request_started(rq);
>   }
>   
>   /**
> @@ -342,7 +356,8 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>   
>   	for (i = 0; i < tagset->nr_hw_queues; i++) {
>   		if (tagset->tags && tagset->tags[i])
> -			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
> +			blk_mq_all_tag_busy_iter(tagset->tags[i], fn,
> +					blk_mq_default_busy_rq, priv);
>   	}
>   }
>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 2b8321efb682..fdf095d513e5 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -21,6 +21,7 @@ struct blk_mq_tags {
>   	struct list_head page_list;
>   };
>   
> +typedef bool (busy_rq_iter_fn)(struct request *, void *, bool);
>   
>   extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
>   extern void blk_mq_free_tags(struct blk_mq_tags *tags);
> @@ -34,6 +35,9 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>   extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
>   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>   		void *priv);
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> +		void *priv);
>   
>   static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>   						 struct blk_mq_hw_ctx *hctx)
> 
I do worry about the performance impact of this new filter function.
 From my understanding, the _busy_iter() functions are supposed to be 
efficient, such that they can be used as an alternative to having a 
global atomic counter.
(cf the replacement of the global host_busy counter).

But if we're adding ever more functionality to the iterator itself 
there's a good chance we'll kill the performance rendering this 
assumption invalid.

Have you measured the performance impact of this?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
