Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C03C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DBE2067C
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="P3twHYzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfDZKEZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:04:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36776 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfDZKEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 06:04:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so617735edx.3
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2019 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Uhnd+ZTyHqzarEfmPfq7PYfZRuzWwiqjQwSXkDCy4pE=;
        b=P3twHYzVOMkoVN49T4LZraJ+/RZHUFkdxtSWal6fYhFBa5bj50eJU/JLmZO6YUvITg
         AUVPKFvLWiosviB4z0Zj9YSpKYRq0PEq+uMaUWCXg833oBUiVSLEXqW0i03vaBRoMk/J
         GOlJKnrsuXXSulan2ml5qT98SKzg10lJJ7bwzoQMSY00JiEzeGtfWAyqbSLmnpE98M/Z
         ladJ4Sh+/bKC6w8y+JyIvhYT8o1GLkNrFmSN/fF84MK8GdgDV7yd87cOhWnnNHwpw7rF
         y2S1jTnmBs8dCDu/vWFu1fhU0Sa3qqNRdak717uUA1ImGK28iw8B9xrDnKm9MMpBVw7T
         9wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Uhnd+ZTyHqzarEfmPfq7PYfZRuzWwiqjQwSXkDCy4pE=;
        b=WvBlNj6JRE9jzZTcHURfVbUow+6SgwRxOdp7SX6xiWdVgjHECW14r+WOTdFTFK0AZZ
         FPBArjpXKZUPjygQ3YFjny096peWflLI9X11Tf6czVSZOPFXp4XZgOoOhe9q1vvKPuAE
         LB7N2YgxUkQg22eKiGSEDAoA3ZZZrVj/feXWXkhhNnJymY9F5br99YiC10SjPG3yX9A/
         spsv101PDR8s0U8kaBYQLQ7eZrOyj2uU67Ruv5gzh5hGccLx5WpZTYSuyU6Rb62gf5MO
         HjHUHI6uj3Z0k9n8ACD3+gLEC/XFFJUClYISwdPPCiZ6CMru2oxnvdXjUUNU/F4mSvIR
         H9jA==
X-Gm-Message-State: APjAAAXweVt5QMbefnw1qa0ITmNCifyCMYehTGy74FVyy6NLAHqPIaqc
        aBAMVNyMmx7/z424bjpP3fKUeg==
X-Google-Smtp-Source: APXvYqwxVe2Brd3cEcDyMGvyGObIu494Zy2LCquIvfAA44lSCeAgXV/X0KOZ5VZcRcnmODt0JqkGHw==
X-Received: by 2002:a50:adf8:: with SMTP id b53mr27121578edd.194.1556273063083;
        Fri, 26 Apr 2019 03:04:23 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id l46sm7058645edb.24.2019.04.26.03.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:04:21 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D0EF968A-4724-4E5B-BE8B-7FBB785420C2";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
Date:   Fri, 26 Apr 2019 12:04:19 +0200
In-Reply-To: <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
Cc:     Heiner Litz <hlitz@ucsc.edu>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190425052152.6571-1-hlitz@ucsc.edu>
 <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_D0EF968A-4724-4E5B-BE8B-7FBB785420C2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 26 Apr 2019, at 11.11, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> On 25.04.2019 07:21, Heiner Litz wrote:
>> Introduce the capability to manage multiple open lines. Maintain one =
line
>> for user writes (hot) and a second line for gc writes (cold). As user =
and
>> gc writes still utilize a shared ring buffer, in rare cases a =
multi-sector
>> write will contain both gc and user data. This is acceptable, as on a
>> tested SSD with minimum write size of 64KB, less than 1% of all =
writes
>> contain both hot and cold sectors.
>=20
> Hi Heiner
>=20
> Generally I really like this changes, I was thinking about sth similar =
since a while, so it is very good to see that patch.
>=20
> I have a one question related to this patch, since it is not very =
clear for me - how you ensure the data integrity in following scenarios:
> -we have open line X for user data and line Y for GC
> -GC writes LBA=3DN to line Y
> -user writes LBA=3DN to line X
> -we have power failure when both line X and Y were not written =
completely
> -during pblk creation we are executing OOB metadata recovery
> And here is the question, how we distinguish whether LBA=3DN from line =
Y or LBA=3DN from line X is the valid one?
> Line X and Y might have seq_id either descending or ascending - this =
would create two possible scenarios too.
>=20
> Thanks
> Igor
>=20

You are right, I think this is possible in the current implementation.

We need an extra constrain so that we only GC lines above the GC line
ID. This way, when we order lines on recovery, we can guarantee
consistency. This means potentially that we would need several open
lines for GC to avoid padding in case this constrain forces to choose a
line with an ID higher than the GC line ID.

What do you think?

Thanks,
Javier

--Apple-Mail=_D0EF968A-4724-4E5B-BE8B-7FBB785420C2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzC16MACgkQPEYBfS0l
eODiWA/+NnPGXwCNAiRIGflg6iOCkHbPmUN+s9PhmEz1JYn0aPWhDz4lCRPEd+fX
JGFcg6CI/YpHE2Vm6YxpvqbzUgHe3LkJt3wPAEakLVHRRzbymtoU0f0sPnNibnJK
VcA227UPRzz7wHb8eZBG+ChzEA1EUgL+4/eUcRlzhNG4Ofog6uchZl36Y8R/wrqT
djuZq0ziFvI/y60gTgYP5KkKqS/mlMZw2OXYYfEJHCYEwMJ43lXfWHH7HeX7PYt9
lE2K4sIP9Q13N4l1XbqTctLv1ykaFdp73Mj3dwgz9wSbo5/rnYuoOY+B0igF39Y7
pqZA3akAjzGenKHjN7ufe0/+Dxx8pcKewfj4vH2RJ6rjs8Xb5hkNCpRzls8ZFmN9
QEHfxCwtZjt2/Zdey6cgVtkrBeaOXiSMqnuynGbFOLw/9zqAkzmzSP+rXLISqf6b
xKxxXjIWFUe5gAmEpVv92ejq1VGTooT8WXYyL+HsDnXMovsGZrgO8kPyyTNioHxP
vSyZ6Nvn2TyoWlaH6iILmJcLsm4pYpdr6ZeF3GbNH3I5DOfpHXjM4wbeH3+xAano
865HG0uySxZHIGf3OOuXXjsRemJPA1FN6MdyZ3eLwMFmM/CYBOBy2fqB7GhCM9KA
8eeOdP26FJdMb7cP42lYS1r8bkrYvP6pXBW3JH7YIUlMTwJx3Dc=
=1OCh
-----END PGP SIGNATURE-----

--Apple-Mail=_D0EF968A-4724-4E5B-BE8B-7FBB785420C2--
