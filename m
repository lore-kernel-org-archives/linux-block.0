Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17727C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7D9206A1
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hLq1H8N7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="niJpKPU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgFZBpU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:45:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36100 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgFZBpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 21:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593135919; x=1624671919;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7QPhix6wV2j77qTskwkpa2g7P3oI3Bsje1haoEiVLr8=;
  b=hLq1H8N7OZUNuAQS81L917XMqPX/sqqhRFKRxbdHkVG5506qzmGkB5j/
   vVl1DaTohs3Aq7Dq+SJl3dPqEZncl1LuFgCHrSSKXXFAPFJlqca1euIUi
   mpbxXR1cQfxPB417p60Tdu6ZQ/o5Lgytg2KqDdnLmRXW8w5krQL2Ag1Z+
   TdujrIZlXE8uB2gQgGXsoFmZ0WkktR4QpBianIDjK+ZOrpPDxOR354BaI
   E8zsEHQhVygYtObZdnQn2Ap9u2Pm2j65ceNSl5vYiC0weydGqJTNq5YWG
   hDjYvmObFru6PYpdEFqac3HrVKEhNDm3G9U4O7PN2cp8LcazgFbo2KX2H
   Q==;
IronPort-SDR: XJ4kmlN+geR015j+wpCr+YIe/wqDyiJRBcnvQQTimI0PHRKd9Zrj2/4IcvX2p0W2KrexVB3rmD
 hHczCLB6iUf0FsU4IqV87p6NuAGzljX/cf1WwZ9d8W/fhcx3ov86+223XmvBM/Cs6Rv12Pv6Xs
 JmDSe2mOaFQbWWikJ6LoXpvM71llZmhPjqjQ6M5lZOc2Mujfj5Vz2tuTIaHe390e4wEXC9kih4
 XesDU1kHHFOGOuU0eXx28Liy19JvLFmF7R9Bw5+OGnmCjRrAhCaGNoxuM9MeYdDA/HEy0E4R/A
 w60=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="141197703"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:45:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIA+NBfu2cOz1CRoCsLTVcGRtrggxnnd0uUksJWm99k9eAIH6yGZYqWo/TfP6i+iXA/WtUIu9g69clXj3j+A6krTqb3ULpPLJFil7h3q/Q5Ob8jkkZjvAdxeGZEENluZGigwLdpk+Pm5l+62SpJfhkhRsrYH62uILToBAzqKBRJOagcJ4Cr01OofJQCVuyuQuAa4rskjVkL7HJm1ztWaWghuq0pmqDTODgSiUvP3PUetvJGHoQBV/g5unzJ+oJKc2Nu1QEDBgCSdqHk85lZm4MVfexXvHELCdKJR22CxhoPwTGbGCYjTFl1omuauseIueY5xbRjUWrFbf7z0tWkSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2ccnxABwWBCO5S8LHR60OFIDWBpwkA4A4n6nxh5N4Q=;
 b=lz+TNR3zlbEI+mw/SnpC9mSQdIY0c7Uh5/mkq3/jdGAG3I4PDMnsvjD4ENQw01rbrBjQXIDS7SQlBJhoGBRIl+ShH5a+dmbBagTwDjyBq63R9gKGSe9w1AC2OQj8KAbG4pisLBxssm7WddtwvbFNXuqCC5xrNHok2kqFRXiavrCVzYjzPH9Wq0hFCOO/NgUa48hhnvHVdK/4ELapOFK6dQ6Au+s4DRyHdq+TiYBhuwRpITb5Xr/Ic8pL5DCv8d1f76DKeroNn7MXikYH21tdA8HuCj7sjMaCOCZKRGWMMdZ1Tju+FxThmC5bdZgqBh1KRKpLQPgeyd6HTJgp3GqcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2ccnxABwWBCO5S8LHR60OFIDWBpwkA4A4n6nxh5N4Q=;
 b=niJpKPU7+P8MGE/2txF7x4L8rgOuXKX/uazi823BB8S3QwxUV7eOH4ftn09k22XBmo87WQ8XAVgsg1HPheAPacEVVx3XpW2UdpPG4qr7RIRFzSoRDoLD2LmzNVIngLhNtNqOaX+khc8+9SQlNwEOpciwDk3+g8oMuqGSY29VrAI=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 01:45:17 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:45:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Thread-Topic: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Thread-Index: AQHWSutSdYSwrXPXKEe2iCYs45u1PA==
Date:   Fri, 26 Jun 2020 01:45:17 +0000
Message-ID: <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7928d84-b79f-452f-879a-08d81972942b
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-microsoft-antispam-prvs: <CY4PR04MB1030A686A582D0A1E16DD1B9E7930@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Y9cNFXvYR0A9xZp/OnR7rtqSwn3nTT2jzAMA4mtcomYtSI2fKM02f1XalIVFOUlkj6w6iwSNP/+vL0p72Nc59/JG7Xy0daqf17rmATAHcEUN0RblG8MvbAyw0AQwWi+13TJgNa4r9YNkPi61V1uD/DJ0tUaRZyydeQB70AWmMZgxhn44tMb4QYBcpnqX0dzBjXz1840jC58C1ZbL4r+Fx0b7L2NzEno3dD4QaXtj7jP6akJylxvuT62LA5eAfyJpSDO8aqDt6U4Pgw94TMWUTsGLIRMAAKFBLYHvfpAB6ge7zHSisUlRUwUx54l6dI7bZfm4Sv9dG2iVixPOpYawg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(5660300002)(186003)(76116006)(33656002)(54906003)(83380400001)(8936002)(110136005)(316002)(66574015)(8676002)(91956017)(71200400001)(9686003)(478600001)(55016002)(52536014)(4326008)(7416002)(2906002)(26005)(66476007)(66556008)(64756008)(66446008)(7696005)(6506007)(86362001)(53546011)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Nd8CB6fL6kVrYQZ21mUICJCpWJ6Pyyu+KGz7+7+bh+rOSROJG1UL55HYcsEVI9AI3l8i1LzG2TQRrQMNMd5aoG4DkOvCM2F/9Lv9ZhYGS1p9bUQtquqsgYO7SyovadOEmMg7LlFNkNoayXQo/Lkn/zO/S48i0ZirbErDkl+iIiYbJNFdPsD505TvWOz3/RNEGne3er7fFxAIa38KLXhwzJA9yzopsQnWxEm6MCoQ3CPLzYXbeFIrZGIKEk9v64HFnWj09OaEO46/dm1PW1WMf9pwVdc5twe/wWvXQw5Oqf4RXOzYGustcbNO/svb2NdP9xe/Gi0pskeMi3XpJAWrDr8B3/uw1xS4LdBt9dvMPtPjuSm5m4Aa4yqey+UzHsYA9cuOfEcCph/YZD1vdx40IUp8Ow76RvL/ljJeLnxlcntPnWp8evfsoirEgJf30fsTdZsA1WthCwUA0wdKKfdlTTk90ZqGDrHGat11vB6WuEV7prqFmZSVMUbFzBXtpT08
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7928d84-b79f-452f-879a-08d81972942b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:45:17.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iq+ibR+T68PuTdlYJPCPkMjuZDNxTu9KX6tRQ6ebYlxrawKeen7wTSbeVFDMq1RabUyJilesDOx7fu30aBAdLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> Add zone attributes field to the blk_zone structure. Use ZNS attributes=
=0A=
> as base for zoned block devices in general.=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  drivers/nvme/host/zns.c       |  1 +=0A=
>  include/uapi/linux/blkzoned.h | 13 ++++++++++++-=0A=
>  2 files changed, 13 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
> index 258d03610cc0..7d8381fe7665 100644=0A=
> --- a/drivers/nvme/host/zns.c=0A=
> +++ b/drivers/nvme/host/zns.c=0A=
> @@ -195,6 +195,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,=
=0A=
>  	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));=0A=
>  	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));=0A=
>  	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));=0A=
> +	zone.attr =3D entry->za;=0A=
>  =0A=
>  	return cb(&zone, idx, data);=0A=
>  }=0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index 0c49a4b2ce5d..2e43a00e3425 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -82,6 +82,16 @@ enum blk_zone_report_flags {=0A=
>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),=0A=
>  };=0A=
>  =0A=
> +/**=0A=
> + * Zone Attributes=0A=
=0A=
This is a user interface file. Please document the meaning of each attribut=
e.=0A=
=0A=
> + */=0A=
> +enum blk_zone_attr {=0A=
> +	BLK_ZONE_ATTR_ZFC	=3D 1 << 0,=0A=
> +	BLK_ZONE_ATTR_FZR	=3D 1 << 1,=0A=
> +	BLK_ZONE_ATTR_RZR	=3D 1 << 2,=0A=
> +	BLK_ZONE_ATTR_ZDEV	=3D 1 << 7,=0A=
These are ZNS specific, right ? Integrating the 2 ZBC/ZAC attributes in thi=
s=0A=
list would be nice, namely non_seq and reset. That will imply patching sd.c=
.=0A=
=0A=
> +};=0A=
> +=0A=
>  /**=0A=
>   * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.=0A=
>   *=0A=
> @@ -108,7 +118,8 @@ struct blk_zone {=0A=
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
You are missing a BLK_ZONE_REP_ATTR report flag to indicate to the user tha=
t the=0A=
attr field is present, used and valid.=0A=
=0A=
enum blk_zone_report_flags {=0A=
 	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),=0A=
+	BLK_ZONE_REP_ATTR	=3D (1 << 1),=0A=
 };=0A=
=0A=
is I think needed.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
