Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37110 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbeGCKO0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jul 2018 06:14:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id q10-v6so1355371wrd.4
        for <linux-block@vger.kernel.org>; Tue, 03 Jul 2018 03:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <1529535298-15465-1-git-send-email-hlitz@ucsc.edu>
 <4ef758b3-f9f0-42b5-c202-6f1491f027aa@lightnvm.io> <CAJbgVnUmP6UgA1Mu_do0OLVg2gXrbp7opCVhA6aRD07fxjjk1g@mail.gmail.com>
 <3f640809-3093-55da-6014-91b98d7ae642@lightnvm.io> <2A35B284-70C5-4EB5-AF4F-63012383295B@cnexlabs.com>
In-Reply-To: <2A35B284-70C5-4EB5-AF4F-63012383295B@cnexlabs.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Tue, 3 Jul 2018 12:14:14 +0200
Message-ID: <CAJbgVnXKmOsZXb+At59SeReRvU7T9piVSLUvc_23W=tn4rwsqA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: Add read memory barrier when reading from rb
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        igor.j.konopko@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Matias,

I think you may be right. I created some test benches and could
produce the error I was expecting. My reasoning was based on the
following:

"This will not have the desired effect because there is no actual data
dependency, but rather a control dependency that the CPU may short-circuit
by attempting to predict the outcome in advance, so that other CPUs see
the load from b as having happened before the load from a.  In such a
case what's actually required is:

q =3D READ_ONCE(a);
if (q) {
<read barrier>
p =3D READ_ONCE(b);
}"

As I understand above, the software gives no guarantee that above
works without the read_barrier. The section somewhat contradicts
Matias's reference. Reading more on x86-TSO it seems as if the
hardware does not allow reordering of read(a) and read(b) so we should
be safe, however, ARM hardware would definitely allow reordering of
the two reads. Summary: The proposed smp_rmb() is not required for x86
but it may be for ARM.

On Thu, Jun 28, 2018 at 10:15 AM Javier Gonzalez <javier@cnexlabs.com> wrot=
e:
>
> > On 28 Jun 2018, at 09.59, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
> >
> > On 06/28/2018 01:31 AM, Heiner Litz wrote:
> >> There is a control dependency between two disjoint variables (only rea=
d data if flags =3D=3D WRITTEN). Because x86-TSO allows re-ordering of load=
s the control dependency can be violated.
> >
> > I'm sorry, I do not see it :)
> >
> > Here is my understanding:
> >
> > entry->w_ctx.flags is used as a flagging mechanism to wait for data to =
become available when "flags" has PBLK_WRITTEN_DATA.
> >
> > The later access to entry->data is independent of this. It is assumed t=
hat entry->w_ctx.flags is the guarding barrier.
>
> This is correct. The motivation is to allow several producers to fill the
> buffer simultaneously.
>
> >
> > Here is the titbit from the control dependency section that makes me
> > say that the entry->data loads is not possible to be done before
> > entry->w_ctx.flags:
> >
> > " (*) Control dependencies apply only to the then-clause and else-claus=
e
> >      of the if-statement containing the control dependency, including
> >      any functions that these two clauses call.  Control dependencies
> >      do -not- apply to code following the if-statement containing the
> >      control dependency."
> >
> > The read of entry->data must come after the READ_ONCE of entry->w_ctx.f=
lags.
> >
>
> I also understood it this way when implementing the barrier, but after
> an offline discussion with Heiner, he convinced me that reordering could
> occur.
>
> >> BTW: ARM has an even more relaxed memory model and also allows to
> >> re-order writes. If we want to support ARM correctly, I think we also
> >> need to insert a memory barrier between writing data and writing
> >> flags (and there might be a couple other places where we need to
> >> check).
>
> Heiner: Can you develop on this?
>
> Javier
