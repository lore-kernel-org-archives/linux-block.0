Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1267DC433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 02:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLCbW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 22:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLCbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 22:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA546DB2
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665541877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWHqsdrdeOUECP7iiSQMbg1019god1/+rH/feXS+ZMo=;
        b=MOAiBq/CCwLymuOctqyy/GMKH2QIiX2L4YS8TfjmR4SqYr3xSdh2QDROewvOUfiwLpYCbX
        z8RghguB0ETdxfieezsbi0ER+77cbBUU14jGb0FEAqSfOpvG4MjzDOyE+A3mJ62UrrwZ0K
        m1pt5O4d8zc/sepLWVFMy2hzaeyejrg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-pobGT8oWOoqh4eW1dHFYvA-1; Tue, 11 Oct 2022 22:31:16 -0400
X-MC-Unique: pobGT8oWOoqh4eW1dHFYvA-1
Received: by mail-oo1-f71.google.com with SMTP id u5-20020a4a6145000000b0047f8391678cso8766423ooe.14
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 19:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWHqsdrdeOUECP7iiSQMbg1019god1/+rH/feXS+ZMo=;
        b=cBMDewXJbrQa57tc6eLKy4lTpdfyoR/ahCTGglG23S94O+BaUOk8X1QQu7S1Gg1bIK
         nxu9ocGVGWo8GI2AjYvuSqf2wL9ydGoRE3enbUBlm2CsTljEzBKxIXRKFGg5aSushCna
         JyM4IouNrVwbfXSEYguHJVRVyNnZYkTbkq1dN1/BL0aSgqsDdahKG+5Nz8PR6KwDUw3D
         Hcyv1SaYhPMT3FNlELUIZxB3ODE4i6e2hdiRlmO98C620DnG1DvMuYl+h6ZL2ZztE+e2
         V9EGnLgkrrPYOQMQzVVXfyKl3B9VIiozrRyjPdX4CwU3JQbdglaeyuiqnaf8VeSfKq6W
         pnUw==
X-Gm-Message-State: ACrzQf0sdkoB5dVsVrs0XPHxAMclQ+hLpEXZAumP/9jhjqKAeq0rE9qZ
        qHCQEMcqk0AW/X9UJeDVyXXSOy5HAR08vApbSCIHM2ghQ0dlRThMD5XegMe+AUNcElnWfhUmD8A
        XM5mqW6q1zIEJpCMPJ8sYCkOR9kHz00xGXgbDkN8=
X-Received: by 2002:a05:6830:4387:b0:661:8d25:2c95 with SMTP id s7-20020a056830438700b006618d252c95mr8786161otv.201.1665541875830;
        Tue, 11 Oct 2022 19:31:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64wOhjhRqsyVIZiDQrcHkTTgscLTPNc5Vz2BbwcUYAMAPP7wJwY8RgzN/KjKOtdYXPnk8GQUsp1qFYCd73vDM=
X-Received: by 2002:a05:6830:4387:b0:661:8d25:2c95 with SMTP id
 s7-20020a056830438700b006618d252c95mr8786153otv.201.1665541875611; Tue, 11
 Oct 2022 19:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
In-Reply-To: <20220928234008.30302-1-mgurtovoy@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 12 Oct 2022 10:31:04 +0800
Message-ID: <CACGkMEvfivRAwZ1OT13ujChvrJ_=_d8tY6Fg83WP6+kdO4cOGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     mst@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 7:40 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> This is instead of re-writing the same logic in virtio driver.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Acked-by: Jason Wang <Jasowang@redhat.com>


> ---
>  drivers/virtio/virtio_pci_common.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ad258a9d3b9f..67d3970e57f2 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -607,7 +607,6 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>  {
>         struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>         struct virtio_device *vdev = &vp_dev->vdev;
> -       int ret;
>
>         if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>                 return -EBUSY;
> @@ -615,19 +614,7 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>         if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>                 return -EINVAL;
>
> -       if (pci_vfs_assigned(pci_dev))
> -               return -EPERM;
> -
> -       if (num_vfs == 0) {
> -               pci_disable_sriov(pci_dev);
> -               return 0;
> -       }
> -
> -       ret = pci_enable_sriov(pci_dev, num_vfs);
> -       if (ret < 0)
> -               return ret;
> -
> -       return num_vfs;
> +       return pci_sriov_configure_simple(pci_dev, num_vfs);
>  }
>
>  static struct pci_driver virtio_pci_driver = {
> --
> 2.18.1
>

