Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55572C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F82186A
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="d461wXv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfCPXqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 19:46:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34846 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCPXqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 19:46:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id j5so8799963pfa.2
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=R/9tVsj+/zBIaMt9CujtlQHgRBCqoLbyWaxS3h+PSkQ=;
        b=d461wXv82A9hib0LgGT7fFkzTL1GCaHvCXUiXdg+j0hzS3yOtb2MaUzlCGuNo8WpqO
         1BdvDyq5bafXRa8ftJraqePBUBsKn4v1iydz7XcjKVsIeA1pmm4e1+RnjWT4qYb/d5Pb
         5Ud++Y51v1ykNN2gcOvgTvtB/QnoCTT+bnkyB1BJZeBF4Wbc+K93+y+naseDs+Dm5X5O
         eKo4f9n9Ub9fk4wXj6rkB0R6NC64obPRypSGYOj7/n5gm+JBB2a1el3NYavL2jqhDpEL
         SnOwtU7PjzJBdK4deby2sl43ygmkxTq9Q4sn29NeBOZVO4a64z4OPSC8q8X9cKhBL7lR
         cIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=R/9tVsj+/zBIaMt9CujtlQHgRBCqoLbyWaxS3h+PSkQ=;
        b=DeWe2J0RGepCBeMgQESuVtD7P8+akrEXfDB0zCpp4pyP/FGwakt9hjK+bDypo4JzEw
         cmpqk2sTaHRk7MHjvJ7LjwJZJponTrqZUAp/XaS7kirhcBU/C8TaIZ6pm+RiABlRjyGr
         vM3BljshoAsRiZHxXdWF++kEZ2sz+bZaFCKNY+CV9/QH8k1sWXxIasakcugM4Co5+Q5Q
         I50vZ4vDSFWB+S1acTOAF5ombKFAcLlmcJVT0mpua+xPr8fwGoPFzDIAjFXp+uY99yv0
         m3JXInPrijpsxODRKduwUaFOiDoaXmMn7QLSHJvLmFaOVV1C+h/oPfqOH1raz1dnCvBo
         jQPw==
X-Gm-Message-State: APjAAAX3t3rpaomSPkfwv9Yq7bwV7837oehKF8BK7jDamS9hkVQLYEz6
        px/2/Khpe9YbNANf7BJlCcCxlg==
X-Google-Smtp-Source: APXvYqx4GWL8c97QKB5BomL1AfCoWSzpUoRV4ibRDA7sIbkyUFI99aMbuDMVQsaNq5MIwSZhYA7Phw==
X-Received: by 2002:a62:b608:: with SMTP id j8mr11907444pff.183.1552779994859;
        Sat, 16 Mar 2019 16:46:34 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id h23sm7742760pfn.68.2019.03.16.16.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 16:46:34 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <4017AC03-A854-4158-ADC9-E1BBAE65003D@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4F77CA3A-4148-40E8-8CA3-763A6F2EACEE";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 06/18] lightnvm: pblk: recover only written metadata
Date:   Sat, 16 Mar 2019 16:46:32 -0700
In-Reply-To: <20190314160428.3559-7-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-7-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_4F77CA3A-4148-40E8-8CA3-763A6F2EACEE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch ensures that smeta/emeta was written properly before even
> trying to read it based on chunk table state and write pointer.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 43 =
++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 688fdeb..ba1691d 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -653,8 +653,42 @@ static int pblk_line_was_written(struct pblk_line =
*line,
> 	bppa =3D pblk->luns[smeta_blk].bppa;
> 	chunk =3D &line->chks[pblk_ppa_to_pos(geo, bppa)];
>=20
> -	if (chunk->state & NVM_CHK_ST_FREE)
> -		return 0;
> +	if (chunk->state & NVM_CHK_ST_CLOSED ||
> +	    (chunk->state & NVM_CHK_ST_OPEN
> +	     && chunk->wp >=3D lm->smeta_sec))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int pblk_line_was_emeta_written(struct pblk_line *line,
> +				       struct pblk *pblk)
> +{
> +
> +	struct pblk_line_meta *lm =3D &pblk->lm;
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +	struct nvm_chk_meta *chunk;
> +	struct ppa_addr ppa;
> +	int i, pos;
> +	int min =3D pblk->min_write_pgs;
> +	u64 paddr =3D line->emeta_ssec;
> +
> +	for (i =3D 0; i < lm->emeta_sec[0]; i++, paddr++) {
> +		ppa =3D addr_to_gen_ppa(pblk, paddr, line->id);
> +		pos =3D pblk_ppa_to_pos(geo, ppa);
> +		while (test_bit(pos, line->blk_bitmap)) {
> +			paddr +=3D min;
> +			ppa =3D addr_to_gen_ppa(pblk, paddr, line->id);
> +			pos =3D pblk_ppa_to_pos(geo, ppa);
> +		}
> +		chunk =3D &line->chks[pos];
> +
> +		if (!(chunk->state & NVM_CHK_ST_CLOSED ||
> +		    (chunk->state & NVM_CHK_ST_OPEN
> +		     && chunk->wp > ppa.m.sec)))
> +			return 0;
> +	}
>=20
> 	return 1;
> }
> @@ -788,6 +822,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 			goto next;
> 		}
>=20
> +		if (!pblk_line_was_emeta_written(line, pblk)) {
> +			pblk_recov_l2p_from_oob(pblk, line);
> +			goto next;
> +		}
> +
> 		if (pblk_line_emeta_read(pblk, line, line->emeta->buf)) =
{
> 			pblk_recov_l2p_from_oob(pblk, line);
> 			goto next;
> --
> 2.9.5

 I would like to avoid iterating on all chunks again an again to check
 for different things at boot time. What do you think having this as
 something like PBLK_LINESTATE_OPEN_INVALID or
 PBLK_LINESTATE_OPEN_NONRECOV, which you populate when collecting the
 chunk information? Then this becomes a simple check as opposed to the
 extra chunk iteration?

On the check itself: Is this done for completeness or have you hit a
case that is not covered by the smeta/emeta CRC protection?



--Apple-Mail=_4F77CA3A-4148-40E8-8CA3-763A6F2EACEE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNitgACgkQPEYBfS0l
eOBc1g/+Jz5JE3TctNEJk/VQQ55xFMn93GpsI33UEnzVK4m4NIcs6hnnxijGEHvF
qHW6QU6/ccBdNwQFghTl6aeAoaTcVfpp/R8Dv5AkhHfztr4yI2xxbMup1AQ9+6H0
zfujLjFCHlO/T29il6TDH5hapCPMJg3xiNgsj/wd7/mNVaTgSOzhSP2Oj7bYxTDm
DP8K56bWYJvzH/xVbA/GI18ieTCAViYQNS90OlU/rLv4A5YsAvYgCZHS9HYLUzRz
pXzTIa4SxEmGo1ss2ZrqHvieq8LtBaMiKVT+5legm4w7J0f6be0Fm0qqKBfRPKbA
cWiLbY9pzBT4ThQXUCk1DzdIeEb7MYgqL+9Prm+xWNiLbfEk7KIVlsx0Bz3Ab0vH
aSN5LjuP2Zv1qyA0QekaJV0FzFyUQAxzNgSRbcU4NjbrlqGYk7JZzrYTEjWyLsQ6
3T0M6353hXqEnzp+8uGRvw82wkqJFdxhY7iWIahH6hBDuZ7+KKzVHApqUeAzDy53
8Kd9I4ZSeb9QyN4lUHknzMW27t6NlHCnbIBJhJUwTD9HBiyfxjevZzBcZNogDWdh
lY2KcqEiG7v+rhGbzsH8jHpx01cu1tMkIlW0Ncj+144IquybXOn930Kkgq1sJQdj
zR0o6tRxXS7kU81HB47DH5aIVagXh4dYB+PbNymJcASvK3i8xIM=
=Q0gf
-----END PGP SIGNATURE-----

--Apple-Mail=_4F77CA3A-4148-40E8-8CA3-763A6F2EACEE--
