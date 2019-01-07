Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D4C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 07:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607DF2085A
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 07:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loljrn67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfAGHlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:41:31 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:40140 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfAGHlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 02:41:31 -0500
Received: by mail-vs1-f50.google.com with SMTP id z3so26159933vsf.7;
        Sun, 06 Jan 2019 23:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7l+mW3518jTbvWwRJxxgeUW2983E7kIuwaHs1QI7Gg=;
        b=Loljrn67CbL25joObUtzkjHVH4Uw2iUOVGzjGfvcwMrSs3amDBxNDDO2+KSvBxrwm/
         RwdaWlLKvSpU5XzFtyzbldXzoXIV8lSVMobxmcSSCj4iR3ftTumLnyYrDCLo5fDYZUKy
         lsOlh8k0KsQJHC+s1CCUc0ogVzoQe5YUWEGG3Sz3wwo1XCpdK+zw6xYbN3BI55scjHFF
         WENsodCmQGvqJYUtzao9cSvcTSjI9qR5NtEjyx+7GL8l9CP05F4y5XVPGvP70T4bk/8k
         arWiT9YCVlIf/Dxb8yhtC28jl1RVnOOkUu7HSVzsE3wbDa+s7d/wX9qFHYnsrz9/eJYq
         yQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7l+mW3518jTbvWwRJxxgeUW2983E7kIuwaHs1QI7Gg=;
        b=gp8YLw7HpL2zCPpUGDAGzFZC0c/pVs+JQ5hFKnz1ofg0TWIShT1L7R0rl7l8wBXE8V
         mFgGM89+6ItfJV2SCRaUWyTpreV7nVDlCMS1uMMt51Y2asPP2j2OFZiZl+/l5GLcG5Ek
         OsLXS39yBnbHAMCq8l01o8HwoksASN0T5TwLDPnL2STJPQiGVdoTy8Tgaqj59hYHIZor
         Ly/ZhjsdK4Z0f1Pz852IUavbLjHabwIgQ3jkqFKCzYYLhPHasXfYZVcrvmPmDARkpfTZ
         t+RPXAaqO4/6zf2WYZNJGKYdseXmVcosUZOOtE+1qVxnPNOI/qbYnTs2X5DYdVBHSZfn
         kBKQ==
X-Gm-Message-State: AJcUukeGcHwtkKEIw5y/2eviPa3gJ6NuLBHud8xn8VaGGcju6OduWid3
        l6e52eM3uxOPhXwptcV7JGMnd8F483i6tWQpPjw=
X-Google-Smtp-Source: AFSGD/XqLyaFAGWAQWTTbc2tBsW11RAuGQJawdCiw6yY7hSvvgaptzkuh0l1bCdrC5RS1/99dkZp+Wj6/QB2v7HK9PQ=
X-Received: by 2002:a67:4850:: with SMTP id v77mr25123554vsa.59.1546846889035;
 Sun, 06 Jan 2019 23:41:29 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
 <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
 <1546445424.29282.1.camel@redhat.com> <1546540117.24199.0.camel@redhat.com>
 <1546548458.24199.2.camel@redhat.com> <CALjAwxhOb_HLD1Adux-n0LUienLK_FhrOnyBw=UMLj49aN6_5A@mail.gmail.com>
 <1546555220.2666.1.camel@redhat.com> <CALjAwxgtCGLEJkV3xw4Amp4gdkuacgmTVkYn=w8ZHucJ6ffDew@mail.gmail.com>
 <4c231a3e-1ae3-c872-f6f8-06b19ddfd20b@suse.de>
In-Reply-To: <4c231a3e-1ae3-c872-f6f8-06b19ddfd20b@suse.de>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Mon, 7 Jan 2019 07:41:17 +0000
Message-ID: <CALjAwxiaVRpqgxs4rtjxDM4J5YDnrKAyCwn79h5tdhxwZX8iTA@mail.gmail.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     Hannes Reinecke <hare@suse.de>
Cc:     Laurence Oberman <loberman@redhat.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 7 Jan 2019 at 07:17, Hannes Reinecke <hare@suse.de> wrote:
>
> On 1/4/19 8:33 AM, Sitsofe Wheeler wrote:
> > Blimey Laurence - you're really pushing the boat out on this one!
> >
> [ .. ]
> > I've yet to attach the disk directly to the mobo. It's a bit fiddly as
> > the most accessible port is meant for the DVD drive and I think it's
> > speed is slower than the others.
> >
> > The speed of the ATA ports is lower than you might expect (this
> > machine is fairly old):
> >
> [ .. ]
> > [    3.242623] ata2.00: FORCE: horkage modified (noncq)
> > [    3.242683] ata2.00: supports DRM functions and may not be fully accessible
> > [    3.242686] ata2.00: ATA-11: Samsung SSD 860 EVO 500GB, RVT01B6Q,
> > max UDMA/133
> > [    3.242689] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (not used)
> > [    3.245518] ata2.00: supports DRM functions and may not be fully accessible
> > [    3.247611] ata2.00: configured for UDMA/133
>
> 'slower' is an understatement.

Are you surprised that there would be such a dramatic difference in
the speeds between the two SSDs (Samsung 860 EVO, Crucial MX500) on
that particular workload in that same machine?

> That adapter can't do NCQ, hence 'WRITE FPDMA QUEUED' (which _is_ an NCQ
> command) will never be issued.
> So I'd be _very_ surprised if you still see this problem there ...

I'm curious, why would using the libata.force=2.00:noncq kernel
command line (only mentioned in my very first mail) make using that
drive more stable if the adapter could never accept that command
anyway? Shouldn't the sending of that command have been disabled if
anything along the way can't actually accept it?

-- 
Sitsofe | http://sucs.org/~sits/
