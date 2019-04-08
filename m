Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85A7C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35BA20879
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6GTCo5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDHPTK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:19:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37147 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfDHPTK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:19:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so16911297wrm.4
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/leuO0ReNKxJFhgJ0Qj7KukamA50Bn4keQX7qI/nENE=;
        b=k6GTCo5umK7gLWSz437KDn9LSP6GlCxNEy4GI7Rh0gEDZvFxEpAL4TbtSYFlVLJ4Ge
         fGm70b/C4itq7DAv3r5wbbDoGubjcGfZRYW5W5qdmMHX+Pk82yCxd8bJxSF7sSn4L++/
         SHJNvARO3Pn0vszp+AJNvT89eAG3kOQIYQu3ZgqLUSDsyOy4fHCPN1zEN7pJl40IIR0q
         R7JKRK3+IxbcOpyTiDofd8AoewvBhF2GA1Jnpog/fF4tYgsiUE+hoXfu4ViwBjtTck9R
         X2DhhVhmZOjtb2Ts9U/eFU9ApsHhSUkP/MtdBg7TWBWK+IFI/M1OswuUaH5f3tEimal/
         qquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/leuO0ReNKxJFhgJ0Qj7KukamA50Bn4keQX7qI/nENE=;
        b=qFbg+Y8UYmbCsKKi+Jw2ziH2ZVGiZpzxH9DWtC/EcUaQFIlGcMJgUIJr3ppSYYI2vf
         Sa6svG8X7fD1np3bZzsgvpsrg77bzxrlwOC7obFgOGLCZnv44m6WMVFRbURdkELz2HmN
         KMU+QWolljzgBJvaxgBz77cE+sK0Vpwf9VvO0mm9ubBpW2OPYXrdzvrt21VOQ2gb39Jl
         85vAFJKE/y3KUSeNM228UhfZ1h/58yKNrImxkmuN6KJQ0Enz7JeYsDb9su4gYnNIeeoW
         VPh9JdhakSwbqmpuINqCIIT/uOVDnnjtu7GWg8SRfm7916iNFMC91TnorzVbMM5h3g6b
         HQNg==
X-Gm-Message-State: APjAAAUatUs4RQTM2stu3VY3E/WpqZgdBqYtriYqYvg87Wu9ZeYfJStM
        JvIZHCr+RlycUu7G1q/4a69qVw==
X-Google-Smtp-Source: APXvYqwIL3aSbbSE3AHMHC3+MPX0zhIl82ebt9C8NHdoa3rLCksIfRwVXXfEDjnPoiIE342asVOFSQ==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr18416274wrq.218.1554736747973;
        Mon, 08 Apr 2019 08:19:07 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id t15sm28228687wrx.22.2019.04.08.08.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:19:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d5c1fb9c-16ec-420c-4067-53d6bccb4ebd@kernel.dk>
Date:   Mon, 8 Apr 2019 17:19:06 +0200
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
Message-Id: <0266AF07-C2CE-49DC-BC54-519F2C71E1EE@linaro.org>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
 <20190408150828.GC23021@linux-x5ow.site>
 <d5c1fb9c-16ec-420c-4067-53d6bccb4ebd@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 apr 2019, alle ore 17:13, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 4/8/19 9:08 AM, Johannes Thumshirn wrote:
>> On Mon, Apr 08, 2019 at 09:05:19AM -0600, Jens Axboe wrote:
>>> I did consider that, and that would be doable. But honestly, I'm =
having a
>>> hard time seeing what issue we are attempting to fix by doing this.
>>=20
>> Yeah, I guess the real fix would be to update the documentation and =
the
>> expectations user-space has. Including eventual re-write of some udev =
rules or
>> whatever is facing these files. But to me that sounds more like a =
systemd or
>> even distro thing than a kernel thing.
>=20
> I agree. Trying to force someones hand by renaming isn't going to fix
> anything, but it will potentially cause issues.
>=20

Potential issues against concrete, big issues already with us.  The
proportional share interface doesn't match the idea people have of it.

I don't want to push for this solution, but we cannot pretend we don't
have a big problem already.  Any solution that could really work is ok
for me, including symlinks.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

