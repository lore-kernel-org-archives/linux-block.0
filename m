Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42639C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 15:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiCQPFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiCQPFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 11:05:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF41F1E92
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 08:03:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h2so7034238pfh.6
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8mMGx+ZnWLWdjrgKj6NDxk2i+A2zefzeOSXhji5DzeI=;
        b=czvfcSx2YzYv0/j5TWj1jJU6ExaY3s2iqlFhKcuXULsi6kTpRzc0TcHKzw3yjnw2iY
         WkfTRy2tSoNxHW6lagD88MerJyJADcujGUSQaJei1u5SdPkFie7VrEVycp6bDMa6mCq+
         eDil/0YWOC3p44tOWIVZ1Ja49yNJtkAwSGapXgEdO04sdmzqLXRhHMrNThvSM1p3zf+r
         b79Nx4lcTBPAKmTHHryRYpC/HJddr5/iFelKV/Y1bzXtAsBHy04YnQOQF/G4NCa5iyWk
         WadXAdqSIVSSkJPKNp67bxxjRktruKgl0nscdMo5fnak03gvoixnYRD7OuYm4sXzqzvK
         +niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8mMGx+ZnWLWdjrgKj6NDxk2i+A2zefzeOSXhji5DzeI=;
        b=3gvbVeGQ93W+QJU7KzfnAFhWn1oP6L5BaD2hq9z851B4rksbbw+duMk4tjIhI7NX95
         qfctv16a86SIMBrRbLc+sOofY6PD//FO/lhCTZJsgzNp7GDSt21nN4H/RW98kiyGdCmj
         2/C1kK2h3wcYzFfCxh4uLvg0iN5fZZODjbUbAls8lEmjQXthjWRH8Le61C1uHHxfHVI6
         qr3a6JO1qCT5EbwT2gcaQek1kdI3BOjrkswKzEB9aEKHYaHlAdIqbWId38S8fDl1VC9H
         DFJ9/Kvs//8sjFFivLWJvy+7rsjtyvOfUk+1VGsTH1JJvkSBga6RyMTHHGxIi4GNUis7
         RaUw==
X-Gm-Message-State: AOAM532gRlM8ftPypiWz4nHMFsjKQBCd4N0qtg4K5UoJXrMWbNol+Gbg
        zuTAMLv1gv59TTUR2M8a4OAoGm+v6NpVDQ==
X-Google-Smtp-Source: ABdhPJxP6uBbe0/HpAqakDmXN+GQFDXgrkwx9BFiaY/ItUptDgz3KzUM6ln1MbUFFhvdEj/9n5El0w==
X-Received: by 2002:a65:6cc7:0:b0:380:6a04:cecc with SMTP id g7-20020a656cc7000000b003806a04ceccmr4045919pgw.455.1647529431179;
        Thu, 17 Mar 2022 08:03:51 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id e19-20020a637453000000b003821bdb8103sm1131323pgn.83.2022.03.17.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:03:50 -0700 (PDT)
Date:   Fri, 18 Mar 2022 00:03:44 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <YjNN0Id5Hhus1CwB@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
 <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
 <YjIDIjUwuwkfRS2d@localhost.localdomain>
 <CACGkMEu8T8_9gJMGybMZVCT9zCrw+OaTtbhtvnUNUORNmYKw-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu8T8_9gJMGybMZVCT9zCrw+OaTtbhtvnUNUORNmYKw-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 17, 2022 at 10:20:05AM +0800, Jason Wang wrote:
> On Wed, Mar 16, 2022 at 11:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> >
> > On Wed, Mar 16, 2022 at 10:02:13AM +0800, Jason Wang wrote:
> > > On Tue, Mar 15, 2022 at 10:43 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
> > > > > On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> > > > >
> > > > > > On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> > > > > > >
> > > > > > > 在 2022/3/11 下午11:28, Suwan Kim 写道:
> > > > > > > > diff --git a/include/uapi/linux/virtio_blk.h
> > > > > > b/include/uapi/linux/virtio_blk.h
> > > > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > > > >      * deallocation of one or more of the sectors.
> > > > > > > >      */
> > > > > > > >     __u8 write_zeroes_may_unmap;
> > > > > > > > +   __u8 unused1;
> > > > > > > > -   __u8 unused1[3];
> > > > > > > > +   __virtio16 num_poll_queues;
> > > > > > > >   } __attribute__((packed));
> > > > > > >
> > > > > > >
> > > > > > > This looks like a implementation specific (virtio-blk-pci) optimization,
> > > > > > how
> > > > > > > about other implementation like vhost-user-blk?
> > > > > >
> > > > > > I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
> > > > > > use vritio_blk_config as kernel-qemu interface?
> > > > > >
> > > > >
> > > > > Yes, but see below.
> > > > >
> > > > >
> > > > > >
> > > > > > Does vhost-user-blk need additional modification to support polling
> > > > > > in kernel side?
> > > > > >
> > > > >
> > > > >
> > > > > No, but the issue is, things like polling looks not a good candidate for
> > > > > the attributes belonging to the device but the driver. So I have more
> > > > > questions:
> > > > >
> > > > > 1) what does it really mean for hardware virtio block devices?
> > > > > 2) Does driver polling help for the qemu implementation without polling?
> > > > > 3) Using blk_config means we can only get the benefit from the new device
> > > >
> > > > 1) what does it really mean for hardware virtio block devices?
> > > > 3) Using blk_config means we can only get the benefit from the new device
> > > >
> > > > This patch adds dedicated HW queue for polling purpose to virtio
> > > > block device.
> > > >
> > > > So I think it can be a new hw feature. And it can be a new device
> > > > that supports hw poll queue.
> > >
> > > One possible issue is that the "poll" looks more like a
> > > software/driver concept other than the device/hardware.
> > >
> > > >
> > > > BTW, I have other idea about it.
> > > >
> > > > How about adding “num-poll-queues" property as a driver parameter
> > > > like NVMe driver, not to QEMU virtio-blk-pci property?
> > >
> > > It should be fine, but we need to listen to others.
> >
> > To Michael, Stefan, Max
> >
> > How about using driver parameter instead of virio_blk_config?
> 
> I agree.
> 
> Thanks
 
Okay. Then I will send v2 with .queue_rqs patch

Regards,
Suwan Kim
