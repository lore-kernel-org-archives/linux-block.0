Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF3C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 09:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8134F6145A
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 09:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhDVKAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230365AbhDVKAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 06:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619085589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3JC+FrC8kW9yjI+xSNFebXalDnxoffxG/hAMeMUBYHk=;
        b=B2yeGfFMIdnQvh3INlFyBXgpriHLp73vxEULt3DO5uqDmnHxHlPqOwn8BWvxobDgBAhCEO
        sAQKmPaPi4NBeRZzwId5zLYPPpyMbQTtUatjpyeGUNmmANP9sJEr2kZqbfvAcGD3UTScOj
        9z3TZ41QQ3TG9qbRmZmtn0dtQ7wiR/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-FJmPCfs4MCuipEOwC6wgzQ-1; Thu, 22 Apr 2021 05:59:45 -0400
X-MC-Unique: FJmPCfs4MCuipEOwC6wgzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF7984BA40;
        Thu, 22 Apr 2021 09:59:44 +0000 (UTC)
Received: from localhost (ovpn-115-28.ams2.redhat.com [10.36.115.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E972F5D9C6;
        Thu, 22 Apr 2021 09:59:43 +0000 (UTC)
Date:   Thu, 22 Apr 2021 10:59:42 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     libc-alpha@sourceware.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH liburing] examples/ucontext-cp.c: cope with variable
 SIGSTKSZ
Message-ID: <YIFJDgno7deI5syK@stefanha-x1.localdomain>
References: <20210413150319.764600-1-stefanha@redhat.com>
 <YH2VE2RdcH0ISvxH@stefanha-x1.localdomain>
 <CAMe9rOpK08CJ5TdQ1fZJ2sGUVjHqoTHS2kT8EzDEejuodu8Ksg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tTB7Fo7YtaBGELxr"
Content-Disposition: inline
In-Reply-To: <CAMe9rOpK08CJ5TdQ1fZJ2sGUVjHqoTHS2kT8EzDEejuodu8Ksg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--tTB7Fo7YtaBGELxr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 11:38:07AM -0700, H.J. Lu wrote:
> On Mon, Apr 19, 2021 at 7:35 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Tue, Apr 13, 2021 at 04:03:19PM +0100, Stefan Hajnoczi wrote:
> > > The size of C arrays at file scope must be constant. The following
> > > compiler error occurs with recent upstream glibc (2.33.9000):
> > >
> > >   CC ucontext-cp
> > >   ucontext-cp.c:31:23: error: variably modified =E2=80=98stack_buf=E2=
=80=99 at file scope
> > >   31 |         unsigned char stack_buf[SIGSTKSZ];
> > >      |                       ^~~~~~~~~
> > >   make[1]: *** [Makefile:26: ucontext-cp] Error 1
> > >
> > > The following glibc commit changed SIGSTKSZ from a constant value to a
> > > variable:
> > >
> > >   commit 6c57d320484988e87e446e2e60ce42816bf51d53
> > >   Author: H.J. Lu <hjl.tools@gmail.com>
> > >   Date:   Mon Feb 1 11:00:38 2021 -0800
> > >
> > >     sysconf: Add _SC_MINSIGSTKSZ/_SC_SIGSTKSZ [BZ #20305]
> > >   ...
> > >   +# define SIGSTKSZ sysconf (_SC_SIGSTKSZ)
> > >
> > > Allocate the stack buffer explicitly to avoid declaring an array at f=
ile
> > > scope.
> > >
> > > Cc: H.J. Lu <hjl.tools@gmail.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > > Perhaps the glibc change needs to be revised before releasing glibc 2=
=2E34
> > > since it might break applications. That's up to the glibc folks. It
> > > doesn't hurt for liburing to take a safer approach that copes with the
> > > SIGSTKSZ change in any case.
> >
> > glibc folks, please take a look. The commit referenced above broke
> > compilation of liburing's tests. It's possible that applications will
> > hit similar issues. Can you check whether the SIGSTKSZ change needs to
> > be reverted/fixed before releasing glibc 2.34?
> >
>=20
> It won't be changed for glibc 2.34.

Thanks for the response, H.J. and Paul.

In that case liburing needs this patch.

Stefan

--tTB7Fo7YtaBGELxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCBSQ4ACgkQnKSrs4Gr
c8g8tQf/eZkYU0VK1+vqZXkq7OGFswziLeF9lAtl8YIt40yIHVyLKq18nSArBUPP
ee0RHJZ8HH1T5PJct2SZAF1r5LyndGxngBX61LpOkIizjRNDQKrr0sf5fEp84cvF
mry2p5++FnOGWTLvJZz2pboJ5YYbUNSb1Z6sTZHuXx8nack5uZFG6sjk9uJS5ZP0
yKvSYEqKLh6w1iSCWI5Oojw7HusAo2erRuIF3vjTTVceNiSQkGUsXvbTkaSerpVh
MjgIhcmdkUmEczKq4I7UzEyDHG2sZoW6JeIYX70IZ3iSRB3rkRAMtD5uGjeRVYsq
hhxbX0BFCqHhuNXr0k+w9nel3kLHhA==
=7suT
-----END PGP SIGNATURE-----

--tTB7Fo7YtaBGELxr--

