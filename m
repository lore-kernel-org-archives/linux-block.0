Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36011 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeHYH3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Aug 2018 03:29:46 -0400
Received: by mail-it0-f46.google.com with SMTP id p16-v6so4395606itp.1
        for <linux-block@vger.kernel.org>; Fri, 24 Aug 2018 20:52:19 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKEdd+7fzAgbgjEiHNPwVs6Hi6j_J3mB1R-8jubaCgy6-A@mail.gmail.com>
 <3038babc-1470-b69b-61c9-4a60fba4f0a7@grimberg.me>
In-Reply-To: <3038babc-1470-b69b-61c9-4a60fba4f0a7@grimberg.me>
MIME-Version: 1.0
Date: Fri, 24 Aug 2018 21:52:17 -0600
Message-ID: <b0131d408fa0cc87aa624b577c0a71e4@mail.gmail.com>
Subject: RE: [RFC0/1] megaraid_sas : IRQ polling using threaded interrupt
To: Sagi Grimberg <sagi@grimberg.me>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Peter Rivera <peter.rivera@broadcom.com>,
        Steve Hagan <steve.hagan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> >
> >   I am trying to evaluate the similar concept to reduce interrupts
> > using irq-poll and threaded ISR. Below is high level changes I did in
> > my experiment.
>
> You want to reduce interrupts because you want to fix a bug where
> your driver never exit from hard-irq? or trying to optimize the
> efficiency of the system?

We have already adopted irq-poll interface to avoid any hard-lockup issue.
This time, I want to evaluate multiple options to reduce interrupts per
seconds for MegaRaid and HBA.
In certain cases, we observe that IOPs are not scaling mainly because of
each IO completion happens with one interrupt.

>
> > In megaraid_sas driver, I schedule irq poll using =E2=80=9Cirq_poll_sch=
ed=E2=80=9D and
> > disable that particular IRQ line. I was expecting more completion
> > after I disable irq line, but in most of the cases  just one
> > completion happened from irq poll context. It must be due to host side
> > processing is much faster than IO processing at back end device.
> > Similar observation was posted in above mentioned thread as well.
>
> Is your device able to coalesce interrupts?

Yes, our device is capable of doing interrupt coalescing. That interface is
already in plan for this exercise.  Disadvantage of allowing h/w doing
interrupt coalescing is low QD profiles. We see latency goes high upto 20%
and we want to avoid that as well.

>
> > I added manual wait using =E2=80=9Cudelay()=E2=80=9D and wait for some =
more time in irq
> > poll context. Using additional wait, I am able to reduce interrupt per
> > seconds and performance impact on latency is not visible since I
> > choose udelay(1). One drawback I see is overall CPU utilization goes
> > up since driver is using extra delay to reduce interrupts.
> >
> >   To overcome CPU utilization issue, I switch to threaded ISR and
> > replace udelay() with usleep().  Using threaded interrupt based
> > polling CPU utilization goes to normal.
>
> Doesn't sound like the right approach to me, but I don't understand
> what you are trying to achieve.

I posted patch with threaded ISR to do interrupt polling instead of taking
advantage of irq-poll. I can do same thing with irq-poll as well.  In eithe=
r
approach, I found that just doing interrupt disable and polling reply queue
processing does not server purpose. Every time I disable interrupt
(disable_irq_nosync) and start polling of the reply queue, it quits
immediately since CPU processing is much faster compare to IO completion
from backend. Eventually, I have to spend some time after
"disable_irq_nosync" to gain benefit of the polling.  I can not use
sleepable delay in irq-poll, but I can use sleepable delay in threaded isr.
This difference comes with pros and cons. Irq-poll based interface hogs mor=
e
CPU whereas threded isr avoid cpu hogging. I still think that thread-isr is
not a good idea because of fairness as you explained earlier in mentioned
discussion.

My confusion and question is - "threaded ISR is viable option to use for
interrupt polling or irq-poll is suitable design? "
