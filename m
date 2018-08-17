Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0055.outbound.protection.outlook.com ([104.47.42.55]:23409
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbeHQMhc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 08:37:32 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
Date: Fri, 17 Aug 2018 09:34:30 +0000
Message-ID: <05339052-F338-45A5-B3E2-43152A4A0DF6@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
 <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
 <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
In-Reply-To: <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 11.29, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/17/2018 10:44 AM, Javier Gonzalez wrote:
>>> On 17 Aug 2018, at 10.21, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>>>> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>>>>> core.
>>>>>=20
>>>>> Hi Javier, I did not end up using your patch. I had misunderstood =
what
>>>>> was implemented. Instead I implemented the detection of the each =
chunk by
>>>>> first sensing the first page, then the last page, and if the chunk
>>>>> is sensed as open, a per page scan will be executed to update the =
write
>>>>> pointer appropriately.
>>>> I see why you want to do it this way for maintaining the chunk
>>>> abstraction, but this is potentially very inefficient as blocks not =
used
>>>> by any target will be recovered unnecessarily.
>>>=20
>>> True. It will up to the target to not ask for more metadata than =
necessary (similarly for 2.0)
>>>=20
>>> Note that in 1.2, it is
>>>> expected that targets will need to recover the write pointer =
themselves.
>>>> What is more, in the normal path, this will be part of the metadata
>>>> being stored so no wp recovery is needed. Still, this approach =
forces
>>>> recovery on each 1.2 instance creation (also on factory reset). In =
this
>>>> context, you are right, the patch I proposed only addresses the =
double
>>>> erase issue, which was the original motivator, and left the actual
>>>> pointer recovery to the normal pblk recovery process.
>>>> Besides this, in order to consider this as a real possibility, we =
need
>>>> to measure the impact on startup time. For this, could you =
implement
>>>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>>>> recovering (i) asynchronously and (ii) concurrently across luns so =
that
>>>> we can establish the recovery cost more fairly? We can look at a
>>>> specific penalty ranges afterwards.
>>>=20
>>> Honestly, 1.2 is deprecated.
>> For some...
> No. OCSSD 1.2 is deprecated. Others that have a derivative of 1.2 have
> their own storage stack and spec that they will continue development
> on, which can not be expected to be compatible with the OCSSD 1.2 that
> is implemented in the lightnvm subsystem.
>=20

There are 1.2 devices out there using the current stack with no changes.

>>> I don't care about the performance, I
>>> care about being easy to maintain, so it doesn't borg me down in the
>>> future.
>> This should be stated clear in the commit message.
>>> Back of the envelope calculation for a 64 die SSD with 1024 blocks =
per
>>> die, and 60us read time, will take 4 seconds to scan if all chunks =
are
>>> free, a worst case something like ~10 seconds. -> Not a problem for
>>> me.
>> Worst case is _much_ worse than 10s if you need to scan the block to
>> find the write pointer. We are talking minutes.
>=20
> I think you may be assuming that all blocks are open. My assumption is
> that this is very rare (given the NAND characteristics). At most a
> couple of blocks may be open per die. That leads me to the time
> quoted.
>=20

Worst case is worst case, no assumptions.

>> At least make the recovery reads asynchronous. It is low hanging =
fruit
>> and will help the average case significantly.
>>>> Also, the recovery scheme in pblk will change significantly by =
doing
>>>> this, so I assume you will send a followup patchset reimplementing
>>>> recovery for the 1.2 path?
>>>=20
>>> The 1.2 path shouldn't be necessary after this. That is the idea of
>>> this work. Obviously, the set bad block interface will have to
>>> preserved and called.
>> If we base this patch on top of my 2.0 recovery, we will still need =
to
>> make changes to support all 1.2 corner cases.
>> How do you want to do it? We get this patch in shape and I rebase on =
top
>> or the other way around?
>=20
> I'll pull this in when you're tested it with your 1.2 implementation.

Please, address the asynchronous read comment before considering pulling
this path. There is really no reason not to improve this.

Javier

--Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt2lqMACgkQIX4xUKFR
nnR1rRAAuSALuy7at1Tp4jDYVlxQg0petxvWeOSyP6RYS+HDQwhgQHzNF90Hbq6Y
o/5XOSS4ljBUHnWocYE7FJIz53Tqf8D2gQa52E24BrOH1ZSpwGoEB7RTrZWP0ML4
JVV+T7e48Wr5kLOUIGiCaNmPeQRCiz6jl61jzlkxRe9emNuihKO6EJHRY+IBiV6F
gXSpN3FdMqHk4zEKR7sLJcixupcvL2sGWHv5D8K5Dv8CmjcAhDBQmC0xSnNtIPxz
kwQwxnJ3/0fnROGNMhPD7nxYOWZqJBF+focwq4DJgkwYxjGXD1Q3TM6JJ8N0n/7r
E3aMu+LD1pI68XKaWarJ7Oii7o6vNxS+HtcltT3oPyd5Ckpos92gHqn/GL/h6OQL
6U3ehDzlNeE7Cs2QzVb1ATMlX01IJn6cZpEXU/LJjt2Oqrvk+RQBcXX7sJzrxkj8
1p2GdJ6nLHaQoViOFGahFcqwqjJ6zkwEOLhrilN+zSDgIfxHo+/456d5Wf5D0J/I
dn2TtePg22qDq5XjVzbMAmFdxfYRyKRfzbebHwfvJVHYKYn9pm4pGkcZdn6I62q5
OurQ1uIeuL0BBlgyzXgTwHxdvajNpbS0TIzbncGPBfbI/G/HZIqVUmXmv6UMbWYe
JDZ3VJ/ta+JLvHyfxzyOOogshgFIYSgPjqXyrrrcbu2/w+aGsS4=
=yFpk
-----END PGP SIGNATURE-----

--Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1--
