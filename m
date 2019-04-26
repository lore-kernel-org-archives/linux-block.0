Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FBFC43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BCD206C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="rYfvjc8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfDZQYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:24:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37684 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZQYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 12:24:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id r6so5246918wrm.4
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2019 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UzhCyWVw2ohKAqlWgQxAK1pFWZImjiKlk+1POr4aVyE=;
        b=rYfvjc8pDeEnoXFyh0FcY5gFVGfdHYxr43H7Taz7k/21srXuCPCjn6AQvrCWRCqdKW
         xgZFeh9Hchpzd2GZI3xJV6WMPE6ceyLTeQD+sSM/jz4EoOCZIvNnp+7LobYp2BhWja9F
         EsMF9rwYelFUBEblVkBrWNDhhaIxvlUZeCYuQGUS0nDtfTzup0r+H6CIpcxkw6S4X18Y
         hAUY0KowaDPkmZgIEJWpwZ1Y2jRY5iJk8lKOBh/FOxmEuU0Us6/40qBuANgrd7UaOeok
         reClcFDGKBAgIAIWCO3zMTr7x+pHHWgkN0A/OUuTZ1E9Ji0R5HN8Xm5dJ5QNE1VCDfj3
         1Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UzhCyWVw2ohKAqlWgQxAK1pFWZImjiKlk+1POr4aVyE=;
        b=VAMHFBrFmQEbo02qOVAB+JlgpbyU5FMmNJxu67fQ+xbrmdPQiW7G1jGB6i4P2E3eBe
         vDD16zapImMfX5R+wDASUyAzUimbD5qE9eHz62NkJQykQ+5qO/yhXNpQ41RiT0YXFm41
         moM4OXCOiizMFW1HJZlUFP66YCCbJUISnRi1EFAWNmXCv+VALhAA+k45WCZvPaJBQk8L
         4gWfBAq3K0uceRs7p4VCZ5uRwMRHDg4HY3wTo001zCgIpvdsmltimQPwVJusSAoplsTC
         IGxKYGL18DCQUbSG2u2x7vjifyVdhJIF6fHTXfm1RWAaRY8SEmFZXlAXCHki7+n4QJC9
         x0SQ==
X-Gm-Message-State: APjAAAVDPUfCHHJHBLB2IgRS2ZzaXPXDhw6CVJ/+VD94dq/q25BWhDRf
        F6tCNXD0hLKvXISwOKWzzKEoGIlnjZiHihkHG6cjMQ==
X-Google-Smtp-Source: APXvYqyNQtA10mj+UkS+PgFWurtyKJGpvmkrWdZUeuJZ8s9rM9xvJdBA6xCjOCzRLoQvvRuvG4wcHz9ZZLHdV3xmqRE=
X-Received: by 2002:a5d:4e92:: with SMTP id e18mr249636wru.302.1556295847150;
 Fri, 26 Apr 2019 09:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190425052152.6571-1-hlitz@ucsc.edu> <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
 <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com> <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
In-Reply-To: <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Fri, 26 Apr 2019 09:23:55 -0700
Message-ID: <CAJbgVnWsHQRpEPkd77E6u0hoW5jKQaOGR-3dW9+drGNq_JYpfA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nice catch Igor, I hadn't thought of that.

Nevertheless, here is what I think: In the absence of a flush we don't
need to enforce ordering so we don't care about recovering the older
gc'ed write. If we completed a flush after the user write, we should
have already invalidated the gc mapping and hence will not recover it.
Let me know if I am missing something.

On Fri, Apr 26, 2019 at 6:46 AM Igor Konopko <igor.j.konopko@intel.com> wro=
te:
>
>
>
> On 26.04.2019 12:04, Javier Gonz=C3=A1lez wrote:
> >
> >> On 26 Apr 2019, at 11.11, Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
> >>
> >> On 25.04.2019 07:21, Heiner Litz wrote:
> >>> Introduce the capability to manage multiple open lines. Maintain one =
line
> >>> for user writes (hot) and a second line for gc writes (cold). As user=
 and
> >>> gc writes still utilize a shared ring buffer, in rare cases a multi-s=
ector
> >>> write will contain both gc and user data. This is acceptable, as on a
> >>> tested SSD with minimum write size of 64KB, less than 1% of all write=
s
> >>> contain both hot and cold sectors.
> >>
> >> Hi Heiner
> >>
> >> Generally I really like this changes, I was thinking about sth similar=
 since a while, so it is very good to see that patch.
> >>
> >> I have a one question related to this patch, since it is not very clea=
r for me - how you ensure the data integrity in following scenarios:
> >> -we have open line X for user data and line Y for GC
> >> -GC writes LBA=3DN to line Y
> >> -user writes LBA=3DN to line X
> >> -we have power failure when both line X and Y were not written complet=
ely
> >> -during pblk creation we are executing OOB metadata recovery
> >> And here is the question, how we distinguish whether LBA=3DN from line=
 Y or LBA=3DN from line X is the valid one?
> >> Line X and Y might have seq_id either descending or ascending - this w=
ould create two possible scenarios too.
> >>
> >> Thanks
> >> Igor
> >>
> >
> > You are right, I think this is possible in the current implementation.
> >
> > We need an extra constrain so that we only GC lines above the GC line
> > ID. This way, when we order lines on recovery, we can guarantee
> > consistency. This means potentially that we would need several open
> > lines for GC to avoid padding in case this constrain forces to choose a
> > line with an ID higher than the GC line ID.
> >
> > What do you think?
>
> I'm not sure yet about your approach, I need to think and analyze this a
> little more.
>
> I also believe that probably we need to ensure that current user data
> line seq_id is always above the current GC line seq_id or sth like that.
> We cannot also then GC any data from the lines which are still open, but
> I believe that this is a case even right now.
>
> >
> > Thanks,
> > Javier
> >
