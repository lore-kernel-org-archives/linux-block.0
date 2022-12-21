Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A68C4167B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLUKcJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUKam (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:30:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C148D
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:30:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so35649911ejb.13
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjvJRQIdCdV8yoJ43xfdfjH/MiEQ7j354lDaOzKqIs0=;
        b=IjfAOC6tCgGjsFhMyJghmv6WwLaHCfdYPbrupetldsJgQrxHRbw78h4wOlxrpaBCif
         FTx5gODrnqh8avB0XW5lzJJX2ic7ypHCu7BBRMOJbn4zWeWoaP4s9nDBqHv/V3J8CHMC
         ybk991vV5sGjWkUS4uO0H9+ChrIt/BQ2OMosnZwoLCQAU5txFR0HYsJLVBEhBiL2+9QM
         a6aMJxTBOq4FL0UX5AwpRjsnN2wFlHFAK4J40XS9rUSEM4R+25VW9M/9gDpGwh3Uf8es
         5tWq6hn40GirDmCjrt++hYkD27gM0kK9r4lP95oB9/ZphtKO0EzDvBaPrxA/6ZtSlCEP
         yBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjvJRQIdCdV8yoJ43xfdfjH/MiEQ7j354lDaOzKqIs0=;
        b=DN4JNQMmuaynu2aWHBPNWRznwFQvbzdhrgtQjyx4qOVfM0IFNIOH77scXPUeZdaj/z
         nhBe9BflP5vG5QVQQEnyNRPJiW6xpazOwEZMGW1KOxd1ZIJjwGv72kpn3v2no29NCWaP
         e20o09CIbI9bVxnDyZiTNqxlDuqNaDHJ3CzAUlG9NPN6LzBMFenXL9jyuZqWoWwwmYj7
         zcHc0AnNjgDlJr/Efluaw93lPLyZ7lXQo9C0wy/qpyNqZrFNWV0m1O1njM/PY2gGyCn5
         WKrp7TNu/iN79hMewIWErOoCpM9gz/Ey0r9e8Otuc2lIoHd3naz0c6iidJ3Huh2cKRmQ
         sW8g==
X-Gm-Message-State: AFqh2koLeiLlXAgg1dujwytz9XrzF+Ks+x5xFaj2ounIOlcH0N7/XW6V
        eD0kYJlKYsLpM0o/Ez9BAnpe5w==
X-Google-Smtp-Source: AMrXdXsydh44E6pcwFbWHFitspGVthr1eKSul48dqf8/CcezZNU1z2AoIdqOmymRoNdyLgq5X47I9A==
X-Received: by 2002:a17:906:8447:b0:7c8:9f04:ae7e with SMTP id e7-20020a170906844700b007c89f04ae7emr4278221ejy.22.1671618637560;
        Wed, 21 Dec 2022 02:30:37 -0800 (PST)
Received: from mbp-di-paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906539900b00738795e7d9bsm6919482ejo.2.2022.12.21.02.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:30:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V10 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3E955C95-3912-46D0-A48C-9709F094FD0D@linaro.org>
Date:   Wed, 21 Dec 2022 11:30:35 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <918DD21A-0099-4EF9-955B-CAED2A3F8947@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <20221209094442.36896-2-paolo.valente@linaro.org>
 <cd41583b-ef11-a3b7-1e39-c4a224050c7d@opensource.wdc.com>
 <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
 <eb58939f-567e-c0c1-bafb-383f18f3d58e@opensource.wdc.com>
 <3E955C95-3912-46D0-A48C-9709F094FD0D@linaro.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 21 dic 2022, alle ore 11:13, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 21 dic 2022, alle ore 01:50, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>>=20
>> On 2022/12/20 22:10, Paolo Valente wrote:
>>>>> -	/*
>>>>> -	 * Does queue (or any parent entity) exceed number of requests =
that
>>>>> -	 * should be available to it? Heavily limit depth so that it =
cannot
>>>>> -	 * consume more available requests and thus starve other =
entities.
>>>>> -	 */
>>>>> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
>>>>> -		depth =3D 1;
>>>>> +	for (act_idx =3D 0; act_idx < bfqd->num_actuators; act_idx++) {
>>>>> +		struct bfq_queue *bfqq =3D
>>>>> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) =
: NULL;
>>>>=20
>>>> Commented already: why not add a "if (!bfqq) return NULL;" in
>>>> bic_to_bfqq() ?
>>>=20
>>> You have probably missed my reply on this.  The problem is that your
>>> proposal would improve code (only) here, but it would entail the =
above
>>> control for all the other invocations, for which it is useless :(
>>=20
>> But then you have *a lot* of "if (bfqd)" tests that are useless =
elsewhere since
>> bic_to_bfqq() never returns NULL.
>>=20
>=20
> I'm probably misunderstanding your point, sorry.  Could you point me
> to one of the places where there is the useless control that would go
> away if we add your proposed control inside bic_to_bfqq?

You had already done that in a following email, sorry.  I have replied
to that email of yours.

Thanks,
Paolo

