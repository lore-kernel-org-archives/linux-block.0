Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5AAC433F5
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E45261029
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhIEQD4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 12:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237979AbhIEQDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Sep 2021 12:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630857770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFUKBgO0Ri1xXVfSTLwQQ6n1EXRj/R2St3GRxbwUsHQ=;
        b=L6KYagGDGaZilvHOS9Z6jkATTFTzqxoMiCIM968UWnyhzk4uUoZflPq9QgqLyLCnrDaQu8
        lrCtVp8KkTBKNrIAKZvHrHMoNnYDwa768texxmu4yRVASszzsg52A1xs9uDGbi9yDH6bF5
        bFN/gFMiNsABnjASuvlQJdTaR8JDMh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-GpCXCAsGMAujkldz3fj0MQ-1; Sun, 05 Sep 2021 12:02:49 -0400
X-MC-Unique: GpCXCAsGMAujkldz3fj0MQ-1
Received: by mail-wm1-f69.google.com with SMTP id p29-20020a1c545d000000b002f88d28e1f1so1437487wmi.7
        for <linux-block@vger.kernel.org>; Sun, 05 Sep 2021 09:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UFUKBgO0Ri1xXVfSTLwQQ6n1EXRj/R2St3GRxbwUsHQ=;
        b=GcBRCkoUPDacgRqL4r9nn/nt2dlYgNzkLq89HnefT03Mn9PgmgQNS6JT4UF5V1RuWU
         1ACfLIZoEH+jzofPyYkZiSiN8OKLuTIs3C1Jqq3ZZjQaFph4h/mmc1D+H/VdfADFKYsY
         fgRDcxdAPYau+gk5tuwm4ziHFoqCNoSMuebGuX9FE3CHFtlMfnMixhPpqPPJT+29xNKL
         6JUMSTaAkkdoLHwDDHirm1zCq+hPkI40RYCkbxEZsImGXlPy+Oe8emhqhnzuI+k47Auf
         5mFfzG0Nfq+34C4Kru+u+sY3Sj6Ig7xzloDvHsWRoaL/7KfgpyIK4VsFV1v1bu7MyB5K
         4LAw==
X-Gm-Message-State: AOAM530Hda9/UZzff4B6Bt/HWxG25rOhU0ZE+LBLdtqkeIMpPcr8QWdw
        osqby/cp6ADAqS3Hq/ZM1owE5lTmFKEE2tRPVmKU2tYMu3b19dw4hjtkQqlrJamm7xm5qstgrAY
        Se1fxBIGvmCUHoOhdGFMJs0Y=
X-Received: by 2002:a1c:7503:: with SMTP id o3mr7425505wmc.129.1630857767103;
        Sun, 05 Sep 2021 09:02:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+jYdy0uL4WaJOpJ4iOFHt6H+cjCfQhzErPuJ1lH4FMlns0HOWIVet2jX9qnAP00mbt8+/SQ==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr7425490wmc.129.1630857766939;
        Sun, 05 Sep 2021 09:02:46 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id q11sm4833205wmc.41.2021.09.05.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 09:02:46 -0700 (PDT)
Date:   Sun, 5 Sep 2021 12:02:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>, hch@infradead.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        israelr@nvidia.com, nitzanc@nvidia.com, oren@nvidia.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210905120234-mutt-send-email-mst@kernel.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
 <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > Sometimes a user would like to control the amount of IO queues to be
> > created for a block device. For example, for limiting the memory
> > footprint of virtio-blk devices.
> > 
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> > 
> > changes from v1:
> >  - use param_set_uint_minmax (from Christoph)
> >  - added "Should > 0" to module description
> > 
> > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > ---
> >  drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4b49df2dfd23..9332fc4e9b31 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -24,6 +24,22 @@
> >  /* The maximum number of sg elements that fit into a virtqueue */
> >  #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> >  
> > +static int virtblk_queue_count_set(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > +}
> > +
> > +static const struct kernel_param_ops queue_count_ops = {
> > +	.set = virtblk_queue_count_set,
> > +	.get = param_get_uint,
> > +};
> > +
> > +static unsigned int num_io_queues;
> > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > +MODULE_PARM_DESC(num_io_queues,
> > +		 "Number of IO virt queues to use for blk device. Should > 0");
> > +
> >  static int major;
> >  static DEFINE_IDA(vd_index_ida);
> >  
> > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> >  	if (err)
> >  		num_vqs = 1;
> >  
> > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > +	num_vqs = min_t(unsigned int,
> > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > +			num_vqs);
> 
> If you respin, please consider calling them request queues. That's the
> terminology from the VIRTIO spec and it's nice to keep it consistent.
> But the purpose of num_io_queues is clear, so:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

I did this:
+static unsigned int num_io_request_queues;
+module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
+MODULE_PARM_DESC(num_io_request_queues,
+                "Limit number of IO request virt queues to use for each device. 0 for now limit");

