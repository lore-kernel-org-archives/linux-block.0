Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:56935 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdJCKgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:36:47 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so2035313wmd.5
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:36:47 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <0C7D68DA-B8B2-4438-A332-C9BC431F05FB@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CAA0D4EA-1437-4CCF-BEFE-77B2B4137429";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/9] lightnvm: pblk: start gc if needed during init
Date: Tue, 3 Oct 2017 12:36:45 +0200
In-Reply-To: <1507025113-13351-5-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-5-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_CAA0D4EA-1437-4CCF-BEFE-77B2B4137429
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Start GC, if needed, directly after init, as we might
> need to garbage collect to make room for user writes.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-init.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 1cc3de4..fb41182 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1022,6 +1022,10 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 			pblk->rwb.nr_entries);
>=20
> 	wake_up_process(pblk->writer_ts);
> +
> +	/* Check if we need to start GC */
> +	pblk_gc_should_kick(pblk);
> +
> 	return pblk;
>=20
> fail_stop_writer:
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--Apple-Mail=_CAA0D4EA-1437-4CCF-BEFE-77B2B4137429
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTaD0ACgkQYx8FO3WZ
GMpOQA//Sr57r9xbHuS0uMg33Wt4hJwBz/rb4wNOyPuuemoOeMZcqinWep0fVRNp
mkACu8xNBFnBHs/WDcYtLl1hc3BqfJRwKPhKv+/mkzg/2AiCnCe7DZmUr6AO+FUG
/SeDWkOde2gQJIwzGZW4nhbJNBRceW4uI6JTBxr95Nt5lvmnedtFAcK0qYSmaEUV
DU9tKaBG6t0Q+giIVjAcvAnSvMwyC0KwUKkuadcekAnXGTs9IMysBMHAcNsP0zKC
6fBkXijt6KaM0AoX8glWmZK/TrGE6yyQ3BgmTtxgkFeagax76IWiufmghG697fLK
wJ/NMWgKtdyf/KF+/lQHcclsrOrkvRFnatdWf0BuYR3AKawpQmgtlhny019CpHyc
jSGt5jmv/xvd9Nc2AqZZr7Q87WwASSbhlJ30omm+wmN8iSYpseSPMwa02LnXBu0m
QAkTLweUHCdeXXFFV28Era1OdA1fWw0XNkmuQUaCx8xiAV4Y5A8qWxfBpdaRPiav
74hKR+Jicr2BWJ7bJ1h27zCoIjMF+IHGgL8HAPlN1BN1MnJeNwV01SWWl85iSUj/
UF3pNc/HP0btZteZfWtteZJikGImlZzV2NwzMvEUcGqZljU+Psy2YzQPIEvWHumf
SzJHHATZpIm8jFrRnmcVzn9f0I9xKeEexJ0ewo2ywXdEUTtKZeU=
=d2zu
-----END PGP SIGNATURE-----

--Apple-Mail=_CAA0D4EA-1437-4CCF-BEFE-77B2B4137429--
