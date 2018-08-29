Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr710069.outbound.protection.outlook.com ([40.107.71.69]:60019
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2RH7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 13:07:59 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: add helpers for chunk addresses
Date: Wed, 29 Aug 2018 13:10:50 +0000
Message-ID: <A4C9F089-0BCF-4753-B3C7-AE166A14D489@cnexlabs.com>
References: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
 <742b25cb-c871-2ef4-d34c-a81bce9283a8@lightnvm.io>
In-Reply-To: <742b25cb-c871-2ef4-d34c-a81bce9283a8@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 14.36, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 10:37 AM, Javier Gonz=C3=A1lez wrote:
>> Implement helpers to go from ppas to a chunk within a line and an
>> address within a chunk.
>> These helpers will be used on the patches adding trace support in =
pblk,
>> which will be sent in this window.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk.h | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index be67bbfa3d0a..1bfbd3315598 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -1034,6 +1034,37 @@ static inline struct ppa_addr =
addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
>>  	return ppa;
>>  }
>>  +static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct =
pblk *pblk,
>> +							struct ppa_addr =
p)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line *line =3D &pblk->lines[pblk_ppa_to_line(p)];
>> +	int pos =3D pblk_ppa_to_pos(geo, p);
>> +
>> +	return &line->chks[pos];
>> +}
>> +
>> +static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
>> +							struct ppa_addr =
p)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	u64 caddr;
>> +
>> +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>=20
> Please move this into core.

Wanted to wait until the rest of address conversions were moved, but you
can get a v2 for this.

Javier

--Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGm1cACgkQIX4xUKFR
nnTLvBAA0IB02fccBh8LAzNH9mgm3hVvwZD+k/EvxjrZQAoheRNHRd7qSegE90pO
b4OQdAGZns1wkljHnZAZpr94qKMC34lDL43DcMqHL15mLF0NeSHWr9W9Isqe454T
vR+8aq3+j2Qzzy3uUiEad8uscUUM12xFX2Ff+R4bpRAXR6D3WWtpw4m/z19TXe2m
2YMye629jp3IpB+wC3nn16PIWEml8JrDrEfk51lroaYkb8a9FlCjAq26p/i8fpqd
8nnwIPIZ+zsxs8Aw7Gf7xOjcIDVC4yKuTCIUgrrxXB2DYQxOciTMkaI3jJTG/xIF
N9V1wCzLTag8Nd48pvIpkrCAyz4fiwG/8MjAO9OAqRrbo4zQzRlS/na5S2sn7sp3
ckbaYuq3kdZqHGlM6/W6Vg56hG8UfmpYpfFCi/W7NjTJQqxHayirNxuQe+eQdVVh
phiUponvgsGqj7g8g4JYIC0aiOvKHXTFNa30CwKlCODRnUHjGZX+sFXOC8X9ICb0
WvAbsdmY/wXiZF2wRCKeaeuq0mH7DzCiHghgVSBbztUTkD5fasdG+BAp0mwHKTw0
FpVlk3XViSW+4FGxuawOV9PfU/NkPrFpb94Tx9mHho40iJ5B3BBMvRmB5hh8wpYE
nmh3eSaPtj6+ZWfVebYi5rWE7twZzu0IIQNpSC7MqyXgDmiEpPs=
=8zp5
-----END PGP SIGNATURE-----

--Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F--
