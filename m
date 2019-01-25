Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFDDC282C6
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E7021855
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="wDe5kDHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfAYJhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:37:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42164 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfAYJhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:37:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so6848073edw.9
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 01:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=U7xWct8fpo5uF4inpPT83b7tyag62f+IlDnqulmlW28=;
        b=wDe5kDHT96ZRkEpQgeZv15Lq8/P4s1cKVJPH4eufmLrNh/i5ed8+HJ3iWukx6deoUy
         OZjEnkSZyvKoTBt0NZfwNy9CwhRG/Y7LddteXDHuQGvVytyreEmNUhslw+IWapazAEQP
         QPK0adhTvxOa7XhOYxhsaqIn7ypsPTEYI0+jgaRTdQFQCnD4Oh2hEF5poOqsLg2exOc9
         S+XtlmNJr2NYQ4RVFyHG+1UQp1RY8WRjtSDpGzAMqLgj1Duh4K7sLR4RevMTgFU4iIfb
         giVByJtTLADcJ3es7Gfy8/wba3k7iQaQ6kU7w7foXE6Y05RE1rpkg64nrNF1RlB6VWSq
         ZNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=U7xWct8fpo5uF4inpPT83b7tyag62f+IlDnqulmlW28=;
        b=nTXGreTSPh7/0xJRh6xGFivW/UYevtyfqkLBot4bynDWBg3f5VWGifiLDp8fcGwFRJ
         pQ07oSVQi4QkBsyRqbe/yyf08PeNir3QAbwZguVh7y5UYZvieq7WxgyXUohaRODAUh3h
         ssVe3IvXtH4tnmPMETKGIfgEOg8us3hCbp8lYlZcHbskh7lpju9pmRgB8IFwIQ2efgLv
         j5Vnx4fkEoKV1hiu5DUPliYQN6S1W4dJdCgo0oBFNsMqG4AjgJ8D2Vx1sina139YpB+z
         IVW5J3BbPhfdEdWECCswUpN+8GUaNSt9j8a4DtkRe2+HQGOrUnbR+kWHjIfIJg0e/oyl
         cR5A==
X-Gm-Message-State: AJcUukfrTvwIJmF9P+GdMwCAnEJzz2scgWy9bdoZhffw1B+EvPlnztYk
        CJh+IOpsEhlPOLuiUU4JMUoeag==
X-Google-Smtp-Source: ALg8bN6INZA6fUxYN/O52HKyif58nX39xqE03ZXJNS+xYJ1/eBQC2C4ZCN3pexXSaST8zD8YqC1a3w==
X-Received: by 2002:a50:95b4:: with SMTP id w49mr9890358eda.186.1548409036128;
        Fri, 25 Jan 2019 01:37:16 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id b45sm11629157eda.34.2019.01.25.01.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:37:15 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <7BAC034D-8992-41E4-87A9-378813C821F7@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_025C617B-44BF-449F-A530-B3644883D9D7";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: stop taking the free lock in in
 pblk_lines_free
Date:   Fri, 25 Jan 2019 10:37:14 +0100
In-Reply-To: <CANr-nt04b06LAXm0LUV4wtGM18Qb2UZ2+Kq+D7XC79nyiptUug@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <20190122101531.30893-1-hans@owltronix.com>
 <251D7CB9-A9B0-4474-85A0-B0C23DB31272@javigon.com>
 <CANr-nt04b06LAXm0LUV4wtGM18Qb2UZ2+Kq+D7XC79nyiptUug@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_025C617B-44BF-449F-A530-B3644883D9D7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 25 Jan 2019, at 10.15, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Thu, Jan 24, 2019 at 2:19 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 22 Jan 2019, at 11.15, hans@owltronix.com wrote:
>>>=20
>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>=20
>>> pblk_line_meta_free might sleep (it can end up calling vfree, =
depending
>>> on how we allocate lba lists), and this can lead to a BUG()
>>> if we wake up on a different cpu and release the lock.
>>>=20
>>> As there is no point of grabbing the free lock when pblk has shut =
down,
>>> remove the lock.
>>>=20
>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 2 --
>>> 1 file changed, 2 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>> index f9a3e47b6a93..eb0135c77805 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -584,14 +584,12 @@ static void pblk_lines_free(struct pblk *pblk)
>>>      struct pblk_line *line;
>>>      int i;
>>>=20
>>> -     spin_lock(&l_mg->free_lock);
>>>      for (i =3D 0; i < l_mg->nr_lines; i++) {
>>>              line =3D &pblk->lines[i];
>>>=20
>>>              pblk_line_free(line);
>>>              pblk_line_meta_free(l_mg, line);
>>>      }
>>> -     spin_unlock(&l_mg->free_lock);
>>>=20
>>>      pblk_line_mg_free(pblk);
>>>=20
>>> --
>>> 2.17.1
>>=20
>> Can you add a comment too indicating that this is only safe on a =
single
>> threaded shutdown?
>=20
> To be able to free the lines, we need have stopped anything accessing
> the lines first. That seems obvious to me.
>=20

The reason I mention this is that there is assumptions on the shutdown
logic that the line freeup will be single threaded - you can see that we
do not lock pblk_line_mg_free() either, for the same reason as you are
removing this lock. We can do this is only because we have a single open
line at the time (which in close down we fill up in parallel to speed up
the process BTW). If we have more open lines, it would be desirable to
close them in parallel. At this point we either have a sync point when
they are all closed and then free, or we allow them to free themselves.
In the second case, locking will be necessary.

IMHO, a comment does not hurt.

> It would be nice to make a pass over the code and document pblk's
> locking(and other concurrency handling, like the line krefs) though.
>=20

True that - krefs specially would deserve some documentation. Let me see
if I can allocate some time the following weeks to write up some
documentation.

> Thanks,
> Hans
>=20
>> Otherwise the patch looks good.
>>=20
>> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_025C617B-44BF-449F-A530-B3644883D9D7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxK2MoACgkQPEYBfS0l
eODJCA/7BPpAYB3Rmziu5rEtnitaNWmUSiZ2AZ5yHzVq7JmDXMmMqkOa1eXeoJu7
HjXC3wHDcWUoBxAGxwFIUvo36+6o4h5qh2bj+RI/vt2jMP7tbBXQ5Vd6AlAGhnl+
iTfjPf/iuB0VHpL3ViWCpf4rcgvSdk2Qi222INq2YAA9s0hihNsRiRM2SNai6UsD
aSQsuz+fBOrWJzeYFwe7L8Ui67+eU80Su4f25YB4QXuvTP0Yal6S19RmxMWP51tc
5I3lyL4kVFjV6riWU7TiNrG98BKQt/pqPxQaBzgpnbuGgCtBJnY+IituwH7VKidF
YftswdrvqwXeouxnvM2EaCWWnLcI+B9XB5nSwtLWbaMlbyv9WYm5J/ZOPXUMF/8b
bXLsh3UDudB/3tkJJYOnwJg0i4UyMli+UX93MFJdiCKyBl5+jDvK6bk04vO0G1tM
VNMkUY4BYZeCFTEXABXVyiIz9j1cobe0T05/LSqoz5HxmZTHr3CcjStx6/GimYxr
7fSdUD+nQecjmknjL/6WU4Al8jNuDkhgOrLcOiYnrvK3XchD2HGkXjpEpbhWR5gt
U22vjoEvT/KZzOw3y6tofYe/wHNiUmnY4RS4UwGh7WQvLDovbIxPn4RD26jab4XV
zQokB58h3ywvASzZ9+eNgKxOXKMS+VHXrU71kkkNXWByjsq3ACg=
=eU8s
-----END PGP SIGNATURE-----

--Apple-Mail=_025C617B-44BF-449F-A530-B3644883D9D7--
