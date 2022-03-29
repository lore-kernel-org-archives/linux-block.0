Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiC2P4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiC2P4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 11:56:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E633E02
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 08:55:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id jx9so17902252pjb.5
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cuhk1XdERu69A8XvjiWHEvjoeMu5OdiIwkUINeMnFcc=;
        b=WuSO8BgjKAhJz2zqNOvrPk0uO2c1MvY6Po8VGSLtL5ergv+o5ZbC4r+sA++cfMAOSs
         ZMDOjOhiBSjx1dcUIX8XW+Bo71UOxtKVx0Nr/75p80EEXPmFHPBTr05Mp8c7m+LP98Ti
         svm9D67jAgkCj7aBBPfCrVV3UmxT0EWggS/doZhynTR98ixY/4DNZz28lCOdnv0q9v3d
         p1bO36LPVU4VMlWlxQWLtiiVII7jFwCDW7gmXK1apQmwabiBXE+I9xA3w/8Yqb+JrUsy
         dIiQEovE3D/Skiyc+7BKnF5tuA7TTPD4wt+upGxVUu3zL71GIERDO53KY62tScj/8Ebj
         Mlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cuhk1XdERu69A8XvjiWHEvjoeMu5OdiIwkUINeMnFcc=;
        b=tbSMkjOyLIZhe0Xy2WRX0skZxHIZ5t/SpKL1If51iGT0INB1485Vkv6VFAAbHZTVLs
         LT+3kuleVz5sNZLR/+rovagW86MFOV8w9tqM9ZZ3ICjpTMTvuJ5Y/8UShtxWmB+F/6ZN
         VMR0GbYMty/OtG7r4yr3QgGMMFA4LFASbF3KGdL3nqSE2N5f6+O6ID3kSZC15oF8P9Li
         o4fvXLHAlRNaYZ6HIT+kfh8MHeyvm6LeRuSNYHyAzDvkkih7GeUhhJ9clYRBBEmVRaaA
         VRdOHJvsR6D9wdKQWMrt8DYrmwl/UUycLikFCUrWiQ/R+TSYuxb6z4/rRvWJp2AcmMLd
         atCw==
X-Gm-Message-State: AOAM532u9cHYIW4iuUBXOpRA2yo6b3uChp+iglYlrNbMcZs5P2bS+vkp
        zJJNR1j2NgaZWz5aq9Bk75Y=
X-Google-Smtp-Source: ABdhPJwf2sNAcxgsLmbO/21Z8HUN/SDQK/R/iNTLlQUw9JfvSCENtjkJWMDTVzSouQlwsO7a1L/oUw==
X-Received: by 2002:a17:902:e88e:b0:154:7562:176d with SMTP id w14-20020a170902e88e00b001547562176dmr30640930plg.13.1648569299518;
        Tue, 29 Mar 2022 08:54:59 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b004fb24adc4b8sm13922134pfu.159.2022.03.29.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:54:58 -0700 (PDT)
Date:   Wed, 30 Mar 2022 00:54:53 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkMrzdEYj4hq7QH8@localhost.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-3-suwan.kim027@gmail.com>
 <YkG1HeQ8qu11KFnF@stefanha-x1.localdomain>
 <YkHZSV+USBSRPuTv@localhost.localdomain>
 <YkLHKXukyZd27ADE@stefanha-x1.localdomain>
 <YkMOIBhpODZNLhnZ@localhost.localdomain>
 <YkMfWoA8gjH7fdGU@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkMfWoA8gjH7fdGU@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 29, 2022 at 04:01:46PM +0100, Stefan Hajnoczi wrote:
> On Tue, Mar 29, 2022 at 10:48:16PM +0900, Suwan Kim wrote:
> > On Tue, Mar 29, 2022 at 09:45:29AM +0100, Stefan Hajnoczi wrote:
> > > On Tue, Mar 29, 2022 at 12:50:33AM +0900, Suwan Kim wrote:
> > > > On Mon, Mar 28, 2022 at 02:16:13PM +0100, Stefan Hajnoczi wrote:
> > > > > On Thu, Mar 24, 2022 at 11:04:50PM +0900, Suwan Kim wrote:
> > > > > > +static void virtio_queue_rqs(struct request **rqlist)
> > > > > > +{
> > > > > > +	struct request *req, *next, *prev = NULL;
> > > > > > +	struct request *requeue_list = NULL;
> > > > > > +
> > > > > > +	rq_list_for_each_safe(rqlist, req, next) {
> > > > > > +		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> > > > > > +		unsigned long flags;
> > > > > > +		bool kick;
> > > > > > +
> > > > > > +		if (!virtblk_prep_rq_batch(vq, req)) {
> > > > > > +			rq_list_move(rqlist, &requeue_list, req, prev);
> > > > > > +			req = prev;
> > > > > > +
> > > > > > +			if (!req)
> > > > > > +				continue;
> > > > > > +		}
> > > > > > +
> > > > > > +		if (!next || req->mq_hctx != next->mq_hctx) {
> > > > > > +			spin_lock_irqsave(&vq->lock, flags);
> > > > > 
> > > > > Did you try calling virtblk_add_req() here to avoid acquiring and
> > > > > releasing the lock multiple times? In other words, do virtblk_prep_rq()
> > > > > but wait until we get here to do virtblk_add_req().
> > > > > 
> > > > > I don't know if it has any measurable effect on performance or maybe the
> > > > > code would become too complex, but I noticed that we're not fully
> > > > > exploiting batching.
> > > > 
> > > > I tried as you said. I called virtlblk_add_req() and added requests
> > > > of rqlist to virtqueue in this if statement with holding the lock
> > > > only once.
> > > > 
> > > > I attach the code at the end of this mail.
> > > > Please refer the code.
> > > > 
> > > > But I didn't see improvement. It showed slightly worse performance
> > > > than the current patch.
> > > 
> > > Okay, thanks for trying it!
> > > 
> > > > > > +			kick = virtqueue_kick_prepare(vq->vq);
> > > > > > +			spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > +			if (kick)
> > > > > > +				virtqueue_notify(vq->vq);
> > > > > > +
> > > > > > +			req->rq_next = NULL;
> > > > 
> > > > Did you ask this part?
> > > > 
> > > > > > +			*rqlist = next;
> > > > > > +			prev = NULL;
> > > > > > +		} else
> > > > > > +			prev = req;
> > > > > 
> > > > > What guarantees that req is still alive after we called
> > > > > virtblk_add_req()? The device may have seen it and completed it already
> > > > > by the time we get here.
> > > > 
> > > > Isn't request completed after the kick?
> > > > 
> > > > If you asked about "req->rq_next = NULL",
> > > > I think it should be placed before
> > > > "kick = virtqueue_kick_prepare(vq->vq);"
> > > > 
> > > > -----------
> > > > 	req->rq_next = NULL;
> > > > 	kick = virtqueue_kick_prepare(vq->vq);
> > > > 	spin_unlock_irqrestore(&vq->lock, flags);
> > > > 	if (kick)
> > > > 		virtqueue_notify(vq->vq);
> > > > -----------
> > > 
> > > No, virtqueue_add_sgs() exposes vring descriptors to the device. The
> > > device may process immediately. In other words, VIRTIO devices may poll
> > > the vring instead of waiting for virtqueue_notify(). There is no
> > > guarantee that the request is alive until virtqueue_notify() is called.
> > > 
> > > The code has to handle the case where the request is completed during
> > > virtqueue_add_sgs().
> > 
> > Thanks for the explanation.
> > 
> > We should not use req again after virtblk_add_req().
> > I understand...
> > 
> > Then, as you commented in previous mail, is it ok that we do
> > virtblk_add_req() in "if (!next || req->mq_hctx != next->mq_hctx)"
> > statement to avoid use req again after virtblk_add_req() as below code?
> > 
> > In this code, It adds reqs to virtqueue in batch just before
> > virtqueue_notify(), and it doesn't use req again after calling
> > virtblk_add_req().
> > 
> > If it is fine, I will try it again.
> > This code is slightly different from the code I sent in previous mail.
> > 
> > ---
> > static void virtio_queue_rqs(struct request **rqlist)
> > ...
> > 	rq_list_for_each_safe(rqlist, req, next) {
> > ...
> > 		if (!next || req->mq_hctx != next->mq_hctx) {
> > 			// Cut the list at current req
> > 			req->rq_next = NULL;
> > 			// Add req list to virtqueue in batch with holding lock once
> > 			kick = virtblk_add_req_batch(vq, rqlist, &requeue_list);
> > 			if (kick)
> > 				virtqueue_notify(vq->vq);
> > 
> > 			// setup new req list. Don't use previous req again.
> > 			*rqlist = next;
> > 			prev = NULL;
> > ...
> 
> Yes, that sounds good.
> 
> (I noticed struct request has a reference count so that might be a way
> to keep requests alive, if necessary, but I haven't investigated. See
> req_ref_put_and_test() though it's not used by block drivers and maybe
> virtio-blk shouldn't mess with it either.)

I also think that using ref count is not a good idea.
I will send the next version soon.

Regards,
Suwan Kim
