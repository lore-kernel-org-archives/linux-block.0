Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C11C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 14:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiCOOoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiCOOoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 10:44:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89C2631C
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 07:43:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so90208pjp.3
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s2Fo8cFhNIIc04Q+dLxt9o39hs6qWMAmWn+8C9PjvUQ=;
        b=qvc2AxZC04cEbvTPKDFsrmCvTQuUktI3F8dUPlB2ZmwZB9r4i6t3cUiDt5VFzlQ29/
         UJarmdlnlcfk6zbv0/RmPkGaLQ0IcAUFeN5iW7sw86JvImfMvhjpu2ojzNxygZGJF+KW
         iA7NZDhpgTFpd30jw69dUvs8oP7e9g+skJHqb2OBlrYMIRj8JpOqCjvxFQPpv6V9brGe
         o3aBE/tgb1MMljwPsDKliboDrWqHfn8vPyP5q99s3yXnA/6vzPPsqB17SGhZLDKP8ABW
         eICMviKMLqQYthwNeyHMF1xoJeGahwUeZ2h0UwGCIG8dgFSq0N/8FOO/0iRtXnbDSmSw
         XA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s2Fo8cFhNIIc04Q+dLxt9o39hs6qWMAmWn+8C9PjvUQ=;
        b=0cKUAKVBnxkSGIfUm5Lugs33lf439LJehOh4pLArwqDYm+4ZGBLuqScqzN2SNmC4k2
         iJxRbU/qyFd8mJ/DrB5Yz0i4yOAM8l1tpSd4MzCd68dEPVixUnw9ZIMCqr03ge9HyEVZ
         8gsQaalHPyCIcHSZJhnImesjChLYgduY6N8zHHavWOLxk03K+J2iPvDckfexHd8/yZjN
         M/MDBW5RY7kugaTCWzPOQ6o8V44QtDxOpplsq8cbGHpPPl1CpzQm++6wIbtPg1+6I0cO
         Pd9aeDXiD6gQYdvwf650VLzDsyloj4GOC3X1AvTXYjPil21SrcyM4XpP76DQRyIkaZuu
         TUtQ==
X-Gm-Message-State: AOAM532mkjRKn5LtHJJzBuCOhYi1VDp9KcB5iDkHTlR95ppBX/3Tr3XQ
        p9g+CD0OE19SrB7A4JjkCIo=
X-Google-Smtp-Source: ABdhPJwWZ3Zd3quUZ02+D8WG9japUmMBVWiWS66RcKjOBEIv1rSxJjEWtqJ5xYlN+aek6hCVlBsd+A==
X-Received: by 2002:a17:903:2303:b0:151:d3dc:42b3 with SMTP id d3-20020a170903230300b00151d3dc42b3mr28845731plh.85.1647355404428;
        Tue, 15 Mar 2022 07:43:24 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id mt3-20020a17090b230300b001c633aca1e1sm3474740pjb.18.2022.03.15.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:43:23 -0700 (PDT)
Date:   Tue, 15 Mar 2022 23:43:18 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <YjCmBkjgtQZffiXw@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
> On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> 
> > On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> > >
> > > 在 2022/3/11 下午11:28, Suwan Kim 写道:
> > > > diff --git a/include/uapi/linux/virtio_blk.h
> > b/include/uapi/linux/virtio_blk.h
> > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > --- a/include/uapi/linux/virtio_blk.h
> > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > >      * deallocation of one or more of the sectors.
> > > >      */
> > > >     __u8 write_zeroes_may_unmap;
> > > > +   __u8 unused1;
> > > > -   __u8 unused1[3];
> > > > +   __virtio16 num_poll_queues;
> > > >   } __attribute__((packed));
> > >
> > >
> > > This looks like a implementation specific (virtio-blk-pci) optimization,
> > how
> > > about other implementation like vhost-user-blk?
> >
> > I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
> > use vritio_blk_config as kernel-qemu interface?
> >
> 
> Yes, but see below.
> 
> 
> >
> > Does vhost-user-blk need additional modification to support polling
> > in kernel side?
> >
> 
> 
> No, but the issue is, things like polling looks not a good candidate for
> the attributes belonging to the device but the driver. So I have more
> questions:
> 
> 1) what does it really mean for hardware virtio block devices?
> 2) Does driver polling help for the qemu implementation without polling?
> 3) Using blk_config means we can only get the benefit from the new device

1) what does it really mean for hardware virtio block devices?
3) Using blk_config means we can only get the benefit from the new device

This patch adds dedicated HW queue for polling purpose to virtio
block device.

So I think it can be a new hw feature. And it can be a new device
that supports hw poll queue.

BTW, I have other idea about it.

How about adding “num-poll-queues" property as a driver parameter
like NVMe driver, not to QEMU virtio-blk-pci property?

If then, we don’t need to modify virtio_blk_config.
And we can apply the polling feature only to virtio-blk-pci.
But can QEMU pass “num-poll-queues" to virtio-blk driver param?



2) Does driver polling help for the qemu implementation without polling?

Sorry, I didn't understand your question. Could you please explain more about?

Regards,
Suwan Kim
