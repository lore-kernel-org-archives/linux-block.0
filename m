Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31BFC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CE0207FC
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M9pS76og";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qZPw/tg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgFSHw1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:52:27 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19391 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgFSHwZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 03:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592553145; x=1624089145;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qNM0w10sl2ulHv/j9xUSP+oYs44PLB+fMx2YMxvCaPs=;
  b=M9pS76ogzr3i5EUW+9KBNaJnCjrn+FCR+8nolu4ih4MRMBYeUAlBkQGn
   njlqxTRbe1VIdVLfgrWBfroSC/Kzc0Uxt0cfoDg02HWuvE6COWYJvLOg8
   x3czi7iNzrZ+n0JWMU46f3YUy90qJ5o7zbKRKNzXUqrfrmHM4I7ZxdA5C
   QWgd8Vf1qJZogcDl/TdO+KANHHoMR+6LuA6BkUMsyyyP6I9k4mSZ909kD
   8stETIl8/yOD0bUfW7XPLknFrXfwt3SlgouhPQABr6WkWecJ6xt12WD1X
   98261wb+ZJa8jrCSoFkrVXnUnNZGOgC3mTln7GFnulIkNTdZBJ0/MsTo1
   Q==;
IronPort-SDR: jUzS1eR7Faww8VODRf9cfqU1MZ5R0ZQrsgTHEyhf2wvMwAFVxkjRU5f01HiHQpzj0iRp2Bot8f
 T1UqM6jdXwdyVjipRDUQeVG7uuewIEKS5ssv/Oc7skaD7seF3D1OjQU9wvRUTjPYXPtw1ROL5y
 YdY6vLfG6nB5aT0gYU08gzjfJ6pymHKg5sgaSEXWfYdY6z/sy0kH/xcNuRFk5IWOHQuvXzu3K+
 MBneKEayI0R8HyGD7c5w4LKrD+1UiS7qyh49NBtR9ZsR7k0H0sDq61zyr9/9Au8MHiNUB08KeT
 Tt4=
X-IronPort-AV: E=Sophos;i="5.75,254,1589212800"; 
   d="scan'208";a="141787129"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 15:52:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RevhQjpqXjiIV5xZUbwD3lh62FMdaiNRu+Pi+e2lVSyiqj6ek4y8Gdo0jWRIqfbcGo2tt+bglirkXLpBC1/kldzOxysc3EAb/exSKVdlV3DbLSj1Vh2fS2w1bYtO65J/FQB+cA9vogP03I7vnymO9EMn3eahc2Psfo5p7jKSfHmtecTluHdaFviZ/su9D6ZsOHYfcDq1IlRt8J2uKkk9CpeOrFeLNFujHT5FMqcC7o4M8Y+/xfjmyvXwetDnYTr8sun6vUEKBlfdZ1AOnZ0zrPx3gfFeVuuXz7cmwltBxpF/0FX73okd4a3t1DGpH9QAQVd+Px3rB/H6qObAoutT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt3mL45gQ3WOtLuoxTfNwtGAOuGVRUCfGHRg1YbY6gA=;
 b=Vt3aBKslpasmO3ZgLzZhTIDcHzchPodPLH+AOve47X0XHF5+uDFTTRc1+Tsgdv6+77DX8p2kLwV5nU70eyK7jPSVRN4oeASnCBdjjKB1vgzHrOBmivw9EMVcilRu2mTIqAXCgmmTjNc35+2dzaRvKCPIjg4hGgYtZH8R3I5ps2+vAcylG7Db7lR4F1W2AdzyNqG7A1kSbEmcDextmP+8KjpkPojIHdcCWr/sX83WJkDDGHXWEbyWGJf9nklpu4eVtUgnQAxu0Y8Wjpg5DyXschTCDZ9jw2eP+nYZgaSt/3Wl97drFiSyn6Q+xlgmMlkhottF3TjLPUlN1f6BRnO+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt3mL45gQ3WOtLuoxTfNwtGAOuGVRUCfGHRg1YbY6gA=;
 b=qZPw/tg31yYd5Ytq52VMBqscTTH0oycz2QeFN3ta5uvCHWsr7rgbyLN31U5fABj9RYkJQJ/RHG1J0e5/RIW7MGQ0LWVpBn1IiEom6CUqbgVNPOdxnSs3wiggSARrx/E0s3+664uZYOx7K6rGZCV/3XPTR/cdzbPM3c2dwjV6obs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3636.namprd04.prod.outlook.com (2603:10b6:910:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Fri, 19 Jun
 2020 07:52:22 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 07:52:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 1/2] dm: update original bio sector on Zone Append
Thread-Topic: [PATCH 1/2] dm: update original bio sector on Zone Append
Thread-Index: AQHWRgcxVdsmSghuh0qfelwKmrP/0Q==
Date:   Fri, 19 Jun 2020 07:52:22 +0000
Message-ID: <CY4PR04MB37511B64E85A60344AB2473AE7980@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
 <20200619065905.22228-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50bf53a5-c24b-40c6-9b8c-08d81425b339
x-ms-traffictypediagnostic: CY4PR0401MB3636:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB3636C1CDB70682C7CBE72B78E7980@CY4PR0401MB3636.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 06rfhiTSpE9uOP5X6xDJBLmSPpZGpKFiyngtEodatMX3QN7MeOyuwxqbDS4VgeAmzHEiUgNqU8CLVKOUb7/UhYDEmaZgpcqxckqcFk+zuSbWBB2wp5E5WP2opy6hv4t0YEjhjdeoMhvglJgvd6vHrONhKrvI8EA1Q1cFJL5ZzKUynHurD1pcTEK3p7D2JI0J1Yq1pc9sV4LCg7o/GZxn8M+/uon+oJcmvvVdGFDi4Lyd++rsqPNInS02nNpsDTF1cr0fmTpPWupJzzFKjDzqYFy3Q8TiGLruX3aWQ3vq7ka09aMlm3ULYw+o1u/M8xSZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(186003)(316002)(33656002)(8936002)(91956017)(66476007)(66946007)(110136005)(76116006)(52536014)(66446008)(6506007)(53546011)(4326008)(26005)(478600001)(54906003)(7696005)(66556008)(83380400001)(8676002)(64756008)(86362001)(2906002)(71200400001)(5660300002)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /mGqkykclANK+MxVvfjgQS2t9BbS7IcdbQ+U/HU/1p5A5eGNC9N64PEmbH7g/SlIzxq+DJAiXlnNkb4B7CPSwOdYalGyQ+Nw/5MbzpCNvA5w18MvM4LC/+KNyJ/RHv60UINY7TeJZaqRrvosScieeO07tBIGncKmARp7KkJ2Af4nSP/Wkv31C8ooQsrHxA8KwRvNSvtVl8mbcXuov1It380JjYovFPSFItVEMYFTLlJvf19Oi1Wp+f2ztYCcszDIV/w0rVFVgOnNVLINkk1LD9xdLjVNSEq5psoMnHScupVJdpLFxW2ToADQ1cdqKlfWf40N3cQgkXkAeH5D6Wg7km9ABcPy+tWYRCgbY1g64GLZEDv/9pDltpZcVoHuYgAUYLd5mQ0t4FUltfgq5m7daPXPSMxhhSzbATKyoO1Br/QLRxmmMFroTPgyfGKJ7C6yFfhx/7yEA6M06qzc3tbFk0jSuyKzpG5Qhmcz8j3DEkFmB/RRX7ckcasBNOOczwL0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bf53a5-c24b-40c6-9b8c-08d81425b339
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 07:52:22.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3Lbak4z2QgPAcraJ1UP+69DsbqoR7XsOfO9xJTfEDyJ1k+QsMND+vDc96ssNisi+EasgmJ81vySmqgUz1690g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3636
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/19 15:59, Johannes Thumshirn wrote:=0A=
> Naohiro reported that issuing zone-append bios to a zoned block device=0A=
> underneath a dm-linear device does not work as expected.=0A=
> =0A=
> This because we forgot to reverse-map the sector the device wrote to the=
=0A=
> original bio.=0A=
> =0A=
> For zone-append bios, get the offset in the zone of the written sector=0A=
> from the clone bio and add that to the original bio's sector position.=0A=
> =0A=
> Reported-by: Naohiro Aota <Naohiro.Aota@wdc.com>=0A=
> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  drivers/md/dm.c | 13 +++++++++++++=0A=
>  1 file changed, 13 insertions(+)=0A=
> =0A=
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
> index 109e81f33edb..058c34abe9d1 100644=0A=
> --- a/drivers/md/dm.c=0A=
> +++ b/drivers/md/dm.c=0A=
> @@ -1009,6 +1009,7 @@ static void clone_endio(struct bio *bio)=0A=
>  	struct dm_io *io =3D tio->io;=0A=
>  	struct mapped_device *md =3D tio->io->md;=0A=
>  	dm_endio_fn endio =3D tio->ti->type->end_io;=0A=
> +	struct bio *orig_bio =3D io->orig_bio;=0A=
>  =0A=
>  	if (unlikely(error =3D=3D BLK_STS_TARGET) && md->type !=3D DM_TYPE_NVME=
_BIO_BASED) {=0A=
>  		if (bio_op(bio) =3D=3D REQ_OP_DISCARD &&=0A=
> @@ -1022,6 +1023,18 @@ static void clone_endio(struct bio *bio)=0A=
>  			disable_write_zeroes(md);=0A=
>  	}=0A=
>  =0A=
> +	/*=0A=
> +	 * for zone-append bios get offset in zone of the written sector and ad=
d=0A=
> +	 * that to the original bio sector pos.=0A=
> +	 */=0A=
> +	if (bio_op(orig_bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
> +		sector_t written_sector =3D bio->bi_iter.bi_sector;=0A=
> +		struct request_queue *q =3D orig_bio->bi_disk->queue;=0A=
> +		u64 mask =3D (u64)blk_queue_zone_sectors(q) - 1;=0A=
> +=0A=
> +		orig_bio->bi_iter.bi_sector +=3D written_sector & mask;=0A=
> +	}=0A=
> +=0A=
>  	if (endio) {=0A=
>  		int r =3D endio(tio->ti, bio, &error);=0A=
>  		switch (r) {=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
