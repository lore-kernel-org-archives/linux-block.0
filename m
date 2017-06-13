Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <C89764AD-ABD1-49EE-9C6D-5157127C3189@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0CFD2D35-5644-4708-90F4-D1EA21FE59E3";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/11] Add support for write life time hints
Date: Tue, 13 Jun 2017 15:53:02 -0600
In-Reply-To: <60597d4d-9067-82ba-bb2f-74ed4b27ab78@kernel.dk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block@vger.kernel.org,
 Michael Kerrisk-manpages <mtk.manpages@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
 <0c6e72e1-eb9d-4748-269a-15e218d277ed@kernel.dk>
 <2A5802CF-4DA7-477E-B5AA-F31FCD7F7908@dilger.ca>
 <ee7a8e90-5df9-c1fc-e07e-5d0e62d6334c@kernel.dk>
 <E4EBB016-5EA3-4C2C-BC63-7B8D475768AC@dilger.ca>
 <60597d4d-9067-82ba-bb2f-74ed4b27ab78@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_0CFD2D35-5644-4708-90F4-D1EA21FE59E3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 2:56 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 06/13/2017 02:45 PM, Andreas Dilger wrote:
>>>>>> I thought that one of the major attractions of numeric stream IDs =
was
>>>>>> that they had no semantic meanings, just "N is similar to N" and =
"M is
>>>>>> similar to M", and it is up to userspace to define what these =
mean?
>>>>>>=20
>>>>>> That allows userspace to use the IDs for lifetimes (as above), =
but
>>>>>> also/instead use them for allocation sizes, different =
applications,
>>>>>> different users, etc.
>>>>>=20
>>>>> Right, that is indeed the intent. But we have to attach some =
naming
>>>>> to them. Userspace could in theory use these totally randomly, and
>>>>> things like NVMe would not care. But the semantic meaning of =
"short"
>>>>> vs "long" is important on caching infrastructure where you might
>>>>> want to use the hint for data placement.
>>>>>=20
>>>>> I think the important part here is that no absolute meaning is
>>>>> attached to them, only relative.
>>>>=20
>>>> In both IOCB_WRITE_LIFE_* and RWF_WRITE_LIFE_* this is consuming 4 =
bits of
>>>> space (which is itself fine) for only 4 different stream IDs.  Why =
not just
>>>> shift a 4-bit arbitrary stream ID to the appropriate offset in =
those fields,
>>>> rather than treating them as 4 individual bits and allowing only =
one of
>>>> them to be passed down the stack at a time?
>>>=20
>>> I did think about that, and I'm a bit split on it. It turns a bit =
mask
>>> into a hybrid beast, with bits and sets of bits for values.
>>=20
>> I don't think that is too confusing for anyone.
>=20
> Agree, especially because it's a win on multiple fronts. I've made =
that
> change (see the write-stream.2 branch).
>=20
>>> For utilization of the space, yes, we could just use 2 bits instead =
of
>>> the 4. Or use the 4 bits and potentially have the app pass in up to =
16
>>> values. For the latter, I'm still very much in favor of keeping the =
app
>>> interface super simple and just retaining the 4 life time types.
>>=20
>> I don't think anyone cares too much about 4 bits.  Strictly speaking,
>> the current implementation can't fit into 2 bits because it has 5 =
values
>> if one includes "no ID".
>=20
> Right, I ended up taking 3 bits. That allows 7 valid stream IDs, and =
one
> for unknown.

I wouldn't mind if that was 4 bits, especially for the userspace =
interface.
The internal bits are easily changed, but it won't be possible to get =
more
contiguous bits in the RWF_* flags if a later one is used for something =
else.


I guess that implies (before Michael Kerrisk asks :-) that this also =
needs
a pwritev2(2) man page update to describe these flags.  I'd add =
something like:

    The RWF_WRITE_LIFE_{SHORT..EXTREME} flags are recommended for
    identifying stream IDs of different write classes, so that multiple
    users or applications running on a single storage back-end can
    aggregate their IO patterns in a consistent manner.  However, there
    are no functional semantics implied by these flags, and different
    IO classes can use the stream IDs in arbitrary ways so long as they
    are used consistently.

>> It is a bit of overhead to use 32 bits in most of the structs where =
this
>> field is actually stored.  I suspect that using only 8 or 16 bits in =
the
>> structs is better, and even if it doesn't find an existing hole =
("pahole"
>> is your friend here) it will allow something else to use the =
remaining
>> space in the future.
>=20
> I packed the i_stream into a hole, and the bio part is filling a hole
> too. So while that's not completely free, it's better than taking more
> space.
>=20
>> For userspace, I think it is fine to define the WRITE_LIFE values as =
they
>> are today, and most users will use them, but IMHO it makes sense to
>> allow arbitrary IDs as they see fit, especially if the underlying =
hardware
>> doesn't care much about the actual values.
>=20
> I change the WRITE_LIFT values to just be 1, 2, 3, 4, but shifted up.
> Might as well keep them as values, now we've changed the space in the
> flags field.
>=20
> I'll throw this out for more commenting soon. Meanwhile, I'd =
appreciate
> if you could just take a look at the write-stream.2 branch:
>=20
> http://git.kernel.dk/cgit/linux-block/log/?h=3Dwrite-stream.2
>=20
> as it should address all your concerns so far. Thanks! Until I post =
it,
> I may rebase it... I'm going to throw the basic testing at it to =
ensure
> it still works as designed before posting again.

>  #define RWF_DSYNC	0x00000002 /* per-IO O_DSYNC */
>  #define RWF_SYNC	0x00000004 /* per-IO O_SYNC */
>=20
>  /*
> + * Data life time write flags, steal 3 bits for that
> + */
> +#define RWF_WRITE_LIFE_SHIFT	3
> +#define RWF_WRITE_LIFE_MASK	((1 << 3) | (1 << 4) | (1 << 5))
> +#define RWF_WRITE_LIFE_SHORT	(1 << RWF_WRITE_LIFT_SHIFT)
> +#define RWF_WRITE_LIFE_MEDIUM	(2 << RWF_WRITE_LIFT_SHIFT)
> +#define RWF_WRITE_LIFE_LONG	(3 << RWF_WRITE_LIFT_SHIFT)
> +#define RWF_WRITE_LIFE_EXTREME	(4 << RWF_WRITE_LIFT_SHIFT)

I'd recommend to use SHIFT=3D4 and then define the mask as:

 #define RWF_SYNC		0x00000004 /* per-IO O_SYNC */
+#define RWF_WRITE_LIFE_MASK	0x000000f0 /* 4 bits stream IDs */


so that it is in the same format as the other RWF_* masks here.  The
actual SHORT, ..., EXTREME definitions can stay the same if you want.
Otherwise it is error-prone to map ((1 << 3) | (1 << 4) | (1 << 5))
into the RWF_ space to determine which is the next flag available.

Also, leaving one bit free before RWF_WRITE_LIFE_MASK gives us room
for another flag to be added before the mask until we get cut off on
the high end if others think that 4 bits isn't enough stream IDs.
It might even be prudent to move this up to 0x000f0000 (SHIFT=3D16) to
give us a bit more breathing room in that regard, given that this is
essentially going to become a permanent userspace API?

The rest of the patches look fine.  You might consider to merge patches
#2 and #3, since the WRITE_LIFE_* constants are only used by the blk_mq
patch (inode_init_always() could just use "0" for initialization).  You
may also want to move the NVMe patch before the ext4/xfs/btrfs patches,
since it isn't strictly dependent on them, and allows some testing on
real hardware once the O_DIRECT patch is available.

The other thing that might be interesting to include in the NVMe patch
is what kind of hardware support is available for the Streams Directive
(i.e. in existing hardware, draft spec only, how many stream IDs are
available, etc.) and what kind of performance benefit this provides
(even if not quantitative).  As it stands now, unless you already know
what this patch series does, it doesn't explain very much.

Cheers, Andreas






--Apple-Mail=_0CFD2D35-5644-4708-90F4-D1EA21FE59E3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQF6+pIg59Q01vtYRAqSkAJ9YTKP4mxYofeQjxT4BEMF4YJQIqgCfe+yc
j6+Zii+sJpJmD1HCS20Dirs=
=C3Be
-----END PGP SIGNATURE-----

--Apple-Mail=_0CFD2D35-5644-4708-90F4-D1EA21FE59E3--
