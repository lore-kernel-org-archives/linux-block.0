Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F8C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CA220449
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfFMPOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:14:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbfFMPOp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 11:14:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5352B3058838;
        Thu, 13 Jun 2019 15:14:33 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 164D67C593;
        Thu, 13 Jun 2019 15:14:28 +0000 (UTC)
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     Roman Stratiienko <roman.stratiienko@globallogic.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
 <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
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
Message-ID: <adc59944-7654-ea38-8dfc-f91361a80987@redhat.com>
Date:   Thu, 13 Jun 2019 10:14:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eee2xFe75vs2A2ScnCuVGakVCSApzTrMR"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Jun 2019 15:14:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eee2xFe75vs2A2ScnCuVGakVCSApzTrMR
Content-Type: multipart/mixed; boundary="5N8QQ9ksT8qW138LJWwnZPp8pi4LDryqo";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Roman Stratiienko <roman.stratiienko@globallogic.com>,
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, nbd@other.debian.org,
 Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
 linux-block@vger.kernel.org, axboe@kernel.dkn.org
Message-ID: <adc59944-7654-ea38-8dfc-f91361a80987@redhat.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
 <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
In-Reply-To: <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>

--5N8QQ9ksT8qW138LJWwnZPp8pi4LDryqo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/13/19 9:45 AM, Roman Stratiienko wrote:

>>
>> Just throw nbd-client in your initramfs.  Every nbd server has it's ow=
n
>> handshake protocol, embedding one particular servers handshake protoco=
l into the
>> kernel isn't the answer here.  Thanks,

The handshake protocol is well-specified:
https://github.com/NetworkBlockDevice/nbd/blob/cdb0bc57f3faefd7a5562d57ad=
57cd990781c415/doc/proto.md

All servers implement various subsets of that document for the handshake.=


> Also, as far as I know mainline nbd-server daemon have only 2
> handshake protocols. So called OLD-STYLE and NEW-STYLE. And OLD-STYLE
> is no longer supported. So it should not be a problem, or please fix
> me if I'm wrong.

You are correct that oldstyle is no longer recommended. However, the
current NBD specification states that newstyle has two different
flavors, NBD_OPT_EXPORT_NAME (which you used, but is also old) and
NBD_OPT_GO (which is newer, but is more likely to encounter differences
where not all servers support it).

The NBD specification includes a compatibility baseline:
https://github.com/NetworkBlockDevice/nbd/blob/cdb0bc57f3faefd7a5562d57ad=
57cd990781c415/doc/proto.md#compatibility-and-interoperability

and right now, NBD_OPT_GO (and _not_ NBD_OPT_EXPORT_NAME) is the
preferred way forward.  As long as your handshake implementation
complies with the baseline documented there, you'll have maximum
portability to the largest number of servers that also support the
baseline - but not all servers are up to that baseline yet.

So, this becomes a question of how much are you reinventing baseline
portability handshake concerns in the kernel, vs. in initramfs.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5N8QQ9ksT8qW138LJWwnZPp8pi4LDryqo--

--eee2xFe75vs2A2ScnCuVGakVCSApzTrMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0CaFQACgkQp6FrSiUn
Q2pm7gf/YgMHlLWD2BT2imqW/yN9a1Es25xRJvErM5AHt6pMGxP8Wfe3mvHi2hLk
H9UeSdcbgVqMp5ODGh63j4DGB3ag499E+NBJUGIcAm1TZi3GE+/qHcTaN4i9Deb5
sNT0DLoqMikKYZu+N7t4uOckPSdxiMA52ReLVGwoUusZ+Oxb+kVHnukxEjUqUE4N
gbNVJwS+sFEyjcIXyvb8LxhCzkfoUEEN48hPI7ZfjEkWa//uQ7iRBia6vqlUU0pW
Am1QEbFENHSu8VqYpIzUKisNOIbVaXqFZ89Md7CDABJdyEyw3oGn+iO/dn4Q3N7L
+wJFmB5X9rfYco3X6NQOy/eGDQInuQ==
=G4i4
-----END PGP SIGNATURE-----

--eee2xFe75vs2A2ScnCuVGakVCSApzTrMR--
