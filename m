Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC9FC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BA020874
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SI3wwF4Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V1FhPzM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGBJyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:54:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8755 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGBJyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 05:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593683656; x=1625219656;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=X+7H1S1fyH3TDdnS2FtBrDLV0kMG9NYYBm8ZjeJLBFQ=;
  b=SI3wwF4ZLApI0pTcUhLPlDZRbadt6t43yQzhDVjk8GE6VJKs5cqb/zaT
   oigvZGIYBjfOLXDd2+Dl7/PNaeH9MzVHvnHFhVWn0vuOlb6vO6bxyjlyG
   Mk284C9vZ3o3HR23VMUR6V3y+6N3LQL9ZEMkLRk5hWwCjgGUK+UtGKHfD
   Cz3zWfDQ6BAAhpsGqmw0fDGrrKe62W+9vA7h5hc2j7D9JLMK7F5g0CV4V
   MZmav50O3H270AgqmZOf9IMFsnRZCtaCu7A2+AWDGBoclXnYzAlFPOA8h
   2JjTXNWkmfvQ1VoMqoO9kk3gdVs8ueooBfFnrdoJWyjWDUt7H4WI4auHB
   Q==;
IronPort-SDR: YkZr1Q7dBVSnxmDUDHsXQZQVVCTGoGDL+dSGL+FqRUQDdu4mSL0OgThNLwM8ymTSRSljlRUjvn
 6looD56etMgV9HC4XZoQFgcqZn7XUGSPQeaUyc9R5RGjtKNVWZBVBPohCbf+67EOULER038QHy
 yqWJrAS4iIKYBlctTLW0959eukKTw4yBGu7MH4UecPvY5SryVcAAbB3r9Sxv6jQSfZYXaTdV6f
 EEdSknVRDUO2b0yZNhFDhkeAGal9pl/rmP0+qxMjueMF1bE8Z1gliOr64QN4OJfxde4zsqulkZ
 Qps=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="250704462"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 17:54:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOHvX+0GsYU9WBPex6fuClgDHvSsMHOVlr2YyXc6Hvxrn11f9KTPj7STMJb+h0ww0Zhf4xsXgRgU8jsVIF0meRNUtZMDJyhXQ50JxgtcAsSuObeWRXY6lTmuzmN13X4zIKNMeNmGuZxFJa13FKZHYu/kcvOVuYZ7mi1XoOV7XKhRTFCEg1TBBYGpnsTzUhlB7PsqVuArAKPOgk4hawPlWQ+gCwGoXm+H/2M23PoZP9f/4D1zsZiSXh27iTotptWOaxszyLPwhWaLHAKOhb9Qt1RG9zACVmBGitqDIhutU7kmIUN+tcc07qurzhbi1tL+2rq157HHvgAGVnZiqWCk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWrtpcoeh0luRt+Se4/Nj87QwIcHli/+eHO14SRDIss=;
 b=Hh/ViF6wWq84olEOrV4pa/spBqole/AIg2r7sUqaAk/1LWDz1PTvR87TxHERj/KRTtO8CEJl1v6UF8JKrznMrSawlC4GC1dR6HfXCHnlsN+VogDjq7H8WQNSCEFf2D1E8v+3w63uS8fmJQNLnAnGxpKnQPJT3RjisdvY3Jgyjvx7rQaDkVG3KMsBCqucy8STNNB9mLt9hcgty5naN0IHnB1sKFmmBB+Ok36UoXs885Kwb0194AZbNQYTfDmLGQzeT6O7j7RuCbsk8hu1rHIIX/ugQQWJE69j02vvea1rT/q6RA6RaVBRfwNrSEm4qastYOQi/BhfHn2GvTWsufgOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWrtpcoeh0luRt+Se4/Nj87QwIcHli/+eHO14SRDIss=;
 b=V1FhPzM8WZ7szQ7fKWzZJCWy7DmKbWM93PgASi8l3fgjVxOpezwppnFKjiFUCWbmX70u4QAAumQf3flEYxelD+eZsb9njhktsrEaNDoDjmf7iub9kFafyvJWTrXn3FZy2/kYLHuZJFMOiBWO0FcZYkX5x2v+lifDl3CWO/nBbIs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:54:12 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:54:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3 4/4] block: add attributes to zone report
Thread-Topic: [PATCH v3 4/4] block: add attributes to zone report
Thread-Index: AQHWUFK3RxUfGqWvLEyZ9ArAbfPr+Q==
Date:   Thu, 2 Jul 2020 09:54:12 +0000
Message-ID: <CY4PR04MB3751CAC724F706063EA0D87EE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702092438.63717-1-javier@javigon.com>
 <20200702092438.63717-5-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9696c36c-4ec3-4a42-2cf3-08d81e6ddfe1
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0246E687CE3AE98284D293CBE76D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5DplzHkY1WMUpPfhS3K/Hofpj6/ZLZzXJKBL8JzWaYQ8nbgXDdWeM4MY5RBRSUTNMHMpB1y9C6DqIv8Tsww9ohGvHTJ22douYldRBLVHaHnz/2WrC/epSCXVbZrWwJUtFxaJ1l/V+syjZlAnQq/k/Fyf0a7YnZ/56AJko82D2uj3AGVwPSPWXQc7dvPdppoZaROUM6khJgKV2gfjy59/J3SISprLBc7By84Eh0lwAu/RjxpRB5rWphnc6FzUTy6BCBD0liS/bQO1ogYVih7ld98NxPbZJR9/qxl7K//BkZBlivN18RUT+BKh7RnOHmz7LPS0lbpY2xwjRzq+/eJtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(52536014)(54906003)(33656002)(8936002)(2906002)(83380400001)(53546011)(7696005)(66574015)(8676002)(4326008)(6506007)(110136005)(7416002)(86362001)(71200400001)(316002)(66556008)(5660300002)(186003)(64756008)(478600001)(9686003)(55016002)(66446008)(26005)(76116006)(91956017)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eljEybN7DZjPZteDahXRdUo6U4oUOhM3nrKKPScnftRxUMijEz/2jFAyJd95zzCB2FwNojTR09tofyb8Lmd+m1J5HZx3sBp7qxrYN5+YibN7y+POPXdB0aVvC7nOhMCKKDnpUGviulKNYUUWFprtmYbnqYQ0PWhpq9GjTC+gfo0unCpIOAR471A2AmenshLK24V34N5zQLyeJQl212u1dLJ06C40CO+ThYfV3ZZgRAPtDIeLuIPnIcckAuMbHp3tBessA2HwB7yAVRc8xG+LWL+qL4ivyTjMqFsm+acDlH+GE9VH0kdpm4FMkvkBKIXTHsil7PlgD2QVFozYz7WYopMtzXCu0KYa69gfdhItAeuH/+E55zGHmIkQ4E0mK26cDegg1kIyk0Xn+avFkLeBtdtZFvQtS4zKYw3z7Dsar9WWCsDm0KDflU8HNvJ2mEz6UvQye39jrExlBwn23vSsreOoewXdbPO2cUgM05PmACkEd6k8ii4TVqe1+vkjN3PH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9696c36c-4ec3-4a42-2cf3-08d81e6ddfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 09:54:12.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfyX/3rlX9AvsLcZVftJAgYszoGW2zVDeHPDHxdF2B0q1P0A9QpO+9XPrA7vpPTEaWme1TzaOBfAhNrnI9xMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/02 18:25, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> Add zone attributes field to the blk_zone structure. Use ZNS attributes=
=0A=
> as base for zoned block devices and add the current atributes in=0A=
> ZAC/ZBC.=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  drivers/nvme/host/zns.c       |  3 ++-=0A=
>  drivers/scsi/sd.c             |  2 +-=0A=
>  drivers/scsi/sd_zbc.c         |  8 ++++++--=0A=
>  include/uapi/linux/blkzoned.h | 26 +++++++++++++++++++++++++-=0A=
>  4 files changed, 34 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
> index daf0d91bcdf6..926904d1827b 100644=0A=
> --- a/drivers/nvme/host/zns.c=0A=
> +++ b/drivers/nvme/host/zns.c=0A=
> @@ -118,7 +118,7 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,=0A=
>  	}=0A=
>  =0A=
>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_SUP_OFFLINE;=0A=
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_CAPACITY | BLK_Z=
ONE_SUP_OFFLINE;=0A=
=0A=
Wrong flag added, as already signaled.=0A=
=0A=
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>  free_data:=0A=
>  	kfree(id);=0A=
> @@ -197,6 +197,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,=
=0A=
>  	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));=0A=
>  	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));=0A=
>  	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));=0A=
> +	zone.attr =3D entry->za;=0A=
=0A=
Mask on defined attributes ?=0A=
=0A=
>  =0A=
>  	return cb(&zone, idx, data);=0A=
>  }=0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index b9c920bace28..63270598aa76 100644=0A=
> --- a/drivers/scsi/sd.c=0A=
> +++ b/drivers/scsi/sd.c=0A=
> @@ -2967,7 +2967,7 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)=0A=
>  	if (sdkp->device->type =3D=3D TYPE_ZBC) {=0A=
>  		/* Host-managed */=0A=
>  		q->limits.zoned =3D BLK_ZONED_HM;=0A=
> -		q->zone_flags =3D BLK_ZONE_REP_CAPACITY;=0A=
> +		q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_ATTR;=0A=
>  	} else {=0A=
>  		sdkp->zoned =3D (buffer[8] >> 4) & 3;=0A=
>  		if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk)) {=0A=
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
> index 183a20720da9..51c7f82b59c5 100644=0A=
> --- a/drivers/scsi/sd_zbc.c=0A=
> +++ b/drivers/scsi/sd_zbc.c=0A=
> @@ -53,10 +53,14 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp=
, u8 *buf,=0A=
>  =0A=
>  	zone.type =3D buf[0] & 0x0f;=0A=
>  	zone.cond =3D (buf[1] >> 4) & 0xf;=0A=
> -	if (buf[1] & 0x01)=0A=
> +	if (buf[1] & 0x01) {=0A=
> +		zone.attr |=3D BLK_ZONE_ATTR_NRW;=0A=
>  		zone.reset =3D 1;=0A=
> -	if (buf[1] & 0x02)=0A=
> +	}=0A=
> +	if (buf[1] & 0x02) {=0A=
> +		zone.attr |=3D BLK_ZONE_ATTR_NSQ;=0A=
>  		zone.non_seq =3D 1;=0A=
> +	}=0A=
>  =0A=
>  	zone.len =3D logical_to_sectors(sdp, get_unaligned_be64(&buf[8]));=0A=
>  	zone.capacity =3D zone.len;=0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index 8b7c4705cef7..b48b8cb129a2 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -77,16 +77,39 @@ enum blk_zone_cond {=0A=
>   * enum blk_zone_report_flags - Feature flags of reported zone descripto=
rs.=0A=
>   *=0A=
>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.=0A=
> + * @BLK_ZONE_REP_ATTR: Zone attributes reported.=0A=
>   * @BLK_ZONE_SUP_OFFLINE : Zone device supports explicit offline transit=
ion.=0A=
>   */=0A=
>  enum blk_zone_report_flags {=0A=
>  	/* Report feature flags */=0A=
>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),=0A=
> +	BLK_ZONE_REP_ATTR	=3D (1 << 2),=0A=
>  =0A=
>  	/* Supported capabilities */=0A=
>  	BLK_ZONE_SUP_OFFLINE	=3D (1 << 1),=0A=
>  };=0A=
>  =0A=
> +/**=0A=
> + * enum blk_zone_attr - Zone Attributes=0A=
> + *=0A=
> + * Attributes of the zone. Reported in struct blk_zone -> attr=0A=
> + *=0A=
> + * @BLK_ZONE_ATTR_ZFC: Zone Finished by Controller due to a zone active =
excursion=0A=
> + * @BLK_ZONE_ATTR_FZR: Finish Zone Recommended required by controller=0A=
> + * @BLK_ZONE_ATTR_RZR: Reset Zone Recommended required by controller=0A=
> + * @BLK_ZONE_ATTR_NSQ: Non Sequential zone=0A=
> + * @BLK_ZONE_ATTR_NRW: Need Reset Write Pointer required by controller=
=0A=
> + * @BLK_ZONE_ATTR_ZDEV: Zone Descriptor Extension Valid in zone report=
=0A=
> + */=0A=
> +enum blk_zone_attr {=0A=
> +	BLK_ZONE_ATTR_ZFC	=3D 1 << 0,=0A=
> +	BLK_ZONE_ATTR_FZR	=3D 1 << 1,=0A=
> +	BLK_ZONE_ATTR_RZR	=3D 1 << 2,=0A=
> +	BLK_ZONE_ATTR_NSQ	=3D 1 << 3,=0A=
> +	BLK_ZONE_ATTR_NRW	=3D 1 << 4,=0A=
> +	BLK_ZONE_ATTR_ZDEV	=3D 1 << 7,=0A=
> +};=0A=
> +=0A=
>  /**=0A=
>   * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.=0A=
>   *=0A=
> @@ -113,7 +136,8 @@ struct blk_zone {=0A=
>  	__u8	cond;		/* Zone condition */=0A=
>  	__u8	non_seq;	/* Non-sequential write resources active */=0A=
>  	__u8	reset;		/* Reset write pointer recommended */=0A=
> -	__u8	resv[4];=0A=
> +	__u8	attr;		/* Zone attributes */=0A=
> +	__u8	resv[3];=0A=
>  	__u64	capacity;	/* Zone capacity in number of sectors */=0A=
>  	__u8	reserved[24];=0A=
>  };=0A=
> =0A=
=0A=
Similarly to BLK_ZONE_REP_CAPACITY, I do not see the point of having=0A=
BLK_ZONE_REP_ATTR added to q->zone_flags. Rename that one q->zone_features =
and=0A=
have report zones do:=0A=
=0A=
	re.flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_ATTR | q->zone_features;=
=0A=
=0A=
Devices such as nullblk can simply have zone->attr at 0, always. That is st=
ill=0A=
correct. BLK_ZONE_REP_ATTR means "have attr field", not "attributes are set=
".=0A=
seems a lot cleaner and simpler to me. For zone_features, it would be zone=
=0A=
offline only, but as already discussed, I do not think that a feature flag =
is=0A=
the best approach as that complicates support for device mapper.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
