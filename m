Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B931C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiCPPeO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbiCPPeN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 11:34:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6464C5
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 08:32:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t187so498700pgb.1
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rnmipZJmwwd9sb/WiPh6QaespcJoC4jwrIz9QyEhPMs=;
        b=AWVDfJdkIC6Zzq9kh2L5pNVzRnxx1dgr4jBmrOS3T0JQvBto6nLV8dc3xbynxSeyOw
         ZPKVJ2zwJlPli7Af1V6rGGcQisBKYd+JOnscSYe04mUtissjRgBDEYvPVaK3Us5CqLsu
         4EGohBkuM7XTXan2OTIKDPFRffhsS8/jygeqdsMrMggVYjIRGEfW4jkMJ7S/TbrXB59r
         H+UASXthXBIcsLIqroNDSBar80AaPKfWazl5ZIQFq8QN2g/ExQBA3ZCifNrVoAqdMG4R
         2sa9/91kxwLKx4+QP9vdj5d/0po40pHej5fhz9Uvl0KRq3R0AikXs5wTmNERTZoePP3g
         fBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rnmipZJmwwd9sb/WiPh6QaespcJoC4jwrIz9QyEhPMs=;
        b=e0V8TMWX5F3fhpsNSncgiNOVSUO6nUpQAh2YAEsrs2IhgLHyLUggu6w3D8AkgYZFhD
         xZIkiG6xrkAbi1+5lj6GWe18+4wg3ZaUkS2nZc2zZG2ZEg5yQLrp56Ox3IDqFOe6V5dL
         mHqdx51UvXaDrZLYqfH8tEWwDZ4dxT4NVtzwV354DGQSwX3aNJxbejUPFNmQUWzbdqg6
         vmMFPTIqkO5QfiRt2vLVbdjD1mfSK13s2ZctpIfWcS3DRhJuqqGPZAyD6lVHwijlXmHr
         O75ZogGaKn5mf+TrlO2eP6sDki5L03c93zCBXwU5i1F/GXXNgwJq71MS4ARVvizdj8F7
         w5+Q==
X-Gm-Message-State: AOAM533wU9EbJWOXGSFv2x96EoW4+QDYRiUDj3UvzqD6/5G0Gu3JZfXm
        0SBxu+3gg+C321Ywa3JftDY=
X-Google-Smtp-Source: ABdhPJwadgEWXpq/oaf+CfhRVgSj/2ZKwEVchkeNCdBRyGf7kRZkoCaRfUrH+5byFGICg7mWq3UtXw==
X-Received: by 2002:aa7:8889:0:b0:4f7:7283:e378 with SMTP id z9-20020aa78889000000b004f77283e378mr441260pfe.36.1647444776677;
        Wed, 16 Mar 2022 08:32:56 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm2806773pgk.74.2022.03.16.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:32:55 -0700 (PDT)
Date:   Thu, 17 Mar 2022 00:32:50 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org, mgurtovoy@nvidia.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <YjIDIjUwuwkfRS2d@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
 <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 10:02:13AM +0800, Jason Wang wrote:
> On Tue, Mar 15, 2022 at 10:43 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> >
> > On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
> > > On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> > >
> > > > On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> > > > >
> > > > > 在 2022/3/11 下午11:28, Suwan Kim 写道:
> > > > > > diff --git a/include/uapi/linux/virtio_blk.h
> > > > b/include/uapi/linux/virtio_blk.h
> > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > >      * deallocation of one or more of the sectors.
> > > > > >      */
> > > > > >     __u8 write_zeroes_may_unmap;
> > > > > > +   __u8 unused1;
> > > > > > -   __u8 unused1[3];
> > > > > > +   __virtio16 num_poll_queues;
> > > > > >   } __attribute__((packed));
> > > > >
> > > > >
> > > > > This looks like a implementation specific (virtio-blk-pci) optimization,
> > > > how
> > > > > about other implementation like vhost-user-blk?
> > > >
> > > > I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
> > > > use vritio_blk_config as kernel-qemu interface?
> > > >
> > >
> > > Yes, but see below.
> > >
> > >
> > > >
> > > > Does vhost-user-blk need additional modification to support polling
> > > > in kernel side?
> > > >
> > >
> > >
> > > No, but the issue is, things like polling looks not a good candidate for
> > > the attributes belonging to the device but the driver. So I have more
> > > questions:
> > >
> > > 1) what does it really mean for hardware virtio block devices?
> > > 2) Does driver polling help for the qemu implementation without polling?
> > > 3) Using blk_config means we can only get the benefit from the new device
> >
> > 1) what does it really mean for hardware virtio block devices?
> > 3) Using blk_config means we can only get the benefit from the new device
> >
> > This patch adds dedicated HW queue for polling purpose to virtio
> > block device.
> >
> > So I think it can be a new hw feature. And it can be a new device
> > that supports hw poll queue.
> 
> One possible issue is that the "poll" looks more like a
> software/driver concept other than the device/hardware.
> 
> >
> > BTW, I have other idea about it.
> >
> > How about adding “num-poll-queues" property as a driver parameter
> > like NVMe driver, not to QEMU virtio-blk-pci property?
> 
> It should be fine, but we need to listen to others.

To Michael, Stefan, Max

How about using driver parameter instead of virio_blk_config?

Regards,
Suwan Kim
