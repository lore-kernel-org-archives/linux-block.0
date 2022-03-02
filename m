Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3904CC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 13:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiCBNSS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiCBNSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 08:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C5B713FBA
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646227050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IpoZwqDiyWyouUNfFZ1KMMACwgAnA6JVdey+IK2PuMU=;
        b=gKPhowhEHN/x03Bzt9EAXOc8T2e5PozCPaSBrnW8qz40s43R8Qq5/TsCcn6eeSl+5qYVYS
        nr3ygxrfRKsIT5PshxTzHEWeeSv9p6+ZjX039WrFCBEkdhoV1nBs0HAohKhg3bmu0Ga0LT
        N4Xn5kr1wXy1vvbuzgtzcOTMYUMg+GQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-KLtErDnwNKWXhfC9WCGXUg-1; Wed, 02 Mar 2022 08:17:29 -0500
X-MC-Unique: KLtErDnwNKWXhfC9WCGXUg-1
Received: by mail-wm1-f69.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso386828wme.1
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 05:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IpoZwqDiyWyouUNfFZ1KMMACwgAnA6JVdey+IK2PuMU=;
        b=Z4NT0D/fjndAK1OGFn7LdCtsUZIDgJqsXGUMmMJ/z5XjHlhMkb8J5y+RHj4v4DYuZg
         a1VUC2ExVw+rdOWj/fqo9pQAPjAnRtQB/Xr2CrsK5+oPpcANjRnDd3J8/YlPdlxbTQyT
         YJk94Gj3qDCX95540vySsLxCPZXYmzCdHk63/dNYT2Wd88CgoxfgzZmyLzqOvjPAhQ9z
         wsLRHVTT6CDkPkrgbRBK+F6XwemSl1uvzRFrysrQl6xkP3YKmGPX2q/0MkswlpSNoXIr
         hP0FU+10aaft884ijDaDA2ILpEYL0Di9kFxuJGGMM6IzPYdSGobfChCLtx59F04qHSxq
         ac0w==
X-Gm-Message-State: AOAM533aW2fLcbuSKlwM6wC257FvHvJc+1cQbg6MhcDwVZ4AXMiK5irR
        FM/3/4hvyok1KLd/ZhayAJLlLyRSklBtSAuN+8KApDTyl9x3qAO5c2J2U2nGyhN40zxWi6s7w5A
        /xtcKMRIcLBYiNIo7yyXhlh8=
X-Received: by 2002:a05:6000:1883:b0:1f0:44f6:4bc0 with SMTP id a3-20020a056000188300b001f044f64bc0mr1550993wri.659.1646227047892;
        Wed, 02 Mar 2022 05:17:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbot4giXhot64z2wqmSUyiUo5F/crURpMZGOqzGXQd0aA2SQbWCMa1E2G7Iwrvrk+r1P4Wgw==
X-Received: by 2002:a05:6000:1883:b0:1f0:44f6:4bc0 with SMTP id a3-20020a056000188300b001f044f64bc0mr1550979wri.659.1646227047692;
        Wed, 02 Mar 2022 05:17:27 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5228000000b001ea76210986sm16329531wra.58.2022.03.02.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:17:27 -0800 (PST)
Date:   Wed, 2 Mar 2022 08:17:24 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
        axboe@kernel.dk, hch@infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302081542-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> 
> On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > Currently we have a BUG_ON() to make sure the number of sg
> > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > However, the block layer uses queue_max_discard_segments()
> > > instead of queue_max_segments() to limit the sg list for
> > > discard requests. So the BUG_ON() might be triggered if
> > > virtio-blk device reports a larger value for max discard
> > > segment than queue_max_segments().
> > Hmm the spec does not say what should happen if max_discard_seg
> > exceeds seg_max. Is this the config you have in mind? how do you
> > create it?
> 
> I don't think it's hard to create it. Just change some registers in the
> device.
> 
> But with the dynamic sgl allocation that I added recently, there is no
> problem with this scenario.

Well the problem is device says it can't handle such large descriptors,
I guess it works anyway, but it seems scary.

> This commit looks good to me, thanks Xie Yongji.
> 
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> 
> > > To fix it, let's simply
> > > remove the BUG_ON() which has become unnecessary after commit
> > > 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
> > > And the unused vblk->sg_elems can also be removed together.
> > > 
> > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 10 +---------
> > >   1 file changed, 1 insertion(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index c443cd64fc9b..a43eb1813cec 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -76,9 +76,6 @@ struct virtio_blk {
> > >   	 */
> > >   	refcount_t refs;
> > > -	/* What host tells us, plus 2 for header & tailer. */
> > > -	unsigned int sg_elems;
> > > -
> > >   	/* Ida index - used to track minor number allocations. */
> > >   	int index;
> > > @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > >   	blk_status_t status;
> > >   	int err;
> > > -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > -
> > >   	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> > >   	if (unlikely(status))
> > >   		return status;
> > > @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >   	/* Prevent integer overflows and honor max vq size */
> > >   	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
> > > -	/* We need extra sg elements at head and tail. */
> > > -	sg_elems += 2;
> > >   	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> > >   	if (!vblk) {
> > >   		err = -ENOMEM;
> > > @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >   	mutex_init(&vblk->vdev_mutex);
> > >   	vblk->vdev = vdev;
> > > -	vblk->sg_elems = sg_elems;
> > >   	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> > > @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >   		set_disk_ro(vblk->disk, 1);
> > >   	/* We can handle whatever the host told us to handle. */
> > > -	blk_queue_max_segments(q, vblk->sg_elems-2);
> > > +	blk_queue_max_segments(q, sg_elems);
> > >   	/* No real sector limit. */
> > >   	blk_queue_max_hw_sectors(q, -1U);
> > > -- 
> > > 2.20.1

