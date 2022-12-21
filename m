Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616ACC4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 03:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiLUDYw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 22:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiLUDYv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 22:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4ED13E02
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 19:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671593044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGspaHzQPxqTwdTzEM+6CxFY6yjXuHAKATnBqhR/cIw=;
        b=ItIf7A/kSmEM080v167pyAImRjonYafxaH8lttBz4NKhzR53v2T1HrS1KaNUWm/YMlFBfS
        oSNi0N55HR6pjh+It/i6xOWLmocd6R6mqCBF4To71/3G7UswBhlmm+somh9y470a1VPmdm
        aq2II+lWqmIBszNOy6mtiVP9dWDhdnQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-T91siB0PMyStkIMrhEHiWA-1; Tue, 20 Dec 2022 22:24:03 -0500
X-MC-Unique: T91siB0PMyStkIMrhEHiWA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1447ffe6046so6264143fac.3
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 19:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGspaHzQPxqTwdTzEM+6CxFY6yjXuHAKATnBqhR/cIw=;
        b=z728+Tiktas+icFoY4Wzzu9+M/nQaQNjFMwV3uZgqprbk+CQ6C3uAifIlwIAl654Ri
         XnPinVLodoOV6p/Usd+2L9Qh7OMrtWn4u433ZD9h6Mn0LeQdika2s2NW+WSXYAIt6P2e
         u+Vlyl55VUmu6tPHQsGVnQHoPlw+EGmI4gzzy/22zFXlZQl5LhFLnYiB/Hm+tHl8gSGz
         YbQ9593egDA8KaKnDdjiMa0BYwT5Lhw4AVseobKkzVmPg0Ru0ScfzbgcF9D4VmJM/3a2
         k6LnDkivxtrJ2khz4gYeRNBZzkw5LaLugZFdGOFCfu2sEwnUkshRf6IOvEPRwXYnp7hV
         nyuQ==
X-Gm-Message-State: AFqh2kplBUSuK6OUeXSYleJT3FPxRyTwwums6nk5et9RhxT+bS9XPYNc
        Dlnq+0M7p/vLmWk61TMqzIpA1N+1PhcXM3hHElW6gPDEU46G9jBj//IKD9kxCF0NPQoqfbYGXEU
        J1vER31W3RHp4/gjbb0VJ+aRS5R/ZaiQ9bWzoQec=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id c3-20020a9d7843000000b006781eb43406mr25000otm.237.1671593042446;
        Tue, 20 Dec 2022 19:24:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu6qY57e2GgcRHWrfthleF4uh/gauFFEArM3SE5nEJmGcPQ8lmsJLiuqe4JznhtR/YQJA67yWVZFf3UWvSworo=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr24997otm.237.1671593042237; Tue, 20 Dec
 2022 19:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20221220112340.518841-1-mst@redhat.com>
In-Reply-To: <20221220112340.518841-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 21 Dec 2022 11:23:51 +0800
Message-ID: <CACGkMEvwwBSkeUaOJKYB2VTc0HT60sWfLFSNwcrEzyDWu9Aj2g@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 20, 2022 at 7:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
> is excluded from array of driver features.
> As a result virtio_has_feature panics in virtio_check_driver_offered_feature
> since that by design verifies that a feature we are checking for
> is listed in the feature array.
>
> To fix, replace the call to virtio_has_feature with a stub.
>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/block/virtio_blk.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 88b3639f8536..5ea1dc882a80 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -760,6 +760,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>         return ret;
>  }
>
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +       return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
> +}
>  #else
>
>  /*
> @@ -775,6 +779,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  {
>         return -EOPNOTSUPP;
>  }
> +
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>
>  /* return id (s/n) string for *disk to *id_str
> @@ -1480,7 +1489,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>         virtblk_update_capacity(vblk, false);
>         virtio_device_ready(vdev);
>
> -       if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +       if (virtblk_has_zoned_feature(vdev)) {
>                 err = virtblk_probe_zoned_device(vdev, vblk, q);
>                 if (err)
>                         goto out_cleanup_disk;
> --
> MST
>

