Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A620C35280
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 01:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A7A2085B
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 01:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ2diI/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEHB76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 21:59:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49717 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgEHB76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 21:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588903197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fEl+LhRb2ZhtYY1XNVMWuuougQq7+F5WGxBMr/NiBIA=;
        b=KZ2diI/+l6yZSITzQIAGIR1GP97iOhAd2swa1BbHUAAP1MCSTI4U204lI9RdXDQs+Q3Lbd
        Qt2bgIgbpcmUgBGTJOXymsZJPmV7dWlSbjzUGpq/CB1TAa30UULT+r/kNTpQMNhbINNymJ
        mfTkuW//Rz6CJgvNZUxcvuvZK2qfpQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-qv5sl72pMa6AZerfsLX6PA-1; Thu, 07 May 2020 21:59:54 -0400
X-MC-Unique: qv5sl72pMa6AZerfsLX6PA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94E891005510;
        Fri,  8 May 2020 01:59:53 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3EC21FDE1;
        Fri,  8 May 2020 01:59:47 +0000 (UTC)
Date:   Fri, 8 May 2020 09:59:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 4/4] block: don't hold part0's refcount in IO path
Message-ID: <20200508015942.GC1360332@T590>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
 <20200507085239.1354854-5-ming.lei@redhat.com>
 <20200507142050.GD11551@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507142050.GD11551@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 07:20:50AM -0700, Christoph Hellwig wrote:
> On Thu, May 07, 2020 at 04:52:39PM +0800, Ming Lei wrote:
> > gendisk can't be gone when there is IO activity, so not hold
> > part0's refcount in IO path.
> > 
> > Cc: Yufen Yu <yuyufen@huawei.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Hou Tao <houtao1@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-core.c | 3 ++-
> >  block/genhd.c    | 1 -
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 826a8980997d..56cc61354671 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1343,7 +1343,8 @@ void blk_account_io_done(struct request *req, u64 now)
> >  		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
> >  		part_dec_in_flight(req->q, part, rq_data_dir(req));
> >  
> > -		hd_struct_put(part);
> > +		if (part->partno)
> > +			hd_struct_put(part);
> >  		part_stat_unlock();
> 
> Doesn't blk_account_io_merge needs the check as well?

You are right, blk_account_io_merge needs it too.

> 
> Maybe it should go into hd_struct_put and the other helpers to be
> centralized?

I think that is doable.

Thanks,
Ming

