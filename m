Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:59221
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQNwd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 09:52:33 -0400
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
Date: Fri, 17 Aug 2018 10:49:28 +0000
Message-ID: <F3989C76-24EF-4E26-801A-DB3E1CC45981@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
 <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
 <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
 <05339052-F338-45A5-B3E2-43152A4A0DF6@cnexlabs.com>
 <d17ce375-6ddb-8fd2-a8c1-f1e7d3572b37@lightnvm.io>
In-Reply-To: <d17ce375-6ddb-8fd2-a8c1-f1e7d3572b37@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 17 Aug 2018, at 11.42, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/17/2018 11:34 AM, Javier Gonzalez wrote:
>>> On 17 Aug 2018, at 11.29, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/17/2018 10:44 AM, Javier Gonzalez wrote:
>>>>> On 17 Aug 2018, at 10.21, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>>>>>> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval =
to
>>>>>>> core.
>>>>>>>=20
>>>>>>> Hi Javier, I did not end up using your patch. I had =
misunderstood what
>>>>>>> was implemented. Instead I implemented the detection of the each =
chunk by
>>>>>>> first sensing the first page, then the last page, and if the =
chunk
>>>>>>> is sensed as open, a per page scan will be executed to update =
the write
>>>>>>> pointer appropriately.
>>>>>> I see why you want to do it this way for maintaining the chunk
>>>>>> abstraction, but this is potentially very inefficient as blocks =
not used
>>>>>> by any target will be recovered unnecessarily.
>>>>>=20
>>>>> True. It will up to the target to not ask for more metadata than =
necessary (similarly for 2.0)
>>>>>=20
>>>>> Note that in 1.2, it is
>>>>>> expected that targets will need to recover the write pointer =
themselves.
>>>>>> What is more, in the normal path, this will be part of the =
metadata
>>>>>> being stored so no wp recovery is needed. Still, this approach =
forces
>>>>>> recovery on each 1.2 instance creation (also on factory reset). =
In this
>>>>>> context, you are right, the patch I proposed only addresses the =
double
>>>>>> erase issue, which was the original motivator, and left the =
actual
>>>>>> pointer recovery to the normal pblk recovery process.
>>>>>> Besides this, in order to consider this as a real possibility, we =
need
>>>>>> to measure the impact on startup time. For this, could you =
implement
>>>>>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>>>>>> recovering (i) asynchronously and (ii) concurrently across luns =
so that
>>>>>> we can establish the recovery cost more fairly? We can look at a
>>>>>> specific penalty ranges afterwards.
>>>>>=20
>>>>> Honestly, 1.2 is deprecated.
>>>> For some...
>>> No. OCSSD 1.2 is deprecated. Others that have a derivative of 1.2 =
have
>>> their own storage stack and spec that they will continue development
>>> on, which can not be expected to be compatible with the OCSSD 1.2 =
that
>>> is implemented in the lightnvm subsystem.
>> There are 1.2 devices out there using the current stack with no =
changes. >
>=20
> Yes, obviously, and they should continue to work. Which this patch =
doesn't change.
>=20
>>>>> I don't care about the performance, I
>>>>> care about being easy to maintain, so it doesn't borg me down in =
the
>>>>> future.
>>>> This should be stated clear in the commit message.
>>>>> Back of the envelope calculation for a 64 die SSD with 1024 blocks =
per
>>>>> die, and 60us read time, will take 4 seconds to scan if all chunks =
are
>>>>> free, a worst case something like ~10 seconds. -> Not a problem =
for
>>>>> me.
>>>> Worst case is _much_ worse than 10s if you need to scan the block =
to
>>>> find the write pointer. We are talking minutes.
>>>=20
>>> I think you may be assuming that all blocks are open. My assumption =
is
>>> that this is very rare (given the NAND characteristics). At most a
>>> couple of blocks may be open per die. That leads me to the time
>>> quoted.
>> Worst case is worst case, no assumptions.
>>>> At least make the recovery reads asynchronous. It is low hanging =
fruit
>>>> and will help the average case significantly.
>>>>>> Also, the recovery scheme in pblk will change significantly by =
doing
>>>>>> this, so I assume you will send a followup patchset =
reimplementing
>>>>>> recovery for the 1.2 path?
>>>>>=20
>>>>> The 1.2 path shouldn't be necessary after this. That is the idea =
of
>>>>> this work. Obviously, the set bad block interface will have to
>>>>> preserved and called.
>>>> If we base this patch on top of my 2.0 recovery, we will still need =
to
>>>> make changes to support all 1.2 corner cases.
>>>> How do you want to do it? We get this patch in shape and I rebase =
on top
>>>> or the other way around?
>>>=20
>>> I'll pull this in when you're tested it with your 1.2 =
implementation.
>> Please, address the asynchronous read comment before considering =
pulling
>> this path. There is really no reason not to improve this.
>=20
> I'll accept patches, but I won't spend time on it. Please let me know =
if you have other comments.

Your choice to ignore my comment on a RFC at this early stage of the
4.20 window.

In any case, I tested on our 1.2 devices and the patch has passed
functionality.

Please do not add reviewed-by or tested-by tags with my name as I do not
back the performance implications of the current implementation (on an
otherwise good cleanup patch).

Javier



--Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt2qDUACgkQIX4xUKFR
nnTHsBAA2sBWCHyicdxggssMKimMN6V5OGI/VGbfo5PMiS2/vYssbm/j2ZoMgATa
CA6S0G3vMrHllyjeZSlV5LUImZ5j4zif+LpqJd/UnznO8wU8F25pHvrvWxcNb/Nq
L6AOVkNpfbEZT4ZUAAMqfToh60+mnq/E8F3WMshq+/nd6qJvuFC2dTDfOnnZBtIn
8Lm+Kx2FENhF0OogBcGj2sydLVS6bbgs4xeZ8zhCDzzYiUJ9xDRXUUvrKM/XiNMI
/qS+a/OCGzl89JVejCkaoMPnptjgTk2/NE+a/FHra4VDPiuYwgKCZPtoMQr7M77c
nI3PJZrnmgOzEGV/eC0wbRLV/yxOSV+I32SwTFCbw5zM83l7SgHA0Th8uh9gVFDS
EinkHk1e3AqJ7s4aVtOo67scrX3U6D4jnYgoM064AgnMNP2INOwbP05vyUduwFzU
5wmsuaqaHq9E15yes+W/wcRyq9qraENnn/EuPETCAI/2dMpwr7P2/KDouJmTnTtg
hv+LGb4GxsjGXyGjyuNlhVR0UBWKwxY2sY9uGADHCop7z8HuqRfrBfqONvNgsizU
X+NuDDMp9RLprK/EYVHhiILhNjXd0EPureIWjzLCMERAbzJR8hCDbD4SKAJmZx/h
IowLZM8Otw0moyp0QANOPf9YMLe2OHoOAUys5D3AoEvVJrQLlJE=
=cd2f
-----END PGP SIGNATURE-----

--Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B--
