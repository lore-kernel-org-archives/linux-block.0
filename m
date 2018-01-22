Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <C6C37388-622C-451D-B14D-953EBE580995@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D4E53BD7-1EBA-4EE9-AFBB-C800AEF95E8D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
Date: Mon, 22 Jan 2018 12:10:27 -0700
In-Reply-To: <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>,
 Andi Kleen <ak@linux.intel.com>,
 linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 darrick.wong@oracle.com,
 Goldwyn Rodrigues <rgoldwyn@suse.com>
To: Jens Axboe <axboe@kernel.dk>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
 <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
 <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_D4E53BD7-1EBA-4EE9-AFBB-C800AEF95E8D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jan 20, 2018, at 8:07 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 1/20/18 7:23 PM, Goldwyn Rodrigues wrote:
>>=20
>>=20
>> On 01/20/2018 08:11 PM, Andi Kleen wrote:
>>>=20
>>> It's likely there's a lot of code in user space that does
>>>=20
>>>     if (write(..., N) < 0) handle error
>>>=20
>>> With your change it would need to be
>>>=20
>>>     if (write(..., N) !=3D N) handle error
>>>=20
>>> How much code is actually doing that?
>>>=20
>>> I can understand it fixes your artifical test suite, but it seems to =
me your
>>> change has a high potential to break a lot of existing user code
>>> in subtle ways. So it seems to be a bad idea.
>>=20
>>=20
>> Quoting 'man 2 write':
>>=20
>> RETURN VALUE
>> On  success,  the  number  of bytes written is returned (zero =
indicates
>> nothing was written).  It is not an error if  this  number  is  =
smaller
>> than the number of bytes requested; this may happen for example =
because
>> the disk device was filled.  See also NOTES.
>=20
> You can quote as much man page as you want - Andi is well aware of how
> read/write system call works, as I'm sure all of us are, that is not =
the
> issue. The issue is that there are potentially LOTS of applications =
out
> there that do not check for short writes, they do exactly what Andi
> speculated above. If you break it with this change, it doesn't matter
> what's in the man page. What matters is previous behavior, and that
> you are breaking user space. At that point nobody cares what's in the
> man page.

Applications that don't handle partial writes are already broken with
buffered I/O, this change doesn't really make them more broken.

Cheers, Andreas






--Apple-Mail=_D4E53BD7-1EBA-4EE9-AFBB-C800AEF95E8D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlpmNyMACgkQcqXauRfM
H+Cj8Q/6Ag/sHY7emobPSQSBKRhh91pCsag3lxPXfZRCGFaNHo4vwSjB5U6zlrTj
jVmocs8Jw7Rk4uphJvgj7G0BsGPll4gLsXZqgAzfoOROfmJTs+FEp8M0N2ioZ7ql
ZxQQ/yTlmAe+/7IzQFZC6GdUVHr8JIuRQszFqNcpKW9JLqJS4x+zCSpOItmtd6LI
JkT1kdLQyMhkciYoPAFjm5txM7UZklIQyNiIuelC4HBLaj464GsoR4E8qkVhgM3u
ddhF9YG7uEIC4iJgTsuv+sqp0bxFQkB0iGrUY2VpRwrP1xhrpLfYTXpe3CSlvn17
wQX8tpSsUpY1DtjxLwppUmcx7EDzH1IebWNFmg1mUKNJ2BeIRJW28jO97LGNDrHl
Cx1LQsiOAPRsKZuj9T1O98v29XKkiy4Fahbfvd/5PscKg06dj3U4Q06a42Let2v4
dBp3NJWybwgKdmlXB4QjaK6s+uowXR9WIbVhmn709eZXTXUSdAl6cehVRNkpnYJ2
Jvtoh+lVXcJ0aMdKou7Vx9kXYmoDfywVbfBK2Vx1e9OfzfBseMdR+iAEpd7rRFL9
gQaNCiynPnojQh9V7zfUrxX2vsKhxwOPmEz+uBXDsYqnmBM0TA5eyYT8DqxWbzSt
vZfSREc8PQ4+rzRyaJK+paHP4+onubdKrAROyeCnw3jYldf1jQQ=
=aNPi
-----END PGP SIGNATURE-----

--Apple-Mail=_D4E53BD7-1EBA-4EE9-AFBB-C800AEF95E8D--
