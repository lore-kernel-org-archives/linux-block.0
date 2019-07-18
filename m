Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8BC76191
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 07:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F01121019
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 07:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVGH0KxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfGRHGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:06:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39182 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfGRHGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 03:06:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so27371749wrt.6
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AjHCbwBrWhsfLtVDroYK4H9JzJ/y/JeFj0V80CAWrXw=;
        b=dVGH0KxN6IWsqILmypdJN4ffQoCPa2LdoyifWahZfeHOoPNHQTGt8fE1xe1MSWS4uw
         3z3/+hqTViU1WPFnk1rbvI7YmuGNFFkVwWP7zYDAZitxcvVUbuAIgRCGyAuOdFr3yGAu
         +Vetkcpm6wt7w5dxfjzV17UX6+KSHP4fzyLXXAnbzy4Cw4373BJ9cpVsww8NC1RX7NkW
         sLqz8+Sw3+jMGZUgDk7gV3VD3Kf2vOPwHMdldJUW6DdNxMdiQQX1jymVRkBA7LkBxmr+
         GU2jr6+/K0OPFYMXdYBlqYv+PesxCApS2onGI5eDrig3q7k+29ISZmzIwTJYaaD/dTHC
         DZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AjHCbwBrWhsfLtVDroYK4H9JzJ/y/JeFj0V80CAWrXw=;
        b=onZiYp00qnR0e65v9BWvegrJIyM0pVQXXt2n0aprjJu4swUwBerR/s1QLNTadY9dED
         S+JE+0cWu18UagBbA14ZBdcP2oHF2zArT9pV+KPUJe581CDaAOo0zYxjPUsiPdlA3wvY
         6CoiJZ7/bAI9BnnaNL1Fi0j5ehbq9tUyw122d+QjmFTblEF6LtKSQ4BPQ1jsjHPBLyEN
         w+NOj0T1Iy2GJejDaBeo8aZx/g4z7gQzQQztfj1ro9qgVnVgZ/0xgkjPnTABb0j/uaPQ
         vltVcoCSe467zwMPqpfuMSR2BdVS7bnHNux03b2XSral2gVLMoa//ceH2SlA+QE/M5Cd
         Vg4Q==
X-Gm-Message-State: APjAAAUo+gDvMXFiEvSHwZqhepBEekfCZvWFvsixmDeibUGJs7BwVLt5
        bCyGN6nRvxq8hmpLo9ym5qEFXA==
X-Google-Smtp-Source: APXvYqwZgraIaMNlL/RuU9cyBFJWX9VGmgZznSLju1U+tv3DN8TEIZD+AhpTERo3x4as2ww2RMcmGA==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr5109243wrw.21.1563433603713;
        Thu, 18 Jul 2019 00:06:43 -0700 (PDT)
Received: from [192.168.0.100] (146-241-85-178.dyn.eolo.it. [146.241.85.178])
        by smtp.gmail.com with ESMTPSA id i18sm31923341wrp.91.2019.07.18.00.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 00:06:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 0/1] block, bfq: eliminate latency
 regression with fast drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <6867cf11-d7f8-cadf-b9ec-85549bb86af3@kernel.dk>
Date:   Thu, 18 Jul 2019 09:06:41 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <12B115BF-AF31-44F8-9A3A-EC64D3284FBB@linaro.org>
References: <20190715105719.20353-1-paolo.valente@linaro.org>
 <6867cf11-d7f8-cadf-b9ec-85549bb86af3@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 16 lug 2019, alle ore 16:11, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 7/15/19 4:57 AM, Paolo Valente wrote:
>> [V2 that should apply cleanly on current HEAD]
>>=20
>> Hi Jens,
>> I've spotted a regression on a fast SSD: a loss of I/O-latency =
control
>> with interactive tasks (such as the application start up I usually
>> test). Details in the commit.
>>=20
>> I do hope that, after proper review, this commit makes it for 5.3.
>=20
> If it's a regression, it should have a Fixes: line telling us which
> commit originally introduced the regression. This is important for
> folks doing backports.

Right, sorry.

> Can you add that?
>=20

Added, together with an explanation of why the fixed commit fails.

Sending a V3.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

