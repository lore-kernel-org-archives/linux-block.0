Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:48823 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdJBMo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 08:44:26 -0400
Received: by mail-wm0-f45.google.com with SMTP id i82so8173706wmd.3
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 05:44:26 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <13AC8182-29EB-4601-980E-FC8B59A83CFC@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C158CAAC-83EC-46A2-B02A-E3E3A647881E";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 6/6] lightnvm: pblk: fix releases of kmem cache in error
 path
Date: Mon, 2 Oct 2017 14:44:23 +0200
In-Reply-To: <20171001132633.GA5783@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20171001132633.GA5783@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_C158CAAC-83EC-46A2-B02A-E3E3A647881E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 1 Oct 2017, at 15.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
> 
> If pblk_core_init fails lets destroy all global caches.
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-init.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 519e5cf..9f39800 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -246,7 +246,7 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk->page_bio_pool = mempool_create_page_pool(nvm_max_phys_sects(dev),
> 									0);
> 	if (!pblk->page_bio_pool)
> -		return -ENOMEM;
> +		goto free_global_caches;
> 
> 	pblk->gen_ws_pool = mempool_create_slab_pool(PBLK_GEN_WS_POOL_SIZE,
> 							pblk_ws_cache);
> @@ -314,6 +314,12 @@ static int pblk_core_init(struct pblk *pblk)
> 	mempool_destroy(pblk->gen_ws_pool);
> free_page_bio_pool:
> 	mempool_destroy(pblk->page_bio_pool);
> +free_global_caches:
> +	kmem_cache_destroy(pblk_ws_cache);
> +	kmem_cache_destroy(pblk_rec_cache);
> +	kmem_cache_destroy(pblk_g_rq_cache);
> +	kmem_cache_destroy(pblk_e_rq_cache);
> +	kmem_cache_destroy(pblk_w_rq_cache);
> 	return -ENOMEM;
> }
> 
> --
> 2.7.4

Looks good. I'll refactor it on a single function so that we can reuse
it on tear down. It will also be simpler to add/remove caches in the
future.

Since it depends on the last patch, I'll wait until you reply to it
before making the changes.

Javier

--Apple-Mail=_C158CAAC-83EC-46A2-B02A-E3E3A647881E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSNKcACgkQYx8FO3WZ
GMplUQ//dUvtSpZ80+wk9nh+7VdQfy1LPDxG/d/1RoAW5ScFzOHdNCRTGgt24bGf
hfk5TKujKeQH3PvCFPRO9xsKGeprrw1BvWCfCKiCb/C3/ekIsOK+9zOyKWZ9V87e
h1AinaD5JvJd/PpkQAJv10H4uLXHg74XwA1URihTNWBkSxUwaDQK/x45+iuM1icC
4/grOmye0TxCjNRl24YDLNJdyVOy5SlLCfyxdrU6qn6QD4uiYoQe/RVnCCMFySOK
cAk1p+yMxD8z5cAG05pE2Ve5i+2SkhwNIw8kDmTj16rh5DoWtpbnYek4AAUTPpgq
E54PbdgQZvkhGQ9N+gftQJMHsaGATFDBfo/v6luANNxPgKnreXbaz8p4tjUybS+w
RLieahSXLjZiyn4Ps8aSTdXBnooFCdmmlRMuk9oxuupv0NiJr+AncIgDyQ16m03/
47zpxMedFLVOyi5wg/EGNNU5zZjkcMz3SBOn1Sjlbidz39zWxn5TVtdNPEaCiAMS
nzYkDJ/7Vb2kVJso4H+pf05xapnrAyM4sO0mO6HyPz6yJfRkE5ePaz9a5CSkMJoL
e2Ir+Yhs64et8RTPhGf57xh9lIvpY98qmCKWkasJvyl68laKk8mpNeESkA/crj8P
MKD3hv11OXMokSGmF+0bXPo37vq1hfB8ko8vgZjalZZPaWCaOm8=
=Frne
-----END PGP SIGNATURE-----

--Apple-Mail=_C158CAAC-83EC-46A2-B02A-E3E3A647881E--
