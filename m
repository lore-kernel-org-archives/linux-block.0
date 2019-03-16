Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD19C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EB1218AC
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="MuroqcYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCPWnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:43:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41942 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfCPWnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 18:43:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so8717789pfn.8
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1UqmBPWVA88fAil27WpbjMFMfs0PZrbZcAP+uSQAa0E=;
        b=MuroqcYS/zA4lgzXdxlmJZI188fuuYHmcQR81YHb017kWZfAEKRhhEo+fonwqUZ5vp
         hpxg97fvQE/TGaKva0biJNWQonfm91PhKknUKAb8jAqYBU3HxiR/0qiK63ChsZOIwZak
         aQhBgoYLOZ1cEdi5oX+66iUGylSbfXSrOQ9T8dK7/mbSbbPRiBj/n8RyMtAaa1B1y+11
         yP8ji3NqpCV3WkH0Vcsuu+kpbwk2+9oK/kWTxG4LhabdqDp/Pu0p8E3ew88/dhbBJTHW
         7EgHuZ+f/HvONtf4b4gAXnicX1i/gJPFgUtoWWFLUcb9EuAdpmhdpZhtXfJmQDKptVS8
         Oq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1UqmBPWVA88fAil27WpbjMFMfs0PZrbZcAP+uSQAa0E=;
        b=r6R+NFyOq3NOKFxqs8Xq/fbxAUebU33vEjmiCpck5HaaKio2wRgBdYMUyG6fYmb1H9
         LmJRu/cYMZ848N9BhfntkqpoSH+NJovsqVedUtdFOXGDSvSHNH+HPEIByObJAka7tM87
         v7fn9jllK0BG2fzbARltQy9wdNSX3pqRlQVU2CbXmy8Vs6K5OVmt1EPHwQFZwj3szH8b
         nBxU5mPPzP8Ro6qmtWqvC4pVV76wDqXObZE2KDnpSTNn++lTeYCxDl+nCNxB8/BjGEzE
         ECynZvMDDDn2L1Bz6WnKdbQM2nNxAyJEn5ja5FfsNqdEqoBy14el6f4ifYGqX2SXj2sR
         k/ig==
X-Gm-Message-State: APjAAAV+3GxynV3uxsQh9f3Z/wGZeqB9BrH3nIJ6axHf1uf/Lc10FYRQ
        C8vpmecNaVpw6bJsx0PTLh8JTA==
X-Google-Smtp-Source: APXvYqwKOe5W1JBAaCQh+wTxZyOBdDhoPkeNwno3l038w6fjdppD7JVIbI6NBTfoCkO0yieusID+iQ==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr12037855pln.74.1552776194679;
        Sat, 16 Mar 2019 15:43:14 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id h184sm11411501pfc.78.2019.03.16.15.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:43:13 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <F7A12A66-ADBD-4B24-9FD0-B02031E2FACB@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6B21195B-A921-4344-990A-289A56373BDB";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 04/18] lightnvm: pblk: OOB recovery for closed chunks fix
Date:   Sat, 16 Mar 2019 15:43:12 -0700
In-Reply-To: <20190314160428.3559-5-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-5-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_6B21195B-A921-4344-990A-289A56373BDB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In case of OOB recovery, when some of the chunks are in closed state,
> we are calculating number of written sectors in line incorrectly,
> because we are always counting chunk WP, which for closed chunks
> does not longer reflects written sectors in particular chunks. This
> patch for such a chunks takes clba field instead.
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

Mmmm. The change is correct, but can you develop on why the WP does not
reflect the written sectors in a closed chunk? As I understand it, the
WP reflects the last written sector; if it happens to be WP =3D=3D clba, =
then
the chunk state machine transitions to closed, but the WP remains
untouched. It is only when we reset the chunk that the WP comes back to
0. Am I missing something?


--Apple-Mail=_6B21195B-A921-4344-990A-289A56373BDB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNfAAACgkQPEYBfS0l
eODqNQ//cKH7+q35YunzvAo3TfB+cW8sznlXMKGgax2SymdzwX78uLuZn5vIslqK
K3xQYp5iNHneaDK+OPbH/MCs3hVzwTZqVc8Q0nCTbrSR2nnKHL+A/j4lVnXI12Wh
/XW9jhuDxOHXPWzkoNg4u4plBFyUk/KjkxgdQsG/6+MRMdiCqWLv2IN3skicnKkM
R2G9wyhfMruqxf9efQXJR4P8CTk97bt9JT8tBGN3gBwhNSezGlfV+DPvCEV7gDjr
MRPksEy9LaDvQ0ZoYpggc5TC5SorzBhVj4f//NeBml/MhJSSxMvyfP9VnI/O+/tI
Svapz9qT3MfRJqf9cSZHcEFEtZFNt0FKM13nx9K1TKMf01CMg8YZ4emYDniJlP+s
CpvtX25gQLlvYkGe0yh5p7RwRZKwxvBXGsxG0gPXnQKxy9+70yXDWBjPdNzm1cXr
JlDj7B+QB/J/I5HrrvpXnJYV7KKdhSLv0+hOnpIsMDjJJs8YGnSqiB7ulMd48ZBY
NcpwTqrsjeWETtKkmReqwO1L+BJW6WI0ATOJEAgRd1Dh7O5HEYBR4UGVzszohL/V
xafg/w++owEh7YctfUlAXPQ6uXQQxqyLcAUp2aLJufPU1VvBuJnVtUZOLMLokwKb
/xGCoedzkdaPLnSCWiLYO/ogV/XsoJfdi39u5JQp63D1O9zDJRA=
=Ibto
-----END PGP SIGNATURE-----

--Apple-Mail=_6B21195B-A921-4344-990A-289A56373BDB--
