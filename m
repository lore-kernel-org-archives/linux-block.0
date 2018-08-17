Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44364 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHQUjg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 16:39:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so7704817wrt.11
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 10:35:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: blk-mq 5-8 times slower for bmap-tools
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
Date: Fri, 17 Aug 2018 19:35:18 +0200
Cc: linux-block@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Message-Id: <5F152F61-4DBE-4394-939B-D5F82EEE72AE@linaro.org>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



> Il giorno 17 ago 2018, alle ore 19:31, Ricardo Ribalda Delgado =
<ricardo.ribalda@gmail.com> ha scritto:
>=20
> Hello
>=20
> Coming from: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D906328
>=20
> bmaptools is kind of a "smart dd" tool, that lets you write images
> very fast and securely. Since the last Debian Kernel update it has
> become 5-8 times slower.
>=20
> After some debugging, we have figured out that the reason for that
> slowness is the Multi-Queue Block IO Queueing Mechanism.
>=20
> Debian maintainer has pointed out that in the near future the single
> queue will be deprecated.
>=20
> My question is if we can get a similar perfomance for bmaptools with
> blk-mq and how?
>=20

Have you also checked what happens after switching to a different I/O
scheduler for the involved drive (among none, mq-deadline, bfq and
kyber)?

Paolo

> Thanks!
>=20
> --=20
> Ricardo Ribalda
