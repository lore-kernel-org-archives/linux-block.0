Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43891 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHYGLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Aug 2018 02:11:49 -0400
Subject: Re: [RFC0/1] megaraid_sas : IRQ polling using threaded interrupt
To: Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Peter Rivera <peter.rivera@broadcom.com>,
        Steve Hagan <steve.hagan@broadcom.com>
References: <CAHsXFKEdd+7fzAgbgjEiHNPwVs6Hi6j_J3mB1R-8jubaCgy6-A@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3038babc-1470-b69b-61c9-4a60fba4f0a7@grimberg.me>
Date: Fri, 24 Aug 2018 19:34:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAHsXFKEdd+7fzAgbgjEiHNPwVs6Hi6j_J3mB1R-8jubaCgy6-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Hi,
> 
> I refer below thread for interrupt polling related discussion for
> storage devices (NVME/HBA).
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2017-January/007749.html
> 
>   I am trying to evaluate the similar concept to reduce interrupts
> using irq-poll and threaded ISR. Below is high level changes I did in
> my experiment.

You want to reduce interrupts because you want to fix a bug where
your driver never exit from hard-irq? or trying to optimize the
efficiency of the system?

> In megaraid_sas driver, I schedule irq poll using “irq_poll_sched” and
> disable that particular IRQ line. I was expecting more completion
> after I disable irq line, but in most of the cases  just one
> completion happened from irq poll context. It must be due to host side
> processing is much faster than IO processing at back end device.
> Similar observation was posted in above mentioned thread as well.

Is your device able to coalesce interrupts?

> I added manual wait using “udelay()” and wait for some more time in irq
> poll context. Using additional wait, I am able to reduce interrupt per
> seconds and performance impact on latency is not visible since I
> choose udelay(1). One drawback I see is overall CPU utilization goes
> up since driver is using extra delay to reduce interrupts.
> 
>   To overcome CPU utilization issue, I switch to threaded ISR and
> replace udelay() with usleep().  Using threaded interrupt based
> polling CPU utilization goes to normal.

Doesn't sound like the right approach to me, but I don't understand
what you are trying to achieve.
