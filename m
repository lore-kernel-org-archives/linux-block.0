Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:51544
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbeHTPEo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 11:04:44 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: refactor put line fn on read completion
Date: Mon, 20 Aug 2018 11:49:16 +0000
Message-ID: <3799720A-6EEC-44BC-A29E-5082659B9F39@cnexlabs.com>
References: <20180820114320.3764-1-mb@lightnvm.io>
In-Reply-To: <20180820114320.3764-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Aug 2018, at 13.43, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The read completion path uses the put_line variable to decide whether
> the reference on a line should be released. The function name used for
> that is pblk_read_put_rqd_kref, which could lead one to believe that =
it
> is the rqd that is releasing the reference, while it is the line
> reference that is put.
>=20
> Rename and also split the function in two to account for either rqd or
> single ppa callers.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c | 23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index cd2f61eed6a0..16858eaf694a 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -165,20 +165,23 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random =
request\n");
> }
>=20
> -static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq =
*rqd)
> +static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr =
ppa)
> {
> -	struct ppa_addr *ppa_list;
> -	int i;
> -
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> -
> -	for (i =3D 0; i < rqd->nr_ppas; i++) {
> -		struct ppa_addr ppa =3D ppa_list[i];
> 		struct pblk_line *line;
>=20
> 		line =3D &pblk->lines[pblk_ppa_to_line(ppa)];
> 		kref_put(&line->ref, pblk_line_put_wq);
> -	}
> +}
> +
> +static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	struct ppa_addr *ppa_list;
> +	int i;
> +
> +	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> +
> +	for (i =3D 0; i < rqd->nr_ppas; i++)
> +		__pblk_read_put_line(pblk, ppa_list[i]);
> }
>=20
> static void pblk_end_user_read(struct bio *bio)
> @@ -208,7 +211,7 @@ static void __pblk_end_io_read(struct pblk *pblk, =
struct nvm_rq *rqd,
> 		bio_put(int_bio);
>=20
> 	if (put_line)
> -		pblk_read_put_rqd_kref(pblk, rqd);
> +		pblk_read_put_line(pblk, rqd);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
> --
> 2.11.0

Looks good to me

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6qrkACgkQIX4xUKFR
nnQgkA/7ByvFT6fbi2MayWh8oOGNGPnh07DsmkRFamR1KFHFd0zwNkCDZ00fDXHO
ei7w97fPbI56EziYPMN7vqRRtrCUyyqbiCDsZxttslHFShiV5v8pH+we/Z6OVE/0
GXcASdantM/Bdhd1rmZjOToEtxYqGSbUyeJkI2oBTtBwqJIrGKr5s5CeVrb9yPrd
6dyebJNvNdzzSa/rYt1rIqTveFA3GOr++6yGOnDvHgUMtpc66XQAiaC7Wxh6hwkG
GBpGWWnZKhvTCLVY4zJrcercFR5yAAGvJ3RdMX3qrM/F3yEqeqoOqzeGqeehVP/h
HyhOtvDvUu/KOKNsJX86eI2u0K6lw6rH1wWNHqPZFtPVnDbRuO8GlGttC9OwEFz/
PSdi4WWJLdfY9a4hZUrzfNXSysnIkClEUtxpmGBsjN2HKD0JG7LqAaX/n2lFbsag
rdeVpXvuVVLcSUJZdRzA6AEuasSYxU14cnFUDFj4Wn0sOP/WsJ8tiz2uK/WGFbiW
Da5u0SgynGGQtUpNUWDFAtheSEIFaK1pAAXSoI9envFC13awvQVKxbTifF82UGKI
Kh9989mZDE4naDbEYnCLX8RrRpMsaWoHca5DWbUzZt5Rril/HbMz6hTKIGrMSS4G
wk6IlUFCFhfsvNsUOeeBl6BLTE9uk0rhaoIMBQuNgZh7TvVGNZU=
=2BpG
-----END PGP SIGNATURE-----

--Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951--
