Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:64032
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750818AbeBDKhm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 4 Feb 2018 05:37:42 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Date: Sun, 4 Feb 2018 10:37:39 +0000
Message-ID: <DEB69E27-635B-4B4F-ABA4-08BEC14B291F@cnexlabs.com>
References: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
 <1517364411-22386-5-git-send-email-javier@cnexlabs.com>
 <bdde0655-0904-0bf1-7029-51708fcff8b3@lightnvm.io>
 <F1AA3AA6-8F23-43A8-9C4C-5F684A80782C@cnexlabs.com>
 <33896b20-c555-7c60-ed47-28156f4c93bf@lightnvm.io>
In-Reply-To: <33896b20-c555-7c60-ed47-28156f4c93bf@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 31 Jan 2018, at 19.24, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 01/31/2018 10:13 AM, Javier Gonzalez wrote:
>>> On 31 Jan 2018, at 16.51, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>> I have a patches abstracting this, which I think it makes it cleaner. =
I can push it next week for review. I=E2=80=99m traveling this week. (If =
you want to get a glimpse I can point you to the code).
>=20
> Yes, please do. Thanks

This is the release candidate for 2.0 support based on 4.17. I'll rebase
on top of you 2.0 support. We'll see if all changes make it to 4.17
then.

https://github.com/OpenChannelSSD/linux/tree/for-4.17/spec20

Javier

--Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlp24nUACgkQIX4xUKFR
nnQ7LRAAtDotghsKBW/aWyeDw4WdKX9eMGcFOduPuw2Ub73JheSsGWjLA55PFHV8
WhuLhHanLrGm7NeIdckXoOaGQ05ZsHZySz5d5wx9SY4pPKo2p8ZSKRa8CNyXhzdk
RFpx5M5ZGaDMBruIWdRUh3aYaZKJEAubQobi2cEFC0DAJr9xA2I8Hmx7qYzgth7k
2QvHytDU1lcurYUp88JQ6VV3g42Loayy5lUI+M+rvlCuJcIuebz4LWF7XHRrmsei
8SJGg6nZzist5XymmrlaLrACEt28QG9yztcZpbG0MWO2UrOGwk+M+bptn9PCFzbC
7cTBvOMemcjeg1i3qnPRcNMiv5P1LOt77xy1cxwVF7tBrhSBxGvgEZv1v+X3Bcg5
63vc7BhnupG+FqfrGhsCyIT+VUbMKqM11S2T2pBSR/o3fSII6hUSvCLazBUxExTH
1krlckrV/0j4Rnx0nTKhket///sSXcrauKyH4o5aQC7v5T5re+U+2MhtE7MUgemJ
7HCOH4re6pnCr5Wh0pAeOgqeuOIN8S24wRgUYwD5ZDdKUTaQ3ezgdG0ITUSBs0tB
MylUyZxAXRQ6fLqRKT6RgsAlgIYqfG57XnL2GkvoqJB4gBc7Q+RFSiVU3aL1Ys1S
89XXxyULKGzMFBcjUqXk3p1fSHlC/lxCuhxSRJVJjtGYSEBkwvU=
=KPSN
-----END PGP SIGNATURE-----

--Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934--
