Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EFDC433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 13:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiC2NuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiC2NuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 09:50:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D5DF62
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 06:48:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bx5so17483955pjb.3
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mXJzlYVD+DjRpLpJGhDOsMh/Zm7JLhIX2UQq7rw4yPE=;
        b=eqnECCcd+u9x8y9FzmZJ8pwNzk0Dw/CMSrWV87z+douBIJPnoQQhWmANKoW73csgzW
         +XH7kBLWddafq/9R/1eUGNzpE13I50PPr/VVQpHJfMAsLU8yLH+6RkkqsbF1fa6KS5pp
         IdVvUeEOm3YVPomgJh/bzpyW1cd0MGo8Fucu3RjR/pLUhVdNwsp3l+vjOvu2PCK2zTzL
         MMvkF1afnUal9d85xg4yl8jwWZWhljVywakg8FZggNwBkKFtvRmdEa8jJvmRbLpZob0i
         lxmy39nQ2O51j3QVed8MwawJpDJ/XJ3xvmPPPSRe6I3nzdS6h7bcyj3qO1CRtTuCaSHw
         g4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mXJzlYVD+DjRpLpJGhDOsMh/Zm7JLhIX2UQq7rw4yPE=;
        b=fBTwD8lVJhXFQp7yeV0PX1UOjY9UQ2cxIvuSSwsQDs3ndvDyl/5hKsoqyms7nHf0bQ
         5iM5yfNv2MhbSnADBYHQcAoY8wNSzzOisYd0aSNhQddrn38czGABnEQItHNw0kkjJKHL
         iW16mUreeQKSjA98ziuEF7nkuw6qUAoiMjq3pCRZSD3+kDjrLX4tGVMLzZ/E0rb3HQrz
         91mhS86ylatmoafjOzvva0wvuMJufmg7CAGDSciIoMGnXas9zVUZtdYuBZWv1BSfaLnd
         Q1yJAyY+5qC9E0dbN9mB0kEiSKZMmSpr1c/L08INEqMqTnpgVuzzlxLdBZaszl+Qr97n
         Uk2g==
X-Gm-Message-State: AOAM532ATLVoVyoCeAnuAeIs2QzEBMPZpmrC2pd921oj0rWsW15IwTPK
        dHjobikYzrJ4Masoh+zuaWtMelE6DN86KQ==
X-Google-Smtp-Source: ABdhPJzb9vb3N4M/AhAbUFwMLp8Nt874tOSGcAmrfKNTGmabDmT0KRKuC3Mh18ATB0qgNXzoAzbz9g==
X-Received: by 2002:a17:90b:4b89:b0:1c8:105a:2262 with SMTP id lr9-20020a17090b4b8900b001c8105a2262mr4663568pjb.225.1648561702321;
        Tue, 29 Mar 2022 06:48:22 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id gk13-20020a17090b118d00b001c6b2472576sm3101842pjb.19.2022.03.29.06.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:48:21 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:48:16 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkMOIBhpODZNLhnZ@localhost.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-3-suwan.kim027@gmail.com>
 <YkG1HeQ8qu11KFnF@stefanha-x1.localdomain>
 <YkHZSV+USBSRPuTv@localhost.localdomain>
 <YkLHKXukyZd27ADE@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkLHKXukyZd27ADE@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 29, 2022 at 09:45:29AM +0100, Stefan Hajnoczi wrote:
> On Tue, Mar 29, 2022 at 12:50:33AM +0900, Suwan Kim wrote:
> > On Mon, Mar 28, 2022 at 02:16:13PM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Mar 24, 2022 at 11:04:50PM +0900, Suwan Kim wrote:
> > > > +static void virtio_queue_rqs(struct request **rqlist)
> > > > +{
> > > > +	struct request *req, *next, *prev = NULL;
> > > > +	struct request *requeue_list = NULL;
> > > > +
> > > > +	rq_list_for_each_safe(rqlist, req, next) {
> > > > +		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> > > > +		unsigned long flags;
> > > > +		bool kick;
> > > > +
> > > > +		if (!virtblk_prep_rq_batch(vq, req)) {
> > > > +			rq_list_move(rqlist, &requeue_list, req, prev);
> > > > +			req = prev;
> > > > +
> > > > +			if (!req)
> > > > +				continue;
> > > > +		}
> > > > +
> > > > +		if (!next || req->mq_hctx != next->mq_hctx) {
> > > > +			spin_lock_irqsave(&vq->lock, flags);
> > > 
> > > Did you try calling virtblk_add_req() here to avoid acquiring and
> > > releasing the lock multiple times? In other words, do virtblk_prep_rq()
> > > but wait until we get here to do virtblk_add_req().
> > > 
> > > I don't know if it has any measurable effect on performance or maybe the
> > > code would become too complex, but I noticed that we're not fully
> > > exploiting batching.
> > 
> > I tried as you said. I called virtlblk_add_req() and added requests
> > of rqlist to virtqueue in this if statement with holding the lock
> > only once.
> > 
> > I attach the code at the end of this mail.
> > Please refer the code.
> > 
> > But I didn't see improvement. It showed slightly worse performance
> > than the current patch.
> 
> Okay, thanks for trying it!
> 
> > > > +			kick = virtqueue_kick_prepare(vq->vq);
> > > > +			spin_unlock_irqrestore(&vq->lock, flags);
> > > > +			if (kick)
> > > > +				virtqueue_notify(vq->vq);
> > > > +
> > > > +			req->rq_next = NULL;
> > 
> > Did you ask this part?
> > 
> > > > +			*rqlist = next;
> > > > +			prev = NULL;
> > > > +		} else
> > > > +			prev = req;
> > > 
> > > What guarantees that req is still alive after we called
> > > virtblk_add_req()? The device may have seen it and completed it already
> > > by the time we get here.
> > 
> > Isn't request completed after the kick?
> > 
> > If you asked about "req->rq_next = NULL",
> > I think it should be placed before
> > "kick = virtqueue_kick_prepare(vq->vq);"
> > 
> > -----------
> > 	req->rq_next = NULL;
> > 	kick = virtqueue_kick_prepare(vq->vq);
> > 	spin_unlock_irqrestore(&vq->lock, flags);
> > 	if (kick)
> > 		virtqueue_notify(vq->vq);
> > -----------
> 
> No, virtqueue_add_sgs() exposes vring descriptors to the device. The
> device may process immediately. In other words, VIRTIO devices may poll
> the vring instead of waiting for virtqueue_notify(). There is no
> guarantee that the request is alive until virtqueue_notify() is called.
> 
> The code has to handle the case where the request is completed during
> virtqueue_add_sgs().

Thanks for the explanation.

We should not use req again after virtblk_add_req().
I understand...

Then, as you commented in previous mail, is it ok that we do
virtblk_add_req() in "if (!next || req->mq_hctx != next->mq_hctx)"
statement to avoid use req again after virtblk_add_req() as below code?

In this code, It adds reqs to virtqueue in batch just before
virtqueue_notify(), and it doesn't use req again after calling
virtblk_add_req().

If it is fine, I will try it again.
This code is slightly different from the code I sent in previous mail.

---
static void virtio_queue_rqs(struct request **rqlist)
...
	rq_list_for_each_safe(rqlist, req, next) {
...
		if (!next || req->mq_hctx != next->mq_hctx) {
			// Cut the list at current req
			req->rq_next = NULL;
			// Add req list to virtqueue in batch with holding lock once
			kick = virtblk_add_req_batch(vq, rqlist, &requeue_list);
			if (kick)
				virtqueue_notify(vq->vq);

			// setup new req list. Don't use previous req again.
			*rqlist = next;
			prev = NULL;
...
---

Regards,
Suwan Kim
