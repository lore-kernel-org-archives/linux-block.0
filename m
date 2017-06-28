Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37088 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdF1PF0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 11:05:26 -0400
Received: by mail-wm0-f50.google.com with SMTP id i127so62216482wma.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 08:05:25 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <FDF98E2A-9FCA-4973-BB98-757647CDC871@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_83E5139E-611F-46C6-8827-2AC67EA3EDA3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [bug report] lightnvm: pblk: sched. metadata on write thread
Date: Wed, 28 Jun 2017 17:05:22 +0200
In-Reply-To: <20170628150342.wnwfbistfzbmjqpv@mwanda>
Cc: linux-block@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170628142645.khaab3l43vzd5fpt@mwanda>
 <41E89B64-A0CF-43C9-B5CF-B7DFAF6891F6@lightnvm.io>
 <20170628150342.wnwfbistfzbmjqpv@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_83E5139E-611F-46C6-8827-2AC67EA3EDA3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 Jun 2017, at 17.03, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> On Wed, Jun 28, 2017 at 04:46:02PM +0200, Javier Gonz=C3=A1lez wrote:
>>> On 28 Jun 2017, at 16.26, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>>>=20
>>> Hello Javier Gonz=C3=A1lez,
>>>=20
>>> The patch dd2a43437337: "lightnvm: pblk: sched. metadata on write
>>> thread" from Jun 26, 2017, leads to the following static checker
>>> warning:
>>>=20
>>> 	drivers/lightnvm/pblk-init.c:822 pblk_lines_init()
>>> 	warn: 'pblk->lines' double freed
>>=20
>> Thanks for reporting Dan. Do you want to put a patch together fixing =
it?
>> Or should I?
>=20
> I wasn't sure which kfree() I should remove...  Can you send the =
patch?
>=20

I will send it on Friday. Have a couple patches more fixing some sparse
warnings too anyway.

Thanks!
Javier

--Apple-Mail=_83E5139E-611F-46C6-8827-2AC67EA3EDA3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZU8WyAAoJEGMfBTt1mRjKt9oQAKldRyfPoWkr2kibCqk+tBwu
abAPFHmPtdxGcWwv84ODg2eW8hpVricmOQxQ40TdmBA7nd4H5qVuwNCJ5RjGTS+S
j1/AWq/5AxV3OjiTAl4ftxjcHdBOWGFMcbK3zh8aFXdKxpyOifAGnw3w9pUo/OcO
TJkL1v9pQFHH3VKUU9s+9T0eMZCABxCYSr6ewLurstn7eVzNSljpOprVLiK+eQ+J
9SyY88QG748wYbDdOesA2zU3oGW5/+EfTolg+bBpUxKYert7+526wmkZrxN7n+k+
ukNDS8t+7tCogI0bdB131V8GWfuH7HW6CFV3o3sM6GI6I3orsARjSu8gFvFFse68
qzDOTHAvIjvA+POSNSAZH6Ff1dbeJZQHVkYch3RgDQpCb7AnfN2ftJKOq67sJp8K
cybAmaodxrs7fFqN870M4sgsw0VHw6uab5If9OfnOt/7KRoxiCqK7h2QMrGOgVuy
LCuek3ypSwHtPom/ev5svWw03nqrKb6qN6YOTQmY0smDIDlm6dVmvdfI8lZv+mm0
8aMARA+xzKgZ0uC6mCj2QBync2SSkFF5Y6mSUOI/K65xtE2PbggjaMTIa/kx9D3b
80ZHtlpA0i1lT9MQrWjuZ1D6y1nJnNYQDEmkkVDQzs7ikNpti/d9efMeqhUZMW3W
W5WlkUP/WJMxcXMedNth
=Nu+y
-----END PGP SIGNATURE-----

--Apple-Mail=_83E5139E-611F-46C6-8827-2AC67EA3EDA3--
