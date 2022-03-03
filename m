Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE0AC433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiCCIMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 03:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiCCIMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 03:12:30 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108C170D4B
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 00:11:45 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id r13so8912881ejd.5
        for <linux-block@vger.kernel.org>; Thu, 03 Mar 2022 00:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orkRZU3EYl7nwMmKLkhe9S0vp2TZOXRxGLBEKEhgY6c=;
        b=fM1P81UfzeKjinHaRL6xGyT1jTG2itYotri3MnueeEwo1j31+EZX92M+0BMJgasO7p
         o/ThD1MFuaqA+KYAr7h8RlZibpBanRfGe8i2FrnXT6uHTaYj3gbN+ZoQl1edEUyldqsf
         TJRB34qIuH1kgu9+ux/urShvoBXBCMSFKoWeEKctRqgaNxFbd4WmBvATMEdygzP494aO
         U9M1bvowRycY8IRKTdmP1XdW4nlkkbNzGjtwzajSMZvN/00nKrf5EUPNuaLndxF71+SO
         xNLNq00pfaNQjjK9q1YXWAXhGYS2Q3NFlEisY5xMDbosku5YQs4utofoSIh4ZT5xIS5C
         po9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orkRZU3EYl7nwMmKLkhe9S0vp2TZOXRxGLBEKEhgY6c=;
        b=8Nv2rlbOJdJrlJtsFnucD/UVP/Dp2ydOP5nKljDSpLD9JBpfpg1Lm/ktISoNI53HqC
         QNdKkqsDzgGt++WWwU0rGHWOKItgo3yOizjm3xEVJiUJTZgLTBos24t7h9JmxhMsnx06
         aD2Xadk9mCL1/AZCLqLPJE+UFu3muPLwOQ5R5pICwZRZdXDtDoeXIh3vYMrTz0pskc1l
         FqnH2wEbtqYg2qE+QdL438+aKh6fW1ym1eJpnd4lNPqIDeGPuIb58SvIO+2wknHHk4KZ
         H/xjakA1XNNGhj9H7lxO5oJRD0dhTNq+UmHq2iGp4/DGTU35/fLedwgxP31vggWPbt6a
         D8DA==
X-Gm-Message-State: AOAM531+z5TV7eqQt/AHrRb60P2M6/dUC2Hf4e82eAs9hW3M1JFT/vse
        xD7sA0lcE7PrutVS3FHFcEAZjFPweWKypjYV9/Qw
X-Google-Smtp-Source: ABdhPJw1T/8R2YfsFrTrcJxyoTvP11CgwcdzaMV+GdXCHvHcJ9gE51EBqBM+Kyfb7MJ2qSZkV3n5ETbNA/1J6uzkhRY=
X-Received: by 2002:a17:907:7fa6:b0:6d6:f925:d97 with SMTP id
 qk38-20020a1709077fa600b006d6f9250d97mr8229636ejc.374.1646295103955; Thu, 03
 Mar 2022 00:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20220228065720.100-1-xieyongji@bytedance.com> <20220301104039-mutt-send-email-mst@kernel.org>
 <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
 <20220302081017-mutt-send-email-mst@kernel.org> <8fa47a28-a974-4478-23b6-aea14355a315@nvidia.com>
 <CACycT3ubdASWTW3UN4Wxg2iYnXRaMkrfHty0p6h1E0EYPF82Yw@mail.gmail.com> <20220303021637-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220303021637-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 3 Mar 2022 16:11:33 +0800
Message-ID: <CACycT3sZ506becSGjJZQgoFJUsgVRDPo-+tJrSuEEDHCEjUr5A@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 3, 2022 at 3:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Mar 03, 2022 at 11:31:35AM +0800, Yongji Xie wrote:
> > On Wed, Mar 2, 2022 at 11:05 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> > >
> > >
> > > On 3/2/2022 3:15 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 02, 2022 at 06:46:03PM +0800, Yongji Xie wrote:
> > > >> On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > >>>> Currently we have a BUG_ON() to make sure the number of sg
> > > >>>> list does not exceed queue_max_segments() in virtio_queue_rq().
> > > >>>> However, the block layer uses queue_max_discard_segments()
> > > >>>> instead of queue_max_segments() to limit the sg list for
> > > >>>> discard requests. So the BUG_ON() might be triggered if
> > > >>>> virtio-blk device reports a larger value for max discard
> > > >>>> segment than queue_max_segments().
> > > >>> Hmm the spec does not say what should happen if max_discard_seg
> > > >>> exceeds seg_max. Is this the config you have in mind? how do you
> > > >>> create it?
> > > >>>
> > > >> One example: the device doesn't specify the value of max_discard_seg
> > > >> in the config space, then the virtio-blk driver will use
> > > >> MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
> > > >> BUG_ON() if the seg_max is less than 256.
> > > >>
> > > >> While the spec didn't say what should happen if max_discard_seg
> > > >> exceeds seg_max, it also doesn't explicitly prohibit this
> > > >> configuration. So I think we should at least not panic the kernel in
> > > >> this case.
> > > >>
> > > >> Thanks,
> > > >> Yongji
> > > > Oh that last one sounds like a bug, I think it should be
> > > > min(MAX_DISCARD_SEGMENTS, seg_max)
> > > >
> > > > When max_discard_seg and seg_max both exist, that's a different question. We can
> > > > - do min(max_discard_seg, seg_max)
> > > > - fail probe
> > > > - clear the relevant feature flag
> > > >
> > > > I feel we need a better plan than submitting an invalid request to device.
> > >
> > > We should cover only for a buggy devices.
> > >
> > > The situation that max_discard_seg > seg_max should be fine.
> > >
> > > Thus the bellow can be added to this patch:
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index c443cd64fc9b..3e372b97fe10 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -926,8 +926,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >                  virtio_cread(vdev, struct virtio_blk_config,
> > > max_discard_seg,
> > >                               &v);
> > >                  blk_queue_max_discard_segments(q,
> > > -                                              min_not_zero(v,
> > > - MAX_DISCARD_SEGMENTS));
> > > +                                              min_t(u32, (v ? v :
> > > sg_elems),
> > > + MAX_DISCARD_SEGMENTS));
> > >
> > >                  blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > >          }
> > >
> > >
> >
> > LGTM, I can add this in v3.
> >
> > Thanks,
> > Yongji
>
> Except the logic is convoluted then.  I would instead add
>
>         /* max_seg == 0 is out of spec but we always handled it */
>         if (!v)
>                 v = sg_elems;

Got it.

Thanks,
Yongji
