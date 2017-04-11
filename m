Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33982 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdDKWNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 18:13:35 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so4866320pgg.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 15:13:35 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <8123618D-0CBB-420B-BC68-64A0A36E2532@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BF6C52E3-F4B3-4037-8978-0C89446537AB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v5] lightnvn: pblk
Date: Wed, 12 Apr 2017 00:13:29 +0200
In-Reply-To: <1491923975.2654.4.camel@sandisk.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1491921077-9377-1-git-send-email-javier@cnexlabs.com>
 <1491923975.2654.4.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_BF6C52E3-F4B3-4037-8978-0C89446537AB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Bart,

> On 11 Apr 2017, at 17.19, Bart Van Assche <Bart.VanAssche@sandisk.com> =
wrote:
>=20
> On Tue, 2017-04-11 at 16:31 +0200, Javier Gonz=C3=A1lez wrote:
>> Changes since v4:
>> * Rebase on top of Matias' for-4.12/core
>> * Fix type implicit conversions reported by sparse (reported by Bart =
Van
>>  Assche)
>> * Make error and debug statistics long atomic variables.
>=20
> Hello Javier,
>=20
> Thanks for the quick respin. But have you already had a look at the
> diagnostics reported by smatch? Smatch reports e.g.
>=20
> drivers/lightnvm/pblk-rb.c:783: pblk_rb_tear_down_check() error: we =
previously assumed 'rb->entries' could be null (see line 779)
>=20
> on the following code:
>=20
> 	if (rb->entries)
> 		goto out;
>=20
> 	for (i =3D 0; i < rb->nr_entries; i++) {
> 		entry =3D &rb->entries[i];
>=20
> 		if (entry->data)
> 			goto out;
> 	}
>=20
> Is that "if (rb->entries)" check correct or should that perhaps been
> "if (!rb->entries)"? Smatch is available at =
http://repo.or.cz/w/smatch.git.

I have run smatch over the code (did not know the tool, so thanks!).
This particular error has been fixed on v5. The only standing warning
relates to a semaphore on pblk-map that is taken on the erase path. This
is a false positive; it is intended that the semaphore lock is taken
here and then released on the completion path. Sparse and coccicheck
have been also been used on v5, but please point out to any other
tools/concerns you may have.

> Bart.

Thanks,

Javier

--Apple-Mail=_BF6C52E3-F4B3-4037-8978-0C89446537AB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY7VUJAAoJEGMfBTt1mRjKg9YP/RbS/oNkOKgi3ezsXpsj366a
PznVu//WbBRnn1ZzMPexD/6trWL/23Mx4P8Zw2dRa9AnOB08jGAOuO9xg/qDmXwr
xt6LEI7cJm3tP1bX1igomMOkcEyr/vTcW+aEPkRRRUbCvM1clpVMNlKX5/8czW03
Tkry7pyXqIjZesbOt2V0zFkevgWKr8gVbs2DsX3XIhZd6kT8fMeFF8no8ooZ2Ib9
EetNrvS9z0d8lWJrVsvt1xLQO+Ytz5XjpilYBauIEp5+4yElGsUMjxJIkuxYqFVS
GtLut8HE/HNieKXCh5Vl1YEyzVJwKGDKv5TedvkpRddi/7qpTaWn+4cgUV31f2tB
q6u779HMHVALk865lF2gAtA074BNU9loy62XZtX/m/IlQywytOp6YMIGN6Bcgb6C
ORkZZgkZb4iIo7xDc73r7sYTOpBZE92mkKliU/QjwTMStFm7b9CzL47h40hQrhG5
yswHOJzPNodqUzaC0VYwwcM3xzk3J0AU1v5Rmi+QVdbHqSwsv6uGs1BEUNfGM0iA
ybBCJrNAJCAtwgxHWhRSBRASq78Ou5603aHu6Tg1vB2srKOOl+H/Q8D7cifCQil/
/13+3HujCqCjHYQBgf2z4W/XF78rrt1ab7hxeJdetb7IkPnMVs0+4TqeNVOtITAQ
udP+7PVDXP/xptffn7qF
=+x+q
-----END PGP SIGNATURE-----

--Apple-Mail=_BF6C52E3-F4B3-4037-8978-0C89446537AB--
