Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A0C433E3
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 01:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA95B20888
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 01:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhqmKkAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgE1Bqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 21:46:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34424 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbgE1BqQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 21:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590630375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gGnB1itj8DYWVfaK2K5KWLiaxzXiz3PBax5+J6dMRM=;
        b=VhqmKkALf4ce+cLi94ILxCwkPbcw3Kz/0AmCsmMXbX7s1jQSOuqxhYXz2d/Km9GsFpyP/o
        2MWMzsENr2PudgTYbe/8VsB6Ixd3kNj22asvT55ltmTQ2hV+t5kLsnumhtWm42BbkblcvZ
        Cb+TQawyO35RSUrz/oiBi4ATAU6v1rY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-xC1hC2nfPnWkUnXThA0Ppg-1; Wed, 27 May 2020 21:46:13 -0400
X-MC-Unique: xC1hC2nfPnWkUnXThA0Ppg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCC80460;
        Thu, 28 May 2020 01:46:11 +0000 (UTC)
Received: from T590 (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94E875C1B0;
        Thu, 28 May 2020 01:46:05 +0000 (UTC)
Date:   Thu, 28 May 2020 09:46:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200528014601.GC933147@T590>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
 <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 27, 2020 at 04:09:19PM -0700, Bart Van Assche wrote:
> On 2020-05-27 11:06, Christoph Hellwig wrote:
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -180,6 +180,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> >  	sbitmap_finish_wait(bt, ws, &wait);
> >  
> >  found_tag:
> > +	/*
> > +	 * Give up this allocation if the hctx is inactive.  The caller will
> > +	 * retry on an active hctx.
> > +	 */
> > +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
> > +		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
> > +		return -1;
> > +	}
> >  	return tag + tag_offset;
> >  }
> 
> The code that has been added in blk_mq_hctx_notify_offline() will only
> work correctly if blk_mq_get_tag() tests BLK_MQ_S_INACTIVE after the
> store instructions involved in the tag allocation happened. Does this
> mean that a memory barrier should be added in the above function before
> the test_bit() call?

Please see comment in blk_mq_hctx_notify_offline():

+       /*
+        * Prevent new request from being allocated on the current hctx.
+        *
+        * The smp_mb__after_atomic() Pairs with the implied barrier in
+        * test_and_set_bit_lock in sbitmap_get().  Ensures the inactive flag is
+        * seen once we return from the tag allocator.
+        */
+       set_bit(BLK_MQ_S_INACTIVE, &hctx->state);


Thanks, 
Ming

