Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B42C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1F6115C
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbhHFTUE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbhHFTUE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 15:20:04 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC68C0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Aug 2021 12:19:47 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id d20so3226582vso.8
        for <linux-block@vger.kernel.org>; Fri, 06 Aug 2021 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6PYzLJt1arhIuX2nMuzTdwdGEkB8jgPEbuOXvTL9es=;
        b=IdpA7MlfC2ny1bDRy9UqmOWEJFZl2r3n1H8sd5gYnEZfZoKnsNSIUjwQ60adN0fs0r
         XJMEtWiKTwkQ9ntZBJdsKFkXpFEgZ8GhEXIl7EHHJ6VnDp1WC1ag5vDEPfKCbBWlbvoB
         f3Q8w9PK903ZqHXvatZ87jBG8S4hjCgPgcG8mu/dEFlPYXojNFb33GSpHK1+uRnsJBfh
         JlZR43J80eelL2ONFemLHPgb/+2faNzL37D1ED/FatFW6cMQPkEErZHio/lPWwspxqdi
         Gm/dkjvq8qTSGkSIeM4CYI1Lps4nUJxuV+bs7bdu5aoPeqTJRoUkH/ZvwBFuoxvuifFM
         d+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6PYzLJt1arhIuX2nMuzTdwdGEkB8jgPEbuOXvTL9es=;
        b=nWxIrE+vkRcDCpY4codFRqHxR6VPG8ql6XfZVtxXvhmE+rcgrvoMW2yIaNUH4HKhOu
         9mBzMMOzJFxx3AR/UtFl7Vzw19/uwI3J4hB8poqdoNNffmr4rdmQphXVTg+RP/RK6Vy0
         wCh61kY7tddDcrClM/64oMqzubZPKE9XlElR+EzcIDvoZ/3flCJZWIgiYXRVGvIM/e+J
         M6y+lTJOjl54qTEa5BR09lLUtH70jtqcyz6166l0qZMCTiXU0p3tjDUVCC3UMHj9kOdL
         xnr009ZhbGYCDIB9JNbtNoGZnRGusAUEvGEYAdOcxC4SeE5YXdbBYLEMLJ/U/Uebs3IQ
         nhcg==
X-Gm-Message-State: AOAM5300+Ri6//M+6hPDqZTnB7PvV1rjPzNTAlQMIQGT6QTG1gAOUzgf
        AIVy9wOR3A8M9rC3hn3zru4mj8PhueWEsPNcgl+LhA==
X-Google-Smtp-Source: ABdhPJxj3UOh4bMNktDpfSGlcv4DDEWQr7zCPXJuX6uYmGyJ0nBxO0c6Vg/cd0F7IXEOTcVLaBY2kAOoNyK++85Q4Cw=
X-Received: by 2002:a67:2c44:: with SMTP id s65mr6485739vss.29.1628277586373;
 Fri, 06 Aug 2021 12:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210505193655.2414268-1-egranata@google.com> <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain> <87pmvlck3p.fsf@redhat.com> <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
In-Reply-To: <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
From:   Enrico Granata <egranata@google.com>
Date:   Fri, 6 Aug 2021 13:19:35 -0600
Message-ID: <CAPR809uuo=5kmzUs3RFp6z_4===R0hxdFiScLPouUS+qxdaVWg@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi folks,
I am back from my leave of absence, so thank you everyone for your patience

This proposal has been outstanding for a while and didn't seem to
receive pushback, especially compared to the initial proposal

Would it be the right time to put this modification up for a vote?

Thanks,
- Enrico

Thanks,
- Enrico


On Wed, Jul 14, 2021 at 8:25 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Jul 14, 2021 at 11:36:58AM +0200, Cornelia Huck wrote:
> > On Wed, Jul 14 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > > On Wed, May 05, 2021 at 12:37:26PM -0700, Enrico Granata wrote:
> > >> ---------- Forwarded message ---------
> > >> From: Enrico Granata <egranata@google.com>
> > >> Date: Wed, May 5, 2021 at 1:37 PM
> > >> Subject: [PATCH v2] Provide detailed specification of virtio-blk
> > >> lifetime metrics
> > >> To: <virtio-dev@lists.oasis-open.org>
> > >> Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> > >> <linux-block@vger.kernel.org>,
> > >> <virtualization@lists.linux-foundation.org>
> > >>
> > >>
> > >> In the course of review, some concerns were surfaced about the
> > >> original virtio-blk lifetime proposal, as it depends on the eMMC
> > >> spec which is not open
> > >>
> > >> Add a more detailed description of the meaning of the fields
> > >> added by that proposal to the virtio-blk specification, as to
> > >> make it feasible to understand and implement the new lifetime
> > >> metrics feature without needing to refer to JEDEC's specification
> > >>
> > >> This patch does not change the meaning of those fields nor add
> > >> any new fields, but it is intended to provide an open and more
> > >> clear description of the meaning associated with those fields.
> > >>
> > >> Signed-off-by: Enrico Granata <egranata@google.com>
> > >> ---
> > >> Changes in v2:
> > >>   - clarified JEDEC references;
> > >>   - added VIRTIO_BLK prefix and cleaned up comment syntax;
> > >>   - clarified reserved block references
> > >>
> > >>  content.tex | 40 ++++++++++++++++++++++++++++++++--------
> > >>  1 file changed, 32 insertions(+), 8 deletions(-)
> > >
> > > Ping?
> > >
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > [Enrico is currently on leave of absence]
> >
> > Is there any outstanding feedback from the linux-block folks? I've lost
> > track of this, I'm afraid. (Your R-b is the only feedback I see on this
> > list...)
> >
> > We can certainly put up a vote. This is one of the things I wanted to
> > see fixed for the next release of the standard.
>
> I have CCed Christoph, linux-block@, and virtualization@. Here is the
> link to the patch that we're discussing:
> https://patchwork.kernel.org/project/linux-block/patch/20210505193655.2414268-1-egranata@google.com/
>
> Stefan
