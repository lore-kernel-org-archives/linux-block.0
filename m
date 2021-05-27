Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A3C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 05:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78C661355
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 05:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhE0FYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 01:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232452AbhE0FYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 01:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622092985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMolLnDEuKlCbbgIOvjZGGBzK5WYRhCAHto1CLY+p8s=;
        b=TGpZIpUJddH24prhTz0/nxwz7qwQWR2QXX1cSDQdiIS31A0qAWM4Pl4q1UopVellJCP6if
        ZkOnL5d3EYGXaGk1uazPTwDygoqvNteSJFCR63uhv+I6CZbsBjJPtA0eP+vFceLm+rAucb
        Q0+8F7xWVXbFQ08UgluHaFvOSo0MBfc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-ETJfCA7mOQu4hQFxUk_BmQ-1; Thu, 27 May 2021 01:23:03 -0400
X-MC-Unique: ETJfCA7mOQu4hQFxUk_BmQ-1
Received: by mail-wm1-f69.google.com with SMTP id o126-20020a1c28840000b0290149b8f27c99so1485527wmo.2
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 22:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMolLnDEuKlCbbgIOvjZGGBzK5WYRhCAHto1CLY+p8s=;
        b=Ra2r0fPvQWVa9fk3RLqzkuPBTtGfHJpClst0z6xtWMMOHqdgdJGURbscwQTt+iS4JJ
         0CoY42AfS85JITQhuqxB39OnfbRhkOtghqH4vBfVr1Z/Ic0Z1gAp7Hdk1LDR28B6QtLf
         xZdCXfdtua9r8GqxjMMDzfnHAmbdqP4y/E5JRCrDI9PbexEj7KA6aWv8rNN9VL82GDK2
         g4P3X2pAZalGiSgwfmweeIfxwlJJrz6lXCn1t0DsMdhSNhBJMSWfsXVOaFN3Jbr/M8hb
         0NuQAFnaEXEGvYSEI4ZiYFvqcuULARvXwSVY/rnpO3MRkf0Fi/sQTDeKayotBR0LCNxP
         mYYw==
X-Gm-Message-State: AOAM530WYnrDcc/Ec9UWAgaLhqqyLmuSYrsYYdHY994Y2PFgagrNA8aS
        OH9uayK1mD4OTgu2kf35JfCrLRm2CJgE8jBgKDPhdAlbsNoZ7kBjlSVovW6ZIyY0EJAChAQoU07
        MyMUnXIou4eVeX+6QIxSTm8eH9O3IHTATu0I1f/A=
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr1475257wmj.13.1622092982524;
        Wed, 26 May 2021 22:23:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa0wPCCjw27Z2yCH+wdxntKMt6SKdiBQRynFGJITdQ1ITjKHgkP1NlgNUqPttT4t/L9oT/b35YZi6UHzeV/LA=
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr1475236wmj.13.1622092982195;
 Wed, 26 May 2021 22:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
 <YKMKdHPFCNhR1SXx@T590> <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
 <CAFnufp3ZzrKHiV1Vy9_bAymy0oEr288dL4yWo4EjqUzhJV6J-A@mail.gmail.com> <CAFnufp0V7X_nvN3RGK-C0AXappQ+qjMS_rb7iQhcjT8E0OVpzA@mail.gmail.com>
In-Reply-To: <CAFnufp0V7X_nvN3RGK-C0AXappQ+qjMS_rb7iQhcjT8E0OVpzA@mail.gmail.com>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Thu, 27 May 2021 10:52:50 +0530
Message-ID: <CANwsLLEtOws-+X=3CCGzO88poP9NF8uNN8aW9wHOJ+QA=SFH3A@mail.gmail.com>
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Ilya Dryomov <idryomov@redhat.com>,
        Xiubo Li <xiubli@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 26, 2021 at 7:44 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Wed, May 19, 2021 at 4:33 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > On Tue, May 18, 2021 at 9:52 AM Prasanna Kalever <pkalever@redhat.com> wrote:
> > > > BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
> > > > is added for addressing this issue, what do you think of that generic
> > > > approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
> > > > for addressing this issue?
> > > >
> > > > https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r
> > >
> > > If I understand the changes and the background of the fix correctly, I
> > > think with that fix author is trying to monotonically increase the seq
> > > number and add it to the disk on every single device map/attach and
> > > expose it through the sysfs, which will help the userspace processes
> > > further to correlate events for particular and specific devices that
> > > reuse the same loop device.
> > >
> >
> > Yes, but nothing prevents to use diskseq in nbd, and increase it on reconfigure.
> > That would allow to detect if the device has been reconfigured.
> >
> > Regards,
> > --
> > per aspera ad upstream
>
> FYI: I just sent a v2 of the diskseq change
>
> https://lore.kernel.org/linux-block/20210520135622.44625-1-mcroce@linux.microsoft.com/

Thanks, Matteo, I will take a look.

Just to set the expectation here, I don't have any thoughts on
leverage the diskseq number for nbd as part of this patch. This patch
is trying to solve a different problem which is more severe for us
than helping to identify the reconfigured events.

That all said, once diskseq patches are merged, I will surely open a
new patch with the required changes in nbd, to leverage diskseq
number.

Best Regards,
--
Prasanna

>
> --
> per aspera ad upstream
>

