Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0124EC31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 07:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF5420874
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 07:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7hiit2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfFLHcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:32:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40459 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfFLHcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 03:32:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so5359680wmj.5
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2019 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=QMtgwyts0QGdC+1fc20nq5wA9txu5y6YVEKphC2r0+4=;
        b=D7hiit2zreapEqB0/InvMsT27/9a3p3z3qHe2ucl2ViENFPsDHzM6ITHXgTZmVB1WX
         8leZarVOzmEGuggBGu3Fyq+skOUDGOrW/jOE4giZSKgSflD63iMk1TqOeUbPua4sLaZM
         5lWxOEs+KdY3owHRwJiGD+Um+YpVP3KJuXMzMQjmcx7y/riZrxSWldkqqGcTKHB75wWp
         WD0CrE3eXSm/VrsrNbrHFqLsWJNofhW/6DHghkid+r3WPcdewHkoTBH8aNDeiHj1yxpD
         KW7JVNByIxPc20wgpKqUKs9IL7+vTA7Obo2bmwAg3UnOaxxY8+ndh57nr/z13ChpgVNC
         fj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=QMtgwyts0QGdC+1fc20nq5wA9txu5y6YVEKphC2r0+4=;
        b=CDr3UaXedWD3+Digl7xbjBNRnU6sOs48vfHAEDbmJIf7UUC27sqhSM9/58MjUpCUyJ
         BGBhGb82E2NRYV/6f0SkVHdiDcZZRo+kccgYqsdV0ds6TMFRanyFSnV2+rWHUJRte1MJ
         WT192J9TaFXekmxKPgARuL+jjCOoOfPgrYE53JbjEZ4lIPeCatWBFxyP877WppSnyr9J
         IPfK7qWwyIKYhrJtXkzV8DVBpS8RGFtzagU0LP5yOkzExG2WcOQFzU2/HCzBweIKrR3f
         4OkttJdEr51a0tQe3teT5Dadp+Xt6I/wYVI6MpwG/SOOvc3UPYdTjPYEi4a0W/d0GaD3
         wJOw==
X-Gm-Message-State: APjAAAU6M9cENyT1S0y2lpjGXUAucdbwh2zb+nARfhdjbNJh3qIEdr0F
        wa1QqrOf4n3VoZ8WPsLYEE58Bg==
X-Google-Smtp-Source: APXvYqwN6BM+EG5ByMN8tbmVzzJUicHNXZPWFFtMyrJeeqvoMdP33k8MriLjcyzBN2cp1fDWT5tmjw==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr20980325wmi.140.1560324730509;
        Wed, 12 Jun 2019 00:32:10 -0700 (PDT)
Received: from [192.168.0.101] (146-241-96-49.dyn.eolo.it. [146.241.96.49])
        by smtp.gmail.com with ESMTPSA id b14sm12865858wro.5.2019.06.12.00.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:32:09 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <A1C3E3D8-62E3-4BD3-86B4-59E7E1319EA8@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3C8282D4-E1D2-4BD8-9741-E58209C7228A";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
Date:   Wed, 12 Jun 2019 09:32:07 +0200
In-Reply-To: <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
To:     Tejun Heo <tj@kernel.org>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
 <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
 <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_3C8282D4-E1D2-4BD8-9741-E58209C7228A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 11 giu 2019, alle ore 23:17, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Tue, Jun 11, 2019 at 12:49:59PM -0700, Tejun Heo wrote:
>> (Description mostly stolen from 19e9da9e86c4 ("block, bfq: add weight
>> symlink to the bfq.weight cgroup parameter")
>>=20
>> Many userspace tools and services use the proportional-share policy =
of
>> the blkio/io cgroups controller. The CFQ I/O scheduler implemented
>> this policy for the legacy block layer. To modify the weight of a
>> group in case CFQ was in charge, the 'weight' parameter of the group
>> must be modified. On the other hand, the BFQ I/O scheduler implements
>> the same policy in blk-mq, but, with BFQ, the parameter to modify has
>> a different name: bfq.weight (forced choice until legacy block was
>> present, because two different policies cannot share a common
>> parameter in cgroups).
>=20
> Sorry, please don't apply this patch.  The cgroup interface currently
> implemented by bfq doesn't follow the io.weight interface spec.

Could you elaborate a little more on this?

bfq code for setting up and handling io.weight (more precisely
io.bfq.weight) is a copy and paste of cfq code.

Thanks,
Paolo

> It's
> different from cfq interface and symlinking to or renaming it won't do
> anybody any good.
>=20
> For now, the only thing we can do looks like keeping it as-is.
>=20
> Thanks.
>=20
> --
> tejun


--Apple-Mail=_3C8282D4-E1D2-4BD8-9741-E58209C7228A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAl0AqncACgkQOAkCLQGo
9oOMXRAAoEDcCx8bMHHzhbSNf8ZfMTdRpoYcT1kk65OMw8iOJ0wIQyLXhsNjqLsf
h4Cz55g5wGA4Do508iljbDVJCiCkJWSAjrKywOOxklx2CKgZejbqCyvWWy08lkhW
p6Tc3s7sIdmFTeBdWURwy10xYO0dOiQUA5cZQOS8cQBp1BtAbgTrB/uYdf82B4Te
WNAN9qeMDsl0s0fWN493DjjRiPedUMj+otFJbmVue9jX18wVnyKta440pxkxx2Cp
gXzMbC5HTusObz7eq9cR+NiCncftsEM4rRoz5O7nrM5VeeGLf4ad2FmaA+PVFTza
yrd4Zj5JEYWDa5QW/tQ8S3sQmGnur5uWzkO8diY9EaKw7ZQNp4AXFWKuBy4ESFEz
dQgeihcIkmJvAGXt8K9uWyc9sqfnVC9xn8jseU9iCXIcS+NxOOaO671yBHXUZFFu
hZppYRg1j4b40UXFpUSq7WZmBZX3vtj1/UIzM/x4DYeRFntcJv0RWJDoicFaAkda
70P4JrC3hR96F8lqy25StxIt8iYeT7lIgFl9VvLmlYCLIvpkhSG7DBPWu1ARocoH
OBUWidLcn5MkT4cxqQeqksnI46nnmZXPfdVKViPUOI7j8FDFic5kTW2/JAWv5NXw
Kx0EI40DL6U1I0IB5W9sbIV2iofhvzJGejMao7/5kUaRTKjb7w8=
=KrPP
-----END PGP SIGNATURE-----

--Apple-Mail=_3C8282D4-E1D2-4BD8-9741-E58209C7228A--
