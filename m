Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0072.outbound.protection.outlook.com ([104.47.34.72]:31744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730129AbeHCOeA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:34:00 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Date: Fri, 3 Aug 2018 12:37:45 +0000
Message-ID: <F7B041D7-4E55-4B26-A263-9289C4616223@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
 <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
 <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
 <88659F4F-8105-41CA-B0B8-849E707F18CD@cnexlabs.com>
 <423c5d4b-6d9a-d233-d3da-f2cb8b10f880@lightnvm.io>
In-Reply-To: <423c5d4b-6d9a-d233-d3da-f2cb8b10f880@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:02 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 13.57, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 07/24/2018 09:54 AM, Javier Gonzalez wrote:
>>>>> On 29 Jun 2018, at 13.28, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 06/29/2018 01:22 PM, Javier Gonzalez wrote:
>>>>>>> On 29 Jun 2018, at 13.14, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> On 06/28/2018 11:12 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>> The Open-Channel 1.2 spec does not define a mechanism for the =
host to
>>>>>>>> recover the block (chunk) state. As a consequence, a newly =
format device
>>>>>>>> will need to reconstruct the state. Currently, pblk assumes =
that blocks
>>>>>>>> are not erased, which might cause double-erases in case that =
the device
>>>>>>>> does not protect itself against them (which is not specified in =
the spec
>>>>>>>> either).
>>>>>>>=20
>>>>>>> It should not be specified in the spec. It is up to the device =
to handle
>>>>>>> double erases and not do it.
>>>>>>>=20
>>>>>>>> This patch, reconstructs the state based on read errors. If the =
first
>>>>>>>> sector of a block returns and empty page =
(NVM_RSP_ERR_EMPTYPAGE), then
>>>>>>>> the block s marked free, i.e., erased and ready to be used
>>>>>>>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>>>>>>>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not =
fully
>>>>>>>> written, it has to be erased in order to be used again.
>>>>>>>=20
>>>>>>> Should we extend it to do the scan, and update the write pointer =
as
>>>>>>> well? I think this kind of feature already is baked into pblk?
>>>>>> This is already in place: we scan until empty page and take it =
from
>>>>>> there. This patch is only for the case in which we start a pblk =
instance
>>>>>> form scratch. On a device already owned by pblk, we would not =
have the
>>>>>> problem we are trying to solve here because we know the state.
>>>>>=20
>>>>> Agree. What I meant was that when we anyway are recovering the =
state,
>>>>> we could just as well update ->wp and set to NVM_CHK_ST_OPEN and =
so
>>>>> forth for the initialization phase.
>>>> In 1.2 the use of chunk metadata is purely fictional. We respect =
the
>>>> chunk state machine as we transition lines, but all the write =
pointers
>>>> are ignored. Instead, we use the line bitmap to point to the next
>>>> writable entry. This is BTW the same way we it in open lines on 2.0 =
too.
>>>=20
>>> Now I understand where you are coming from. I had the understanding
>>> that we where using the write pointer now that we moved to 2.0,
>>> looking through the code, that wasn't the case. :) Which means that
>>> pblk doesn't work with a devices that implements 2.0. Yikes... I =
knew
>>> I had forgot a detail when support was added into pblk.
>> I think you misunderstood; pblk does support 2.0 devices. What =
happens
>> is that we transform the per chunk WP in 2.0 into the line bitmap to
>> simplify the lookup. The point being that we do not need to create a
>> fictional chunk for 1.2 devices since we do the translation to the
>> bitmap directly. Does this make sense?
>=20
> The chunk->wp isn't used anywhere. So it can't take wp into account.
> It uses the EMPTYPAGE marker from 1.2 instead. See pblk-core and
> pblk-recovery.
>=20

I see that the patches for this are still internal. Will post for 4.20

>>> There are no empty sector marker in the 2.0 spec, since it uses the
>>> write pointer to know where it is in the chunk. So there is a bit of
>>> work to do there.
>> Yes. And for 2.0 devices we go and look at the WP, but for 1.2 =
devices we
>> need to scan.
>>> Since this properly is a bit more work to do, I'll look into it =
after FMS.
>> Look the comments above. All we need for 2.0 support is in place. We =
can
>> talk about it f2f.
>>> I'm also moving the explicit coding of 1.2/2.0 chunk / bad block
>>> fixing into core, so pblk can be simplfied, and doesn't have to =
think
>>> to manage each version separately.
>> Good. I have a patch I was expecting to send after FMS for moving =
chunk
>> / bad block out of pblk for the same reason. If you're doing the same
>> thing I can stop looking into it...
>=20
> I am, will post when done.

Cool!

Javier


--Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkTJcACgkQIX4xUKFR
nnTNHw/9G4WDVFkwkzZr44wYAscR6zPnq5j1OcB/+t85381hPUITrse08da1dePq
KZ8SuD0tAjathPfSLsuf31NqvCqXqWDA24EkNdxWSoakIUM2/8cjg+5myXKKTZM/
8jxQ0430haJNShRJBm1UkKYT7Mboigh+qWjiA4xhHmia9OX3VYOX6umVJaW+gg9l
pMxSPUzr9T2nFCGgjL1Is3IJAa8cDOTZfPUX9De59Q2D/iTxSndTh8H2Uod1AX8+
DpzLE7Ix73hSS23gh/P+PkRv10oISSgqx4tZWIXmKkS9IRwXWtSCUus/wZWtWh6q
X3bCWl3w/y5PEqptahyjWqS2LDmpJpLAw1FZJdloNXnZFuM/HeVMFuONaZN7AALs
CLsPbbKgwcZixPVIksFP+RdyH0TfDuFmKqmu7rs405Ja2wu0c1R5KjwkGPBBk0PV
OX3Ri60IyFna9Y0lxio0WJ0jaijumo+7IODM4jOEJaY5GbV429mz+pF2fkQtYhB3
B83JAhtrtbyefWo9U4TPAswoOv8Bsl8PY/rGhFhdoLBP4QnZu9YtuQF+7qndw3IJ
uzMLANhns/6bzaPUlKD0Y6NmsH4BKLtjeT3ESl8IRg30g5UxaxT7tVbAD9JPhsHH
1z8+KycRaWhTniKJomkduvVz7hmgnbfx+Pny0h2MQt5pyYXa8T0=
=ml0d
-----END PGP SIGNATURE-----

--Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB--
