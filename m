Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5456C31E40
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC2A206C3
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 14:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qajtvbdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390261AbfFJOty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:49:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51943 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbfFJOty (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 10:49:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so3879434wma.1
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=A7S7JGBmczEndtH1SNqeQ60kQQeVijqVO1oEOrAhBj8=;
        b=Qajtvbdu6Z48mSZ+DUChAPH2GJgRbbUyKgTpz48ReiLthzr/iQBGG2Kae0piQqCocR
         +T6/y0+H1z6cM3OtT1jikQPo2rNFRFBRzIYrvxF5NZ30E11KOJMMIWTNA8JcGXDh1iGD
         0C4S3dr2abohL8uZXQ3oMaF4+qe9FVZyMm3d1nwrFYaIT1PAIeyBEBR1qVWWBNPIZYj7
         SeEltAtVbnuKiE0Ai5SSK2okiCnrRZUr8hfigMcz+xfX/tjX4nZfSO10wuY9QodobjhK
         d9oz+m01TW17blJYUaX2R6jf620UrfGZuqNu31jrJPa09c1gvo0IBNBG+DeNSsikzDXA
         TS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=A7S7JGBmczEndtH1SNqeQ60kQQeVijqVO1oEOrAhBj8=;
        b=P3QpUDn/199x1gLs6/cPgCUTNcFXBACTb6AZ93oTIM/LYWaBQ9iWgTGlWblchtA1Zl
         d2dFBgcQ7ghwo4vEujQT1bIG0p/EMCkeVR3qZsdagnh60OcavSOrhaPhl4hVjhc8uFnD
         olQ/pu9RJUwRrasHE7Hd7lrpKLg+Tt+/rkBn8Sq0Kx/JD14XU/6NKr4FIunN10li/YFO
         Hv78p0nwiZtv/WEfizm2zCIbq9mIfGWy0lx5oGgRq/rEdTfF+XbLmgziaej+OfYiD00D
         PajmeORO9MK2K5F7b0osaf3LoHeVaI3/U01nRY22e/zu4LwZ9DP0zQzBqbhgvSY/x9GN
         yIxg==
X-Gm-Message-State: APjAAAWjGVE4+z0bJAr3xlNNwoSWtsr4EyX0hcoJN6DgN497/Rln46Au
        JVWaGBWGoQhLj5eADznmSNTAmg==
X-Google-Smtp-Source: APXvYqyBgTcjseBsTC/DmZarQ24ImGDj6jH9LhZtCWFFqDGKHe287EJVBuQnRKcDFLboNh6LgcZf2A==
X-Received: by 2002:a1c:bbc1:: with SMTP id l184mr13596761wmf.111.1560178191181;
        Mon, 10 Jun 2019 07:49:51 -0700 (PDT)
Received: from [192.168.0.103] (146-241-69-56.dyn.eolo.it. [146.241.69.56])
        by smtp.gmail.com with ESMTPSA id t7sm10418020wrn.52.2019.06.10.07.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 07:49:50 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_83BA77E0-46A0-4C23-87D2-E77D3CE3F0D6";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [GIT PULL] Block fixes for 5.2-rc4
Date:   Mon, 10 Jun 2019 16:49:47 +0200
In-Reply-To: <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
To:     Jens Axboe <axboe@kernel.dk>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_83BA77E0-46A0-4C23-87D2-E77D3CE3F0D6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 10 giu 2019, alle ore 12:15, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 6/9/19 10:06 AM, Linus Torvalds wrote:
>> On Sat, Jun 8, 2019 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>=20
>>> FWIW, the concept/idea goes back a few months and was discussed with
>>> the cgroup folks. But I totally agree that the implementation could
>>> have been cleaner, especially at this point in time.
>>>=20
>>> I'm fine with you reverting those two patches for 5.2 if you want =
to,
>>> and the BFQ folks can do this more cleanly for 5.3.
>>=20
>> I don't think the code is _broken_, and I don't think the link_name
>> thing is wrong. So no point in reverting unless we see more issues.
>>=20
>> I just wish it had been done differently, both from the patch details
>> standpoint, but also in making sure the cgroup people were aware (and
>> maybe they were, but it certainly didn't show up in the commit).
>>=20
>> So I think an incremental patch like the attached would make the code
>> easier to understand (I really do mis-like random boolean flags being
>> passed around that change behavior in undocumented and non-obvious
>> ways), but I'd also want to make sure that Tejun & co are all on =
board
>> and know about it..
>>=20
>> I'm sure this happens a lot, but during the rc series I just end up
>> *looking* at details like this a lot more, when I see changes outside
>> of a subsystem directory.
>>=20
>> Tejun&co, we're talking about commit 54b7b868e826 ("cgroup: let a
>> symlink too be created with a cftype file") which didn't have any =
sign
>> of you guys being aware of it or having acked it.
>=20
> I talked to Tejun about this offline, and he's not a huge fan of the
> symlink. So let's revert this for now, and Paolo can do this properly
> for 5.3 instead.
>=20

Hi all,
we'd be ok with implementing this the right way, but what's the point
in spending further hours on a solution not liked by Tejun?  Here's
what happened so far:
1) General solution allowing multiple entities to share common files:
   rejected by Tejun.
2) Simple replacement bfq.weight -> weight, after the only entity
   using that name, cfq, has gone: rejected by Jens because it is a
   disruptive change of the interface.
3) Symlink, proposed by Johannes: maybe rejected by Tejun.

Tejun, could you please tell us whether you may accept the last
option?  This option may be associated with deprecating the explicit
use of bfq.weight (I don't know of anybody who wants to use this
confusing name).  So, in a few releases we could finally drop this
bfq.weight and turn the symlink back into an actual interface file.

I'm running out of options, apart from giving up.

Thanks,
Paolo

> Sorry for the confusion! Please pull the below.
>=20
>=20
>  git://git.kernel.dk/linux-block.git tags/for-linus-20190610
>=20
>=20
> ----------------------------------------------------------------
> Jens Axboe (1):
>      cgroup/bfq: revert bfq.weight symlink change
>=20
> block/bfq-cgroup.c          |  6 ++----
> include/linux/cgroup-defs.h |  3 ---
> kernel/cgroup/cgroup.c      | 33 ++++-----------------------------
> 3 files changed, 6 insertions(+), 36 deletions(-)
>=20
> --
> Jens Axboe


--Apple-Mail=_83BA77E0-46A0-4C23-87D2-E77D3CE3F0D6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlz+bgwACgkQOAkCLQGo
9oN52g/8DZ1uF/vjCae4pLzLw26f3gsNwzBi+xYpfUSLZJh2mv1uOpId21hHqRH2
uLoev+IzMtMDQBKDtObMMqZg3i2/6fZkDs6g05aJL7r/gdzLY8T73UyHRI5AjlZO
lKwBP9Rj8v1u5NWA3QS78Q/JnQIO6aXPRRUUBNFk3tWuhe8061cDds9OC28CFxaS
6tsgHBY6AAQ15bL/i1YXjBUuwPDuGhqUpbIYKD0JuHWJsdB2RWjnwLkJY+ydIhwq
nwYZavfzYQF/8eZTKK2V/TsvMJXDQYZlB2LVQFzFIq0I4F0rPDS+jLxeZwQn0BIf
axClFbBr6m8oOzIuhgnYlKRgUJsptoLvLhQorEZjEtfKzZRBekzeWdW5UqJOpGuv
2r2t6LAyFE/k+K1dHtD6mZoYFV807JY+8uVCp8s4/I9TDxaJOmxI6g44EsHy8ecX
YV8C1IxKV/Y1bo3D6TrN1fSfJfrFBDTCuDznOEuCKaSV0sqxqYkMP5iYohoa6vjn
NnILmVdltB1634jwEcRqIA/Kfk4JT3Nt04i4LPXbalcESXzeYzdoMwCCbgrdYwfS
355I37RIW8rPg1N64XvBUVDt0fvR43/oTqge3hNXWEjR2j7vJY/acbn+AAaf7fWV
I+gppYWm+emRQ6bCHNJYSJPpT6zPbor6NlWoF6NYfk6szhj3BX4=
=n7bs
-----END PGP SIGNATURE-----

--Apple-Mail=_83BA77E0-46A0-4C23-87D2-E77D3CE3F0D6--
