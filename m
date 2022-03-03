Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6565C433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 03:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiCCDcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 22:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCCDce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 22:32:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC511D798
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 19:31:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i11so4860515eda.9
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 19:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDmqEl8g94be2Aujv7w5OVxFMBvJ7E/+DDgi8jtXbK4=;
        b=dujNAGDOSWfzme5yj8Avp0TCcVq3gHjdtKhUTiOa0A8e2d0xvPnK7jzgmL6VP3WJ4+
         ZQKP8H040InhzhTY2aAegUUKNPishvUWGnQcdovBc1pBj+VnJZfYsIA72gjCllsybjI4
         PjZUmV/uQOBEcqB6C+B7IOzLjoQN5XqXmMDuEl6F+ihTEghbdBrH7/RzQzAEU/9sJvr+
         8LTosezzTkh2QlICTMKC5OpL2dnPMQdXGaYODYxGuKLytGQWxJwXQMADBmj2MgOqSzDE
         Fbltb7idne+/rVnk0MC5jOSkaY27vEghxjNpPSnQl47lGhgxtfWYNBekKoN8/v1CHoC4
         7HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDmqEl8g94be2Aujv7w5OVxFMBvJ7E/+DDgi8jtXbK4=;
        b=qGcbwp5VUeEj+d0HEzX3gfUeARR5Au/c5nO9wxMFxxqLgYvXz2zyRO50YIGfwkBgyL
         Rzqzogbzg+jRGjS/+E03EZ5cpePnUZjBgvloFk9QfMlA9/kOus6GpBgWRWltIT9KXDuc
         pF4Wqzvol2d8Ei2DIue6JUcHXbZAbcwX1peNkfr83q1HYDcK/3cFVHMN7vv8/RsoH+em
         tZS4DEzUOKBNPmt6DHhicLCp078+5NToqNZyroFAfAoTJ0Xcp0Z6t3oINJwHN23zVANe
         txdzN26HTujPo9MWYkfebMJBkBmJ0LEkLuuAZ+4QajjFXdcRBrw+feOyD0ZzgXM8jB6V
         SU3A==
X-Gm-Message-State: AOAM533B9/hLghGNFhS5/j8oFnEdmk3MT8Wwa37Fr+Qrl0otzQoxhs1M
        Z+ucVFB3ROKfsoDm5dZigCTb/K3BcwanbAXpzzb2hmGvJQ==
X-Google-Smtp-Source: ABdhPJxP8B5ny7nhFRp4S7DP7xjG6HoBSmEvx4tPiXCLsUQSavN+yRY65rF/VjjoszhkMDNWtGsDv5vLWMXvcgJ2rwg=
X-Received: by 2002:a50:fe08:0:b0:40f:932a:47b0 with SMTP id
 f8-20020a50fe08000000b0040f932a47b0mr32521948edt.64.1646278306932; Wed, 02
 Mar 2022 19:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20220228065720.100-1-xieyongji@bytedance.com> <20220301104039-mutt-send-email-mst@kernel.org>
 <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
 <20220302081017-mutt-send-email-mst@kernel.org> <8fa47a28-a974-4478-23b6-aea14355a315@nvidia.com>
In-Reply-To: <8fa47a28-a974-4478-23b6-aea14355a315@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 3 Mar 2022 11:31:35 +0800
Message-ID: <CACycT3ubdASWTW3UN4Wxg2iYnXRaMkrfHty0p6h1E0EYPF82Yw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 2, 2022 at 11:05 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 3/2/2022 3:15 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 06:46:03PM +0800, Yongji Xie wrote:
> >> On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> >>>> Currently we have a BUG_ON() to make sure the number of sg
> >>>> list does not exceed queue_max_segments() in virtio_queue_rq().
> >>>> However, the block layer uses queue_max_discard_segments()
> >>>> instead of queue_max_segments() to limit the sg list for
> >>>> discard requests. So the BUG_ON() might be triggered if
> >>>> virtio-blk device reports a larger value for max discard
> >>>> segment than queue_max_segments().
> >>> Hmm the spec does not say what should happen if max_discard_seg
> >>> exceeds seg_max. Is this the config you have in mind? how do you
> >>> create it?
> >>>
> >> One example: the device doesn't specify the value of max_discard_seg
> >> in the config space, then the virtio-blk driver will use
> >> MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
> >> BUG_ON() if the seg_max is less than 256.
> >>
> >> While the spec didn't say what should happen if max_discard_seg
> >> exceeds seg_max, it also doesn't explicitly prohibit this
> >> configuration. So I think we should at least not panic the kernel in
> >> this case.
> >>
> >> Thanks,
> >> Yongji
> > Oh that last one sounds like a bug, I think it should be
> > min(MAX_DISCARD_SEGMENTS, seg_max)
> >
> > When max_discard_seg and seg_max both exist, that's a different question. We can
> > - do min(max_discard_seg, seg_max)
> > - fail probe
> > - clear the relevant feature flag
> >
> > I feel we need a better plan than submitting an invalid request to device.
>
> We should cover only for a buggy devices.
>
> The situation that max_discard_seg > seg_max should be fine.
>
> Thus the bellow can be added to this patch:
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b..3e372b97fe10 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -926,8 +926,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>                  virtio_cread(vdev, struct virtio_blk_config,
> max_discard_seg,
>                               &v);
>                  blk_queue_max_discard_segments(q,
> -                                              min_not_zero(v,
> - MAX_DISCARD_SEGMENTS));
> +                                              min_t(u32, (v ? v :
> sg_elems),
> + MAX_DISCARD_SEGMENTS));
>
>                  blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
>          }
>
>

LGTM, I can add this in v3.

Thanks,
Yongji
