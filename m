Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72607C5519F
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 09:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F081F2224C
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 09:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="SHXWMa+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgKTJMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgKTJMH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 04:12:07 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D5C0613CF
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 01:12:07 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id h23so9262564ljg.13
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 01:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYwHjbKEpls2WUbFGvsAlTnALvxjY3C45fMPKOCCdWo=;
        b=SHXWMa+QBbvSWXTVTvc9oCEYja53wrH4XnNDPeDjBZ+0PzbUw/zJjF0sOwfukdto2I
         yv4yeH324vWGnkO3rxD77aI3dC+Y7Nna31AhnQIDQ9yic0vUGsrNF06nsfiEwsD47Kro
         UAi8KcIpnD8LZMUU1t1HDrAtiS/irUs9O71BHRasiL5n9VXF52ZIdC9wLjq86Qu22owJ
         kMhLLzuIm7a6dgG6k1Si7fbwfZdq16DMcWEk7EETvYItWfSJTBFCIfLok5+DvbAbsi3r
         S+o7ch2CzwMiFWx81DFF1H1ms+b082ZMsq6ftLFKcUJSGVL4uqQ8C5KS28zlaooJLeZK
         WnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYwHjbKEpls2WUbFGvsAlTnALvxjY3C45fMPKOCCdWo=;
        b=J77fbbuDsIsT790ecrxsGNcsKymXgbkug1N+WWQtbqBBOCr2wucigkpb79Bp0d6D7A
         QLeuvyvDhO+dZvF+9wWZk5INP7vkXeY5Czwt2ru0sDAFW76U1PDHjIoVAygGEO0AmEA0
         jgDTVW5UnEDDjKImQbf/k6DjUa+UJtbgemyWJkSDHhs5H6SAZ6l6yMNgGg1oruJUp1XP
         7aDMKUskCxZ7bZNJK7aC0iAQqGsW1N/JYxxFkjPxGXEZ/bwOEAzQ+4CqeekNWvrXYr76
         oEN3+wBR0h3mXFiG+It6/4S71p1bAH3tkotRswefjW0ks7p0ssQU1KgrnpRUtpogXmbc
         cLrA==
X-Gm-Message-State: AOAM530wEL8Ivgg7y3qEdFZ2SCCXTNwcvAPLYcaibnd5FWGVg7L/MXNL
        k+eeMXrk5vE8roCiDD97H7D2S7M1QmP0+WFN90bm
X-Google-Smtp-Source: ABdhPJxe3gqqTHhUOIoW4RhjpAyW8nk/gUrLRGbbSANUyqjh2R+b6qVn3dxWsuAQG4KNWibj/6cGMLuL7fDMiZQUMEw=
X-Received: by 2002:a2e:a164:: with SMTP id u4mr7809363ljl.75.1605863525418;
 Fri, 20 Nov 2020 01:12:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org> <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org> <CAHg0HuxJ-v7WgqbU62zkihquN9Kyc9nPzGhcung+UyFOG7LECQ@mail.gmail.com>
 <a1446914-1388-40af-4204-5ef8b7618b42@acm.org>
In-Reply-To: <a1446914-1388-40af-4204-5ef8b7618b42@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 20 Nov 2020 10:11:54 +0100
Message-ID: <CAHg0Huy6U5hKUVjPt0PtZQJ2ur7gFveZjnq_MV-vE4hF2d6f0Q@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Sun, Sep 27, 2020 at 2:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-09-09 04:42, Danil Kipnis wrote:
> > On Fri, Sep 4, 2020 at 5:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 2020-09-04 04:35, Danil Kipnis wrote:
> >>> On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >>>> How will it be guaranteed that the resulting software does
> >>>> not suffer from the problems that have been solved by the introduction
> >>>> of the DRBD activity log
> >>>> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?
> >>>
> >>> The above would require some kind of activity log also, I'm afraid.
> >>
> >> How about collaborating with the DRBD team? My concern is that otherwise
> >> we will end up with two drivers in the kernel that implement block device
> >> replication between servers connected over a network.
> >
> > I have two general understanding questions:
> > - What is the conceptual difference between DRBD and an md-raid1 with
> > one local leg and one remote (imported over srp/nvmeof/rnbd)?
>
> I'm not sure there is a conceptual difference. But there will be a big
> difference in recovery speed after a temporary network outage (assuming that
> the md-raid write intent bitmap has been disabled).

I think RMR is conceptually different to either of the setups
(drbd or md-raid over srp/iser/nvmeof/rnbd devices) in the sense that
the logic required for replication policies (coding) is present inside rdma
subsystem which would allow to potentially offload it to underlying
rdma devices. The user of the rdma enabled devices can then utilize
them for both: block io transport and replication.

Another difference is that one can put a volume manager on top of RMR and
have it work as a distributed one.

>
> > - Is this possible to setup an md-raid1 on a client sitting on top of
> > two remote DRBD devices, which are configured in "active-active" mode?
>
> I don't think that DRBD supports this. From the DRBD source code:
> "this code path is to recover from a situation that "should not happen":
> concurrent writes in multi-primary setup."

This means md-raid on top of two block devices imported over rdma has write
latency twice shorter (while having recovery latency twice as high) as drbd.
RMR would allow for having single hop for both: write IO and resync IO.

Thank you,
Danil.
