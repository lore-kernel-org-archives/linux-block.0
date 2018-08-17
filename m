Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39785 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQUqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 16:46:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so8085558wmq.4
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 10:42:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: blk-mq 5-8 times slower for bmap-tools
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAPybu_3_ZJ8KopMM6fxvHXkXmdLUyqPZoXx=fx=nDYOXsvesHg@mail.gmail.com>
Date: Fri, 17 Aug 2018 19:42:15 +0200
Cc: linux-block@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Message-Id: <82A59CD0-9B59-4F5B-BE9B-BCDD3FDCA177@linaro.org>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <5F152F61-4DBE-4394-939B-D5F82EEE72AE@linaro.org>
 <CAPybu_3_ZJ8KopMM6fxvHXkXmdLUyqPZoXx=fx=nDYOXsvesHg@mail.gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



> Il giorno 17 ago 2018, alle ore 19:39, Ricardo Ribalda Delgado =
<ricardo.ribalda@gmail.com> ha scritto:
>=20
> Hello Paolo
> On Fri, Aug 17, 2018 at 7:35 PM Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>=20
>>=20
>>=20
>>> Il giorno 17 ago 2018, alle ore 19:31, Ricardo Ribalda Delgado =
<ricardo.ribalda@gmail.com> ha scritto:
>>>=20
>>> Hello
>>>=20
>>> Coming from: =
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D906328
>>>=20
>>> bmaptools is kind of a "smart dd" tool, that lets you write images
>>> very fast and securely. Since the last Debian Kernel update it has
>>> become 5-8 times slower.
>>>=20
>>> After some debugging, we have figured out that the reason for that
>>> slowness is the Multi-Queue Block IO Queueing Mechanism.
>>>=20
>>> Debian maintainer has pointed out that in the near future the single
>>> queue will be deprecated.
>>>=20
>>> My question is if we can get a similar perfomance for bmaptools with
>>> blk-mq and how?
>>>=20
>>=20
>> Have you also checked what happens after switching to a different I/O
>> scheduler for the involved drive (among none, mq-deadline, bfq and
>> kyber)?
>=20
> I have only tried mq-deadline and none (because they are enabled by
> default on Debian). Both produce results in the same range: 5-8 times
> slower.
>=20
> I could easily enable kyber:
> cat /boot/config-4.17.0-1-amd64  | grep CONFIG_MQ_IOSCHED
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dm
>=20
> But I left the card reader on the office, so any test would have to
> wait until monday sorry :(
>=20

Try bfq too, as it is probably the one containing also the most old
way heuristics.  If bfq fails too, we will at least know that the issue
is out of the schedulers. Or in every scheduler! :)

Paolo

>=20
>>=20
>> Paolo
>>=20
>>> Thanks!
>>>=20
>>> --
>>> Ricardo Ribalda
>>=20
>=20
>=20
> --=20
> Ricardo Ribalda
