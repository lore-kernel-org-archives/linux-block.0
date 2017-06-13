Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <E4EBB016-5EA3-4C2C-BC63-7B8D475768AC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8A56401F-3C97-475B-BDE8-78C395842A2A";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/11] Add support for write life time hints
Date: Tue, 13 Jun 2017 14:45:46 -0600
In-Reply-To: <ee7a8e90-5df9-c1fc-e07e-5d0e62d6334c@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
 <0c6e72e1-eb9d-4748-269a-15e218d277ed@kernel.dk>
 <2A5802CF-4DA7-477E-B5AA-F31FCD7F7908@dilger.ca>
 <ee7a8e90-5df9-c1fc-e07e-5d0e62d6334c@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_8A56401F-3C97-475B-BDE8-78C395842A2A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 2:13 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 06/13/2017 01:21 PM, Andreas Dilger wrote:
>> On Jun 13, 2017, at 12:26 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>>=20
>>> On 06/13/2017 12:04 PM, Andreas Dilger wrote:
>>>> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>=20
>>>>> A new iteration of this patchset, previously known as write =
streams.
>>>>> Instead of exposing numeric values for streams, I've previously
>>>>> advocated for just doing a set of hints that makes sense instead. =
See
>>>>> the coverage from the LSFMM summit this year:
>>>>>=20
>>>>> https://lwn.net/Articles/717755/
>>>>>=20
>>>>> This patchset attempts to do that. We define 4 flags for the =
pwritev2
>>>>> system call:
>>>>>=20
>>>>> RWF_WRITE_LIFE_SHORT	Data written with this flag is expected =
to have
>>>>> 			a high overwrite rate, or life time.
>>>>>=20
>>>>> RWF_WRITE_LIFE_MEDIUM	Longer life time than SHORT
>>>>>=20
>>>>> RWF_WRITE_LIFE_LONG	Longer life time than MEDIUM
>>>>>=20
>>>>> RWF_WRITE_LIFE_EXTREME	Longer life time than LONG
>>>>>=20
>>>>> The idea is that these are relative values, so an application can
>>>>> use them as they see fit. The underlying device can then place
>>>>> data appropriately, or be free to ignore the hint. It's just a =
hint.
>>>>>=20
>>>>> Comments appreciated.
>>>>=20
>>>> I thought that one of the major attractions of numeric stream IDs =
was
>>>> that they had no semantic meanings, just "N is similar to N" and "M =
is
>>>> similar to M", and it is up to userspace to define what these mean?
>>>>=20
>>>> That allows userspace to use the IDs for lifetimes (as above), but
>>>> also/instead use them for allocation sizes, different applications,
>>>> different users, etc.
>>>=20
>>> Right, that is indeed the intent. But we have to attach some naming
>>> to them. Userspace could in theory use these totally randomly, and
>>> things like NVMe would not care. But the semantic meaning of "short"
>>> vs "long" is important on caching infrastructure where you might
>>> want to use the hint for data placement.
>>>=20
>>> I think the important part here is that no absolute meaning is
>>> attached to them, only relative.
>>=20
>> In both IOCB_WRITE_LIFE_* and RWF_WRITE_LIFE_* this is consuming 4 =
bits of
>> space (which is itself fine) for only 4 different stream IDs.  Why =
not just
>> shift a 4-bit arbitrary stream ID to the appropriate offset in those =
fields,
>> rather than treating them as 4 individual bits and allowing only one =
of
>> them to be passed down the stack at a time?
>=20
> I did think about that, and I'm a bit split on it. It turns a bit mask
> into a hybrid beast, with bits and sets of bits for values.

I don't think that is too confusing for anyone.

> For utilization of the space, yes, we could just use 2 bits instead of
> the 4. Or use the 4 bits and potentially have the app pass in up to 16
> values. For the latter, I'm still very much in favor of keeping the =
app
> interface super simple and just retaining the 4 life time types.

I don't think anyone cares too much about 4 bits.  Strictly speaking,
the current implementation can't fit into 2 bits because it has 5 values
if one includes "no ID".

It is a bit of overhead to use 32 bits in most of the structs where this
field is actually stored.  I suspect that using only 8 or 16 bits in the
structs is better, and even if it doesn't find an existing hole =
("pahole"
is your friend here) it will allow something else to use the remaining
space in the future.

For userspace, I think it is fine to define the WRITE_LIFE values as =
they
are today, and most users will use them, but IMHO it makes sense to
allow arbitrary IDs as they see fit, especially if the underlying =
hardware
doesn't care much about the actual values.

> If folks feel strongly about the wasted space, and I can definitely
> revisit and just pack it.

Cheers, Andreas






--Apple-Mail=_8A56401F-3C97-475B-BDE8-78C395842A2A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQE76pIg59Q01vtYRAumXAKDdvotCeXHCC1jvya8wba6zu+w8mgCeONUc
ZxWzRe9HSs9Vr84i4HBgE3E=
=Yd6I
-----END PGP SIGNATURE-----

--Apple-Mail=_8A56401F-3C97-475B-BDE8-78C395842A2A--
