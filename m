Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44703 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdLGSE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Dec 2017 13:04:57 -0500
Received: by mail-wr0-f180.google.com with SMTP id l22so8401639wrc.11
        for <linux-block@vger.kernel.org>; Thu, 07 Dec 2017 10:04:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: blk-mq + bfq:  udevd hang on usb2 storages
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20171204105720.GA6884@ming.t460p>
Date: Thu, 7 Dec 2017 19:04:54 +0100
Cc: Alban Browaeys <alban.browaeys@gmail.com>,
        Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        SERENA ZIVIANI <169364@studenti.unimore.it>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Message-Id: <D03704C9-BF8E-49E1-B552-90393BC9DE4A@linaro.org>
References: <1512147869.8698.21.camel@gmail.com> <20171204105720.GA6884@ming.t460p>
To: Ming Lei <ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 04 dic 2017, alle ore 11:57, Ming Lei <ming.lei@redhat.com> =
ha scritto:
>=20
> On Fri, Dec 01, 2017 at 06:04:29PM +0100, Alban Browaeys wrote:
>> I initially reported as =
https://bugzilla.kernel.org/show_bug.cgi?id=3D198
>> 023 .
>>=20
>> I have now bisected this issue to commit a6a252e6491443c1c1 "blk-mq-
>> sched: decide how to handle flush rq via RQF_FLUSH_SEQ".
>>=20
>> This is with an USB stick Sandisk Cruzer (USB Version:  2.10) I
>> regressed with.
>> systemctl restart systemd-udevd restores sanity.
>>=20
>> PS: With an USB3 Lexar (USB Version:  3.00) I get more severe an =
issue
>> (not bisected) where I find no way out of reboot. My report to =
bugzilla
>> has logs when I was swapping between the these keys. The logs =
attached
>> there mixes what looks like two different behaviors.
>=20
> Hi Paolo,
>=20
> =46rom both Alban's trace and my trace, looks this issue is in BFQ,
> since request can't be retrieved via =
e->type->ops.mq.dispatch_request()
> in blk_mq_do_dispatch_sched() after it is inserted into BFQ's queue.
>=20
>        https://bugzilla.kernel.org/show_bug.cgi?id=3D198023#c4
>        https://marc.info/?l=3Dlinux-block&m=3D151214241518562&w=3D2
>=20
> BTW, I have tried to reproduce the issue with scsi_debug, but not =
succeed,
> and it can't be reproduced with other schedulers(mq-deadline, none) =
too.
>=20
> So could you take a look?
>=20

Hi Ming, all,
sorry for the delay, but we preferred to reply directly after finding
the cause of the problem.  And the cause is that gdisk makes an I/O
request that is dispatched to the drive, but apparently never
completed (as Serena, in CC discovered).  Or, at least, the execution
of completed_request in bfq is never triggered.

In more detail: disk is a process for which bfq performs device idling
(for good reasons), and, for one such process, bfq does not switch to
serving another process until the last pending request of the process
is completed, after which device idling is started, to wait for the
next request of the process.  So, if such a last request is never
completed, bfq remains forever waiting for such an event, and then
refuses forever to deliver requests of other queues.

As for why bfq_completed_request is not executed for the above,
dispatched request, the reason is either that the bfq_finish_request
hook is not invoked at all, or that it is invoked, but the request
does not have the RQF_STARTED flag set.  Discovering which event
occurs is our next step.

We'll let you know.

Thanks,
Paolo

> Thanks,
> Ming
