Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D172C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 17:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF752148E
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 17:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDHRjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:39:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41615 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfDHRjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 13:39:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 16CC4803C8; Mon,  8 Apr 2019 19:39:07 +0200 (CEST)
Date:   Mon, 8 Apr 2019 19:39:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Message-ID: <20190408173914.GA13260@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

For some reason, Thinkpad X60 now crashes during boot. I see some
weird backtraces, and it may be bfq related... or maybe ACPI idle.

Does x86-32 work for you?

Weird thing is, 5.1.0-rc3-next-20190408 boots here (but later has
problems during resume, making it unusable, too). They may not have
100% same configs.=20

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrh0IACgkQMOfwapXb+vIRrACggLsDvfZVSFfbIvrcQZoIKISC
vMcAniBKjgYjIf9rFHdY2PhSUgLR82Zf
=5yXV
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
