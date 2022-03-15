Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF26C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 14:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbiCOOyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiCOOyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 10:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3EBED46
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647356010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vv+3ovGKwDTOrBOb0CBCSF9P9oG+MybmZmM71ErkNhE=;
        b=DbYjSLQZfuplAPrWEvO7EERSsCyDRewwLCKNkivjR74KUoCOuQKQ43wFNujFnYtHn/b08r
        dOehwXccKnyVPipokaZmOL7jcG54vXqHlrBVakikbzmRFL3ltLJmvoLTg3LTDuPwQW9iid
        CzfOn9lbDXxYU+Zk3j/JE8ApEsmP6C0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-Pc2SVGMnNA-bWPm6pXcoJg-1; Tue, 15 Mar 2022 10:53:29 -0400
X-MC-Unique: Pc2SVGMnNA-bWPm6pXcoJg-1
Received: by mail-wr1-f71.google.com with SMTP id 8-20020adf8108000000b00203d97ba415so391389wrm.5
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 07:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vv+3ovGKwDTOrBOb0CBCSF9P9oG+MybmZmM71ErkNhE=;
        b=JS4D/0qxAia6qpHYLFo4/zj6nVQJW6sq6JQc+GeKqpPV0+1S8sCCVZ8mDDrdrg9rMP
         Q+dMnTw66fNEyZi40nhAn4bvxpMLyW7S+kndWBxKtFJdUaKs397fGxEZMrmQYidrnxOg
         qpb3XO9cUHghG7BghdYKLB/XyXAocPK7tdEh/yLhO2/3oUlK4yrRvYhHrG8F0M55v4BS
         QJIAF+PaOoahsv1glhs2Ib5Ze+qn3B1ykf3+gyI9ufIYT2GruB6IuEH0VE69DZTjBbF4
         6G/x8YbGl6t/tBwUU/EYOeiEMYS00x9ODVpbpM8+/ZIge51ZFinvGJxVZs7kyGSXUhum
         ONeg==
X-Gm-Message-State: AOAM532CSKcSIf7L5q0F5YMDAdPb9YB/zbo9WayOoyUoPBTn5QQcpGSb
        8LQcjls7epsNxBNbaS4ZMR68HUpW23HOhKyRedLCLauQJGBeCgxfZO6Kb8qP3jlmJSzeye0kIiK
        JMqDPyT6MJy+gN5SZbMJCK24=
X-Received: by 2002:a05:600c:4e94:b0:389:e900:5ba9 with SMTP id f20-20020a05600c4e9400b00389e9005ba9mr3786075wmq.166.1647356008372;
        Tue, 15 Mar 2022 07:53:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNv0nAdQhLiCI3Puh8sIvNuqxUpLK8JinaItSHy7MtiHhOeNXZjQJTiNstvQh9XDren6dRkw==
X-Received: by 2002:a05:600c:4e94:b0:389:e900:5ba9 with SMTP id f20-20020a05600c4e9400b00389e9005ba9mr3786063wmq.166.1647356008149;
        Tue, 15 Mar 2022 07:53:28 -0700 (PDT)
Received: from redhat.com ([2.53.2.35])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d5981000000b00203d8ea8c94sm1348768wri.84.2022.03.15.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:53:27 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:53:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220315105155-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjCmBkjgtQZffiXw@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 11:43:18PM +0900, Suwan Kim wrote:
> On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
> > On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> > 
> > > On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> > > >
> > > > 在 2022/3/11 下午11:28, Suwan Kim 写道:
> > > > > diff --git a/include/uapi/linux/virtio_blk.h
> > > b/include/uapi/linux/virtio_blk.h
> > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > >      * deallocation of one or more of the sectors.
> > > > >      */
> > > > >     __u8 write_zeroes_may_unmap;
> > > > > +   __u8 unused1;
> > > > > -   __u8 unused1[3];
> > > > > +   __virtio16 num_poll_queues;
> > > > >   } __attribute__((packed));
> > > >
> > > >
> > > > This looks like a implementation specific (virtio-blk-pci) optimization,
> > > how
> > > > about other implementation like vhost-user-blk?
> > >
> > > I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
> > > use vritio_blk_config as kernel-qemu interface?
> > >
> > 
> > Yes, but see below.
> > 
> > 
> > >
> > > Does vhost-user-blk need additional modification to support polling
> > > in kernel side?
> > >
> > 
> > 
> > No, but the issue is, things like polling looks not a good candidate for
> > the attributes belonging to the device but the driver. So I have more
> > questions:
> > 
> > 1) what does it really mean for hardware virtio block devices?
> > 2) Does driver polling help for the qemu implementation without polling?
> > 3) Using blk_config means we can only get the benefit from the new device
> 
> 1) what does it really mean for hardware virtio block devices?
> 3) Using blk_config means we can only get the benefit from the new device
> 
> This patch adds dedicated HW queue for polling purpose to virtio
> block device.
> 
> So I think it can be a new hw feature. And it can be a new device
> that supports hw poll queue.
> 
> BTW, I have other idea about it.
> 
> How about adding “num-poll-queues" property as a driver parameter
> like NVMe driver, not to QEMU virtio-blk-pci property?
> 
> If then, we don’t need to modify virtio_blk_config.
> And we can apply the polling feature only to virtio-blk-pci.
> But can QEMU pass “num-poll-queues" to virtio-blk driver param?

Same as any other driver parameter, pass it on kernel command line.

> 
> 
> 2) Does driver polling help for the qemu implementation without polling?
> 
> Sorry, I didn't understand your question. Could you please explain more about?
> 
> Regards,
> Suwan Kim

