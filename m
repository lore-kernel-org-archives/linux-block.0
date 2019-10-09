Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C072C47404
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C200206BB
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 17:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfJIRqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1469 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJIRqV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Oct 2019 13:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 694EF10A8124;
        Wed,  9 Oct 2019 17:46:21 +0000 (UTC)
Received: from localhost (ovpn-116-110.ams2.redhat.com [10.36.116.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F22CA5EE1D;
        Wed,  9 Oct 2019 17:46:20 +0000 (UTC)
Date:   Wed, 9 Oct 2019 18:46:19 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
Subject: Re: liburing 0.2 release?
Message-ID: <20191009174619.GJ13568@stefanha-x1.localdomain>
References: <20191009083406.GA4327@stefanha-x1.localdomain>
 <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Wed, 09 Oct 2019 17:46:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 05:40:16AM -0600, Jens Axboe wrote:
> On 10/9/19 2:34 AM, Stefan Hajnoczi wrote:
> > Hi Jens,
> > I would like to add a liburing package to Fedora.  The liburing 0.1
> > release was in January and there have been many changes since then.  Is
> > now a good time for a 0.2 release?
>=20
> I've been thinking the same. I'll need to go over the 0.1..0.2 additions
> and ensure I'm happy with all of it (before it's set in stone), then we
> can tag 0.2.
>=20
> Let's aim for a 0.2 next week at the latest.

Sounds great!

Stefan

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2eHOsACgkQnKSrs4Gr
c8hdgwf/acCSUjyxlDBoWcV25uGVnEid1ZBCooZUllGpvitvXVlLFX3mqiXMuOpK
6gYrudU7nTcLp75fKu5VZLRjGY9XygfSR3p9ChKQ2diUS2LV5/uA3NJ7vvqwKraY
DdK30VPeh2DHE551ElWd/NWCddrP3yF3vfQ+KGZnXbnZPMVhZ2iDQVYTQ6VRPQqU
vLikBkRhNbAkmwNo4WPhfJwVVkkHI655aCed/NCaI6y4CdnWvrOzxFf4NDloPnNA
aK5xhJbUy7QJw7xlmicaTBCemHYDZccWn2pyZgZt+YT+7XOkYPlTmEcjh7ONUENO
2c4bbiueQvJIWsruMYEDozU9FUsHyQ==
=Xvq7
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
