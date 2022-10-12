Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8131EC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 05:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJLFCh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 01:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLFCg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 01:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8588A99FE
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 22:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665550954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lUdzXlZRbmm8fLOWLU5kjEhw2Wcvma+a+WOCKqncy0w=;
        b=LvWJL7UEYXJrIVc7CXB/me0sX59QtraWb3ftu6ozaHk6QVvg0ezwfb8oovrIOIneE42ag3
        jhfcCkKUthsPPk+S4MH2Lswrm49Kdq907dIXOhXlZzkKRa5ajjbIxDGO4xq9eYMhMoFqR2
        Hk05ayV7fTM9WYIZr6cjRxzqU08fpwc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-K1nFbW1DMBqDO2uiBJGp1Q-1; Wed, 12 Oct 2022 01:02:32 -0400
X-MC-Unique: K1nFbW1DMBqDO2uiBJGp1Q-1
Received: by mail-wm1-f72.google.com with SMTP id v23-20020a1cf717000000b003bff630f31aso150371wmh.5
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 22:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUdzXlZRbmm8fLOWLU5kjEhw2Wcvma+a+WOCKqncy0w=;
        b=ZmZCMp8oi/LdlqyJGVH+V6h2NuUZs1l8Ar7Kb56vNP1qHSIt+4C8eD8r+9JtD2D7+M
         aSOa5n8DZ2hPBqaKxoDoFgB3iTqLCWbOVe4g6CM9ocYYDNwmk7bsd5MGbhD22iXMfhno
         kjvkWFOsJUx8BYOMVWE8NAK8ShVL+v89kGMU1vMXeEmA+mqp4OHsFN7ym+1o2BzO90nj
         zPAPVFqeQuABeQ65n4w0N+os9fIJ3UV1QtY+MxEufQHLyOUeWUmtSG4NzEbmYDSFoCrP
         Xqck36EXrHrTrOsr9nC12jfOnGu6aSSCzOgkgqpRDDb/3ilR30H2w6J9lTV+2IkaDh5v
         qn9Q==
X-Gm-Message-State: ACrzQf066Z4nOrDr22Fi5dZc3CNQP6AO+BGm+NVpeuMWeulfzCLUrIVo
        q1l+ultqS4WGpxILMcaPa8bvoeHF2YK8KUFwCwqWz5f+bTAO7MNmlwyiLthqNuKEuKMTkv56rQM
        un+4+AaCH3Yc2aloN70FBjd4=
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id hg24-20020a05600c539800b003c3dccf2362mr1446656wmb.89.1665550951589;
        Tue, 11 Oct 2022 22:02:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43nJw2V0KYBPwQaTZ96tpYNyEooqrzualAwt0QthTQBlgIdKki5aOgTWjuEDbQb+l61Dez7g==
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id hg24-20020a05600c539800b003c3dccf2362mr1446644wmb.89.1665550951350;
        Tue, 11 Oct 2022 22:02:31 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b003c452678025sm764640wmm.4.2022.10.11.22.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 22:02:30 -0700 (PDT)
Date:   Wed, 12 Oct 2022 01:02:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Message-ID: <20221012010143-mutt-send-email-mst@kernel.org>
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928234008.30302-1-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
> This is instead of re-writing the same logic in virtio driver.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Dropped this as it caused build failures:

https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com

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
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct virtio_device *vdev = &vp_dev->vdev;
> -	int ret;
>  
>  	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>  		return -EBUSY;
> @@ -615,19 +614,7 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>  	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>  		return -EINVAL;
>  
> -	if (pci_vfs_assigned(pci_dev))
> -		return -EPERM;
> -
> -	if (num_vfs == 0) {
> -		pci_disable_sriov(pci_dev);
> -		return 0;
> -	}
> -
> -	ret = pci_enable_sriov(pci_dev, num_vfs);
> -	if (ret < 0)
> -		return ret;
> -
> -	return num_vfs;
> +	return pci_sriov_configure_simple(pci_dev, num_vfs);
>  }
>  
>  static struct pci_driver virtio_pci_driver = {
> -- 
> 2.18.1

