Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99214C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAFF2087F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DUx1Uuhx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D9zEvCZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFQ0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 12:26:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35618 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEFQ0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 12:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557159973; x=1588695973;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aBN2XyOogjiXBo2x3Cy8FCVcyl4iWZ8kxjHIPn9tPTg=;
  b=DUx1UuhxdUHhaUNq6/ozZWYRCTdiLY25lewptaWFMFNCsBEKrWgr7Vbp
   lkTgkmoXNYTcISBIFhBcSyhBZoqQ5cNxpPXHgcClfO1I93+gGJHtl486v
   G02Ba4me7v1XUVa3+7vR3w90z+Vq0r5eOMIBRhfv1bBdQZEV0ohk9grtL
   AlG2l8kXlnwEgkG92dPwLf3pdy/veM9hI1z49plosPFjREnE8BJUqvxa+
   byWdJDlBX/pr3fj9EaVK/ODIbyBUaNlI+/qSqdioSMGlmuESR2fYMG3PU
   fGNxksQT03g6t5zQH62VTHpVgecepzHTvlJzA6GzKF9w1V/DhoZUpA0jS
   A==;
X-IronPort-AV: E=Sophos;i="5.60,438,1549900800"; 
   d="scan'208";a="108834778"
Received: from mail-co1nam03lp2058.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.58])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 00:26:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOpXC3O6FcsnbyMoeMzdQU9Yr9ezmLVctL/744MYGSw=;
 b=D9zEvCZ68PaOgc6AIYOY9uS5w0c6/OnNAc+dWtj5HyxIaiFLJLRBlOil+jI23axgi8VfRhb1XmD3Lu9KI0JDy6qzcNBDVP2Kv9LxdtEEiBqGevhwJ6WNp13IMFJQqzy7i/evV9Gj2x5P0mgsW9apDXNOJQc2dupkfL1/jLynU8Y=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4062.namprd04.prod.outlook.com (52.135.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 16:26:11 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 16:26:11 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme: 016: fix nvmet pass data with loop
Thread-Topic: [PATCH 2/3] nvme: 016: fix nvmet pass data with loop
Thread-Index: AQHVA1Qn7EhCyAs9uk2B8q3mOzvu7Q==
Date:   Mon, 6 May 2019 16:26:10 +0000
Message-ID: <SN6PR04MB452726B60D050C3A88A7456C86300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-3-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7d05a41-3047-433d-ab6b-08d6d23f8d14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4062;
x-ms-traffictypediagnostic: SN6PR04MB4062:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4062E46144AE4C5B571F8F3686300@SN6PR04MB4062.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(52536014)(54906003)(316002)(53936002)(446003)(476003)(486006)(110136005)(6246003)(5660300002)(7696005)(478600001)(72206003)(14454004)(26005)(102836004)(186003)(33656002)(91956017)(66556008)(66476007)(9686003)(76116006)(64756008)(66446008)(66946007)(76176011)(73956011)(6506007)(53546011)(8936002)(55016002)(25786009)(229853002)(3846002)(4326008)(81156014)(6116002)(305945005)(7736002)(71200400001)(256004)(81166006)(68736007)(8676002)(2906002)(74316002)(6436002)(99286004)(86362001)(71190400001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4062;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iTf5LsIJS3GtsLxyVuxYmy1LBOfROXV7e8akhZsAT3RLGPM0bozs+7CE1Nl19w9Ms2Rqd+xZ4ucwDIP0yrcVFzvE3B4IJfD2tF5dWBD+NWE+jx//4AI/czm1jrw+fzARs0g4uHCguAQqBqF5jfIcm7HEnAWelcvZlDVxslxIC7mOAMG06XwXAr5YutmGxU2JjKaaZX3lD6/s8OZPUZqm406k/Gurn7gh3QKcd3bb0wgAxAekFoCJO/PngkDS0SP0L3t+KovP01tyMv34aoJ50nPMGeUXaQkD0mzTW6nmNymBkRp4bvGCTqh24yqmm8dtzPR+owWxYsGp4LBv/MvjJ9HSCSMlggxGLd08RkPLYj3LnRNactEIDDEybr8oAqMroBvSVOlXJ6ZZ/jLOowq75qdrklKlr3aV4eiB8eYsoos=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d05a41-3047-433d-ab6b-08d6d23f8d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 16:26:11.0087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4062
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to get rid of the string comparison here.=0A=
On 05/05/2019 08:06 AM, Minwoo Im wrote:=0A=
> The following commit has affected the result of genctr and treq field=0A=
> printed:=0A=
>=0A=
> genctr would increment two times per a subsystem due to=0A=
>    Commit b662a078 ("nvmet: enable Discovery Controller AENs")=0A=
>=0A=
> treq field would be printed out to support TP 8005:=0A=
>    nvmet driver:=0A=
>      Commit 9b95d2fb ("nvmet: expose support for fabrics SQ flow control=
=0A=
>                        disable in treq")=0A=
>    nvme-cli:=0A=
>      Commit 2cf370c3 ("fabrics: support fabrics sq flow control disable")=
=0A=
>=0A=
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
> ---=0A=
>   tests/nvme/016.out | 4 ++--=0A=
>   1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/tests/nvme/016.out b/tests/nvme/016.out=0A=
> index 59bd293..8599066 100644=0A=
> --- a/tests/nvme/016.out=0A=
> +++ b/tests/nvme/016.out=0A=
> @@ -1,11 +1,11 @@=0A=
>   Running nvme/016=0A=
>=0A=
> -Discovery Log Number of Records 1, Generation counter 1=0A=
> +Discovery Log Number of Records 1, Generation counter 2=0A=
>   =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D=0A=
>   trtype:  loop=0A=
>   adrfam:  pci=0A=
>   subtype: nvme subsystem=0A=
> -treq:    not specified=0A=
> +treq:    not specified, sq flow control disable supported=0A=
>   portid:  X=0A=
>   trsvcid:=0A=
>   subnqn:  blktests-subsystem-1=0A=
>=0A=
=0A=
