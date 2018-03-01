Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com ([104.47.36.52]:61168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967435AbeCALCz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Mar 2018 06:02:55 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/15] lightnvm: implement get log report chunk helpers
Date: Thu, 1 Mar 2018 11:02:52 +0000
Message-ID: <B6B4086D-DA0B-41FF-AFB4-5E752F18CD01@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
 <1519832975-25432-10-git-send-email-javier@cnexlabs.com>
 <4c82d581-d8bf-25fb-26ea-48b26e6de899@lightnvm.io>
In-Reply-To: <4c82d581-d8bf-25fb-26ea-48b26e6de899@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F0C456E6-94BC-4B21-A030-8CF4E400683F";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_F0C456E6-94BC-4B21-A030-8CF4E400683F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Mar 2018, at 11.40, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/28/2018 04:49 PM, Javier Gonz=C3=A1lez wrote:
>> The 2.0 spec provides a report chunk log page that can be retrieved
>> using the stangard nvme get log page. This replaces the dedicated
>> get/put bad block table in 1.2.
>> This patch implements the helper functions to allow targets retrieve =
the
>> chunk metadata using get log page. It makes nvme_get_log_ext =
available
>> outside of nvme core so that we can use it form lightnvm.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/core.c      | 11 +++++++
>>  drivers/nvme/host/core.c     |  6 ++--
>>  drivers/nvme/host/lightnvm.c | 74 =
++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/nvme/host/nvme.h     |  3 ++
>>  include/linux/lightnvm.h     | 24 ++++++++++++++
>>  5 files changed, 115 insertions(+), 3 deletions(-)
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index ed33e0b11788..4141871f460d 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -712,6 +712,17 @@ static void nvm_free_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev,
>>  	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
>>  }
>>  +int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct =
nvm_chk_meta *meta,
>> +		struct ppa_addr ppa, int nchks)
>> +{
>> +	struct nvm_dev *dev =3D tgt_dev->parent;
>> +
>> +	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
>> +
>> +	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
>> +						(sector_t)ppa.ppa, =
nchks);
>> +}
>> +EXPORT_SYMBOL(nvm_get_chunk_meta);
>>    int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct =
ppa_addr *ppas,
>>  		       int nr_ppas, int type)
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 2e9e9f973a75..af642ce6ba69 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2127,9 +2127,9 @@ static int nvme_init_subsystem(struct nvme_ctrl =
*ctrl, struct nvme_id_ctrl *id)
>>  	return ret;
>>  }
>>  -static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns =
*ns,
>> -			    u8 log_page, void *log,
>> -			    size_t size, size_t offset)
>> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> +		     u8 log_page, void *log,
>> +		     size_t size, size_t offset)
>>  {
>>  	struct nvme_command c =3D { };
>>  	unsigned long dwlen =3D size / 4 - 1;
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index f7135659f918..a1796241040f 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
>>  	nvme_nvm_admin_set_bb_tbl	=3D 0xf1,
>>  };
>>  +enum nvme_nvm_log_page {
>> +	NVME_NVM_LOG_REPORT_CHUNK	=3D 0xca,
>> +};
>> +
>>  struct nvme_nvm_ph_rw {
>>  	__u8			opcode;
>>  	__u8			flags;
>> @@ -236,6 +240,16 @@ struct nvme_nvm_id20 {
>>  	__u8			vs[1024];
>>  };
>>  +struct nvme_nvm_chk_meta {
>> +	__u8	state;
>> +	__u8	type;
>> +	__u8	wi;
>> +	__u8	rsvd[5];
>> +	__le64	slba;
>> +	__le64	cnlb;
>> +	__le64	wp;
>> +};
>> +
>>  /*
>>   * Check we didn't inadvertently grow the command struct
>>   */
>> @@ -252,6 +266,9 @@ static inline void _nvme_nvm_check_size(void)
>>  	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) !=3D 64);
>>  	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20_addrf) !=3D 8);
>>  	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20) !=3D =
NVME_IDENTIFY_DATA_SIZE);
>> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) !=3D 32);
>> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) !=3D
>> +						sizeof(struct =
nvm_chk_meta));
>>  }
>>    static void nvme_nvm_set_addr_12(struct nvm_addr_format_12 *dst,
>> @@ -555,6 +572,61 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev =
*nvmdev, struct ppa_addr *ppas,
>>  	return ret;
>>  }
>>  +/*
>> + * Expect the lba in device format
>> + */
>> +static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>> +				 struct nvm_chk_meta *meta,
>> +				 sector_t slba, int nchks)
>> +{
>> +	struct nvm_geo *geo =3D &ndev->geo;
>> +	struct nvme_ns *ns =3D ndev->q->queuedata;
>> +	struct nvme_ctrl *ctrl =3D ns->ctrl;
>> +	struct nvme_nvm_chk_meta *dev_meta =3D (struct nvme_nvm_chk_meta =
*)meta;
>> +	struct ppa_addr ppa;
>> +	size_t left =3D nchks * sizeof(struct nvme_nvm_chk_meta);
>> +	size_t log_pos, offset, len;
>> +	int ret, i;
>> +
>> +	/* Normalize lba address space to obtain log offset */
>> +	ppa.ppa =3D slba;
>> +	ppa =3D dev_to_generic_addr(ndev, ppa);
>> +
>> +	log_pos =3D ppa.m.chk;
>> +	log_pos +=3D ppa.m.pu * geo->num_chk;
>> +	log_pos +=3D ppa.m.grp * geo->num_lun * geo->num_chk;
>=20
> Why is this done?

The log page does not map to the lba space. You need to convert it to
get one chunk at a time in the format.

   GRP:PU:CHK

I can see why taking a lba as argument is better than a ppa, since users
might use the lbas directly, but the conversion needs to be done
somewhere.

Javier

--Apple-Mail=_F0C456E6-94BC-4B21-A030-8CF4E400683F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqX3dYACgkQIX4xUKFR
nnTs4xAAwlCCReIvMizInklpHCaYBVzc4/PgOoMvXvEA4p87fjI58hUFV2BoJNCv
yqcagu8dbSr++gerQ7L+4M5lD1fBeiZXvQQ4QoCTbDEPJvMFBFDyUWIi6eq98CtO
5UIjtEIFnZ18NaoqP+dRLo48fA2jnwkGYIXlrSKBwfXUrpBaG8b2gOSHayJ17Zn1
SGmTvNdpDvUYj2suCJ9SAzK16sYCX/7f+BJM9FMUkgWbygnjC8jhrQdQK+ZnziWK
Oq7h2Sfg3mFmje2UR6RkA5X8BHnikX0uyWQiO9/Hq5IAu4Y5NbGEJ2763BZimfjM
dUARqbN+xmn5ioCuLIPvhJXW0wFT7uCHCbL3uH/KlVyPrBv0s7+f30VpTfq/LsZ0
vWBijBozomUAVM+XOw1ieRhiNUsIFz30zHdLlrKbnGMWNWZe+d2iWwcOhwVbWllJ
9A/dpnAPS3cKTuSTJXAZPYqmhGdUxiOsFz86XBvaMSmPv7B0PitKLH62dLPHQhC7
ujG8JQegfiw0SZtJ3lhWYgppH3Fn7TQD1HoeVlqTNLezOAvaLBUSgKEUE4r+8nIw
voj3/FiFh0x/P8OgFdeoC5ltB+7ILJm79QfOW/gKmV1kkOhbJobGW4t+NiMYyqxU
eXhQ3nNISb8y41HW/v5KH+RB3bKEa4v0XxHWQTtyjzj1c5ko2W4=
=RPIO
-----END PGP SIGNATURE-----

--Apple-Mail=_F0C456E6-94BC-4B21-A030-8CF4E400683F--
