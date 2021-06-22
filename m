Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B6C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 11:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38056135F
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 11:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFVLwS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFVLwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 07:52:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D94C061756
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 04:50:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hz1so11517999ejc.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbU3A+j/FG5iAg91a8f8bwvtnCy0uA/d+gF6dETaSVg=;
        b=d0zYt/LlWEAZcBW88+Jx42WFcf1LsNbpablBwlFiU1nxsqTnFFRdy2aPFqUAqS1806
         9w3h2Qg9YTkgjCSnI0bWqYlPVvDVYkVAf0PvO58ZGpN1FUhcVjihZ1PWC7QOeo9SuKN9
         oBOj+AwNMCVZzWIm7wWi1hD7GkH7nsBK+icabGnVs2b4MBGYT3odKcAXaprzY7DeZ6zB
         LHLHCdzlePFKqYIm/nJT7XGXuLE1pwr1WauuKSegdUek4FJxh0VRdaQnrWo47uvbcNsG
         FKPJKTiIFSYyHdDdfZQQH7vpwEQS0aaxnR9X8+dbDUPtqhdvKEaZJyTq1jQ+fx2sg81J
         AWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbU3A+j/FG5iAg91a8f8bwvtnCy0uA/d+gF6dETaSVg=;
        b=ZQZyj4IJ7Sk6jpSQL/qaqZ0E29/Pa8qJXy5pSebQTVMpNZjzBNtDwPRDmNbPUNW9vE
         XZ8TP62j6/au1A6p7xt2uVvoR4l4qEx8RhrDYovufjb+rLmqTNHdNkS0TccjbOglOYJq
         G+t/Prect720I7VSY03XS7NpJ3BirEAEs95UFRCr2EaR52kn8awBG01jH+lCnTmfnzM/
         OYAnLmUtJ6jhF4MFFA0HK0QPIauCazwg2d7bnbpf4iZJySodl4ZwGaD+SRmUPH0TU3J4
         pB/Lskjl7EMS5/KNwUujnyXyVRw3UPSf4jC2T2WiRcCBpYk+osYpCMWYQ2G9+YSLe12P
         AvsA==
X-Gm-Message-State: AOAM531ZBhwPjS1YmmACHT4ZHQC1QEi9E1WHu/sd5wKaAI4r5qnYiKiZ
        WPvu+zNy47IXg750r1RrDWJmC6FymU/cxSRkARk2
X-Google-Smtp-Source: ABdhPJwjJhnt6HHLPJdVrIzl9bkjRQKXLtyVV33ecWzRUTc1f9JbUSH4QFMVDYoFpXOD2cZMBa2QJMgzFRPRQCo/xSI=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr3545896ejz.247.1624362601096;
 Tue, 22 Jun 2021 04:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210617051004.146-1-xieyongji@bytedance.com> <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
In-Reply-To: <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 22 Jun 2021 19:49:50 +0800
Message-ID: <CACycT3tBCbiRFixa4V_d_4kAT7zPz1Eyaxbnv4kUPDrGceJU-g@mail.gmail.com>
Subject: Re: Re: [PATCH v3] virtio-blk: Add validation for block size in
 config space
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 6:11 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Jun 17, 2021 at 01:10:04PM +0800, Xie Yongji wrote:
> > This ensures that we will not use an invalid block size
> > in config space (might come from an untrusted device).
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/block/virtio_blk.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index b9fa3ef5b57c..bbdae989f1ea 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -696,6 +696,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +     u32 blk_size;
> > +
> > +     if (!vdev->config->get) {
> > +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +                     __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +             return 0;
> > +
> > +     blk_size = virtio_cread32(vdev,
> > +                     offsetof(struct virtio_blk_config, blk_size));
> > +
> > +     if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +             __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > +
> > +     return 0;
> > +}
>
> I saw Michael asked for .validate() in v2. I would prefer to keep
> everything in virtblk_probe() instead of adding .validate() because:
>
> - There is a race condition that an untrusted device can exploit since
>   virtblk_probe() fetches the value again.
>

Good point! I agree that it's better to add the validation in virtblk_probe().

Thanks,
Yongji
