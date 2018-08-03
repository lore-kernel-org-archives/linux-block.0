Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0064.outbound.protection.outlook.com ([104.47.42.64]:55856
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728300AbeHCPPj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 11:15:39 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
Date: Fri, 3 Aug 2018 13:19:15 +0000
Message-ID: <62385844-6194-4345-B482-D0637EA2718E@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
 <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
 <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
 <B2E9F490-32FD-49C5-906D-994762E7191D@cnexlabs.com>
 <e0be455d-2586-fea8-a554-2796b08dd5ff@lightnvm.io>
In-Reply-To: <e0be455d-2586-fea8-a554-2796b08dd5ff@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 15.01, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:55 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 14.43, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/03/2018 02:40 PM, Javier Gonzalez wrote:
>>>>> On 3 Aug 2018, at 14.37, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>>>>>> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> A 1.2 device is able to manage the logical to physical mapping
>>>>>>> table internally or leave it to the host.
>>>>>>>=20
>>>>>>> A target only supports one of those approaches, and therefore =
must
>>>>>>> check on initialization. Move this check to core to avoid each =
target
>>>>>>> implement the check.
>>>>>>>=20
>>>>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>>>>> ---
>>>>>> I see where you want to go with these changes, but the way =
targets are
>>>>>> layered on top of the LightNVM subsystem does not align with it.
>>>>>> LightNVM can support different OCSSD versions and capabilities, =
but that
>>>>>> does not mean that a target (e.g., pblk) does. The way I see it, =
core
>>>>>> should only check for (i) the drive to expose itself in a known =
revision
>>>>>> and (ii) the reported structures to be consistent. However, =
specific
>>>>>> functionality is not for core to check upo.
>>>>>=20
>>>>> Why try to initialize a target, if we already know that it is =
incompatible?
>>>> Yes, that is my point. But the one who knows if the targets =
supports
>>>> something or not is the target, not the subsystem. Here, you are =
making
>>>> an assumption knowing the pblk requires the L2P on the host, but =
that
>>>> could change in the future...
>>>=20
>>> I don't believe it can. It is not supported by the 2.0 =
specification.
>>> 1.2 is legacy.
>> Ja... We both know that people is using 1.2 variants out there...
>=20
> Yes, I'm not saying that. I'm saying the spec 1.2 has been deprecated
> by 2.0 and no longer developed,

But we need to maintain it either way.

> and I'm not going to move that brainfart into the 2.0 spec :)

I would not ask you to. Luckily, no-one has asked for it yet...

>>> I understand this from the perspective when checking for un-even
>>> configurations using the geometry. But this is a spec =
incompatibility,
>>> which I don't think the target should care about.
>> I see the point of not having this check in pblk since we know that =
we
>> are moving towards 2.0 and leaving 1.2 as legacy/not-upstream. But =
does
>> it really make sense to fail LightNVM on a 1.2 capability that is =
spec.
>> compliant? For all we know people could have this and use it from =
user
>> space or through an internal target.
>=20
> It only fails on target creation, not on disk initialization. The disk
> will be up so user-space and targets that implements. Is that a
> problem?

My only point is that there are different responsibilities for core and
targets and some things are supported by 1.2 and not by 2.0, but that is
ok. If someone wants to create a hybrid 1.2 device on top of LightNVN -
in my view -, they should be allowed to.

Anyway, this is more a general layering discussion than actual
opposition to the patch itself.

Javier

--Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkVlAACgkQIX4xUKFR
nnRFVQ/7B2MabSVU+FJi6c4gbKpoZSwIY+BisMUKc4ICUljPr+WhwpIqmc/FecdN
qeePUu5HUZH1NtQWi2k008ZoUMJVXAjQ2AxPlIllO5oAne+hhTuaxdUfGb6IhHz8
meG3f05ITP+SONpAdJR+LZNjyJWBKT3y/65XKiC4Ui88aszoBHtwJHtvqJe7oABL
5QwJAH6TOH58meogZmRGxGn6poOTwk3SbxzMfip4gsyzQIoGwzi4CRd2SCfechFC
9hOqqaua7oM+nh2KOBCQB2P/LLXUE15eozP0MNnpuVdokm6yCMHtdy2YmNbRTfKI
Rd5egUeTKD4fzH/ahN1v3bRmhigxa6PRqLjiVCo1dkAohyBJ9Rxvdj0SjeViHqXP
e6xkSEQFM7tHP9+G9T+JC8XtziGsGeUdD5lcZFwMzotMC73UrRzI+H7BzOQe86zW
CKhZyp8IND2o5A8iWaPFbO4dLG++TSxXKVnTesJFpjkTXrlSmf4K7b4zOBxzHe0z
jg+trmGAIERpeAdOPs2oF24nhqAWUBlUxORYhQm9j5wfKCwUuLmQn0qMFjww07ev
WlCEyB8jHl0ND2zFWgFfD2NqJKlUtYLsuPwCJKJK3bDANewb7tYWv0ZLJuE19vNT
QyOcJmwXdk8hy7EbykOjwXMDj/sHCL5+zt7n1p7E3KdjfkDzPGQ=
=uwB9
-----END PGP SIGNATURE-----

--Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A--
