Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9450C3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 19:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4618521881
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 19:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=venev.name header.i=@venev.name header.b="PAcpF7FY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfH0Tgh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:36:37 -0400
Received: from mtel-bg02.venev.name ([77.70.28.44]:42986 "EHLO
        mtel-bg02.venev.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0Tgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 15:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
         s=default; h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:
        From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xX1gQbZyBs76V04EYbKV3hgiObAvRTqWy+SCU2mou7c=; b=PAcpF7FYCNqo+wukY/+XQD7BXn
        +5HXOFzdDlbYgYjfjkoKWLaFNASdOFXirr9/qlJMPKVGVylKK7IXC2kbfmNzBmdmL6CocaSg83dnA
        AXKapUy2oJHzJsw0P+4FCoIlAnYn5ZuyKKKYt+7xcn9wxR3ObkC3p4NDnIPXj2cwbIoxgOdACPH0g
        2mJmWPOWju8pVYtB7h7uwWygBHgcDuB9/Jvn4fw6fkrKjQhjAt9LClmk/vHA73MUXn20l6dNHjpYH
        os8K0jLVj0FPDdpu+5nSdvLPc2A1tVLx+EDQ+qTDb6O5nzpr91toUx0qvsYZw12nPwHInaGHJq1wJ
        LuYvwCQMG1UnUnidPo6K36DL22310NC5f1irW1JW1P1V8Dvav6dVb3Jdjm5zYjv4buyNYm8E4F/b8
        JUEBClLPqirFrsaXQ8/I7BMMVcSzUo4K9nYnvSuPPyy3fU+Rg9rO7e09VC6fP1F3KpWlYScg7tw5i
        o7ICZBsEovMr36X7rpx2ZPa2Tg44gERNww0vrO1zHSwtk2Pu8l+XTE4nYzKqu4hKDGHo9BRBHFveG
        l6eqqcBuFF0jqNsK+wETAnu1ryCjjbGFb2m+81d4j00O4wmCdHgF+kudyztAOL7BOW7GDmyb06tQE
        9ts91/Mnyy5K7A+zZYn6CkUfQYSMIm6sYbU/Unv6A=;
X-Check-Malware: ok
Received: from mtel-bg02.venev.name
        by mtel-bg02.venev.name with esmtpsa
        (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (envelope-from <hristo@venev.name>)
        id 1i2hFu-0000lU-B4; Tue, 27 Aug 2019 19:36:15 +0000
Message-ID: <2f409a14ea27516a97cb7a7f1d70de7fe45c7c69.camel@venev.name>
Subject: Re: [PATCH] io_uring: allocate the two rings together
From:   Hristo Venev <hristo@venev.name>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Date:   Tue, 27 Aug 2019 20:35:49 +0100
In-Reply-To: <80e0e408-f602-4446-d244-60f9d4ce9c71@kernel.dk>
References: <20190826172346.8341-1-hristo@venev.name>
         <80e0e408-f602-4446-d244-60f9d4ce9c71@kernel.dk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-5lS1I17x6LGI3gmd+GKr"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--=-5lS1I17x6LGI3gmd+GKr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the duplicate reply, I forgot to CC the mailing list.

On Tue, 2019-08-27 at 09:50 -0600, Jens Axboe wrote:
> Outside of going for a cleanup, have you observed any wins from this
> change?

I haven't ran any interesting benchmarks. The cp examples in liburing
are running as fast as before, at least on x86_64.

Do you think it makes sense to tell userspace that the sq and cq mmap
offsets now mean the same thing? We could add a flag set by the kernel
to io_uring_params.

--=-5lS1I17x6LGI3gmd+GKr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4Qy6IzCpC4j84tq6r2XB91Zob5cFAl1lhhUACgkQr2XB91Zo
b5dzYBAAxxifj/qM5DLDSw2ocavA7mpWHbxcSEV/RQ/r7/rR/Q7YpKbaWB2BGWS1
nMZem/s/Wyc5WFFhCHCMwtpRLjRVqysAXTllzElHd9/YHGf3ou3RkuoJRwUfuhn+
BJ0Bww57BNJF5853xzGiRTNkpKE/96iyPAd+R/rCuQajoNMHsuJ6OobZmPwNxJWG
a7H/VfctmfdgIseuhJ7wCxIDHabN0w71dpqM3uLoFr2O5NNFR/SuioZoThkLK6WO
A99HX8JRlY5oCL7+sG0bSfj5Kw0UG1TNGV+oDE+Iwf2RqA3deIVanSFS9CXbvo+o
BD8YFQ2wrH0EfUFImjw58+X1Fd11PgII85HvonVymYT7+doYrh0UkZgsL7zrIYlt
KEDHR+yKfrXNxdaFegpSlua95/5VhHamqrN6YyC8OOvA9mWHkFT1dVMp42qxUaRF
8JoGLVelGp5/mnrbIeN+N6hMc7Nf50/8Rrp/yJGRYCq9LNwHcxDV/tQzDOc0rTgQ
PCpADEVF3xZv00BBKGoUOYK+Xpz99kWQ1cKOf61mR4bkGwASXYhBba48OUibzGj/
5D4BfCQZvhyvXjtWAu5HjoA4BvvjtcKBPqVZ9PKqckwM3ZDAYnlglyW3WMQYMviL
5EBuqXXQJdW13UfjttbGF0NXfeGXCw2Gfx92ns9Peszx5XKUIdQ=
=28QB
-----END PGP SIGNATURE-----

--=-5lS1I17x6LGI3gmd+GKr--

