Return-Path: <linux-block-owner@vger.kernel.org>
Received: from h19-45-4-185.rev.hosting.nbs-system.com ([185.4.45.19]:19901
        "EHLO owa.groupeot.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934668AbdGTP5l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2017 11:57:41 -0400
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
To: Keith Busch <keith.busch@intel.com>
References: <5554bd39-6e0a-5c17-2b64-bb80d4a6502b@nbs-system.com>
 <CAKdd5H9f_=NCYMmhLcvHKFw7m_sKvygSVqz3+Z0YPAGiPMxKxQ@mail.gmail.com>
 <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
 <20170720153346.GC1202@localhost.localdomain>
CC: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        <xen-users@lists.xen.org>, WebDawg <webdawg@gmail.com>,
        <linux-block@vger.kernel.org>
From: Benoit Depail <benoit.depail@nbs-system.com>
Message-ID: <0c158c47-fa56-68a6-1517-12700afee2c3@nbs-system.com>
Date: Thu, 20 Jul 2017 17:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170720153346.GC1202@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature";
        boundary="U8BF5ASnTK2sfaWIrQncI2adnT321PP3v"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--U8BF5ASnTK2sfaWIrQncI2adnT321PP3v
Content-Type: multipart/mixed; boundary="megDROqMSuNqUKNkrwQdKn7rLgSuCURbj";
 protected-headers="v1"
From: Benoit Depail <benoit.depail@nbs-system.com>
To: Keith Busch <keith.busch@intel.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 xen-users@lists.xen.org, WebDawg <webdawg@gmail.com>,
 linux-block@vger.kernel.org
Message-ID: <0c158c47-fa56-68a6-1517-12700afee2c3@nbs-system.com>
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
References: <5554bd39-6e0a-5c17-2b64-bb80d4a6502b@nbs-system.com>
 <CAKdd5H9f_=NCYMmhLcvHKFw7m_sKvygSVqz3+Z0YPAGiPMxKxQ@mail.gmail.com>
 <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
 <20170720153346.GC1202@localhost.localdomain>
In-Reply-To: <20170720153346.GC1202@localhost.localdomain>

--megDROqMSuNqUKNkrwQdKn7rLgSuCURbj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/20/17 17:33, Keith Busch wrote:
> On Thu, Jul 20, 2017 at 05:12:33PM +0200, Benoit Depail wrote:
>>
>> The main issue we are seeing is degraded write performance on storage
>> devices of Xen PV DomUs, about half (or even a third on our production=

>> setup where NFS is involved) of what we used to have.
>=20
> Read performance is unchanged?
>=20

Read performance is unaffected indeed.

--=20
Benoit Depail
Senior Infrastructures Architect
NBS System


--megDROqMSuNqUKNkrwQdKn7rLgSuCURbj--

--U8BF5ASnTK2sfaWIrQncI2adnT321PP3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKxBAEBCgCbFiEEUVI4Zy9ojyLG8rQSok/WASnIOwQFAllw0udfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDUx
NTIzODY3MkY2ODhGMjJDNkYyQjQxMkEyNEZENjAxMjlDODNCMDQdHGJlbm9pdC5k
ZXBhaWxAbmJzLXN5c3RlbS5jb20ACgkQok/WASnIOwR5PRAAhkKRMhxz321ZZ6q9
8Iu9/nIsMcy5SqgquCerN8U+ir5TwCbXQxVZih5Z2Xn553wcnKyiqaoJw6iqjv/m
gUJJTah8Zshe6Ptas/Xfcx31vtIqNQYs6RjYv3HdfAYxFQxAFxjGg9B5oMi6Fjbi
2fYTefZPIqCpnZ3n2PdxkPKq5dTTx62qiGZ9hA6+RhBHRKzMh5KeRTVqmHooJmXh
wIo9hL8S+wnt1RXbEbAxo8quxybDkHRjZtPgqEexC1j5bjWzJOTIfYq2EkCjXbb9
uYTNUXuiAdMash74tVGSn8FyMsFjaTMiMOVHEOsHBjfbvN5WED7FfE0OOYvSeTyt
pl4wrAfZJiKIjYut7286arIhpxwyNdh3Ulx6TkKxsoWkK1wc7bujfcUJl/K/m57j
RJUhDYGT0YlkFWyNg7booOaTvHgPcfIanCuDELxMeElVYBClTTY3yXYBoK2eqaBp
eNi4fb3a2K8GgFt3GgmNTu9q4e9Piro5RhUMlwff2+wleyHc3ihuH1J1eXaMddKV
JKLsWNjerCIyQG9nIh4J1Vz3kz/rZz65QaCHiHeiQ04EURelEkHLf1QiKyD6Jzd3
toqtKegLGaJumn6wgNerrawltqoLrFF81EyZ7LtQNRNFWwrwKdymE8d0LjkksllR
+wO9IlR4ik0XxJcy8LLM4E2LRpw=
=2fhz
-----END PGP SIGNATURE-----

--U8BF5ASnTK2sfaWIrQncI2adnT321PP3v--
