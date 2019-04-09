Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EEC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031B42084F
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDIQdE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:33:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35827 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDIQdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 12:33:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E55F880203; Tue,  9 Apr 2019 18:32:52 +0200 (CEST)
Date:   Tue, 9 Apr 2019 18:33:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        paolo.valente@linaro.org, linux-block@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Message-ID: <20190409163304.GA23829@amd>
References: <20190408173914.GA13260@amd>
 <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-08 11:41:18, Jens Axboe wrote:
> On 4/8/19 11:39 AM, Pavel Machek wrote:
> > Hi!
> >=20
> > For some reason, Thinkpad X60 now crashes during boot. I see some
> > weird backtraces, and it may be bfq related... or maybe ACPI idle.
> >=20
> > Does x86-32 work for you?
> >=20
> > Weird thing is, 5.1.0-rc3-next-20190408 boots here (but later has
> > problems during resume, making it unusable, too). They may not have
> > 100% same configs.

I now noticed it said:

EIP is in bfq_bfqq_expire

> Can you try and revert:
>=20
> 9dee8b3b057e1
>=20
> and see if that helps?

Yes, I tried and yes, it helps. What are the next steps?=20

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlysyUAACgkQMOfwapXb+vI+KwCgradkSjU5BXM7t3nzK3oiTVBE
/vYAn069+EnMQXCDobqsLfChLCZ8wYH+
=hjYf
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
