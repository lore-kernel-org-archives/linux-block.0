Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr690087.outbound.protection.outlook.com ([40.107.69.87]:60868
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751251AbeFHMh7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Jun 2018 08:37:59 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Subject: Re: [PATCH v2] lightnvm: pblk: handle case when mw_cunits equals to 0
Date: Fri, 8 Jun 2018 12:37:54 +0000
Message-ID: <62454DF5-7E75-453B-ABCD-197B1B114A20@cnexlabs.com>
References: <1528388123-14193-1-git-send-email-marcin.dziegielewski@intel.com>
In-Reply-To: <1528388123-14193-1-git-send-email-marcin.dziegielewski@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_314D35CD-72CA-4133-B9B3-B9281F1A0715";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_314D35CD-72CA-4133-B9B3-B9281F1A0715
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 7 Jun 2018, at 18.15, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
> Some devices can expose mw_cunits equal to 0, it can cause the =
creation of too small write buffer and cause performance to drop on =
write workloads.
>=20
> Additionally, write buffer size must cover openchannel write data =
requirements, such as WS_MIN and MW_CUNITS - it must be greater than or =
equal to the larger one multipled by number of luns. However, for the =
performance reason, we are using WS_OPT value to calculation instead of =
WS_MIN.
>=20
> Because the place where buffer size is calculated was changed, this =
patch also removes pgs_in_buffer filed in pblk structure.

Please keep 72 characters on the commit description.
scripts/checkpatch.pl should report this.

Maybe Matias can format it when picking it up.

>=20
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-init.c | 9 +++++----
> drivers/lightnvm/pblk.h      | 3 ---
> 2 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index a27b28d..2f94832 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -179,11 +179,14 @@ static int pblk_rwb_init(struct pblk *pblk)
> 	struct pblk_rb_entry *entries;
> 	unsigned long nr_entries, buffer_size;
> 	unsigned int power_size, power_seg_sz;
> +	int pgs_in_buffer;
>=20
> -	if (write_buffer_size && (write_buffer_size > =
pblk->pgs_in_buffer))
> +	pgs_in_buffer =3D max(geo->mw_cunits, geo->ws_opt) * =
geo->all_luns;
> +
> +	if (write_buffer_size && (write_buffer_size > pgs_in_buffer))
> 		buffer_size =3D write_buffer_size;
> 	else
> -		buffer_size =3D pblk->pgs_in_buffer;
> +		buffer_size =3D pgs_in_buffer;
>=20
> 	nr_entries =3D pblk_rb_calculate_size(buffer_size);
>=20
> @@ -366,8 +369,6 @@ static int pblk_core_init(struct pblk *pblk)
> 	atomic64_set(&pblk->nr_flush, 0);
> 	pblk->nr_flush_rst =3D 0;
>=20
> -	pblk->pgs_in_buffer =3D geo->mw_cunits * geo->all_luns;
> -
> 	pblk->min_write_pgs =3D geo->ws_opt * (geo->csecs / PAGE_SIZE);
> 	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 7fbdfdc..b62fc3e 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -608,9 +608,6 @@ struct pblk {
>=20
> 	int min_write_pgs; /* Minimum amount of pages required by =
controller */
> 	int max_write_pgs; /* Maximum amount of pages supported by =
controller */
> -	int pgs_in_buffer; /* Number of pages that need to be held in =
buffer to
> -			    * guarantee successful reads.
> -			    */
>=20
> 	sector_t capacity; /* Device capacity when bad blocks are =
subtracted */
>=20
> --
> 1.8.3.1

Otherwise the patch looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_314D35CD-72CA-4133-B9B3-B9281F1A0715
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsaeKAACgkQIX4xUKFR
nnSUkw//QYIef0zQVCIB1X2HzkXfiCzcABv5m+Q5rRR95iBhqWKkYZ+xPsy/38CQ
9L6Sng48gMkoapemkOHOrbKa0RGXKg32vlCmC+Z559SA6hiL5GAybHqe5AE/rhvJ
u9Haw47s9jjGEfKaEVSnc5Tim81DPBaD46kRMK7hwKAqCe6VzkbxvJe0C+0JB9GK
7cSl/LAL0yBZtd8Iupyd1voZ0pNBNoKstW6MsOhXOURABTtxgDgYtuo6vfIiXrRE
pIJawM/l+Oa602OgqC9j0e2ln+tRN76n6WLAgFoiZ+RpuRkD9KOuT77KILarc0X+
CUtLR8Yf3YfC0JzaZ178XvGPk5oFKHv2IilHSTnax6+5VUTWV3V/IkXLs5vOBBH9
Yt7q2QF4d5CZSBi5mgx73Kb++PetNV/7YHJ82MYgBJ1ze86+xse85T5Dzh3MxsMk
sn+Vo7oc3909foGiSup9ljRvFVApZQNaNwWOAWhYDOt1pJIUwPhtlkziwRzxyTIP
smClt9bikFh8vIxe07HPoniQWv9gnC2rByyFNCRHHTTu7hYru/hgUWjNA9N4/rqN
r0ASoVrobwwsAvvw3hpzsfwcDggawZp8zNvZ27OlzMVqXzM/xbV+Q3Ei0N2sx74a
TApTfb8WSJ96l6Th6jq2kGXJqwVVwver5en8Oxlk3fYT1iqcqLQ=
=10Cg
-----END PGP SIGNATURE-----

--Apple-Mail=_314D35CD-72CA-4133-B9B3-B9281F1A0715--
