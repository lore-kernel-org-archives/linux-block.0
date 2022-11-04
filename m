Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A297C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 06:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKDG5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 02:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKDG5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 02:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1AC6434
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 23:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667544969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z8pgpEoQGeTMdYiqrUkF/Lckp8LaxoK9HC3TP6LmFk=;
        b=CiCw683jaHHCLBOp5W/xYdsLOeCM3e9x+DTXcDxYMTeC7re3kDLQhiCFC8JXDGLhcEqJ3Y
        ImuSGmteNOM4lA6pr8uPargqsNQxK1AB1JeepJV2xt7ClgLQyxlmAdB56KKe4t/n5IZIXd
        PIsTQLEcVCOaZRL8XuSr6ILa2Gs4Ros=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-E196k4EYM6itbhqOp0P0YQ-1; Fri, 04 Nov 2022 02:56:08 -0400
X-MC-Unique: E196k4EYM6itbhqOp0P0YQ-1
Received: by mail-oi1-f199.google.com with SMTP id h20-20020aca1814000000b003552a075929so1942467oih.3
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 23:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z8pgpEoQGeTMdYiqrUkF/Lckp8LaxoK9HC3TP6LmFk=;
        b=WDn2FV/XRS1Ao9B4Kpe2gXf3zW/rvJ6fq8dlrs5pHs9tcUlvOROiESGLNI/GQZYY3Y
         d9WATVn7EeMaGTVP1YmaJ2FL6EZkw6fhSVcwI6SpNfwV+CF/so1ig0bYrlicukS2VRPo
         Q2TfsrEeySvDp2OQXU4xs+wxweVHxw9O6tZuNu3uLEH6Oh9v4sS3QYespTAGimAGrOk9
         s3OOXaJ7jmmvGNLFBvoVhcc9spHYClNsFkzHjuHlE/uCZ1Qw7iunEze+WHbkJ367abTM
         G6ijS4IJsEWpr8DBFE5E8ka8QPh3+tMxpwZ9V6I+kidrovYFKGRlMvlWJQ4VKEiLX1PC
         607A==
X-Gm-Message-State: ACrzQf2ZbKa9nJ3PULgTRStoTPWDqK7O5j2VroK9yNsPj7qKg6kMYvh6
        Nwf2rTH8SvycJ1pZToCoq0NJYH2Bv/Ez8FuAD2qpoUnWH77qwcGXbYHxJSR8UKojgUSwWCCC/bt
        +HcsuhRsQUiL2zv7X0Q8Bv7qUiWvF+Jveopml8Pc=
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id k21-20020a056870959500b0013207b329acmr187912oao.35.1667544967828;
        Thu, 03 Nov 2022 23:56:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6uOSbcIQS7KtsvJ6sUqAGVkWZj1MHAULLpUw3CyxbO8+piM4IZrUq0fI1jx3qzy5Tb12QsruflGwjcxpEXVPQ=
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id
 k21-20020a056870959500b0013207b329acmr187905oao.35.1667544967645; Thu, 03 Nov
 2022 23:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <Y0lcmZTP5sr467z6@T590> <CACycT3u8yYUS-WnNzgHQtQFYuK-XcyffpFc35HVZzrCS7hH5Sg@mail.gmail.com>
 <Y05OzeC7wImts4p7@T590> <CACycT3sK1AzA4RH1ZfbstV3oax-oeBVtEz+sY+8scBU0=1x46g@mail.gmail.com>
 <CAJSP0QVevA0gvyGABAFSoMhBN9ydZqUJh4qJYgNbGeyRXL8AjA@mail.gmail.com>
 <CACycT3udzt0nyqweGbAsZB4LDQU=a7OSWKC8ZWieoBpsSfa2FQ@mail.gmail.com>
 <1d051d63-ce34-1bb3-2256-4ced4be6d690@redhat.com> <CACycT3usE0QdJd50bSiLiPwTFxscg-Ur=iZyeGJJBPe7+KxOFQ@mail.gmail.com>
 <CAJSP0QUGj4t8nYeJvGaO-cWJ+F3Zvxcq007RHOm-=41zaE-v0Q@mail.gmail.com>
 <CACGkMEt+BWCUVQPnfUUd0QXkHz=90LMXxydCgBqWTDB3eGBw-w@mail.gmail.com> <Y2LBa/ePKiSN2phm@fedora>
In-Reply-To: <Y2LBa/ePKiSN2phm@fedora>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 4 Nov 2022 14:55:55 +0800
Message-ID: <CACGkMEvBZDxTv-DS7V6HW+GPZio5jiafmNGACa2cyWqCr_GvJg@mail.gmail.com>
Subject: Re: ublk-qcow2: ublk-qcow2 is available
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Denis V. Lunev" <den@openvz.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 3, 2022 at 3:13 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Nov 01, 2022 at 10:36:29AM +0800, Jason Wang wrote:
> > On Tue, Oct 25, 2022 at 8:02 PM Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> > >
> > > On Tue, 25 Oct 2022 at 04:17, Yongji Xie <xieyongji@bytedance.com> wr=
ote:
> > > >
> > > > On Fri, Oct 21, 2022 at 2:30 PM Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2022/10/21 13:33, Yongji Xie =E5=86=99=E9=81=93:
> > > > > > On Tue, Oct 18, 2022 at 10:54 PM Stefan Hajnoczi <stefanha@gmai=
l.com> wrote:
> > > > > >> On Tue, 18 Oct 2022 at 09:17, Yongji Xie <xieyongji@bytedance.=
com> wrote:
> > > > > >>> On Tue, Oct 18, 2022 at 2:59 PM Ming Lei <tom.leiming@gmail.c=
om> wrote:
> > > > > >>>> On Mon, Oct 17, 2022 at 07:11:59PM +0800, Yongji Xie wrote:
> > > > > >>>>> On Fri, Oct 14, 2022 at 8:57 PM Ming Lei <tom.leiming@gmail=
.com> wrote:
> > > > > >>>>>> On Thu, Oct 13, 2022 at 02:48:04PM +0800, Yongji Xie wrote=
:
> > > > > >>>>>>> On Wed, Oct 12, 2022 at 10:22 PM Stefan Hajnoczi <stefanh=
a@gmail.com> wrote:
> > > > > >>>>>>>> On Sat, 8 Oct 2022 at 04:43, Ziyang Zhang <ZiyangZhang@l=
inux.alibaba.com> wrote:
> > > > > >>>>>>>>> On 2022/10/5 12:18, Ming Lei wrote:
> > > > > >>>>>>>>>> On Tue, Oct 04, 2022 at 09:53:32AM -0400, Stefan Hajno=
czi wrote:
> > > > > >>>>>>>>>>> On Tue, 4 Oct 2022 at 05:44, Ming Lei <tom.leiming@gm=
ail.com> wrote:
> > > > > >>>>>>>>>>>> On Mon, Oct 03, 2022 at 03:53:41PM -0400, Stefan Haj=
noczi wrote:
> > > > > >>>>>>>>>>>>> On Fri, Sep 30, 2022 at 05:24:11PM +0800, Ming Lei =
wrote:
> > > There are ways to minimize that cost:
> > > 1. The driver only needs to fetch the device's sq index when it has
> > > run out of sq ring space.
> > > 2. The device can include sq index updates with completions. This is
> > > what NVMe does with the CQE SQ Head Pointer field, but the
> > > disadvantage is that the driver has no way of determining the sq inde=
x
> > > until a completion occurs.
> >
> > Probably, but as replied in another thread, based on the numbers
> > measured from the networking test, I think the current virtio layout
> > should be sufficient for block I/O but might not fit for cases like
> > NFV.
>
> I remember that the Linux virtio_net driver doesn't rely on vq spinlocks
> because CPU affinity and the NAPI architecture ensure that everything is
> CPU-local. There is no need to protect the freelist explicitly because
> the functions cannot race.
>
> Maybe virtio_blk can learn from virtio_net...

It only works for RX where add and get could be all done in NAPI. But
this is not the case for TX (and virtio-blk).

Actually, if the free_list is the one thing that needs to be
serialized, there's no need to use lock at all. We can try to switch
to use ptr_ring instead.

Thanks

>
> Stefan

