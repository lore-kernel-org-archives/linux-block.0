Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6FDC433E1
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 00:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB16820738
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 00:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIwRppyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHSAUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbgHSAUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 20:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597796446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gs2NvF8gnx1vHyD5HoIk+F9hdBlMxJaYiFyBCzuPyas=;
        b=HIwRppyc7RrAlUnodZ/Z3CEXxR9M2XL6k+96nbu8um2C8G+FaQO4tq6DSifCjrp6Yu8+W1
        PYd2RHUNw8BWsVfLX/CSbqLiq1vKo7EmTlmt5f3ar7iNHLQvN++BxTQ5lW9EjPDD6eyAaD
        5sv84ohB5h2/GsoToHU4fQtMjv7m42o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-VCVnQbClMoKN_E8l7s4IHg-1; Tue, 18 Aug 2020 20:20:42 -0400
X-MC-Unique: VCVnQbClMoKN_E8l7s4IHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB3391084C82;
        Wed, 19 Aug 2020 00:20:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C751110021AA;
        Wed, 19 Aug 2020 00:20:36 +0000 (UTC)
Date:   Tue, 18 Aug 2020 20:20:35 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, dm-devel@redhat.com
Subject: Re: [PATCH RESEND] blk-mq: insert request not through ->queue_rq
 into sw/scheduler queue
Message-ID: <20200819002035.GA9292@redhat.com>
References: <20200818090728.2696802-1-ming.lei@redhat.com>
 <92162ee6-0fa0-dafd-69b1-af285ee61044@kernel.dk>
 <20200818152022.GB6842@redhat.com>
 <20200818235220.GA2712797@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818235220.GA2712797@T590>
eFrom:  Mike Snitzer <snitzer@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18 2020 at  7:52pm -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Tue, Aug 18, 2020 at 11:20:22AM -0400, Mike Snitzer wrote:
> > On Tue, Aug 18 2020 at 10:50am -0400,
> > Jens Axboe <axboe@kernel.dk> wrote:
> > 
> > > On 8/18/20 2:07 AM, Ming Lei wrote:
> > > > c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list") supposed
> > > > to add request which has been through ->queue_rq() to the hw queue dispatch
> > > > list, however it adds request running out of budget or driver tag to hw queue
> > > > too. This way basically bypasses request merge, and causes too many request
> > > > dispatched to LLD, and system% is unnecessary increased.
> > > > 
> > > > Fixes this issue by adding request not through ->queue_rq into sw/scheduler
> > > > queue, and this way is safe because no ->queue_rq is called on this request
> > > > yet.
> > > > 
> > > > High %system can be observed on Azure storvsc device, and even soft lock
> > > > is observed. This patch reduces %system during heavy sequential IO,
> > > > meantime decreases soft lockup risk.
> > > 
> > > Applied, thanks Ming.
> > 
> > Hmm, strikes me as strange that this is occurring given the direct
> > insertion into blk-mq queue (bypassing scheduler) is meant to avoid 2
> > layers of IO merging when dm-mulipath is stacked on blk-mq path(s).  The
> > dm-mpath IO scheduler does all merging and underlying paths' blk-mq
> > request_queues are meant to just dispatch the top-level's requests.
> > 
> > So this change concerns me.  Feels like this design has broken down.
> > 
> 
> 'bypass_insert' is 'true' when blk_insert_cloned_request() is
> called from device mapper code, so this patch doesn't affect dm.

Great.
 
> > Could be that some other entry point was added for the
> > __blk_mq_try_issue_directly() code?  And it needs to be untangled away
> > from the dm-multipath use-case?
> 
> __blk_mq_try_issue_directly() can be called from blk-mq directly, that
> is the case this patch is addressing, if one request can't be queued to
> LLD because of running out of budget or driver tag, it should be added to
> scheduler queue for improving io merge, meantime we can avoid too many
> requests dispatched to hardware.

I see, so if retry is needed best to attempt merge again.

Thanks for the explanation.

Mike

