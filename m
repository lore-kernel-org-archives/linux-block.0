Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D22C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiLUKNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiLUKNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:13:12 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB59210B73
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:13:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jo4so26730012ejb.7
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFtUFEZ0yASxUMxyQqgxfJVN6QZngKYn2+EeS1iFjCo=;
        b=UNuNXzFe/jgHclh7OC+ib0WQHgrctcsjkyvePS0r49LZu3k2B/Dh+/RN6Uqy1PBQ0x
         jPZC8aqpG/bWd67UES1Na1SH6B4McMvKTRfmbQeylSzdaDGEO2sAnQJbK8LcpRZOCF1R
         x+qHZ6wZSo7cvHQwjZZ/Y8Q/Pf0/V07R3SFjp/FSBkn7MzApBi0i1utMPvDOh4BU6IWQ
         WmGLqzqh2gkkyAc7Q7MCKJtZJ+xSIsfXgR/8ebs6V4zlX3oUNdLt/QZ0Abou9Ep6yLH7
         G27XY/S2lWLGW3xyU+GGbwzaMjhlMY5YkLbGe99pYkLS6NUNlbotYorEm22o7InHbNvw
         oH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFtUFEZ0yASxUMxyQqgxfJVN6QZngKYn2+EeS1iFjCo=;
        b=TIWz9dHC7hZv3vDrAYJ18i9P1r6RLqDyUcV+c/mBTYnic74GPmn0qbVByV2GmwRplZ
         2YDXtqqb0FtUn33wQBZHCxY3aae1uHboMZ0Dooa/ZUWpOjo2vm+lFCAUbNdBIHJ1Y2GT
         FBBqeEuKw54R3514C1nFEcllSP35sqeuwMh0qs4p3VfghaLZs8g9iD1loeWp7ceQNe54
         Uta9sV4QHgmCVL/57rDz9d0hLiv+mzhUBnkgrFBBBRslyc6/2K5wdmc9m8k2rxOuVfML
         XFcheQ/0SusxW1qc3+45Go91XdKc1U7MeBIy5wc+UcRC8RDO8bxHYyRnEvdiEDcmspOS
         9Krg==
X-Gm-Message-State: AFqh2kqJWXCTgzlk7ZVvawVBXan+HCmd8+IzKZ9OCo0KBoVCehVbgDJR
        KqlJB7HTeOJZyd87VUsg+zDDcc1F4dlmsk0w
X-Google-Smtp-Source: AMrXdXu/B1l/48o1Lzo9FG7MydmQAkljJlw+an+qgZ2PalLVn46ULX35mPd1yX16FhCu/QvEXUz1JA==
X-Received: by 2002:a17:906:30d3:b0:7c0:a1f9:c778 with SMTP id b19-20020a17090630d300b007c0a1f9c778mr920539ejb.13.1671617589472;
        Wed, 21 Dec 2022 02:13:09 -0800 (PST)
Received: from mbp-di-paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id z8-20020aa7cf88000000b0043bbb3535d6sm6741560edx.66.2022.12.21.02.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:13:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V10 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <eb58939f-567e-c0c1-bafb-383f18f3d58e@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 11:13:07 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E955C95-3912-46D0-A48C-9709F094FD0D@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <20221209094442.36896-2-paolo.valente@linaro.org>
 <cd41583b-ef11-a3b7-1e39-c4a224050c7d@opensource.wdc.com>
 <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
 <eb58939f-567e-c0c1-bafb-383f18f3d58e@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 21 dic 2022, alle ore 01:50, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 2022/12/20 22:10, Paolo Valente wrote:
>>>> -	/*
>>>> -	 * Does queue (or any parent entity) exceed number of requests =
that
>>>> -	 * should be available to it? Heavily limit depth so that it =
cannot
>>>> -	 * consume more available requests and thus starve other =
entities.
>>>> -	 */
>>>> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
>>>> -		depth =3D 1;
>>>> +	for (act_idx =3D 0; act_idx < bfqd->num_actuators; act_idx++) {
>>>> +		struct bfq_queue *bfqq =3D
>>>> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) =
: NULL;
>>>=20
>>> Commented already: why not add a "if (!bfqq) return NULL;" in
>>> bic_to_bfqq() ?
>>=20
>> You have probably missed my reply on this.  The problem is that your
>> proposal would improve code (only) here, but it would entail the =
above
>> control for all the other invocations, for which it is useless :(
>=20
> But then you have *a lot* of "if (bfqd)" tests that are useless =
elsewhere since
> bic_to_bfqq() never returns NULL.
>=20

I'm probably misunderstanding your point, sorry.  Could you point me
to one of the places where there is the useless control that would go
away if we add your proposed control inside bic_to_bfqq?  (of course
apart form the above one, which seems to be the only one to me)

> And for this line, I personally would prefer seeing something like:
>=20
> 		struct bfq_queue *bfqq;
>=20
>=20
> 		if (bic)
> 			bfqd =3D bic_to_bfqq(bic, op_is_sync(opf), =
act_idx)
> 		else
> 			bfqd =3D NULL;
>=20
> Which is a lot simpler to read.
>=20
>=20

Ok, as I have your blessing on this point, I'll send a V12 with also
this change.

Thanks,
Paolo

> --=20
> Damien Le Moal
> Western Digital Research
>=20

