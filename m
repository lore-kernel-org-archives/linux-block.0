Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF8EC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2248F2054F
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfFMPSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732144AbfFMNDB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 09:03:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B21DCA36F;
        Thu, 13 Jun 2019 13:03:00 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D484E541F2;
        Thu, 13 Jun 2019 13:02:57 +0000 (UTC)
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
        josef@toxicpanda.com, nbd@other.debian.org,
        A.Bulyshchenko@globallogic.com, linux-block@vger.kernel.org,
        axboe@kernel.dkn.org, "Richard W.M. Jones" <rjones@redhat.com>
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
Message-ID: <b988f702-f394-6f2e-43ea-61298c0f2b03@redhat.com>
Date:   Thu, 13 Jun 2019 08:02:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612163144.18486-2-roman.stratiienko@globallogic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9Icx9ItsU53ORwiANl09EUUC5IOzpGhUD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 13 Jun 2019 13:03:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Icx9ItsU53ORwiANl09EUUC5IOzpGhUD
Content-Type: multipart/mixed; boundary="GcPkFI5vKHhM5L3R0laXCr11kPXSMamS8";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com, nbd@other.debian.org, A.Bulyshchenko@globallogic.com,
 linux-block@vger.kernel.org, axboe@kernel.dkn.org,
 "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <b988f702-f394-6f2e-43ea-61298c0f2b03@redhat.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
In-Reply-To: <20190612163144.18486-2-roman.stratiienko@globallogic.com>

--GcPkFI5vKHhM5L3R0laXCr11kPXSMamS8
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

Did you intend for nbdroot=3D1234 to connect to port 1234 or to server
1234 port 10809?  Is an export name mandatory even when it is the empty
string, in which case, is the / character mandatory?  Maybe this would
be better written as:

 [<SERVER_IP>[:<SERVER_PORT]][/<EXPORT_NAME]

although that would allow nbdroot=3D using all defaults (will that still
do the right thing?).

Should we support nbdroot=3DURI, and tie this in to Rich's proposal [1] o=
n
standardizing the set of URIs that refer to an NBD export?  It seems
like you are still limited to a TCP socket (not Unix) with no
encryption, so this would be equivalent to the URI:

nbd://[server[:port]][/export]

[1] https://lists.debian.org/nbd/2019/06/msg00011.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--GcPkFI5vKHhM5L3R0laXCr11kPXSMamS8--

--9Icx9ItsU53ORwiANl09EUUC5IOzpGhUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0CSYAACgkQp6FrSiUn
Q2rmfAf8ChmatMRfkJIY+wjmA8EpvunLFeeBfqMUiCnyHNvBwC4gnGLM+bicQbaH
daIi5U8i80IsZZ3su8d8eaBxBaFF9iy+CoRjczdUZnE1XdkDoJyA+0csp1+LiggC
0SmwnYAF9o8XRSJrhkg0xeVHwBljDbKsd1bwWzDVD6YDFERJPuGjVPYFM6sX//Qh
6fj1jDb2Y3jVg/6eiEOOzofmP5aO9aN4IGOWs5LgI7SFrk7r3gg33qlMrNk2e0sH
9d/D+8fBkuDFaoCGBk/1uBoBcLN9lkzB3MopCSMIilvavvv5+Wb1c84f+TE/0Fnm
xb7WMLpghXn8h/JLGjX503VhNmx7dw==
=Uh/K
-----END PGP SIGNATURE-----

--9Icx9ItsU53ORwiANl09EUUC5IOzpGhUD--
