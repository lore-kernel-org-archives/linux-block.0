Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:58872
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934285AbeFROZJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jun 2018 10:25:09 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 2/5] lightnvm: pblk: Remove resv field for sec meta
Date: Mon, 18 Jun 2018 14:25:06 +0000
Message-ID: <40AA2413-9E0B-4079-AE14-703902324CF5@cnexlabs.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-3-igor.j.konopko@intel.com>
 <c3723e66-9183-6ee3-c780-06e4f012a844@lightnvm.io>
In-Reply-To: <c3723e66-9183-6ee3-c780-06e4f012a844@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_303D0929-9072-4170-8DD5-B44E7C3CC99F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_303D0929-9072-4170-8DD5-B44E7C3CC99F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Jun 2018, at 21.27, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/16/2018 12:27 AM, Igor Konopko wrote:
>> Since we have flexible size of pblk_sec_meta
>> which depends on drive metadata size we can
>> remove not needed reserved field from that
>> structure
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>  drivers/lightnvm/pblk.h | 1 -
>>  1 file changed, 1 deletion(-)
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index f82c3a0b0de5..27658dc6fc1a 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -82,7 +82,6 @@ enum {
>>  };
>>    struct pblk_sec_meta {
>> -	u64 reserved;
>>  	__le64 lba;
>>  };
>>=20
>=20
> Looks good to me. Javier may have some comment on this, since it is
> not completely obvious from the code why that reserved attribute is
> there. I do like the change to go in, as it needlessly extends the
> requirement from 8 to 16bytes.

Looks good to me. Maybe marge this patch with 1/5? It was actually a
comment I added to it.

--Apple-Mail=_303D0929-9072-4170-8DD5-B44E7C3CC99F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsnwL4ACgkQIX4xUKFR
nnSRMBAA3ckaIyNKrm32W1XS1cbL4dVIuAmpjOk48DcYmDmUf5sbZXjhsv7fOyDr
BAzevnLlKrSnPAsemSYgilY9n+gWyYkffGcEaxsKgd4NaYFYpm10ExsJNTieLpWQ
fpqlwR1stpImAcpcJyrGIqNjZ23EpRDhewHie3/9/o5H4H0HoIcEydLVaEjQDXNP
KhJ/Ja/p/V2oN5OhQZ9w6Ld4HYeiBKTfydkwc5FFlAw0/knmxI+MvtF43Z59zudZ
AznXJpdFYuwPb2oApTbYizKSDWNsS1LukWxxfCMCKIFe5wezFx+FkmCN0sdxR39Q
30Hnv3yZNkRw89Q/1KQo/oy09Azzak7DUq/Jv32DmYMxsV1D7AqriNJWkIo6YAPN
AhqEqCoFs788J0+QoRcTeGFQm8XqLpk5d20WyPzIm98V4UTdx2PjdWIN3P+R6067
ZMtn+1FYfrf2tZ7ovv8tAz6WnRinxLxHmeJO0qGA3b1C/CkF1hdzB7d8cXl1LGiQ
lS7Rv2d3kvGeMh12ch+4e3i5HnEMdGbBVL7QKkYQTO+Z+pVir2/S8Kfc9qWBJK/Z
G3pED4N2s5oYAfkXK8G60DEUNGSFq02NQDslblUrXzkLyFu/JVFPnDOQKxc799AY
6cVxQhcTEzcc2xeIG7NCVO9Bk5LIMOgCxrE92kTlKRGoLyAGbpc=
=aNsQ
-----END PGP SIGNATURE-----

--Apple-Mail=_303D0929-9072-4170-8DD5-B44E7C3CC99F--
