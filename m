Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE85FC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 13:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbiCBNz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiCBNzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 08:55:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623DCA71E
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 05:53:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so3861443ejc.9
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCCSfRJDnXWOkNDwW72f3MN8R37EnnYbFY8Wl4Di/bQ=;
        b=3WV9mTimTinyzLjmo8r1K9HD+/zbmnjroLSnRZ+J9q1WiMAAPCYhhiSgiK+mnUtHa+
         FX0ie/KxPNPmj3kycEhG6qzMz5fJBLyTOF9q/oLgtdWvkUVfRjvxTQo900L036XGR1wk
         T+EOsyEX2y3CkAz/UecImcpdyxxsbLxCvV/R3XiTw0byAvs+P39OXyGwT3fsROxFItcC
         6W1g9aFWHw2wYIDI7bNnI7Ml6W+WwpACCcJmzG4stHmjD2lHl8gJtkVRIIVp8Xa6VBAP
         NNUHLZ7aq0hxR/zThH+OMBbZYbC2E3hdeymj8Y5ByISV8VVfmniXFmuWZrgZ2W7HM2Xa
         X7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCCSfRJDnXWOkNDwW72f3MN8R37EnnYbFY8Wl4Di/bQ=;
        b=ceCsA/AHkGbmGVUnmVuazPiQI7H7ATMuM+7mnYp7WG/DsENclbvABYUYu6/TmZbOfL
         YPjfol5SpIbIVNeic5x1a80o4d4pRxle3zUCoEmX5REFP6pqekmFE9lJR++IbN4Et0Oc
         EJu2x8Jc760AUBf8tv84htk2RwV6R8ueaIhlQ9h4QdxM2o3PkjHQ3mEi5HV6/d279vUD
         1ehwYW0ZDq6fgCfWS/4wwneCLiEByJDBhOkPMC3LsMRFjHPR0nApim984ProX6c6tyEJ
         SvRW/sqYclJUerEVbBpd6jSDs/0OeWz8Qp37ktorX6ZMHhwNNuJJKWQjvxwYjSt1bSKm
         a9jg==
X-Gm-Message-State: AOAM531gaqhyMqDmgmZ7qinHsq6/4RHEW6+6h6dgGoWTtLebrGgzbaLF
        nAUXg2t4ZjIwnDL7uUbejjIZaIUomSu3to3qwhmA
X-Google-Smtp-Source: ABdhPJwdQFZGKVuGc1bd8h8/1g9ClJ1bYWZ4K7b34lr/We363Rb5gYLoiOIWvK2ZPT7pbNa3F6enZHxpnSu9MGHb5rs=
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id
 o14-20020a170906974e00b006bb4f90a6aemr23569009ejy.452.1646229208514; Wed, 02
 Mar 2022 05:53:28 -0800 (PST)
MIME-Version: 1.0
References: <20220228065720.100-1-xieyongji@bytedance.com> <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com> <20220302081542-mutt-send-email-mst@kernel.org>
 <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com> <20220302083112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220302083112-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 2 Mar 2022 21:53:17 +0800
Message-ID: <CACycT3uJFNof7UNTdrEK2dVB-W9q4VVkVWnjos6TJawSRF+EDA@mail.gmail.com>
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

On Wed, Mar 2, 2022 at 9:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
> >
> > On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
> > > On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> > > > On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > > > > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > > > > Currently we have a BUG_ON() to make sure the number of sg
> > > > > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > > > > However, the block layer uses queue_max_discard_segments()
> > > > > > instead of queue_max_segments() to limit the sg list for
> > > > > > discard requests. So the BUG_ON() might be triggered if
> > > > > > virtio-blk device reports a larger value for max discard
> > > > > > segment than queue_max_segments().
> > > > > Hmm the spec does not say what should happen if max_discard_seg
> > > > > exceeds seg_max. Is this the config you have in mind? how do you
> > > > > create it?
> > > > I don't think it's hard to create it. Just change some registers in the
> > > > device.
> > > >
> > > > But with the dynamic sgl allocation that I added recently, there is no
> > > > problem with this scenario.
> > > Well the problem is device says it can't handle such large descriptors,
> > > I guess it works anyway, but it seems scary.
> >
> > I don't follow.
> >
> > The only problem this patch solves is when a virtio blk device reports
> > larger value for max_discard_segments than max_segments.
> >
>
> No, the peroblem reported is when virtio blk device reports
> max_segments < 256 but not max_discard_segments.
> I would expect discard to follow max_segments restrictions then.
>

I think one point is whether we want to allow the corner case that the
device reports a larger value for max_discard_segments than
max_segments. For example, queue size is 256, max_segments is 128 - 2,
max_discard_segments is 256 - 2.

Thanks,
Yongji
