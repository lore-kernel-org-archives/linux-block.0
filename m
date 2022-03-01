Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B674BC433F5
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 15:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiCAPoE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiCAPn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 10:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72B54A1478
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646149393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zi/rF6ZbstmVPPcLyO+lYHA/xLDgWYDmluRIslmEBwo=;
        b=UYavwnBf64MszjRAMIuiGMaj8lDjjCnSXRlLHYUMVDsNBtxEB+H8MxJQLS/S0lq8wkF8aq
        ouKmvwT+iO3xpTXoc0byfymDVtZPieXDgWV9TEr1G5TV2k/jIgt08OU8D+xjPTm8NAASEp
        LuuC3lcQGVeoipCPCpF2r5CRljVq/xA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-05XQh4KnPzyrvsrMh33OWw-1; Tue, 01 Mar 2022 10:43:12 -0500
X-MC-Unique: 05XQh4KnPzyrvsrMh33OWw-1
Received: by mail-wr1-f69.google.com with SMTP id z16-20020adff1d0000000b001ef7dc78b23so2483234wro.12
        for <linux-block@vger.kernel.org>; Tue, 01 Mar 2022 07:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zi/rF6ZbstmVPPcLyO+lYHA/xLDgWYDmluRIslmEBwo=;
        b=OkWqr8ErslgkfkiW8jPvsXY+BRokD15ZIy+iyadeHxoGEPjI1k3jn4bV5P4ha+B79f
         cWu4iJmWnjlF15LDhpeOele9+1T41HFTt1Bovxzm+FcdMYkP/co1ZymVpbBj9e3f2sD5
         3RYPZr6Py/m+f0NIr/kWRssG+ypyXdBkRXIvYZTBumHre6UQCC2vciTesi6OTQhsijI0
         kS6YDI2zFJtNIXKR16O+oPqO728+QggxUHihdCyqGIodjEoRyC4Ymp71uWY/TFRc2q7u
         MlnLs2IlJB3eXDyedF6XwkfStYHZqlbgDFM8PqfwMbbKe+WELnZo0PEOyKZlVN2KYzWi
         oNJA==
X-Gm-Message-State: AOAM530j3+7oSVnP6KSBqvLGpbtx382Cv+d5IY1FShpG2dNrBPy34L6u
        2OucroHSApHjmJTcSWkQmB5e7D8NphY+Smqt7ipA014ydWymmBaN+QetUW7MqYOWbIu0bc98xyQ
        lXTqjCtJZ1hCrnTaFYc1QK4I=
X-Received: by 2002:a5d:4578:0:b0:1ed:bf30:40f3 with SMTP id a24-20020a5d4578000000b001edbf3040f3mr20424546wrc.669.1646149391305;
        Tue, 01 Mar 2022 07:43:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRUwQD1hJ1u91M2fQsU2xg9R4HN5NlawjsdCEJ846aEK4fDF9wmsyllywQDwwFcvuwBhdJCQ==
X-Received: by 2002:a5d:4578:0:b0:1ed:bf30:40f3 with SMTP id a24-20020a5d4578000000b001edbf3040f3mr20424527wrc.669.1646149391064;
        Tue, 01 Mar 2022 07:43:11 -0800 (PST)
Received: from redhat.com ([2.53.2.184])
        by smtp.gmail.com with ESMTPSA id m62-20020a1c2641000000b00380d0cff5f3sm2966744wmm.8.2022.03.01.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:43:10 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:43:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, axboe@kernel.dk, hch@infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220301104039-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228065720.100-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> Currently we have a BUG_ON() to make sure the number of sg
> list does not exceed queue_max_segments() in virtio_queue_rq().
> However, the block layer uses queue_max_discard_segments()
> instead of queue_max_segments() to limit the sg list for
> discard requests. So the BUG_ON() might be triggered if
> virtio-blk device reports a larger value for max discard
> segment than queue_max_segments().

Hmm the spec does not say what should happen if max_discard_seg
exceeds seg_max. Is this the config you have in mind? how do you
create it?

> To fix it, let's simply
> remove the BUG_ON() which has become unnecessary after commit
> 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
> And the unused vblk->sg_elems can also be removed together.
> 
> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/block/virtio_blk.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b..a43eb1813cec 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -76,9 +76,6 @@ struct virtio_blk {
>  	 */
>  	refcount_t refs;
>  
> -	/* What host tells us, plus 2 for header & tailer. */
> -	unsigned int sg_elems;
> -
>  	/* Ida index - used to track minor number allocations. */
>  	int index;
>  
> @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_status_t status;
>  	int err;
>  
> -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> -
>  	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>  	if (unlikely(status))
>  		return status;
> @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> -	/* We need extra sg elements at head and tail. */
> -	sg_elems += 2;
>  	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
>  	if (!vblk) {
>  		err = -ENOMEM;
> @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	mutex_init(&vblk->vdev_mutex);
>  
>  	vblk->vdev = vdev;
> -	vblk->sg_elems = sg_elems;
>  
>  	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
>  
> @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		set_disk_ro(vblk->disk, 1);
>  
>  	/* We can handle whatever the host told us to handle. */
> -	blk_queue_max_segments(q, vblk->sg_elems-2);
> +	blk_queue_max_segments(q, sg_elems);
>  
>  	/* No real sector limit. */
>  	blk_queue_max_hw_sectors(q, -1U);
> -- 
> 2.20.1

