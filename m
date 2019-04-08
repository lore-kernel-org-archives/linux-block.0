Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E135CC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CC3217F4
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0909WOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDHPG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:06:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38677 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfDHPGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:06:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so15121890wmc.3
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eAkVGL8LuYrWK2HSKnJoGKtfb768PfHiEnLOTq+qGeM=;
        b=g0909WOpVaY8LRC/Xa+v/jGqL0gEvjsPdUfTvNJr2wRjddJLW2HrkE1CR9QmPUDB90
         jbI4iqkFXuf2E2tjUSxfUdM2KJTLnFJLFwjqSlVdd4sfnpRQaQgytRq3miL1HERLR//F
         K63Yi+ZwNB1AWpSOTI85KRMjjDyX8/4rmvp1vnWVYsGVU3CFhOBftd9yJe/a6RUym7Tk
         gwDXlHkwUuUD3o/3Q9lfCnRFiHdVpU2IzFC8VoSEgTkl9WhcXocTIOKX/W4R/F0iMLM8
         cufzA4I9sn7r1a4ePUDLsefsQXtXRnS9gwh+fVCxlC9j2uvxQ/GjHFzm5SCCel2uI792
         6gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eAkVGL8LuYrWK2HSKnJoGKtfb768PfHiEnLOTq+qGeM=;
        b=bwbwBgYtduvKikR78NG6T/cKHkelobSafce6rrxcUPyrDFFgy2Pked5RR8k+n+eVS4
         0tIVW2qD+r4xVNFdSXX10Xyy2FIlok0iV0Bn5GumzXV4QR0FzAPP5HyEyuC5l0f/8TsP
         BKBrp0ZHvQ368IFEAxBMKRC69DzFIWEjsD+B0I0xNcifvhOfo/hnNXUzXnpbEWFKJ/FO
         D/4gILyvXpI4mDVvyOEyAWKlwZriy4YQ35qvFuQ4WZJFKZcYPKtLZBCm4HMXAVdAbBpc
         UZMKc2mu9FcsZbWYgYylFwZTRclyW1D2pWd696KylzkW+zn1Jg1MTajZTlLX2is1lo6S
         +Qog==
X-Gm-Message-State: APjAAAVHXFWWj7GTExOaualWklDNyyn9bjrfS6eAZpyQGxnAO/mWVO7y
        OLVvUdGw/IWbSioZqL42XO99Qw==
X-Google-Smtp-Source: APXvYqz5wk5CVsf1SCEbEItZbOWgJ84MZIEvEU5bOD5aGKQpNdCZoc4Jl+IWFrE71mTc2NCb+W3zsg==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr18719569wmj.37.1554736012178;
        Mon, 08 Apr 2019 08:06:52 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id g10sm21900262wrq.2.2019.04.08.08.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:06:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
Date:   Mon, 8 Apr 2019 17:06:47 +0200
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
Content-Transfer-Encoding: quoted-printable
Message-Id: <938957C8-3A0F-4664-8D1F-A822F6D6D4E7@linaro.org>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 apr 2019, alle ore 17:05, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 4/8/19 9:04 AM, Johannes Thumshirn wrote:
>> [+Cc Michal ]
>> On Mon, Apr 08, 2019 at 04:54:39PM +0200, Paolo Valente wrote:
>>>=20
>>>=20
>>>> Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn =
<jthumshirn@suse.de> ha scritto:
>>>>=20
>>>> On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
>>>>> From: Angelo Ruocco <angeloruocco90@gmail.com>
>>>>>=20
>>>>> When bfq was merged into mainline, there were two I/O schedulers =
that
>>>>> implemented the proportional-share policy: bfq for blk-mq and cfq =
for
>>>>> legacy blk. bfq's interface files in the blkio/io controller have =
the
>>>>> same names as cfq. But the cgroups interface doesn't allow two
>>>>> entities to use the same name for their files, so for bfq we had =
to
>>>>> prepend the "bfq" prefix to each of its files. However no legacy =
code
>>>>> uses these modified file names. This naming also causes confusion, =
as,
>>>>> e.g., in [1].
>>>>>=20
>>>>> Now cfq has gone with legacy blk, so there is no need any longer =
for
>>>>> these prefixes in (the never used) bfq names. In view of this =
fact, this
>>>>> commit removes these prefixes, thereby enabling legacy code to =
truly
>>>>> use the proportional share policy in blk-mq.
>>>>>=20
>>>>> [1] https://github.com/systemd/systemd/issues/7057
>>>>=20
>>>> Hmm, but isn't this a user-space facing interface and thus some =
sort of ABI?
>>>> Do you know what's using it and what breaks due to this conversion?
>>>>=20
>>>=20
>>> Yep, but AFAIK, the problem is exactly the opposite: nobody uses =
these
>>> names for the proportional-share policy, or wants to use these =
names.  I'm
>>> CCing Lennart too, in case he has some improbable news on this.
>>>=20
>>> So the idea is to align names to what people expect, possibly before
>>> more confusion arises.
>>=20
>> OK, crazy idea, not sure if Jens and Tejun will beat me for this, but
>> symlinks?
>>=20
>> This way we can a) keep the old files and b) have them point to the =
new (a.k.a
>> cfq style) files.
>=20
> I did consider that, and that would be doable. But honestly, I'm =
having a
> hard time seeing what issue we are attempting to fix by doing this.
>=20

The problem is ~100% of people and software believing to set weights and =
not doing it.

Paolo

> --=20
> Jens Axboe

