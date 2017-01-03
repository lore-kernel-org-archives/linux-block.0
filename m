Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:36768 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934163AbdACJj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2017 04:39:27 -0500
Received: by mail-wj0-f180.google.com with SMTP id c11so235656614wjx.3
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2017 01:39:26 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [LSF/MM ATTEND AND AGENDA TOPIC] request to attend the summit
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1483431417.2911.1.camel@sandisk.com>
Date: Tue, 3 Jan 2017 10:39:17 +0100
Cc: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "broonie@linaro.org" <broonie@linaro.org>
Message-Id: <C805E81A-2266-4E8D-A8BD-8023165A27FC@linaro.org>
References: <771BC555-46A4-4AE1-BDD5-BFB4E3F065F0@linaro.org> <1483431417.2911.1.camel@sandisk.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 03 gen 2017, alle ore 09:17, Bart Van Assche =
<Bart.VanAssche@sandisk.com> ha scritto:
>=20
> On Mon, 2017-01-02 at 19:14 +0100, Paolo Valente wrote:
>> This is to retry to request to attend the summit.  This time I'm
>> trying to propose and agenda topic too.
>>=20
>> I would like to attend, and propose a topic, because:
>> 1) the project for adding (only) the BFQ I/O scheduler to blk-mq has
>> entered a quite active phase: the framework prepared by Jens seems
>> mostly ready and complete, and I need just a few details to complete
>> the port of BFQ.
>> 2) the landing of BFQ into blk-mq might have possibly important
>> consequences, in a way or the other.
>>=20
>> So, it might be quite useful for me, and possibly for other
>> developers/stakeholders interested in these changes and consequences,
>> to have the opportunity to talk with each other, exactly when, or
>> right after these changes happen.
>>=20
>> In addition, a few months ago Greg KH and James Bottomley even
>> suggested to postpone to this summit, or Vault, the KS discussion =
that
>> I proposed on the unsolved latency problems for which BFQ has been
>> devised.  So, my topic proposal would be exactly this:
>> "Unsolved latency problems, related to I/O, in Linux: consequences on
>> lsb-compliant and Android systems, solutions proposed so far, =
possible
>> next solutions".
>=20
> Hello Paolo,
>=20

Hi Bart

> I agree that it would be useful to discuss blk-mq I/O scheduling =
during
> LSF/MM. However, blk-mq I/O scheduling involves more than what has =
been
> described above.

Definitely.

> The topics I would like to see being discussed are:

I agree on discussing all the points you mention. Some details below.

> * How to add an I/O scheduling API to the blk-mq core. This is what =
Jens
>  is working on =
(http://git.kernel.dk/cgit/linux-block/log/?h=3Dblk-mq-sched).
> * The BFQ for blk-mq patch series once this patch series has been =
posted.
>  If the rules for this edition of LSF/MM are similar to those of =
previous
>  editions then I expect that the LSF/MM program committee will want to
>  see a BFQ for blk-mq implementation posted as patches on a Linux =
kernel
>  mailing list before adding a session about BFQ for blk-mq to the =
LSF/MM
>  agenda.

In this respect, I hope that the committee does not meet too soon.
I'm waiting just for some replies from Jens to complete a first,
postable patch series.  Anyway, even if no patch series is available
yet, I hope it is clear that we are well on the way.  Probably a
matter of one month at most ...

> * Since BFQ has been designed for hard disks and since the approach in =
BFQ
>  for handling deceptive idleness reduces bandwidth, what scheduling
>  algorithm to use for storage media that do not have any moving parts
>  (SSDs and MMC).

I would really like to have the opportunity to debunk this false myth.
BFQ is optimized for rotational as well as non-rotational device.  BFQ
does not keep up only if IOPS go beyond ~50k.  And I'm already
working on this limitation, but, as agreed with Jens, the priority for
the moment is pushing BFQ as it is.

> * How to port the MMC driver to blk-mq. See also Linus Walleij, =
"[PATCH
>  v2] RFD: switch MMC/SD to use blk-mq multiqueueing"
>  (https://www.spinics.net/lists/linux-block/msg07360.html).
>=20
> Something that would also be useful is to describe what you would like =
to
> discuss in a session about BFQ that has not yet been explained in any =
of
> the papers about BFQ, e.g. "High Throughput Disk Scheduling with Fair
> Bandwidth Distribution"
> (http://algo.ing.unimo.it/people/paolo/disk_sched/bfq-techreport.pdf)?
>=20

Yes, I would really like to share the additional ideas that I put in
BFQ.  In fact, for me BFQ is more a collection of ideas than a
monolithic object.  Some of the components I would like to talk about
are, e.g., the automatic detection of soft real-time applications, and
the use of preemption to boost throughput without breaking bandwidth
and latency guarantees.

Thanks,
Paolo

> Thanks,
>=20
> Bart.

