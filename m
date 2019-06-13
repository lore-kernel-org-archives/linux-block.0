Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B074EC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E2620B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfFMPSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732169AbfFMNOq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 09:14:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4953330C4069;
        Thu, 13 Jun 2019 13:14:29 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29392838DB;
        Thu, 13 Jun 2019 13:14:24 +0000 (UTC)
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
        josef@toxicpanda.com, nbd@other.debian.org,
        A.Bulyshchenko@globallogic.com, linux-block@vger.kernel.org,
        axboe@kernel.dkn.org, "Richard W.M. Jones" <rjones@redhat.com>
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <b988f702-f394-6f2e-43ea-61298c0f2b03@redhat.com>
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
Message-ID: <9719bfd9-b8a7-93be-4c72-20c15bd9b0ca@redhat.com>
Date:   Thu, 13 Jun 2019 08:14:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b988f702-f394-6f2e-43ea-61298c0f2b03@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ErDNsdXWDIj6U5hGHisGjUBG8gJFtQVKk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Jun 2019 13:14:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ErDNsdXWDIj6U5hGHisGjUBG8gJFtQVKk
Content-Type: multipart/mixed; boundary="S2EvyWwzvf46WIVEfIBBFWxpPGsygXebW";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com, nbd@other.debian.org, A.Bulyshchenko@globallogic.com,
 linux-block@vger.kernel.org, axboe@kernel.dkn.org,
 "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <9719bfd9-b8a7-93be-4c72-20c15bd9b0ca@redhat.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <b988f702-f394-6f2e-43ea-61298c0f2b03@redhat.com>
In-Reply-To: <b988f702-f394-6f2e-43ea-61298c0f2b03@redhat.com>

--S2EvyWwzvf46WIVEfIBBFWxpPGsygXebW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/13/19 8:02 AM, Eric Blake wrote:
> On 6/12/19 11:31 AM, roman.stratiienko@globallogic.com wrote:
>> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
>>
>> Adding support to nbd to use it as a root device. This code essentiall=
y
>> provides a minimal nbd-client implementation within the kernel. It ope=
ns
>> a socket and makes the negotiation with the server. Afterwards it pass=
es
>> the socket to the normal nbd-code to handle the connection.
>>
>> The arguments for the server are passed via kernel command line.
>> The kernel command line has the format
>> 'nbdroot=3D[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>'.
>=20
> Did you intend for nbdroot=3D1234 to connect to port 1234 or to server
> 1234 port 10809?  Is an export name mandatory even when it is the empty=

> string, in which case, is the / character mandatory?  Maybe this would
> be better written as:
>=20
>  [<SERVER_IP>[:<SERVER_PORT]][/<EXPORT_NAME]

Make that:

 [[<SERVER_IP>][:<SERVER_PORT>]][/[<EXPORT_NAME>]]

as well as a blurb that IPv6 requires use of [] around SERVER_IP to
avoid ambiguity between IP address and the port designator.  That would
allow variations such as:

nbdroot=3D1.2.3.4          # port 10809 and export name '' defaulted
nbdroot=3D1.2.3.4:10809/   # fully explicit, export name ''
nbdroot=3D:10810/export    # host defaulted by DHCP, rest is explicit
nbdroot=3D/                # host and port are defaulted, export is ''
nbdroot=3D[::1]:10810      # IPv6 localhost and port 10810
nbdroot=3D::1              # IPv6 localhost, default port 10809

[I'm aware that localhost is probably not going to work based on how
early this is encountered during the boot; rather, consider ::1 as a
placeholder for a more realistic IPv6 address]

>=20
> although that would allow nbdroot=3D using all defaults (will that stil=
l
> do the right thing?).

nbdroot=3D                # host from DHCP, port 10809, export ''

>=20
> Should we support nbdroot=3DURI, and tie this in to Rich's proposal [1]=
 on
> standardizing the set of URIs that refer to an NBD export?  It seems
> like you are still limited to a TCP socket (not Unix) with no
> encryption, so this would be equivalent to the URI:
>=20
> nbd://[server[:port]][/export]
>=20
> [1] https://lists.debian.org/nbd/2019/06/msg00011.html
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--S2EvyWwzvf46WIVEfIBBFWxpPGsygXebW--

--ErDNsdXWDIj6U5hGHisGjUBG8gJFtQVKk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0CTC8ACgkQp6FrSiUn
Q2rVgwf/a4qoPz761KRZj2SZLO9qDdWaN73bDKtRdLi6UHkKF5lhPaFDJR48Ati2
UKl2pwsbplvO82LGtjHcvfozVcd1CZw8Dp1PnLx/BsROJPjW0gjvWUYLUyTSZmtb
9id03GupgF4GmGEu6f7fRmFZ83/JJgo/zlzbLwk72eNH6CgzSUcw18QAeDKADbPg
CeMcNyEvzjtK4cCv3OV7ZAE3o5hvdrwDu/vznghfsRKgwtFv9qYsK0BvQsPvBCcC
N4KiGIW8vC3xqm8N0CxXz8R5FcZFXo/qsowWYqW09fW9iNwpYRNkFPomp6LyyYYE
vA/DvL70eT0jbRcZoinfY0Wc4B3QGA==
=vawe
-----END PGP SIGNATURE-----

--ErDNsdXWDIj6U5hGHisGjUBG8gJFtQVKk--
