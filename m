Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB089C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD603208CA
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfFNKnD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:43:03 -0400
Received: from sauhun.de ([88.99.104.3]:52116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfFNKnD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 06:43:03 -0400
Received: from localhost (p5486CF81.dip0.t-ipconnect.de [84.134.207.129])
        by pokefinder.org (Postfix) with ESMTPSA id 9DB202CF690;
        Fri, 14 Jun 2019 12:42:57 +0200 (CEST)
Date:   Fri, 14 Jun 2019 12:42:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        joro@8bytes.org, axboe@kernel.dk, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, iommu@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU can
 merge the segments
Message-ID: <20190614104252.GA2245@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190614072459.GD8420@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190614072459.GD8420@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +		host->can_merge =3D 1;
> > +	else
> > +		host->can_merge =3D 0;
> > +
>=20
> can_merge seems a little too generic a name to me.  Maybe can_iommu_merge?

Ack.


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0DeicACgkQFA3kzBSg
Kbai+A//TXe/UTCawLN26OjHt2UucUCPMqPhYULQbICoNMwgmVUqX54DWzikDx5o
A9NBpSff++FwU4hkdh80DQfdR4//S3uTQZnf0ZlND4AGFLKOCCSdZwsDCg3o8sAe
/Oc4pJa8BPV2W72PVKyZK+qFw5e5GFzC9jehlDHVWSI3/w08lICPzX2ogz5teYVn
8cmYjuaj9y6gibmMbRj/rgv3WvGn1jr2rjc+ekpZS5V/YlYqeUI3/5fp7n4Bit8X
OVQBXCcf6Z5oqVs+tio/MhA801qPykJvCwIrnsN9FN4P1C2iUZ72ynZ9z47jfxp2
MHAyV0h7glizA51S0YUqqW9ZeUIp2EKO6rPULVDlu4vxLtbELU0y8Yp5WmB6aJ4L
dRXpygqseWNgf9MlCFTT56L2VVVFnty/3Bm0f/LNiA+98XM103+bUsk3Y9nU9GnS
SBUEQbxyBnIt2JDhS978XAQWWNcy1Q1cyfj4Y4ywGatkCip7RjXC8jl2YQmOF7c9
sf+FIrEziEJKfWWXjtbz8NeWHFMsIt1GbP3+ICCgykgU5jrtGMhE8Xr/w1GV4RQ6
MPMdY2g9BwHGr27IVqCK0cHjs6mT4VRCH5NOEDdakN3FOmTXwFLsMEo2TXiSPjPa
TMMucF0Vlrt8S5/SuQQfz5L5JTRsr7RzLbOiV4mzDi00znetCwM=
=nycl
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
