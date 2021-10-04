Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE5C433F5
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EC161357
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 15:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhJDPlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234314AbhJDPla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Oct 2021 11:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633361981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU1FtB2Eld4jQppv2Kg9J4SKZoBotXi+g3+/KDP2nB0=;
        b=Ji1ekAVtELkiAF3gBH5NEDrs1pRF5oKB1QAMKpaKVDAn9JfMz4BTr+ZVoaP+4ANTsB/MkF
        OXlp81kBY7gFHKaeo1o9XIJnOQMwejgBOHqSnof5yaOXH5THF3T2MSJwAmDsf3797rkW4p
        nMBYsnrxh09ttdb2BTj+3Q2w8npkR8c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-VzJmoiALMJi9dzgnN1SClg-1; Mon, 04 Oct 2021 11:39:39 -0400
X-MC-Unique: VzJmoiALMJi9dzgnN1SClg-1
Received: by mail-ed1-f70.google.com with SMTP id w6-20020a50d786000000b003dabc563406so13195904edi.17
        for <linux-block@vger.kernel.org>; Mon, 04 Oct 2021 08:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qU1FtB2Eld4jQppv2Kg9J4SKZoBotXi+g3+/KDP2nB0=;
        b=1ZEYhxuLKiLIrYXzE1HdmYDIBC8VgQQvDDB6/t/Lr+Dli1FYRErjT7g3z/eBjQiK9W
         /DubYjbG/uD5Ox+UVVpbB956siGpFKArgeopQDs8VFuJpJgf6n7Hhppqxg/N8jOolnvu
         hFqG4u3HmZTdB2k6flYP8LPBLHO73ET/sY4iRXrG3aRnWqruefws0Prati3dCkJon5NT
         1zDXUg5qSpO7uZbbIryQKUl9MhETYpg5XZV/T0jO0hmMDBTqekv2BNuJqGYphnObKeY9
         HEC6H+5076Kjgn75Uo6gwECpvLiWfaGxDYJY/jhHYMSmZRQ8Pe/FgPgkSQeB3sIigrD5
         Gm6A==
X-Gm-Message-State: AOAM532hux9pWYeggA5i4UTag+c3bBHLFk3BlnPXqNd2X3LS7xCX/PVj
        qfly8+BwPEWJVvr12vz5r4l+PXv4/vgaYZ6bfF7PiclB1dVb6K6rd25Cd/er5yxqO3ziWAPEvFF
        xyY2URMD5h6OYL7QmjIAr+88=
X-Received: by 2002:a17:906:a2c9:: with SMTP id by9mr13462723ejb.305.1633361977034;
        Mon, 04 Oct 2021 08:39:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymXaxS/ytfZ06+7jKPOhRySBzCqaPSUjBwPFfvyPHjd3iZN7oI5pN28PgDrC2yAGlapCwmMA==
X-Received: by 2002:a17:906:a2c9:: with SMTP id by9mr13462700ejb.305.1633361976806;
        Mon, 04 Oct 2021 08:39:36 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
        by smtp.gmail.com with ESMTPSA id o5sm7374753eds.26.2021.10.04.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:39:36 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:39:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211004113722-mutt-send-email-mst@kernel.org>
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
> 
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

I started wondering about this. So let's assume is
PAGE_SIZE < blk_size (after all it's up to guest at many platforms).

Will using the device even work given blk size is less than what
is can support?

And what exactly happens today if blk_size is out of this range?





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

