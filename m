Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <7A67BC5A-021E-4D9B-8BCB-9FBA8E2670EE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_954A5741-9F1E-4BB8-BD5B-1C66080042EA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
Date: Tue, 23 Jan 2018 17:19:49 -0700
In-Reply-To: <38e72c8a-c178-7930-3858-83d860e568a2@kernel.dk>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>,
 Goldwyn Rodrigues <rgoldwyn@suse.com>,
 Andi Kleen <ak@linux.intel.com>,
 linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 darrick.wong@oracle.com
To: Jens Axboe <axboe@kernel.dk>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
 <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
 <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
 <C6C37388-622C-451D-B14D-953EBE580995@dilger.ca>
 <175784d7-70e7-3be1-47f0-ae67ab37e921@kernel.dk>
 <2b11e24d-d09c-f7c4-db6d-6ecc1ce40719@suse.de>
 <38e72c8a-c178-7930-3858-83d860e568a2@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_954A5741-9F1E-4BB8-BD5B-1C66080042EA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 22, 2018, at 8:28 PM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> On 1/22/18 8:18 PM, Goldwyn Rodrigues wrote:
>>> that their application was "already broken". I'd hate for a kernel
>>> upgrade to break them.
>>> 
>>> I do wish we could make the change, and maybe we can. But it probably
>>> needs some safe guard proc entry to toggle the behavior, something we
>>> can drop in a few years when we're confident it won't break real
>>> applications.
>> 
>> Assuming we call it /proc/sys/fs/dio_short_writes(better names/paths?),
>> should it be enabled or disabled by default?
> 
> I'd enable it by default, if not, you are never going to be able to
> remove it because you'll have no confidence that anyone actually flipped
> the switch and ran with it enabled. The point of having it there and on
> by default would be that if something does break, people have the option
> of turning it off and restoring the previous behavior, without having to
> change the kernel.

... or fixing their application. :-)

But, yes, I agree that this should be on by default.

Cheers, Andreas






--Apple-Mail=_954A5741-9F1E-4BB8-BD5B-1C66080042EA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlpn0SUACgkQcqXauRfM
H+Bijg//QI7ccBae2uO9yHcZrtrPp/zihC9+vEU5312QgA9ZxA0oY49BjkvAbSxc
Euekbcl9lQpr9e9B0YqSNjOWKZ7Qo5em6Ns2/QBpEGOsiTeTfI24ttYnfFtP9KoK
T2b5Omcwrn/FXEwY5GaVu0arS7U3DECV93J6Mx27MFN43a9GOPn0ObZSEkZ0G12X
/ivFkxIPvOHkR/VhPH/V2CgverCSNMODl9r5HTtl7UvNrcM/BZPzfrK/DlPVfrpp
7cEPqW3LeOpQClMUrHNIGmwqvbvBXXd33f7TfDHus0x8kblQr4Vgk6qEL+bMsq2K
NTkRzJYUS65asTyTUgDVKAv2VOr/AR0oebYFirYj+aK7LwlyFjR6isZlE30F8pjr
pZiRoLG0/FnZh+fP2dLIlLCLcsYo3pOD+w2Wy8RFtyVkJxpUw/VahTF9pxDoNRCr
2UWRuRJbjeP+oj5NFrLWaBbd0j89zXUXrwRgTHps5q8Gxa8Z3UxIHBElL/Ieoemp
8+VAGOKKzTJMiH3ZIdIVQDwPmmdWLyeb5sN2TuVv9GrU8jcVXweQBE1q1DugSauL
y3CKvC2Rv7jphplPGqLVwwwBEwmhtDrcsRLg5x6/kYvVen42HsbceW9f3P/vug2E
DfWUKug6WYbpFnMQasrPyqB87bwjST3VsvUp4em/OvJ3YOIuXC4=
=JFwX
-----END PGP SIGNATURE-----

--Apple-Mail=_954A5741-9F1E-4BB8-BD5B-1C66080042EA--
