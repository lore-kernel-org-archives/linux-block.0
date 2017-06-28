Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38216 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdF1OqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:46:06 -0400
Received: by mail-wm0-f50.google.com with SMTP id b184so61437761wme.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 07:46:06 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <41E89B64-A0CF-43C9-B5CF-B7DFAF6891F6@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F7F6B4E5-CDD7-4DE9-B2CA-ACAD701F9731";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [bug report] lightnvm: pblk: sched. metadata on write thread
Date: Wed, 28 Jun 2017 16:46:02 +0200
In-Reply-To: <20170628142645.khaab3l43vzd5fpt@mwanda>
Cc: linux-block@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170628142645.khaab3l43vzd5fpt@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_F7F6B4E5-CDD7-4DE9-B2CA-ACAD701F9731
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 Jun 2017, at 16.26, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> Hello Javier Gonz=C3=A1lez,
>=20
> The patch dd2a43437337: "lightnvm: pblk: sched. metadata on write
> thread" from Jun 26, 2017, leads to the following static checker
> warning:
>=20
> 	drivers/lightnvm/pblk-init.c:822 pblk_lines_init()
> 	warn: 'pblk->lines' double freed
>=20

Thanks for reporting Dan. Do you want to put a patch together fixing it?
Or should I?

Javier

--Apple-Mail=_F7F6B4E5-CDD7-4DE9-B2CA-ACAD701F9731
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZU8ErAAoJEGMfBTt1mRjK8BIQAJMoDHMaOUyGpq0/C3f5IzZJ
YRcdXVb7rTigTmcMnDy7NrrbWNAQIMGFqtQE2p5NrQVyg12/IkZRKe0C1TksHUeo
a3o0XseCniEfnaMY/oJd1hZZYFg4Dp5C5F3Yff4OGA1GEGuuClCmgHynUWduVM3K
pXNyBVN/fngA36NDqEvu/JJdzxxFO/vwz9Kxpfl9uCjCOKdwELNZssjDEp+BNWgN
Z4axpEn8sF0bFtnzF6GpCjTZtUQmZkDnVB6baMB73mtI5YvmqQyoahv7Xl+HnHhT
ichCjmqb7LaPb8m+09LGM4EsHQzkN+MC3YEddMliMlkFi69ehmux8sxUN9tqpqxM
WCCVUWU+xrhnnw+DTLG8lYXK5pfruGLbnzzSbwJxMhoawD32zizO7oIHVn7v0r+K
qzrpiemDqR3NZU5E/AoaJBHty5DSeVnBltiLIkTp+fajHRmsFJJgWbKezmXid9w+
QnEkK1EokHOqI6pH6Q67AbDAPbbRrUe7a6JzXqdwRC1QTf2heZxsbMABvYkQG66J
AtOeQE/FonDnGC+QgA9qZHbLZUR5vWQvF1r+hC9RIf0NOcmE77c0fCvsM/LYu+V6
7b91vzabx/Ws1gjqaxV90rZ5Z/TPjkw45tFNWgy8QewoDKsBu8tM0VCHYzPv2uFD
AyaOk0AX+ToQtP5gKfpK
=jLpi
-----END PGP SIGNATURE-----

--Apple-Mail=_F7F6B4E5-CDD7-4DE9-B2CA-ACAD701F9731--
