Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BED6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 07:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiDSHD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiDSHD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 03:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C06D81FA7A
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650351643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/Np8bcxq6lXUuRuEvdwmCF7PM4GSiOtDGnA96SV3lk=;
        b=U6PY241ykn7OSd/LtY/CJhkkeE068Q6nHOomSploCYiSn5gXv92i+xKlhcQyp1EyO7uY4l
        2fa7C9JLcu1mcmLL3BjnKZR3npdK+sF66l1lKzOZC3yumdoieGvZBlOKkCsKTiW/vDdQqz
        hziRgOydoqyS/hYFo6d432Ogwg3FAOo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-YEuQjNecOTK1793491g0kw-1; Tue, 19 Apr 2022 03:00:40 -0400
X-MC-Unique: YEuQjNecOTK1793491g0kw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A071E3800516;
        Tue, 19 Apr 2022 07:00:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 391644029DD;
        Tue, 19 Apr 2022 07:00:39 +0000 (UTC)
Date:   Tue, 19 Apr 2022 09:00:37 +0200
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Paymon MARANDI <darwinskernel@gmail.com>
Subject: Re: [PATCH] Revert "make: let src/Makefile set *dir vars properly"
Message-ID: <Yl5eFRLiep5e9hx1@stefanha-x1.localdomain>
References: <20220414063651.81341-1-stefanha@redhat.com>
 <4c5803a4-4e69-e107-c2b8-7a3e7733fae2@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EFlCYg43I5qLIrxp"
Content-Disposition: inline
In-Reply-To: <4c5803a4-4e69-e107-c2b8-7a3e7733fae2@kernel.dk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--EFlCYg43I5qLIrxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 14, 2022 at 06:55:48AM -0600, Jens Axboe wrote:
> On 4/14/22 12:36 AM, Stefan Hajnoczi wrote:
> > This reverts commit 9236f53a8ffe96cc2430f7131bbcba5756b97bc2.
> >=20
> > "make install DESTDIR=3D..." specifies a root directory where files are
> > installed. For example, includedir=3D/usr/include DESTDIR=3D/a should
> > install header files into /a/usr/include.
> >=20
> > Commit 9236f53a8ffe removed the includedir=3D, etc arguments on the make
> > command-line in ./Makefile, leaving only prefix=3D$(DESTDIR)$(prefix). =
It
> > claimed "prefix suffice for setting *dir variables in src/Makefile" but
> > this is incorrect. "make install DESTDIR=3D..." now has no effect and
> > files are not installed with a DESTDIR prefix.
> >=20
> > The GNU make manual 9.5 Overriding Variables says:
> >=20
> >   all ordinary assignments of the same variable in the makefile are
> >   ignored; we say they have been overridden by the command line
> >   argument.
> >=20
> > This explains why it was necessary to set includedir=3D, etc on the make
> > command-line in ./Makefile. We need to override these variables with
> > DESTDIR from the command-line so they are not clobbered in src/Makefile
> > when config-host.mak is included.
>=20
> I think this should have gone to io-uring@vger.kernel.org, the patch had
> me confused for a second.

Sorry about that. I have updated my configuration to send patches to the
correct list.

Stefan

--EFlCYg43I5qLIrxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJeXhUACgkQnKSrs4Gr
c8jtJAf/b2YNwt5b+yQcV4lHY7T7cQRjR3yKgfx283CegomAc1cwX0WvcjADsjYN
dOZcNfBEhGGS5a1rnq9hQiL0Ys+VNNbDThiS8YLHWMTlTomsjKsuHz6aYbPVG0FE
N5q5qdKjzVvP2fCCdU3tIVxoN31OwwMpKyNA46HA8/HinWFxiFWE7zdIqhTO2A72
yKq4PDXfmRA255UlNuEOpMs4gXBEAybhfuCQRf9s7wBonrGNjJTynOrmav5SBVch
q6d09Oi0O80oVcmpg0NTYl+we47Jgp3fWPNL7rOHvBdlu2xQTJ6ZWvVqlaxZlGFJ
wG1dIq9EJNo9GDsOwySZI7FJzMK+lw==
=+Zyt
-----END PGP SIGNATURE-----

--EFlCYg43I5qLIrxp--

