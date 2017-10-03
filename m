Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54419 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdJCKiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:38:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id i124so15868133wmf.3
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:38:45 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <09010E2F-1E25-47AC-AD4D-06644F0A750C@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C1A7EC3C-3D43-4959-99B6-4C65A3E59588";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 6/9] lightnvm: pblk: shut down gc gracefully during exit
Date: Tue, 3 Oct 2017 12:38:43 +0200
In-Reply-To: <1507025113-13351-7-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-7-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_C1A7EC3C-3D43-4959-99B6-4C65A3E59588
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Shut down the GC workqueues and tasks in the right order.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-gc.c | 20 ++++++++++++--------
> 1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 374089f..f343f90 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -422,10 +422,15 @@ void pblk_gc_kick(struct pblk *pblk)
> {
> 	struct pblk_gc *gc =3D &pblk->gc;
>=20
> -	wake_up_process(gc->gc_ts);
> 	pblk_gc_writer_kick(gc);
> 	pblk_gc_reader_kick(gc);
> -	mod_timer(&gc->gc_timer, jiffies + =
msecs_to_jiffies(GC_TIME_MSECS));
> +
> +	/* If we're shutting down GC, let's not start it up again */
> +	if (gc->gc_enabled) {
> +		wake_up_process(gc->gc_ts);
> +		mod_timer(&gc->gc_timer,
> +			  jiffies + msecs_to_jiffies(GC_TIME_MSECS));
> +	}
> }
>=20
> static void pblk_gc_timer(unsigned long data)
> @@ -625,9 +630,6 @@ void pblk_gc_exit(struct pblk *pblk)
> {
> 	struct pblk_gc *gc =3D &pblk->gc;
>=20
> -	flush_workqueue(gc->gc_reader_wq);
> -	flush_workqueue(gc->gc_line_reader_wq);
> -
> 	gc->gc_enabled =3D 0;
> 	del_timer_sync(&gc->gc_timer);
> 	pblk_gc_stop(pblk, 1);
> @@ -635,15 +637,17 @@ void pblk_gc_exit(struct pblk *pblk)
> 	if (gc->gc_ts)
> 		kthread_stop(gc->gc_ts);
>=20
> +	if (gc->gc_reader_ts)
> +		kthread_stop(gc->gc_reader_ts);
> +
> +	flush_workqueue(gc->gc_reader_wq);
> 	if (gc->gc_reader_wq)
> 		destroy_workqueue(gc->gc_reader_wq);
>=20
> +	flush_workqueue(gc->gc_line_reader_wq);
> 	if (gc->gc_line_reader_wq)
> 		destroy_workqueue(gc->gc_line_reader_wq);
>=20
> 	if (gc->gc_writer_ts)
> 		kthread_stop(gc->gc_writer_ts);
> -
> -	if (gc->gc_reader_ts)
> -		kthread_stop(gc->gc_reader_ts);
> }
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--Apple-Mail=_C1A7EC3C-3D43-4959-99B6-4C65A3E59588
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTaLMACgkQYx8FO3WZ
GMrNehAAsd8wFtI76RVxOHk5eG1nfqgd5ynynAE2zhQlA/Aa1WafPtzuX7CHLwCa
4jMD/PN8ZZlQVOtbJlQV3Xv8J8eK9/N+eEhykBnqnBC2BYRMDOQ7usfAtwxVAIgm
EWrUizpMu9uXvJ4bJB2r2YZaHTrXLU3r0sqkfBgugy6YbsJNB+S9QAo+fMAA74Gt
CeQxJaTkpjpfNAQ1dQGX/oFHbOjW6Z2SctJM33EyApEo7U0cLnWfJKG06VydW6Pg
JRxu8V7Iz5yjb16TofeBmVTsWpIV/T0VLAmgOLQX7YSWzo5/6sadBa/sNnJpyQQY
4kj18pf8d8SxqaO5tYSy56DJjcZP+2prcvy57qGFHAmR3zrjtPp8qdKXXESCba/j
fi83Okxg9LSxiZKEe3/+sTzCwhwJ7EiNh1VmJ7jPUlIAgSi4Edn9Wl11NojBRD5l
ZCjElIF2oLi/BiyFzZWhjGBq+xInOptQHyUBgneWrnflvO9h2hys+4XIVieTgR14
P+09pTYKnG9BV4MhiXEb+MSGfcmvutXku+hGvQEYwOp6Shu89cOqaRQwF4wPM+bl
nVW7ogWjb58s+/3JxiR8MaKPoeOxgMMeBDOKRafaDtVzMJAXyNApRmf7BalEh51l
FXOn3EWpfF3T1tJQCCdAXWhQcJmaI2GBIL5Kg+SMKgql7Nvf2jE=
=BdL1
-----END PGP SIGNATURE-----

--Apple-Mail=_C1A7EC3C-3D43-4959-99B6-4C65A3E59588--
