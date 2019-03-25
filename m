Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB6BC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5D32087E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="GBwSY3Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfCYGCS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:02:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34648 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbfCYGCS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 02:02:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so3760974eds.1
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2019 23:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=E1lyr5CXTIG+jq8Ouwdce60Eeznfpr/w/V/CNo3Inog=;
        b=GBwSY3JpidEH9/T1qbruZe2dHYhIGIpsMlhtlcQVunq3BqH5Vj8WYLtJzwVLd7NDRt
         MQ/KEUeL9mp+j4zkeNAx7xL4R0xX0ZuShcwkcV+UXDBB8oTfbIREMm06BV36PeQAwmkU
         IxXtngSeZGFlHkMZHtyK3f/oFUEeAXl/XUKkUlpkSASlM3FVygdVNOGmF5ILnG573dOx
         AFywVXJydytVg84RkcOchA0F+CB7I3k0HPaKuZaLZ9qwaGDaDDLYsirox2auQV41d72E
         bH58a+LpI07aBk9kHxOFSnrTYzZ1hailcdPnGNPgLy7+JmDOCjwH0LOWSnm9N1wJCiLK
         kQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=E1lyr5CXTIG+jq8Ouwdce60Eeznfpr/w/V/CNo3Inog=;
        b=HynlzTq9I4Z1IJsw3v+/grNza9vrtw/7EqD66xUlOQcCtiwiQsAn6mmAkPMqH4wa4N
         LLFe0sSF3zthp+N6WelO9IVRcojSzmA9L0mJbgjSIzVt+rW+1sxDR70BVQ6QIBXRI9cb
         NCoeX1RG//awDo+GTGlUpFwo4fJGtr1rRDNmSzAxwa/9ZgqsbldBchzFm56o3YwCpMo4
         tEFMKoXCdombhswtyOWEAhqZ0zWpyab8YqaB6OW7wHlRIibGtQzbzH4f4q6IVnXClE9h
         ltPLPmgpsd+2ZKxxIwHiTGNBDVaS9YaUkG67lhcBTzh1FWQIyDoa4j56mvJb7aITzllF
         oYGQ==
X-Gm-Message-State: APjAAAW8M2vXqiORdIzs4oLP44KiFt7rfwSB44NQ9+7yPHS+Ey2zFCP7
        sTUXCaoPOgDjcFzKJ5iZNKIdbQ==
X-Google-Smtp-Source: APXvYqy6H0wN4d1Kl/JX/AP5xvKsDCj9fK9KjmVeSPgZw0zuOKC20sE1IPvQCUqIhtgQvLOfW/S4uA==
X-Received: by 2002:a50:b3cd:: with SMTP id t13mr14990681edd.150.1553493736645;
        Sun, 24 Mar 2019 23:02:16 -0700 (PDT)
Received: from [172.30.99.70] ([37.120.153.227])
        by smtp.gmail.com with ESMTPSA id w6sm3236329eja.50.2019.03.24.23.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:02:15 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <652D902B-21C8-4599-8298-F73E0620CC95@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_DA2510D8-52E8-467C-89DF-99F7AE4DBE3D";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 04/16] lightnvm: pblk: OOB recovery for closed chunks
 fix
Date:   Mon, 25 Mar 2019 14:02:12 +0800
In-Reply-To: <20190322144843.9602-5-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-5-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_DA2510D8-52E8-467C-89DF-99F7AE4DBE3D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In case of OOB recovery, when some of the chunks are in closed state,
> we are calculating number of written sectors in line incorrectly,
> because we are always counting chunk WP, which for closed chunks
> does not longer reflects written sectors in particular chunk. Based on
> OCSSD 2.0 spec WP for closed chunks is equal to SLBA + NLB and here we
> need only NLB (clba in code) value for calculation. This patch for =
such
> a chunks takes clba field instead.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 83b467b..bcd3633 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -101,6 +101,8 @@ static void pblk_update_line_wp(struct pblk *pblk, =
struct pblk_line *line,
>=20
> static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line =
*line)
> {
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	int nr_bb =3D bitmap_weight(line->blk_bitmap, lm->blk_per_line);
> 	u64 written_secs =3D 0;
> @@ -113,7 +115,11 @@ static u64 pblk_sec_in_open_line(struct pblk =
*pblk, struct pblk_line *line)
> 		if (chunk->state & NVM_CHK_ST_OFFLINE)
> 			continue;
>=20
> -		written_secs +=3D chunk->wp;
> +		if (chunk->state & NVM_CHK_ST_OPEN)
> +			written_secs +=3D chunk->wp;
> +		else if (chunk->state & NVM_CHK_ST_CLOSED)
> +			written_secs +=3D geo->clba;
> +
> 		valid_chunks++;
> 	}
>=20
> --
> 2.9.5

Didn=E2=80=99t we agree that the patch was not needed?



--Apple-Mail=_DA2510D8-52E8-467C-89DF-99F7AE4DBE3D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyYbuQACgkQPEYBfS0l
eOCnOw//dIYj1IVg0tGcpD0/rCjMc5Y0Uwum5un9MO2Y/cvwzJ49UeLO32GNJZh3
8VoErSh4vOQAd+Ju2F5Pp+neqDOOZQdES52Zcpr8TBBo/kBMMuVEi2ntVr9Q7lHS
6Y6vHv5GXQx5b3o4erFA9mJlX/NVzvYRag6zV4Qw8kgrIa8vEhP86/05YTTaVvp6
sEIlGfz3ypogu3ey13KJlnORwtyX8VNHF87NJLmyVN/3X9jSy8ryMmHyD8J0+mMW
sINRwvqWEgO65mSt7gSA3kRkMUv5dVQ+74pdbMhm1k+pY7wjRSkNNGSa2ymLxZbf
Ja6vYuJjSJFJ+VWg9a9U54kWcGv9Nu0uZX+l9EgnFYVNvHOIbrHeARWRTgjiPUsq
DrZvtYfz/x4+BOqTrRZ1mfEtLMCR996+5sx4mDw0ujTfcNP2ddgJcwDQ2CDWPsYv
jnmcaJrTgB/OlvZO6E0Y4uMFX0xYTKWF4vF2BUjFVqPI4/EZ3pav+5UXDPDE/0Cu
/ehTqYPIDXxHMpxITOucqo1qJxeHmkidK+bkJ5Rzb7CnW1Lcg35zg86C2MriFZwK
t0DewM7WrlIVTeZ2hp1rXZVbLhrpJBvf4NRcgTFJgHoN1KNyuUFDJ7/Qav8NRG07
Fp9dK0YE7gBRYDgXPJmr3ZI2Mr64gCE7V5Z1vAY/uGnThaImQaI=
=JdxL
-----END PGP SIGNATURE-----

--Apple-Mail=_DA2510D8-52E8-467C-89DF-99F7AE4DBE3D--
