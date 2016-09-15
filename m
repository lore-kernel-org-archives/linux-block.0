Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754493AbcIOTCV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 15:02:21 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
References: <20160915120125.GA31044@infradead.org>
 <20160915122120.4h3ykbewaavjk5nx@grep.be>
 <20160915122304.GA15501@infradead.org>
 <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
 <20160915123646.GA10394@infradead.org>
 <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk>
 <20160915124103.GA20657@infradead.org>
 <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk>
 <20160915131741.cth6kilmcgnobbuu@grep.be>
 <ECDC1983-E21B-48D5-892D-63CA3572B2B4@alex.org.uk>
 <20160915162714.om3rwucexi5ogjtm@grep.be>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, mpa@pengutronix.de, kernel-team@fb.com
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a51ea56-6597-9e8f-e929-86f8e951fe09@redhat.com>
Date: Thu, 15 Sep 2016 14:02:19 -0500
MIME-Version: 1.0
In-Reply-To: <20160915162714.om3rwucexi5ogjtm@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NjGlCo2X9Oo5VJoHJMWIlNKlQNPNmUuto"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NjGlCo2X9Oo5VJoHJMWIlNKlQNPNmUuto
Content-Type: multipart/mixed; boundary="iF3MvqNiILar1a4TqMjM7GVVl7JI9AASM"
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 Christoph Hellwig <hch@infradead.org>, Josef Bacik <jbacik@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org, mpa@pengutronix.de, kernel-team@fb.com
Message-ID: <1a51ea56-6597-9e8f-e929-86f8e951fe09@redhat.com>
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
References: <20160915120125.GA31044@infradead.org>
 <20160915122120.4h3ykbewaavjk5nx@grep.be>
 <20160915122304.GA15501@infradead.org>
 <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
 <20160915123646.GA10394@infradead.org>
 <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk>
 <20160915124103.GA20657@infradead.org>
 <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk>
 <20160915131741.cth6kilmcgnobbuu@grep.be>
 <ECDC1983-E21B-48D5-892D-63CA3572B2B4@alex.org.uk>
 <20160915162714.om3rwucexi5ogjtm@grep.be>
In-Reply-To: <20160915162714.om3rwucexi5ogjtm@grep.be>

--iF3MvqNiILar1a4TqMjM7GVVl7JI9AASM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2016 11:27 AM, Wouter Verhelst wrote:
> On Thu, Sep 15, 2016 at 05:08:21PM +0100, Alex Bligh wrote:
>> Wouter,
>>
>>> The server can always refuse to allow multiple connections.
>>
>> Sure, but it would be neater to warn the client of that at negotiation=

>> stage (it would only be one flag, e.g.  'multiple connections
>> unsafe').
>=20
> I suppose that's not a bad idea.

Seems like it may need to be a per-export flag, rather than a global
flag (as a given server may be able to serve multiple types of files,
where the safety depends on the type of file being served).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iF3MvqNiILar1a4TqMjM7GVVl7JI9AASM--

--NjGlCo2X9Oo5VJoHJMWIlNKlQNPNmUuto
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJX2vA7AAoJEKeha0olJ0NqK14H/1tosW6gf8v/KJC+YYtgnIvy
tzwHV2p8r7nLqwUhu7dJjDr1F8las0Mq90YeU3NoM8LsRy9+uy6uHKUSNNfgaCNX
E/RwaRBmg0Qq7iwMB7iywLZJ+A22k1jm5SZB919q0BMMW1CvwxJkQonNrT0NbbRw
sy1UczZFMsWdulJPFPpSCXQKIJtoe9QtY9IDa/+B12z8+Ko3CyVdcQGEggivyYw8
I1LFoQu/oB/HWSdrZ/hjl2lw89cnFfdHFKOggGJpN32Mv8vh77DZWO4hFTXjaQiv
FRuiYhz+AzEva+4XaQcClHuLLCNLgEkZ9Cm8QS6QI4y/Ako/pNrlx8moXiA+tR8=
=HT2Y
-----END PGP SIGNATURE-----

--NjGlCo2X9Oo5VJoHJMWIlNKlQNPNmUuto--
