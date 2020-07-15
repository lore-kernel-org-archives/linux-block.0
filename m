Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72240C433E2
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2452065D
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 12:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMyt8/kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgGOMLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:11:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730789AbgGOMLH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 08:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594815065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qiTdV3yCAaoLvg9QrO2QfUMpXovbFKIwHi7VEOB69IY=;
        b=PMyt8/kHmXB0mlSdP8huF8OVbl56ilPPsNZj0w+Lyt1yJN78a1cHjktHAa88inVchi52pc
        EztqwHJlBc31kEslhL0eUBHTdNRgzTSFiPJFiQcKUZqdU5j9R00J9ZBVfYEL96VdV81QQv
        vD9EdPLT4K4kTHCQ0r5Us5WC4DEolT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-nqN7I_BzO8SA8E5DYjEiiQ-1; Wed, 15 Jul 2020 08:11:01 -0400
X-MC-Unique: nqN7I_BzO8SA8E5DYjEiiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB2011009610;
        Wed, 15 Jul 2020 12:10:59 +0000 (UTC)
Received: from starship (unknown [10.35.206.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D55E179CF8;
        Wed, 15 Jul 2020 12:10:51 +0000 (UTC)
Message-ID: <3fbc070481ab7610cd5ad69d128da665b96bda79.camel@redhat.com>
Subject: Re: [PATCH] virtio-blk: check host supplied logical block size
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>
Date:   Wed, 15 Jul 2020 15:10:50 +0300
In-Reply-To: <20200715075151-mutt-send-email-mst@kernel.org>
References: <20200715095518.3724-1-mlevitsk@redhat.com>
         <20200715060233-mutt-send-email-mst@kernel.org>
         <5dd5af8032160eb49a4f0e38749e2d9cd968a0d6.camel@redhat.com>
         <20200715075151-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2020-07-15 at 07:53 -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2020 at 01:19:55PM +0300, Maxim Levitsky wrote:
> > On Wed, 2020-07-15 at 06:06 -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 15, 2020 at 12:55:18PM +0300, Maxim Levitsky wrote:
> > > > Linux kernel only supports logical block sizes which are power of
> > > > two,
> > > > at least 512 bytes and no more that PAGE_SIZE.
> > > > 
> > > > Check this instead of crashing later on.
> > > > 
> > > > Note that there is no need to check physical block size since it is
> > > > only a hint, and virtio-blk already only supports power of two
> > > > values.
> > > > 
> > > > Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619
> > > > 
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 20 ++++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 980df853ee497..36dda31cc4e96 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -681,6 +681,12 @@ static const struct blk_mq_ops virtio_mq_ops =
> > > > {
> > > >  static unsigned int virtblk_queue_depth;
> > > >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> > > >  
> > > > +
> > > > +static bool virtblk_valid_block_size(unsigned int blksize)
> > > > +{
> > > > +	return blksize >= 512 && blksize <= PAGE_SIZE &&
> > > > is_power_of_2(blksize);
> > > > +}
> > > > +
> > > 
> > > Is this a blk core assumption? in that case, does not this belong
> > > in blk core?
> > 
> > It is a blk core assumption. 
> > I had checked other drivers and these that have variable block size all
> > check this manually like that.
> > 
> > I don't mind fixing all of them but I am a bit afraid to create
> > too much mess.
> 
> You don't have to, start by adding this in blk core and using in virtio.
> Patches to update all drivers can then come separately.

I'll do this then.

Best regards,
	Maxim Levitsky

> 
> > > >  static int virtblk_probe(struct virtio_device *vdev)
> > > >  {
> > > >  	struct virtio_blk *vblk;
> > > > @@ -809,9 +815,16 @@ static int virtblk_probe(struct virtio_device
> > > > *vdev)
> > > >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> > > >  				   struct virtio_blk_config, blk_size,
> > > >  				   &blk_size);
> > > > -	if (!err)
> > > > +	if (!err) {
> > > > +		if (!virtblk_valid_block_size(blk_size)) {
> > > > +			dev_err(&vdev->dev,
> > > > +				"%s failure: unsupported logical block
> > > > size %d\n",
> > > > +				__func__, blk_size);
> > > > +			err = -EINVAL;
> > > > +			goto out_cleanup_queue;
> > > > +		}
> > > >  		blk_queue_logical_block_size(q, blk_size);
> > > > -	else
> > > > +	} else
> > > >  		blk_size = queue_logical_block_size(q);
> > > >  
> > > >  	/* Use topology information if available */
> > > 
> > > OK so if we are doing this pls add {} around  blk_size =
> > > queue_logical_block_size(q);
> > > too.
> > Will do.
> > 
> > > > @@ -872,6 +885,9 @@ static int virtblk_probe(struct virtio_device
> > > > *vdev)
> > > >  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> > > >  	return 0;
> > > >  
> > > > +out_cleanup_queue:
> > > > +	blk_cleanup_queue(vblk->disk->queue);
> > > > +	vblk->disk->queue = NULL;
> > > >  out_free_tags:
> > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > >  out_put_disk:
> > > > -- 
> > > > 2.26.2
> > 
> > Best regards,
> > 	Maxim Levitsky


