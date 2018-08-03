Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:8744
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728524AbeHCOwJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:52:09 -0400
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
Date: Fri, 3 Aug 2018 12:55:46 +0000
Message-ID: <B2E9F490-32FD-49C5-906D-994762E7191D@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
 <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
 <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
In-Reply-To: <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.43, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:40 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 14.37, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>>>> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> A 1.2 device is able to manage the logical to physical mapping
>>>>> table internally or leave it to the host.
>>>>>=20
>>>>> A target only supports one of those approaches, and therefore must
>>>>> check on initialization. Move this check to core to avoid each =
target
>>>>> implement the check.
>>>>>=20
>>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>>> ---
>>>> I see where you want to go with these changes, but the way targets =
are
>>>> layered on top of the LightNVM subsystem does not align with it.
>>>> LightNVM can support different OCSSD versions and capabilities, but =
that
>>>> does not mean that a target (e.g., pblk) does. The way I see it, =
core
>>>> should only check for (i) the drive to expose itself in a known =
revision
>>>> and (ii) the reported structures to be consistent. However, =
specific
>>>> functionality is not for core to check upo.
>>>=20
>>> Why try to initialize a target, if we already know that it is =
incompatible?
>> Yes, that is my point. But the one who knows if the targets supports
>> something or not is the target, not the subsystem. Here, you are =
making
>> an assumption knowing the pblk requires the L2P on the host, but that
>> could change in the future...
>=20
> I don't believe it can. It is not supported by the 2.0 specification.
> 1.2 is legacy.
>=20

Ja... We both know that people is using 1.2 variants out there...

> I understand this from the perspective when checking for un-even
> configurations using the geometry. But this is a spec incompatibility,
> which I don't think the target should care about.

I see the point of not having this check in pblk since we know that we
are moving towards 2.0 and leaving 1.2 as legacy/not-upstream. But does
it really make sense to fail LightNVM on a 1.2 capability that is spec.
compliant? For all we know people could have this and use it from user
space or through an internal target.

Javier

--Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkUMcACgkQIX4xUKFR
nnTZqRAAg8yQSKq2zMa3nnuN0xqzJ8+XFrL5bjOH1dKxxiMHEFzr5VjdQ9Bs7iy5
R99pKtWqfYwrqh+vjSww031hgbjw8ofS0VL4TqFA0Wqx8Tpks6XS4to0BqqDscsH
9lquaUqc23PiRuFBJIYQGjN/ySyQQgtT444Pzr+d7dAxzkNBeyTyzdr3wPCmeii+
1MT9UfRj05B4AbMPDh1QB35wu6rf2jk+piYYCstrivFeml41C7xC5qC7hXNYaICS
3a+JEoNhhN6Fdh344u4h0jfVVNjIq13g7YGi7c4j8HKO9xz+2Xhd5SFkGW9h4/q4
69aQQSlj38V623navu5R777xsuZkbij7BZVrLXkr5FxApp5NHQcWsZ/27CuJS+7n
1dUUmsqYY5b0wtgnEn7TbWBXiSelXNMXkoQB+J9d4Km5oyrxdCoPpEXXPkRIA+c2
Uwk5tgqfrpK6ElNO9luyzufUlLwQO15DZZjP887rb8JP34Vx7zlPByigmqJILm9v
nDQiJxFZbCQMOdCaFFWAMfBVL231ho42oiKIbnyGPlzPuiGFcoE6MKVaPRlBxjiF
G+VLGazAtYyE1o8R11AlEOUvhu9S4h4xGbqf+oMZLm8Qfuj+hukDpAOIBmUgQtTD
RWxcCJOv5todQzehujWStVQrnENGCpuSMuOvH1wTC2EsGHUDNzQ=
=uJK3
-----END PGP SIGNATURE-----

--Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6--
