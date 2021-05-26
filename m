Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE25BC47088
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFAA613D3
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 14:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhEZOPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 10:15:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45408 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEZOPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 10:15:31 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4B95120B8008;
        Wed, 26 May 2021 07:14:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B95120B8008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622038440;
        bh=Hlv5sVjAjS61KZitQI4F9HNXJAk2eb1GHkwnsjqNczM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XijCPxjbXsVWuQd5w2/NKKrCDn1KFc1qqftWyVwwLldTOLNwQ1VAdsdqSsWs1yuhl
         +WpTSEF55jXChbTVJiPdsBZ56vXgEKHtLqfGflnoH5SyRHaqRn9mKejgb55jG04WEa
         aT29+eAbifRmlgC3ORqSqAMc0/MoxlatKxJ+NMFE=
Received: by mail-pj1-f47.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so417076pjb.4;
        Wed, 26 May 2021 07:14:00 -0700 (PDT)
X-Gm-Message-State: AOAM5308JhgexHgHV/giY6zLG4ge+TQUzM/2KayeEgJK5zDK9FBNbVkw
        1SLDr/HWfMsQICR2Dddp4uMiSiRw7YnqmPrgEgM=
X-Google-Smtp-Source: ABdhPJy7mWPbmKxQg3/RQzr4uqXII36pbymjkkiQuMGs+L2mrLJuRksCyOGyyVNyAYM/bMeHO4FGyF30cYDf5+Y2+UU=
X-Received: by 2002:a17:90a:7892:: with SMTP id x18mr3472341pjk.39.1622038439875;
 Wed, 26 May 2021 07:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
 <YKMKdHPFCNhR1SXx@T590> <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
 <CAFnufp3ZzrKHiV1Vy9_bAymy0oEr288dL4yWo4EjqUzhJV6J-A@mail.gmail.com>
In-Reply-To: <CAFnufp3ZzrKHiV1Vy9_bAymy0oEr288dL4yWo4EjqUzhJV6J-A@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 26 May 2021 16:13:23 +0200
X-Gmail-Original-Message-ID: <CAFnufp0V7X_nvN3RGK-C0AXappQ+qjMS_rb7iQhcjT8E0OVpzA@mail.gmail.com>
Message-ID: <CAFnufp0V7X_nvN3RGK-C0AXappQ+qjMS_rb7iQhcjT8E0OVpzA@mail.gmail.com>
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
To:     Prasanna Kalever <pkalever@redhat.com>
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

On Wed, May 19, 2021 at 4:33 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Tue, May 18, 2021 at 9:52 AM Prasanna Kalever <pkalever@redhat.com> wrote:
> > > BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
> > > is added for addressing this issue, what do you think of that generic
> > > approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
> > > for addressing this issue?
> > >
> > > https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r
> >
> > If I understand the changes and the background of the fix correctly, I
> > think with that fix author is trying to monotonically increase the seq
> > number and add it to the disk on every single device map/attach and
> > expose it through the sysfs, which will help the userspace processes
> > further to correlate events for particular and specific devices that
> > reuse the same loop device.
> >
>
> Yes, but nothing prevents to use diskseq in nbd, and increase it on reconfigure.
> That would allow to detect if the device has been reconfigured.
>
> Regards,
> --
> per aspera ad upstream

FYI: I just sent a v2 of the diskseq change

https://lore.kernel.org/linux-block/20210520135622.44625-1-mcroce@linux.microsoft.com/

-- 
per aspera ad upstream
