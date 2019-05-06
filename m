Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A0C04AAC
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 05:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8785A2087F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 05:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="O/PZC2uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfEFFQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 01:16:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEFFQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 01:16:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so5371940wrn.4
        for <linux-block@vger.kernel.org>; Sun, 05 May 2019 22:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jCh6x+ORi5EWv/IlypawahbbvpnK5RHTjISz62KuNKg=;
        b=O/PZC2uANw4749yGxquasq82LLBwHsDNYDcytpi8MLvw8XUUWK3lDggrfpWl+FsV8S
         dNE8ALd6B+SRamBl6n6yaRzROVtPN6QRl7VO46g0bAmW+VBC7rBQ6TGbgOrLifoEBOiN
         aRSWUOFgTXgqNsYEjgN+golZVOJBQmJY+/EvLNRTdOIfdxsYsmyv8XvdoZW/WNTlRKn8
         mLs8j003f2pqKvF8mfTL/Ra55S8bp9iLinYFxkxzCN5htz+REXwUZ2wmhrmf3KQzzYO5
         QNLo+eJRbPgU/clyxPb03HGxYzpQRmMb8ZuKCJPVjj9/Hme17ypQ7+IEuu6ZlidXCIu+
         yNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jCh6x+ORi5EWv/IlypawahbbvpnK5RHTjISz62KuNKg=;
        b=baT0MQGZfCn2rXZDCNluiHpIE4mTYU3/lNPaowzrCPAmxinmMprarBZ6ODVX9L0VHu
         n8umBmaBgJwr4XqsPgFxgIpKt8q9M2yYtp3xRfUK9yURNjiGOfVaOMIxtHQnAo+1QZzI
         RiA5tzkVgIKEOW5L/3ZzCahe6g+6weMri6/JjvP0MmE0HX1s1XiFxO1MSmP1n1wGmRM3
         3g7aIJuoEmLwEcEm5e3jO1jUXLt4EoeErD4M0EVSFcGHUCOgRBPZPDiwLOSs/9YMPDMC
         vmPdZroDIl8yuABuAupnQtxTBcgEEVeUnPIOmJ87jzwWKP1pur76NID4LWl0IyTbMNnR
         z1EA==
X-Gm-Message-State: APjAAAVbQl9PEXSBQJSA87F/4/Svda1nsmtsEqJZHP6cDqKX/gb6Rx6q
        gn9vFXiJXM7Fpq8IAHLL6wc8m2jSB+ugMnFezpgZjA==
X-Google-Smtp-Source: APXvYqyNBjTLPxpA6Ti+erKMILGxw3zCHWCnIs8szraaRWWeF0H22yGhvqPUwRnLS1VQrUjg0jMvJ6T198uU1y8ou64=
X-Received: by 2002:adf:f9c5:: with SMTP id w5mr91669wrr.26.1557119784614;
 Sun, 05 May 2019 22:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190425052152.6571-1-hlitz@ucsc.edu> <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
 <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com> <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
 <CAJbgVnWsHQRpEPkd77E6u0hoW5jKQaOGR-3dW9+drGNq_JYpfA@mail.gmail.com>
 <139AF16B-E69C-4AA5-A9AC-38576BB9BD4B@javigon.com> <CAJbgVnWTRWZB_Dc7F1cvtgWdYPCbJ_aJJ_mas01m51+8siHvHA@mail.gmail.com>
 <b7c03f26-90bb-ffd6-e744-6daf3bbe348d@intel.com>
In-Reply-To: <b7c03f26-90bb-ffd6-e744-6daf3bbe348d@intel.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Sun, 5 May 2019 22:16:13 -0700
Message-ID: <CAJbgVnU3-ed42CBtPv7SWdtA=__bNcSPhiXwobuVKek2-BFBig@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
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

Igor, Javier,

both of you are right. Here is what I came up with after some more thinking=
.

We can avoid the races in 2. and 3. with the following two invariants:
I1: If we have a GC line with seq_id X, only garbage collect from
lines older than X (this addresses 2.)
I2: Guarantee that the open GC line always has a smaller seq_id than
all open user lines (this addresses 3)

We can enforce I2 by adding a minor seq_id. The major sequence id is
only incremented when allocating a user line. Whenever a GC line is
allocated we read the current major seq_id (open user line) and
increment the minor seq_id. This allows us to order all GC lines
before the open user line during recovery.

Problem with this approach:
Consider the following example: There exist user lines U0, U1, U2
(where 0,1,2 are seq_ids) and a non-empty GC5 line (with seq_id 5). If
we now do only sequential writes all user lines will be overwritten
without GC being required. As a result, data will now reside on U6,
U7, U8. If we now need to GC we cannot because of I1.
Solution: We cannot fast-forward the GC line's seq_id because it
contains old data, so pad the GC line with zeros, close it and open a
new GC9 line.

Generality:
This approach extends to schemes that use e.g. hot, warm, cold open
lines (adding a minor_minor_seq_id)

Heiner


On Thu, May 2, 2019 at 2:08 AM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
>
>
> On 01.05.2019 22:20, Heiner Litz wrote:
> > Javier, Igor,
> > you are correct. The problem exists if we have a power loss and we
> > have an open gc and an open user line and both contain the same LBA.
> > In that case, I think we need to care about the 4 scenarios:
> >
> > 1. user_seq_id > gc_seq_id and user_write after gc_write: No issue
> > 2. user_seq_id > gc_seq_id and gc_write > user_write: Cannot happen,
> > open user lines are not gc'ed
>
> Maybe it would be just a theoretical scenario, but I'm not seeing any
> reason why this cannot happen in pblk implementation:
> Let assume that user line X+1 is opened when GC line X is already open
> and the user line is closed when GC line X is still in use. Then GC
> quickly choose user line X+1 as a GC victim and we are hitting 2nd case.
>
> > 3. gc_seq_id > user_seq_id and user_write after gc_write: RACE
> > 4. gc_seq_id > user_seq_id and gc_write after user_write: No issue
> >
> > To address 3.) we can do the following:
> > Whenever a gc line is opened, determine all open user lines and store
> > them in a field of pblk_line. When choosing a victim for GC, ignore
> > those lines.
>
> Your solution sounds right, but I would extend this based on my previous
> comment to 2nd case by sth like: during opening new user data also add
> this line ID to this "blacklist" for the GC selection.
>
> Igor
>
> >
> > Let me know if that sounds good and I will send a v2
> > Heiner
> >
> > On Tue, Apr 30, 2019 at 11:19 PM Javier Gonz=C3=A1lez <javier@javigon.c=
om> wrote:
> >>
> >>> On 26 Apr 2019, at 18.23, Heiner Litz <hlitz@ucsc.edu> wrote:
> >>>
> >>> Nice catch Igor, I hadn't thought of that.
> >>>
> >>> Nevertheless, here is what I think: In the absence of a flush we don'=
t
> >>> need to enforce ordering so we don't care about recovering the older
> >>> gc'ed write. If we completed a flush after the user write, we should
> >>> have already invalidated the gc mapping and hence will not recover it=
.
> >>> Let me know if I am missing something.
> >>
> >> I think that this problem is orthogonal to a flush on the user path. F=
or example
> >>
> >>     - Write to LBA0 + completion to host
> >>     - [=E2=80=A6]
> >>     - GC LBA0
> >>     - Write to LBA0 + completion to host
> >>     - fsync() + completion
> >>     - Power Failure
> >>
> >> When we power up and do recovery in the current implementation, you
> >> might get the old LBA0 mapped correctly in the L2P table.
> >>
> >> If we enforce ID ordering for GC lines this problem goes away as we ca=
n
> >> continue ordering lines based on ID and then recovering sequentially.
> >>
> >> Thoughts?
> >>
> >> Thanks,
> >> Javier
> >>
> >>>
> >>> On Fri, Apr 26, 2019 at 6:46 AM Igor Konopko <igor.j.konopko@intel.co=
m> wrote:
> >>>> On 26.04.2019 12:04, Javier Gonz=C3=A1lez wrote:
> >>>>>> On 26 Apr 2019, at 11.11, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
> >>>>>>
> >>>>>> On 25.04.2019 07:21, Heiner Litz wrote:
> >>>>>>> Introduce the capability to manage multiple open lines. Maintain =
one line
> >>>>>>> for user writes (hot) and a second line for gc writes (cold). As =
user and
> >>>>>>> gc writes still utilize a shared ring buffer, in rare cases a mul=
ti-sector
> >>>>>>> write will contain both gc and user data. This is acceptable, as =
on a
> >>>>>>> tested SSD with minimum write size of 64KB, less than 1% of all w=
rites
> >>>>>>> contain both hot and cold sectors.
> >>>>>>
> >>>>>> Hi Heiner
> >>>>>>
> >>>>>> Generally I really like this changes, I was thinking about sth sim=
ilar since a while, so it is very good to see that patch.
> >>>>>>
> >>>>>> I have a one question related to this patch, since it is not very =
clear for me - how you ensure the data integrity in following scenarios:
> >>>>>> -we have open line X for user data and line Y for GC
> >>>>>> -GC writes LBA=3DN to line Y
> >>>>>> -user writes LBA=3DN to line X
> >>>>>> -we have power failure when both line X and Y were not written com=
pletely
> >>>>>> -during pblk creation we are executing OOB metadata recovery
> >>>>>> And here is the question, how we distinguish whether LBA=3DN from =
line Y or LBA=3DN from line X is the valid one?
> >>>>>> Line X and Y might have seq_id either descending or ascending - th=
is would create two possible scenarios too.
> >>>>>>
> >>>>>> Thanks
> >>>>>> Igor
> >>>>>
> >>>>> You are right, I think this is possible in the current implementati=
on.
> >>>>>
> >>>>> We need an extra constrain so that we only GC lines above the GC li=
ne
> >>>>> ID. This way, when we order lines on recovery, we can guarantee
> >>>>> consistency. This means potentially that we would need several open
> >>>>> lines for GC to avoid padding in case this constrain forces to choo=
se a
> >>>>> line with an ID higher than the GC line ID.
> >>>>>
> >>>>> What do you think?
> >>>>
> >>>> I'm not sure yet about your approach, I need to think and analyze th=
is a
> >>>> little more.
> >>>>
> >>>> I also believe that probably we need to ensure that current user dat=
a
> >>>> line seq_id is always above the current GC line seq_id or sth like t=
hat.
> >>>> We cannot also then GC any data from the lines which are still open,=
 but
> >>>> I believe that this is a case even right now.
> >>>>
> >>>>> Thanks,
> >>>>> Javier
