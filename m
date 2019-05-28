Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F2C04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE9208CB
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 21:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Oq5iytl2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c60zn3rB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfE1VAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 17:00:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfE1VAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 17:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559077205; x=1590613205;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qqs5S/uCAJ5SLX/ginb6cCSsKBE7yRelez5JwY70LMc=;
  b=Oq5iytl2EMZ1kXLFEPVF40bXwExmjuGwgBiAz4l+Boi97L47MMhD0mqb
   TDRvFQZJeyXHKnOl6kneimJdVTS7OSA1M4JpsiVaXQsur0f9I2dYmTjQK
   XhTzxULKbCn1tVP9SnoPVkDJiwNmxu/oHrgVhrfEIk1MY9OKfOXCYnydL
   59YAda03xI5+1t8oTnHeLYrAEy7jsMM5hgSb0lLCUVy2pAOYl4zFG6NJx
   IvSTWk0MDSg6GXXaORQg7uAgPiLinr+biirFwtlxXFYMYm8NM2Qdx+8Yq
   Kab4jAE0NMKcDCB3AxQ6gt2cg7SQuqYQrHuAlnmDsss6/WnK4rxJSj1Bb
   w==;
X-IronPort-AV: E=Sophos;i="5.60,524,1549900800"; 
   d="scan'208";a="110505122"
Received: from mail-co1nam05lp2055.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.55])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2019 05:00:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bee0Rx3wSpDbmjp/tqNUpRWcYAyuS/1+huGg6thH3o8=;
 b=c60zn3rBR8HaHqlD0+VpJm/K62fdkjOswP2Q05nT4Fi1JxUGEnIWiqfQkXTjespW9hOP0mXPWrc+Xr62UkWgL7Qi+AARVpxUizMPIaBuBcKq1cfiubpGajRnb9tnQV/3oLnMyL7gyfgg52+7R4kpy+CjD06RktzC8kdCPlwy9r4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4119.namprd04.prod.outlook.com (20.176.250.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Tue, 28 May 2019 21:00:03 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 21:00:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Peng Wang <wangpeng15@xiaomi.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Wang <rocking@whu.edu.cn>
Subject: Re: [PATCH] block: use KMEM_CACHE macro
Thread-Topic: [PATCH] block: use KMEM_CACHE macro
Thread-Index: AQHVFIJkAGb2oburn0mgfBrMi38GRA==
Date:   Tue, 28 May 2019 21:00:03 +0000
Message-ID: <BYAPR04MB5749FB02197DC584BC613ECF861E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190527114835.2071-1-wangpeng15@xiaomi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4807c7f2-a52f-478e-5d53-08d6e3af74cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4119;
x-ms-traffictypediagnostic: BYAPR04MB4119:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4119653C9DC7E9D03BB88333861E0@BYAPR04MB4119.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(14454004)(53546011)(52536014)(5660300002)(4326008)(6506007)(53936002)(6436002)(64756008)(486006)(76176011)(7696005)(55016002)(9686003)(73956011)(102836004)(66446008)(66946007)(68736007)(66476007)(66556008)(316002)(72206003)(74316002)(86362001)(476003)(76116006)(2501003)(66066001)(81156014)(3846002)(8676002)(81166006)(25786009)(229853002)(6116002)(305945005)(14444005)(256004)(446003)(8936002)(33656002)(2906002)(6246003)(186003)(26005)(54906003)(478600001)(99286004)(7736002)(71190400001)(71200400001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4119;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G+d2qfwH1tiNfseng0l+7dMc1f1lETd/bnElNJgrZBH7k1Pz2fdYfH9LOlFVYSEhCO48vdWYtNnwIFYZSTyg3nNiihZc8YIuY6EqbsToTp0YITQX4yFeXl2xokuU6joBS9M493h7g3VtpDp04xJJi0GVTElgx83xWxLBFDWbg66tXf7nt9Pt517Rw9i5Sg8xWNbQH9uE/ZskjYZuEW7fZe+AOfETBpkSkJ43jyJyxDCBm0gp3z8B/jvWUGS6VTsaYDcPF2c90/IKt8YYcGwerkMtyBEK7Cg62Y8Aa/YHNvE08xNICWme1oP2pL+u/vDjBrQuz3w0zdHCaG6m1/piIITeqcnTXOnQcDA+nZ49WO7KQvA4nHBFQBNeRXdN7vZqZSCtQs6NjDZNFvfpzr7/U1BdhOnegri770uzPxnZ9Hw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4807c7f2-a52f-478e-5d53-08d6e3af74cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 21:00:03.6636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4119
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for your patch.=0A=
=0A=
It also makes the cache name consistent with the structure name.=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 05/27/2019 04:50 AM, Peng Wang wrote:=0A=
> From: Peng Wang <rocking@whu.edu.cn>=0A=
>=0A=
> Use the preferred KMEM_CACHE helper for brevity.=0A=
>=0A=
> Signed-off-by: Peng Wang <rocking@whu.edu.cn>=0A=
> ---=0A=
>   block/blk-core.c | 3 +--=0A=
>   block/blk-ioc.c  | 3 +--=0A=
>   2 files changed, 2 insertions(+), 4 deletions(-)=0A=
>=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 1bf83a0df0f6..841bf0b12755 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1789,8 +1789,7 @@ int __init blk_dev_init(void)=0A=
>   	if (!kblockd_workqueue)=0A=
>   		panic("Failed to create kblockd\n");=0A=
>=0A=
> -	blk_requestq_cachep =3D kmem_cache_create("request_queue",=0A=
> -			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);=0A=
> +	blk_requestq_cachep =3D KMEM_CACHE(request_queue, SLAB_PANIC);=0A=
>=0A=
>   #ifdef CONFIG_DEBUG_FS=0A=
>   	blk_debugfs_root =3D debugfs_create_dir("block", NULL);=0A=
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c=0A=
> index 5ed59ac6ae58..58c79aeca955 100644=0A=
> --- a/block/blk-ioc.c=0A=
> +++ b/block/blk-ioc.c=0A=
> @@ -408,8 +408,7 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, =
struct request_queue *q,=0A=
>=0A=
>   static int __init blk_ioc_init(void)=0A=
>   {=0A=
> -	iocontext_cachep =3D kmem_cache_create("blkdev_ioc",=0A=
> -			sizeof(struct io_context), 0, SLAB_PANIC, NULL);=0A=
> +	iocontext_cachep =3D KMEM_CACHE(io_context, SLAB_PANIC);=0A=
>   	return 0;=0A=
>   }=0A=
>   subsys_initcall(blk_ioc_init);=0A=
>=0A=
=0A=
