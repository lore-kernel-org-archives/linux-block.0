Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr700063.outbound.protection.outlook.com ([40.107.70.63]:40871
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752742AbeGEHOn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Jul 2018 03:14:43 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: limit get chunk meta request size
Date: Thu, 5 Jul 2018 07:14:38 +0000
Message-ID: <FA6B99A4-5CDA-4F43-81B1-F05303F63EC1@cnexlabs.com>
References: <20180702080223.13214-1-mb@lightnvm.io>
 <C0B26672-CFD1-4058-A979-48341CD40F8D@cnexlabs.com>
 <dd3b8963-1f11-59a6-dc60-e0171687a727@lightnvm.io>
In-Reply-To: <dd3b8963-1f11-59a6-dc60-e0171687a727@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Jul 2018, at 21.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 07/03/2018 09:10 PM, Javier Gonzalez wrote:
>>> On 2 Jul 2018, at 10.02, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> For devices that does not specify a limit on its transfer size, the
>>> get_chk_meta command may send down a single I/O retrieving the full
>>> chunk metadata table. Resulting in large 2-4MB I/O requests. =
Instead,
>>> split up the I/Os to a maximum of 256KB and issue them separately to
>>> reduce memory requirements.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/nvme/host/lightnvm.c | 10 ++++++++--
>>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>> index b9989717418d..3b644b0e9713 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
>>> 	struct ppa_addr ppa;
>>> 	size_t left =3D nchks * sizeof(struct nvme_nvm_chk_meta);
>>> 	size_t log_pos, offset, len;
>>> -	int ret, i;
>>> +	int ret, i, max_len;
>>> +
>>> +	/*
>>> +	 * limit requests to maximum 256K to avoid issuing arbitrary =
large
>>> +	 * requests when the device does not specific a maximum transfer =
size.
>>> +	 */
>>> +	max_len =3D min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * =
1024);
>>>=20
>>> 	/* Normalize lba address space to obtain log offset */
>>> 	ppa.ppa =3D slba;
>>> @@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
>>> 	offset =3D log_pos * sizeof(struct nvme_nvm_chk_meta);
>>>=20
>>> 	while (left) {
>>> -		len =3D min_t(unsigned int, left, ctrl->max_hw_sectors =
<< 9);
>>> +		len =3D min_t(unsigned int, left, max_len);
>>>=20
>>> 		ret =3D nvme_get_log_ext(ctrl, ns, =
NVME_NVM_LOG_REPORT_CHUNK,
>>> 				dev_meta, len, offset);
>>> --
>>> 2.11.0
>> Is this a v2? I remember seeing this patch being posted before [1]. =
It
>> still looks good to me :)
>> [1] https://lkml.org/lkml/2018/6/12/466
>> Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>=20
> I changed the title. Since it didn't touch pblk. Thanks.

Makes sense. Thanks!


--Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls9xVsACgkQIX4xUKFR
nnQ9ExAAg/Pzp3qFuVQJ0rXvLCqter9ymRRB9tgqtvI1eroUvhMCF8S2P392N7FG
fm2Z+bO+0+BLhEFWbBhevlzhQCqsL/CpN4fMEVwhbG8tRZLLI6YF0mzoBGj3yiQd
k33nQHd0VF3bZW+w4BSo+ZLlg+A8ER8vpm/cXpBp7JiZVzj5msbSDVxX1/nP0E2f
izH4XmbcpBdS2UMblLcy2DrPB6zaH9q//JzM4x83vFGN3foNxeKMIty2LaA9tCe6
nAQMKFUaqyC4b/SpnylDKbWTnNoXiCRDnHyuLOjeG4Vh9pWW5de/WVMuoKy4OS2e
KJbhNYGMI0e7brobU8/DKw1+aZ/U+tMXf9RILrakCw4SkvyLvzHVO7ietMcgfmL7
e6i0Xm1/JwsqTUpz2+SCYW50Nv+otZzHlxWJoHEIXVAQ1zONlZhAjkSQRHfNNV7n
NTPX8sBfhKoaT2gUvoZHVxvL/VPo2AvfpWfte3Pyeusoj8pACyX18bUWUNR9b/xI
cD7BFDhR+SxgHQi6DXLdAPnQUmmZYZI6hPC/yk+AsAu2UVOvoyBNfFbZvrh0ESFd
nDhRe6+RwxFVo83oyJmg24RY6BzdaUkvyUMlTiw+WIjCfAUL0y9rb0jgEX7B3flK
4/RrOIWIabCd6G96XFdtkwOoRiAB+TcYmkXwvvkN64BGX98ug1o=
=3+q1
-----END PGP SIGNATURE-----

--Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05--
