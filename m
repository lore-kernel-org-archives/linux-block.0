Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D0CA0FE4
	for <linux-block@archiver.kernel.org>; Fri,  1 Sep 2023 01:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbjIAB5z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 21:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIAB5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 21:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F82A9C
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 18:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693533424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGTlLE4GbRfg92inaxAbNFTpkzSFszG9W5O+dVH7Flo=;
        b=f1VCz2U0gC4k2pPT05BmDLIR48RBmF19Wi5kw2hMyi0ZG7TwSscZwB4SM7spzDnqyYl93B
        E1lgkkKHBU04TdvxllRjMfiXsSqJSFN0SLncyBZESyKQ9xe6bzGhLvOKLK8mf0j3z52tqo
        XBUYN5uCqk1hfTgiGhsXft1IJjQPnsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-y3dyoyi-PBqN5jCZx9Ra6A-1; Thu, 31 Aug 2023 21:57:00 -0400
X-MC-Unique: y3dyoyi-PBqN5jCZx9Ra6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE93E803F3A;
        Fri,  1 Sep 2023 01:56:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 147AE2166B25;
        Fri,  1 Sep 2023 01:56:55 +0000 (UTC)
Date:   Fri, 1 Sep 2023 09:56:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
Message-ID: <ZPFE3+vOI/Wm7/3e@fedora>
References: <20230831074221.2309565-1-ming.lei@redhat.com>
 <9353345b-bf34-4ee9-a81f-3c58e7e0e68c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9353345b-bf34-4ee9-a81f-3c58e7e0e68c@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 31, 2023 at 11:59:42AM -0600, Jens Axboe wrote:
> On 8/31/23 1:42 AM, Ming Lei wrote:
> > @@ -3313,11 +3323,12 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
> >  	atomic_inc(&tctx->in_cancel);
> >  	do {
> >  		bool loop = false;
> > +		bool wq_cancelled;
> 
> Minor nit, but io_uring generally uses US spelling, so this should be
> wq_canceled.

OK.

> 
> >  
> >  		io_uring_drop_tctx_refs(current);
> >  		/* read completions before cancelations */
> >  		inflight = tctx_inflight(tctx, !cancel_all);
> > -		if (!inflight)
> > +		if (!inflight && !tctx->io_wq)
> >  			break;
> 
> Not sure I follow this one, is it just for checking of io_wq was ever
> setup? How could it not be?

Here if we have io_wq, all requests in io_wq have to be canceled no
matter if inflight is zero or not because tctx_inflight(tctx, true)
doesn't track FIXED_FILE IOs, but there still can be such IOs in io_wq.

> 
> > -		if (loop) {
> > +		if (!wq_cancelled || (inflight && loop)) {
> >  			cond_resched();
> >  			continue;
> >  		}
> 
> And this one is a bit puzzling to me too - if we didn't cancel anything
> but don't have anything inflight, why are we looping? Should it be
> something ala:
> 
> if (inflight && (!wq_cancelled || loop)) {

There can be FIXED_FILE IOs in io_wq even though inflight is zero.


Thanks,
Ming

