Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08619C43141
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F92206C0
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 09:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKbG0cp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKNJWG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:22:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35822 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNJWG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 04:22:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so5036250wmo.0
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wJ93PkxDUJ1eFbf5mpCbdbWAtZ8jBpbUP4t87omWe5I=;
        b=YKbG0cp+oQfUnQXm58HEPevFGLfCfI894EifegP/RLnHiJlP2lsllzojqjbvMm7BCc
         sQ4sZ0qM5Oz25M6m21AQjB5iQ8VATszIxj1i2+DZik74AwzgSQElaqdnNW9vspA4R1bG
         dolrdpuzottQ5B4l7OczrvUQcigE2MfM/06LFsUT65NfS/Z/s/Z4Rtu0LbyFIjRrB37C
         YgNZZx16/TCWvodmMAtl3QpGS1X4qK0hHpV+5LpFwSGV51SvJu8CUmMnshvXpmxS0kl4
         xYBQe5aTRGWmGfkHWLP8WnNdPVgRpGqH+Hle1mV7n27ht66sK6YD2aryYvHy4BG7m24Z
         o+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wJ93PkxDUJ1eFbf5mpCbdbWAtZ8jBpbUP4t87omWe5I=;
        b=SZjJk87Ya91mLoIdzv9k+m5gI92Zt0orcXsVh6k1icegGt0x60mKXymW0aSu4pKb6x
         TOKBgh/tiQ8Uv9qYTJevcjoe2+w4i1BhJxee4OD1umMigRMNNI7R0KXvuzBgDdipisoh
         6eORYBiZ25v6dYQ4LMt+B1i+fQvkd5TWPdnKq0ViUWyCKvjOsnE53TOfgx111Uz1q9ZK
         amFZlhJc+b98+kPjwV3z8m7rZRjCgY9++7IeGMw16ql5plH9/F3gnEYEvvLT65J5+iiJ
         BBlDpvRa7mk0t/62ZRExEq8Ld1U1Q6RTCiQqYleXk0U3e7s46VEakobmcUL/jfV60PyJ
         FTLg==
X-Gm-Message-State: APjAAAVYmTN59Kj53ujtoI3EcRX/w8cqd319OfXgl0uJxV9EpBtWAU9N
        mQ3SRvCANpVNBR9LaTqGAf1lbQ==
X-Google-Smtp-Source: APXvYqywJK4WDFMo54SzRAabh+pA4uK/fEXdLzXqmc6Fox7lZtfz/sW/JDejJjbWf9gdqWauADwy4g==
X-Received: by 2002:a05:600c:2944:: with SMTP id n4mr6947335wmd.57.1573723324250;
        Thu, 14 Nov 2019 01:22:04 -0800 (PST)
Received: from [192.168.100.210] (hipert-gw1.mat.unimo.it. [155.185.5.1])
        by smtp.gmail.com with ESMTPSA id n1sm6509398wrr.24.2019.11.14.01.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:22:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <8f77fb4e-a49b-4ddc-8756-e08b030dd7e4@kernel.dk>
Date:   Thu, 14 Nov 2019 10:22:01 +0100
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bfq-iosched@googlegroups.com, Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC298DB4-3107-4E9A-AD11-47AA070D85EF@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
 <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
 <65fc0bffbcb2296d121b3d5a79108e76@natalenko.name>
 <5773ff54421ccf179ef57d96e19ef042@natalenko.name>
 <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
 <8f77fb4e-a49b-4ddc-8756-e08b030dd7e4@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 13 nov 2019, alle ore 23:46, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 11/13/19 10:42 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 13 nov 2019, alle ore 16:01, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>>>=20
>>> On 13.11.2019 15:25, Oleksandr Natalenko wrote:
>>>> I didn't try to switch schedulers, but what I see now is once the
>>>> system is able to boot with BFQ, the I/O can still hang on I/O =
burst
>>>> (which for me happens to happen during VM reboot).
>>>> This may also not hang forever, but just slow down considerably. =
I've
>>>> noticed this inside a KVM VM, not on a real HW.
>>>=20
>>> Possible call traces:
>>=20
>> Ok, you may have given me enough information, thank you very much.
>>=20
>> Could you please apply the attached (compressed) patch on top of my
>> offending patch?  For review purposes, here is the simple change:
>=20
> FWIW, I dropped the previous patch.
>=20

Thanks. I'm sending a V2.

Thanks,
Paolo

> --=20
> Jens Axboe

