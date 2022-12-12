Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44694C4332F
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 14:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiLLOn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiLLOn4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 09:43:56 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD6095A3
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 06:43:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 142so8340245pga.1
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 06:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuF1eqwBxskCeYrPt9wrS/ASCD/8dAon4WxokTRgu+o=;
        b=H9wLocN9flhRiHVEh8vDRQ508Hjpe9vurfzl5DHNrWDKLS7tNOAhYrAPILmLab/rhX
         OR4VaJTWPZjrjYKvsUcTmwW/46/vpS2MAfJVRZfiFXZHZdWzTUxgGkGTIWVnBdLDHHFg
         HFwa50eylXRnouktFn2Rm1hSvK9m7EswxPy1d7jU1wO5Z/ocw8uxLp6r3hh3lN4qk2gq
         uKkL2czZKgHLpfriHS5YDRJoAzN+y29MXRdc+159kLaj0jzMcTuW5uFG/TUvE+mlyV8+
         /5WScEuISR/WM3roxWR6wM3eyGLmIgJ42oovh4yD351jrgcgxik6l4zmvi8IHXluTpGK
         lQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuF1eqwBxskCeYrPt9wrS/ASCD/8dAon4WxokTRgu+o=;
        b=gx4dSGbGnCPjd3jRuArVwD9JQlvCtpVa46YkXixLXAhw8otYpaLVXF9HaOBdGuX7xa
         8OK6hjtq5a4N+h63qrG8ptcHU45Fc9KeCFGdhRv7EM4rIBQ/PIfvWD5i3HF24hBoqVFR
         G27/JwD1fgkgBTTUA13GsAPTASHuv5BuZ7T5IKHS1UuBUwm4JLtASArlXtflqbitPvDW
         veKzgFMOuJZc8+V6xEL1DPs2eXWi+P7VsbJKF8SO7FfYVETFPJemZ3U25oKSkvJSl1uR
         FtJuFdFURIaPeBtr9zkYWpWcZubj1rT5RbnUtSObYgWXriz2czNTrl5x3M3FBwx5J/kc
         M9Ng==
X-Gm-Message-State: ANoB5pmWPknoWeFQSv4fOjeHhioFaBMIHkKQ038sjPI78MaY3C7efv9n
        E6z4n+2wDXraiO58VqjZgrGl46A4/E4=
X-Google-Smtp-Source: AA0mqf7TsfY2Ds45Sv36JzK/wqx2vX1PhqojOKuXed+b8FBBxWyG5zFOH0y+Oiq/+Lu/yagwzTOrqg==
X-Received: by 2002:aa7:8492:0:b0:576:ebfe:e9c1 with SMTP id u18-20020aa78492000000b00576ebfee9c1mr16019318pfn.20.1670856234979;
        Mon, 12 Dec 2022 06:43:54 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78bc3000000b005618189b0ffsm5886630pfd.104.2022.12.12.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:43:54 -0800 (PST)
Date:   Mon, 12 Dec 2022 23:43:50 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        hch@infradead.org, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio-blk: support completion batching for the IRQ
 path
Message-ID: <Y5c+Jok0DbtsRJ4X@localhost.localdomain>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
 <20221206141125.93055-2-suwan.kim027@gmail.com>
 <Y5EOEh2HYHqo+Sbh@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5EOEh2HYHqo+Sbh@fedora>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 07, 2022 at 05:05:06PM -0500, Stefan Hajnoczi wrote:
> On Tue, Dec 06, 2022 at 11:11:25PM +0900, Suwan Kim wrote:
> > This patch adds completion batching to the IRQ path. It reuses batch
> > completion code of virtblk_poll(). It collects requests to io_comp_batch
> > and processes them all at once. It can boost up the performance by 2%.
> > 
> > To validate the performance improvement and stabilty, I did fio test with
> > 4 vCPU VM and 12 vCPU VM respectively. Both VMs have 8GB ram and the same
> > number of HW queues as vCPU.
> > The fio cammad is as follows and I ran the fio 5 times and got IOPS average.
> > (io_uring, randread, direct=1, bs=512, iodepth=64 numjobs=2,4)
> > 
> > Test result shows about 2% improvement.
> > 
> >            4 vcpu VM       |   numjobs=2   |   numjobs=4
> >       -----------------------------------------------------------
> >         fio without patch  |  367.2K IOPS  |   397.6K IOPS
> >       -----------------------------------------------------------
> >         fio with patch     |  372.8K IOPS  |   407.7K IOPS
> > 
> >            12 vcpu VM      |   numjobs=2   |   numjobs=4
> >       -----------------------------------------------------------
> >         fio without patch  |  363.6K IOPS  |   374.8K IOPS
> >       -----------------------------------------------------------
> >         fio with patch     |  373.8K IOPS  |   385.3K IOPS
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >  drivers/block/virtio_blk.c | 38 +++++++++++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> Cool, thanks for doing this!
> 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index cf64d256787e..48fcf745f007 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -272,6 +272,18 @@ static inline void virtblk_request_done(struct request *req)
> >  	blk_mq_end_request(req, virtblk_result(vbr));
> >  }
> >  
> > +static void virtblk_complete_batch(struct io_comp_batch *iob)
> > +{
> > +	struct request *req;
> > +
> > +	rq_list_for_each(&iob->req_list, req) {
> > +		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> > +		virtblk_cleanup_cmd(req);
> > +		blk_mq_set_request_complete(req);
> > +	}
> > +	blk_mq_end_request_batch(iob);
> > +}
> > +
> >  static void virtblk_done(struct virtqueue *vq)
> >  {
> >  	struct virtio_blk *vblk = vq->vdev->priv;
> > @@ -280,6 +292,7 @@ static void virtblk_done(struct virtqueue *vq)
> >  	struct virtblk_req *vbr;
> >  	unsigned long flags;
> >  	unsigned int len;
> > +	DEFINE_IO_COMP_BATCH(iob);
> >  
> >  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> >  	do {
> > @@ -287,7 +300,9 @@ static void virtblk_done(struct virtqueue *vq)
> >  		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
> >  			struct request *req = blk_mq_rq_from_pdu(vbr);
> >  
> > -			if (likely(!blk_should_fake_timeout(req->q)))
> > +			if (likely(!blk_should_fake_timeout(req->q)) &&
> > +				!blk_mq_add_to_batch(req, &iob, vbr->status,
> > +							virtblk_complete_batch))
> >  				blk_mq_complete_request(req);
> >  			req_done = true;
> >  		}
> > @@ -295,9 +310,14 @@ static void virtblk_done(struct virtqueue *vq)
> >  			break;
> >  	} while (!virtqueue_enable_cb(vq));
> >  
> > -	/* In case queue is stopped waiting for more buffers. */
> > -	if (req_done)
> > +	if (req_done) {
> > +		if (!rq_list_empty(iob.req_list))
> > +			virtblk_complete_batch(&iob);
> 
> A little optimization to avoid the indirect call: iob.complete(&iob) :).
> Not sure if it's good style to do that but it works in this case because
> we know it can only be virtblk_complete_batch().
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Hi Stefan,

Thanks for the comment!
It also needs to use blk_mq_complete_request_remote() instead of
blk_mq_set_request_complete()
I will resend it with the modification of patch #1 and then please
review it again.

Regards,
Suwan Kim
