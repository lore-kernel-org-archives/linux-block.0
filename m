Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E37C433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8900611CE
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 14:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbhDSOfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 10:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240324AbhDSOfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 10:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618842906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+I+iFmKFfWmcLXUV3qCX76oELASRZSiMUqZswZLmXY=;
        b=iXwqXEBXzWAVT7EuOm+tooGGuBZ9pLDoak2ctju7A/SpCpmpUOzn4Sj1cp1zR763qhBh+n
        4USKtnc/FywdEO3TkVI86I8KN5Bjv41VqPG6cqBoxy1ENAow6OBz0zKY6440kt72VF6JG3
        FnqeIdJTqxnrFaEF3aGa3JsNuPWm/zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Omin1X2bO8qwsKlxfCcAnw-1; Mon, 19 Apr 2021 10:35:01 -0400
X-MC-Unique: Omin1X2bO8qwsKlxfCcAnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9F281006C85;
        Mon, 19 Apr 2021 14:35:00 +0000 (UTC)
Received: from localhost (ovpn-113-179.ams2.redhat.com [10.36.113.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B2B960C5C;
        Mon, 19 Apr 2021 14:35:00 +0000 (UTC)
Date:   Mon, 19 Apr 2021 15:34:59 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     libc-alpha@sourceware.org, "H . J . Lu" <hjl.tools@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH liburing] examples/ucontext-cp.c: cope with variable
 SIGSTKSZ
Message-ID: <YH2VE2RdcH0ISvxH@stefanha-x1.localdomain>
References: <20210413150319.764600-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IPgn7lk3Zt7HqxUb"
Content-Disposition: inline
In-Reply-To: <20210413150319.764600-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--IPgn7lk3Zt7HqxUb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 04:03:19PM +0100, Stefan Hajnoczi wrote:
> The size of C arrays at file scope must be constant. The following
> compiler error occurs with recent upstream glibc (2.33.9000):
>=20
>   CC ucontext-cp
>   ucontext-cp.c:31:23: error: variably modified =E2=80=98stack_buf=E2=80=
=99 at file scope
>   31 |         unsigned char stack_buf[SIGSTKSZ];
>      |                       ^~~~~~~~~
>   make[1]: *** [Makefile:26: ucontext-cp] Error 1
>=20
> The following glibc commit changed SIGSTKSZ from a constant value to a
> variable:
>=20
>   commit 6c57d320484988e87e446e2e60ce42816bf51d53
>   Author: H.J. Lu <hjl.tools@gmail.com>
>   Date:   Mon Feb 1 11:00:38 2021 -0800
>=20
>     sysconf: Add _SC_MINSIGSTKSZ/_SC_SIGSTKSZ [BZ #20305]
>   ...
>   +# define SIGSTKSZ sysconf (_SC_SIGSTKSZ)
>=20
> Allocate the stack buffer explicitly to avoid declaring an array at file
> scope.
>=20
> Cc: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Perhaps the glibc change needs to be revised before releasing glibc 2.34
> since it might break applications. That's up to the glibc folks. It
> doesn't hurt for liburing to take a safer approach that copes with the
> SIGSTKSZ change in any case.

glibc folks, please take a look. The commit referenced above broke
compilation of liburing's tests. It's possible that applications will
hit similar issues. Can you check whether the SIGSTKSZ change needs to
be reverted/fixed before releasing glibc 2.34?

Thanks,
Stefan

> ---
>  examples/ucontext-cp.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/examples/ucontext-cp.c b/examples/ucontext-cp.c
> index 0b2a6b5..ea0c934 100644
> --- a/examples/ucontext-cp.c
> +++ b/examples/ucontext-cp.c
> @@ -28,7 +28,7 @@
> =20
>  typedef struct {
>  	struct io_uring *ring;
> -	unsigned char stack_buf[SIGSTKSZ];
> +	unsigned char *stack_buf;
>  	ucontext_t ctx_main, ctx_fnew;
>  } async_context;
> =20
> @@ -115,8 +115,13 @@ static int setup_context(async_context *pctx, struct=
 io_uring *ring)
>  		perror("getcontext");
>  		return -1;
>  	}
> -	pctx->ctx_fnew.uc_stack.ss_sp =3D &pctx->stack_buf;
> -	pctx->ctx_fnew.uc_stack.ss_size =3D sizeof(pctx->stack_buf);
> +	pctx->stack_buf =3D malloc(SIGSTKSZ);
> +	if (!pctx->stack_buf) {
> +		perror("malloc");
> +		return -1;
> +	}
> +	pctx->ctx_fnew.uc_stack.ss_sp =3D pctx->stack_buf;
> +	pctx->ctx_fnew.uc_stack.ss_size =3D SIGSTKSZ;
>  	pctx->ctx_fnew.uc_link =3D &pctx->ctx_main;
> =20
>  	return 0;
> @@ -174,6 +179,7 @@ static void copy_file_wrapper(arguments_bundle *pbund=
le)
>  	free(iov.iov_base);
>  	close(pbundle->infd);
>  	close(pbundle->outfd);
> +	free(pbundle->pctx->stack_buf);
>  	free(pbundle->pctx);
>  	free(pbundle);
> =20
> --=20
> 2.30.2
>=20

--IPgn7lk3Zt7HqxUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB9lRMACgkQnKSrs4Gr
c8goAAgAtlvWNiujZzrDO8PxUOwvMXG4WA7bCkzOp2WQyjnuJEty0bhDemC+odLa
/lsarwJpfVf5Suli87/3PNg/yM0vwGzD1TqCkC2GgdJ/v/qvsKTPfzzcbgIiMS1m
ss1mfH6GND8FFMg7leEwvTJQeGkeQO/tlLBi9Opx+Skeo7UIbqC6rI3XB2IFDQAL
Wd5taTvaoZgMfG36kT1dD7Ver4ncw0DH6WPTmPmit66z+jtDyyCJX0WiTS6BDY94
6cr/Gsgf7USHmMZUu4WOVAMIVbXS260c83pog0pspPYvaJInSq/Pr9V7RzsyN9SF
5x4DT7YtAl9cLcqrTxb5v9biNvb+Xw==
=iTKY
-----END PGP SIGNATURE-----

--IPgn7lk3Zt7HqxUb--

