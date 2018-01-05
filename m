Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:45472
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751814AbeAET4d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jan 2018 14:56:33 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <m@bjorling.me>
CC: Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hans Holmberg (C)" <hans.holmberg@cnexlabs.com>
Subject: Re: [GIT PULL 18/25] lightnvm: set target over-provision on create
 ioctl
Date: Fri, 5 Jan 2018 19:56:31 +0000
Message-ID: <A85FDAC1-5A0C-4F09-AB6D-B08A388A918B@cnexlabs.com>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105131621.20808-19-m@bjorling.me>
 <fd47bd97-8ff7-1f6a-b07f-c86449ec1834@infradead.org>
 <D8E890A0-DBC8-4C0C-9AB9-62D9BB1CC9F2@cnexlabs.com>
 <05ea1992-8dae-f961-b2e0-a93727edc2b5@bjorling.me>
In-Reply-To: <05ea1992-8dae-f961-b2e0-a93727edc2b5@bjorling.me>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C4B71BC9-BF69-4AF9-982C-79F54FD9BF45";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_C4B71BC9-BF69-4AF9-982C-79F54FD9BF45
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Jan 2018, at 20.53, Matias Bj=C3=B8rling <m@bjorling.me> wrote:
>=20
> On 01/05/2018 08:52 PM, Javier Gonzalez wrote:
>>> On 5 Jan 2018, at 20.33, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>=20
>>> On 01/05/2018 05:16 AM, Matias Bj=C3=B8rling wrote:
>>>> From: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>>=20
>>>> Allow to set the over-provision percentage on target creation. In =
case
>>>> that the value is not provided, fall back to the default value set =
by
>>>> the target.
>>>>=20
>>>> In pblk, set the default OP to 11% of the total size of the device
>>>=20
>>>> +#define PBLK_DEFAULT_OP (11)
>>>=20
>>> Hi,
>>> Just curious -- where does 11 come from?  Is it a spec value?
>> 11 stands for 11% over-provisioning for the media to allow garbage
>> collection. Different SSDs have different values based on the =
targeted
>> workload - 11% is a common default value for standard drives.
>> The spec. does not specify any default values of over-provisioning.
>> Javier.
>=20
> I think what Randy means is, why is the value not 20% or 7%, which is =
the traditional over-provisioning on SSDs.

We decided 11% based on customer input, but 7% and 20% are also good
default values. I'm ok with having any of those as default - anyone
caring about OP will define the value on target creation, which is the
primary objective of this patch.

Javier

--Apple-Mail=_C4B71BC9-BF69-4AF9-982C-79F54FD9BF45
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlpP2GwACgkQIX4xUKFR
nnSI8w/+PtOAGBxelU7hMVLUQi/18SnffbqDQzCd1VYg25sLIP1GRby0vTYpJ1Iq
voO/3yNy4h0Bu/rQg99AS9R6bCxRHua8Bsr4c/zobRkebx6gmKJBIH307IzoEBDq
4iIX+mi+E6MEvcpbO6blvdbT/wI9iKhDctQ6/CrukeaFBrxd6D+jQIHNnvI78KCy
23/UJ1ODLmYZbL122xMMCHQXTj5RNdNw9oU1f7DAzhCKJC0C5ckYKFQp59chM+zM
NGb7XzNRYAiLMhdvJz1FM9vnxCwJe5HEhRnVDmhasu3v98c9tj+bQzRc0NF69Tug
EoM7k3YXQhVb1OGckyGehctDBHC8SRg1Zd3xpYxoRRmvAhR6a/1H7R6f9XGTMULJ
1PhWRDG/nEAMLB0tzi8rh9gKDDqk7CmljJClkg5B/le8TH2QjnFkFIQnAGznO6Cz
qyCzJhWYV1obh0lEuppj0D5uDIt5CUs0+ZZsF1fB3TdQcLrS4/3VA/rfCbV1JrcB
ApUNaaydi/BnxvEBYLE2nhIyqgpEJUpnLGgQ5lvwE/SKTGKNmPiskrNBvrl0H3lC
lt6IogwIJSsdertsyysB7wcZuYCZV4Th9bnW9dOc1li0+Esj+z7plfBFCQ/SJAbq
XdqU+X+DR7g41Y7BDgMt2uWZRdZARSIgEv49XEbcrOqpOMBFq3w=
=6MjL
-----END PGP SIGNATURE-----

--Apple-Mail=_C4B71BC9-BF69-4AF9-982C-79F54FD9BF45--
