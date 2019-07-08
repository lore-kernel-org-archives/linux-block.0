Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC5BC606C9
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D0F2086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 18:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hVraNxve";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vncIqZBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfGHSvs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:51:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51724 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfGHSvs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 14:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562611908; x=1594147908;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ifd0d9tIIbUIYxvx01mpdZrEU3qXePA1pmjEVltjV/g=;
  b=hVraNxve4C6uH2oUFwVRxsMxdKFZW+b1k1yZsDLBhXxPMP7jauB6PtSB
   NY8cgbsrGK97pZx9JxawxTFw6hHRDSitq+ocK9+swZMss/g0oh9Fzb26P
   5+ku+4gbvH2In3iK3vctk56KPb8L4w7Qxca7byYzy/A1Qr/iE1XxxPH2Y
   K4yf2JfziVrS5OLTcmqjWOzWZMT6SSFR75LYzA53t+WO9EDem/VKdTN3p
   kVO1O7szAu8mnxMBPxfb/9icDZIhuXNhCNhOxPgj/jM9OduU02GLOhAG0
   2RteqiiOpVPvDjXjPMvDvBJkldsw7ayY2yMQzCKjs2Ezrnkf8XWpzKSp/
   A==;
IronPort-SDR: SbWe+cdTQuUjrxL8sThz3pHY2B1PEenOtIVLwFLH1yu4IdtRrLsVAUqYFFXwJNPpZWJEIAKOQM
 wjPujJxqTnmyN6qmdj6mdbizMFq9wLm2JB5oj9HzmqQuFqmF15kYe6zBHwIiCX0IMPQ2Ez6UbA
 DDwkSLZ+TcvCydK/9AMQwT0ZeEzk555zV+I9WLlDK/ddHkUEuaZmIzx1dLF6P5VYCjLJOLPHAy
 6Y6Kip0lB10dNN32GuslDkrBqwokUzHeAGFipLbdxYf3XvWb84Z8vSERbW+AbfGCY5Wr4JVHuv
 gTM=
X-IronPort-AV: E=Sophos;i="5.63,466,1557158400"; 
   d="scan'208";a="113649691"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 02:51:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2KSWXN9UBgj3z7Dj1LN9LfcUG6VsnSVHAJzJKgcQug=;
 b=vncIqZBjPpzROP4B7qWrMG9jOUYfx4BlihTksydQsZwXDopPYKwwsBDT5tUz6gPwbxcFEi73tK+0N5eaC8ApBBgGaHIObxkhCzRISgCuLcUglQBLSg/VB/LKIln+cQl+vEKaOFX5kpMlPYAaOkdc+YC7/mRXA5Qc1LVWOkz3//4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4454.namprd04.prod.outlook.com (52.135.237.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 18:51:46 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2052.010; Mon, 8 Jul 2019
 18:51:46 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: use SECTOR_SHIFT consistently
Thread-Topic: [PATCH] null_blk: use SECTOR_SHIFT consistently
Thread-Index: AQHVMRTLjZgILB6sYkKypTgpNVO2Jw==
Date:   Mon, 8 Jul 2019 18:51:46 +0000
Message-ID: <BYAPR04MB57491022743F5264BDFF33CE86F60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190702202857.4433-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b06a40a-79b8-4179-4714-08d703d553f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4454;
x-ms-traffictypediagnostic: BYAPR04MB4454:
x-microsoft-antispam-prvs: <BYAPR04MB44549BB0A156F91F427BB57986F60@BYAPR04MB4454.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(81156014)(229853002)(81166006)(102836004)(186003)(72206003)(8676002)(71200400001)(26005)(71190400001)(3846002)(8936002)(6116002)(66476007)(6916009)(86362001)(478600001)(76176011)(9686003)(305945005)(256004)(7696005)(486006)(6246003)(25786009)(6436002)(55016002)(5640700003)(53936002)(6506007)(53546011)(74316002)(7736002)(99286004)(52536014)(33656002)(316002)(68736007)(2501003)(64756008)(66946007)(73956011)(66446008)(2351001)(66556008)(76116006)(5660300002)(2906002)(446003)(476003)(66066001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4454;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VBgskGdyIhxV0dw6NhlEWN3GNQaodzxo1yH9ZI48ZMkarKoCdaz5iQtt+LBB9/wlYl0B25kg4dZ20I/KTKelWVGamJiipt+d2XYjXv6EMk0aQsew/7APHpj7R8MsDwo6tYgLCUDU9jQtn60gfUokivwZ93pgnMA06G/sqpYeV0FxSrRwCYRE51OCKhbuUvl5S0D5Lp328DTdIcG1XuvwN4EQBzeeuayOr5/9Im3AHVhMMs8/8gLrQ/eRFUWOG5r6y53VWfJpk3MX6/GKeXHM+/DWdqLqXmmKsMV6TaNSzkjIfdyquaJetO0AbdicvJJgirk3oKEg2w/0KKOLm1uxlNXFf1XxSAD0RtKHazeCCYufQ7DPNPDr6ZHORprZ7zDlJhWvBRm3qPIdw5CT7k4+7YMUYLLFq0JsIJ43VDsESuo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b06a40a-79b8-4179-4714-08d703d553f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 18:51:46.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4454
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Minwoo and Marcus reviewed this patch in the last week.=0A=
=0A=
Ping ?=0A=
=0A=
On 07/02/2019 01:29 PM, Chaitanya Kulkarni wrote:=0A=
> This is a pure cleanup patch and doesn't change any functionality.=0A=
> In null_blk_main.c we use mixed style of the code SECTOR_SHIFT and=0A=
>>> 9. Get rid of the >> 9 and use SECTOR_SHIFT everywhere.=0A=
>=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>   drivers/block/null_blk_main.c | 6 +++---=0A=
>   1 file changed, 3 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index cbbbb89e89ab..860d9c17b615 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1203,7 +1203,7 @@ static blk_status_t null_handle_cmd(struct nullb_cm=
d *cmd)=0A=
>   		if (dev->queue_mode =3D=3D NULL_Q_BIO) {=0A=
>   			op =3D bio_op(cmd->bio);=0A=
>   			sector =3D cmd->bio->bi_iter.bi_sector;=0A=
> -			nr_sectors =3D cmd->bio->bi_iter.bi_size >> 9;=0A=
> +			nr_sectors =3D cmd->bio->bi_iter.bi_size >> SECTOR_SHIFT;=0A=
>   		} else {=0A=
>   			op =3D req_op(cmd->rq);=0A=
>   			sector =3D blk_rq_pos(cmd->rq);=0A=
> @@ -1408,7 +1408,7 @@ static void null_config_discard(struct nullb *nullb=
)=0A=
>   		return;=0A=
>   	nullb->q->limits.discard_granularity =3D nullb->dev->blocksize;=0A=
>   	nullb->q->limits.discard_alignment =3D nullb->dev->blocksize;=0A=
> -	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);=0A=
> +	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> SECTOR_SHIFT);=0A=
>   	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);=0A=
>   }=0A=
>=0A=
> @@ -1521,7 +1521,7 @@ static int null_gendisk_register(struct nullb *null=
b)=0A=
>   	if (!disk)=0A=
>   		return -ENOMEM;=0A=
>   	size =3D (sector_t)nullb->dev->size * 1024 * 1024ULL;=0A=
> -	set_capacity(disk, size >> 9);=0A=
> +	set_capacity(disk, size >> SECTOR_SHIFT);=0A=
>=0A=
>   	disk->flags |=3D GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;=
=0A=
>   	disk->major		=3D null_major;=0A=
>=0A=
=0A=
