Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:53430 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbcIOPZO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 11:25:14 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_57A0BD0F-1162-4E60-A11A-9FA1634DE77E"; protocol="application/pgp-signature"; micalg=pgp-sha512
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
Date: Thu, 15 Sep 2016 16:25:12 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <2DFDFFC6-F682-4127-8684-76CB7AF43494@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk> <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
To: Eric Blake <eblake@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_57A0BD0F-1162-4E60-A11A-9FA1634DE77E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Eric,

> I doubt that qemu-nbd would ever want to support the situation with more
> than one client connection writing to the same image at the same time;
> the implications of sorting out data consistency between multiple
> writers is rather complex and not worth coding into qemu.  So I think
> qemu would probably prefer to just prohibit the multiple writer
> situation.

Yeah, I was thinking about a 'no multiple connection' flag.

>  And while multiple readers with no writer should be fine,
> I'm not even sure if multiple readers plus one writer can always be made
> to appear sane (if there is no coordination between the different
> connections, on an image where the writer changes AA to BA then flushes
> then changes to BB, it is still feasible that a reader could see AB
> (pre-flush state of the first sector, post-flush changes to the second
> sector, even though the writer never flushed that particular content to
> disk).

Agree

--
Alex Bligh





--Apple-Mail=_57A0BD0F-1162-4E60-A11A-9FA1634DE77E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJX2r1YAAoJEBPm5K7i9iORlaEP/iZS+5oqbOPZftPV4eKNPfBr
WDx4QUtsfXeygRY3TMm0ipNJ98v08zRYl6grWtxOJLkSteYj838wy71ACQFWAyBG
ZseTvxhw3bkl/+DHHu08tVxhUqiHi3iCHKUuOyT+Na3Bi2dpyNN+KM35+gLo6GpI
4FQFgf4jBRIa5lmRv7/auEKPcJ8fGewaVjj7kD2b+X0xJ0wXUUdwsrnJ90hhIgqQ
rlifGsAmbxM2qeLgujRCC3id5q0yixtYpJE7PbJRVqJNVoetirPG/T9Ded9AVb2q
KY9HyW1o1u773DVbLXLcHK1A/IVY2bVk29uhgfh/a2rsycnaNxLNJFm2+Xspc5tN
P7oiJ/Ywi+g57jmQX6S+n3PjPrkRgMxJhhlWwt36v8OxgCXPhf1bxo8NdzI0bzx5
En74/1C+fFBWFCleeruc+HeX/5+mRN4Qvae1xusIQca/wol7qsX9VQ7DEYJubtk6
f9+ixN9Y7NhAAhyjU5V3UqvjOIDrQZKGP4KztQVxxEfD1vZ4nRn+NoUylS/Evk1+
VUvMWaDuvoFcvjXjxbcqjYmwDBAEjZGRx+BvxN/An6XdLtfxrn8O9vwmddTO2JgA
nqnlPbz9HiF8wNe1bqfDizGX/HLbDpZwOgtJge3Hol8aMeBvsipGv1I8OTzllPUq
uEX9mnje2RNC9EAfmPa1
=ZpeU
-----END PGP SIGNATURE-----

--Apple-Mail=_57A0BD0F-1162-4E60-A11A-9FA1634DE77E--
