Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0071.outbound.protection.outlook.com ([104.47.32.71]:53220
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751731AbeAETwX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jan 2018 14:52:23 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <m@bjorling.me>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hans Holmberg (C)" <hans.holmberg@cnexlabs.com>
Subject: Re: [GIT PULL 18/25] lightnvm: set target over-provision on create
 ioctl
Date: Fri, 5 Jan 2018 19:52:19 +0000
Message-ID: <D8E890A0-DBC8-4C0C-9AB9-62D9BB1CC9F2@cnexlabs.com>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105131621.20808-19-m@bjorling.me>
 <fd47bd97-8ff7-1f6a-b07f-c86449ec1834@infradead.org>
In-Reply-To: <fd47bd97-8ff7-1f6a-b07f-c86449ec1834@infradead.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BC6B9242-2A54-430A-B6D9-7B7FDC8AC5ED";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_BC6B9242-2A54-430A-B6D9-7B7FDC8AC5ED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Jan 2018, at 20.33, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> On 01/05/2018 05:16 AM, Matias Bj=C3=B8rling wrote:
>> From: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>=20
>> Allow to set the over-provision percentage on target creation. In =
case
>> that the value is not provided, fall back to the default value set by
>> the target.
>>=20
>> In pblk, set the default OP to 11% of the total size of the device
>=20
>> +#define PBLK_DEFAULT_OP (11)
>=20
> Hi,
> Just curious -- where does 11 come from?  Is it a spec value?

11 stands for 11% over-provisioning for the media to allow garbage
collection. Different SSDs have different values based on the targeted
workload - 11% is a common default value for standard drives.

The spec. does not specify any default values of over-provisioning.

Javier.

--Apple-Mail=_BC6B9242-2A54-430A-B6D9-7B7FDC8AC5ED
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlpP13AACgkQIX4xUKFR
nnRCGxAAshqygckW9gUIzRe1LnUDWD3ZzGnBqSZvYedC7RGPQJbH6mmNVhKmqORf
hZ4aJRKgOqVwf2eO8LWWvzgRb4h90ttcVV4uDM4VkWnUYkeE4PFdI/5qtnnvuYz6
50F0YLlD70KvYI55HfPjM+I3Bz1y+fLby2LB0ruJW/8AeCALMnnO4CzJenIGVVrN
grUsLXHvYchiRgeCFcectD7spaUboX7gUOg2T04ZjFU9PTKqtp2xRlk9ay8+GaMP
FaqF7l67CCN+DK9Z2nJF/ybKtvTGm57a/mYg4DUr/C+JuRd7aGi2V2+PbNr8rFht
/I09lFoxURs4rnrnUtc2R6v+1mBYkWFTe3tXCNQkNmX2s6tiqMeWUMmVCyGlNeO+
GMvHkLKutkFfUBKvdR/3jXUnCYgNnA8XbJkglNN19sJ7BoxwlL3BZ8ca/YrCLdmb
RqygFc7Z4kpRcix5B68sEh+vya9AoMK4YnbcjV3mp6+P8rPvU8txV5p4Vty5BYDv
ptAiMeyturRZA3TQ7VDjYTXPCfpcwz3vwlN32ZeVezs+2OoKQsM8juSI54TOZ/2H
rbKZnk43zG7315o7LVkW1lW/AuFFxCFSASCC66CwXagPXV+NL417JYnxPYEzEMIZ
Rg7B7VVD0ZIMjyBFqSA5yBJIFmdefk/bslg8FEl3tHAtcClYy5U=
=5GRX
-----END PGP SIGNATURE-----

--Apple-Mail=_BC6B9242-2A54-430A-B6D9-7B7FDC8AC5ED--
