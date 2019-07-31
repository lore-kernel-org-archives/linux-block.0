Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8195EC433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57722206A3
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcXSJJiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfGaT47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:56:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45633 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfGaT47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 15:56:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so50187420qkj.12;
        Wed, 31 Jul 2019 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdMBwj24SuBIJnxcz6f6E7XZGCQRqwgOTkOEZF7y7/s=;
        b=ZcXSJJiBkpkPToXGFq7DHCokKWZ058T8iHffmWffteP55NcYi6FqNdZ3MLtRWtxX7V
         EjXmsNsCo0N4k2ibmQW6vi0gttoazQiHOV6x8e7X4hzmw2K7NIOZZSw9NMlQI/xpxD++
         hXTkxlygAgci360srj2X8PiEUBRALJKwsoQ8NmYS64ZRWqirTSb8oJuaC2jqMW2HhHvA
         WySC05IbbYuoCZbL9wa2ejDRgxCt9PLLV9U43lfltE9RHsEXrEA8XMh/Dif194lMUpOL
         KlpBoJ7XdWTt+kN0h+Y/OfAeQPW+SySGD12vvTdRsAb32QkVJY/QuZv7UvvmR3UFJcUP
         l/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdMBwj24SuBIJnxcz6f6E7XZGCQRqwgOTkOEZF7y7/s=;
        b=ZcH4u5oL6nv39zv9C71ju0Bhvu8m+SJVJy0h0F+AylJGASrDz4pCBbFPJ+qL3DwqWY
         Bmw6VgXEdrkkNdpFnDntGk8IKizE5BDQjftwdlO9mYFZzY02DVsuVJNgIQlE91k+Baiq
         YWJoJ7T9XAWcjgKAeZqsNgEyPQ7gvLJKCBgo8VekNGgzEiOFugXS5O4bEhrykZbRhN8T
         6v12ZO2ppEHjTNxgGbPCPnipMSpywCZjXdGrG72xQIG2QvbkWVQp3Q5dZZebWk/GY3Ft
         SfhqtMUmf9QtRWUG+o8CK1kCHnfMmWJIsHHy/vNMzdRe9m88nIIO+PCmS/7hFFsbSKq3
         VbFQ==
X-Gm-Message-State: APjAAAXI3RY3TKsD74eQMndKFjY/Dm3sBoOr4WwQt9/Hsi/FRn0kPRmD
        urCCEAQJO/FUQQboMJoMrrApXbS6TErIuRREHf5rjQ==
X-Google-Smtp-Source: APXvYqwhmDOGHzO9U0ftdB8CX5f/DjWHe/iKI49iVdsrJr6J3fsBH+lgXpvFwQEagC14twk/VAzT9owYPHQDI3PwrUc=
X-Received: by 2002:a37:a854:: with SMTP id r81mr83186128qke.378.1564603018768;
 Wed, 31 Jul 2019 12:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <87zhkwl6ya.fsf@notabene.neil.brown.name> <6400083b-3cf3-cbc6-650a-c3ae6629b14c@canonical.com>
 <CAPhsuW69YrpHqBCOob2b5wzzWS9FM087sfe3iC0odX8kZWRwmA@mail.gmail.com>
In-Reply-To: <CAPhsuW69YrpHqBCOob2b5wzzWS9FM087sfe3iC0odX8kZWRwmA@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 31 Jul 2019 12:56:47 -0700
Message-ID: <CAPhsuW5zB=Kik4rq9YA-xBer7Z-h-23QV4WSCWe-jvhFgGc0Cw@mail.gmail.com>
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is gone
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <songliubraving@fb.com>, dm-devel@redhat.com,
        Neil F Brown <nfbrown@suse.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 12:54 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Tue, Jul 30, 2019 at 5:31 AM Guilherme G. Piccoli
> <gpiccoli@canonical.com> wrote:
> >
> > On 29/07/2019 21:08, NeilBrown wrote:
> > >[...]
> > >> +    if (unlikely(test_bit(MD_BROKEN, &mddev->flags))) {
> > >> +            bio_io_error(bio);
> > >> +            return BLK_QC_T_NONE;
> > >> +    }
> > >
> > > I think this should only fail WRITE requests, not READ requests.
> > >
> > > Otherwise the patch is probably reasonable.
> > >
> > > NeilBrown
> >
> > Thanks for the feedback Neil! I thought about it; it seemed to me better
> > to deny/fail the reads instead of returning "wrong" reads, since a file
> > read in a raid0 will be incomplete if one member is missing.
> > But it's fine for me to change that in the next iteration of this patch.
>
> For reads at block/page level, we will either get EIO or valid data, right?
>
> If that's not the case, we should fail all writes.

Oops, I meant all _reads_.

>
> Thanks,
> Song
