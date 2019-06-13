Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DFC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25CC20B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfFMPUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbfFMM5C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 08:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4693530872E2;
        Thu, 13 Jun 2019 12:56:46 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1021D10018E0;
        Thu, 13 Jun 2019 12:56:39 +0000 (UTC)
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
        josef@toxicpanda.com, nbd@other.debian.org,
        A.Bulyshchenko@globallogic.com, linux-block@vger.kernel.org,
        axboe@kernel.dkn.org
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
From:   Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <3a15a92f-16d6-cca3-8842-b0866579a95a@redhat.com>
Date:   Thu, 13 Jun 2019 07:56:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612163144.18486-2-roman.stratiienko@globallogic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1mFPIR4gUIZspv7ZUjGD9XHyqwoM6f3do"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Jun 2019 12:57:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1mFPIR4gUIZspv7ZUjGD9XHyqwoM6f3do
Content-Type: multipart/mixed; boundary="sgH4lnP1uGSxVKzPJ1Q9zkQ6LMEiCSRAg";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com, nbd@other.debian.org, A.Bulyshchenko@globallogic.com,
 linux-block@vger.kernel.org, axboe@kernel.dkn.org
Message-ID: <3a15a92f-16d6-cca3-8842-b0866579a95a@redhat.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
In-Reply-To: <20190612163144.18486-2-roman.stratiienko@globallogic.com>

--sgH4lnP1uGSxVKzPJ1Q9zkQ6LMEiCSRAg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/12/19 11:31 AM, roman.stratiienko@globallogic.com wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
>=20
> Adding support to nbd to use it as a root device. This code essentially=

> provides a minimal nbd-client implementation within the kernel. It open=
s
> a socket and makes the negotiation with the server. Afterwards it passe=
s
> the socket to the normal nbd-code to handle the connection.
>=20
> The arguments for the server are passed via kernel command line.
> The kernel command line has the format
> 'nbdroot=3D[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>'.
> SERVER_IP is optional. If it is not available it will use the
> root_server_addr transmitted through DHCP.
>=20
> Based on those arguments, the connection to the server is established
> and is connected to the nbd0 device. The rootdevice therefore is
> root=3D/dev/nbd0.
>=20
> Patch was initialy posted by Markus Pargmann <mpa@pengutronix.de>
> and can be found at https://lore.kernel.org/patchwork/patch/532556/
>=20
> Change-Id: I78f7313918bf31b9dc01a74a42f0f068bede312c
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> Reviewed-by: Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>

> +static int nbd_connection_negotiate(struct socket *sock, char *export_=
name,
> +				    size_t *rsize, u16 *nflags)
> +{

> +
> +	ret =3D sock_xmit_buf(sock, 0, &flags, sizeof(flags));
> +	if (ret < 0)
> +		return ret;
> +
> +	*nflags =3D ntohs(flags);
> +
> +	client_flags =3D 0;

Why not reply with NBD_FLAG_C_FIXED_NEWSTYLE? Which in turn would be
necessary...

> +
> +	ret =3D sock_xmit_buf(sock, 1, &client_flags, sizeof(client_flags));
> +	if (ret < 0)
> +		return ret;
> +
> +	magic =3D cpu_to_be64(nbd_opts_magic);
> +	ret =3D sock_xmit_buf(sock, 1, &magic, sizeof(magic));
> +	if (ret < 0)
> +		return ret;
> +
> +	opt =3D htonl(NBD_OPT_EXPORT_NAME);

Why not use NBD_OPT_GO?  That's a better interface (better error
recovery, and some servers can even use it to advertise preferred block
sizing - particularly if a server insists on a 4k minimum block instead
of 512).

=2E..using NBD_OPT_GO would require checking that the server advertised
FIXED_NEWSTYLE as well as replying that we intend to rely on it.

Otherwise the idea looks interesting to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sgH4lnP1uGSxVKzPJ1Q9zkQ6LMEiCSRAg--

--1mFPIR4gUIZspv7ZUjGD9XHyqwoM6f3do
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0CSAYACgkQp6FrSiUn
Q2pQVgf/SAkzO/2y16ZWAOWbE/P/FZSQbPMBqGLAz1/Rk5z64pdkETpf4GyxwZt9
KzaafzGckPzYHp1gsoFP1/QveKPvNOdhldLJHD5LkD1uEM/3d8z8uRypR2u1gsCJ
EhlIuCpIfoGIMR7hizyZJflpRgwYDBNCyOyN4Y0plN5vZ5cZfMNvI+chKvhuneBX
ZgxfoorSWCx0F1PDviTrfwIclR2ZciBjEEzrDiP4SAg4N9Sg/RDg66P3rxAnuDPa
vWSn5xu2ImK2vPbG3vnBQwsCl1E4cDs+SYo28mFAipi5J+NAmVW355fomubmvCwt
hF75HdVcRncQbmRFlEvU3BIhG4MyEg==
=WxSM
-----END PGP SIGNATURE-----

--1mFPIR4gUIZspv7ZUjGD9XHyqwoM6f3do--
