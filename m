Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF52C4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 21:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJLVVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJLVVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 17:21:13 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AEA6176
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 14:21:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j7so21425839ybb.8
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0TAOYt0oGnHXJ4fG69wmNa3O+s6LMKwU4I9dfo998I=;
        b=V3DVoHb5ufzu84HidBu2j0BgBqiAgtazjj3AjNENKnEWbeYGfOT2Ah2saWsavoUO5Y
         zIvlbnOt6JsKcyi/cxPPnpY2ViF1/IqJo/fXJHwOpqsrXkFUn9tomyezTAwgM2N1B4Aq
         E6PMyHyexVeZQKs0xz5JNcXtAnXFd7CC4ptSFJ90hKbxnpzwCBUaL+5TA8fXp14u1xYi
         vzBkhoHOxmgMwHXqy8OZsudHs8mUgKnF/zsPz19WDYFadUPh5bbzC2/828qHNVPMhEtf
         yJaWr+x3XhGud9xA+cohP52IO7Hbw9rf18wRAccrCE9CJ8eOnSdDhisqgt6A0upuPdKR
         je5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0TAOYt0oGnHXJ4fG69wmNa3O+s6LMKwU4I9dfo998I=;
        b=VH4AX+OLu9Qvf62vR1HNZY5LVljE3JzvUFmP5CEr5lcJlvbLwmmP1v2MZtccWgP+U7
         Ct/ph6KI97d5md43ZvJAZugXU/5DHjogAr//uw/qS+g0UtFN5xFLCK7bjfDDlW1CUu4o
         edaovg0V2FBg/EHmnwxB0CCgexNUajJ4OUHup5dQtSQXPCrzeZODqUIDQIhot5sLViKC
         Ycnwst80sf+/cKmuB1FcPwYECqimOHL5Qw+NL6akcSn//lnOUichwrGp7ROw476AOmFJ
         dE3kKHal0DUPqknFrZoQvlF6i9AVfoy1y7MWaxCDCzgbkPczApAvLJBpkwKichXv+Cic
         B66Q==
X-Gm-Message-State: ACrzQf28Vgdz8Kjo26HNCMsUsjUHvaqFhKlUvJvXIxyDpC4PBfXtIyAv
        1ULR6xGeV3iezOtspadFE1NVm8kV5svxp4A1uiMV
X-Google-Smtp-Source: AMsMyM7eyLb9K0YF56ittS2zxLXFUvVZAswMPgOYhyGxjy9DEdKooIfPez7+UXVuu43fktEwFiCixf8jlqoSXKDC/9Y=
X-Received: by 2002:a25:495:0:b0:6bf:bdc5:3736 with SMTP id
 143-20020a250495000000b006bfbdc53736mr24916261ybe.578.1665609667445; Wed, 12
 Oct 2022 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220928234008.30302-1-mgurtovoy@nvidia.com> <20221012010143-mutt-send-email-mst@kernel.org>
 <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com> <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
In-Reply-To: <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 12 Oct 2022 16:20:56 -0500
Message-ID: <CAErSpo6azrPRAAkENVzXJOTWHCi1PLa8DHJMVKKj_cun8b+K1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 12, 2022 at 5:01 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 10/12/2022 11:42 AM, Max Gurtovoy wrote:
> >
> > On 10/12/2022 8:02 AM, Michael S. Tsirkin wrote:
> >> On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
> >>> This is instead of re-writing the same logic in virtio driver.
> >>>
> >>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> >> Dropped this as it caused build failures:
> >>
> >> https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com
> >
> > maybe you can re-run it with:
> >
> > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > index 8e98d24917cc..b383326a20e2 100644
> > --- a/drivers/virtio/Makefile
> > +++ b/drivers/virtio/Makefile
> > @@ -5,10 +5,11 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> >  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> >  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
> >  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> > -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> > -virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> >  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
> >  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
> >  obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
> >  obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
> >  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> > +
> > +virtio_pci-$(CONFIG_VIRTIO_PCI) := virtio_pci_modern.o
> > virtio_pci_common.o
> > +virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> >
>
> Now I saw that CONFIG_PCI_IOV is not set in the error log so the bellow
> should fix it:
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 060af91bafcd..c519220e8ff8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2228,7 +2228,10 @@ static inline int pci_sriov_set_totalvfs(struct
> pci_dev *dev, u16 numvfs)
>   { return 0; }
>   static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>   { return 0; }
> -#define pci_sriov_configure_simple     NULL
> +static inline int pci_sriov_configure_simple(struct pci_dev *dev, int
> nr_virtfn)
> +{
> +       return -ENOSYS;
> +}
>   static inline resource_size_t pci_iov_resource_size(struct pci_dev
> *dev, int resno)
>   { return 0; }
>   static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool
> probe) { }
>
> Bjorn,
>
> WDYT about the above ?
>
> should I send it to the pci subsystem list ?

Yes.  I don't apply things that haven't appeared on linux-pci@vger.kernel.org.
