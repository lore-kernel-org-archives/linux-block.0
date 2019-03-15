Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2071C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC83218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 08:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="oELe57sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCOIe0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:34:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44559 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfCOIe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 04:34:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id b8so4894386vsq.11
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s5upj3v+TSeq1leK9fAsZyA35bnuuGD34MaHoF8Wovc=;
        b=oELe57sNsZVSlcdttIyaeC7KAlvCBASH9QF93WSwUDxIg+1CrtRF1RpKzM9b+HjwGT
         BIHOmR8TfKZopjrL+FtSWIGBQb3XouaNWBT2N3EGmPeaxj/zfOJVfYx9fk/8DfrxTVyp
         ZlAGpvkBWHympzmyvQlgaiilHO8DkCii1ks7f02JVe6ZM1DlbReaIxOqLiSSpA2mubG2
         GyoPtbv/zexGKFstBr83F7stkYri7dSs4veM4B0p+uyauq9kRtCWoBHTDwFi5AfnD2fa
         b6qRVAVvKStlE+21JuETHds0/zbf3bN7m9hGE3nL2ROEVATxSZDUEKCwzOpGJsfNnCrD
         hNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s5upj3v+TSeq1leK9fAsZyA35bnuuGD34MaHoF8Wovc=;
        b=sc+NQyrtm2cNUOMJVhXKMHcy4AK4NWBqLSMPM4l/VYP67emZ1P8wQnLGHoXuoQKdm1
         TDEmhNfsYGineCFBQsti66DJg7z3fMnbLyHWpXS2Ruxek95/G44ZD7zAQgiv3aOO4YyQ
         HZY6DLEYbl+APRaTJUzgdBC0I2nQOXNsAMiOjwqTAowYo8J1/djY8JYmfMh7YeZmVF53
         hb5yW23ZZ+O2+Uh3DWktw7z+TagICIM+Z/LKLYoE+9NFsg9v2dNFY/OCsmGY1TNEvOx8
         TMQJJirZhArzEnw14Mkh0noJaZld7CnxkfU4kSQ+m/0fN9vEXfyzZjttjUI8WQYQUILW
         mCWQ==
X-Gm-Message-State: APjAAAWjaO/8oDupDwR9rt/ETEKOeaoojobnnlNvxtYGyN2ONdj4CBz9
        ckMopnaosejN5BevVsrCR0PpsBk9V62VAPcUEnA22Q==
X-Google-Smtp-Source: APXvYqxKIuoqcCTvQhbTpjvwM8OShctA1QmP+rbImuBsoMDLFsaDkMlX9FrNwfAeLPU9OfcAv1dpbuWgLkcoGwb8k1c=
X-Received: by 2002:a67:ba05:: with SMTP id l5mr1305615vsn.153.1552638865111;
 Fri, 15 Mar 2019 01:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190314111637.20236-1-hans@owltronix.com> <103c19f4-02a2-f54c-13f8-30bc5447426e@intel.com>
 <FE25456B-A63E-4601-960D-96F519250B8C@javigon.com> <CAJbgVnU2RXK4ci79n0szwTpZ+UB2zx977PHo1ie7h5y5kJrbhQ@mail.gmail.com>
In-Reply-To: <CAJbgVnU2RXK4ci79n0szwTpZ+UB2zx977PHo1ie7h5y5kJrbhQ@mail.gmail.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Fri, 15 Mar 2019 09:34:14 +0100
Message-ID: <CANr-nt0DHudD9TFBqLzhgBuYz8GqVbwgiU7W2b5OVsLtpMuu_w@mail.gmail.com>
Subject: Re: [PATCH RFC] lightnvm: pblk: fix crash in pblk_end_partial_read
 due to multipage bvecs
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 14, 2019 at 5:15 PM Heiner Litz <hlitz@ucsc.edu> wrote:
>
> On Thu, Mar 14, 2019 at 7:16 AM Javier Gonz=C3=A1lez <javier@javigon.com>=
 wrote:
> >
> > > On 14 Mar 2019, at 06.49, Igor Konopko <igor.j.konopko@intel.com> wro=
te:
> > >
> > > While reading this patch, idea came to my mind - maybe it would be si=
mply better to get rid of partial read handling from pblk in current form a=
t all and use bio_split() & bio_chain() combination instead?
> > >
> > > This would definitely reduce a number of this 'kind of complicated' c=
ode inside pblk and let block layer help us with that. Even that the perfor=
mance of such a requests could be a little worse (few smaller IOs instead o=
f single vector IO), I believe that partial read is more a corner case, the=
n a typical use case, so maybe this would be a path to go.
> > >
> > > Let me know what you think about such an approach - I can make a patc=
h with that if you want.
>
> I like this idea as it will clean up a lot of code and get rid of the
> read_bitmap.
> Note that a single request can be turned into up to 32 requests if
> cached and non-cached sectors alternate, each one probably requiring
> an l2p lookup. I still think it's worth doing though.
> When you split, note that you have to release all line_refs which were
> acquired during l2p lookup.
>
> >
> > I agree with Igor.
> >

I agree as well, this path deserves some loving care and cleanup.
Let's just try to avoid read tail latency degradation.

Simplifying the code is a great first step, then we can optimize if needed =
be.

Thanks for the feedback y'all!


> > As I mentioned offline, we should fix this in a way that survives
> > further changes in struct bio; either making pblk handling visible to
> > the outside or rethinking the whole thing.
> >
> > Igor: If you can send a patch you mention, it would be great. I have
> > been trying the helper approach for some time, but it is too specific,
> > as fixing holes in the bvec breaks the bio advance-only semantics. Your
> > approach seems much better.
> >
> > Thanks,
> > Javier
