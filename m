Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7169EC4CECD
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443BE214AF
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy6+Fzxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfIPPVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:21:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbfIPPVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 11:21:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so39300879wrm.9
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K5n01uhQ5HwxlBE5M/2zmjIiad/mSltxdBurQPag48E=;
        b=Jy6+FzxuA5xspP87WcsXSOV4KOdYZWkwZV9U8INYadGh7JZSwRWH/gbT0hmx1AVdJp
         c3z4qE9I4ZBu1OjPKIDmA/xJwG31JNjYTHNY62FngQXJj5Ch5iIf3UvshZV0IaFH7yuh
         v9qvTI6LiL9JqE+hz8CfexVxz2uXwVd5QIAsfhXlMbsTH/wDD/OOX1+fX6e0lOq7Dc6o
         kpe/jGOTZFtoFFaRWaeYDiih2pLyUhyfw4aG8BiagqvcX5YT1xfGUnnl72ARPECAPPBr
         BSGYMoyvKuKfPeDNJ+h/hWOJcuvDR9nehhvCOzGJkCoKRRPU+l6z5hvmHnbNmglWZkkH
         9olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K5n01uhQ5HwxlBE5M/2zmjIiad/mSltxdBurQPag48E=;
        b=YsUapId+rqlm+kuTCk3uWfJ6Va6jsMxMHOddYXpmQG5J7cPEqjjnK/Xy8KPyx8bzny
         qYwPyfbX8dGG+Rg4IZO+goZPb0xl4iw7n9MSR0z6B6wlggbL0cDMNViXIR8IwfBQgzZm
         DKdDn37iqyq/ScQXn6VZhE5CstGqyXk8pWJfMZa6t0hYXuisklBHoWbcC/XuXi8QWgtV
         +otwRU+6zB1LCCMK8xabkydZt91jvhQxXsH5wA4WCAAa030fuaMNUH45KJelIPPSsa+K
         kNyRZTHe/qNTsbkNyETbtZmxOYzrfTiCW3dedv3tDqweb0VwXUsnzH01D0+OhNleE0zK
         EECA==
X-Gm-Message-State: APjAAAWa0GiC4hkzZcWnwcgVXXltofHXfq8tWBAhDpM6sB4R9FphbOeH
        HGKvqGFSiXtMuKNPLDHJbi0zNA==
X-Google-Smtp-Source: APXvYqyjxEqp9sHAmo5kttc6Y0BlvcD5LMImSzPduV+19RimNQXROmwgEraX+NhAEljzg9KcrdGXzA==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr232550wrs.191.1568647263455;
        Mon, 16 Sep 2019 08:21:03 -0700 (PDT)
Received: from [192.168.0.101] (146-241-102-115.dyn.eolo.it. [146.241.102.115])
        by smtp.gmail.com with ESMTPSA id c18sm7151337wrv.10.2019.09.16.08.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:21:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190916151643.GC3084169@devbig004.ftw2.facebook.com>
Date:   Mon, 16 Sep 2019 17:21:01 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <64329DDB-FFF4-4709-83B1-39D5E6BF6AB6@linaro.org>
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
 <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
 <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
 <20190916151643.GC3084169@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 16 set 2019, alle ore 17:16, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Mon, Sep 16, 2019 at 05:07:29PM +0200, Paolo Valente wrote:
>> Tejun, could you put your switch-off-io-cost code into a standalone
>> patch, so that I can put it together with this one in a complete
>> series?
>=20
> It was more of a proof-of-concept / example, so the note in the email
> that the code is free to be modified / used any way you see fit.  That
> said, if you like it as it is, I can surely prep it as a standalone
> patch.
>=20

AFAICT your proposal contains no evident error.  Plus, no one seems to
have complained about the idea (regardless from the exact
implementation).  So I guess the best next step is to go for it.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

