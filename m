Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2666CC43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 03:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96CA20843
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 03:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lZV/0i4K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OdHzv7aF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfD2DQm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 23:16:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8484 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfD2DQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 23:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556507801; x=1588043801;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Yf6VTMNfvkirk4RDV9XuTpjjZc2kN5tPDCNSV6eVeM8=;
  b=lZV/0i4KSZWKdhksYh2kG3SkeUP1hJp0VK0o/UIHevtZjcPpGNuz7uvH
   jgLIUByL9GVQg468MLvRlo5SLeFoLsXRHPQru4MvZGOsapahKoruBbMzB
   es7GeAtlwXTghUTGqZNimxAlyGB51iEES/nP2Vu42yaUl2tWGgfrc2F/+
   20ImX8WdJ9acaAeUM8ejkqiIapVSe2t/sX/GEIuL09sR5pKv9RIV2o5/4
   MD+OCjmzTdO8EkQ+3V+1C3rqDBkwVgk/zusBeAamJu/9cORzg1/eoWBN5
   GueVkcp0dPMtDPfJgCU/ra8PJkNgT5p/84Je2kU7gbFQZ2TMdRZCF1iTt
   g==;
X-IronPort-AV: E=Sophos;i="5.60,408,1549900800"; 
   d="scan'208";a="108761711"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2019 11:16:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85lOzvc3oOVktEc3fui+5GTKYkuQLWA5mmb+bJj/iu4=;
 b=OdHzv7aF76sgs4gM4HcuplBGywyfGHjHDi+3F0fIjJw3iC8U6DuVptlQr80MO7qkAmimN31pMFazwdfYCG9HNXEOwsdqfDgrCx2fjQhVd7IcyOuU98RPDJMNbexBT97SbIwdPxvT6Q3jHoe83s9OdsG5n+hN2utWwu0U0MDz/ZE=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4096.namprd04.prod.outlook.com (52.135.82.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 03:16:39 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Mon, 29 Apr 2019
 03:16:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Move tag field position in struct request
Thread-Topic: [PATCH] block: Move tag field position in struct request
Thread-Index: AQHU/Za+vD0GkVexX0iBn690tPuiOQ==
Date:   Mon, 29 Apr 2019 03:16:39 +0000
Message-ID: <SN6PR04MB4527CECFE2541520C05AABB786390@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190428074803.19484-1-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c735514e-2270-4b6e-6d95-08d6cc51185f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4096;
x-ms-traffictypediagnostic: SN6PR04MB4096:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4096CD659B65043822A862E386390@SN6PR04MB4096.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(256004)(86362001)(71200400001)(97736004)(14444005)(71190400001)(6116002)(186003)(81156014)(66066001)(476003)(6246003)(8936002)(486006)(229853002)(81166006)(25786009)(53936002)(52536014)(446003)(3846002)(2906002)(68736007)(6506007)(2501003)(76176011)(4326008)(102836004)(55016002)(66946007)(91956017)(5660300002)(76116006)(66476007)(66556008)(66446008)(8676002)(64756008)(7696005)(6436002)(14454004)(73956011)(7736002)(99286004)(478600001)(316002)(72206003)(110136005)(9686003)(305945005)(33656002)(26005)(53546011)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4096;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jujy04G3OShVHIfHJwWphVZnde629PUaLQ/UO/pcEBanH0XiY13iOLY75yXtfUWt/yJG9bXncuO3J+cRJcLKsGDajJv5mzfULHq2r2JHSfA+ovAHqQ6CB5uB+pqcWu6X2Yx8Wc9WeS5ND8AMTX9+z5nmaX+zeNlHLcrTEJvOktt6wXJQv93wTzEs5aBBLjzgy7ejfpf84B9odgzQCuVTuc2pTAeUsDHndwMtFyjZslz42MRXKBnDNaC+rejsCntqw7iJtPrnlfGABW44WQCi33+GyDkf32w53ac5n+In2YOsf93gvHnufxdunul/UTAZLD1mOO1/UbIeP0T7P9+drFaYmaWp5oVRPwAQ9yivYDyO0Bzco0MKfXZFvimFfWB77OcuZNss4dO5DDao/OmTLOXw6oExF7+jwcb/h5WsQKc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c735514e-2270-4b6e-6d95-08d6cc51185f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 03:16:39.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4096
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If Jens is okay with this change then :-=0A=
=0A=
Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>.=0A=
=0A=
On 4/28/19 12:48 AM, Minwoo Im wrote:=0A=
> __data_len and __sector are internal fields which should not be accessed=
=0A=
> directly in driver-level like the comment above it. But, tag field can=0A=
> be accessed by driver level directly so that we need to make the comment=
=0A=
> right by moving it to some other place.=0A=
> =0A=
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
> ---=0A=
>   include/linux/blkdev.h | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 317ab30d2904..639ca948d644 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -137,11 +137,11 @@ struct request {=0A=
>   	unsigned int cmd_flags;		/* op and common flags */=0A=
>   	req_flags_t rq_flags;=0A=
>   =0A=
> +	int tag;=0A=
>   	int internal_tag;=0A=
>   =0A=
>   	/* the following two fields are internal, NEVER access directly */=0A=
>   	unsigned int __data_len;	/* total data len */=0A=
> -	int tag;=0A=
>   	sector_t __sector;		/* sector cursor */=0A=
>   =0A=
>   	struct bio *bio;=0A=
> =0A=
=0A=
