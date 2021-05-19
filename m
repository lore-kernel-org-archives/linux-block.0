Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7F6C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2C96135C
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbhESOfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 10:35:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57946 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhESOfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 10:35:16 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id DFBA820B8008;
        Wed, 19 May 2021 07:33:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFBA820B8008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1621434836;
        bh=2l115mN3zp/dArufLuzm7XoNobdsZKeT527UpaHVKJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fHKdSAd+bIMDIFjv1VQkygdXDbeaC76BtcOvxnUrwzT9tEtt8qayiqhuCexkqQGOK
         vSAeVfPQl2TAKTE5yuSQ6xYUIwPThjO8oTXU/LXOxBqCjTfPdYvqTKkbW6eqrsmzVV
         UOQ/VStej2fWyctME1BSAc/c+X5oiKJC/CTgFDTs=
Received: by mail-pf1-f171.google.com with SMTP id x18so5734227pfi.9;
        Wed, 19 May 2021 07:33:56 -0700 (PDT)
X-Gm-Message-State: AOAM530aS1uONyRJsUUanXoKcNVAX8aOFv9kkhsO5h7JAiI8/0rUO2sp
        4MUy4XXTi9nYmMDFLP29UpD+fSGI6K6TDHvK4Fg=
X-Google-Smtp-Source: ABdhPJwENqC/Vi2InCMUSwZFz7uN+2ZeNWRSv6GNRL1ERm50moa1CDtwEjLOFYa7WuWjPgCs0eOGDc8adawq3hV/S50=
X-Received: by 2002:aa7:9f5c:0:b029:2de:a5f0:d73b with SMTP id
 h28-20020aa79f5c0000b02902dea5f0d73bmr7960822pfr.41.1621434836421; Wed, 19
 May 2021 07:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
 <YKMKdHPFCNhR1SXx@T590> <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
In-Reply-To: <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 19 May 2021 16:33:19 +0200
X-Gmail-Original-Message-ID: <CAFnufp3ZzrKHiV1Vy9_bAymy0oEr288dL4yWo4EjqUzhJV6J-A@mail.gmail.com>
Message-ID: <CAFnufp3ZzrKHiV1Vy9_bAymy0oEr288dL4yWo4EjqUzhJV6J-A@mail.gmail.com>
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

On Tue, May 18, 2021 at 9:52 AM Prasanna Kalever <pkalever@redhat.com> wrote:
> > BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
> > is added for addressing this issue, what do you think of that generic
> > approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
> > for addressing this issue?
> >
> > https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r
>
> If I understand the changes and the background of the fix correctly, I
> think with that fix author is trying to monotonically increase the seq
> number and add it to the disk on every single device map/attach and
> expose it through the sysfs, which will help the userspace processes
> further to correlate events for particular and specific devices that
> reuse the same loop device.
>

Yes, but nothing prevents to use diskseq in nbd, and increase it on reconfigure.
That would allow to detect if the device has been reconfigured.

Regards,
-- 
per aspera ad upstream
