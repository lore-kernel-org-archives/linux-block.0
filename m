Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183F8C433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77DD2078A
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="Pc+M+Jf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgH1Hrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:47:41 -0400
Received: from charlie.dont.surf ([128.199.63.193]:35382 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH1Hrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 03:47:35 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 4856BBF554;
        Fri, 28 Aug 2020 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
        s=default; t=1598600852;
        bh=tBI8Q0spIHPr7fUks65vQIU+W7ZPCNmh06qQz3L0JC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pc+M+Jf8lB6jtFPZ+N9B6j5qFEorOUIsUpRKHm0Lly9uniOs6ZBhyATZ5tBJV1HDC
         ufiVov1jsoHa3RiDDQJf7oarDnKKdv1v0vT0OXF2GAJoukMCSi+uQV7mwsaIUQGIfJ
         /CzZ5aY1t8obZm3zLQMjxpI6QeRLT32964Rpj4T83IFJOWnECaO0zo0W5O53RGi0Sp
         mhg7Ui7PSJrR0IHw6hUR+KF8Zt32sk28GGDJqQY7ShdBAD61t/pGB32CAlTOo2p54D
         Y7KEuOF1YVAdPxGmU3M9VQGbvs6SVe7JX3qdBJTuqsxc5l4UwyjW7BnCTQrkwI4aG5
         FKoKmZqSzEm/Q==
Date:   Fri, 28 Aug 2020 09:47:28 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Message-ID: <20200828074728.GA1343822@apples.localdomain>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828072253.GA1331347@apples.localdomain>
 <CY4PR04MB37514386D6A94A04F66EFF1DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37514386D6A94A04F66EFF1DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 28 07:36, Damien Le Moal wrote:
> On 2020/08/28 16:23, Klaus Jensen wrote:
> > On Aug 28 07:06, Damien Le Moal wrote:
> >> On 2020/08/27 22:50, Niklas Cassel wrote:
> >>> +static blk_status_t null_finish_zone(struct nullb_device *dev, struc=
t blk_zone *zone)
> >>> +{
> >>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> >>> +		return BLK_STS_IOERR;
> >>> +
> >>> +	switch (zone->cond) {
> >>> +	case BLK_ZONE_COND_FULL:
> >>> +		/* finish operation on full is not an error */
> >>> +		return BLK_STS_OK;
> >>> +	case BLK_ZONE_COND_EMPTY:
> >>> +		if (!null_manage_zone_resources(dev, zone))
> >>
> >> OK. So you are hitting a fuzzy case here that is not actually well des=
cribed in
> >> the standards. That is, does finishing an empty zone necessarilly impl=
y a
> >> temporary transition through imp open ? Which you are assuming is a ye=
s here.
> >> Personally, I would say that is not necessary, but no strong feeling e=
ither way.
> >>
> >=20
> > For ZNS, the spec is pretty clear that ZSE to ZSF is a legal direct
> > transition. So I don't think the transition should be allowed to fail
> > due to a lack of resources.
>=20
> I had a doubt and checked again ZBC & ZAC. I section 4.4.3.2.4 it says:
>=20
> The Zone Condition state machine (see 4.4.3.5) requires the specified zon=
e to
> have a Zone Condition of EXPLICITLY OPENED or IMPLICITLY OPENED before a =
finish
> zone operation is performed. If a zone with a Zone Condition of EMPTY or =
CLOSED
> is specified for a finish zone operation, prior to processing the finish =
zone
> operation, then the Zone Condition state machine requires that:
> a) a manage open zone resources operation (see 4.4.3.2.6) be performed; a=
nd
> b) the Zone Condition becomes IMPLICITLY OPENED.
>=20
> And section 5.3 describing the zone finish command points to this section.
> So this is not the same as ZNS.
>=20
> As Niklas mentioned, nullblk tends to follow more ZBC than ZNS, so the co=
de is
> correct in this respect. We could also lean toward ZNS on this one. I per=
sonally
>  have no strong opinion either way since there is not real good reasons f=
or
> finishing an empty zone that I can think of.
>=20
>=20

Alrighty then; thanks for looking it up! I won't fight for the ZNS
behavior then :)

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9ItowACgkQTeGvMW1P
Delr5AgAp9np/sJUFZpai+i7J4D/YZghj9cy3HB0x+/fHfiozmdY0jfozu/KaQn3
wP+dh0Up/mBUSRtsHLl0kqy09kxaQsisIUgZYPRLFIvtTdNUhaEui6xzaewicfO9
2kJFrFO/CFgJFQQFZ7Cszf6cgJjb/oBXn7Phj0o2f9pEgUfD4xfDric2M3/uAQ2B
N4oFb3d89q8FDWd0r1MehqzDrBjW2qzt5N9B0DLXVdkWmEXD5ofEAmxrSRLYejde
YC/8aBvwtd/xSifcGd2O7ywQPiDFWCg5kTC610AdcZ4EzoEV96HqnhTXluP02/s8
HsiVJxqZJ4ULosvo1dZ2UQg78P+H2g==
=9bE6
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
