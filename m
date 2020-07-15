Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9AC433E7
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9102620658
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 11:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O20OELM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgGOLxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:53:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729270AbgGOLxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 07:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594813992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRebg+2hQH/Gw0w35KIF4+WcCOOUcfl15x3ccfbN2AQ=;
        b=O20OELM49Xr0qDIoGZCnKj6UVpVz+GaHqhKe81dRV59AGw6oizviDbrZMBifuKx65Ezd2Q
        8at+nv3swqu2iEdTnYAPNng2mx0+P7JYA3QnbiBXeVt5Cpj364XqTIPCScCvEyunNallXB
        jz3VsNAC79L7zY0hY1dGjDg60++pse8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-GqIZhvJMOSSdBE0Kp_IshQ-1; Wed, 15 Jul 2020 07:53:10 -0400
X-MC-Unique: GqIZhvJMOSSdBE0Kp_IshQ-1
Received: by mail-qt1-f197.google.com with SMTP id i5so1204700qtw.3
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 04:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XRebg+2hQH/Gw0w35KIF4+WcCOOUcfl15x3ccfbN2AQ=;
        b=LjAWY6INmYJ2Cnv2K3e0rsbtDQW5ZmDCN9YcC5xp8cqek5rpJqtmx2RP9KMSW04Ijm
         t3aVqV1q+c40kpe9IbjzYihy2E8KoCZO0OgoAxdIEX/DOPCbP9TfMkWSXTLOJSoShfhh
         GTs1rDhw+zJAsXfJFzRYF6DHAF+gakOGtXcuBEmo0ubymU0Mqsy89GDfX0Wk/8KKevWI
         +33sB84RNz4QERUa3t1OoTqCvVZ7fDbdzH4olKznBWHgOzxAHjRzWj+stWZlpSebzmS9
         Q1KQApE6+UFryh5b0ny/h7XfjYnv91cvzrXsmsrLtGjrB7+nRi4HGpgtcGmDoJwVKNl6
         nOPA==
X-Gm-Message-State: AOAM5335S3qXHLycmHLKwfrplPrTsO6exFS2jL5eiFMtBN//haQT7vYl
        HsQdX02YVihDW4N7xEiU5oEjDSAObwiEOypmKMiPlSOZWb0rEcyUor78nMwnB2qRW0Lao+TSkSF
        p0CpcEAQ6JE8G9G0guFJBRu0=
X-Received: by 2002:ac8:1bad:: with SMTP id z42mr10171633qtj.110.1594813990106;
        Wed, 15 Jul 2020 04:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZLQW6IPoaal5RqoixSgcxDNeoXQMbVkN1Hy7ePJAHUY2LlFS6AhokOzXIHgq7pLbao1Bw3A==
X-Received: by 2002:ac8:1bad:: with SMTP id z42mr10171616qtj.110.1594813989842;
        Wed, 15 Jul 2020 04:53:09 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id u27sm2131046qkm.121.2020.07.15.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:53:09 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:53:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] virtio-blk: check host supplied logical block size
Message-ID: <20200715075151-mutt-send-email-mst@kernel.org>
References: <20200715095518.3724-1-mlevitsk@redhat.com>
 <20200715060233-mutt-send-email-mst@kernel.org>
 <5dd5af8032160eb49a4f0e38749e2d9cd968a0d6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd5af8032160eb49a4f0e38749e2d9cd968a0d6.camel@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 15, 2020 at 01:19:55PM +0300, Maxim Levitsky wrote:
> On Wed, 2020-07-15 at 06:06 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2020 at 12:55:18PM +0300, Maxim Levitsky wrote:
> > > Linux kernel only supports logical block sizes which are power of
> > > two,
> > > at least 512 bytes and no more that PAGE_SIZE.
> > > 
> > > Check this instead of crashing later on.
> > > 
> > > Note that there is no need to check physical block size since it is
> > > only a hint, and virtio-blk already only supports power of two
> > > values.
> > > 
> > > Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 980df853ee497..36dda31cc4e96 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -681,6 +681,12 @@ static const struct blk_mq_ops virtio_mq_ops =
> > > {
> > >  static unsigned int virtblk_queue_depth;
> > >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> > >  
> > > +
> > > +static bool virtblk_valid_block_size(unsigned int blksize)
> > > +{
> > > +	return blksize >= 512 && blksize <= PAGE_SIZE &&
> > > is_power_of_2(blksize);
> > > +}
> > > +
> > 
> > Is this a blk core assumption? in that case, does not this belong
> > in blk core?
> 
> It is a blk core assumption. 
> I had checked other drivers and these that have variable block size all
> check this manually like that.
> 
> I don't mind fixing all of them but I am a bit afraid to create
> too much mess.

You don't have to, start by adding this in blk core and using in virtio.
Patches to update all drivers can then come separately.

> > 
> > >  static int virtblk_probe(struct virtio_device *vdev)
> > >  {
> > >  	struct virtio_blk *vblk;
> > > @@ -809,9 +815,16 @@ static int virtblk_probe(struct virtio_device
> > > *vdev)
> > >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> > >  				   struct virtio_blk_config, blk_size,
> > >  				   &blk_size);
> > > -	if (!err)
> > > +	if (!err) {
> > > +		if (!virtblk_valid_block_size(blk_size)) {
> > > +			dev_err(&vdev->dev,
> > > +				"%s failure: unsupported logical block
> > > size %d\n",
> > > +				__func__, blk_size);
> > > +			err = -EINVAL;
> > > +			goto out_cleanup_queue;
> > > +		}
> > >  		blk_queue_logical_block_size(q, blk_size);
> > > -	else
> > > +	} else
> > >  		blk_size = queue_logical_block_size(q);
> > >  
> > >  	/* Use topology information if available */
> > 
> > OK so if we are doing this pls add {} around  blk_size =
> > queue_logical_block_size(q);
> > too.
> Will do.
> 
> > 
> > > @@ -872,6 +885,9 @@ static int virtblk_probe(struct virtio_device
> > > *vdev)
> > >  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> > >  	return 0;
> > >  
> > > +out_cleanup_queue:
> > > +	blk_cleanup_queue(vblk->disk->queue);
> > > +	vblk->disk->queue = NULL;
> > >  out_free_tags:
> > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > >  out_put_disk:
> > > -- 
> > > 2.26.2
> 
> 
> Best regards,
> 	Maxim Levitsky

