Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:16168
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbeIDVmP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Sep 2018 17:42:15 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
Date: Tue, 4 Sep 2018 17:16:07 +0000
Message-ID: <9D0772CA-73AE-41AC-A489-4187185C696D@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
 <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
 <95ae2794-c671-5dc7-3a2d-2b062ea86fba@lightnvm.io>
In-Reply-To: <95ae2794-c671-5dc7-3a2d-2b062ea86fba@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Sep 2018, at 02.54, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/03/2018 11:16 AM, Javier Gonzalez wrote:
>>> On 31 Aug 2018, at 15.57, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/31/2018 03:34 PM, Javier Gonz=C3=A1lez wrote:
>>>> Matias,
>>>> This patchset implements support for retrieving chunk metadata when
>>>> submitting a reset/erase command. Patches 0 and 1 are small fixes =
that
>>>> can be directly merged into your patch:
>>>>      lightnvm: move bad block and chunk state logic to core
>>>> Also, note that these do not apply on top of your for-4.20/core due =
them
>>>> depending on patches that I sent before that you have not picked up =
yet.
>>>> You can see them though in for-4.20/pblk. I'll rebase as patches in =
the
>>>> list appear in your tree.
>>>=20
>>> Thanks. It is really confusing when you guys maintains an implicit =
order and posts the patches separately. I will appreciate that patches =
that are related are posted together, such that I don't have to manually =
track what comes before another. That makes it less of a pain for me to =
keep track of and we can keep the reviews together.
>>>=20
>>> This is the patches that I have in the pipeline (from before the =
e-mails from today):
>>>=20
>>>  - This serie - Pending review
>>>  - Serie: pblk: support variable OOB size - Waiting on review from =
Igor
>>>  - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't =
apply due to the fixes to the pad distance patch.
>> Yes, I know and I apologize - we should have a better flow. What do =
you
>> say that for windows like this, where we have a number of patches =
that
>> have dependencies that we post them in meaningful patchsets and point =
to
>> a branch where they are ordered, like in a PR? Then we can rebase and
>> propagate changes properly?
>=20
> I am with the patchset posted, that should have the order. I just
> wanted to mention it. One thing that would be good, if you do have
> patches you have upstream, feel free to push them in smaller
> increments, so we can pull them in as we go. Only a nitpick, it is
> obviously up to you guys how you want to do it :)
>=20

Sure. If we can improve the workflow to make things easier for you, then
we should.


--Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluOvdQACgkQIX4xUKFR
nnTi1g//dRvNzCyRxxqd8KxuQNss4wYOojWUYeAaz4hw9Loqp3Kgo0TLCUScWT26
IJgtxC9MAws2ArCbWTmhEKF4KVbHtnmUHkut9L85BV4L+eCIUqzYfufH9tYNTKEb
aigmd+6BTdS2G7g60AIBmSoqK0ZDCQgsQfCaavdii24FWOrx47CXT0kzUmcvPhGD
4mfNRusdSbfZcyoBVDT+tJTRzg3XG+rkY0b6Stxzn+IoVNumCE6HpPCtq9bYPDmx
VbJfJrL/8kiw0v8cUvjWtOsL3uE+QW/AylzFRHenWWI3fK0O/wdfCfGnhlDJiXdR
Z02f91WYupNrIL5be5ywBuQ+dYtE2YUotDnxJi7TJHzTcEo0Xq6IoKgJ2faeASgf
aiOMZwfTYCAXHEuRLF/wTQJfXqBVftF6PNhlpfz0mRPAiDx0rizgKufw9YEiut9o
ucwgReS/LiF2qjjZCkztjnCCQyxjjaPglODiLtO4UjHSeGvT+ieXx3dBEoc/9gHN
tgpgJ/a4J2woBSmdlO7OPBWiRRAkCVCORhXfMXF8mBxyndscnN8pKhii1AGGap1U
wYoAKTcW46v26x3VDVWG13muk0Gc+zEtcfv3rE44TMj7JgPsu7zmpF9ybqPkVCZs
w4yjJlbcJcRxM+UMgkpw8Nj5G2ATdNqa38TwmPvQwLygyAzoEJE=
=H9Ci
-----END PGP SIGNATURE-----

--Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F--
