Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537B9C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216B82147A
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7qARWEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDHOLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:11:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35599 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHOLJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 10:11:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so16638046wrp.2
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Wfns7m8C6GNtBYSwqL699CkDjXwjAiCMYCb7xpiD+D0=;
        b=r7qARWEkYIr5D4+grgEi+uqw0AtlzbEYB2l5odaVhSzt28+2q3kFpCAFvIGwHngb5E
         k0Pk2ASo+KZxofku8U4wN+NTLbn30EsBjTs1bqXyP2WYEghIRSh4g2h7NqyUkMJPTZGD
         kwfdBWvhp1/0fGlXLppY3mfyqKlU64MHOFEDCtpFfr/UyWRJswt0SLFhhBYbpz+uL+c8
         kwKHwPgb0lQADKMSH1ciyRj3YMObsq1ub7ILEheP6rErqdrFo/EIkP1pmcHmGPT1F0Sk
         At3waH4m27xeYqZS9mm2NCniB4LT/pfruP+3rIBtb9kYVvqdb5uFVM0HAfnkGNEuNiFi
         GP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Wfns7m8C6GNtBYSwqL699CkDjXwjAiCMYCb7xpiD+D0=;
        b=drHsVkfkyMs96ttVxiW3rJdZuAoRJcPufVJppUSTDu+0FYJ1aZAvTUZ5PtQx8O6aPI
         6FrprDFBQy7Un9NlyN9A5ma/InypJOAL9GOD5tWI70JO5PAAdCBPgVaA3mmEKwaAQg1d
         bj6b3oDD1CxJ/zhSDS8Gvp/Lq7obAJfQ0NtScgKKVsib5aL0vCsf43g0VglEYfwr4CYs
         y5/ER14CZONz6ZR4o3vLXh0aNbq0EDCJ1yQLvOAt4PI37Cn7pmF6vO/ewUxsoRxyF2mi
         GroTRzod5tDoSmkgr+3gP4lRylZiFsA78+OYKmvonU10K2Vbm24gue6ioSMPLskNF1/Y
         DkzQ==
X-Gm-Message-State: APjAAAXiLeJoEevJCPU1kyRi0w8ZUJDTyxA6xfETpdrbGBfB0arwyMfB
        Jfap2WQiM9srWq5dxwh2ERLGpA==
X-Google-Smtp-Source: APXvYqxF/TKDTsqBzoRpgXsbasxPTdZ4V5BJSelBjfaie/pr3veF4d4aSApkNXbjBRvlpQzXW1eUGQ==
X-Received: by 2002:adf:b6a3:: with SMTP id j35mr17935092wre.25.1554732667505;
        Mon, 08 Apr 2019 07:11:07 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id z17sm15213288wmc.7.2019.04.08.07.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:11:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: About BFQ interaction with git filter-branch
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAHG43Mtboi-DNEs-1shodaU-ds0ip+Z8eGirQtC7ncv5OR4t-g@mail.gmail.com>
Date:   Mon, 8 Apr 2019 16:11:05 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Brown <broonie@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9879FDAE-4F32-415D-ACA8-B285BFBDEE68@linaro.org>
References: <CAHG43Mun738NtLTQ4ASp81jVF+f6PzNhjvucGv8Dz1DTUDVHVA@mail.gmail.com>
 <CAHG43Mtboi-DNEs-1shodaU-ds0ip+Z8eGirQtC7ncv5OR4t-g@mail.gmail.com>
To:     Pacho Ramos <pachoramos@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 apr 2019, alle ore 14:40, Pacho Ramos =
<pachoramos@gmail.com> ha scritto:
>=20
> (Resending as text plain as it seems HTML is tagged as SPAM, sorry for
> the noise)
>=20
> ---------- Forwarded message ---------
> De: Pacho Ramos <pachoramos@gmail.com>
> Date: lun., 8 abr. 2019 a las 14:38
> Subject: About BFQ interaction with git filter-branch
> To: Paolo VALENTE <paolo.valente@unimore.it>
> Cc: <bfq-iosched@googlegroups.com>, <linux-block@vger.kernel.org>
>=20
>=20
> I wanted to simply give you thanks to you and BFQ team.

You're very welcome.

> It's the only
> scheduler allowing me to be able to work with my computer even running
> git filter-branch --force --tree-filter... at the same time.
>=20

Great!  This seems a demanding instance of the personal use cases that
I had in mind while designing BFQ heuristics.

> And that huge difference is with a SSD disk, even if some people in
> internet suggest that noop or mq-deadline would perform better for
> them. Maybe for throughput it could perform a bit worse...

Fortunately no.  Thanks to the last developments [1], even the last
throughput gaps seem to have been filled.  With commodity CPUs, BFQ
reaches the same or higher throughput than the other I/O schedulers,
with SSDs peaking up to ~500 KIOPS.

[1] https://lwn.net/Articles/784267/ (wait for one more week if you
				      are not an LWN subscriber, or
				      subscribe! :) )


> I don't
> know, but for being able to work with the system and not simply need
> to move to other computer to work, BFQ clearly wins.
>=20
> Thanks for your work, hopefully it will be chosen by default for not
> needing to play with udev rules or echo ... >
>=20

That's hard to say.  So far, all numbers have been in favor of BFQ,
but this didn't convince, e.g., Jens himself.  IIRC, Jen's last
request was:

"I'm mostly just interested in plain fast NVMe device, and a big box
hardware raid setup with a ton of drives."

Now we have plenty of results on NVMe drives, but I still don't know
well how to proceed with raids with a ton of drives.  The problem is
not much that a ton of drives is not a precise number, but that it may
hint at so large configurations that I'm unlikely to own them.  If
Jens, or anybody else able to access such a hardware, can give access
to me too, for some test, I'd be very happy to compare all I/O
schedulers on their systems of interest.

> Maybe you could try to add this test with git filter-branch to your
> benchmarks.

I'll consider adding also this test to my kern-dev set of sets (now it
includes only make, git checkout and git merge).

> In my case I have tested with: none, mq-deadline
> (kernel-5.0.7) , deadline, cfq, noop (kernel 4.19.32) on a Gentoo
> Linux system running their gentoo-sources kernel (mostly vanilla
> kernel) while trying to work with a Gnome 3.24 desktop, Chrome,
> terminal...
>=20
> The harddisk is SanDisk X400 2.5 7MM 512GB (X4152012) and cpu is
> Intel(R) Core(TM) i5-6600 CPU @ 3.30GHz
>=20

A rather thorough test.  =46rom 5.2, for such a test you should get
even better performance with BFQ, compared to 4.19.

Thanks,
Paolo

> Best regards!

