Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B2C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB1E2067D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nfs+ZACy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z29Zx9lI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGBIK5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:10:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37461 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBIK4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593677493; x=1625213493;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XMYfNeicJWMtlNUA5SOPlyTsUxLqtdlA/UMCJpN6WNA=;
  b=Nfs+ZACyaaZT3BeYoYLGAvYtY2csVrpWe5O7JpOqVyUuyJkRConZ7ojc
   8YZmpIgragXu0WdnTqBA+FYPVDjVWsmQv3kWYRdfSTZn84CaaLX93cWfT
   z5LwMMXSxkliePnZsh8r0o8ck2beYbUYPu6RW9em53xtGCqUmmln20lSz
   cvt9R6IlC+IEuklYrEh7RsRDWOseGu3Pcr1aVdha3o7cgm8tb1F5fCmSl
   j75buuqOznAYjL5/JrsIG6a41NYSW+HVJeRmegMOrOwzNrc7VEqhCN+4D
   8WIavEfphDaUVhjtzl/p/EFisMt+OOsQuofS4CFWElnCg6p/BnEJ0ADxL
   g==;
IronPort-SDR: GTPBCw7ddcRPhc67bh7oSe9xSbwZJDeg6856bBupzibl6TpO3VM2nlFArDhu5gSp/D6A1DsbF0
 zl4tB+DT4JT0OXJ+uAdmnI6MrEzO7eXiPjgmHqL+Rg8BzzN9ueXBwI1NNr3ofwKXk71ZCdKu6m
 kR76v5Xmb5eSvM2aDe7BZrmoVZnpcckKwkw+m/csgqooc5QH8yv+JtBhvU52kve7ciB9Roth44
 KqELcbvCsd2vqTDtaLJ5jGg91QklKXe5KnIGL6ayNiXxitJDfo1lb5Djnek10GB1EH5Xnh1yeg
 um0=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; 
   d="scan'208";a="244482264"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:11:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giWqwp1rVKTMUDaPagL/77d3ev0kOM1BWTI9j/Er6JvszxmcHJCN1bhwHDuSkYs1hTIoK8HukpFe3cAQBB3MYFFwhpUWmXuE8DDvZG+EtFaKIg2lalvOOMvQBSr7qJLavJQYXeqm73fAq9xQ6jLqliBBkL4OxWAT4S9lWZXNwXuEdCkzCXJlrFXmVpIqXws6UPHl9j8TVX0O/R4QaotskqtZoz//ptxT8SXl0F1KD4Qi9DVvpqrClDS8ZCU2bix30yXLW7vW7nUyOoSM0bGpOo07qulKHBDi1cyzTJWJVkVzljqddLXJWFgpmdWk8hKov5BYgu8CkVXVvYK8viSBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=embGmwR3j6tc2qPypZniddQ9JmRQ577nIussOnG53BQ=;
 b=bVQLCN2QmJMrocpY3N0x0RilF1ym3NZziIycmfMCJ54Y3DNFUQ0rfINgJd594aD1OSsVt898NUxkLhCmm0q/uzvgTZRjOdtCz8+Y7upyjCIMMMLsDeCAPj86IPWZm9hVRuCYJ4Vj9Ey+7kyGwXc3+anNgwj/KBgw8DWpHwHqeZ7Wz3Iu0tXjCiQfgXLGozcfaul1l83Tbu9N3FueVXtYrH0ooDLmmEwJcFKOdkN3etdLRA25xj2A2AsA218//HEUqs4ZHVLgfk27tcuIhHQbz++S10ph41TDioNVzAJxaC9Q3C8gHXevnh29jVsBaWIsW3wPPphTgUbOpYU3L4gBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=embGmwR3j6tc2qPypZniddQ9JmRQ577nIussOnG53BQ=;
 b=z29Zx9lIM21nI40GtBMbbO/2HJXKAUvzETOCIavHTs0Ej3SrN2109t+QifLbPHeON8JxJlRJs0fzg52+bedrgIJVSsVtRINgXpr6IDpmZHN3GbDj9X48NnJWZS7dwSrQQ59dMv1Xp/klhrHQX1TvAsr/ZgqQnvLb6OZ6BTnBAls=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0759.namprd04.prod.outlook.com (2603:10b6:903:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 08:10:54 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:10:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 2/4] block: add support for zone offline transition
Thread-Topic: [PATCH 2/4] block: add support for zone offline transition
Thread-Index: AQHWUD25AuPO9FUJKEmO2iwqT0FCbg==
Date:   Thu, 2 Jul 2020 08:10:53 +0000
Message-ID: <CY4PR04MB3751F9F6BBBAD8CAC7E15431E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-3-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c6addb5-e58e-4693-2826-08d81e5f710e
x-ms-traffictypediagnostic: CY4PR04MB0759:
x-microsoft-antispam-prvs: <CY4PR04MB075954E198FF5349D4AF9F6FE76D0@CY4PR04MB0759.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfBpG2YujfEXSWOLxU+rfV6dcEUPIdqktndowMifq/hl5lJPdw1BPqzxvN8XJe5UlNhn8XlrZ+FU3IUW5lJkeC2zgi6dpbJDfAMoX+lnDlUZjWdFPITbYjF2gtMK0KXVBREDxVj7D6rEydxxSOBgVbOslqJbbbNooYVT75GNlO5dJw8T8ZLX++kfjgexWz8RmGZibYAKsg0yoKlw5gCwfN5HtrXwrhjiIsv+11R3ShoKZTbAfCI+yh1U9a5N9Niq6pwKRaTA7WZ1h5F8wlAadeHXklS/bhuozZid9Bb92IyfjmGV0M3wZoqH6sd7UR4UYMAZIqGoSuCUFRnwmO2LjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(66446008)(5660300002)(55016002)(52536014)(186003)(7696005)(26005)(6506007)(9686003)(4326008)(53546011)(86362001)(2906002)(33656002)(8676002)(66476007)(66556008)(64756008)(66946007)(316002)(110136005)(76116006)(54906003)(91956017)(8936002)(66574015)(71200400001)(7416002)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HcbJbwII1ZtosbSisFAc5H5doA0oHFDyk0psdExNm/dOpMLyzHmOqhaFDvQnQUsTtUNSzJt6ZCWUSAbvYNnwT7iHYSNrJdn9NdZtoZ4sqYgMurKXFqY+FmtbZaGSXr5t9LW2YM6hgVV9MUQI0tzJfWH3Dz4+Fh00HKgLUa5mv6VpB2ztsJMb+OTubSfiayBXqj3r9pFup/DktlmNVpxn59/7qtMWU5OU+uH3r9LBTuZVzPt25vnNQkUH93K14qCgIZFXE5Wntpr+/UqtROTFbQX/7b0LpOTMthbQ27HZDrmZnS9bFv7d968mFcwqpXnu6WZLBdVLc41NfzGySFak1tOQhpuIimjSzXpujej3LVa1RKwwKK6j+6rVevOk5fOIDfvH94Isc10s0nsWhlYiny3AFduWXVaLMlsnBGK2I6CmFhhQ9ipSxnEcJsSmzbn+MvTbgV8eeyiFKaEOSi4Kdes6fD9NkovjhLgM8LnJJ/T/o1Eivcc5tRKu+Ol8xstL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6addb5-e58e-4693-2826-08d81e5f710e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:10:53.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtfSebe1BSoCdLFDw3WIBNXmkKIoI1EzFcEg2QeCFnXm+FXOAjDqW11TlCEej2/kckA9AaM0y0YR0uNGe4ZzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0759
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/02 15:55, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> Add support for offline transition on the zoned block device. Use the=0A=
> existing feature flags for the underlying driver to report support for=0A=
> the feature, as currently this transition is only supported in ZNS and=0A=
> not in ZAC/ZBC=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  block/blk-core.c              | 2 ++=0A=
>  block/blk-zoned.c             | 8 +++++++-=0A=
>  drivers/nvme/host/core.c      | 3 +++=0A=
>  drivers/nvme/host/zns.c       | 2 +-=0A=
>  include/linux/blk_types.h     | 3 +++=0A=
>  include/linux/blkdev.h        | 1 -=0A=
>  include/uapi/linux/blkzoned.h | 3 +++=0A=
>  7 files changed, 19 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 03252af8c82c..589cbdacc5ec 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {=0A=
>  	REQ_OP_NAME(ZONE_CLOSE),=0A=
>  	REQ_OP_NAME(ZONE_FINISH),=0A=
>  	REQ_OP_NAME(ZONE_APPEND),=0A=
> +	REQ_OP_NAME(ZONE_OFFLINE),=0A=
>  	REQ_OP_NAME(WRITE_SAME),=0A=
>  	REQ_OP_NAME(WRITE_ZEROES),=0A=
>  	REQ_OP_NAME(SCSI_IN),=0A=
> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)=0A=
>  	case REQ_OP_ZONE_OPEN:=0A=
>  	case REQ_OP_ZONE_CLOSE:=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
> +	case REQ_OP_ZONE_OFFLINE:=0A=
>  		if (!blk_queue_is_zoned(q))=0A=
>  			goto not_supported;=0A=
>  		break;=0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 0f156e96e48f..b97f67f462b4 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -320,7 +320,8 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> - * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl proce=
ssing.=0A=
> + * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE, BLKFINISHZONE and BLKOFFLINE=
ZONE=0A=
> + * ioctl processing.=0A=
>   * Called from blkdev_ioctl.=0A=
>   */=0A=
>  int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=0A=
> @@ -363,6 +364,11 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>  	case BLKFINISHZONE:=0A=
>  		op =3D REQ_OP_ZONE_FINISH;=0A=
>  		break;=0A=
> +	case BLKOFFLINEZONE:=0A=
> +		if (!(q->zone_flags & BLK_ZONE_REP_OFFLINE))=0A=
> +			return -EINVAL;=0A=
=0A=
return -ENOTTY here.=0A=
=0A=
That is the error returned for regular block devices when a zone ioctl is=
=0A=
received, indicating the lack of support for these ioctls. Since this is al=
so a=0A=
lack  of support by the device here too, we may as well keep the same error=
=0A=
code. Returning -EINVAL should be reserved for cases where the device can a=
ccept=0A=
the ioctl but start sector or number of sectors is invalid.=0A=
=0A=
=0A=
> +		op =3D REQ_OP_ZONE_OFFLINE;=0A=
> +		break;=0A=
>  	default:=0A=
>  		return -ENOTTY;=0A=
>  	}=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index e5f754889234..1f5c7fc3d2c9 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struc=
t request *req,=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);=0A=
>  		break;=0A=
> +	case REQ_OP_ZONE_OFFLINE:=0A=
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);=0A=
> +		break;=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);=0A=
>  		break;=0A=
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
> index 888264261ba3..b34d2ed13825 100644=0A=
> --- a/drivers/nvme/host/zns.c=0A=
> +++ b/drivers/nvme/host/zns.c=0A=
> @@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct =
nvme_ns *ns,=0A=
>  	}=0A=
>  =0A=
>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;=0A=
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;=0A=
=0A=
The name BLK_ZONE_REP_OFFLINE is not ideal.  This flag is not about if offl=
ine=0A=
condition will be reported or not. It is about the drive supporting an expl=
icit=0A=
offlining zone operation.=0A=
=0A=
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>  free_data:=0A=
>  	kfree(id);=0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index ccb895f911b1..c0123c643e2f 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -316,6 +316,8 @@ enum req_opf {=0A=
>  	REQ_OP_ZONE_FINISH	=3D 12,=0A=
>  	/* write data at the current zone write pointer */=0A=
>  	REQ_OP_ZONE_APPEND	=3D 13,=0A=
> +	/* Transition a zone to offline */=0A=
> +	REQ_OP_ZONE_OFFLINE	=3D 14,=0A=
>  =0A=
>  	/* SCSI passthrough using struct scsi_request */=0A=
>  	REQ_OP_SCSI_IN		=3D 32,=0A=
> @@ -455,6 +457,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)=
=0A=
>  	case REQ_OP_ZONE_OPEN:=0A=
>  	case REQ_OP_ZONE_CLOSE:=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
> +	case REQ_OP_ZONE_OFFLINE:=0A=
>  		return true;=0A=
>  	default:=0A=
>  		return false;=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 3f2e3425fa53..e489b646486d 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -370,7 +370,6 @@ extern int blkdev_report_zones_ioctl(struct block_dev=
ice *bdev, fmode_t mode,=0A=
>  				     unsigned int cmd, unsigned long arg);=0A=
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,=0A=
>  				  unsigned int cmd, unsigned long arg);=0A=
> -=0A=
>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index 42c3366cc25f..e5adf4a9f4b0 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -77,9 +77,11 @@ enum blk_zone_cond {=0A=
>   * enum blk_zone_report_flags - Feature flags of reported zone descripto=
rs.=0A=
>   *=0A=
>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.=0A=
> + * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.=0A=
=0A=
The device supports explicit zone offline transition=0A=
=0A=
Since the implicit transition by the device may happen, even on SMR disks.=
=0A=
=0A=
But I am not sure this flags is very useful. Or rather, isn't it out of pla=
ce=0A=
here ? Device features are normally reported through sysfs (e.g. discard, e=
tc).=0A=
It is certainly confusing and not matching the user doc for rep.flag which=
=0A=
states that the flags are about the zone descriptors, not what the device c=
an=0A=
do. So at the very least, the comments need to change.=0A=
=0A=
The other thing is that the implementation does not consider device mapper =
case=0A=
again: if a DM target is built on one or more ZNS drives all supporting zon=
e=0A=
offline, then the target should be allowed to report zone offline support t=
oo,=0A=
no ? dm-linear and dm-flakey certainly should be allowed to do that. Export=
ing a=0A=
"zone_offline" (or something like named that) sysfs limit would allow that =
to be=0A=
supported easily through limit stacking and avoid the need for the report f=
lag.=0A=
=0A=
Happy to here others opinion about this one though.=0A=
=0A=
>   */=0A=
>  enum blk_zone_report_flags {=0A=
>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),=0A=
> +	BLK_ZONE_REP_OFFLINE	=3D (1 << 1),=0A=
>  };=0A=
>  =0A=
>  /**=0A=
> @@ -166,5 +168,6 @@ struct blk_zone_range {=0A=
>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)=0A=
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
> +#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)=0A=
>  =0A=
>  #endif /* _UAPI_BLKZONED_H */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
