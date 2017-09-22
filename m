Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:44231 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdIVItE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 04:49:04 -0400
Received: by mail-wm0-f53.google.com with SMTP id m127so1146206wmm.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 01:49:03 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <A1244F27-AE62-433A-AFC2-5F40E8B96B53@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AF91417F-8D71-4A49-A8E7-65EC084E0804";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/6] lightnvm: pblk: protect line bitmap while submitting
 meta io
Date: Fri, 22 Sep 2017 10:49:01 +0200
In-Reply-To: <20170921112620.GA28524@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112620.GA28524@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_AF91417F-8D71-4A49-A8E7-65EC084E0804
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 21 Sep 2017, at 13.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> It seems pblk_dealloc_page would race against pblk_alloc_pages for
> line bitmap for sector allocation.  The chances are very low but might
> as well protect the bitmap properly.  It's not even in fast path.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-core.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index a230125..b92eabc 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -502,12 +502,14 @@ void pblk_dealloc_page(struct pblk *pblk, struct =
pblk_line *line, int nr_secs)
> 	u64 addr;
> 	int i;
>=20
> +	spin_lock(&line->lock);
> 	addr =3D find_next_zero_bit(line->map_bitmap,
> 					pblk->lm.sec_per_line, =
line->cur_sec);
> 	line->cur_sec =3D addr - nr_secs;
>=20
> 	for (i =3D 0; i < nr_secs; i++, line->cur_sec--)
> 		WARN_ON(!test_and_clear_bit(line->cur_sec, =
line->map_bitmap));
> +	spin_lock(&line->lock);
> }
>=20
> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs)
> --
> 2.5.0

Looks good. The reason not to have locks here was that the caller is
always on the write thread - who did the allocation -, since it is error
handling. So there is no protection needed. In any case, it is better to
have it since it is implemented as a helper function.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_AF91417F-8D71-4A49-A8E7-65EC084E0804
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZxM59AAoJEGMfBTt1mRjKYCgQAMFGKatnixETwyxfBVHU4JM0
lAM8a/NWZoFYDiByhuiMIrwFAN07o+xyB6RTYImeiYYtorHTeiHfMjRqoMrbCpBl
Xiu4t0jrMviOOekvfjTfZqqmfQ4lJEB/WnqZXjl0gXN2Pe09GZkuMSQDZysDRVmg
5naX6xJJHtsUYr3HafhU5wfgoWl7FMV+lZ2rvH6DXeQ3KBMOjW8y6ovLuBjK1JzE
vFHWS8hIKPLgJMhspppSWfDXfT1kdu6LMsWceA0wi4zX6XX+aXKShFOxThuA3VXA
v82mxHZbugLIKTVw56NgAltmMuWroIVCy3dGyReju9KJNE/sV6fPWD49MaupgTen
2S9SvL4WftQfo/srZPTFhNUXLuo5iNo0VTE8nZyAb2Em8UXeprLBbqfSojnugBYB
fERTm0XoRQJ87viwPT+T8cP/s7Z85KRuwhHQ6x/j6ct3D0E6M3QZra+8EsqwbgYv
rMRgL6APTGesVHQwbH+evt1a33L33hMoPn37kGa0JUISfBGK/An2P16HvyDid0PD
mElEir4cYbMRfBxHytwR7GRD2kCsY2VDY9UJjBbogAZXlh88V7eY0OYrTAG+3dbA
uP6glkG8Ti0QOT9+XfU3ojMy9CVnej9MZZlhvgv+NpWSQ9TjeWiRB6nq0v/VCXn3
LjMbEgwmgZ7qNWRM/NyI
=FUNk
-----END PGP SIGNATURE-----

--Apple-Mail=_AF91417F-8D71-4A49-A8E7-65EC084E0804--
