Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ABEC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42C4214C6
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6yRtFfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfDHPP1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:15:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40862 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHPP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:15:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so15250954wmi.5
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e2/ADuFbDuc+qrHFSgLHEd6L5BY2SrcoWE9e+J1+2eM=;
        b=r6yRtFfSAF0vtzhQILmSVQskLUgjEqWqi58U1m2nJvUYA4BJY3l3awGVMlgWOKs/f/
         0U3DTdY63n8Hs+nZur+HWqiMM4L+/V5ErXxd7cR35vxNdy/imzyc+Zi3gq0qG/RFXJVN
         nesxjSG+Rd9rNhbQmDDTowO0oD/A5VjfkQ5bq96tRHlx+rde3C60D9D6mkPi0ZgrUBFT
         JDCnw7DF7q1jn9b0SPJwePez074u17wcWQbbdjcUVhpP/70UQ449AK8M8vv4T8w5JX87
         3LWVJmKJC6AOr0dXuXBd+6gQXnf4T/24MhYiLwUl7jeqW7uHpkaNffdhmdbia63KpfLz
         h0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e2/ADuFbDuc+qrHFSgLHEd6L5BY2SrcoWE9e+J1+2eM=;
        b=eGwB0p9fhq2CZ2OS4YW00reqDjxCbqHe2GzF0EQZs+w5rAfZUY/iOa+4mbILQbIIoU
         fEuP7n98+HmWLkB37H4oc8m7d5kxVkzhUgVjgZz7i1PQx8+Xk1I+/7uifr56z6Wvs6cm
         +FIujugkwNXR8Nlm3VSqjq+emYrqGwIb9s9Mn/o3c4uSWz3m+L4i60ZMHitY+6Wad7WJ
         q+OuBNUtF+9NqTJlKf+OFHtCHPY3cuSMIzNqsUafwomHyCppbwtFRpAJSjpRlJAomWAL
         Ym2qIMDih4JM1l40wbPLwYZdjnxQaHM32ps0kkq8FAv7jUPZA+jm9+F/6aXRmv6dUGPw
         KSlw==
X-Gm-Message-State: APjAAAW+y81k5sBriDrczh1oOCy1MN9PUzG5FVIR/Ud4I18XdtTtlWPi
        oXpSkJ2TaGPINYjV7PrBTXT2ZA==
X-Google-Smtp-Source: APXvYqz/+SNgmBpEQ8KdupTM9fAw5KRx8tx/qZ9Z/FiRngQq5AdPJp7BOKj9tflCkRxOnQjlbnVr4A==
X-Received: by 2002:a1c:e0c6:: with SMTP id x189mr13729917wmg.4.1554736525520;
        Mon, 08 Apr 2019 08:15:25 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id z1sm25372163wrs.52.2019.04.08.08.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:15:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <85f1978b-bb31-c6bc-e824-c0682bbd2922@kernel.dk>
Date:   Mon, 8 Apr 2019 17:15:23 +0200
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
Message-Id: <4796D9F5-C30F-442D-B3A2-AF80F6874C2C@linaro.org>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
 <938957C8-3A0F-4664-8D1F-A822F6D6D4E7@linaro.org>
 <85f1978b-bb31-c6bc-e824-c0682bbd2922@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 apr 2019, alle ore 17:11, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 4/8/19 9:06 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 8 apr 2019, alle ore 17:05, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>=20
>>> On 4/8/19 9:04 AM, Johannes Thumshirn wrote:
>>>> [+Cc Michal ]
>>>> On Mon, Apr 08, 2019 at 04:54:39PM +0200, Paolo Valente wrote:
>>>>>=20
>>>>>=20
>>>>>> Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn =
<jthumshirn@suse.de> ha scritto:
>>>>>>=20
>>>>>> On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
>>>>>>> From: Angelo Ruocco <angeloruocco90@gmail.com>
>>>>>>>=20
>>>>>>> When bfq was merged into mainline, there were two I/O schedulers =
that
>>>>>>> implemented the proportional-share policy: bfq for blk-mq and =
cfq for
>>>>>>> legacy blk. bfq's interface files in the blkio/io controller =
have the
>>>>>>> same names as cfq. But the cgroups interface doesn't allow two
>>>>>>> entities to use the same name for their files, so for bfq we had =
to
>>>>>>> prepend the "bfq" prefix to each of its files. However no legacy =
code
>>>>>>> uses these modified file names. This naming also causes =
confusion, as,
>>>>>>> e.g., in [1].
>>>>>>>=20
>>>>>>> Now cfq has gone with legacy blk, so there is no need any longer =
for
>>>>>>> these prefixes in (the never used) bfq names. In view of this =
fact, this
>>>>>>> commit removes these prefixes, thereby enabling legacy code to =
truly
>>>>>>> use the proportional share policy in blk-mq.
>>>>>>>=20
>>>>>>> [1] https://github.com/systemd/systemd/issues/7057
>>>>>>=20
>>>>>> Hmm, but isn't this a user-space facing interface and thus some =
sort of ABI?
>>>>>> Do you know what's using it and what breaks due to this =
conversion?
>>>>>>=20
>>>>>=20
>>>>> Yep, but AFAIK, the problem is exactly the opposite: nobody uses =
these
>>>>> names for the proportional-share policy, or wants to use these =
names. I'm
>>>>> CCing Lennart too, in case he has some improbable news on this.
>>>>>=20
>>>>> So the idea is to align names to what people expect, possibly =
before
>>>>> more confusion arises.
>>>>=20
>>>> OK, crazy idea, not sure if Jens and Tejun will beat me for this, =
but
>>>> symlinks?
>>>>=20
>>>> This way we can a) keep the old files and b) have them point to the =
new (a.k.a
>>>> cfq style) files.
>>>=20
>>> I did consider that, and that would be doable. But honestly, I'm =
having a
>>> hard time seeing what issue we are attempting to fix by doing this.
>>>=20
>>=20
>> The problem is ~100% of people and software believing to set weights =
and not doing it.
>=20
> I'm sorry, but I don't know what that means?
>=20

It means that people and code set weights, not bfq.weights.

Thanks,
Paolo

> --=20
> Jens Axboe

