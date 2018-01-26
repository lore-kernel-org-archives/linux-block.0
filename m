Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:41040
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751377AbeAZKJ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jan 2018 05:09:29 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: Re: [LSF/MM ATTEND] OCSSD topics
Date: Fri, 26 Jan 2018 10:09:23 +0000
Message-ID: <8A03EBCA-3C51-4D57-8C62-A52393E38799@cnexlabs.com>
References: <986429B2-A254-4247-AA4F-F631A565DA8B@cnexlabs.com>
 <52189623-69cf-79cd-d2e3-af2e202c01ec@lightnvm.io>
 <0A986779-992D-40A0-A8C6-7AE9049EF48F@cnexlabs.com>
 <c73c736b-894f-2178-bee8-1011748fa26b@lightnvm.io>
In-Reply-To: <c73c736b-894f-2178-bee8-1011748fa26b@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C7C5ED18-4D37-41D6-8334-735B51DF8B11";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_C7C5ED18-4D37-41D6-8334-735B51DF8B11
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Jan 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 01/26/2018 09:30 AM, Javier Gonzalez wrote:
>>> On 25 Jan 2018, at 22.02, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 01/25/2018 04:26 PM, Javier Gonzalez wrote:
>>>> Hi,
>>>> There are some topics that I would like to discuss at LSF/MM:
>>>>   - In the past year we have discussed a lot how we can integrate =
the
>>>>     Open-Channel SSD (OCSSD) spec with zone devices (SMR). This
>>>>     discussion is both at the interface level and at an in-kernel =
level.
>>>>     Now that Damien's and Hannes' patches are upstreamed in good =
shape,
>>>>     it would be a good moment to discuss how we can integrate the
>>>>     LightNVM subsystem with the existing code.
>>>=20
>>> The ZBC-OCSSD patches
>>> (https://github.com/OpenChannelSSD/linux/tree/zbc-support) that I =
made
>>> last year is a good starting point.
>> Yes, this patches is a good place to start, but as mentioned below, =
they
>> do not address how we would expose the parallelism on report_zone.
>> The way I see it, zone-devices impose write constrains to gain =
capacity;
>> OCSSD does that to enable the parallelism of the device.
>=20
> Also capacity for OCSSDs, as most raw flash is exposed. It is up to
> the host to decide if over-provisioning is needed.
>=20

This is a good point. Actually, if we declare a _necessary_ OP area, =
users
doing GC could use this OP space to do their job. For journaled-only
areas, no extra GC will be necessary. For random areas, pblk can do the
job (in a host managed solution).

> This then can
>> be used by different users to either lower down media wear, reach a
>> stable state at the very early stage or guarantee tight latencies. =
That
>> depends on how it is used. We can use an OCSSD as a zone-device and =
it
>> will work, but it is coming back to using an interface that will =
narrow
>> down the OCSSD scope (at least in its current format).
>>> Specifically, in ALPSS'17
>>>>     we had discussions on how we can extend the kernel zoned device
>>>>     interface with the notion of parallel units that the OCSSD =
geometry
>>>>     builds upon. We are now bringing the OCSSD spec. to =
standarization,
>>>>     but we have time to incorporate feedback and changes into the =
spec.
>>>=20
>>> Which spec? the OCSSD 2 spec that I have copyright on? I don't =
believe
>>> it has been submitted or is under consideration to any standards =
body
>>> yet and I don't currently plan to do that.
>>>=20
>>> You might have meant "to be finalized". As you know, I am currently
>>> soliciting feedback and change requests from vendors and partners =
with
>>> respect to the specification and is planning on closing it soon. If
>>> CNEX is doing their own new specification, please be open about it,
>>> and don't put it under the OCSSD name.
>> As you know, there is a group of cloud providers and vendors that is
>> starting to work on the standarization process with the current state =
of
>> the 2.0 spec as the staring point - you have been part of these
>> discussions... The goal for this group is to collect the feedback =
from
>> all parties and come up with a spec. that is useful and covers cloud
>> needs. Exactly for - as you imply -, not to tie the spec. to an
>> organization and/or individual. My hope is that this spec is very
>> similar to the OCSSD 2.0 that _we_ all have worked hard on putting
>> together.
>=20
> Yes, that is my point. The workgroup device specification you are
> discussing may or may not be OCSSD 2.0 similar/compatible and is not
> tied to the process that is currently being run for the OCSSD 2.0
> specification. Please keep OCSSD out of the discussions until the
> device specification from the workgroup has been completed and made
> public. Hopefully the device specification turns out to be OCSSD 2.0
> compatible and the bits can be added to the 2.0 (2.1) specification.
> If not, it has to be stand-alone, with its own implementation.
>=20

Then we agree. The reason to open the discussion is to ensure that
feedback comes from different places. Many times we have experienced a
mismatch between what is discussed in the standard bodies (e.g., NVMe
working groups) and the reality of Linux. Ideally, we can avoid this.

I _really_ hope that we can sit down and align OCSSD 2.X since it really
makes no sense to have different flavours of the same thing in the
wild...

>> Later on, we can try to to checks on lba "batches", defined by this =
same
>> write restrictions. But you are right that having a fully random lba
>> vector will require individual checks and that is both expensive and
>> intrusive. This can be isolated by flagging the nature of the bvec,
>> something ala (sequential, batched, random).
>=20
> I think it must still be checked. One cannot trust that the LBAs are
> as expected. For example, the case where LBAs are out of bounds and
> accesses another partition.
>=20

Fair point.

>>>  For example supported natively in the NVMe specification.
>> Then we agree that aiming at a stardard body is the goal, right?
>=20
> Vector I/O is orthogonal to proposing a zone/ocssd proposal to the
> NVMe workgroup.

Sure. But since both are related to the ocssd proposal, I would expect
them to be discussed in the same context.

I personally don't see much value in ocssd used as a zone device (same
as I don't see the value of using an ocssd uniquely with pblk) - these
are building blocks to enable adoption. Thhe real value comes from
exposing the parallelism, and down the road the vector I/O is a more
generic way of doing it.

Javier

--Apple-Mail=_C7C5ED18-4D37-41D6-8334-735B51DF8B11
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlpq/lEACgkQIX4xUKFR
nnTC7w/8CgxP6ULRXDemoCaMkhQ06O07RGdgdSvtfQKRtexWyu6XmfCpSpX0mZkR
CoG9195KlBLlj4O5+mn5J2LhDMIfz7DSu35QdFEUzFc8A6L6Eo+mhZD/1E0pv2bL
jmWI+/gVy9yezT+8Gm4HAOI94j2fyExUcW0wfS03QYmnNwiOzvzTjYnw/HSCgi6j
dcmk3D0OsNNg4ZvDiOv6uj3zllWuG7/h+GTFybHiqLOXB6+9rTWgc7rVSkRhdUhp
ICuRh6yp5DzIqItr4YVSlIvAt+BNZz+0tfQgKNR+cfBPSnlhJfG6x7pBKRe73QQp
BybnymJenmlzPhfjjNN0sZsdqb20JllxVEdKD5+cp+uBFoFtboSF+qbrMXIWAft2
6HpumD3uJ2i2XssBTMyUO4FScGtRODZrSrPrzsnSwvNjnpmJGNf3iVwFjVwU7amt
O7rAtM+dGZ4tMNJ+wwoxPldE6cNu6pyB7THYQDUHlLF3j/ptFL1xch8coKkDPdB8
WwHIQDvXlMHwYs90ZXkKO3Ny6MWHbZ8pt0wY77DH80ItTvsSVCID4s0ehrWcHmH1
DtEDtrh6p0gWEILEGKTf48gnGv5w8+Vz7QyokzlXNhgKpzeSjcO7gvrDMOFV4QTz
tW/wGP95bMoIMAsCCD1r36fWX1Yt8Zunb+5eXtliJrlZ+wJbovQ=
=PdPg
-----END PGP SIGNATURE-----

--Apple-Mail=_C7C5ED18-4D37-41D6-8334-735B51DF8B11--
