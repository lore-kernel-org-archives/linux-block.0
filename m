Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F70C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 06:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB62524650
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 06:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nIV23a9v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DcFhVKwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfLSG5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:57:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45385 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfLSG5i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 01:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576738658; x=1608274658;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dqBdyITi3lHTdHfSoDm/oxE1q6+2/8BXZ87CicdGaPU=;
  b=nIV23a9vg/TIcX3azH3ALp8pZiXf+Tx0BdS7c7sXXsm3SCCdsgbPhyWQ
   Xzrzx5t4D6MgbA0NaC2EReI9KbZzA9E3SEJgz7xMhR6lWkBPrf6A0uKHC
   YHr9iXvouXq8MZ9jom7FIq21K00jawWtpwhp4eN3ize+b3GjvyIhl9mK5
   0wthazxe/81kq3LhPMucdBQRRXElZV6m6w9wRbmeg+aiiwOQL6u4MiZ5L
   7IrpYT9XSSfwvxX5KBiMvHrfkvPb0IJzVEq9/ssVb2M5xAC7wv8ckV6Oj
   /PBDozHusokWZChaOjwDTcxyYfmIhG2akLuqoGoxYvJFBmhBPnJA5GLbU
   Q==;
IronPort-SDR: FEVHITVIeo2X3m3Ko6yigjakIJOWTMsvnTzouMfm8g4EAbsYitU+XDCMHlGyIvcxqKcieceSow
 yp5N8Y3Bef/ydWHl6g1mHnB2OT5wqDEjch8lc48aIBJxa2WrgZzC7AFpF1IxifQeusuFyALPRf
 zI1u2OUqjWUm+rflM8G7X8GmpwK+2EC2+/7e81FwLFAvnWH5kVpqewqDv4RMZ90i2P+EMWqpSm
 5IFradVeMKLaiPZYCgAhH4anTwZhAj4yztbVosOFTjJH9c1QReE8HGkZROvkJV9JkHwxKRzgT/
 qoI=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="127312778"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 14:57:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5FqW2iXwGPgBXwXr2mImQOrrma7lAiCJxsTxCsyPd2e4u0wAe+jVIVQyxiXAQpM+WD8g5Pe7nCByKNVqMLwCmrnzb5Hv4K/sXZCUa8c7SW0Fgg7mFOLDsv4XJeR1XdBuKh/v1cFN1pPCCPjxcU5RZjDyU34t6KibsdDNQva1D6Pg8DtWgkgbYqbPGQrKg+cAxVGF6dP7khe7gC8D7aAgE/xg9aMNWdw3RgORLPgpPZgUAK61ZmuZwL1iuzAUQcJgWcAM7U2BJ6Ql9arAlDiMjeSyst7PD84bTnIHOXSGtFfd1m1293ESDj1gipSxNfqUf3bniBnPUmfuzFbHggAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QTCJ2hSwz+cI+ffgGTQNlPseu7hAxIEYP/BGngJhak=;
 b=WXQ8PM8yf1JW1e3Hp8RC0+LpPKbP/bVCoTpSVjuYr1BFrSPQHIAYn7RwVUlVmItByt2Kq1359gDDmHeZlcJbXNpN/RD4gdOMIHlrxw1dBMBUWZUicfI/4mAG27DVO1ZNdo9LyMjV66hGAGZP6mNPcteJWw37wWcQ67R1wjBkGQuNNwAXG0aZCOJ6v3ETs5mpG/xrRlmta0jaAM3NvTNmVrrrQnwtx75OhZVyDMo/kN6dkt5a0ccdOtCQDdtzNSh+N5VrejTZ6kF387UYzsAFvP6uR+QOUsX+pbLCCeZlWmsnlcJ3KZVBCIhh4zUDFRjQ26gjE+Q9AjdXWwFJze4S0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QTCJ2hSwz+cI+ffgGTQNlPseu7hAxIEYP/BGngJhak=;
 b=DcFhVKwJMjlFJ7CNO1CdlVw51NOVXqDQlW0kgy+6ac9rqirHtaPN3OEmkXDCtPkhZ6ImmEf6ZTLFq0e27VzXVZdZ8lWH5mR8ZMw7/Xupvav7p+n1L/u3RAgThFopLWxc6BapNo8h26ibPM4y9FitKT0mN2pysOSOKffLFmtumbM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5894.namprd04.prod.outlook.com (20.179.57.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 06:57:34 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 06:57:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "damien.lamoal@wdc.com" <damien.lamoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: mark zone-mgmt bios with REQ_SYNC
Thread-Topic: [PATCH] block: mark zone-mgmt bios with REQ_SYNC
Thread-Index: AQHVtjOXvHk0IHCqMUKxZxl2lJK9uQ==
Date:   Thu, 19 Dec 2019 06:57:34 +0000
Message-ID: <BYAPR04MB58164734CA73702BAB2745F8E7520@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191219061423.3775-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6304c7a7-650a-445e-80a2-08d78450b9e9
x-ms-traffictypediagnostic: BYAPR04MB5894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58942D05CE707F9B833A1A52E7520@BYAPR04MB5894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(6506007)(54906003)(26005)(186003)(86362001)(33656002)(478600001)(71200400001)(53546011)(8676002)(81156014)(7696005)(81166006)(66556008)(316002)(8936002)(2906002)(55016002)(66946007)(4326008)(5660300002)(9686003)(52536014)(76116006)(66446008)(64756008)(91956017)(4744005)(110136005)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5894;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SH+vMqtHExIezNlx/Xfbe1zsAH+CiVGtElEnQrQ9ZJeSJC1y6gcTqPSC4TsnfhVHQw54vsvYF95Ib8wG+76LIHj5ove6AztK2qZd+0POtyG0WEYC4+4vnPUsST78d+34WAfYRIiL5ffN3au8VKZQR2VPOrzVr+JTBwCsBMi9KbnoMPG6HX0ezibY6Tdc/6ysUy7nZwFVmL8Gvhzt77a9KsSDgHVrLMR9n0DjzT7dB5Oy565sUNwmJLOgTstkKEoMXUzOzUH6BKor81Wiyk2Cs6UOeqv+AtS0xnmD+/xEFOS/vF7jY9BW8skST2wCsvzgLk97U6+mzlvLdcjYhfdmpkYZey4BnCvldDToc471FdmyLt/xEGYGujnvzgn6bcUNXz+BYX123BiqUiMV96sfqkg82IRLz/dFT4vcsBzXXolJw8JVrL0KZZEWWfmRc6XH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6304c7a7-650a-445e-80a2-08d78450b9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 06:57:34.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1nWAYE66WBGVHfQAoz5SMlZ7RiUIZ5CEUsVA5Ferykq1IgmMMGdLtIsqsCqssdITbJJl74tIHRSGBTGtFhN/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5894
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/12/19 15:14, Chaitanya Kulkarni wrote:=0A=
> This patch marks the zone-mgmt bios with REQ_SYNC flag.=0A=
> =0A=
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-zoned.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index d00fcfd71dfe..05741c6f618b 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -198,7 +198,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum =
req_opf op,=0A=
>  			break;=0A=
>  		}=0A=
>  =0A=
> -		bio->bi_opf =3D op;=0A=
> +		bio->bi_opf =3D op | REQ_SYNC;=0A=
>  		bio->bi_iter.bi_sector =3D sector;=0A=
>  		sector +=3D zone_sectors;=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
