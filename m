Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3894C433FE
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE4A6056B
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 11:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhIFLWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 07:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241070AbhIFLWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 07:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630927255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwCcwobqarvdp7b4ZxKmDRuHy822IrmJf431Zj87HGM=;
        b=c8VndKIXRd3uk4l/vu4ezfYK7J6KNb0Du+QtllfoiroG7oy8SwZ5+hyF2SrGCYDxLuV/Ql
        zcHohVvcsFXhk/2YAsJnKZUrSd9gJBp40zD5ZI72ZIIdNmFrboxR9CZxwYuz8qU/BvdLrI
        4YpWkmsd8VLqyRiDxAjh9InDSaMipyM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ktTCRRWsMEmKd597qESsOw-1; Mon, 06 Sep 2021 07:20:54 -0400
X-MC-Unique: ktTCRRWsMEmKd597qESsOw-1
Received: by mail-ej1-f69.google.com with SMTP id ak17-20020a170906889100b005c5d1e5e707so2185839ejc.16
        for <linux-block@vger.kernel.org>; Mon, 06 Sep 2021 04:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwCcwobqarvdp7b4ZxKmDRuHy822IrmJf431Zj87HGM=;
        b=HpsakGoc/Fo19CvFzUEdPU53uzNcn+ds94S8riBYSb7KMQ0VupXziTegFZKuKFbBFc
         sMMUSD63cT9Fbw0tONXKU4JI3hXgNAQmbge3Wf+1mU/IcYUWPvofJGr8+VDOZ7XS3WNk
         I80ashhcAro0cedEByR/pnlZmyTxCFoIZI/ZqvH7VU01ffiTeoY4o2xA9F1gWJK5WHEu
         Bc2owsyVxH4vSJLlOD0NvI/dyiGyQKU4hANH9NYCw80uOQ5iYqHfuONk3V9lppccVsAO
         vOFOJ9ruKOChaP/1/HmoYfdZMZLQriiJylBjGfP1hOtdAzd/Obcs9RFmCdP+aV19QFsT
         NL5Q==
X-Gm-Message-State: AOAM530/9OHYPSIZP5pAgQcz7NIdWM5arWtNGiy/MeMwc02hY+nnHlZa
        i5hfnfBFAZnfxoA5AhPAq0+4mq6g69o1CgQdxaATf9XsmOZSTFc70Rk8oYAljIU8gnCxziyBQvM
        UcpnDpF60GmWGI+c6ACe2Dq4=
X-Received: by 2002:a50:fb08:: with SMTP id d8mr12725040edq.160.1630927253392;
        Mon, 06 Sep 2021 04:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnXiZkAIDU73uVyPn+3O20GkHTxFw7vX6uAGTN6zNHOCvY8p6FyX/5L/Q7XXf2IlUH+ouktQ==
X-Received: by 2002:a50:fb08:: with SMTP id d8mr12725016edq.160.1630927253147;
        Mon, 06 Sep 2021 04:20:53 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id f1sm4406891edq.89.2021.09.06.04.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 04:20:51 -0700 (PDT)
Date:   Mon, 6 Sep 2021 07:20:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, hch@infradead.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        israelr@nvidia.com, nitzanc@nvidia.com, oren@nvidia.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210906071957-mutt-send-email-mst@kernel.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
 <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
 <20210905120234-mutt-send-email-mst@kernel.org>
 <98309fcd-3abe-1f27-fe52-e8fcc58bec13@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98309fcd-3abe-1f27-fe52-e8fcc58bec13@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 01:31:32AM +0300, Max Gurtovoy wrote:
> 
> On 9/5/2021 7:02 PM, Michael S. Tsirkin wrote:
> > On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> > > On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > > > Sometimes a user would like to control the amount of IO queues to be
> > > > created for a block device. For example, for limiting the memory
> > > > footprint of virtio-blk devices.
> > > > 
> > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > ---
> > > > 
> > > > changes from v1:
> > > >   - use param_set_uint_minmax (from Christoph)
> > > >   - added "Should > 0" to module description
> > > > 
> > > > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > > > ---
> > > >   drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> > > >   1 file changed, 19 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 4b49df2dfd23..9332fc4e9b31 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -24,6 +24,22 @@
> > > >   /* The maximum number of sg elements that fit into a virtqueue */
> > > >   #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> > > > +static int virtblk_queue_count_set(const char *val,
> > > > +		const struct kernel_param *kp)
> > > > +{
> > > > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > +}


Hmm which tree is this for?

> > > > +
> > > > +static const struct kernel_param_ops queue_count_ops = {
> > > > +	.set = virtblk_queue_count_set,
> > > > +	.get = param_get_uint,
> > > > +};
> > > > +
> > > > +static unsigned int num_io_queues;
> > > > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > > > +MODULE_PARM_DESC(num_io_queues,
> > > > +		 "Number of IO virt queues to use for blk device. Should > 0");



better:

+MODULE_PARM_DESC(num_io_request_queues,
+                "Limit number of IO request virt queues to use for each device. 0 for now limit");


> > > > +
> > > >   static int major;
> > > >   static DEFINE_IDA(vd_index_ida);
> > > > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > >   	if (err)
> > > >   		num_vqs = 1;
> > > > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > +	num_vqs = min_t(unsigned int,
> > > > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > > > +			num_vqs);
> > > If you respin, please consider calling them request queues. That's the
> > > terminology from the VIRTIO spec and it's nice to keep it consistent.
> > > But the purpose of num_io_queues is clear, so:
> > > 
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > I did this:
> > +static unsigned int num_io_request_queues;
> > +module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
> > +MODULE_PARM_DESC(num_io_request_queues,
> > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> 
> The parameter is writable and can be changed and then new devices might be
> probed with new value.
> 
> It can't be zero in the code. we can change param_set_uint_minmax args and
> say that 0 says nr_cpus.
> 
> I'm ok with the renaming but I prefer to stick to the description we gave in
> V3 of this patch (and maybe enable value of 0 as mentioned above).

