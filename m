Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBCCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 15:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E804F20869
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 15:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFsVkLFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfKDPxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:53:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32141 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbfKDPxe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 10:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572882812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRIPyJVitJkXRDQEoBw5KIWFm/2x3dAwfxhtcvod7FE=;
        b=VFsVkLFoI9M8Oja9rM4hN7cHhABrU4FKmNPNvNyetCA9CxC+K2pu4DVm8PGfCvZMsKj3df
        jaFk1cXdWhUs75lJVzINNj6jnb3s29Me19qC5jKD0rpQ6cpEDI00pGS81eml5V0sWaw4Bl
        mWiqvovWTJ39vdrYiKh5F7KaMNtxzeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-9qD3gLG2OdS6qvhz-B8Hrw-1; Mon, 04 Nov 2019 10:53:29 -0500
X-MC-Unique: 9qD3gLG2OdS6qvhz-B8Hrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F08B800C73;
        Mon,  4 Nov 2019 15:53:28 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9E205D6C5;
        Mon,  4 Nov 2019 15:53:24 +0000 (UTC)
Date:   Mon, 4 Nov 2019 16:53:23 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH liburing 3/3] spec: Fedora RPM cleanups
Message-ID: <20191104155323.GA57506@stefanha-x1.localdomain>
References: <20191104120532.32839-1-stefanha@redhat.com>
 <20191104120532.32839-4-stefanha@redhat.com>
 <91fbe88c-5574-847e-12f0-992710bbb544@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <91fbe88c-5574-847e-12f0-992710bbb544@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 07:07:00AM -0700, Jens Axboe wrote:
> On 11/4/19 5:05 AM, Stefan Hajnoczi wrote:
> > From: Jeff Moyer <jmoyer@redhat.com>
> >=20
> > Cole Robinson and Fabio Valenti made a number of suggestions for the
> > .spec file:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1766157
> >=20
> >   * Release should be Release: 1%{?dist} so the .fcXX bits get appended=
 to the version string
> >   * Source: should be a pointer to the upstream URL that hosts the rele=
ase. In this case I think it should be https://github.com/axboe/liburing/ar=
chive/%{name}-%{version}.tar.gz#%{name}-%{name}-%{version}.tar.gz, the endi=
ng weirdness is due to github renaming the archive strangely. You might nee=
d to pass '-n %{name}-%{name}-%{version}' to %setup/%autosetup to tell it w=
hat the extracted archive name is
> >   * The %defattr lines should be removed: https://pagure.io/packaging-c=
ommittee/issue/77
> >   * The Group: lines should be removed
> >   * All the BuildRoot and RPM_BUILD_ROOT lines should be removed. %clea=
n should be removed
> >   * The ./configure line should be replaced with just %configure
> >   * The 'make' call should be %make_build
> >   * The 'make install' call should be %make_install
> >   * The %pre and %post sections can be entirely removed, ldconfig is do=
ne automatically: https://fedoraproject.org/wiki/Changes/Removing_ldconfig_=
scriptlets
> >   * The devel package 'Requires: liburing' should instead be: Requires:=
 %{name} =3D %{version}-%{release}
> >   * The devel package should also have Requires: pkgconfig
> >   * I think all the %attr usage can be entirely removed, unless they ar=
e doing something that the build system isn't doing.
> >   * The Provides: liburing.so.1 shouldn't be necessary, I'm pretty sure=
 RPM automatically adds annotations like this
> >   * Replace %setup with %autosetup, which will automatically apply any =
listed Patch: in the spec if anything is backported in the future. It's a s=
mall maintenace optimization
> >=20
> > These changes work on Fedora 31 and openSUSE Leap 15.1.  Therefore they
> > are likely to work on other rpm-based distributions too.
>=20
> This looks like a spec file changelog. Nothing wrong with that, but it
> should be no wider than 72 characters to avoid making git log look like
> a mess. Normally I'd just fix that up, but another comment below.

Will fix in v2.

> > -URL: http://git.kernel.dk/cgit/liburing/
> > +URL: http://brick.kernel.dk/snaps/%{name}-%{version}.tar.gz
> > +BuildRequires: gcc
>=20
> I enabled snapshots in cgit, so maybe we can just point at those?
> Something like:
>=20
> URL: https://git.kernel.dk/cgit/liburing/snapshot/%{name}-%{version}.tar.=
gz
>=20
> Yes, and there's also https now, finally got that enabled on kernel.dk
> after running that site for more than two decades.

Great news!  Will switch to that.

> >   %changelog
> > +* Thu Oct 31 2019 Jeff Moyer <jmoyer@redhat.com> - 0.2-1
> > +- Initial fedora package.
> > +
>=20
> Maybe keep this distro agnostic?

I will make the changelog cover the actual API changes in 0.2.

Stefan

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3ASXMACgkQnKSrs4Gr
c8iiFwgAlbeu5r7dARbHGTLSmeOCbFeU/tEm4PMby0j6wDkQd/ukVeIHoDZEADgS
60Jo++RJDDrjjvVh3QLJFrTxR++JkKer/9FllZ2WJ4YWiKMbvvMkz6VCGrPYC0bB
gYzOZZq2g34iuzs970gHVeQ0iYupSrIHLXaUcqK036MYFXOIMqFHEJ9539dS42QK
agg9Lhxl/fqfGEueOwhsMCs+sZq7hvN55smfsmcz5IN/tg7kdl8Qxlvkiz92Y4q5
B3l8IrK9FZ4IwdWGpfJRuMeeNcuO8rGNDbHC0B5ieAdct6wnThELxl5DbGjqnazj
tHp2K/0PwFkyqSNqFu6pO+/i7U3Wsg==
=pEa4
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

