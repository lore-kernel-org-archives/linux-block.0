Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0044.outbound.protection.outlook.com ([104.47.40.44]:46080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752324AbeAZIae (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jan 2018 03:30:34 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: Re: [LSF/MM ATTEND] OCSSD topics
Date: Fri, 26 Jan 2018 08:30:31 +0000
Message-ID: <0A986779-992D-40A0-A8C6-7AE9049EF48F@cnexlabs.com>
References: <986429B2-A254-4247-AA4F-F631A565DA8B@cnexlabs.com>
 <52189623-69cf-79cd-d2e3-af2e202c01ec@lightnvm.io>
In-Reply-To: <52189623-69cf-79cd-d2e3-af2e202c01ec@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_869D24F9-9FF0-4887-9742-582EA13059CB";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_869D24F9-9FF0-4887-9742-582EA13059CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 25 Jan 2018, at 22.02, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 01/25/2018 04:26 PM, Javier Gonzalez wrote:
>> Hi,
>> There are some topics that I would like to discuss at LSF/MM:
>>   - In the past year we have discussed a lot how we can integrate the
>>     Open-Channel SSD (OCSSD) spec with zone devices (SMR). This
>>     discussion is both at the interface level and at an in-kernel =
level.
>>     Now that Damien's and Hannes' patches are upstreamed in good =
shape,
>>     it would be a good moment to discuss how we can integrate the
>>     LightNVM subsystem with the existing code.
>=20
> The ZBC-OCSSD patches
> (https://github.com/OpenChannelSSD/linux/tree/zbc-support) that I made
> last year is a good starting point.
>=20

Yes, this patches is a good place to start, but as mentioned below, they
do not address how we would expose the parallelism on report_zone.

The way I see it, zone-devices impose write constrains to gain capacity;
OCSSD does that to enable the parallelism of the device. This then can
be used by different users to either lower down media wear, reach a
stable state at the very early stage or guarantee tight latencies. That
depends on how it is used. We can use an OCSSD as a zone-device and it
will work, but it is coming back to using an interface that will narrow
down the OCSSD scope (at least in its current format).

> Specifically, in ALPSS'17
>>     we had discussions on how we can extend the kernel zoned device
>>     interface with the notion of parallel units that the OCSSD =
geometry
>>     builds upon. We are now bringing the OCSSD spec. to =
standarization,
>>     but we have time to incorporate feedback and changes into the =
spec.
>=20
> Which spec? the OCSSD 2 spec that I have copyright on? I don't believe
> it has been submitted or is under consideration to any standards body
> yet and I don't currently plan to do that.
>=20
> You might have meant "to be finalized". As you know, I am currently
> soliciting feedback and change requests from vendors and partners with
> respect to the specification and is planning on closing it soon. If
> CNEX is doing their own new specification, please be open about it,
> and don't put it under the OCSSD name.

As you know, there is a group of cloud providers and vendors that is
starting to work on the standarization process with the current state of
the 2.0 spec as the staring point - you have been part of these
discussions... The goal for this group is to collect the feedback from
all parties and come up with a spec. that is useful and covers cloud
needs. Exactly for - as you imply -, not to tie the spec. to an
organization and/or individual. My hope is that this spec is very
similar to the OCSSD 2.0 that _we_ all have worked hard on putting
together.

In any case, my intention with this topic is not discussing the name or
the owners of the spec., but rather seeking feedback from the kernel
community, which is well experienced in implementing, dealing with and
supporting specifications.

>>          Some of the challenges are (i) adding vector I/O interface =
to the
>>     bio structure and (ii) extending the report zone to have the =
notion
>>     of parallelism. I have patches implementing the OCSSD 2.0 spec =
that
>>     abstract the geometry and allow upper layers to deal with write
>>     restrictions and the parallelism of the device, but this is still
>>     very much OCSSD-specific.
>=20
> For the vector part, one can look into Ming's work on multi-page bvec
> (https://lkml.org/lkml/2017/12/18/496). When that code is in, it
> should be possible to implement the rest. One nagging feeling I have
> is that the block core code need to be updated to understand vectors.
> That will be complex given I/O checks are all based on ranges and is
> cheap, while for vectors it is significantly more expensive due to
> each LBA much be checked individually (one reason it is a separate
> subsystem). It might not be worth it until the vector api has broader
> market adoption.

Yes, we have discussed this since the first version of the patches :)

One if the things that we could do - at least for a first version - is
using LBA ranges based on write restrictions (ws_min, ws_opt in oscssd
terms). This will limit using one parallel unit at a time on I/O
submission, but allows file systems to have the notion of the
parallelism for data placement. The device bandwidth should also be
saturated at fairly low queue depths - namely the number of parallel
units.

Later on, we can try to to checks on lba "batches", defined by this same
write restrictions. But you are right that having a fully random lba
vector will require individual checks and that is both expensive and
intrusive. This can be isolated by flagging the nature of the bvec,
something ala (sequential, batched, random).

>  For example supported natively in the NVMe specification.

Then we agree that aiming at a stardard body is the goal, right?

> For extending report zones, one can do (start LBA:end LBA) (similarly
> to the device mapper interface), and then have a list of those to
> describe the start and end of each parallel unit.

Good idea. We probably need to describe the parallel unit in its own
structure, since they might differ. Here I'm thinking of (i) different
ocssds accessible to the same host and (ii) the possibility of some
parallel units accepting random I/O, supported by the device (if this is
relevant at this point...).

>>   - I have started to use the above to do a f2fs implementation, =
where
>>     we would implement the data placement and I/O scheduling directly =
in
>>     the FS, as opposed to using pblk - at least for the journaled =
part.
>>     The random I/O partition necessary for metadata can either reside =
in
>>     a different drive or use a pblk instance for it. This is very =
much
>>     work in progress, so having feedback form the f2fs guys (or other
>>     journaled file systems) would help to start the work in the right
>>     direction. Maybe this is interesting for other file systems =
too...
>=20
> We got much feedback from Jaegeuk. =46rom his feedback, I did the ZBC
> work with f2fs, which used a single parallel unit. To improve on that,
> one solution is to extend dm-stripe to understand zones (it can
> already be configured correctly... but it should expose zone entries
> as well) and then use that for doing stripes across parallel units
> with f2fs. This would fit into the standard codebase and doesn't add a
> whole lot of OCSSD-only bits.
>=20

It can be a start, though I was thinking more on how we could plug into
f2fs garbage collection and metadata to place data in a smart way. I
know this is a matter of sitting down with the code and submitting
patches, but if we are talking about actually providing a benefit for
file systems, why not open the discussion to the file system folks?

My experience building the RocksDB backend for Open-Channel is that it =
is
fairly simple to build the abstractions that allow using an OCSSD, but
it is difficult to plug in the right places to take advantage of the
parallelism, since it requires a good understanding of the placement
internals.


>>   - Finally, now that pblk is becoming stable, and given the advent =
of
>>     devices imposing sequential-only I/O, would it make sense to
>>     generalize pblk as a device mapper translation layer that can be
>>     used for random I/O partitions?
>=20
> dm-zoned fills this niche. Similarly as above, combine it with zone
> aware dm-stripe and it is a pretty good solution. However, given that
> pblk does a lot more than making I/Os sequential, I can see why it
> will be nice to have as a device mapper. It could be the dual-solution
> that we previously discussed, where pblk can use either the
> traditional scalar or vector interface, depending if the drive has
> exposed a separate vector interface.

Exactly. My intention bringing this up is validating the use case before
starting to implement it.

> We have ad internal use cases for
>>     using such translation layer for frontswap devices. Maybe others =
are
>>     looking at this too...
>> Javier

Javier

--Apple-Mail=_869D24F9-9FF0-4887-9742-582EA13059CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlpq5yQACgkQIX4xUKFR
nnTTjxAAuFluImSxiG7reeL1B1mTTmXV4k+QU/wV8RkZSHGdT5vCKZY0Lq727Q3M
APpkln/GkBvTCFd20WQk7/Um/qydtSro2kiUmdNo6Km6weIixwsPQs2+3sEFgSzg
h1MAnln9WiEYtTTXrr4W4YHxsqWYwZEZ2mXzZyxbiAKtu25rGF+me+0J7Npj4qk2
+To+TgFM8FFk1VXxtTAU1iAnu634zN3tArkyarPxFX7Fc3tsgXsKCa1C4DB71dxK
YxaPtsLOTGQCQIwNxaUiL0ercrD/uL60Qr/EsrpQrBTNScXoi51G1BES00dbPi9G
hy/WM6L3b3cyP4DZg6lz4lk9tAaOgZRAvlc2ELeiwxDSp0K1GLQJ0ujlkf9nguMt
RUlceJlurQrYFJGmJH2R8hWAacWrAu8uwhwQIgjKcVQoVwNRMCLl3/3kZ31A/HR5
JQsEfes5xgSD2sJMbrJidQO6RegPASQi4yrmM+06FUtT7TBD3jGeBRCl2ft0KRSG
CEbRL2zWXMFwXH8hMoMzBWU3S6/njxGfoL8Zq5yxCe5mSzcIuSK5QwX4nytzvxMq
u49JRkLzChDBBla9He3zpsurLniA/KiOQjEKW4ZE/xl3st6AGD1tUJhUYLx8GyAh
Qi0Ofk6bHrPA1d9GHiE8ruwWcpbTeLylowVJ4xltRgizfiZcnRA=
=FDoL
-----END PGP SIGNATURE-----

--Apple-Mail=_869D24F9-9FF0-4887-9742-582EA13059CB--
