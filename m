Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB6C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ED620828
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="TLWMf6Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCRHqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:46:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39130 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRHqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 03:46:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so12612473edc.6
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=sZ/1Ywm17Ew8RVFZHN6oAT8kcA2malOzhiPJ057E0Uw=;
        b=TLWMf6Ewk3kIDgUs8JIisJk/9gDMxact1COGP0qzI2X+Qfos/TPtCropBeBatl7Y8t
         3vnvLI6wBWVL/0jQEayiClxFKfFGPBkZunGco0VSr1fNJ/MbvjVxoA7hyya6Jo6sJQ5K
         YtqrPOPQGcdnEbaS0Rzi+mbZc4Ntcu+8pO+HKAbTZaHPNc64CpGMdKoefynFtzhMNEw/
         0D7KJVerfZwCTb4SZJ+CaakaEOqJqA1mNPxJp3n1uIVbV22JwkT0tryZFdytAzxCGwNq
         KRWi6AonKX5DMNogOGCYIqTHSTZUxugBIxBFDCMbWwpHTJKiJ2uR9VCVIC+t72EtW7sN
         j9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=sZ/1Ywm17Ew8RVFZHN6oAT8kcA2malOzhiPJ057E0Uw=;
        b=SRrOfsaj1ihbZIICEvQqsbvPWqDqngvq4sGj1G/xKm4y/SXbBNGUbLLKkSEcg2IlW/
         HW5md+yJeOtDyg8jgDWatS+guMxMI/q/iuoNbc+MVXMbdvD07scatraQe+3h20juXfOc
         XoxI+9iR8K3GfWAF9rQEs4ryUjfdl8/o/8RMa6MCEwqotXWTJFCc+36wi0gHen40sk8z
         ymfErc1VTnTjiIVIp+RVQnFgPJCnoPTb7a/gvYUKoJshYl+WCZu8i06YQIo6Hc3Now2S
         lUApjWhrsuihuhyruP7Crp/fcEjfGuLmGw9Wa1z9aRMKMhPxu1Ch357t96M4CzOfHaBz
         h1cw==
X-Gm-Message-State: APjAAAUKpi63CHrEjFG5cCxeehFik018WGAvA9XfDoCT9QQjth46aPEE
        9JyJmPFEOYbvI9uSPCFpwRgo9w==
X-Google-Smtp-Source: APXvYqxtuyzjcOh2Ez7+Rgwm5OrJvqGP5o7pbZ5YDFp1bKFZ/r5qdt08/9yiDzXs0VN8SEqYEJUXaA==
X-Received: by 2002:a17:906:5e0d:: with SMTP id n13mr5431799eju.37.1552895194248;
        Mon, 18 Mar 2019 00:46:34 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id y21sm3188655edb.54.2019.03.18.00.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 00:46:33 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <9BC9EF01-A5E3-4B30-B437-54E6A22E477C@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A565B89C-8E50-48AE-9620-4E4736095843";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 10/18] lightnvm: pblk: ensure that emeta is written
Date:   Mon, 18 Mar 2019 08:46:32 +0100
In-Reply-To: <20190314160428.3559-11-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-11-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_A565B89C-8E50-48AE-9620-4E4736095843
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> When we are trying to switch to the new line, we need to ensure that
> emeta for n-2 line is already written. In other case we can end with
> deadlock scenario, when the writer has no more requests to write and
> thus there is no way to trigger emeta writes from writer thread. This
> is a corner case scenario which occurs in a case of multiple writes
> error and thus kind of early line close due to lack of line space.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c  |  2 ++
> drivers/lightnvm/pblk-write.c | 24 ++++++++++++++++++++++++
> drivers/lightnvm/pblk.h       |  1 +
> 3 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 38e26fe..a683d1f 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1001,6 +1001,7 @@ static void pblk_line_setup_metadata(struct =
pblk_line *line,
> 				     struct pblk_line_mgmt *l_mg,
> 				     struct pblk_line_meta *lm)
> {
> +	struct pblk *pblk =3D container_of(l_mg, struct pblk, l_mg);
> 	int meta_line;
>=20
> 	lockdep_assert_held(&l_mg->free_lock);
> @@ -1009,6 +1010,7 @@ static void pblk_line_setup_metadata(struct =
pblk_line *line,
> 	meta_line =3D find_first_zero_bit(&l_mg->meta_bitmap, =
PBLK_DATA_LINES);
> 	if (meta_line =3D=3D PBLK_DATA_LINES) {
> 		spin_unlock(&l_mg->free_lock);
> +		pblk_write_emeta_force(pblk);
> 		io_schedule();
> 		spin_lock(&l_mg->free_lock);
> 		goto retry_meta;
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 4e63f9b..4fbb9b2 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -505,6 +505,30 @@ static struct pblk_line =
*pblk_should_submit_meta_io(struct pblk *pblk,
> 	return meta_line;
> }
>=20
> +void pblk_write_emeta_force(struct pblk *pblk)
> +{
> +	struct pblk_line_meta *lm =3D &pblk->lm;
> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +	struct pblk_line *meta_line;
> +
> +	while (true) {
> +		spin_lock(&l_mg->close_lock);
> +		if (list_empty(&l_mg->emeta_list)) {
> +			spin_unlock(&l_mg->close_lock);
> +			break;
> +		}
> +		meta_line =3D list_first_entry(&l_mg->emeta_list,
> +						struct pblk_line, list);
> +		if (meta_line->emeta->mem >=3D lm->emeta_len[0]) {
> +			spin_unlock(&l_mg->close_lock);
> +			io_schedule();
> +			continue;
> +		}
> +		spin_unlock(&l_mg->close_lock);
> +		pblk_submit_meta_io(pblk, meta_line);
> +	}
> +}
> +
> static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
> {
> 	struct ppa_addr erase_ppa;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 0a85990..a42bbfb 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -877,6 +877,7 @@ int pblk_write_ts(void *data);
> void pblk_write_timer_fn(struct timer_list *t);
> void pblk_write_should_kick(struct pblk *pblk);
> void pblk_write_kick(struct pblk *pblk);
> +void pblk_write_emeta_force(struct pblk *pblk);
>=20
> /*
>  * pblk read path
> --
> 2.9.5

This should not be possible. In pblk_map_page_data() we wait to close
emeta for the previous line before starting to write to the new line
(look at pblk_line_close_meta(). Note that we schedule emeta writes for
the previous line as we write the current line, so this function is only
called in extreme cases. Otherwise, this would show jittering.

Do you have a different case in mind?


--Apple-Mail=_A565B89C-8E50-48AE-9620-4E4736095843
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyPTNgACgkQPEYBfS0l
eOBeGhAAgteUoJ0XldWm6grImMlXO9wfAgMNSwwFKpUBmOlM1t9GDBrhzJERVguu
TWTy0lnJaOinwJE5W0xSuDMB4AA0QklcSf+e5BFiOegGTpwy2GIM5VijQbGbgFSt
aNWpdUmy79DqlRaaqLOZ1QBH34UEjqRz6oYi32bz9nmd2sY1en88cDZfpNcVcF5c
kpM9kAwdGh9SLCIHOR95OOVKYMZP5/hxEETNxfxc45Vl/oP5xI7ljd7jtp3bajbe
gGhOzp2DEiqgTMOI4qIbiEOOyWVupiNjVZSvmrdN2NkFVBhxTZ/JByWlzyA8TvS4
hd+54pLf/H8d33js2svP0Lu0xG2kNQgClwfDBwTinb89HwFzcAm8lx/DVmTBXih9
01VGM5YkuV+u89LkijhSYaGTocbUySiDI/LvSTFj6ZRvmwK/fDwkC/AtWL4IBZnJ
Hshcx7Fr6KQhjrVikyQq3PvMjic35m+QeReIQnOQVUb2UUtyh+sVnyVZuPl6sgjj
lOgHlwnYHsrjki0qMhBUUxhfPK+t8zg3aK/FqaOa2+wcGtMNxR2GMyWHDzECYP+K
3fw8SxarAO2lXpk20tH+p5d/H32Qdswh7TCoF9+ShFmxFRmjXnoYGSFG63JEv5mM
iMZnwVuE/ivhkJjsEb0e7H7Rf6BifCAOF9EHHJIkzYBYjs6wwUY=
=WOol
-----END PGP SIGNATURE-----

--Apple-Mail=_A565B89C-8E50-48AE-9620-4E4736095843--
