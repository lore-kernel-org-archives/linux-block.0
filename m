Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34186 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeHQUne (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 16:43:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so6983474ljk.1
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 10:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <5F152F61-4DBE-4394-939B-D5F82EEE72AE@linaro.org>
In-Reply-To: <5F152F61-4DBE-4394-939B-D5F82EEE72AE@linaro.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 17 Aug 2018 19:39:00 +0200
Message-ID: <CAPybu_3_ZJ8KopMM6fxvHXkXmdLUyqPZoXx=fx=nDYOXsvesHg@mail.gmail.com>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
To: paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Paolo
On Fri, Aug 17, 2018 at 7:35 PM Paolo Valente <paolo.valente@linaro.org> wrote:
>
>
>
> > Il giorno 17 ago 2018, alle ore 19:31, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> ha scritto:
> >
> > Hello
> >
> > Coming from: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=906328
> >
> > bmaptools is kind of a "smart dd" tool, that lets you write images
> > very fast and securely. Since the last Debian Kernel update it has
> > become 5-8 times slower.
> >
> > After some debugging, we have figured out that the reason for that
> > slowness is the Multi-Queue Block IO Queueing Mechanism.
> >
> > Debian maintainer has pointed out that in the near future the single
> > queue will be deprecated.
> >
> > My question is if we can get a similar perfomance for bmaptools with
> > blk-mq and how?
> >
>
> Have you also checked what happens after switching to a different I/O
> scheduler for the involved drive (among none, mq-deadline, bfq and
> kyber)?

I have only tried mq-deadline and none (because they are enabled by
default on Debian). Both produce results in the same range: 5-8 times
slower.

I could easily enable kyber:
cat /boot/config-4.17.0-1-amd64  | grep CONFIG_MQ_IOSCHED
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m

But I left the card reader on the office, so any test would have to
wait until monday sorry :(


>
> Paolo
>
> > Thanks!
> >
> > --
> > Ricardo Ribalda
>


-- 
Ricardo Ribalda
