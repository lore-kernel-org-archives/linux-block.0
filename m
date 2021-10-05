Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA38C433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 10:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C343F61526
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 10:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhJEKon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233077AbhJEKon (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Oct 2021 06:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633430572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnN0iAzDh/S8fsii9MloUrds9D80Vyvt+Eh8JOcls+c=;
        b=I1JVxdoeV2yBhwIwi6rr92cHvHyHjj4PgSeb668R9NN6YfNuzy7l0AFAy6vnGhJ4ShyUXC
        1OAWxc4/PMqvU6iiYqnRDTEJ9M45oIzAzJ4cOoI0MVZ69N3HrwLKX7DB8uW81XV7M6/eFA
        Al0lXcl5x7wt5stLbC+kpzdbR82R438=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-X_tNFquvPsuZkZO-FxC_pA-1; Tue, 05 Oct 2021 06:42:51 -0400
X-MC-Unique: X_tNFquvPsuZkZO-FxC_pA-1
Received: by mail-ed1-f70.google.com with SMTP id k10-20020a508aca000000b003dad77857f7so4303221edk.22
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 03:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnN0iAzDh/S8fsii9MloUrds9D80Vyvt+Eh8JOcls+c=;
        b=7AnnBwJoklJSsx+1QGjlwTIpNdHK6ct38iRYldJgpMpe07JDRGfYlyJGNJMh2r4hFQ
         C4uUoirgO+Kt/nk4LM73Xi1CKfidwexSOCIbTf4F7Wnzquwg0mXjg67R/Y1cXuywionr
         U6lg9bSncsHhzMinRxXKwVcoNVb2R/VH+Rk3AYTSpr34NGnh0dcKwGukLNeI7bw/kX/+
         tb7g83pRdK+1MpQqtEKYDOLEfSqHJHrrFC2aUIbmHZSDxueyDSPm/ez6rBnJhYncPEbX
         rQOqKHj3mrJmUOn1GoIGfp2JkX3fmYXSys52/Dhrg+tkErJNcTyrFrtE1xVyHkBxj+KZ
         YoTw==
X-Gm-Message-State: AOAM532kC4D1c8z9Y/owkdLA+NfeUa5EbQ9gfBaISf5yx//XT0H9Czf8
        jjjs+Fi9qHa5r8CxWzrt8htU5cOQ0e2KJUT4TULvuhRV1eSHiq4GjPS8P7+1xGgCZOKQ0UlF4Pp
        lAYyJ3dWRaErWNYW+5hMjQiM=
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr23510381ejj.441.1633430570490;
        Tue, 05 Oct 2021 03:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwACM112IUCa3fOx7O5XRyDrZ+g5wNyCBCOWtDMMiRFBtNmFLZZKgE9j8Wc70F7xxIuqg+/cw==
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr23510362ejj.441.1633430570315;
        Tue, 05 Oct 2021 03:42:50 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id a1sm8000402edu.43.2021.10.05.03.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 03:42:49 -0700 (PDT)
Date:   Tue, 5 Oct 2021 06:42:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Wolf <kwolf@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211005062359-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004112623-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 04, 2021 at 11:27:29AM -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> > An untrusted device might presents an invalid block size
> > in configuration space. This tries to add validation for it
> > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > feature bit if the value is out of the supported range.
> > 
> > And we also double check the value in virtblk_probe() in
> > case that it's changed after the validation.
> > 
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> 
> So I had to revert this due basically bugs in QEMU.
> 
> My suggestion at this point is to try and update
> blk_queue_logical_block_size to BUG_ON when the size
> is out of a reasonable range.
> 
> This has the advantage of fixing more hardware, not just virtio.
> 

Stefan also pointed out this duplicates the logic from 

        if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
                return -EINVAL;


and a bunch of other places.


Would it be acceptable for blk layer to validate the input
instead of having each driver do it's own thing?
Maybe inside blk_queue_logical_block_size?



> 
> > ---
> >  drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 33 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4b49df2dfd23..afb37aac09e8 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >  
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +	u32 blk_size;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +		return 0;
> > +
> > +	blk_size = virtio_cread32(vdev,
> > +			offsetof(struct virtio_blk_config, blk_size));
> > +
> > +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > +
> > +	return 0;
> > +}
> > +
> >  static int virtblk_probe(struct virtio_device *vdev)
> >  {
> >  	struct virtio_blk *vblk;
> > @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	u8 physical_block_exp, alignment_offset;
> >  	unsigned int queue_depth;
> >  
> > -	if (!vdev->config->get) {
> > -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > -			__func__);
> > -		return -EINVAL;
> > -	}
> > -
> >  	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> >  			     GFP_KERNEL);
> >  	if (err < 0)
> > @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	else
> >  		blk_size = queue_logical_block_size(q);
> >  
> > +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> > +		dev_err(&vdev->dev,
> > +			"block size is changed unexpectedly, now is %u\n",
> > +			blk_size);
> > +		err = -EINVAL;
> > +		goto err_cleanup_disk;
> > +	}
> > +
> >  	/* Use topology information if available */
> >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
> >  				   struct virtio_blk_config, physical_block_exp,
> > @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> >  	return 0;
> >  
> > +err_cleanup_disk:
> > +	blk_cleanup_disk(vblk->disk);
> >  out_free_tags:
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >  out_free_vq:
> > @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
> >  	.driver.name			= KBUILD_MODNAME,
> >  	.driver.owner			= THIS_MODULE,
> >  	.id_table			= id_table,
> > +	.validate			= virtblk_validate,
> >  	.probe				= virtblk_probe,
> >  	.remove				= virtblk_remove,
> >  	.config_changed			= virtblk_config_changed,
> > -- 
> > 2.11.0

