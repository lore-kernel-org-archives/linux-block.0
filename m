Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848CFC28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6188720722
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjBvgKgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEIDwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:52:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbgEIDwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 23:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588996355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pf6i6X4/eu8UJGgXrpS9lLpC6cdrzW1FPXw7u04Q79M=;
        b=FjBvgKgsad9LgMR0MWkbFGasZJ4hQNQi/YS2AmPUv9Ecy6B8TgctlpK5lTQ1QkquF0quA6
        AycBwwFweSyT/y1t23AYt+LAiPctwOyPgwqfz5EvujlxmpL6IQZPhPb0taxym6s/oK/djF
        OmjVVuU1pSViGW/Zf34sCMtx6BPYB/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-yw4NQG1MP4m6V8S8six7Mg-1; Fri, 08 May 2020 23:52:33 -0400
X-MC-Unique: yw4NQG1MP4m6V8S8six7Mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A05800D24;
        Sat,  9 May 2020 03:52:32 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 211915D9CA;
        Sat,  9 May 2020 03:52:23 +0000 (UTC)
Date:   Sat, 9 May 2020 11:52:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 05/11] blk-mq: support rq filter callback when
 iterating rqs
Message-ID: <20200509035219.GE1392681@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-6-ming.lei@redhat.com>
 <8d7a14f8-b36c-4f5c-a4af-d5904d3e9ea1@acm.org>
 <51888b96-1e3b-9810-fb64-47a965b83711@acm.org>
 <20200509020522.GA1392681@T590>
 <a0d48ad1-a0f2-7b3a-37ac-0dfe7f1740a7@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d48ad1-a0f2-7b3a-37ac-0dfe7f1740a7@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 08:08:23PM -0700, Bart Van Assche wrote:
> On 2020-05-08 19:05, Ming Lei wrote:
> > Fine, then we can save one callback, how about the following way?
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 586c9d6e904a..5e9c743d887b 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -257,6 +257,7 @@ struct bt_tags_iter_data {
> >  	busy_tag_iter_fn *fn;
> >  	void *data;
> >  	bool reserved;
> > +	bool iterate_all;
> >  };
> >  
> >  static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> > @@ -274,8 +275,10 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >  	 * test and set the bit before assining ->rqs[].
> >  	 */
> >  	rq = tags->rqs[bitnr];
> > -	if (rq && blk_mq_request_started(rq))
> > -		return iter_data->fn(rq, iter_data->data, reserved);
> > +	if (rq) {
> > +		if (iter_data->iterate_all || blk_mq_request_started(rq))
> > +			return iter_data->fn(rq, iter_data->data, reserved);
> > +	}
> 
> How about combining the two if-statements above in the following single
> if-statement:
> 
> if (rq && (iter_data->iterate_all || blk_mq_request_started(rq)))
> 	...

OK.

> 
> > @@ -321,8 +326,30 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> >  		busy_tag_iter_fn *fn, void *priv)
> >  {
> >  	if (tags->nr_reserved_tags)
> > -		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
> > -	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
> > +		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
> > +				 false);
> > +	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, false);
> > +}
> 
> How about inserting comments like /*reserved=*/ and /*iterate_all=*/ in
> the bt_tags_for_each() call in front of "false" to make these calls
> easier to read?

I think it isn't necessary, given both two are self-documented from
the name of bt_tags_for_each's parameters.

> 
> > +/**
> > + * blk_mq_all_tag_iter - iterate over all requests in a tag map
> > + * @tags:	Tag map to iterate over.
> > + * @fn:		Pointer to the function that will be called for each
> > + *		request. @fn will be called as follows: @fn(rq, @priv,
> > + *		reserved) where rq is a pointer to a request. 'reserved'
> > + *		indicates whether or not @rq is a reserved request. Return
> > + *		true to continue iterating tags, false to stop.
> > + * @priv:	Will be passed as second argument to @fn.
> > + *
> > + * It is the caller's responsility to check rq's state in @fn.
>                          ^^^^^^^^^^^^
>                          responsibility?

OK.

 
Thanks,
Ming

