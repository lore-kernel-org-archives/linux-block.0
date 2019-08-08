Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17D4C433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 07:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38472171F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 07:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfHHHn1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:43:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36681 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHHn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 03:43:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C0278803EC; Thu,  8 Aug 2019 09:43:10 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:43:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Will Deacon <will@kernel.org>,
        Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
Message-ID: <20190808074322.GA7308@amd>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed 2019-07-31 17:47:40, Denis Efremov wrote:
> Hi All,
>=20
> On 18.07.2019 01:03, Jiri Kosina wrote:
> > On Wed, 17 Jul 2019, Linus Torvalds wrote:
> >
> >> I don't think we really have a floppy maintainer any more,
> >
> > Yeah, I basically volunteered myself to maintain it quite some time
> > ago back when I fixed the concurrency issues which exhibited itself
> > only with VM-emulated devices, and at the same time I still had the
> > physical 3.5" reader.

For the record, I still have three or maybe more 3.5" drives here, if
you want them, delivery to your office should be easy ;-).

> > The hardware doesn't work any more though. So I guess I should just
> > remove myself as a maintainer to reflect the reality and mark floppy.c
> > as Orphaned.
>=20
> Well, without jokes about Thunderdome, I've got time, hardware and
> would like to maintain the floppy. Except the for recent fixes,
> I described floppy ioctls in syzkaller. I've already spent quite
> a lot of time with this code. Thus, if nobody minds

Thanks for doing this!

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1L0pkACgkQMOfwapXb+vLWYgCeLN4oIoMNBkOcwmpNCAIDT479
hMAAnj+BfMaP75cKAj27BO/d1SDLsoX3
=bAw2
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
