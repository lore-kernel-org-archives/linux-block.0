Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34177 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeF1H7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 03:59:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id n96-v6so3500497lfi.1
        for <linux-block@vger.kernel.org>; Thu, 28 Jun 2018 00:59:45 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: Add read memory barrier when reading from
 rb
To: hlitz@ucsc.edu
Cc: linux-block@vger.kernel.org, javier@cnexlabs.com,
        marcin.dziegielewski@intel.com, igor.j.konopko@intel.com
References: <1529535298-15465-1-git-send-email-hlitz@ucsc.edu>
 <4ef758b3-f9f0-42b5-c202-6f1491f027aa@lightnvm.io>
 <CAJbgVnUmP6UgA1Mu_do0OLVg2gXrbp7opCVhA6aRD07fxjjk1g@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <3f640809-3093-55da-6014-91b98d7ae642@lightnvm.io>
Date: Thu, 28 Jun 2018 09:59:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAJbgVnUmP6UgA1Mu_do0OLVg2gXrbp7opCVhA6aRD07fxjjk1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/28/2018 01:31 AM, Heiner Litz wrote:
> There is a control dependency between two disjoint variables (only read 
> data if flags == WRITTEN). Because x86-TSO allows re-ordering of loads 
> the control dependency can be violated.

I'm sorry, I do not see it :)

Here is my understanding:

entry->w_ctx.flags is used as a flagging mechanism to wait for data to 
become available when "flags" has PBLK_WRITTEN_DATA.

The later access to entry->data is independent of this. It is assumed 
that entry->w_ctx.flags is the guarding barrier.

Here is the titbit from the control dependency section that makes me say 
that the entry->data loads is not possible to be done before 
entry->w_ctx.flags:

" (*) Control dependencies apply only to the then-clause and else-clause
       of the if-statement containing the control dependency, including
       any functions that these two clauses call.  Control dependencies
       do -not- apply to code following the if-statement containing the
       control dependency."

The read of entry->data must come after the READ_ONCE of 
entry->w_ctx.flags.

> 
> https://www.kernel.org/doc/Documentation/memory-barriers.txt refers to 
> the above scenario as control dependency but your description is of 
> course also correct. Let me know if we should clarify the comment.
> 
> BTW: ARM has an even more relaxed memory model and also allows to 
> re-order writes. If we want to support ARM correctly, I think we also 
> need to insert a memory barrier between writing data and writing flags 
> (and there might be a couple other places where we need to check).
> 
> On Fri, Jun 22, 2018, 11:02 AM Matias Bjørling <mb@lightnvm.io 
> <mailto:mb@lightnvm.io>> wrote:
> 
>     On 06/21/2018 12:54 AM, Heiner Litz wrote:
>      > READ_ONCE does not imply a read memory barrier in the presence of
>     control
>      > dependencies between two separate memory locations (flags and
>     data). On x86
>      > TSO, reading from the data page might be reordered before the
>     flags read.
>      > See chapter CONTROL DEPENDENCIES in
>      > https://www.kernel.org/doc/Documentation/memory-barriers.txt
>      >
>      > Signed-off-by: Heiner Litz <hlitz@ucsc.edu <mailto:hlitz@ucsc.edu>>
>      > ---
>      >   drivers/lightnvm/pblk-rb.c | 3 +++
>      >   1 file changed, 3 insertions(+)
>      >
>      > diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
>      > index a81a97e..5f09983 100644
>      > --- a/drivers/lightnvm/pblk-rb.c
>      > +++ b/drivers/lightnvm/pblk-rb.c
>      > @@ -545,6 +545,9 @@ unsigned int pblk_rb_read_to_bio(struct
>     pblk_rb *rb, struct nvm_rq *rqd,
>      >                       goto try;
>      >               }
>      >
>      > +             /* Observe control dependency between flags and
>     data read */
>      > +             smp_rmb();
>      > +
>      >               page = virt_to_page(entry->data);
>      >               if (!page) {
>      >                       pr_err("pblk: could not allocate write bio
>     page\n");
>      >
> 
>     Hi Heiner,
> 
>     Can you help explain how it is a control dependency? What case am I
>     missing?
> 
>     The way I read the code, there is the case where a read of entry->data
>     happens before entry->w_ctx.flags, but I see that as a memory
>     reordering, which the smp_rmb() fixes. Would that be more accurate?
> 
>     Thank you,
>     Matias
> 
