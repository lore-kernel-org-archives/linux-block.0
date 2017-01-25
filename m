Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbdAYVgW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 16:36:22 -0500
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
To: Greg KH <gregkh@linuxfoundation.org>, Alex Bligh <alex@alex.org.uk>
References: <1485182528.9861.22@smtp.office365.com>
 <20170123145212.GA19582@kroah.com> <1485183472.21123.0@smtp.office365.com>
 <20170123150325.GB26884@kroah.com> <1485186762.21123.1@smtp.office365.com>
 <20170124071152.GB13251@kroah.com> <1485352053.5902.0@smtp.office365.com>
 <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
 <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
 <5F1F69A4-CDE1-4519-9FB4-C6B1DED5BBAE@alex.org.uk>
 <20170125213004.GA6141@kroah.com>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Alex Gartrell <agartrell@fb.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68e14c2e-e96e-ff8d-bd8a-0754fb970e77@redhat.com>
Date: Wed, 25 Jan 2017 15:36:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170125213004.GA6141@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DxNVPknwHIM9IRW2Oi1fE88tNFaiNutbN"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DxNVPknwHIM9IRW2Oi1fE88tNFaiNutbN
Content-Type: multipart/mixed; boundary="3MK2kjb8e4RUQN4xloWFxAcvW9TgwFnw3";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>, Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Josef Bacik <jbacik@fb.com>,
 Jens Axboe <axboe@fb.com>, Kernel Team <Kernel-team@fb.com>,
 Alex Gartrell <agartrell@fb.com>
Message-ID: <68e14c2e-e96e-ff8d-bd8a-0754fb970e77@redhat.com>
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
References: <1485182528.9861.22@smtp.office365.com>
 <20170123145212.GA19582@kroah.com> <1485183472.21123.0@smtp.office365.com>
 <20170123150325.GB26884@kroah.com> <1485186762.21123.1@smtp.office365.com>
 <20170124071152.GB13251@kroah.com> <1485352053.5902.0@smtp.office365.com>
 <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
 <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
 <5F1F69A4-CDE1-4519-9FB4-C6B1DED5BBAE@alex.org.uk>
 <20170125213004.GA6141@kroah.com>
In-Reply-To: <20170125213004.GA6141@kroah.com>

--3MK2kjb8e4RUQN4xloWFxAcvW9TgwFnw3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2017 03:30 PM, Greg KH wrote:
>> Given (because of NBD_DO_IT) we need an ioctl anyway, and we have
>> an ioctl that isn't going to go away, it would seem better if possible=

>> to stick with ioctls, and not introduce either a dependency
>> on netlink (which would presumably bloat static binaries that
>> are used early in the boot process). Personally I'd have thought
>> adding a new NBD ioctl (or extending an existing one) would be
>> less entropy than adding a new char device.
>=20
> Why can't you just do this on any existing nbd block device with an
> ioctl to it?  No need to have to do it on an out-of-band char device
> node, right?

How do you get an fd to existing nbd block device?  Your intent is to
use an ioctl to request creating/opening a new nbd device that no one
else is using; opening an existing device in order to send that ioctl
may have negative ramifications to the actual user of that existing
device, if not permissions issues that prevent the open from even
happening.  Having a separate control fd makes it obvious that you are
asking for a new nbd device, and don't want to stomp on any existing
devices.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3MK2kjb8e4RUQN4xloWFxAcvW9TgwFnw3--

--DxNVPknwHIM9IRW2Oi1fE88tNFaiNutbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYiRpUAAoJEKeha0olJ0NqUXIH/jxLrPJ71z9Tl/xdI05ys01M
+0JIjZGDbs4PJJYrotezG2aqlHF5gjzGQtoeqGsUvRozuHS+wz6pNYPS/45+CABw
HXiotM8OYknQ0ORi9cGtbrCIaZ5PWzLQtuwKwzrfwquZtK3AotXM+lTL/oWNY/c8
4noJpIa1O3xKY0aAqlKtmRBOaFM54l9WXTElXyZ6ZvYCp1om9JZowlzSaxqWs+J+
7arGxiSsGJJwLF9SG40i8t1RQd23bBORVS4aVKTEzUVgc+QgLRwlNzik1zFl1fF9
iLDk5Vvj8NFiyA5z0emSgX0MZX8iUsOemyiKjpFgcq9TwcIRjQR7VQSnCO9h0iA=
=sLYX
-----END PGP SIGNATURE-----

--DxNVPknwHIM9IRW2Oi1fE88tNFaiNutbN--
