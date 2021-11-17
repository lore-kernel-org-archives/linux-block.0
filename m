Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7567BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 23:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5967961B71
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 23:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhKRACg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241741AbhKRAC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 19:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637193567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LNYhpChmuB0fhRg5Bf/4TJxJAHL7rQEEjYhrD7rYdvM=;
        b=Og3HA7Ct9h2rdtLDmBlWAxRa95+L2B1LDG+zON2GzAOd28bwFil9TNJ0T6m5q77poS2JNk
        qKurbfoK1wrvc3Gy/vZO2nwehxjkhcZht5XK5SZdeAmAfQDgUPJ2op8hKvgzzSN06ZAOVS
        5xq2YwMK55MGbOu+lW6tK3BZIiyt5lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-6l5rFhBBOpi5TN7O6S9qrw-1; Wed, 17 Nov 2021 18:59:23 -0500
X-MC-Unique: 6l5rFhBBOpi5TN7O6S9qrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE16F1054FA6;
        Wed, 17 Nov 2021 23:59:20 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 467AC19E7E;
        Wed, 17 Nov 2021 23:59:16 +0000 (UTC)
Date:   Thu, 18 Nov 2021 07:59:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <YZWXUFuCePvvexxi@T590>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk>
 <YZS7XPMlvMEP5yfp@T590>
 <942f12f8-a334-f90b-481b-ff3b36fb1102@kernel.dk>
 <20211117204814.GB3295649@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117204814.GB3295649@dhcp-10-100-145-180.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 12:48:14PM -0800, Keith Busch wrote:
> On Wed, Nov 17, 2021 at 08:43:02AM -0700, Jens Axboe wrote:
> > On 11/17/21 1:20 AM, Ming Lei wrote:
> > > On Tue, Nov 16, 2021 at 08:38:04PM -0700, Jens Axboe wrote:
> > >> If we have a list of requests in our plug list, send it to the driver in
> > >> one go, if possible. The driver must set mq_ops->queue_rqs() to support
> > >> this, if not the usual one-by-one path is used.
> > >>
> > >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >> ---
> > >>  block/blk-mq.c         | 17 +++++++++++++++++
> > >>  include/linux/blk-mq.h |  8 ++++++++
> > >>  2 files changed, 25 insertions(+)
> > >>
> > >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> > >> index 9b4e79e2ac1e..005715206b16 100644
> > >> --- a/block/blk-mq.c
> > >> +++ b/block/blk-mq.c
> > >> @@ -2208,6 +2208,19 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
> > >>  	int queued = 0;
> > >>  	int errors = 0;
> > >>  
> > >> +	/*
> > >> +	 * Peek first request and see if we have a ->queue_rqs() hook. If we
> > >> +	 * do, we can dispatch the whole plug list in one go. We already know
> > >> +	 * at this point that all requests belong to the same queue, caller
> > >> +	 * must ensure that's the case.
> > >> +	 */
> > >> +	rq = rq_list_peek(&plug->mq_list);
> > >> +	if (rq->q->mq_ops->queue_rqs) {
> > >> +		rq->q->mq_ops->queue_rqs(&plug->mq_list);
> > >> +		if (rq_list_empty(plug->mq_list))
> > >> +			return;
> > >> +	}
> > >> +
> > > 
> > > Then BLK_MQ_F_TAG_QUEUE_SHARED isn't handled as before for multiple NVMe
> > > NS.
> > 
> > Can you expand? If we have multiple namespaces in the plug list, we have
> > multiple queues. There's no direct issue of the list if that's the case.
> > Or maybe I'm missing what you mean here?
> 
> If the plug list only has requests for one namespace, I think Ming is
> referring to the special accounting for BLK_MQ_F_TAG_QUEUE_SHARED in
> __blk_mq_get_driver_tag() that normally gets called before dispatching
> to the driver, but isn't getting called when using .queue_rqs().

Yeah, that is it. This is one normal case, each task runs I/O on
different namespace, but all NSs share/contend the single host tags,
BLK_MQ_F_TAG_QUEUE_SHARED is supposed to provide fair allocation among
all these NSs.


thanks, 
Ming

