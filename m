Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A02EC433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 07:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEEF610FB
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 07:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhD0HHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235029AbhD0HHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 03:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619507223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ObfScVwh89WMM/pwCz0as4G2pFAPQ5MEqQjo/s2PLg=;
        b=F4VqS52GluQ9kfElJHTMAhnkZRKogEWkgsLzSQwUeLT8RuFHJxEXhCW7FqUhT1lyDKES62
        WfgMWqTEIp6loHFpl5pcVXw3IapOTTuWOHHoHTHHsKvK1bSkQP8Vfnos40A18DWyCn7amC
        fUzfuMOGC/0BZ7qizLeanCBJ4e10fDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-QO3ZveAGORq7Sf9_79JnBA-1; Tue, 27 Apr 2021 03:07:01 -0400
X-MC-Unique: QO3ZveAGORq7Sf9_79JnBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84BDC1A8A68;
        Tue, 27 Apr 2021 07:06:59 +0000 (UTC)
Received: from T590 (ovpn-13-248.pek2.redhat.com [10.72.13.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08F0960CC9;
        Tue, 27 Apr 2021 07:06:44 +0000 (UTC)
Date:   Tue, 27 Apr 2021 15:06:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V2 2/3] blk-mq: complete request locally if the
 completion is from tagset iterator
Message-ID: <YIe4CzfUDX4yCCNO@T590>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
 <20210427014540.2747282-3-ming.lei@redhat.com>
 <c122e2bc-2e03-3890-bc7a-be1470bee1d5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c122e2bc-2e03-3890-bc7a-be1470bee1d5@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 07:30:51PM -0700, Bart Van Assche wrote:
> On 4/26/21 6:45 PM, Ming Lei wrote:
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 100fa44d52a6..773aea4db90c 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -284,8 +284,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >  	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
> >  	    !blk_mq_request_started(rq))
> >  		ret = true;
> > -	else
> > +	else {
> > +		rq->rq_flags |= RQF_ITERATING;
> >  		ret = iter_data->fn(rq, iter_data->data, reserved);
> > +		rq->rq_flags &= ~RQF_ITERATING;
> > +	}
> >  	if (!iter_static_rqs)
> >  		blk_mq_put_rq_ref(rq);
> >  	return ret;
> 
> All existing rq->rq_flags modifications are serialized. The above change
> adds code that may change rq_flags concurrently with regular request
> processing. I think that counts as a race condition.

Good catch, but we still can change .rq_flags via atomic op, such as:

	do {
		old = rq->rq_flags;
		new = old | RQF_ITERATING;
	} while (cmpxchg(&rq->rq_flags, old, new) != old);

> Additionally, the
> RQF_ITERATING flag won't be set correctly in the (unlikely) case that
> two concurrent bt_tags_iter() calls examine the same request at the same
> time.

If the driver completes request from two concurrent bt_tags_iter(), there has
been big trouble of double completion, so I'd rather not to consider this case.


Thanks,
Ming

