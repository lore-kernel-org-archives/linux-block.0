Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8771C2BA1A
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A905E20776
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoON/SAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDYDFa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:05:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726038AbgDYDF3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587783927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBGaQWaf4rVLYQ7CZoigruzmvFsG2Bf7QfE6bLhUoUI=;
        b=GoON/SAtjFJ/+fKpKbMX/90F/egdGTXk9rbI/tOzMOZUGu352W/CBQwm5zWev1XpL15iox
        qDK0qjHfrMcptA6kHKdUxOvot1Xb0JF7Ba/hYy/HVjobpnZ690XdvEcCa9+O9aK/t7ZejQ
        QQSZ6d+elJFN59Kb9K8JbFPndbHq5U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-4ykle-IdOWyqT7Fqf-R2tQ-1; Fri, 24 Apr 2020 23:04:45 -0400
X-MC-Unique: 4ykle-IdOWyqT7Fqf-R2tQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1BD245F;
        Sat, 25 Apr 2020 03:04:43 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5702F5C1D2;
        Sat, 25 Apr 2020 03:04:34 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:04:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 05/11] blk-mq: support rq filter callback when
 iterating rqs
Message-ID: <20200425030428.GB477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-6-ming.lei@redhat.com>
 <69c1f94f-1363-5c58-0168-3dc07fe91ea1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c1f94f-1363-5c58-0168-3dc07fe91ea1@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 03:17:48PM +0200, Hannes Reinecke wrote:
> On 4/24/20 12:23 PM, Ming Lei wrote:
> > Now request is thought as in-flight only when its state is updated as
> > MQ_RQ_IN_FLIGHT, which is done by dirver via blk_mq_start_request().
> > 
> 
> driver
> 
> > Actually from blk-mq's view, one rq can be thought as in-flight
> > after its tag is >= 0.
> > 
> Well, and that we should clarify to avoid any misunderstanding.
> To my understanding, 'in-flight' are request which are submitted to
> the LLD. IE we'll have a lifetime rule like
> 
> internal_tag >= tag > in-flight
> 
> If the existence of a 'tag' would be equivalent to 'in-flight' we could
> do away with all the convoluted code managing the MQ_RQ_IN_FLIGHT state,
> wouldn't we?

Yeah, I have been thinking about that.

> 
> > Passing one rq filter callback so that we can iterating requests very
> > flexiable.
> > 
> 
> flexible
> 
> > Meantime blk_mq_all_tag_busy_iter is defined as public, which will be
> > called from blk-mq internally.
> > 
> Maybe:
> 
> Implement blk_mq_all_tag_busy_iter() which accepts a 'busy_fn' argument
> to filter over which commands to iterate, and make the existing
> blk_mq_tag_busy_iter() a wrapper for the new function.

Fine.

> 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-tag.c | 39 +++++++++++++++++++++++++++------------
> >   block/blk-mq-tag.h |  4 ++++
> >   2 files changed, 31 insertions(+), 12 deletions(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 586c9d6e904a..2e43b827c96d 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -255,6 +255,7 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
> >   struct bt_tags_iter_data {
> >   	struct blk_mq_tags *tags;
> >   	busy_tag_iter_fn *fn;
> > +	busy_rq_iter_fn *busy_rq_fn;
> >   	void *data;
> >   	bool reserved;
> >   };
> > @@ -274,7 +275,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >   	 * test and set the bit before assining ->rqs[].
> >   	 */
> >   	rq = tags->rqs[bitnr];
> > -	if (rq && blk_mq_request_started(rq))
> > +	if (rq && iter_data->busy_rq_fn(rq, iter_data->data, reserved))
> >   		return iter_data->fn(rq, iter_data->data, reserved);
> >   	return true;
> > @@ -294,11 +295,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >    *		bitmap_tags member of struct blk_mq_tags.
> >    */
> >   static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
> > -			     busy_tag_iter_fn *fn, void *data, bool reserved)
> > +			     busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> > +			     void *data, bool reserved)
> >   {
> >   	struct bt_tags_iter_data iter_data = {
> >   		.tags = tags,
> >   		.fn = fn,
> > +		.busy_rq_fn = busy_rq_fn,
> >   		.data = data,
> >   		.reserved = reserved,
> >   	};
> > @@ -310,19 +313,30 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
> >   /**
> >    * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
> >    * @tags:	Tag map to iterate over.
> > - * @fn:		Pointer to the function that will be called for each started
> > - *		request. @fn will be called as follows: @fn(rq, @priv,
> > - *		reserved) where rq is a pointer to a request. 'reserved'
> > - *		indicates whether or not @rq is a reserved request. Return
> > - *		true to continue iterating tags, false to stop.
> > + * @fn:		Pointer to the function that will be called for each request
> > + * 		when .busy_rq_fn(rq) returns true. @fn will be called as
> > + * 		follows: @fn(rq, @priv, reserved) where rq is a pointer to a
> > + * 		request. 'reserved' indicates whether or not @rq is a reserved
> > + * 		request. Return true to continue iterating tags, false to stop.
> > + * @busy_rq_fn: Pointer to the function that will be called for each request,
> > + * 		@busy_rq_fn's type is same with @fn. Only when @busy_rq_fn(rq,
> > + * 		@priv, reserved) returns true, @fn will be called on this rq.
> >    * @priv:	Will be passed as second argument to @fn.
> >    */
> > -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> > -		busy_tag_iter_fn *fn, void *priv)
> > +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> > +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> > +		void *priv)
> >   {
> >   	if (tags->nr_reserved_tags)
> > -		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
> > -	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
> > +		bt_tags_for_each(tags, &tags->breserved_tags, fn, busy_rq_fn,
> > +				priv, true);
> > +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, busy_rq_fn, priv, false);
> > +}
> > +
> > +static bool blk_mq_default_busy_rq(struct request *rq, void *data,
> > +		bool reserved)
> > +{
> > +	return blk_mq_request_started(rq);
> >   }
> >   /**
> > @@ -342,7 +356,8 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
> >   	for (i = 0; i < tagset->nr_hw_queues; i++) {
> >   		if (tagset->tags && tagset->tags[i])
> > -			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
> > +			blk_mq_all_tag_busy_iter(tagset->tags[i], fn,
> > +					blk_mq_default_busy_rq, priv);
> >   	}
> >   }
> >   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> > diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> > index 2b8321efb682..fdf095d513e5 100644
> > --- a/block/blk-mq-tag.h
> > +++ b/block/blk-mq-tag.h
> > @@ -21,6 +21,7 @@ struct blk_mq_tags {
> >   	struct list_head page_list;
> >   };
> > +typedef bool (busy_rq_iter_fn)(struct request *, void *, bool);
> >   extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
> >   extern void blk_mq_free_tags(struct blk_mq_tags *tags);
> > @@ -34,6 +35,9 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
> >   extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
> >   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
> >   		void *priv);
> > +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> > +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> > +		void *priv);
> >   static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
> >   						 struct blk_mq_hw_ctx *hctx)
> > 
> I do worry about the performance impact of this new filter function.
> From my understanding, the _busy_iter() functions are supposed to be
> efficient, such that they can be used as an alternative to having a global

No, blk_mq_tagset_busy_iter() won't be called in fast IO path, usually
it is run in EH code path.

Also I don't see how big the performance impact can be given what the
patch is doing is just to add blk_mq_default_busy_rq() to replace the
check of blk_mq_request_started().

> atomic counter.
> (cf the replacement of the global host_busy counter).
> 
> But if we're adding ever more functionality to the iterator itself there's a
> good chance we'll kill the performance rendering this assumption invalid.
> 
> Have you measured the performance impact of this?

As I mentioned, we don't call such busy_iter() in fast path. Or do you
see such usage in fast path?


thanks,
Ming

