Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30AAC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813F4205F4
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 20:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="X8ZDqnM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfEAUUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 16:20:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52666 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAUUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 16:20:16 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so569820itf.2
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fz3GeyUaaYb3iIwSQZ0CUGF73KA0iqI7HPWmL9LCq6Q=;
        b=X8ZDqnM/rjgbw16OSJ0YlnQO23ECayN6t1xXZmY5a17o4WcZp4qds6y7xgLWtvd4SJ
         ouYhgqYRvZfO5tfgcNnPNFj9mbaGttNqEQdCjn6Uc6GpsTVAWNbME5Zw4cQAPnNuk8+k
         sxoeWrAt8GUc+kop2GL6dTVC1oAnja87MB6Mu+BoDoPBb7V+waVmYH1UHqycwL8OVc0S
         EawAyS8aeTYgN6YtuNBRbzVAEx9aF/xmQeMvxabFiz+HBET8nSI1hBewLM+5ThihAyCZ
         caDTcgt2jfJ79e5/OwEgwZFxqjZQj77TbrEApCoUZEEqSPOzwvCForqmjUDkh5fzVoaU
         sVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fz3GeyUaaYb3iIwSQZ0CUGF73KA0iqI7HPWmL9LCq6Q=;
        b=W1i4C5kemZXUiy4ZtwctddBpa2yAAvSBYhYlCbUgb6qqqg5hcxyjWp6B48hSyojwnx
         VWHWB1Zj4MgDGEzqwMOY+8lo3cwZjrFEHurE8s12Lc/M44a8E/zQDwEhkJuHYuWsyoVi
         vKqx3YmNtJsI7cOnukGMgoOyZxmNeN6fGIS7KljDhoX/3RuLPQevo7AhRzUUPmQ5FThu
         pPH0lZ0WQkFj0sAHtznXTZ6NDhQsp+FwWhkG1F4X6k8JRKbnNSCyX16gZ0mIBwH2iwTJ
         RDb6IjUdmAbsxsRCGKwY9eA0TUrFvXne5pEWj/faevnSAst57iXyRND8leSTjHdSUX6E
         tU9Q==
X-Gm-Message-State: APjAAAXc6qen9ViSw8qwKsmEew2fY14qAYbglp/vokUitN5K+FcuNSTj
        Cie8dLz7lFb8uuOFtnat/MwtpEEn+8j5xcJwz8+nGyRYg3s=
X-Google-Smtp-Source: APXvYqx+MzEl+oXGw+4d57VeE1MCe+7iLBBmYipmE9LvnYwHM11DgiFw+r01CaswODN9VmR9c5m4fbLl4bad5QLJsTw=
X-Received: by 2002:a24:920a:: with SMTP id l10mr8932944itd.98.1556742015338;
 Wed, 01 May 2019 13:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190425052152.6571-1-hlitz@ucsc.edu> <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
 <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com> <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
 <CAJbgVnWsHQRpEPkd77E6u0hoW5jKQaOGR-3dW9+drGNq_JYpfA@mail.gmail.com> <139AF16B-E69C-4AA5-A9AC-38576BB9BD4B@javigon.com>
In-Reply-To: <139AF16B-E69C-4AA5-A9AC-38576BB9BD4B@javigon.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Wed, 1 May 2019 13:20:04 -0700
Message-ID: <CAJbgVnWTRWZB_Dc7F1cvtgWdYPCbJ_aJJ_mas01m51+8siHvHA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
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

Javier, Igor,
you are correct. The problem exists if we have a power loss and we
have an open gc and an open user line and both contain the same LBA.
In that case, I think we need to care about the 4 scenarios:

1. user_seq_id > gc_seq_id and user_write after gc_write: No issue
2. user_seq_id > gc_seq_id and gc_write > user_write: Cannot happen,
open user lines are not gc'ed
3. gc_seq_id > user_seq_id and user_write after gc_write: RACE
4. gc_seq_id > user_seq_id and gc_write after user_write: No issue

To address 3.) we can do the following:
Whenever a gc line is opened, determine all open user lines and store
them in a field of pblk_line. When choosing a victim for GC, ignore
those lines.

Let me know if that sounds good and I will send a v2
Heiner

On Tue, Apr 30, 2019 at 11:19 PM Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>
> > On 26 Apr 2019, at 18.23, Heiner Litz <hlitz@ucsc.edu> wrote:
> >
> > Nice catch Igor, I hadn't thought of that.
> >
> > Nevertheless, here is what I think: In the absence of a flush we don't
> > need to enforce ordering so we don't care about recovering the older
> > gc'ed write. If we completed a flush after the user write, we should
> > have already invalidated the gc mapping and hence will not recover it.
> > Let me know if I am missing something.
>
> I think that this problem is orthogonal to a flush on the user path. For =
example
>
>    - Write to LBA0 + completion to host
>    - [=E2=80=A6]
>    - GC LBA0
>    - Write to LBA0 + completion to host
>    - fsync() + completion
>    - Power Failure
>
> When we power up and do recovery in the current implementation, you
> might get the old LBA0 mapped correctly in the L2P table.
>
> If we enforce ID ordering for GC lines this problem goes away as we can
> continue ordering lines based on ID and then recovering sequentially.
>
> Thoughts?
>
> Thanks,
> Javier
>
> >
> > On Fri, Apr 26, 2019 at 6:46 AM Igor Konopko <igor.j.konopko@intel.com>=
 wrote:
> >> On 26.04.2019 12:04, Javier Gonz=C3=A1lez wrote:
> >>>> On 26 Apr 2019, at 11.11, Igor Konopko <igor.j.konopko@intel.com> wr=
ote:
> >>>>
> >>>> On 25.04.2019 07:21, Heiner Litz wrote:
> >>>>> Introduce the capability to manage multiple open lines. Maintain on=
e line
> >>>>> for user writes (hot) and a second line for gc writes (cold). As us=
er and
> >>>>> gc writes still utilize a shared ring buffer, in rare cases a multi=
-sector
> >>>>> write will contain both gc and user data. This is acceptable, as on=
 a
> >>>>> tested SSD with minimum write size of 64KB, less than 1% of all wri=
tes
> >>>>> contain both hot and cold sectors.
> >>>>
> >>>> Hi Heiner
> >>>>
> >>>> Generally I really like this changes, I was thinking about sth simil=
ar since a while, so it is very good to see that patch.
> >>>>
> >>>> I have a one question related to this patch, since it is not very cl=
ear for me - how you ensure the data integrity in following scenarios:
> >>>> -we have open line X for user data and line Y for GC
> >>>> -GC writes LBA=3DN to line Y
> >>>> -user writes LBA=3DN to line X
> >>>> -we have power failure when both line X and Y were not written compl=
etely
> >>>> -during pblk creation we are executing OOB metadata recovery
> >>>> And here is the question, how we distinguish whether LBA=3DN from li=
ne Y or LBA=3DN from line X is the valid one?
> >>>> Line X and Y might have seq_id either descending or ascending - this=
 would create two possible scenarios too.
> >>>>
> >>>> Thanks
> >>>> Igor
> >>>
> >>> You are right, I think this is possible in the current implementation=
.
> >>>
> >>> We need an extra constrain so that we only GC lines above the GC line
> >>> ID. This way, when we order lines on recovery, we can guarantee
> >>> consistency. This means potentially that we would need several open
> >>> lines for GC to avoid padding in case this constrain forces to choose=
 a
> >>> line with an ID higher than the GC line ID.
> >>>
> >>> What do you think?
> >>
> >> I'm not sure yet about your approach, I need to think and analyze this=
 a
> >> little more.
> >>
> >> I also believe that probably we need to ensure that current user data
> >> line seq_id is always above the current GC line seq_id or sth like tha=
t.
> >> We cannot also then GC any data from the lines which are still open, b=
ut
> >> I believe that this is a case even right now.
> >>
> >>> Thanks,
> >>> Javier
