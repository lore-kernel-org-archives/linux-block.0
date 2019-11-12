Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67C0C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 17:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57321925
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 17:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0yJ5Dz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfKLRtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:49:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43942 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLRtW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 12:49:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so19494193wra.10
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2019 09:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b2s8SEY9t9fulZHVtE2E7prB2MDxE1u1Ylc99r86PD8=;
        b=d0yJ5Dz57PgK7Z0V45voYWt/WzqHqNY5NBtC01g2eYXLfE8Fypw7fDOQj6rCAVMLgV
         6oVT+CjwNI4Ez5Rt6oVCGHCbyocVxo4X1IJsWxQjICw2lNDresTfFfA1/NuBqgqqPK/6
         anWK84bmfXc/gaWVG5HyLCAMiaVtVlWFPlPSsPa8Hqt5j3fJyQlzQV46OIfFNp0VoTD+
         KM+6LnMOkApmbvtmkV7O/+aLZ3UMAFvnrz/kH1F9puI53ZQ6SVWh5x5EG5LN/PiXpw3x
         eziGKFGb9OPQAG/1+VOGE99qEBF8XUudh36wPcwEW6ZKVirUVUanEEdsyal0p8D68csy
         64hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b2s8SEY9t9fulZHVtE2E7prB2MDxE1u1Ylc99r86PD8=;
        b=bZsvS6OqPdYHYFgkw4hh/1dquH0QftD3JAy5GEL8pDtIKxte8HwAC+lTz2YZhdLITB
         stg5mNC7+fP+R5d+aQsRZejfI8VF6aA5OVy0hXTgF3JnXirx1b2VLPAhd4832MGVTq9s
         Sb9MjtvFsBdAOUn7GHE8cSIB2kYRygkzITpmNSXQFBgJcvqJj6H/4gl4XjdoHqn/ZpE7
         vkZb0RmDAJzo8d+KyVafDWTmTQBFBU44rAf3cvLAfScqiDyhNwn6/4fAh/BgKpuR3asx
         e12E7SHve6i2MqVteuIlYSDyUvjShqtLyPLVnMcSaTDbh0WiLeD4wh5P8xiF5pzR9S3w
         A+Rg==
X-Gm-Message-State: APjAAAUgjfw9ZmvJtPTmh+nQSBi5+KAK1svNtYQbhsfsU9pvgtO+Dexq
        s0C0FLIUNROOygvxDXJETYYciA==
X-Google-Smtp-Source: APXvYqwUIKVu5EMWyXa9vC0XGv4k64nyPQGV6mmstQPvS3S1OqT7BWQajDKpz7iNjmui6uGLLLvinA==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr29187752wrj.84.1573580959164;
        Tue, 12 Nov 2019 09:49:19 -0800 (PST)
Received: from [192.168.43.233] ([37.161.193.189])
        by smtp.gmail.com with ESMTPSA id 76sm5676410wma.0.2019.11.12.09.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:49:18 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <83a56a54-3269-ecb9-f4ae-01c3f9717279@kernel.dk>
Date:   Tue, 12 Nov 2019 18:49:16 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E12E7F9-B6C3-4B8A-9659-C60C9830ACBB@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <83a56a54-3269-ecb9-f4ae-01c3f9717279@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 12 nov 2019, alle ore 16:23, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 11/11/19 11:48 PM, Paolo Valente wrote:
>> Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
>> they deserve I/O plugging"), to prevent the service guarantees of a
>> bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
>> scheduled for service, even if empty (see comments in
>> __bfq_bfqq_expire() for details). But, if no process will send
>> requests to the bfq_queue any longer, then there is no point in
>> keeping the bfq_queue scheduled for service.
>>=20
>> In addition, keeping the bfq_queue scheduled for service, but with no
>> process reference any longer, may cause the bfq_queue to be freed =
when
>> descheduled from service. But this is assumed to never happen, and
>> causes a UAF if it happens. This, in turn, caused crashes [1, 2].
>>=20
>> This commit fixes this issue by descheduling an empty bfq_queue when
>> it remains with not process reference.
>>=20
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1767539
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D205447
>=20
> Applied, thanks.
>=20

That was fast (thanks)!  Some people are testing this, with no more
hangs, and no new issues, so far.

BTW, could you reply to the hung thread on finally fixing BFQ's
cgroups interface [1]?

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/10/1/1252

> --=20
> Jens Axboe

