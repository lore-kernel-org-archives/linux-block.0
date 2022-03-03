Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E59DC433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 07:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiCCHXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 02:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCCHXN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 02:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50CB91C119
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 23:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646292147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDFPItTCDUnDzD48ZKfCOgOAERl5mtbUoXGLlNyuCC8=;
        b=WbDb3Y4QNXrqCeesJgyWXPmdO7kTWq+4DbPvWPnvnoo4fKnSHWIG5zAt73Gp87oFAcBcRG
        gkv3u/FHgTH5rmARWfeQ6kGz32xXmp9RLq8V7NrbAv+dEZP6+ui6UZCylUnTcFDMLTqPGY
        T60fF3pnoZWQPZ4tw8Wz9dsGdhKN5a0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-BQpZvHoHNO-6IMl5euUnww-1; Thu, 03 Mar 2022 02:22:26 -0500
X-MC-Unique: BQpZvHoHNO-6IMl5euUnww-1
Received: by mail-wm1-f70.google.com with SMTP id 10-20020a1c020a000000b0037fae68fcc2so2849754wmc.8
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 23:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDFPItTCDUnDzD48ZKfCOgOAERl5mtbUoXGLlNyuCC8=;
        b=TOvAdDNSimcUEAq6KyKX8dYpdkIr02anT7sEQdU6KYGF+GFA4irb7HxVIjSZCEnqk7
         xr/x/GWfagWWDeYy5KEr+sqt0y6LID2mfvSZmmyO+JJeTqE1+7Q3s4dOeNlK/mQB3Xcg
         BcJik9UN+P4EvgPJMZ6HO3zxH2s0eUqd7zloLvWS3F5cMI9J9jYeufl14V2pREzYc3sQ
         3Jy2CZQZa0xIR6h3Aljzb202aKGExdr3zkLEaY1L/vyaWviBoJeBS9fGW8Sf8jGaH7M+
         GMHOubOh2tJeizsE1tg07LpHcKiTBTzHt2ZMLTHvGh/RjoLquXYhMg/n9nWqj0co5nY4
         Ct4w==
X-Gm-Message-State: AOAM530sCiY7UcBbRJbSFLIXSmY8aYB0is/jYRpL7vBvNa3fnGAOaL6g
        InZrz8NU47t3syZeC1iWaFw3H6rFyXYFXE36ozJ7o4GUWIj0JaWhf8tOT7DXL5/5ID0wVQjiIA6
        7J4qh+n/kvGWGeNUTHOuvrR4=
X-Received: by 2002:a5d:64af:0:b0:1ef:6070:2297 with SMTP id m15-20020a5d64af000000b001ef60702297mr21871841wrp.609.1646292145137;
        Wed, 02 Mar 2022 23:22:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDOWNrHymY+lG7AWIGKBnT14vPEi71FuUfqXiT0gn+BMNgMa2PgpV650Wbvx5TV+C1spWR5g==
X-Received: by 2002:a5d:64af:0:b0:1ef:6070:2297 with SMTP id m15-20020a5d64af000000b001ef60702297mr21871826wrp.609.1646292144926;
        Wed, 02 Mar 2022 23:22:24 -0800 (PST)
Received: from redhat.com ([2.55.143.133])
        by smtp.gmail.com with ESMTPSA id k15-20020adff5cf000000b001e4b8fde355sm1128053wrp.73.2022.03.02.23.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 23:22:24 -0800 (PST)
Date:   Thu, 3 Mar 2022 02:22:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220303021637-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
 <20220302081017-mutt-send-email-mst@kernel.org>
 <8fa47a28-a974-4478-23b6-aea14355a315@nvidia.com>
 <CACycT3ubdASWTW3UN4Wxg2iYnXRaMkrfHty0p6h1E0EYPF82Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3ubdASWTW3UN4Wxg2iYnXRaMkrfHty0p6h1E0EYPF82Yw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 03, 2022 at 11:31:35AM +0800, Yongji Xie wrote:
> On Wed, Mar 2, 2022 at 11:05 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >
> >
> > On 3/2/2022 3:15 PM, Michael S. Tsirkin wrote:
> > > On Wed, Mar 02, 2022 at 06:46:03PM +0800, Yongji Xie wrote:
> > >> On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > >>>> Currently we have a BUG_ON() to make sure the number of sg
> > >>>> list does not exceed queue_max_segments() in virtio_queue_rq().
> > >>>> However, the block layer uses queue_max_discard_segments()
> > >>>> instead of queue_max_segments() to limit the sg list for
> > >>>> discard requests. So the BUG_ON() might be triggered if
> > >>>> virtio-blk device reports a larger value for max discard
> > >>>> segment than queue_max_segments().
> > >>> Hmm the spec does not say what should happen if max_discard_seg
> > >>> exceeds seg_max. Is this the config you have in mind? how do you
> > >>> create it?
> > >>>
> > >> One example: the device doesn't specify the value of max_discard_seg
> > >> in the config space, then the virtio-blk driver will use
> > >> MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
> > >> BUG_ON() if the seg_max is less than 256.
> > >>
> > >> While the spec didn't say what should happen if max_discard_seg
> > >> exceeds seg_max, it also doesn't explicitly prohibit this
> > >> configuration. So I think we should at least not panic the kernel in
> > >> this case.
> > >>
> > >> Thanks,
> > >> Yongji
> > > Oh that last one sounds like a bug, I think it should be
> > > min(MAX_DISCARD_SEGMENTS, seg_max)
> > >
> > > When max_discard_seg and seg_max both exist, that's a different question. We can
> > > - do min(max_discard_seg, seg_max)
> > > - fail probe
> > > - clear the relevant feature flag
> > >
> > > I feel we need a better plan than submitting an invalid request to device.
> >
> > We should cover only for a buggy devices.
> >
> > The situation that max_discard_seg > seg_max should be fine.
> >
> > Thus the bellow can be added to this patch:
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index c443cd64fc9b..3e372b97fe10 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -926,8 +926,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> >                  virtio_cread(vdev, struct virtio_blk_config,
> > max_discard_seg,
> >                               &v);
> >                  blk_queue_max_discard_segments(q,
> > -                                              min_not_zero(v,
> > - MAX_DISCARD_SEGMENTS));
> > +                                              min_t(u32, (v ? v :
> > sg_elems),
> > + MAX_DISCARD_SEGMENTS));
> >
> >                  blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> >          }
> >
> >
> 
> LGTM, I can add this in v3.
> 
> Thanks,
> Yongji

Except the logic is convoluted then.  I would instead add

	/* max_seg == 0 is out of spec but we always handled it */
	if (!v)
		v = sg_elems;


-- 
MST

