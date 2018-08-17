Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:27971
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQLrJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 07:47:09 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
Date: Fri, 17 Aug 2018 08:44:30 +0000
Message-ID: <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
In-Reply-To: <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 10.21, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>>> core.
>>>=20
>>> Hi Javier, I did not end up using your patch. I had misunderstood =
what
>>> was implemented. Instead I implemented the detection of the each =
chunk by
>>> first sensing the first page, then the last page, and if the chunk
>>> is sensed as open, a per page scan will be executed to update the =
write
>>> pointer appropriately.
>> I see why you want to do it this way for maintaining the chunk
>> abstraction, but this is potentially very inefficient as blocks not =
used
>> by any target will be recovered unnecessarily.
>=20
> True. It will up to the target to not ask for more metadata than =
necessary (similarly for 2.0)
>=20
> Note that in 1.2, it is
>> expected that targets will need to recover the write pointer =
themselves.
>> What is more, in the normal path, this will be part of the metadata
>> being stored so no wp recovery is needed. Still, this approach forces
>> recovery on each 1.2 instance creation (also on factory reset). In =
this
>> context, you are right, the patch I proposed only addresses the =
double
>> erase issue, which was the original motivator, and left the actual
>> pointer recovery to the normal pblk recovery process.
>> Besides this, in order to consider this as a real possibility, we =
need
>> to measure the impact on startup time. For this, could you implement
>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>> recovering (i) asynchronously and (ii) concurrently across luns so =
that
>> we can establish the recovery cost more fairly? We can look at a
>> specific penalty ranges afterwards.
>=20
> Honestly, 1.2 is deprecated.

For some...

> I don't care about the performance, I
> care about being easy to maintain, so it doesn't borg me down in the
> future.

This should be stated clear in the commit message.

>=20
> Back of the envelope calculation for a 64 die SSD with 1024 blocks per
> die, and 60us read time, will take 4 seconds to scan if all chunks are
> free, a worst case something like ~10 seconds. -> Not a problem for
> me.
>=20

Worst case is _much_ worse than 10s if you need to scan the block to
find the write pointer. We are talking minutes.

At least make the recovery reads asynchronous. It is low hanging fruit
and will help the average case significantly.

>> Also, the recovery scheme in pblk will change significantly by doing
>> this, so I assume you will send a followup patchset reimplementing
>> recovery for the 1.2 path?
>=20
> The 1.2 path shouldn't be necessary after this. That is the idea of
> this work. Obviously, the set bad block interface will have to
> preserved and called.

If we base this patch on top of my 2.0 recovery, we will still need to
make changes to support all 1.2 corner cases.

How do you want to do it? We get this patch in shape and I rebase on top
or the other way around?

Javier

--Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt2iusACgkQIX4xUKFR
nnR4ThAAv5nuGq6jJLoVggIyNEeBCyIWNeFX5hXc0GYokhpeq2RlHXiQc13BtKt1
39hDwMzyqE/0/fn02H++/L/Buk2teN85FezflIAcBLdUxNaK/VTDbKT7xgBBZGdY
R4uvFyM7pKP+E18ZcZy0hz91fgOYesHVe/V6WB+6ZjBk1cSjNGlYdoRUoxcuuCeh
933YNlH58d4Lpzg3yQT7vIXjNl5zGjCMhfMsAi4UxbKShBlDRUaxQe+yyRRCj4Je
3Rs6gTaqxcqmA2q81f3CVO7j8nbqquWfhZs0ps1sEDzvDUqXvnGay2bvjwcCDoEu
djXJpYSDRpIgiBp+RSL4juLh4Xhma5BUk/bwno0inGrDg1LqlBZRvMyw0gHumxWb
pF5mwELEGoVcHOZENdwcoNfYQRK5GGICIIn1moWDSmVteouOHT3RhjQJ06sQNBVN
lbUjTtTkD7sLjWTnW6LqDPAWRykpyIBp6jMPNVVNPVc5/rD+vFxp73jeFlBowpHp
Vi5Vfz/AP6330HrDff84Ae9wFUSch+tGy4gLbGxIwaCqgl7I5WfIqDnYmvRvvXJ2
9qOJkyxYzMKTOWLNHwMZ9CKa1aiet+jTtnm46lZS+/TfzxB/2vk67L02CR5khsvS
Zb3NZoFyvD7PwS+ezpvn8y1WnN0kad9KGy+pwhmQariFmPCMIJE=
=pTAb
-----END PGP SIGNATURE-----

--Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D--
