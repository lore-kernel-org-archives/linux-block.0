Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA1DC00140
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 12:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiHJMlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHJMlO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 08:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D895175FD5
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660135272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GVGfUW1RKI3FajCNZWPpZsDvCAXWP2hsd5EFJaoYXWQ=;
        b=YrPo+c8sBZsohWX88b68ek3HQ8vFzmyFRgVaqmZu9q9SCqF6gm1ypEwUKuZQcoeZNNaLIC
        0e7VXZRGI78zPAiGhl7B9m+g9denJWsn+t5spZs4ImeJmNGfjaOGBioek++SJNBWRseXKw
        Ciy25fxaNdkWN9IQ0B+OuFwq2rFL6x0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-Az4jMoreMrq8YlP0GBw4uA-1; Wed, 10 Aug 2022 08:41:10 -0400
X-MC-Unique: Az4jMoreMrq8YlP0GBw4uA-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020a05640251cc00b00440647ec649so6779001edd.21
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GVGfUW1RKI3FajCNZWPpZsDvCAXWP2hsd5EFJaoYXWQ=;
        b=L+bXMbR0a1H2jJMufHDVTwQ9Ay7kk5SIKFbr2XrMGqsvIVkHjtoXjoVapzrx53fpFb
         /KjgVg/o7OWCV2pTv8YNpJmV6Y6gcWPHRmIyeKpXtx8rqs2DWVrJ0KgYV2k0ZdRy3bdG
         jjBn6dlYYzlaaQaGIMd3lBtYsKahlbHxHg5UcaXLI5pbkn7xdieZ1wWgLz8DespWZQ0l
         JxH1NpK113suksXb5gg+Kiv/hY8Mtp2N4MKyCopuQUfWvMhZJtdzsKbOf9vYW7z/P7Xj
         pitWMmXQSDNjKPbTRUhsQ2re2e4L+HT3mfRncr4aoAYjYsrpR6s3/HEvhgIm51AZ3vHd
         juLg==
X-Gm-Message-State: ACgBeo2H6bBp2LVNgXogqymoTDixyZ4N74SeMfwDwGu03H6IVbyvJsWC
        6Q1BrpAEVQl5ZtdBGocqK3cyjn9I0wDokwTOLaNRP9C1zUisaRQnAPjSTxk851SQJ4kZ5U0IRlg
        NxlWhaeUQbh+DdNwaIEX/A94=
X-Received: by 2002:aa7:ce88:0:b0:442:30f5:433f with SMTP id y8-20020aa7ce88000000b0044230f5433fmr4995883edv.317.1660135269506;
        Wed, 10 Aug 2022 05:41:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5/cz4aFbceABg+Osg2Px2SlIV/ktzBNGlPGXbY6O3K6PVCUlBtIy54SKtla4RESUH41xAi2g==
X-Received: by 2002:aa7:ce88:0:b0:442:30f5:433f with SMTP id y8-20020aa7ce88000000b0044230f5433fmr4995865edv.317.1660135269288;
        Wed, 10 Aug 2022 05:41:09 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170907774b00b006fe0abb00f0sm2250524ejc.209.2022.08.10.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 05:41:08 -0700 (PDT)
Date:   Wed, 10 Aug 2022 08:41:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shigeru Yoshida <shigeru.yoshida@gmail.com>
Cc:     jasowang@redhat.com, axboe@kernel.dk, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Avoid use-after-free on suspend/resume
Message-ID: <20220810084053-mutt-send-email-mst@kernel.org>
References: <20220731070951.196831-1-shigeru.yoshida@gmail.com>
 <20220810.204556.441522765735488771.shigeru.yoshida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810.204556.441522765735488771.shigeru.yoshida@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 10, 2022 at 08:45:56PM +0900, Shigeru Yoshida wrote:
> ping?
> 
> On Sun, 31 Jul 2022 16:09:51 +0900, Shigeru Yoshida wrote:
> > hctx->user_data is set to vq in virtblk_init_hctx().  However, vq is
> > freed on suspend and reallocated on resume.  So, hctx->user_data is
> > invalid after resume, and it will cause use-after-free accessing which
> > will result in the kernel crash something like below:
> > 
> > [   22.428391] Call Trace:
> > [   22.428899]  <TASK>
> > [   22.429339]  virtqueue_add_split+0x3eb/0x620
> > [   22.430035]  ? __blk_mq_alloc_requests+0x17f/0x2d0
> > [   22.430789]  ? kvm_clock_get_cycles+0x14/0x30
> > [   22.431496]  virtqueue_add_sgs+0xad/0xd0
> > [   22.432108]  virtblk_add_req+0xe8/0x150
> > [   22.432692]  virtio_queue_rqs+0xeb/0x210
> > [   22.433330]  blk_mq_flush_plug_list+0x1b8/0x280
> > [   22.434059]  __blk_flush_plug+0xe1/0x140
> > [   22.434853]  blk_finish_plug+0x20/0x40
> > [   22.435512]  read_pages+0x20a/0x2e0
> > [   22.436063]  ? folio_add_lru+0x62/0xa0
> > [   22.436652]  page_cache_ra_unbounded+0x112/0x160
> > [   22.437365]  filemap_get_pages+0xe1/0x5b0
> > [   22.437964]  ? context_to_sid+0x70/0x100
> > [   22.438580]  ? sidtab_context_to_sid+0x32/0x400
> > [   22.439979]  filemap_read+0xcd/0x3d0
> > [   22.440917]  xfs_file_buffered_read+0x4a/0xc0
> > [   22.441984]  xfs_file_read_iter+0x65/0xd0
> > [   22.442970]  __kernel_read+0x160/0x2e0
> > [   22.443921]  bprm_execve+0x21b/0x640
> > [   22.444809]  do_execveat_common.isra.0+0x1a8/0x220
> > [   22.446008]  __x64_sys_execve+0x2d/0x40
> > [   22.446920]  do_syscall_64+0x37/0x90
> > [   22.447773]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > This patch fixes this issue by getting vq from vblk, and removes
> > virtblk_init_hctx().
> > 
> > Signed-off-by: Shigeru Yoshida <shigeru.yoshida@gmail.com>

Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
Cc: "Suwan Kim" <suwan.kim027@gmail.com>

I assume?

> > ---
> >  drivers/block/virtio_blk.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6fc7850c2b0a..d756423e0059 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -101,6 +101,14 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
> >  	}
> >  }
> >  
> > +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	struct virtio_blk *vblk = hctx->queue->queuedata;
> > +	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > +
> > +	return vq;
> > +}
> > +
> >  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
> >  {
> >  	struct scatterlist hdr, status, *sgs[3];
> > @@ -416,7 +424,7 @@ static void virtio_queue_rqs(struct request **rqlist)
> >  	struct request *requeue_list = NULL;
> >  
> >  	rq_list_for_each_safe(rqlist, req, next) {
> > -		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> > +		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> >  		bool kick;
> >  
> >  		if (!virtblk_prep_rq_batch(req)) {
> > @@ -837,7 +845,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
> >  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> >  {
> >  	struct virtio_blk *vblk = hctx->queue->queuedata;
> > -	struct virtio_blk_vq *vq = hctx->driver_data;
> > +	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
> >  	struct virtblk_req *vbr;
> >  	unsigned long flags;
> >  	unsigned int len;
> > @@ -862,22 +870,10 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> >  	return found;
> >  }
> >  
> > -static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> > -			  unsigned int hctx_idx)
> > -{
> > -	struct virtio_blk *vblk = data;
> > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> > -
> > -	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
> > -	hctx->driver_data = vq;
> > -	return 0;
> > -}
> > -
> >  static const struct blk_mq_ops virtio_mq_ops = {
> >  	.queue_rq	= virtio_queue_rq,
> >  	.queue_rqs	= virtio_queue_rqs,
> >  	.commit_rqs	= virtio_commit_rqs,
> > -	.init_hctx	= virtblk_init_hctx,
> >  	.complete	= virtblk_request_done,
> >  	.map_queues	= virtblk_map_queues,
> >  	.poll		= virtblk_poll,
> > -- 
> > 2.37.1
> > 

