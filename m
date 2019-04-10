Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E046C10F14
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 09:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D689A2083E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 09:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfDJJas (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:30:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36042 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfDJJas (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 05:30:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EE9E08053D; Wed, 10 Apr 2019 11:30:36 +0200 (CEST)
Date:   Wed, 10 Apr 2019 11:30:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Message-ID: <20190410093044.GA3776@amd>
References: <20190408173914.GA13260@amd>
 <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
 <20190409163304.GA23829@amd>
 <F6306562-0022-4043-BBF8-13FE4872CA31@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <F6306562-0022-4043-BBF8-13FE4872CA31@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I now noticed it said:
> >=20
> > EIP is in bfq_bfqq_expire
> >=20
> >> Can you try and revert:
> >>=20
> >> 9dee8b3b057e1
> >>=20
> >> and see if that helps?
> >=20
> > Yes, I tried and yes, it helps. What are the next steps?=20
> >=20
>=20
> Try my fix:
>=20
> https://lore.kernel.org/linux-block/20190409191420.3f56d493@fire.localdom=
ain/T/#m30a14045e710b870f00f7c51cdaa7c403977b767
>=20
> and cross your fingers :)

It seems to work... even without fingers crossed.

Tested-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlytt8QACgkQMOfwapXb+vLQHACgwtIivSbdVhFRgJOzmwD+jX9w
fiAAn3PNMMqoimIU76sd/za230tevyY+
=dYXi
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
