Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37969 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbdIFOBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 10:01:00 -0400
Received: by mail-wm0-f48.google.com with SMTP id 187so31385845wmn.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 07:00:59 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <EE4FE7F3-88CF-42DD-B18F-B0AC2CB5EB2C@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_ACB5EC58-7F03-4B88-BF4A-6774F09218D7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 10/18] lightnvm: pblk: use bio_copy_kern when possible
Date: Wed, 6 Sep 2017 16:00:56 +0200
In-Reply-To: <20170906134731.GD3960@infradead.org>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias@cnexlabs.com>
To: Christoph Hellwig <hch@infradead.org>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
 <1504695071-25928-11-git-send-email-javier@cnexlabs.com>
 <20170906134731.GD3960@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_ACB5EC58-7F03-4B88-BF4A-6774F09218D7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Sep 2017, at 15.47, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Wed, Sep 06, 2017 at 12:51:03PM +0200, Javier Gonz=C3=A1lez wrote:
>> In pblk, buffers forming bios can be allocated on physically =
contiguous
>> or virtually contiguous memory. For physically contiguous memory, we
>> already use the bio_map_kern helper funciton, however, for virtually
>> contiguous memory, we from the bio manually. This makes the code more
>> complex, specially on the completion path, where mapped pages need to =
be
>> freed.
>>=20
>> Instead, use bio_copy_kern, which does the same and at the same time
>> simplifies the completion path.
>=20
> Nope.  You want to loop over vmalloc_to_page and call bio_add_page
> for each page,

Yes. This is basically what I did before.

> after taking care of virtually tagged caches instead
> of this bounce buffering.

And thus I considered bio_copy_kern to be a better solution, since it
will through time take care of doing the vmalloc_to_page correctly for
all cases.

>=20
> And you really want to allocate the request first and only then map
> the data to the request, as said before.

Ok. So this would mean that targets (e.g., pblk) deal with struct
request instead of only dealing with bios and then letting the LightNVM
core transforming bios to requests. This way we can directly map to the
request. Is this what you mean?

Just out of curiosity, why is forming the bio trough bio_copy_kern (or
manually doing the same) and then transforming to a request incorrect /
worse?

Javier

--Apple-Mail=_ACB5EC58-7F03-4B88-BF4A-6774F09218D7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZr/+YAAoJEGMfBTt1mRjKw60P/iWReeEH7bXez9uqLZtTPMui
fpyNkwi7bycns7FRo5s2kzTjsfOXSTeDkNZmcVPd+EqsLKv9JLuVGOpFMZOZSvC1
bVctK+GovAcyYE93FcoQecYthfqJFOZILDs1L0PxmE7LZEixzZKd3Py5p/LTnPrQ
jy//lzHEKPgMei9+42hefhuep1HTX4h41j1O4sPGwoYoIJRAUZxpXTbLlWPMtbN+
ySXuX8DkLhiWjJRll5ypBhaCOHZ5oEf2UjKpL67ym0PskxZ9q9uVKMBoeMN9C8Ke
AbSebzvDRRg+AKC2HYBfyCaRA32/UCRuTIADBoWN0JTzr/2y4IcViYIIaLFyfYdK
wP+yozayN3AN7VyN2sRZRTt31TownL+Ecmo1mMSsvhonlCjnqTHn9cgCEuX/E+f/
7877ovMhd+jjDxNw1tkWf9No+mLy+BfyocQ3cYKwxDrObOigFJTJpbo74sDv53K1
i3y3tXXXPGLfkVJSJiugxxGHQ52tWi/NpuQ7ZuZOW/rsphjGjh/hSeDK2qBQB4GS
Qe3zw3uYNKS6izBbY498mEWzldmIQhCRnKai4UAlwU8RmTWhmBimlOFIrsVpib33
wJhIQlME4RUAmAfWRPMy7jegOm/mPJ0scdsej5EWyPkXSCmQSQJxshWXYd1uC5vy
YTwNnLdCDzMMdJDJQHyL
=MNfU
-----END PGP SIGNATURE-----

--Apple-Mail=_ACB5EC58-7F03-4B88-BF4A-6774F09218D7--
