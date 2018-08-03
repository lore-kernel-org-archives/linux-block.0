Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:39993
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728524AbeHCOvs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:51:48 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Date: Fri, 3 Aug 2018 12:53:37 +0000
Message-ID: <D6BDF75C-179D-424C-A8B0-950A1FD80221@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
 <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
 <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
 <88659F4F-8105-41CA-B0B8-849E707F18CD@cnexlabs.com>
 <423c5d4b-6d9a-d233-d3da-f2cb8b10f880@lightnvm.io>
 <F7B041D7-4E55-4B26-A263-9289C4616223@cnexlabs.com>
 <f50b1c39-10a3-a62c-85d4-7a869ba74cbe@lightnvm.io>
In-Reply-To: <f50b1c39-10a3-a62c-85d4-7a869ba74cbe@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.46, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:37 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 14.30, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/03/2018 02:02 PM, Javier Gonzalez wrote:
>>>>> On 3 Aug 2018, at 13.57, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 07/24/2018 09:54 AM, Javier Gonzalez wrote:
>>>>>>> On 29 Jun 2018, at 13.28, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> On 06/29/2018 01:22 PM, Javier Gonzalez wrote:
>>>>>>>>> On 29 Jun 2018, at 13.14, Matias Bj=C3=B8rling =
<mb@lightnvm.io> wrote:
>>>>>>>>>=20
>>>>>>>>> On 06/28/2018 11:12 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>>> The Open-Channel 1.2 spec does not define a mechanism for the =
host to
>>>>>>>>>> recover the block (chunk) state. As a consequence, a newly =
format device
>>>>>>>>>> will need to reconstruct the state. Currently, pblk assumes =
that blocks
>>>>>>>>>> are not erased, which might cause double-erases in case that =
the device
>>>>>>>>>> does not protect itself against them (which is not specified =
in the spec
>>>>>>>>>> either).
>>>>>>>>>=20
>>>>>>>>> It should not be specified in the spec. It is up to the device =
to handle
>>>>>>>>> double erases and not do it.
>>>>>>>>>=20
>>>>>>>>>> This patch, reconstructs the state based on read errors. If =
the first
>>>>>>>>>> sector of a block returns and empty page =
(NVM_RSP_ERR_EMPTYPAGE), then
>>>>>>>>>> the block s marked free, i.e., erased and ready to be used
>>>>>>>>>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>>>>>>>>>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and =
not fully
>>>>>>>>>> written, it has to be erased in order to be used again.
>>>>>>>>>=20
>>>>>>>>> Should we extend it to do the scan, and update the write =
pointer as
>>>>>>>>> well? I think this kind of feature already is baked into pblk?
>>>>>>>> This is already in place: we scan until empty page and take it =
from
>>>>>>>> there. This patch is only for the case in which we start a pblk =
instance
>>>>>>>> form scratch. On a device already owned by pblk, we would not =
have the
>>>>>>>> problem we are trying to solve here because we know the state.
>>>>>>>=20
>>>>>>> Agree. What I meant was that when we anyway are recovering the =
state,
>>>>>>> we could just as well update ->wp and set to NVM_CHK_ST_OPEN and =
so
>>>>>>> forth for the initialization phase.
>>>>>> In 1.2 the use of chunk metadata is purely fictional. We respect =
the
>>>>>> chunk state machine as we transition lines, but all the write =
pointers
>>>>>> are ignored. Instead, we use the line bitmap to point to the next
>>>>>> writable entry. This is BTW the same way we it in open lines on =
2.0 too.
>>>>>=20
>>>>> Now I understand where you are coming from. I had the =
understanding
>>>>> that we where using the write pointer now that we moved to 2.0,
>>>>> looking through the code, that wasn't the case. :) Which means =
that
>>>>> pblk doesn't work with a devices that implements 2.0. Yikes... I =
knew
>>>>> I had forgot a detail when support was added into pblk.
>>>> I think you misunderstood; pblk does support 2.0 devices. What =
happens
>>>> is that we transform the per chunk WP in 2.0 into the line bitmap =
to
>>>> simplify the lookup. The point being that we do not need to create =
a
>>>> fictional chunk for 1.2 devices since we do the translation to the
>>>> bitmap directly. Does this make sense?
>>>=20
>>> The chunk->wp isn't used anywhere. So it can't take wp into account.
>>> It uses the EMPTYPAGE marker from 1.2 instead. See pblk-core and
>>> pblk-recovery.
>> I see that the patches for this are still internal. Will post for =
4.20
>=20
> Thanks. Please also put a Fixes: on, so it gets backported =
appropriately.

Sure. I will.

--Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkUE8ACgkQIX4xUKFR
nnQM4A//cFy3JBs8FG/s466SuLWj5sXJMfOGcGCxJm0XE7Tz/elkMjQg3LvOXoYd
6rQI3QP+cvSvJtSU/Am/Mbptp9iaxzvmfyfhghhsmbdd0orHUrLz9hivL9VoTPpW
MRwhqx00/S2ND3DuOVhgJbZgI2dIcoC3R5JVGxug21iv130Cnp3a4SWAvvImqdIa
2FggTaoiQTYWl9Bcpf/x7Aj1RPlHmgoaphdbePufFyZzWNXKj0sBLWhQYfiA9MdH
pKMLk33CHbHm4yovQgSzm8DvbIDMA/nciYhyg9Bm6o0i2ksM3Gral/hvlUW26Asl
nQdsCsTkSbwdXGXf9eBya8nXWN4n9M9IRzeScalycDTnAcDH/LXsygMVTExG+iay
F01GfZgMVA3GWapCnxP/BRO5e1HaVRi07iaqvlLZfOew2zGOA/D88qawr2tTrW/L
1GydZ99t9yvZsp/8N081lokcKuKgfuozTqnT+RIoQ2U22/gOH1OMJNRUsGQVl3cI
1u95hMygXo+yxgq6KmWxkWsuheJlJB6ciADIy8eO3VzfrMWCiPG+IRV7QlvI27im
U7vWHTkETqgrmbCcqeElOvzOFTeKkSf0ukhvTIb4mhYnnyOn4nVV29mCB3btO9DT
Eo+qSoEMdddcbyrALj/QZSz3avTMTgje6i0S00Tpo5YWFFeBTGw=
=mLQz
-----END PGP SIGNATURE-----

--Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905--
