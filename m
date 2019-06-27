Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C16C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4699D20665
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 19:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UAzpKQ6Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XP7t8HWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0Th0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:37:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21131 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0Th0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 15:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561664246; x=1593200246;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TJyucWBKKtaJtkuGy3o6AFVlpwa3EjEOoWL9+pX+iQU=;
  b=UAzpKQ6ZG4Lye2dP3nkhDKRI4qx3llZOu89rw6op6ty0Zk+LWp3vkC2J
   IsdIzabaTao+7eC7Xr//SGrBQhGSRvbaNN79cWeEmGO/ZUh6b5vaC/kgH
   PGfDaCybGYRxUhWLPPZs/23KKFfiXqbc6JQ4UWS36jwwXppPLGkg4UdCO
   QBHVey9MYc6A8wFAXTovHSz5av2wM/D9tvfW7zUZ5CvrDN113ykI1uSMx
   Z30nBT96GyQFicb2hNoqOVZzbyNZZLLganmrpQK75/iGQiaXwv3AywRFS
   7jVF+Qc9YNas2jSIeHv9AV+uKolZ8y6IwOjeXd/HRuRBVrPnWtqx7ZJ3F
   w==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="111720778"
Received: from mail-sn1nam01lp2059.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.59])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:37:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i29kx4jM7Fn1iLbLaDn/DruOpaNDL+lgs4WwAf8CC0s=;
 b=XP7t8HWo2d5lRaotn1aBW4za7cJiwtDiJtLQzFQ1DGQGNUAhlv/eUJ8NwvcakYxh+jO699VKEZ80b65f9DIeEbh+PTw7bH0MnMSL2fR4Aah4HgwDTSx7W0HT17K7dGkSRK+yXeXcmuh0eWnCE7919N0cA7SS81RqFcb9L9t2c0w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4664.namprd04.prod.outlook.com (52.135.240.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Thu, 27 Jun 2019 19:37:23 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 19:37:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/87] block: skd_main.c: Remove call to memset after
 dma_alloc_coherent
Thread-Topic: [PATCH 10/87] block: skd_main.c: Remove call to memset after
 dma_alloc_coherent
Thread-Index: AQHVLQ61YUY2jSmYOkW/rXYnO0F8bg==
Date:   Thu, 27 Jun 2019 19:37:23 +0000
Message-ID: <BYAPR04MB574987E7A45552F8AD8AD6DE86FD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190627173516.2351-1-huangfq.daxian@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4208cd15-4002-480b-3444-08d6fb36e0b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4664;
x-ms-traffictypediagnostic: BYAPR04MB4664:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4664F2756EC47E0982C1AF2186FD0@BYAPR04MB4664.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:65;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(14454004)(66946007)(72206003)(2906002)(8936002)(86362001)(6916009)(71190400001)(71200400001)(54906003)(316002)(446003)(476003)(486006)(229853002)(68736007)(14444005)(81166006)(256004)(81156014)(66066001)(8676002)(102836004)(6506007)(4744005)(53546011)(53936002)(3846002)(66446008)(76116006)(33656002)(5660300002)(73956011)(64756008)(6116002)(55016002)(99286004)(186003)(6436002)(74316002)(25786009)(9686003)(6246003)(305945005)(478600001)(4326008)(7696005)(26005)(66556008)(52536014)(66476007)(7736002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4664;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y3xTzZX/ZZQJfRkKYqh1cNqSKPPO6+nC85pZp7zwte2SFUpjRI6f+CsEXrOlrAy2AsMKD5yycf2HqfMEotOXGwKSo9ks83xEGvFohl8bWUTy7b8CVJnCDVyMLxaqRGeGiLPbJe02eL75HKAxWWyT5ipTEpxduUQOCeFs8fkxD96H7NoPyAxZhx9dg5a3HiCVhwtv/X2ytOEmPXss30j2EikahQakSn6QQ3RGJ79FVFXN9kfVYaF0ME1yNn7cfewQ3EFbdW7CldIBCGIy9xf1SIK7olmCHGRGBrw/+LJVAwildm3RGeNyqYltcrIpLHp35eUdL6DXPPosmRSw1a0cPPe0h9mlUjtnJ9CwK1Bbt5lxkD5X+0Zt/vJujUbUbLDZWZqRoiG2SSSXmm2ifWiYE6c9cH7ZkicKPqu3UY2SBnU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4208cd15-4002-480b-3444-08d6fb36e0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 19:37:23.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 06/27/2019 10:35 AM, Fuqian Huang wrote:=0A=
> In commit af7ddd8a627c=0A=
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-m=
apping"),=0A=
> dma_alloc_coherent has already zeroed the memory.=0A=
> So memset is not needed.=0A=
>=0A=
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>=0A=
> ---=0A=
>   drivers/block/skd_main.c | 1 -=0A=
>   1 file changed, 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index c479235862e5..51569c199a6c 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -2694,7 +2694,6 @@ static int skd_cons_skmsg(struct skd_device *skdev)=
=0A=
>   		     (FIT_QCMD_ALIGN - 1),=0A=
>   		     "not aligned: msg_buf %p mb_dma_address %pad\n",=0A=
>   		     skmsg->msg_buf, &skmsg->mb_dma_address);=0A=
> -		memset(skmsg->msg_buf, 0, SKD_N_FITMSG_BYTES);=0A=
>   	}=0A=
>=0A=
>   err_out:=0A=
>=0A=
=0A=
