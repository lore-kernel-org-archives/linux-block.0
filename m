Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647EAC38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CA0218AC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSQ72+nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgEICFn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 22:05:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45890 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728158AbgEICFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 22:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588989941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FelGRuv5Frlg3E3AJBKqFDXYnuGaIALB63acDeC1q2E=;
        b=dSQ72+nfAdNnylNJNPBKmoaUrJw2yZleP1uf9qfpnDsuLVfweuanAMiOW7PTeAYbrcWa7g
        Gc39FuY+XH+JWYrIcJV/T2NmXVZ56JrY5FWt0IMX0zqDzgkBDN3VsOFk+CBTuWHmTRzwN4
        aWBE+2njbxQUfYZe9Qd8BcLN8+x+OQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-mq0W2nIjMxSdbm4trTC7sw-1; Fri, 08 May 2020 22:05:37 -0400
X-MC-Unique: mq0W2nIjMxSdbm4trTC7sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05DF8464;
        Sat,  9 May 2020 02:05:36 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B381C6AD09;
        Sat,  9 May 2020 02:05:27 +0000 (UTC)
Date:   Sat, 9 May 2020 10:05:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 05/11] blk-mq: support rq filter callback when
 iterating rqs
Message-ID: <20200509020522.GA1392681@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-6-ming.lei@redhat.com>
 <8d7a14f8-b36c-4f5c-a4af-d5904d3e9ea1@acm.org>
 <51888b96-1e3b-9810-fb64-47a965b83711@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51888b96-1e3b-9810-fb64-47a965b83711@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 05:18:56PM -0700, Bart Van Assche wrote:
> On 2020-05-08 16:32, Bart Van Assche wrote:
> > On 2020-05-04 19:09, Ming Lei wrote:
> >> @@ -310,19 +313,30 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
> >>  /**
> >>   * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
> >>   * @tags:	Tag map to iterate over.
> >> - * @fn:		Pointer to the function that will be called for each started
> >> - *		request. @fn will be called as follows: @fn(rq, @priv,
> >> - *		reserved) where rq is a pointer to a request. 'reserved'
> >> - *		indicates whether or not @rq is a reserved request. Return
> >> - *		true to continue iterating tags, false to stop.
> >> + * @fn:		Pointer to the function that will be called for each request
> >> + * 		when .busy_rq_fn(rq) returns true. @fn will be called as
> >> + * 		follows: @fn(rq, @priv, reserved) where rq is a pointer to a
> >> + * 		request. 'reserved' indicates whether or not @rq is a reserved
> >> + * 		request. Return true to continue iterating tags, false to stop.
> >> + * @busy_rq_fn: Pointer to the function that will be called for each request,
> >> + * 		@busy_rq_fn's type is same with @fn. Only when @busy_rq_fn(rq,
> >> + * 		@priv, reserved) returns true, @fn will be called on this rq.
> >>   * @priv:	Will be passed as second argument to @fn.
> >>   */
> >> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> >> -		busy_tag_iter_fn *fn, void *priv)
> >> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> >> +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> >> +		void *priv)
> >>  {
> > 
> > The name 'busy_rq_fn' is not ideal because it is named after one
> > specific use case, namely checking whether or not a request is busy (has
> > already been started). How about using the name 'pred_fn' ('pred' from
> > predicate because it controls whether the other function is called)?
> > Since only the context that passes 'fn' can know what data structure
> > 'priv' points to and since 'busy_rq_fn' is passed from another context,
> > can 'busy_rq_fn' even know what data 'priv' points at? Has it been
> > considered not to pass the 'priv' argument to 'busy_rq_fn'?
> 
> Thinking further about this, another possible approach is not to modify
> blk_mq_all_tag_busy_iter() at all and to introduce a new function that
> iterates over all requests instead of only over busy requests. I think
> that approach will result in easier to read code than patch 5/11 because
> each of these request iteration functions will only accept a single
> callback function pointer. Additionally, that approach will make the
> following function superfluous (from patch 7/11):
> 
> +static bool blk_mq_inflight_rq(struct request *rq, void *data,
> +			       bool reserved)
> +{
> +	return rq->tag >= 0;
> +}

Fine, then we can save one callback, how about the following way?

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..5e9c743d887b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -257,6 +257,7 @@ struct bt_tags_iter_data {
 	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
+	bool iterate_all;
 };
 
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
@@ -274,8 +275,10 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
-		return iter_data->fn(rq, iter_data->data, reserved);
+	if (rq) {
+		if (iter_data->iterate_all || blk_mq_request_started(rq))
+			return iter_data->fn(rq, iter_data->data, reserved);
+	}
 
 	return true;
 }
@@ -294,13 +297,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
+			     busy_tag_iter_fn *fn, void *data, bool reserved,
+			     bool iterate_all)
 {
 	struct bt_tags_iter_data iter_data = {
 		.tags = tags,
 		.fn = fn,
 		.data = data,
 		.reserved = reserved,
+		.iterate_all = iterate_all,
 	};
 
 	if (tags->rqs)
@@ -321,8 +326,30 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
+				 false);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, false);
+}
+
+/**
+ * blk_mq_all_tag_iter - iterate over all requests in a tag map
+ * @tags:	Tag map to iterate over.
+ * @fn:		Pointer to the function that will be called for each
+ *		request. @fn will be called as follows: @fn(rq, @priv,
+ *		reserved) where rq is a pointer to a request. 'reserved'
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop.
+ * @priv:	Will be passed as second argument to @fn.
+ *
+ * It is the caller's responsility to check rq's state in @fn.
+ */
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv)
+{
+	if (tags->nr_reserved_tags)
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
+				 true);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, true);
 }
 
 /**
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 2b8321efb682..d19546e8246b 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -34,6 +34,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)


thanks,
Ming

