Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52951 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeBVHt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:49:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id t3so2029943wmc.2
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 23:49:55 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <1FE350B9-E8CD-43BC-8AE8-2593A6398D3F@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1CD6AF7F-4ADE-4316-B039-83EA8F609F82";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 09/20] lightnvm: use generic identify structure
Date: Thu, 22 Feb 2018 08:49:51 +0100
In-Reply-To: <6f76c204-847a-2f20-3070-06cb28a66555@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-10-git-send-email-javier@cnexlabs.com>
 <6f76c204-847a-2f20-3070-06cb28a66555@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_1CD6AF7F-4ADE-4316-B039-83EA8F609F82
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 08.47, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>> Create a generic identify structure to collect the identify =
information
>> before knowing the spec. version. This forces different version paths =
to
>> cast the structure to their spec structure, thus making the code less
>> error prone and more maintainable.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 32 ++++++++++++++++++++------------
>>  1 file changed, 20 insertions(+), 12 deletions(-)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 9c1f8225c4e1..70dc4740f0d3 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -170,6 +170,12 @@ struct nvme_nvm_id12 {
>>  	__u8			resv2[2880];
>>  } __packed;
>>  +/* Generic identification structure */
>> +struct nvme_nvm_id {
>> +	__u8			ver_id;
>> +	__u8			resv[4095];
>> +} __packed;
>> +
>>  struct nvme_nvm_bb_tbl {
>>  	__u8	tblid[4];
>>  	__le16	verid;
>> @@ -279,9 +285,10 @@ static void nvme_nvm_set_addr_12(struct =
nvm_addr_format_12 *dst,
>>  	dst->sec_mask =3D ((1ULL << dst->sec_len) - 1) << =
dst->sec_offset;
>>  }
>>  -static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>> +static int nvme_nvm_setup_12(struct nvme_nvm_id *gen_id,
>>  			     struct nvm_dev_geo *dev_geo)
>>  {
>> +	struct nvme_nvm_id12 *id =3D (struct nvme_nvm_id12 *)gen_id;
>>  	struct nvme_nvm_id12_grp *src;
>>  	int sec_per_pg, sec_per_pl, pg_per_blk;
>>  @@ -380,9 +387,11 @@ static void nvme_nvm_set_addr_20(struct =
nvm_addr_format *dst,
>>  	dst->sec_mask =3D ((1ULL << dst->sec_len) - 1) << =
dst->sec_offset;
>>  }
>>  -static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>> +static int nvme_nvm_setup_20(struct nvme_nvm_id *gen_id,
>>  			     struct nvm_dev_geo *dev_geo)
>>  {
>> +	struct nvme_nvm_id20 *id =3D (struct nvme_nvm_id20 *)gen_id;
>> +
>>  	dev_geo->major_ver_id =3D id->mjr;
>>  	dev_geo->minor_ver_id =3D id->mnr;
>>  @@ -427,19 +436,19 @@ static int nvme_nvm_setup_20(struct =
nvme_nvm_id20 *id,
>>  static int nvme_nvm_identity(struct nvm_dev *nvmdev)
>>  {
>>  	struct nvme_ns *ns =3D nvmdev->q->queuedata;
>> -	struct nvme_nvm_id12 *id;
>> +	struct nvme_nvm_id *nvme_nvm_id;
>>  	struct nvme_nvm_command c =3D {};
>>  	int ret;
>>    	c.identity.opcode =3D nvme_nvm_admin_identity;
>>  	c.identity.nsid =3D cpu_to_le32(ns->head->ns_id);
>>  -	id =3D kmalloc(sizeof(struct nvme_nvm_id12), GFP_KERNEL);
>> -	if (!id)
>> +	nvme_nvm_id =3D kmalloc(sizeof(struct nvme_nvm_id), GFP_KERNEL);
>> +	if (!nvme_nvm_id)
>>  		return -ENOMEM;
>>    	ret =3D nvme_submit_sync_cmd(ns->ctrl->admin_q, (struct =
nvme_command *)&c,
>> -				id, sizeof(struct nvme_nvm_id12));
>> +				nvme_nvm_id, sizeof(struct =
nvme_nvm_id));
>>  	if (ret) {
>>  		ret =3D -EIO;
>>  		goto out;
>> @@ -449,22 +458,21 @@ static int nvme_nvm_identity(struct nvm_dev =
*nvmdev)
>>  	 * The 1.2 and 2.0 specifications share the first byte in their =
geometry
>>  	 * command to make it possible to know what version a device =
implements.
>>  	 */
>> -	switch (id->ver_id) {
>> +	switch (nvme_nvm_id->ver_id) {
>>  	case 1:
>> -		ret =3D nvme_nvm_setup_12(id, &nvmdev->dev_geo);
>> +		ret =3D nvme_nvm_setup_12(nvme_nvm_id, =
&nvmdev->dev_geo);
>>  		break;
>>  	case 2:
>> -		ret =3D nvme_nvm_setup_20((struct nvme_nvm_id20 *)id,
>> -							=
&nvmdev->dev_geo);
>> +		ret =3D nvme_nvm_setup_20(nvme_nvm_id, =
&nvmdev->dev_geo);
>>  		break;
>>  	default:
>>  		dev_err(ns->ctrl->device, "OCSSD revision not supported =
(%d)\n",
>> -							id->ver_id);
>> +							=
nvme_nvm_id->ver_id);
>>  		ret =3D -EINVAL;
>>  	}
>>    out:
>> -	kfree(id);
>> +	kfree(nvme_nvm_id);
>>  	return ret;
>>  }
>>=20
>=20
> Thanks for another way to represent it. I want to keep the original
> path. If we are going that down road, then one should maybe look into
> unifying the "three" data structures, and have the version as the base
> property and the others in each their sub data structure.

That's what this structure aims to do, since the version is shared. But
you call if you want to cast unrelated structures back an forth. I'll
revert it...

Javier

--Apple-Mail=_1CD6AF7F-4ADE-4316-B039-83EA8F609F82
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqOdh8ACgkQYx8FO3WZ
GMrdXRAAtR/o4697/X6iUqg09P6U1J8FFEAPwvddEK/deZm+SelVFkjrVZzjL2vs
YXvp0KpuKC/CEGK5KypezQ06IgPTDrVIteJOCvlvhNJH0ALp5GqqBqlYsjEvW0d3
zWeMPNTsvg4RYjwxSjg7e4M+3l9U4dH6r35otGGZOAwfY4kYBTka6HcJjTpqKf0B
IuPQlTkciCrvAKVzyYSN6LM9fo61+l+Za7vXYTQWLqb8XriKaGL33fV69f9JGe+j
DneTeJLmefB8Q7iwHVRW5sAMphxumEGfK4TNAeXW6leYK/2sj72/YfFMR/2ZiWO3
+FvmtmwwTl8iuvURQXtPNjrDWjEGSn4Eq8AGcXMxkXiO6fmtCjTfja5fm9xkKeVV
t1pn/mfS0dKYrhD4zQcTW5ISxjqA+nWC9ITvL1L/ewTYYSqLbzXFmWsyWU7gYj9w
T5MMQwtTMERIJ+Gs2EK94iJS/8LLlY3oiXrewjtj/Vda/JDFUN4zuHu4XCGGjXmz
jjGiKHKgFrB2jNCz0CTT+H7/z9oXairuaQlj5Srg0kTUjLTWi9EaT8pQYdmTdEIK
a0RvuAJviVlSTv6DfGRJc05sK1BoduIse1PNjxZ0WRnPo08TuzRfSqPEGHllBhf5
GCZiqsx8j40hYsh6uwDOk4D9MpKILZaPEBqIQwMSRCpuZG4WU5Q=
=piTq
-----END PGP SIGNATURE-----

--Apple-Mail=_1CD6AF7F-4ADE-4316-B039-83EA8F609F82--
