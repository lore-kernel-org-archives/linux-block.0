Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0044.outbound.protection.outlook.com ([104.47.40.44]:30407
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751695AbdF1PTX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 11:19:23 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Javier Gonzalez <javier@cnexlabs.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <matias@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: LightNVM pblk: read/write of random kernel memory
Date: Wed, 28 Jun 2017 15:19:20 +0000
Message-ID: <D6B0829A-CC86-4F1D-9F5B-DC9768975972@cnexlabs.com>
References: <42c49a3a-447b-8a31-91b5-92264f196085@gmx.net>
 <BE9E3136-5D3F-44E7-ACE4-49FEC95B330A@cnexlabs.com>
 <7a0a2821-0007-7af0-7eb8-d58650123718@gmx.net>
 <CE85E6EB-69AF-4A02-B7DF-F70F2F7E54A3@cnexlabs.com>
 <4F70E259-B8AB-4C99-9ABC-4D7B6F7169DF@cnexlabs.com>
In-Reply-To: <4F70E259-B8AB-4C99-9ABC-4D7B6F7169DF@cnexlabs.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6CE5620C-4AD3-4904-A467-142BA5B1EE12";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_6CE5620C-4AD3-4904-A467-142BA5B1EE12
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 28 Jun 2017, at 17.15, Javier Gonzalez <javier@cnexlabs.com> wrote:
>=20
> On 28.06.2017 16:58, Javier Gonzalez wrote:
>>> On 28 Jun 2017, at 16.33, Carl-Daniel Hailfinger =
<c-d.hailfinger.devel.2006@gmx.net> wrote:
>>>=20
>>> thanks for the pointer to the github reporting page.
>>> I'll answer your questions here (to make then indexable by search
>>> engines in case someone else stumbles upon this) and link to newly
>>> created github issues for the various problems I encountered.
>> Ok. I answered each issue directly on the github. A couple og things
>> inline though, for completion.
>=20
> Thanks.
>=20
>=20
>>> On 28.06.2017 13:07, Javier Gonzalez wrote:
>>>> I'll take the question here, but please use our github [1] to =
report
>>>> errors and ask questions instead (including this thread). No need =
to
>>>> spam the rest of the linux-block mailing list for LightNVM specific
>>>> matters - unless of course, you want to discuss specific parts of =
the
>>>> code.
>>>>=20
>>>> [1] https://github.com/OpenChannelSSD
>>>>=20
>>>>> On 28 Jun 2017, at 01.30, Carl-Daniel Hailfinger =
<c-d.hailfinger.devel.2006@gmx.net> wrote:
>>>>>=20
>>>>> I'm currently having trouble with LightNVM pblk with kernel =
4.12-rc7 on
>>>>> Ubuntu 16.04.2 x86_64 in a Qemu VM using latest
>>>>> https://github.com/OpenChannelSSD/qemu-nvme .
>>>>>=20
>>>>> I'm creating a pblk device inside the VM with the following =
command:
>>>>> [...]
>>>>>=20
>>>>> This might either be a bug in the OpenChannelSSD qemu tree, or it =
might
>>>>> be a kernel bug.
>>>>>=20
>>>>> I also got warnings like the below:
>>>> In the 4.12 patches for pblk we do not have an error state machine. =
This
>>>> is, when writes fail on the device (on qemu in this case), we did =
not
>>>> communicate this to the application. This bad error handling =
results in
>>>> unexpected side-errors like the one you are experiencing. On the =
patches
>>>> for 4.13, we have implemented the error state machine, so this type =
of
>>>> errors should be better handled.
>>> Oh. Shouldn't a minimal version of those patches get merged into =
4.12
>>> (or 4.12-stable once 4.12 is released) to avoid releasing a kernel =
with
>>> a data corruption bug?
>> This is only in case the device fails, how we handle the error on the
>> host. If the device is not accepting writes for some reason, data is
>> lost anyway. So I don't think we need the fix for stable.
>=20
> This is odd. AFAICS qemu isn't configured to simulate device failure, =
so
> in theory this should never have happened. Can you think of any reason
> why this code path was triggered? Should I open a separate github =
issue
> for that?

Qemu does not simulate failures (though we have implemented error
injection for LightNVM), but if there is an error on the device
simulation then it will propagate to the host. Based on what I can see,
seems like your qemu instance is doing something funky and that most of
your errors are related, but we need to look deeper into it.

In any case, let's continue the discussion on the open github issues.

>=20
>>>> You can pick up the code from out github (linux.git - branch:
>>>> pblk.for-4.13) or take it directly form Jens' for-4.13/core
>>> Thanks. A full kernel compile will take some time, though. Do you =
happen
>>> to have a Ubuntu-compatible kernel .deb for the new code?
>> We thought about, but never actually did it (to share at least). I =
see
>> it might be useful :) For the time being, I'll share a minimal =
.config
>> for qemu, which takes a couple of minutes to compile.
>=20
> Thanks!
>=20
>=20
>>> [various bugs]
>>> Filed as https://github.com/OpenChannelSSD/linux/issues/28
>>> Filed as https://github.com/OpenChannelSSD/linux/issues/29
>>> Filed as https://github.com/OpenChannelSSD/linux/issues/30
>>> Filed as https://github.com/OpenChannelSSD/linux/issues/31
>>>=20
>>> Regards,
>>> Carl-Daniel
>> Javier
>=20
> Regards,
> Carl-Daniel

Javier

--Apple-Mail=_6CE5620C-4AD3-4904-A467-142BA5B1EE12
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZU8j3AAoJECF+MVChUZ50ZJcP/AnthbAP9CSXowAaXtUn/SzJ
kwjxQ3GkPsTIpMOTKf69Xg++GUAveJCXTXkRkf4YKJ6F3fpZbXGgS3cuF0yYJs63
eTtL47B8d+wc223OzO04jlgjJFQ8GiIqPAE2NnDX53oEPbOWA+gD4re1UOT5epX6
cRCZIiCelmdC2Uqjv8X8iNI1yYAOKxBMoM2ErNwVHXERYkGmTcfiaNxMHF3Lhyyn
v+4MPxL4PCIHm5L+QmZXvvRXBpZKtCdsn2VQizMfZRSzm0paSwveMPso5RdBy+FP
ZXUAbhzCdajv37xqeFUzKj1B1OsvpAIbh05WPNvlD3fj4PU/kNP0lm7OPYX20Z/g
b4XLEelooW3TbIbbPzCjNu5vw2Ujb9jYd0tUEEBm93qJYNwjtcp1ziiO+8MQ9cUv
PpnbSm0UKSu9ceKHdOrOMFnUiDWEH6yobBZ1rKJqZh6VJZHT/2SF5XPFQPw6tefE
eKR/MLDNPqMHOVDFZ3VOPRq+nvPKrLi3/WcOkE2lOX/0+r2f7wb1wK3qtV+NcIyF
tkNBzZtCnYB/uELZMPY+y87rHOwyJlyp6YU6JKnehMYC3vVcMvRX6CFd+JGK5hAS
mTXZG+VDvQnm6IMPAEt5LP+T3IRlGLPFdME1/UUc6G4UwcdeJMw4MMn5y+1J9Jp/
wr+DnDwV8yX1OzgNEhPL
=t5JD
-----END PGP SIGNATURE-----

--Apple-Mail=_6CE5620C-4AD3-4904-A467-142BA5B1EE12--
