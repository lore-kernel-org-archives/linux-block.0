Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F863C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 14:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiGOOaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOOaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 10:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C73D011A08
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657895418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MczqJjZ66guoWM3oSHGaYBtwU1i+YsELM1y0lzRGkZg=;
        b=iqNTADLD3iT40mYL/fmvLjAJ+61WKuoQrfDuJihJbV8MzwLHWFae2dIdVG8zhjLFs9rIYR
        GUvFLiKjyShnz00VGxk2KAZc3fnDfOIDdFRtw+Wcbi99mZQ+droosifvWxr0KMrDP/i5B2
        ygwLpbuEk/ksLhEkGQ0F7ksXdx6zE2I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-f4WUeekEM8GfyvaFsFLxVw-1; Fri, 15 Jul 2022 10:30:12 -0400
X-MC-Unique: f4WUeekEM8GfyvaFsFLxVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01C7A3C025BA;
        Fri, 15 Jul 2022 14:30:12 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 618FB1121315;
        Fri, 15 Jul 2022 14:30:08 +0000 (UTC)
Date:   Fri, 15 Jul 2022 22:30:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Vincent Fu <vincent.fu@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: cleanup null_init_tag_set
Message-ID: <YtF57BoFppNm19wf@T590>
References: <CGME20220715031940uscas1p27e74dec9ebf60d454441271aabe147de@uscas1p2.samsung.com>
 <20220715031916.151469-1-ming.lei@redhat.com>
 <c109ba5ec91c4fffb1ae834d50076dda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c109ba5ec91c4fffb1ae834d50076dda@samsung.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 15, 2022 at 02:11:21PM +0000, Vincent Fu wrote:
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei@redhat.com]
> > Sent: Thursday, July 14, 2022 11:19 PM
> > To: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-block@vger.kernel.org; Ming Lei <ming.lei@redhat.com>;
> > Vincent Fu <vincent.fu@samsung.com>
> > Subject: [PATCH] null_blk: cleanup null_init_tag_set
> > 
> > The passed 'nullb' can be NULL, so cause null ptr reference.
> > 
> > Fix the issue, meantime cleanup null_init_tag_set for avoiding to add
> > similar issue in future.
> > 
> > Cc: Vincent Fu <vincent.fu@samsung.com>
> > Fixes: 37ae152c7a0d ("null_blk: add configfs variables for 2 options")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/null_blk/main.c | 49 ++++++++++++++++++++++-----------
> > --
> >  1 file changed, 31 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> > index c955a07dba2d..a08856b121b3 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -1898,31 +1898,44 @@ static int null_gendisk_register(struct nullb
> > *nullb)
> > 
> >  static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set
> > *set)
> >  {
> > +	unsigned int flags = BLK_MQ_F_SHOULD_MERGE;
> > +	int hw_queues, numa_node;
> > +	unsigned int queue_depth;
> >  	int poll_queues;
> > 
> > +	if (nullb) {
> > +		hw_queues = nullb->dev->submit_queues;
> > +		poll_queues = nullb->dev->poll_queues;
> > +		queue_depth = nullb->dev->hw_queue_depth;
> > +		numa_node = nullb->dev->home_node;
> > +		if (nullb->dev->no_sched)
> > +			flags |= BLK_MQ_F_NO_SCHED;
> > +		if (nullb->dev->shared_tag_bitmap)
> > +			flags |= BLK_MQ_F_TAG_HCTX_SHARED;
> > +		if (nullb->dev->blocking)
> > +			flags |= BLK_MQ_F_BLOCKING;
> > +	} else {
> > +		hw_queues = g_submit_queues;
> > +		poll_queues = g_poll_queues;
> > +		queue_depth = g_hw_queue_depth;
> > +		numa_node = g_home_node;
> > +		if (g_blocking)
> > +			flags |= BLK_MQ_F_BLOCKING;
> > +	}
> > +
> 
> Ming, thank you for fixing the mess I created.
> 
> I believe that even when 'nullb' is NULL we should still set the
> BLK_MQ_F_NO_SCHED and BLK_MQ_F_TAG_HCTX_SHARED flags based on the values of
> g_no_sched and g_shared_tag_bitmap, respectively. Is that not right?

Yeah, it is right, and I have covered it in V2.

Thanks,
Ming

