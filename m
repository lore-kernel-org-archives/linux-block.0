Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96671C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B4B26008
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KeL3t2AU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MhOyhsDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEaCAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:00:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31461 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268039; x=1590804039;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MG45U8qVgAZi3T8q5gpKnTMZTmkctHxVs+SRZJGAipo=;
  b=KeL3t2AUkoj3pjQ0rIdd8cyx/tsE5pWgwgdBx3jxfsFnsVc9d/IMTNF8
   z8sDCmTwAWYT6v/0wQ1ZFgUI/uF4xIz0Hdkw/NxYUVeStcJTuGHLkztso
   fT1e0V+/Bn3sSrBVE5NcNI1EGiP1+7mrvLu5q15E+kGWD9py0Clj/TUxA
   n8eJfVmjaaxI5BZhV20jJtVZWbEi/5X6DqRfnvAj0aVU7rQ3yoYoagzQ3
   Fd8FG6OBNGBlWY3UZOEPhqZQcm30itDolqzwPO+TRNaj9qerXpxfjZHIJ
   HOw5ihXKVvhRm8+yV/N1qG2EUeZ1+IxeJmLPDHvkYXn6x+rJZLbPo0fE5
   A==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="109455877"
Received: from mail-dm3nam05lp2051.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.51])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:00:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9RE8q/wPXTDb3l+uCuR+x2aoqZwhGji8kVhqrJqalo=;
 b=MhOyhsDPIiTSEhx+xWKrdQfm9JR6S53fFwL9dqaJ2DkySYnuFmYpGN5KKDBeYu+6/Lq1tTgCRKJIZoIBhwwjux8cCeUkmEvGfi+3iehkZWQR7fI5JWWchRqqLteiagDyuwtxDOTAqBqBaL4jl2LyQ6cjaO4OeVfLJfPeELQKW3s=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5670.namprd04.prod.outlook.com (20.179.57.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:00:36 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:00:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/8] block: Convert blk_invalidate_devt() header into a
 non-kernel-doc header
Thread-Topic: [PATCH 2/8] block: Convert blk_invalidate_devt() header into a
 non-kernel-doc header
Thread-Index: AQHVF0P1DZt9vd+ZVEqyPD0LyBxomA==
Date:   Fri, 31 May 2019 02:00:35 +0000
Message-ID: <BYAPR04MB5749F9BA0D0D60687D28EC7086190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79666e75-7e9e-43fb-b041-08d6e56bc5bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5670;
x-ms-traffictypediagnostic: BYAPR04MB5670:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5670F26322153F0E3E6B59BF86190@BYAPR04MB5670.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(4326008)(256004)(14454004)(478600001)(305945005)(7736002)(54906003)(110136005)(26005)(8676002)(8936002)(66066001)(486006)(9686003)(33656002)(71190400001)(81156014)(81166006)(71200400001)(186003)(55016002)(72206003)(316002)(25786009)(6436002)(66476007)(66556008)(66946007)(66446008)(64756008)(102836004)(76116006)(73956011)(3846002)(53546011)(6116002)(4744005)(6506007)(5660300002)(53936002)(2906002)(76176011)(86362001)(74316002)(52536014)(68736007)(476003)(99286004)(7696005)(446003)(6246003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5670;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dVBIdOn/diWrqvjhYUSb9/cnQY6Se0xrVvWFvPY07p8/Fwbo5QVZR2+ib8aJjA0W6SKBjp74J7/LFK41lr2xYaoEve+OXPuvT2J4hXuDv3kLnf8mRxXysm2+O+6jH+S04ua3omCHkFpDEMxpYq8esJuuWf2Mm3ZkugrqqpaPKM3GoN/vvSfgJWfu5dAfsL9+TgT4x6QSk/wCnlFeeiVe5YU0qF5puPLXJAOenNyEbMqqCRCkg4FtfqtaW3VVbJYzWZDns6WU2dSkG1YJUgeFwogQ5BTXIlPeU+1CGdr0q6AW3CErNZN/HX1xTQ8zK3jloxQS9rprnZCDRKlkpP8cyZYaIeUxulZG9L4RjPJiiCNQzc0X0pptqSal4Q8/HCDZUdqMUF42adLsh+OOeoJtR6o+Xm2ETFOhSWhAZrcvcXg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79666e75-7e9e-43fb-b041-08d6e56bc5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:00:35.9993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5670
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chiatanya.kulkarni@wdc.com>=0A=
=0A=
On 5/30/19 5:01 PM, Bart Van Assche wrote:=0A=
> This patch avoids that the kernel-doc tool warns about this function=0A=
> header when building with W=3D1.=0A=
> =0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/genhd.c | 4 ++--=0A=
>   1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index ad6826628e79..24654e1d83e6 100644=0A=
> --- a/block/genhd.c=0A=
> +++ b/block/genhd.c=0A=
> @@ -532,8 +532,8 @@ void blk_free_devt(dev_t devt)=0A=
>   	}=0A=
>   }=0A=
>   =0A=
> -/**=0A=
> - *	We invalidate devt by assigning NULL pointer for devt in idr.=0A=
> +/*=0A=
> + * We invalidate devt by assigning NULL pointer for devt in idr.=0A=
>    */=0A=
>   void blk_invalidate_devt(dev_t devt)=0A=
>   {=0A=
> =0A=
=0A=
