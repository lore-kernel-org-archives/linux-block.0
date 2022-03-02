Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5FAC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 14:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbiCBOQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBOQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 09:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 974B8B0E9E
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646230550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2N/IlzGyjMOglJgTyOGfwxfmg2/yQAmnahVF4RnYydE=;
        b=WQ+/vxiPPNgqYL4BKNejYCI/1c6wvAOO8ozNR8n15iTnkfL3NkB4rSvRMMKQUlioske7z1
        kUCi5RFC2+G/VnA7REn9UJ5WJ8T2pI/0/f9O4TAb0bjxGbz8d1v70hni8u/cJggfTI7hxW
        o4KE398drP+i+YwjtkNnkGRjGPBalEM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-JyZ-UXOSMbSuH4I7phZbmQ-1; Wed, 02 Mar 2022 09:15:49 -0500
X-MC-Unique: JyZ-UXOSMbSuH4I7phZbmQ-1
Received: by mail-wm1-f71.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso454073wme.1
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 06:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2N/IlzGyjMOglJgTyOGfwxfmg2/yQAmnahVF4RnYydE=;
        b=zanwC4XKys6lFtO4cIrmNTpvX3XaTi8TArPxaqc5hpGF87PgEAyxg1FF4UeJcguNBk
         OTB8iglO101IdkvTP3iEtA15etkkxKpqPJdZgVF8FiaGGqM5P2jKFQNCwe1LE4tM7q9J
         aQDi+dt+NBZrBQ20mn0ItFG0+QXSqxN7PFlWq5bY7jmxKCfqj0gvgsyQyr3c8swUlF1b
         DxQA1k11+mmMnbcxvQiMzkmrgwQiMdEUMrm+aP3dTdh0V/+JtC5nuXDGOsOiRJl/C7d3
         63BQBNaiHoCuMR/MRMHrC4rGmIry6ulp15XwkjT8Z6hTJ4HHgE7vATwRVYm8cJhr50dq
         gFag==
X-Gm-Message-State: AOAM530C8DoxnghZy42i4QsVyJsK907Cap1LTiBg7iVI0eMM4ozefnVJ
        Pw3VY2dPvAdW49Ymzpd/Zw3dblITqooXsSBaLn0za1AJEqp+ZG0+33WUpsuxqXrALIrIaRVQpVe
        aDZkZ1BKtMAferpdCZfa9KRQ=
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id y15-20020a05600015cf00b001f044b9b916mr1806332wry.86.1646230548434;
        Wed, 02 Mar 2022 06:15:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze6YulJFuarXC9cemliWPtlNBmwiwnvxdYpuAHM3IqXDAykNjmrhcy744TOT0f+rdwqJ9aJQ==
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id y15-20020a05600015cf00b001f044b9b916mr1806308wry.86.1646230548113;
        Wed, 02 Mar 2022 06:15:48 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id k15-20020adff5cf000000b001e4b8fde355sm16619182wrp.73.2022.03.02.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:15:44 -0800 (PST)
Date:   Wed, 2 Mar 2022 09:15:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
        axboe@kernel.dk, hch@infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302085132-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
 <20220302081542-mutt-send-email-mst@kernel.org>
 <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
 <20220302083112-mutt-send-email-mst@kernel.org>
 <808fbd57-588d-03e3-2904-513f4bdcceaf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <808fbd57-588d-03e3-2904-513f4bdcceaf@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 03:45:10PM +0200, Max Gurtovoy wrote:
> 
> On 3/2/2022 3:33 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
> > > On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> > > > > On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > > > > > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > > > > > Currently we have a BUG_ON() to make sure the number of sg
> > > > > > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > > > > > However, the block layer uses queue_max_discard_segments()
> > > > > > > instead of queue_max_segments() to limit the sg list for
> > > > > > > discard requests. So the BUG_ON() might be triggered if
> > > > > > > virtio-blk device reports a larger value for max discard
> > > > > > > segment than queue_max_segments().
> > > > > > Hmm the spec does not say what should happen if max_discard_seg
> > > > > > exceeds seg_max. Is this the config you have in mind? how do you
> > > > > > create it?
> > > > > I don't think it's hard to create it. Just change some registers in the
> > > > > device.
> > > > > 
> > > > > But with the dynamic sgl allocation that I added recently, there is no
> > > > > problem with this scenario.
> > > > Well the problem is device says it can't handle such large descriptors,
> > > > I guess it works anyway, but it seems scary.
> > > I don't follow.
> > > 
> > > The only problem this patch solves is when a virtio blk device reports
> > > larger value for max_discard_segments than max_segments.
> > > 
> > No, the peroblem reported is when virtio blk device reports
> > max_segments < 256 but not max_discard_segments.
> 
> You mean the code will work in case device report max_discard_segments  >
> max_segments ?
> 
> I don't think so.

I think it's like this:


        if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {

		....

                virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
                             &v);
                blk_queue_max_discard_segments(q,
                                               min_not_zero(v,
                                                            MAX_DISCARD_SEGMENTS));

	}

so, IIUC the case is of a device that sets max_discard_seg to 0.

Which is kind of broken, but we handled this since 2018 so I guess
we'll need to keep doing that.


> This is exactly what Xie Yongji mention in the commit message and what I was
> seeing.
> 
> But the code will work if VIRTIO_BLK_F_DISCARD is not supported by the
> device (even if max_segments < 256) , since blk layer set
> queue_max_discard_segments = 1 in the initialization.
> 
> And the virtio-blk driver won't change it unless VIRTIO_BLK_F_DISCARD is
> supported.
> 
> > I would expect discard to follow max_segments restrictions then.
> > 
> > > Probably no such devices, but we need to be prepared.
> > Right, question is how to handle this.
> > 
> > > > > This commit looks good to me, thanks Xie Yongji.
> > > > > 
> > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > 
> > > > > > > To fix it, let's simply
> > > > > > > remove the BUG_ON() which has become unnecessary after commit
> > > > > > > 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
> > > > > > > And the unused vblk->sg_elems can also be removed together.
> > > > > > > 
> > > > > > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > > > > > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > > ---
> > > > > > >     drivers/block/virtio_blk.c | 10 +---------
> > > > > > >     1 file changed, 1 insertion(+), 9 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > > > index c443cd64fc9b..a43eb1813cec 100644
> > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > @@ -76,9 +76,6 @@ struct virtio_blk {
> > > > > > >     	 */
> > > > > > >     	refcount_t refs;
> > > > > > > -	/* What host tells us, plus 2 for header & tailer. */
> > > > > > > -	unsigned int sg_elems;
> > > > > > > -
> > > > > > >     	/* Ida index - used to track minor number allocations. */
> > > > > > >     	int index;
> > > > > > > @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > > > > > >     	blk_status_t status;
> > > > > > >     	int err;
> > > > > > > -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > > > > > -
> > > > > > >     	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> > > > > > >     	if (unlikely(status))
> > > > > > >     		return status;
> > > > > > > @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > > > > >     	/* Prevent integer overflows and honor max vq size */
> > > > > > >     	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
> > > > > > > -	/* We need extra sg elements at head and tail. */
> > > > > > > -	sg_elems += 2;
> > > > > > >     	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> > > > > > >     	if (!vblk) {
> > > > > > >     		err = -ENOMEM;
> > > > > > > @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > > > > >     	mutex_init(&vblk->vdev_mutex);
> > > > > > >     	vblk->vdev = vdev;
> > > > > > > -	vblk->sg_elems = sg_elems;
> > > > > > >     	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> > > > > > > @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > > > > >     		set_disk_ro(vblk->disk, 1);
> > > > > > >     	/* We can handle whatever the host told us to handle. */
> > > > > > > -	blk_queue_max_segments(q, vblk->sg_elems-2);
> > > > > > > +	blk_queue_max_segments(q, sg_elems);
> > > > > > >     	/* No real sector limit. */
> > > > > > >     	blk_queue_max_hw_sectors(q, -1U);
> > > > > > > -- 
> > > > > > > 2.20.1

