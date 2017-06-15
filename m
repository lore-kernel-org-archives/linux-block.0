Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <48A74D71-9765-4881-B337-761FE66757BB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F296B91C-410A-438E-93F2-B7C141DF1F44";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCHSET v2] Add support for write life time hints
Date: Wed, 14 Jun 2017 21:53:24 -0600
In-Reply-To: <9e152ed7-ed49-bb62-902c-0daac7646a86@kernel.dk>
Cc: Martin Petersen <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org> <yq1shj2tv1z.fsf@oracle.com>
 <20382261-3180-41F0-B959-9181C2FF4BAA@dilger.ca>
 <9e152ed7-ed49-bb62-902c-0daac7646a86@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_F296B91C-410A-438E-93F2-B7C141DF1F44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 14, 2017, at 9:26 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On Wed, Jun 14, 2017 at 5:39 PM, Andreas Dilger <adilger@dilger.ca> =
wrote:
>> On Jun 14, 2017, at 10:04 AM, Martin K. Petersen =
<martin.petersen@oracle.com> wrote:
>>> Christoph,
>>>=20
>>>> I think what Martin wants (or at least what I'd want him to want) =
is
>>>> to define a few REQ_* bits that mirror the RWF bits, use that to
>>>> transfer the information down the stack, and then only translate it
>>>> to stream ids in the driver.
>>>=20
>>> Yup. If we have enough space in the existing flags that's perfect (I
>>> lost count after your op/flag shuffle).
>>=20
>> Just to clarify, does this mean that Jens' "lifetime" hints are going =
to
>> be independent of separate "stream ID" values in the future (needing =
a
>> similar, but independent, set of fields for stream IDs, or will they
>> both be implemented using a common transport in the kernel (i.e. both
>> share a single set of fields in the inode/bio/etc?
>=20
> There's no reason they can't coexist. Now that bio->bi_stream is gone
> and we just have the flags, if we want to expose separate "real" =
stream
> IDs, then we could later re-introduce that. It'd be pretty trivial to
> just use the most pertinent information on the driver side.
>=20
> =46rom my perspective, all I really care about is the 4 hints. It's a
> simple enough interface that applications can understand and use it, =
and
> we don't need any management of actual stream IDs. I think that has =
the
> highest chance of success. Modifying an application to use it is
> trivial, even something like RocksDB (if you havehad to make changes
> to RocksDB, you'll get this).

If this is really to be only flags, rather than a hybrid of flags and =
IDs
(as I had thought), then it probably makes sense to limit the inode =
usage
to a few bits in i_flags using S_LIFETIME_* values rather than a =
separate
16-bit i_stream field, which can be used for the actual stream IDs =
later.

>> I can imagine applications using either the lifetime hints (mapped to
>> stream IDs internally), or explicitly managing stream IDs, but it =
seems
>> unlikely that both would be in use at the same time, unless the =
"lifetime"
>> hints are intended to also indirectly map to HSM-like tiered =
cache/storage
>> hints internally to the storage stack (e.g. whether writes should be =
put
>> into local cachefs vs remote network storage, or bcache NVRAM vs. =
HDD)?
>=20
> Agree, both would be viable solutions, and they can coexist. =
Explicitly
> managing stream IDs is a lot more advanced, and the 4 hints will get
> most people 95% of the way there. For explicit streams, we'd need
> something similar to my previous versions of this patchset, where a =
full
> API is provided.
>=20
>> Jens' patches were moving in the direction of allowing up to 16 =
stream IDs,
>> with the default being IDs 1-4 are intended to reflect different data
>> lifetimes, but allowing up to 15 unique IDs to be specified "per =
device"*
>> if userspace wants to manage this more explicitly.
>=20
> I don't think we should mix the two up. As mentioned above, one will
> require a full API and kernel management of the streams. I had a lot =
of
> push back on that approach previously, which is why I've now gone for
> the simpler version. If we want to expose stream IDs explicitly to =
user
> space, that's a lot more involved.
>=20
> --
> Jens Axboe


Cheers, Andreas






--Apple-Mail=_F296B91C-410A-438E-93F2-B7C141DF1F44
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQgS0pIg59Q01vtYRAt+HAJ9V7fIUDBVaoopRoxbYNOD2oCtMkwCfQhg+
iMWdCFrEwkDCmNuzBfRrxr8=
=5xSm
-----END PGP SIGNATURE-----

--Apple-Mail=_F296B91C-410A-438E-93F2-B7C141DF1F44--
