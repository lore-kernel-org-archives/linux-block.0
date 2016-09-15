Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:48974 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbcIOPXv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 11:23:51 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_0CE677D8-17DB-4038-93B5-6F82A6D615F1"; protocol="application/pgp-signature"; micalg=pgp-sha512
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <f4756e27-9814-477c-2d03-e7373154c3b7@redhat.com>
Date: Thu, 15 Sep 2016 16:23:48 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Eric Blake <eblake@redhat.com>,
        Wouter Verhelst <w@uter.be>, Josef Bacik <jbacik@fb.com>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <95DD0F04-13D7-4FEB-8710-5489AA72B259@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk> <8dd28f8b-0a3c-4112-ca6d-a9ad080d5920@redhat.com> <f4756e27-9814-477c-2d03-e7373154c3b7@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_0CE677D8-17DB-4038-93B5-6F82A6D615F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Paolo,

> On 15 Sep 2016, at 15:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> I don't think QEMU forbids multiple clients to the single server, and
> guarantees consistency as long as there is no overlap between writes =
and
> reads.  These are the same guarantees you have for multiple commands =
on
> a single connection.
>=20
> In other words, from the POV of QEMU there's no difference whether
> multiple commands come from one or more connections.

This isn't really about ordering, it's about cache coherency
and persisting things to disk.

What you say is correct as far as it goes in terms of ordering. However
consider the scenario with read and writes on two channels as follows
of the same block:

     Channel1     Channel2

     R                      Block read, and cached in user space in
                            channel 1's cache
                            Reply sent

                  W         New value written, channel 2's cache updated
                            channel 1's cache not

     R                      Value returned from channel 1's cache.


In the above scenario, there is a problem if the server(s) handling the
two channels each use a read cache which is not coherent between the
two channels. An example would be a read-through cache on a server that
did fork() and shared no state between connections.

Similarly, if there is a write on channel 1 that has completed, and
the flush goes to channel 2, it may not (if state is not shared) =
guarantee
that the write on channel 1 (which has completed) is persisted to =
non-volatile
media. Obviously if the 'state' is OS block cache/buffers/whatever, it
will, but if it's (e.g.) a user-space per process write-through cache,
it won't.

I don't know whether qemu-nbd is likely to suffer from either of these.

--
Alex Bligh





--Apple-Mail=_0CE677D8-17DB-4038-93B5-6F82A6D615F1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJX2r0FAAoJEBPm5K7i9iORO1kP/1RTZBBY7FfY6QzQ962DXEV5
GVRjx1U51Jc98jRtq1S+3fhkcSOp4pDicg1x6UIXRM8My/zPBQMIOI6nsqO1kyq0
2UX09Blokz+HSZfM9LYpyrsBxn+d6oE50fQncgkRVXUP1zvzczPHDxr8k4+b/Faa
ZID2qRsBZecjDeAakuOFdm9tWbRin9FG9H+QjbZn/n57Ste3OmEwRaNlOnBuXDqB
NUAgKi3p2M2FjWlqcO0u8zqzbUT/5bZrFOk63RVyIf4HAGkF6ERIJB3MSTG1KrIk
uhhv+GvS8p8AZ1OiaiElHYyB7rg348d4PrKakq8zyM4Sw303KtB2gKct+axVzK+a
Mhhe/1qouXlRAjB9IUeVOqRmcXbCa1rVjwPIPQVmgTWzhxFddNpQdbnEHoy7Lcki
MQbyfT4IEOeyiWoN2CL3FAFpa7F6vfzL7O6cjXcLlXXrtzi+07uk4xgnbaIHcfrp
CWccLxYF97o+SDgFA/sR8QYIK7BWpdHOyQfvmIirN6gnsA7DQRk+Y+m9j8s+vs7E
KzzG/fQs5hI+M3f7Qpdlirlowe2cAAAgv/PYbDPnuUwCAFY2qeosgHyRk3LvCjRb
Bg5R9K3+jl6a6TPI8FpDv1fGnqFZ/Zd+7jS7sz7U23IGb/vBDZ52uYFPCWRE7Zw8
8/mwTAy9xDR/tOdRbMwo
=pz9X
-----END PGP SIGNATURE-----

--Apple-Mail=_0CE677D8-17DB-4038-93B5-6F82A6D615F1--
