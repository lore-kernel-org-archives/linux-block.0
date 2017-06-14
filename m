Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <20382261-3180-41F0-B959-9181C2FF4BAA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_92A92C74-2F92-409F-B639-77A7744B2E30";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCHSET v2] Add support for write life time hints
Date: Wed, 14 Jun 2017 17:39:32 -0600
In-Reply-To: <yq1shj2tv1z.fsf@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Martin Petersen <martin.petersen@oracle.com>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org> <yq1shj2tv1z.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_92A92C74-2F92-409F-B639-77A7744B2E30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 14, 2017, at 10:04 AM, Martin K. Petersen =
<martin.petersen@oracle.com> wrote:
> Christoph,
>=20
>> I think what Martin wants (or at least what I'd want him to want) is
>> to define a few REQ_* bits that mirror the RWF bits, use that to
>> transfer the information down the stack, and then only translate it
>> to stream ids in the driver.
>=20
> Yup. If we have enough space in the existing flags that's perfect (I
> lost count after your op/flag shuffle).

Just to clarify, does this mean that Jens' "lifetime" hints are going to
be independent of separate "stream ID" values in the future (needing a
similar, but independent, set of fields for stream IDs, or will they
both be implemented using a common transport in the kernel (i.e. both
share a single set of fields in the inode/bio/etc?

I can imagine applications using either the lifetime hints (mapped to
stream IDs internally), or explicitly managing stream IDs, but it seems
unlikely that both would be in use at the same time, unless the =
"lifetime"
hints are intended to also indirectly map to HSM-like tiered =
cache/storage
hints internally to the storage stack (e.g. whether writes should be put
into local cachefs vs remote network storage, or bcache NVRAM vs. HDD)?

Jens' patches were moving in the direction of allowing up to 16 stream =
IDs,
with the default being IDs 1-4 are intended to reflect different data
lifetimes, but allowing up to 15 unique IDs to be specified "per =
device"*
if userspace wants to manage this more explicitly.

Martin, how many stream IDs do you think are needed?  If we need too =
many,
then we wouldn't be able to pack them into the existing pwritev2() flags
and would need another new API to specify the stream IDs.

[*] more work is needed to handle this on multiple filesystems, =
MDRAID/LVM, etc.

Cheers, Andreas






--Apple-Mail=_92A92C74-2F92-409F-B639-77A7744B2E30
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQck0pIg59Q01vtYRAgfWAKDH3ZdaCsLlZ5ZP/edOkTmmCGrW2QCfbIdh
X0Of/6enzVnxypOv1pJ52hU=
=Ei9r
-----END PGP SIGNATURE-----

--Apple-Mail=_92A92C74-2F92-409F-B639-77A7744B2E30--
