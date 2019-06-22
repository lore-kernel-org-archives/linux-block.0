Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23183C43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 01:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE97520881
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 01:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oLXbFf2v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ILEoYwB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfFVBDB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 21:03:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25771 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFVBDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 21:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561165409; x=1592701409;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Udndhz60ZzlfIpHCFeg0jc33OOEAT1IEHGJWYT7AkSI=;
  b=oLXbFf2vzvHkoOcMu+olU87Yw/KRNxs3U6WxMdEBQiLT5Coi50ziHZyy
   zIZV1U9BiyAmgIWDBskq2yuqNUx/s0VGYaDYg2O7AFQ2FhdnI9T9A2mPp
   KJPDef279kDfnyf9Ldv+0mpun8do6msSQ750jC5psy630z8UFjYb5oDeD
   lRRM1EnHqAwbjbG/o2SZa8t+PXoynmnwmLCWZPPYP7OUKG7+BCPmXvzz5
   1cidxbO0EtOUuVUdm7FSdRcdSXUeg/IQdUY4xltNRBJI78B7w5/3ODVnb
   zZgapC1YXflehQvnJgKzA4YoWofsCfw3aZutAoaorfdtKd1s7K2T6+W/9
   w==;
X-IronPort-AV: E=Sophos;i="5.63,402,1557158400"; 
   d="scan'208";a="210966298"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 09:03:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxhXsic7HCm3JaUSZgoQTreVYV33L1KfbJ+EQXdKi6o=;
 b=ILEoYwB2jxL1/pMblb8QS49+oV6UFU2CU4YLnsSNtVmmYd/rokHyoL9tHv8RZRKpyZeZeh4WOuFrMzrrP1SLHWhbJCv1YEi29nor5XvDrLPrknoWdDvW7ToVpgCqmr1RvC7GiYpJnP4FHeAB496mQUvgfq27rw/Bc2UtBLkq6w4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5142.namprd04.prod.outlook.com (52.135.235.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 22 Jun 2019 01:02:57 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Sat, 22 Jun 2019
 01:02:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 2/4] null_blk: add zone open, close, and finish support
Thread-Topic: [PATCH 2/4] null_blk: add zone open, close, and finish support
Thread-Index: AQHVKDJPvRqrrDdCI02PGkGKUbxkfQ==
Date:   Sat, 22 Jun 2019 01:02:57 +0000
Message-ID: <BYAPR04MB5816D471063D970DDCF9AEC7E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-3-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d46e582-e6b4-4697-e547-08d6f6ad5d27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5142;
x-ms-traffictypediagnostic: BYAPR04MB5142:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB514291E08B70C40920C7DC6AE7E60@BYAPR04MB5142.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(6246003)(7416002)(25786009)(14454004)(6436002)(68736007)(52536014)(72206003)(316002)(66446008)(64756008)(66556008)(66476007)(66946007)(71190400001)(71200400001)(73956011)(91956017)(76116006)(5660300002)(66574012)(478600001)(55016002)(2501003)(229853002)(2906002)(66066001)(9686003)(74316002)(14444005)(305945005)(7736002)(7696005)(76176011)(81166006)(186003)(476003)(81156014)(486006)(446003)(256004)(8936002)(4326008)(8676002)(110136005)(54906003)(53936002)(6116002)(3846002)(26005)(99286004)(6506007)(86362001)(102836004)(53546011)(33656002)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5142;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PkAnvaKGB2HsQemJLvBkMO67uA8gGV03iMOEKSErEPPZmvtRaHQyJ6E0IjzXdkueUZRXIfTzhqtbPSUxGJS2oM2SxFVQzIm+Y6HPT7E9hmpHefvtT64llT6r3QOpdEzjv7nGrsOvdl5C/UGeUqB5GXOG1n2ECR4TvW/QLMed6oU+ze/Fl+Pa4m3DqSHoSZ8IYI4A0u6W7rIL5l0nGfJVWAhDZnryjuPGMxq107YZQmVH9wRIxgY8qcLsTAyH9FeM4sC26F+0CY6mFdCy1RrsEDovnDlnEYmmOJOlIiJG4zu1SZahgEkKYjKDnYS5M7uAPAbbDYX5EZrE1R0aJutnRgszIhKNKo5TQ7dC6BZ3pEKUiWv6oV/s3biY4sgC2qW3m6Xwpuk9brqN50cfmpwRwpS+2mePHUhwViBtvPSxfrc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d46e582-e6b4-4697-e547-08d6f6ad5d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 01:02:57.1375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5142
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/21 22:07, Matias Bj=F8rling wrote:=0A=
> From: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> =0A=
> Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH=0A=
> support to allow explicit control of zone states.=0A=
> =0A=
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> Signed-off-by: Matias Bj=F8rling <matias.bjorling@wdc.com>=0A=
> ---=0A=
>  drivers/block/null_blk.h       |  4 ++--=0A=
>  drivers/block/null_blk_main.c  | 13 ++++++++++---=0A=
>  drivers/block/null_blk_zoned.c | 33 ++++++++++++++++++++++++++++++---=0A=
>  3 files changed, 42 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
> index 34b22d6523ba..62ef65cb0f3e 100644=0A=
> --- a/drivers/block/null_blk.h=0A=
> +++ b/drivers/block/null_blk.h=0A=
> @@ -93,7 +93,7 @@ int null_zone_report(struct gendisk *disk, sector_t sec=
tor,=0A=
>  		     gfp_t gfp_mask);=0A=
>  void null_zone_write(struct nullb_cmd *cmd, sector_t sector,=0A=
>  			unsigned int nr_sectors);=0A=
> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);=0A=
> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector);=0A=
>  #else=0A=
>  static inline int null_zone_init(struct nullb_device *dev)=0A=
>  {=0A=
> @@ -111,6 +111,6 @@ static inline void null_zone_write(struct nullb_cmd *=
cmd, sector_t sector,=0A=
>  				   unsigned int nr_sectors)=0A=
>  {=0A=
>  }=0A=
> -static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t secto=
r) {}=0A=
> +static inline void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sec=
tor) {}=0A=
>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  #endif /* __NULL_BLK_H */=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 447d635c79a2..5058fb980c9c 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1209,10 +1209,17 @@ static blk_status_t null_handle_cmd(struct nullb_=
cmd *cmd)=0A=
>  			nr_sectors =3D blk_rq_sectors(cmd->rq);=0A=
>  		}=0A=
>  =0A=
> -		if (op =3D=3D REQ_OP_WRITE)=0A=
> +		switch (op) {=0A=
> +		case REQ_OP_WRITE:=0A=
>  			null_zone_write(cmd, sector, nr_sectors);=0A=
> -		else if (op =3D=3D REQ_OP_ZONE_RESET)=0A=
> -			null_zone_reset(cmd, sector);=0A=
> +			break;=0A=
> +		case REQ_OP_ZONE_RESET:=0A=
> +		case REQ_OP_ZONE_OPEN:=0A=
> +		case REQ_OP_ZONE_CLOSE:=0A=
> +		case REQ_OP_ZONE_FINISH:=0A=
> +			null_zone_mgmt_op(cmd, sector);=0A=
> +			break;=0A=
> +		}=0A=
>  	}=0A=
>  out:=0A=
>  	/* Complete IO by inline, softirq or timer */=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index fca0c97ff1aa..47d956b2e148 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -121,17 +121,44 @@ void null_zone_write(struct nullb_cmd *cmd, sector_=
t sector,=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)=0A=
> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector)=0A=
>  {=0A=
>  	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>  	unsigned int zno =3D null_zone_no(dev, sector);=0A=
>  	struct blk_zone *zone =3D &dev->zones[zno];=0A=
> +	enum req_opf op =3D req_op(cmd->rq);=0A=
>  =0A=
>  	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
>  		cmd->error =3D BLK_STS_IOERR;=0A=
>  		return;=0A=
>  	}=0A=
>  =0A=
> -	zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> -	zone->wp =3D zone->start;=0A=
> +	switch (op) {=0A=
> +	case REQ_OP_ZONE_RESET:=0A=
> +		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> +		zone->wp =3D zone->start;=0A=
> +		return;=0A=
> +	case REQ_OP_ZONE_OPEN:=0A=
> +		if (zone->cond =3D=3D BLK_ZONE_COND_FULL) {=0A=
> +			cmd->error =3D BLK_STS_IOERR;=0A=
> +			return;=0A=
> +		}=0A=
> +		zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
=0A=
=0A=
With ZBC, open of a full zone is a "nop". No error. So I would rather have =
this as:=0A=
=0A=
		if (zone->cond !=3D BLK_ZONE_COND_FULL)=0A=
			zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
		=0A=
=0A=
> +		return;=0A=
> +	case REQ_OP_ZONE_CLOSE:=0A=
> +		if (zone->cond =3D=3D BLK_ZONE_COND_FULL) {=0A=
> +			cmd->error =3D BLK_STS_IOERR;=0A=
> +			return;=0A=
> +		}=0A=
> +		zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
=0A=
Sam as for open. Closing a full zone on ZBC is a nop. And the code above wo=
uld=0A=
also set an empty zone to closed. Finally, if the zone is open but nothing =
was=0A=
written to it, it must be returned to empty condition, not closed. So somet=
hing=0A=
like this is needed.=0A=
=0A=
		switch (zone->cond) {=0A=
		case BLK_ZONE_COND_FULL:=0A=
		case BLK_ZONE_COND_EMPTY:=0A=
			break;=0A=
		case BLK_ZONE_COND_EXP_OPEN:=0A=
			if (zone->wp =3D=3D zone->start) {=0A=
				zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
				break;=0A=
			}=0A=
		/* fallthrough */=0A=
		default:=0A=
			zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
		}=0A=
=0A=
> +		return;=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
> +		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> +		zone->wp =3D zone->start + zone->len;=0A=
> +		return;=0A=
> +	default:=0A=
> +		/* Invalid zone condition */=0A=
> +		cmd->error =3D BLK_STS_IOERR;=0A=
> +		return;=0A=
> +	}=0A=
>  }=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
