Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35948 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947235AbdDYQkp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2017 12:40:45 -0400
Received: by mail-wm0-f52.google.com with SMTP id u65so27888932wmu.1
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2017 09:40:45 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <1988AD95-54E8-4A78-8A75-F7105D97270F@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C1E90CBB-9455-4E00-B127-B4E6B1FB0ED4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -next] lightnvm: fix possible memory leak in
 pblk_bb_discovery()
Date: Tue, 25 Apr 2017 18:40:41 +0200
In-Reply-To: <20170425161530.13445-1-weiyj.lk@gmail.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-block@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
References: <20170425161530.13445-1-weiyj.lk@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_C1E90CBB-9455-4E00-B127-B4E6B1FB0ED4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 25 Apr 2017, at 18.15, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> 'blks' is malloced in pblk_bb_discovery() and should be freed
> before leaving from the nvm_get_tgt_bb_tbl() error handling cases,
> otherwise it will cause memory leak. Also skip assign blks to
> rlun->bb_list when error.
>=20
> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>=20

Thanks Wei. Looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_C1E90CBB-9455-4E00-B127-B4E6B1FB0ED4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY/3wKAAoJEGMfBTt1mRjKM3MP/12bl4V7WN7swRyKzAP9eS4W
cl7aV8rYtXt4pGwTr33vgMPrHJFtgC7njZ/PdiWaSzbr8ZnW6WNy15sIVjO0Fxwj
JogFXNTIoSGUiUbqM17oD2rsViqfo+Ipgc6U1wfEbTnEWTQ24rPAQOblLin9ia7M
g83HPdDO3MRe17QRJZcun5skshjN4Q3/6yAusBFfzVQn6sRUN4M95hpkeGpOsZPX
fZUNjM2DKALvdXvmy8zzOlDWejJPhLuGHNsRwAnmIE2/lTzzYJ4DBoCA2uILlU/D
gug8Y9t6m9Yhg/CZmAAVWVzmMBv4VQW9kn+F4ckUDKAqo0Vb0CcjL9XA+N39jMZh
oMg/FRB3hpzQhN5+96zxKEThY+KRsK9t4UZtd12EU3RKfDBM/5hUPkX134COOa1u
Ct4Dfmikz5oMtQyEZ56VZKH9prBZxI9YxGjNvhOTMp4CEX9MvdThaxfC4CP87Zui
N0k/LmYO/bjnDevIl5sLGK2MGJECPfy4HXgJ3/wSwtgEhL4g1THr9dPMsaKPKo5S
g1TPMo7SY4Y5ZrNxVgu5gal3KEOpikFAirydNEBHS8Ulz9QEmtkMxSIGp9XgR2Je
12vTdMmpRn6gXMi2kA7+Tbb+Balh82+RsupIsflvsA1pcrNfBSLEAbtaz3zcdMBs
ttdRMtn7VTPbNyhQb7fU
=UXbS
-----END PGP SIGNATURE-----

--Apple-Mail=_C1E90CBB-9455-4E00-B127-B4E6B1FB0ED4--
