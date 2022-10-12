Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA10C433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJLXTM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 19:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJLXTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 19:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1850012C896
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665616750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yE7HqDJx889u7pqiqqMRvQDmULGHmUZUd5wFAOQCgDQ=;
        b=ThZpLESQQ2Ff7BtMing2tKf3z1aV/14mLkTErvAkXUtjXvoZcyuinJNw+k4oN0zNujFPHd
        SAe8wNOKizu4MpofZmbMonSI5Y4mknUsQC16zD36azwNOgrqCAjkrFcNsDwYTBwmSQpsjX
        xDHgPKOV84sSjAjpgC6pHcHTH7+/R6E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-VhFV8OjLMcWDt0-FGzL-kw-1; Wed, 12 Oct 2022 19:19:08 -0400
X-MC-Unique: VhFV8OjLMcWDt0-FGzL-kw-1
Received: by mail-wm1-f70.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso153724wmj.1
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 16:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE7HqDJx889u7pqiqqMRvQDmULGHmUZUd5wFAOQCgDQ=;
        b=NmY+6v1z/BgrLQooGrnvYjBXv0NuSz/jTIVexyoCQskoQfKHn2yxblhQ7Z72Uk5hn/
         BKQiTdilKGxYHRRZG11k17LINZDszp90xgyHaoBZtvSGCJn6d5iXiKAu9rJR1AV7lTOb
         G4qJeccysTdBEFWaHSwFavbiSnxF1TKFRjcJHn/9nF9ybyTnStkKKuju1THvj4EK3KAG
         DfGr3EljniSOpEd7wlbGIlFztKSHNU1OuIOHmJYTkWKBBNLugi1wWhh4m3d1GH1rNJTV
         JnD/V65LIc7LOva/0bUmQbIhXD4zJFkykpbI2t062fZp2jzDiTPSpcWVBoCQJBiuBTmD
         7lGQ==
X-Gm-Message-State: ACrzQf0lhsWwueiS/KiHVeXbP/vaC/2Z2VIIIiPlbpZvZ4zj+XH4rZ/j
        AGo/4QAsSnAYrNMrrXdWT6ZpPpXlTfCBiit61n96fSUzA8AQGYSPt+9ARYMVwPN4iDILRdWV3g2
        a17PFyWPn2eD2smH5/uoCAyU=
X-Received: by 2002:a5d:6c62:0:b0:230:5aa7:6771 with SMTP id r2-20020a5d6c62000000b002305aa76771mr11333443wrz.158.1665616747365;
        Wed, 12 Oct 2022 16:19:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7vBRuzDCDKjNuIq0n56gKUJ0aB/KWwPJBoNzMEaALW7TAv8G88bOXEAz6aahT5r9Chk4OIsA==
X-Received: by 2002:a5d:6c62:0:b0:230:5aa7:6771 with SMTP id r2-20020a5d6c62000000b002305aa76771mr11333434wrz.158.1665616747112;
        Wed, 12 Oct 2022 16:19:07 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id b8-20020a056000054800b0022ae401e9e0sm695188wrf.78.2022.10.12.16.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 16:19:06 -0700 (PDT)
Date:   Wed, 12 Oct 2022 19:19:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, stefanha@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Message-ID: <20221012191159-mutt-send-email-mst@kernel.org>
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
 <20221012010143-mutt-send-email-mst@kernel.org>
 <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com>
 <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
 <CAErSpo6azrPRAAkENVzXJOTWHCi1PLa8DHJMVKKj_cun8b+K1A@mail.gmail.com>
 <63b02394-d932-a385-9267-515c71bb65ee@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b02394-d932-a385-9267-515c71bb65ee@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 13, 2022 at 02:01:04AM +0300, Max Gurtovoy wrote:
> 
> On 10/13/2022 12:20 AM, Bjorn Helgaas wrote:
> > On Wed, Oct 12, 2022 at 5:01 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> > > 
> > > On 10/12/2022 11:42 AM, Max Gurtovoy wrote:
> > > > On 10/12/2022 8:02 AM, Michael S. Tsirkin wrote:
> > > > > On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
> > > > > > This is instead of re-writing the same logic in virtio driver.
> > > > > > 
> > > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Dropped this as it caused build failures:
> > > > > 
> > > > > https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com
> > > > maybe you can re-run it with:
> > > > 
> > > > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > > > index 8e98d24917cc..b383326a20e2 100644
> > > > --- a/drivers/virtio/Makefile
> > > > +++ b/drivers/virtio/Makefile
> > > > @@ -5,10 +5,11 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> > > >   obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> > > >   obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
> > > >   obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> > > > -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> > > > -virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> > > >   obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
> > > >   obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
> > > >   obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
> > > >   obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
> > > >   obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> > > > +
> > > > +virtio_pci-$(CONFIG_VIRTIO_PCI) := virtio_pci_modern.o
> > > > virtio_pci_common.o
> > > > +virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> > > > 
> > > Now I saw that CONFIG_PCI_IOV is not set in the error log so the bellow
> > > should fix it:
> > > 
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 060af91bafcd..c519220e8ff8 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -2228,7 +2228,10 @@ static inline int pci_sriov_set_totalvfs(struct
> > > pci_dev *dev, u16 numvfs)
> > >    { return 0; }
> > >    static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
> > >    { return 0; }
> > > -#define pci_sriov_configure_simple     NULL
> > > +static inline int pci_sriov_configure_simple(struct pci_dev *dev, int
> > > nr_virtfn)
> > > +{
> > > +       return -ENOSYS;
> > > +}
> > >    static inline resource_size_t pci_iov_resource_size(struct pci_dev
> > > *dev, int resno)
> > >    { return 0; }
> > >    static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool
> > > probe) { }
> > > 
> > > Bjorn,
> > > 
> > > WDYT about the above ?
> > > 
> > > should I send it to the pci subsystem list ?
> > Yes.  I don't apply things that haven't appeared on linux-pci@vger.kernel.org.
> 
> Sure.
> 
> MST,
> 
> can you confirm the above fixes the build errors before I sent the v2 ?

Max, please just use the lkp test, it's not hard.

-- 
MST

