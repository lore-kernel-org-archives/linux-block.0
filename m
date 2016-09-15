Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbcIOVLC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 17:11:02 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Alex Bligh <alex@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
 <f4756e27-9814-477c-2d03-e7373154c3b7@redhat.com>
 <95DD0F04-13D7-4FEB-8710-5489AA72B259@alex.org.uk>
Cc: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>,
        Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f24823d3-0fcb-20d1-90db-4072e7ddec9e@redhat.com>
Date: Thu, 15 Sep 2016 23:10:52 +0200
MIME-Version: 1.0
In-Reply-To: <95DD0F04-13D7-4FEB-8710-5489AA72B259@alex.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="29s3rUDG2i8t4jV1Np500Pb3jJKRJxltK"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--29s3rUDG2i8t4jV1Np500Pb3jJKRJxltK
Content-Type: multipart/mixed; boundary="D62wHar1deQUpGeVIlMgA5pinjn0At4pw";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alex Bligh <alex@alex.org.uk>
Cc: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>,
 Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
 Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <f24823d3-0fcb-20d1-90db-4072e7ddec9e@redhat.com>
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com>
 <f4756e27-9814-477c-2d03-e7373154c3b7@redhat.com>
 <95DD0F04-13D7-4FEB-8710-5489AA72B259@alex.org.uk>
In-Reply-To: <95DD0F04-13D7-4FEB-8710-5489AA72B259@alex.org.uk>

--D62wHar1deQUpGeVIlMgA5pinjn0At4pw
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 15/09/2016 17:23, Alex Bligh wrote:
> Paolo,
>=20
>> On 15 Sep 2016, at 15:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> I don't think QEMU forbids multiple clients to the single server, and
>> guarantees consistency as long as there is no overlap between writes a=
nd
>> reads.  These are the same guarantees you have for multiple commands o=
n
>> a single connection.
>>
>> In other words, from the POV of QEMU there's no difference whether
>> multiple commands come from one or more connections.
>=20
> This isn't really about ordering, it's about cache coherency
> and persisting things to disk.
>=20
> What you say is correct as far as it goes in terms of ordering. However=

> consider the scenario with read and writes on two channels as follows
> of the same block:
>=20
>      Channel1     Channel2
>=20
>      R                      Block read, and cached in user space in
>                             channel 1's cache
>                             Reply sent
>=20
>                   W         New value written, channel 2's cache update=
d
>                             channel 1's cache not
>=20
>      R                      Value returned from channel 1's cache.
>=20
>=20
> In the above scenario, there is a problem if the server(s) handling the=

> two channels each use a read cache which is not coherent between the
> two channels. An example would be a read-through cache on a server that=

> did fork() and shared no state between connections.

qemu-nbd does not fork(), so there is no coherency issue if W has replied=
=2E

However, if W hasn't replied, channel1 can get garbage.  Typically the
VM will be the one during writes, everyone else must be ready to handle
whatever mess the VM throws at them.

Paolo

> Similarly, if there is a write on channel 1 that has completed, and
> the flush goes to channel 2, it may not (if state is not shared) guaran=
tee
> that the write on channel 1 (which has completed) is persisted to non-v=
olatile
> media. Obviously if the 'state' is OS block cache/buffers/whatever, it
> will, but if it's (e.g.) a user-space per process write-through cache,
> it won't.
>=20
> I don't know whether qemu-nbd is likely to suffer from either of these.=


It can't happen.  On the other hand, channel1 must be ready to handle
garbage, it's illegal.





--D62wHar1deQUpGeVIlMgA5pinjn0At4pw--

--29s3rUDG2i8t4jV1Np500Pb3jJKRJxltK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2w5cAAoJEL/70l94x66DQdgH/3kzF84UHwT4R2CYqJpuxVvL
kz90PbduLg1EgS3uARGRXRD0L/c/Rr6uWKN184WpaSZldPG+HsfAEkjLg9hqo9gA
rQAg2v3+j6RtU8bQLH780jDXsleF9krhgK0n+NkTXW+pn8P5O8YVzoXXWYz28MkC
9cGPM/GeDmtFwh8DFYK4MCs93Vn4P95XR/TIgywU1H9ldR0Qkg6ebO3BahiaHrGW
ed/uZT9mUNBlo5TQYZkjoEj3X5CE0kawMA+WG9oUD0wj1Dt37ye+gyF3wVQM1/wt
T43uy6yYvBjoGYMM15udP9RwhL5/QXvK7GxdOJHHfo59hlrGozr9nPOO9MCvyMA=
=Q6oz
-----END PGP SIGNATURE-----

--29s3rUDG2i8t4jV1Np500Pb3jJKRJxltK--
