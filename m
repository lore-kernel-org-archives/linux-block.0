Return-Path: <linux-block-owner@vger.kernel.org>
Received: from h19-45-4-185.rev.hosting.nbs-system.com ([185.4.45.19]:30315
        "EHLO owa.groupeot.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935913AbdGTP1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2017 11:27:55 -0400
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <5554bd39-6e0a-5c17-2b64-bb80d4a6502b@nbs-system.com>
 <CAKdd5H9f_=NCYMmhLcvHKFw7m_sKvygSVqz3+Z0YPAGiPMxKxQ@mail.gmail.com>
 <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
CC: <xen-users@lists.xen.org>, WebDawg <webdawg@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        <linux-block@vger.kernel.org>
From: Benoit Depail <benoit.depail@nbs-system.com>
Message-ID: <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
Date: Thu, 20 Jul 2017 17:12:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature";
        boundary="IHo6VxuXMdapckbGbxvwbJF5Pqw4PIc9I"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--IHo6VxuXMdapckbGbxvwbJF5Pqw4PIc9I
Content-Type: multipart/mixed; boundary="eNoXXtqi4Sd2ngDNpVQFsTREUHLusNLJG";
 protected-headers="v1"
From: Benoit Depail <benoit.depail@nbs-system.com>
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: xen-users@lists.xen.org, WebDawg <webdawg@gmail.com>,
 Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
Message-ID: <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
References: <5554bd39-6e0a-5c17-2b64-bb80d4a6502b@nbs-system.com>
 <CAKdd5H9f_=NCYMmhLcvHKFw7m_sKvygSVqz3+Z0YPAGiPMxKxQ@mail.gmail.com>
 <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
In-Reply-To: <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>

--eNoXXtqi4Sd2ngDNpVQFsTREUHLusNLJG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/20/17 10:52, Roger Pau Monn=E9 wrote:
> For the sake of the people that I've added, would you mind describing
> the issues you are seeing and the tests that you performed?
>=20
> Thanks, Roger.
>=20

Sure.

The main issue we are seeing is degraded write performance on storage
devices of Xen PV DomUs, about half (or even a third on our production
setup where NFS is involved) of what we used to have.

Our test setup is as follow (we left the NFS out as it has nothing to do
with our problem):

On a physical server running debian stretch as a Xen 4.8 hypervisor, we
create a PV domU, also running debian stretch. The storage of this domU
resides on the server's local disk as raw image files, which will be
setup as loop-devices before being exposed to the domU as /dev/xvd{a,b}.

the domU configuration (relevant part):

disk        =3D [
   'file:/mnt/domu_root.img,xvda,w',
   'file:/mnt/d-anb-nab2.img,xvdb,w'
]


When the domU is running, a loop-device is created:

/dev/loop1: [65027]:12 (/mnt/d-anb-nab2.img)

We perform a simple dd to test the sequential writing speed:

##### Dom0 with a kernel < 4.4.2 (here, 4.1.42, we had similar results
with 3.16.0)

# dd if=3D/dev/zero of=3D/mnt/d-anb-nab2.img bs=3D4M count=3D1280
1280+0 records in
1280+0 records out
5368709120 bytes (5.4 GB) copied, 47.5052 s, 113 MB/s

# dd if=3D/dev/zero of=3D/dev/loop1 bs=3D4M count=3D1280
1280+0 records in
1280+0 records out
5368709120 bytes (5.4 GB) copied, 46.8227 s, 115 MB/s

On the domU:
# dd if=3D/dev/zero of=3D/dev/xvdb bs=3D4M count=3D1280
1280+0 records in
1280+0 records out
5368709120 bytes (5.4 GB) copied, 46.7245 s, 115 MB/s


##### Dom0 with a kernel >=3D 4.4.2, or a custom 4.4.1 including commit
d2081cfe624b5decaaf68088ca256ed1b140672c

On the dom0:
# dd if=3D/dev/zero of=3D/mnt/d-anb-nab2.img bs=3D4M count=3D1280
1280+0 records in
1280+0 records out
5368709120 bytes (5.4 GB) copied, 46.3234 s, 116 MB/s

# dd if=3D/dev/zero of=3D/dev/loop1 bs=3D4M count=3D1280
1280+0 records in
1280+0 records out
5368709120 bytes (5.4 GB) copied, 44.948 s, 119 MB/s

On the domU:
# dd if=3D/dev/zero of=3D/dev/xvdb bs=3D4M count=3D1280
1280+0 records in
1280+0 records out
5368709120 bytes (5.4 GB) copied, 102.943 s, 52.2 MB/s


For completeness sake, I'll put my findings below:

> I used git bisect on the linux-stable source tree to build (a lot of)
> tests kernels, and was able to find this commit as the first one
> introducing the regression :
>
> d2081cfe624b5decaaf68088ca256ed1b140672c is the first bad commit
> commit d2081cfe624b5decaaf68088ca256ed1b140672c
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Tue Jan 12 15:08:39 2016 -0700
>
>     block: split bios to max possible length
>
> In term of kernel version, the first one showing bad performances in my=

> case is 4.4.2 (with, obviously, 4.4.1 working as expected).
>
> Interestingly, this commit is an improvement of
> d3805611130af9b911e908af9f67a3f64f4f0914, which is present in 4.4-rc8
> but do not show any performance issue in our case.
>
> I can also confirm that this issue is still present in the latest
> unstable kernel (we tested 4.13-rc1).


Thanks,

--=20
Benoit Depail
Senior Infrastructures Architect
NBS System


--eNoXXtqi4Sd2ngDNpVQFsTREUHLusNLJG--

--IHo6VxuXMdapckbGbxvwbJF5Pqw4PIc9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKxBAEBCgCbFiEEUVI4Zy9ojyLG8rQSok/WASnIOwQFAllwyGJfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDUx
NTIzODY3MkY2ODhGMjJDNkYyQjQxMkEyNEZENjAxMjlDODNCMDQdHGJlbm9pdC5k
ZXBhaWxAbmJzLXN5c3RlbS5jb20ACgkQok/WASnIOwQUdA/+KpeMIl9ucG2MzQJ3
j0EXjkLCrrGdPYpoGt4Wmptnbnvme+leFlPMtFALRnkiv1+D+N1RPEmn6h9tRlxv
YiugT6cvjEorpLU8QOcUtagbhRvjKXnSjynzZFAgbcBTua5fsyD9GkCYAzMe3mak
dRN7fcS6yi+p78IPFjqGFaIJ2pM+j5K5mqcK9ziMjuO/85CHFGWw3NvT0et38c02
X0lY85aoEucS8EriK6+wYMyDhjdvDnb6kV3KVqX9sJnKA0f8uEonQNZUESuMUkER
vW4DS0QjPMJEhPY0aQJ51XJz4ExKOpH8X0tq/D0nPhwCOFSRmA5z1PxlYb0F9Cxl
d89liSrvvRVleuK74+SmhVoZIRxw4nNeCKfLXVfIevDOyCcekvJb5NUMaln4F483
UPq803FpmstqiTjGj4sS8jxhfDZJPa+8QRr2N1n0bC9dgVLiQgwAdn/s8M+DQ9Zq
wJzDqD1c04lYZpR/d2y4bzbTm0iHo3qE2GTN/c1hm6g1DzT51zjzm/0oH9eU5caw
1PzTIP3B/WJjo6s5k5WYjWQcB9dByhTJmgm2Olq8Jb+L9h4rZf5k24uJHO9ksJpK
doFTgvnNPk6Ns1CozMKSHHyY6RmfNDTx6JuCWqqqrLWH5MfVal35Pfc/iXwPmv9/
x2i0ZA+BLT2zvJ6BSM46xu+nWhs=
=amIp
-----END PGP SIGNATURE-----

--IHo6VxuXMdapckbGbxvwbJF5Pqw4PIc9I--
