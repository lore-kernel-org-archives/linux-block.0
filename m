Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbcIONe1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 09:34:27 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        Josef Bacik <jbacik@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
Cc: linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
Date: Thu, 15 Sep 2016 08:34:25 -0500
MIME-Version: 1.0
In-Reply-To: <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LPBQlvvUDaBDq7CDfrQGBCXuijh1w8QnJ"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LPBQlvvUDaBDq7CDfrQGBCXuijh1w8QnJ
Content-Type: multipart/mixed; boundary="EaROG2g7QABeRXjGiGJ7dWgaOP7WHss81"
From: Eric Blake <eblake@redhat.com>
To: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
 Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
 kernel-team@fb.com,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
In-Reply-To: <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>

--EaROG2g7QABeRXjGiGJ7dWgaOP7WHss81
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2016 06:09 AM, Alex Bligh wrote:
>=20
> I also wonder whether any servers that can do caching per
> connection will always share a consistent cache between=20
> connections. The one I'm worried about in particular here
> is qemu-nbd - Eric Blake CC'd.
>=20

I doubt that qemu-nbd would ever want to support the situation with more
than one client connection writing to the same image at the same time;
the implications of sorting out data consistency between multiple
writers is rather complex and not worth coding into qemu.  So I think
qemu would probably prefer to just prohibit the multiple writer
situation.  And while multiple readers with no writer should be fine,
I'm not even sure if multiple readers plus one writer can always be made
to appear sane (if there is no coordination between the different
connections, on an image where the writer changes AA to BA then flushes
then changes to BB, it is still feasible that a reader could see AB
(pre-flush state of the first sector, post-flush changes to the second
sector, even though the writer never flushed that particular content to
disk).

But Paolo Bonzini (cc'd) may have more insight on qemu's NBD server and
what it supports (or forbids) in the way of multiple clients to a single
server.

> A more general point is that with multiple queues requests
> may be processed in a different order even by those servers that
> currently process the requests in strict order, or in something
> similar to strict order. The server is permitted by the spec
> (save as mandated by NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA) to
> process commands out of order anyway, but I suspect this has
> to date been little tested.

qemu-nbd is definitely capable of serving reads and writes out-of-order
to a single connection client; but that's different than the case with
multiple connections.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--EaROG2g7QABeRXjGiGJ7dWgaOP7WHss81--

--LPBQlvvUDaBDq7CDfrQGBCXuijh1w8QnJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJX2qNhAAoJEKeha0olJ0Nq+z8H/3is8nLRyrv66YivNs5JGsdG
oZbvVuoG65AcYUk8meQ2ktUWtrs/qCxRPRfaZ4xA+IFcDz+giJ0+joHRCTaw7whV
XhfQAthLTXt5nCUEuzvUzxHT3h4Eq0HDPm9ZYMyjxFDfvbZgJhijaB+yfSC4fskJ
JpDCDwtDnoZqIhaCQPp3LZulHisuVe5T3K7xJYs/qlag5uUKkfpQVRAnOZuudeYI
67dQy5W8vS2YZT8wm1fRRdBF6YddXvTvQQy2APiI9QOBHVL3jJu2XgxHf0lE6YnC
rZFyZMSebm4vvrCy0csnQwRlNf/UCJrNsvy+V+09vUqU2yfhp3wrpwlIYyH9l4Q=
=3DIn
-----END PGP SIGNATURE-----

--LPBQlvvUDaBDq7CDfrQGBCXuijh1w8QnJ--
