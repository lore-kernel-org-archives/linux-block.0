Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934171AbcIOOIJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 10:08:09 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Eric Blake <eblake@redhat.com>, Alex Bligh <alex@alex.org.uk>,
        Wouter Verhelst <w@uter.be>, Josef Bacik <jbacik@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
Cc: linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4756e27-9814-477c-2d03-e7373154c3b7@redhat.com>
Date: Thu, 15 Sep 2016 16:07:54 +0200
MIME-Version: 1.0
In-Reply-To: <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4FHCt7GDgNSjApphcH50D1MAse9DfrJ9V"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4FHCt7GDgNSjApphcH50D1MAse9DfrJ9V
Content-Type: multipart/mixed; boundary="RTloq5xUGAeDHeQsHCk68u2trL1mfauWL";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Alex Bligh <alex@alex.org.uk>,
 Wouter Verhelst <w@uter.be>, Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
 kernel-team@fb.com,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <f4756e27-9814-477c-2d03-e7373154c3b7@redhat.com>
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
In-Reply-To: <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>

--RTloq5xUGAeDHeQsHCk68u2trL1mfauWL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/09/2016 15:34, Eric Blake wrote:
> On 09/15/2016 06:09 AM, Alex Bligh wrote:
>>
>> I also wonder whether any servers that can do caching per
>> connection will always share a consistent cache between=20
>> connections. The one I'm worried about in particular here
>> is qemu-nbd - Eric Blake CC'd.
>>
>=20
> I doubt that qemu-nbd would ever want to support the situation with mor=
e
> than one client connection writing to the same image at the same time;
> the implications of sorting out data consistency between multiple
> writers is rather complex and not worth coding into qemu.  So I think
> qemu would probably prefer to just prohibit the multiple writer
> situation.  And while multiple readers with no writer should be fine,
> I'm not even sure if multiple readers plus one writer can always be mad=
e
> to appear sane (if there is no coordination between the different
> connections, on an image where the writer changes AA to BA then flushes=

> then changes to BB, it is still feasible that a reader could see AB
> (pre-flush state of the first sector, post-flush changes to the second
> sector, even though the writer never flushed that particular content to=

> disk).
>=20
> But Paolo Bonzini (cc'd) may have more insight on qemu's NBD server and=

> what it supports (or forbids) in the way of multiple clients to a singl=
e
> server.

I don't think QEMU forbids multiple clients to the single server, and
guarantees consistency as long as there is no overlap between writes and
reads.  These are the same guarantees you have for multiple commands on
a single connection.

In other words, from the POV of QEMU there's no difference whether
multiple commands come from one or more connections.

Paolo

>> A more general point is that with multiple queues requests
>> may be processed in a different order even by those servers that
>> currently process the requests in strict order, or in something
>> similar to strict order. The server is permitted by the spec
>> (save as mandated by NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA) to
>> process commands out of order anyway, but I suspect this has
>> to date been little tested.
>=20
> qemu-nbd is definitely capable of serving reads and writes out-of-order=

> to a single connection client; but that's different than the case with
> multiple connections.
>=20


--RTloq5xUGAeDHeQsHCk68u2trL1mfauWL--

--4FHCt7GDgNSjApphcH50D1MAse9DfrJ9V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2qs/AAoJEL/70l94x66DZqYIAIht6TgcoSaZfQXWM2fYv2kc
0lxbS4+detutAwkcgMh3hWUUY5WDLCQDuCHRbF6WubXU9SwdzWNEZeUnjKY60Y2V
VclfxrMiUwyvhYVLTV+oJDcXzNSyXh80o3rpcb9e+zBVofIs7IlQJtkzLo6/7Bqp
tHMQjKtS4lSDz4pI213/VD4DUS3kpJ7zsCwQULSu+QDs+vWLbeWPXJaB3IQ1OOSl
kPpcG8Xs+HIqJfUHFxnTWO6M7yIbP93zvW6Z5e1aiPjhHdSqRSUHRVApGY3iLYSm
PJuq1rK9D+qLWY6qdQ6SbZV+U/WdZxxrXtWSkvXK9QvDRSZIuqw2FzwKG9VkLA0=
=vRxL
-----END PGP SIGNATURE-----

--4FHCt7GDgNSjApphcH50D1MAse9DfrJ9V--
