Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C2C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1C20856
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="c1OOQT2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfA2SkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:40:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40784 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfA2Sjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 13:39:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so16825088edr.7
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DKW/3CbGHJHdF8JF06o0YFmJlgNJt2C6YGs5YYxFuqk=;
        b=c1OOQT2sRsfAmBePmoHD3unbGA9C7dsFVbNqS9H45P7z5+czIKBvZfVG1HXOFmbjTN
         SdAelDD7a249vk5aGwgaVP41hHaVizvN/YyiWbdCpArqnvBGschEtolpo0BpnjXHEaLO
         vm8bl/SVNyVeLXvAtZ7Gkx9W+zePTKn5Wf3CPrpZdAfSuMtQYTqIjDJHcCbswjDumY83
         4t7zEWBJyBtMpSY/aULwnddSCPdd37E0ZSN9Su+Lc2eNEhtwLEgTeVh8f75ku8e4LyPD
         LD8m65nJNZu9BI6o7NeTZ98K9crKgsC4VC8cUgt7fO7W+3G4zAdrStXdcALIvPKORp/a
         JCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DKW/3CbGHJHdF8JF06o0YFmJlgNJt2C6YGs5YYxFuqk=;
        b=oAqUTxjmtP7Y70yUmXfSLh94YrJlY9QXmpGkkUo7y3QIELQU7yM/pAa5HfJwJAxofS
         w5By2hY3YQ2/k3konh8MNqoap7S0WcXiRcp7n4MCZkjNj3ygYyH0TDbgHrSv/SrDOMI7
         h+sJTx+C3i4nnFDIx/qps7s/wayjDgQhSGZOLWa5ZGvsp5WmMT3Dh88JiYT3o2osrIiY
         xvF+fETcotFZo5lvjYwmiyXO59cWlD7dFZISA20nLWkjUnLv1tcLH4davPZ2O1BVIalY
         E2SFYog5MlXqxH6vDLCywOu0hk//6SzhAM+wTpDp20q5un+N7o+jhJkRVIEkk+LG+Gwl
         XVWg==
X-Gm-Message-State: AJcUukc5iBrjMgOYZi76wmm5Oe9R4YHxseHZS1SHQEOpnq6sSCHRZbaW
        /7Bz8P6lTzFc80fDUqu87wSFuA==
X-Google-Smtp-Source: ALg8bN7drDDMYNiftECOf5dox+TWzwhOZVn0aTWm7vOitZfRUamTwb2RTjT777hHUHLVGYNiew18Qg==
X-Received: by 2002:a17:906:364f:: with SMTP id r15mr8364824ejb.70.1548787186170;
        Tue, 29 Jan 2019 10:39:46 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id m13sm14618335edd.2.2019.01.29.10.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:39:45 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <9F9F7209-749A-468A-988E-B5E899788D5E@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A95A566B-0D61-4AC4-96E0-5D0C6169119D";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: fix race condition on GC
Date:   Tue, 29 Jan 2019 19:39:44 +0100
In-Reply-To: <CAJbgVnU8G+brMW1anV1u79autsVzigwAoaaQKfZi_dizUFLfdw@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Heiner Litz <hlitz@ucsc.edu>
References: <20190127065421.10662-1-hlitz@ucsc.edu>
 <9E81CD34-5291-40B8-93EE-00BABAC7C0DC@javigon.com>
 <CAJbgVnU8G+brMW1anV1u79autsVzigwAoaaQKfZi_dizUFLfdw@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_A95A566B-0D61-4AC4-96E0-5D0C6169119D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Jan 2019, at 17.36, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> Javier,
>=20
> On Tue, Jan 29, 2019 at 12:13 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
> > On 27 Jan 2019, at 07.54, Heiner Litz <hlitz@ucsc.edu> wrote:
> >
> > This patch fixes a race condition where a write is mapped to the =
last
> > sectors of a line. The write is synced to the device but the L2P is =
not
> > updated yet. When the line is garbage collected before the L2P =
update is
> > performed, the sectors are ignored by the GC logic and the line is =
freed
> > before all sectors are moved. When the L2P is finally updated, it =
contains
> > a mapping to a freed line, subsequent reads of the corresponding =
LBAs fail.
>=20
> Hi Heiner,
>=20
> This has been an interesting issue to debug - good catch!
>=20
> Felt more like a marathon than a catch ;)

Hehehe, I know. It is a good maraton then :)

>=20
>=20
> >
> > Note that looking up the L2P and checking the ppa in the write =
buffer needs
> > to be performed atomically, hence the refactor of =
pblk_lookup_l2p_rand.
> >
> > Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> > ---
> > drivers/lightnvm/pblk-read.c | 27 +++++++++++++++++++++++++--
> > 1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> > index 3789185144da..7c556b2218e4 100644
> > --- a/drivers/lightnvm/pblk-read.c
> > +++ b/drivers/lightnvm/pblk-read.c
> > @@ -529,13 +529,35 @@ static int read_ppalist_rq_gc(struct pblk =
*pblk, struct nvm_rq *rqd,
> >       int valid_secs =3D 0;
> >       int i;
> >
> > -     pblk_lookup_l2p_rand(pblk, ppa_list_l2p, lba_list, nr_secs);
> > -
> > +     spin_lock(&pblk->trans_lock);
> >       for (i =3D 0; i < nr_secs; i++) {
> >               if (lba_list[i] =3D=3D ADDR_EMPTY)
> >                       continue;
> >
> > +             ppa_list_l2p[i] =3D pblk_trans_map_get(pblk, =
lba_list[i]);
> >               ppa_gc =3D addr_to_gen_ppa(pblk, paddr_list_gc[i], =
line->id);
> > +
> > +             /* Obtain ppa from cache if the sector has been synced =
to the
> > +                device but the L2P has not been updated yet */
> > +             if(pblk_addr_in_cache(ppa_list_l2p[i])) {
> > +                     struct pblk_rb *rb =3D &pblk->rwb;
> > +                     struct pblk_rb_entry *entry;
> > +                     struct pblk_w_ctx *w_ctx;
> > +                     u64 pos =3D =
pblk_addr_to_cacheline(ppa_list_l2p[i]);
> > +
> > +#ifdef CONFIG_NVM_PBLK_DEBUG
> > +                     /* Ensure that the access will not cause an =
overflow */
> > +                     BUG_ON(pos >=3D rb->nr_entries);
> > +#endif
> > +
> > +                     entry =3D &rb->entries[pos];
> > +                     w_ctx =3D &entry->w_ctx;
> > +                     if (pblk_ppa_comp(w_ctx->ppa, ppa_gc)) {
> > +                             rqd->ppa_list[valid_secs++] =3D =
ppa_gc;
> > +                             continue;
> > +                     }
> > +             }
> > +
> >               if (!pblk_ppa_comp(ppa_list_l2p[i], ppa_gc)) {
> >                       paddr_list_gc[i] =3D lba_list[i] =3D =
ADDR_EMPTY;
> >                       continue;
> > @@ -543,6 +565,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, =
struct nvm_rq *rqd,
> >
> >               rqd->ppa_list[valid_secs++] =3D ppa_list_l2p[i];
> >       }
> > +     spin_unlock(&pblk->trans_lock);
> >
> > #ifdef CONFIG_NVM_PBLK_DEBUG
> >       atomic_long_add(valid_secs, &pblk->inflight_reads);
> > --
> > 2.17.1
>=20
>=20
> Here is a suggestion: Why not add an atomic counter to the
> line stating the sectors that are synced in the L2P table and then
> loosely wait (i.e., check and sleep / schedule) until the counter
> reaches 0 on pblk_line_close_ws()? This way you guarantee that the =
line
> does not close - and therefore never reaches the GC lists - before all
> the L2P entries for that line point to the media. Any other form of
> synchronization that puts the burden at pblk_line_close_ws() would =
also
> work for me.
>=20
> In essence, I would rather pay the price on a per-line basis than
> blocking the trans_lock longer for each I/O.
>=20
> The patch only adds 2 well predictable branches to the loop so I think =
the
> impact would be minimal, but I still think your approach is cleaner.
> I suggest checking the proposed sync counter whenever selecting a GC
> candidate. I'll send out a V2
>=20

Sounds good! Thanks!

Javier

--Apple-Mail=_A95A566B-0D61-4AC4-96E0-5D0C6169119D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxQnfAACgkQPEYBfS0l
eOCxpBAAv300ZbaZz1jVYQCYasbNU+xmJ3CXl61gN/3Z/d4TtuAxYJErnWWdbkfo
a3x16qOEy3NFvpb/DNr+XOtrtuLtu+GJ9s9Csvly89OotBOanPjpF1TuNRU/9TZp
4/5mABPUx5wE8m12G0RJJmqlHUhAps+JqC3035m5ucerh7N+/LUcJzRfyW1RAEk2
SDUARt8QsecaKN5ICWRA2y05nvpneVQx0XkeTX8DQ5efkhiiVbJDkICVFNspQKKV
4Jr1sPhjqI/7LbchrAYyCajUZyHavheQ1AyR4oOfCYlFJA9wfZ3M2BDJcckwHJDO
RgFLvAMSCNwEbPcf18yxf2QhB41CPQCEvT6VjzLskpJyXtI1mAyTEIC3LxOxpKj9
yWLvdurWyzEXGGsI8Q/QaRS5gxsaJ4S01jGAfqBu2Joq22oXEyE/L/TfIBN/pbJT
ofzoBrdS0H2biB60tVcJiEO7oY89dDq3o3EQAtEyJNb7X6SMg7byI7nlJuxK1yvl
Tv3m6nGjAEva6pI02NrFbaKiT0gqgUJkQJ7/iCcE2k0IzzfFSIupM/XxTfYAuxzu
Z/1KTJo89UN2CFEfM19ZCtqUdrYJfwvgUrncN4m2/v1elc0NgULaui9kU98bNMlX
dN9eKQL4DatksHckZVJJq3bfwBQ0bxWuKMrxPlMoCafVCKSVEUg=
=3tJR
-----END PGP SIGNATURE-----

--Apple-Mail=_A95A566B-0D61-4AC4-96E0-5D0C6169119D--
