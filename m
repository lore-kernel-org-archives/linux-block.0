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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815AAC433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE5E613B4
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 19:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhEETnI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhEETnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 15:43:07 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8047C061574
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 12:42:10 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id h1so961401uar.0
        for <linux-block@vger.kernel.org>; Wed, 05 May 2021 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpVFqXEuIpJD4j9Rlw4+N7Y4VKXbpflRMpWAe9efIi8=;
        b=RuzDhZXhFuFcJDW/QpE2GoVqPEIZEl9B7s5+pda0lcwwf1pSqdynGpEa4ZsYOTR3YZ
         x7TU6Xu8xL6Ph/QxF/e3lHa7iQZxee76LIsOW4Q8BmaY/2tCwQFaZ1QoAQpP8+uBbOoB
         CpE9X+qdTXQdLHH4T3g3G1BhlUnaRx9eZXcsVdSoGdxUG+ABbLQ+Bmms+3qYSLC/Glsm
         rot36PcbAcOrv5ZQZLfYt3qh6ye2iZud6x4Ms0uC16rIQnUcQaOgjAMCtcTZIX4CXVQS
         CGpgMpiUc5hDamZeODUyjKJpBLq4HzFPYvLc88ztB876DBm0SPn9oqySrIGx6M2Z0v4w
         fERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpVFqXEuIpJD4j9Rlw4+N7Y4VKXbpflRMpWAe9efIi8=;
        b=PGTUPFOo6W9k1jqLEl7JjzMbxRLSo1p92R3Ci5kcVL97e1Qp7kALCt9DcVtH8bLJ8F
         EvXl5StjjIO+vwPMUZneLYGFoztQYYYC9bEJ9A/NvSisC5Drb9MrZ9cBbdnKxl/PgjWd
         UrzptzP/DnZS/mPe8J1dGMVscx1d1VnGCqy/rpy7Rv1nS6EX4CaYTAgFKrrcwSe/4OeQ
         jE6i9nZPFvQCzHoTdg5IFM7e1a3Ib9qCDlVJax6ZWV+qX64sj+eGZYpWiGjYdygpBTHt
         HVkO3QAbOp3OwDKiZ4YDF8LODDtS3F4Q+iv99r7I/3wzb/gU+7uafk7eIl2n4/uUQv8y
         KBIQ==
X-Gm-Message-State: AOAM531H/+ulgxPikeuM/S3tv9gpfO93ahA8GichM6SNC7buUNxdBtC3
        sbvjjbhpP9b0Dd/0RyhkKcFXg8+x1Hzwr3Vpwqd59A==
X-Google-Smtp-Source: ABdhPJyVyRXGeTFae1iU0zru7j4Eh65UtsGgHIBEQ4Nvx57sV/0nGgiOcP/XUfef77y23uIpIZq9TgjKCKMUwRwVeII=
X-Received: by 2002:ab0:c18:: with SMTP id a24mr849019uak.68.1620243729808;
 Wed, 05 May 2021 12:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210420162556.217350-1-egranata@google.com> <20210502045740-mutt-send-email-mst@kernel.org>
 <20210505062458-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210505062458-mutt-send-email-mst@kernel.org>
From:   Enrico Granata <egranata@google.com>
Date:   Wed, 5 May 2021 13:41:58 -0600
Message-ID: <CAPR809te6JhRgdKXoxNO2JVbwJgD-=b0E-oUxj__f+MbM+ZQfw@mail.gmail.com>
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime metrics
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks everyone for the feedback thus far; I just sent out a v2 patch
based on everyone's comments
I am happy to see the discussion moving forward here and I look
forward to your continued input

On Wed, May 5, 2021 at 4:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, May 02, 2021 at 05:12:14AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> > > In the course of review, some concerns were surfaced about the
> > > original virtio-blk lifetime proposal, as it depends on the eMMC
> > > spec which is not open
> > >
> > > Add a more detailed description of the meaning of the fields
> > > added by that proposal to the virtio-blk specification, as to
> > > make it feasible to understand and implement the new lifetime
> > > metrics feature without needing to refer to JEDEC's specification
> > >
> > > This patch does not change the meaning of those fields nor add
> > > any new fields, but it is intended to provide an open and more
> > > clear description of the meaning associated with those fields.
> > >
> > > Signed-off-by: Enrico Granata <egranata@google.com>
> >
> > Enrico it's great that you are reaching out to the
> > wider storage community before making spec changes.
> >
> > Christoph could you please comment on whether this addresses
> > your concerns with the lifetime feature.
> > You wrote "it really needs to stand a lone and be properly documented"
> > and this seems to be the direction this patch is going in.
> >
> >
> > > ---
> > >  content.tex | 34 +++++++++++++++++++++++++++-------
> > >  1 file changed, 27 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index 9232d5c..7e14ccc 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -4669,13 +4669,32 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> > >  \end{lstlisting}
> > >
> > >  The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
> > > -and \field{device_lifetime_est_b} have the semantics described by the JESD84-B50
> > > -specification for the extended CSD register fields \field{PRE_EOL_INFO}
> > > -\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
> > > -respectively.
> > > +and \field{device_lifetime_est_b} are discussed in the JESD84-B50 specification.
> > >
> > > -JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> > > -pursuant to JEDEC's licensing terms and conditions.
> > > +The complete JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> > > +pursuant to JEDEC's licensing terms and conditions.
> >
> > These links really belong in either normative or non-normative
> > references section.
> >
> > > For the purposes of this
> > > +specification, these fields are defined as follows.
> >
> > All this seems kind of vague. What does one need that spec for?
> > Is it just a note for pass-through developers?
> >

Moved these comments and clarified intent in patch v2

> > How about "to simplify pass-through
> > from eMMC devices the format of fields
> >   pre_eol_info, device_lifetime_est_typ_a and device_lifetime_est_typ_b
> > matches PRE_EOL_INFO, DEVICE_LIFETIME_EST_TYP_A and DEVICE_LIFETIME_EST_TYP_B
> > in the
> > \hyperref[intro:PCI]{[PCI]}.
> >
> >
> >
> > Also, now that I mention it, what about NVMe pass-through? Arguably
> > nvme is getting more popular. Will we be able to support that use-case
> > as well? Or is more data needed? What is the plan there?
> >

Given my use case and expertise I have not looked into NMVe at the moment.
I see a possible option, i.e. rename the F_LIFETIME flag to
F_EMMC_LIFETIME, and leave everything else as-is
When someone (myself or others) wants to add NMVe support, add a F_NMVE_LIFETIME
Then T_LIFETIME could return either the existing eMMC data structures,
or the new NMVe data structures depending on which
feature flag is exposed.
The only issue here would be that you could not support both at the
same time, but I am personally not convinced that this would be a
major issue, as I imagine most implementations would be passthroughs
of what the underlying host hardware is offering, and so you
would provide NMVe info on NMVe hardware and eMMC info on eMMC hardware.
What do you think?

> > > +
> > > +The \field{pre_eol_info} will have one of these values:
>
> Besides specifying the values what does it mean exactly?
> E.g. what are blocks?
>
> E.g. "pre_eol_info specifies the percentage of blocks consumed
> on the device" and explain what blocks are here.
>

Specified in v2 patch

> > > +
> > > +\begin{lstlisting}
> > > +// Value not available
> > > +#define PRE_EOL_INFO_UNDEFINED    0
> > > +// < 80% of blocks are consumed
> > > +#define PRE_EOL_INFO_NORMAL       1
> > > +// 80% of blocks are consumed
> > > +#define PRE_EOL_INFO_WARNING      2
> > > +// 90% of blocks are consumed
> > > +#define PRE_EOL_INFO_URGENT       3
> > > +// All others values are reserved
>
>
> Also please prefix with VIRTIO_BLK_ for consistency.
>
> >
> >
> > Block comments /* */ should be used as these are documented
> > in the introduction.
> >

Both addressed in v2 patch

> > > +\end{lstlisting}
> > > +
> > > +The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and is provided in
> > > +increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime used, and so on,
> > > +thru to 11 meaning estimated lifetime exceeded. All values above 11 are reserved.
> > > +
> > > +The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided with
> > > +the same semantics as \field{device_lifetime_est_typ_a}.
> > >
> > >  The final \field{status} byte is written by the device: either
> > >  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> > > @@ -4812,7 +4831,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> > >  or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
> > >  flag. The flag MUST NOT be offered if the device is backed by storage for which
> > >  the lifetime metrics described in this document cannot be obtained or for which
> > > -such metrics have no useful meaning.
> > > +such metrics have no useful meaning. If the metrics are offered, the device MUST NOT
> > > +send any reserved values, as defined in this specification.
> > >
> > >  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
> > >  When using the legacy interface, transitional devices and drivers
> > > --
> > > 2.31.1.368.gbe11c130af-goog
> > >
>
