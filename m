Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53668 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdJFMBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 08:01:49 -0400
Received: by mail-wm0-f54.google.com with SMTP id q132so7483058wmd.2
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 05:01:49 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <6D7E3697-713C-4FBD-86EA-20AB1DC72742@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_635F63D7-903B-42EA-8276-89FCEB8C7461";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Why removing REQ_FAILFAST_DRIVER in LightNVM?
Date: Fri, 6 Oct 2017 14:01:46 +0200
In-Reply-To: <20171006115927.GA12530@infradead.org>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
References: <216FF7C0-4B2A-438A-BC63-88A9BBDC77CC@lightnvm.io>
 <20171006115927.GA12530@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_635F63D7-903B-42EA-8276-89FCEB8C7461
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Oct 2017, at 13.59, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Fri, Oct 06, 2017 at 11:19:09AM +0200, Javier Gonz=C3=A1lez wrote:
>> on the lightnvm I/O path and that has propagated through the code as =
we
>> added more functionality. Can you explain why this is necessary? If I
>> can just remove it, it is much easier to do the cleanup.
>>=20
>> I have tested on or HW and all works fine without it.
>=20
> nvme_alloc_request always sets REQ_FAILFAST_DRIVER and that srops
> it to stick to the previous behavior.
>=20
> If you actually want all your lightnvm requests to fail fast you can
> remove it.

I think it is good to fail fast as any other nvme I/O command and then
recover in pblk if necessary.

Thanks Christoph!
Javier

--Apple-Mail=_635F63D7-903B-42EA-8276-89FCEB8C7461
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnXcKoACgkQYx8FO3WZ
GMqFgQ//Y90XPmWdFooT8UPEvnvx5VuMIOvAMxcjifzc80eRln8tx8GEn5uxaCiz
BBfaHVAbnSxw2DJnQ17Ud/xQNKLwTN5l+o1+V8tRjb8yJl4FE39Ufn4rlzJfGmPq
Orq8euYmnVHt+W4hfR5+1Wvr/uOobH2TO0QAaq+ADvUtdB5Hb34rIpdrLRSJI+bJ
URPI5BOBlGTtgTO0KEsRz4A/ZVjWWNnkeX69Dt9JaZIWcT4srT9wePNL819e7azt
LfeDuhfalBxgGQonseTLY48eJuQOuQmxxwcWaNBNRV+wRKr37drg+K7yK3PVTUXf
VdXr2w97Cz5nqDp6t/rYzl2O35EF8qoYlXna6WN+qa6WvizSh+CwJs91JXq7CWwa
sDVz5aovpYqGHzZqHY/ovukgLigBjlNvQIeUKO4eeW88E/a0sVkKIMrF478QwN9X
Aimp4yyVBZe7RrWjh3upC+6QBarN919SM2jHYXqZIMOmxGVomg74OMMuXETt3z9d
/JeyIWDDPt+YsQ+6uZtMXKhswBIQjB23yxQbUdyEOrNRcwSPFSsyfubgB5lxPyiL
dBjpMnLYVNY43h5S+S1DZCr7ZVLP3uxu0fiZa57ig7VVZ0kbFY0Km8BjFra9vySx
GvAlLEg6T5WBbWGmZRfmcTf3jmRCqmCSw/6acNA8rXVs4NycYIs=
=pjxy
-----END PGP SIGNATURE-----

--Apple-Mail=_635F63D7-903B-42EA-8276-89FCEB8C7461--
