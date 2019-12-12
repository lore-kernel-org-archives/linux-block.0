Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FEEC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595CC214D8
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oFIjfL3x";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MZ7fTKjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLLBUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:20:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13933 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfLLBUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 20:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576113646; x=1607649646;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3YER+UQJ2W2GdR1x37h5nwF1u54dORoywlN5x2cmFfs=;
  b=oFIjfL3xWnp2XCVvfcBVmyASp2Wd8Q1UbkBkn1c7pSVuvY4ObGqfZ8lQ
   Ckg2eow0CObB8HfYRqf4xfo5CMLVBLd1c/9q6Bye0fsUeiq/Rv7AKElar
   zqmjagimn41KGRAxXsw1CnRS3KkQh+Gf76wOIBFM/QAcoFRUklkJyc7x6
   F9BZW0sc3WUeFmFZh8H02uoyESdTNN+cFZ/WTJ2F7hFc7aCmGBR/lvJuC
   6ZJX/TWHykSXCJVXIrNaOTepo4qYKtPpec44z+ZsnwWxdA64MMsLvuI0e
   OX0EeU9ICkre7n06FtjW9z1ucdcHaWvWqIXWDbiRUXPmVzS2u+mRqpDcN
   g==;
IronPort-SDR: tRJJhTpjvoNC+TE67T9sIeAatatnWIWlsFJgJQ2LY5vuj+jb38cxPu8SqXfSc1eKgCl4JOR6OP
 53voD/ySB4Ck7wKp4lOd73b2qZdDDJhFA6WHZBeSh0PALvdHSgu8AaqfWJmvf+4yYYc4bwkUtS
 tzJjJ920ZngNMbVhZoJ7gSyfAnBOe8/XElCBUjMJgjZ8fj2dbPG6D0PtT5eIxDnVWurVGYcnzM
 NyVIO0VttkRbb5yMaLPnuiV+v+etXbJdTg38cSYLIEMW1iDTTVDfJap9nqEuLohYXk4WdH0Ae8
 pjE=
X-IronPort-AV: E=Sophos;i="5.69,303,1571673600"; 
   d="scan'208";a="125141412"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2019 09:20:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO4lKd4VuaU3DZSzJ4KIyg0k2QLojBOZezUHt0+TRBKgkFWQrQcHJ/FNG2FSDWMi6+fdLYvxok+glIXbIi/gjZ6U262EPqW2+1uzD4apjPmXJbVAGgKl4BvyayeWm97dm+aGK7oj7V55R1wUBmJeQO6O8RZDbX3oMaZlgHLwJEeP5Sg/09MyN+pL97/TsHs7C4IpZsoMB3nuVjDtl2N8iYAITt5KCZYm1o09HQSTbWi65rPREH4Y+NC/fkH9ds1tq1le+F2zVtQnEtyur6VLdazPKBByDjfhVrUk0Y/3QuGwAfYFTw8AJy2haqhuYgBqtPR22hRNNgp9OuYerI6E+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0bxADDAaGt9YHOw1odtCaQ0reoKNM+fA99dhaSiNqo=;
 b=IgxUXzcLQhJedkxHEGmlOGhNg4BI9VzuBMPX8iJjC26jLHsuvTuEUSjySITDnNU2ldrTjZZqHTx17e5HBIpb6ZfJvfPzUbA/bpcNpD0DYnNGBejOSl/VZ5IW0/quF/7iEfC8QsFpNzggrI7gWaiA96gYcW4+t6C+CzDb/KVqsgybdT6Gg3mQlm3bbj/9Y9EjxXa8tJN8EpDOGLHutvZBVT62amRMvQUN8/tEzJ50VJ46cBf54O3Q6rYbUvD45i5GvQB7L86clDqV0D3gR+wO4W/AeUHijtDevIFOgCFgth6B0Hn8kIiyIA1DAiTnEM6946jwhAYkz3d4qtl19pCaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0bxADDAaGt9YHOw1odtCaQ0reoKNM+fA99dhaSiNqo=;
 b=MZ7fTKjSoQ7c3DCj++UNL/MzOcxzbllGcDpN7ubbU+z63cC6oobxuq8FDLD6kxQb8L5+eZ/nj/KA4N37wX2ddL5TP80LWnBYYVVJin86eR2eW5ib2QZF4xUZn8iMy3ThgNRaRAv/PAGhzvzJAL2bKs23AhVxxGavXq2xaIp68xY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4968.namprd04.prod.outlook.com (52.135.235.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Thu, 12 Dec 2019 01:20:44 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2516.019; Thu, 12 Dec 2019
 01:20:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Keith Busch <kbusch@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 05/24] compat_ioctl: block: handle add zone open, close
 and finish ioctl
Thread-Topic: [PATCH 05/24] compat_ioctl: block: handle add zone open, close
 and finish ioctl
Thread-Index: AQHVsGPd6d4kt4E0pU22jxHVQDXQ5g==
Date:   Thu, 12 Dec 2019 01:20:43 +0000
Message-ID: <BYAPR04MB5816D0BAE4CFEECD3F099700E7550@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-6-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc465ad4-06cf-47e7-77bd-08d77ea1828d
x-ms-traffictypediagnostic: BYAPR04MB4968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49680BB6B74D1B57D435427BE7550@BYAPR04MB4968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(66946007)(4744005)(66556008)(64756008)(7696005)(478600001)(76116006)(66476007)(66446008)(86362001)(316002)(2906002)(54906003)(33656002)(7416002)(6636002)(110136005)(4326008)(53546011)(8936002)(81166006)(6506007)(26005)(81156014)(8676002)(71200400001)(55016002)(186003)(9686003)(52536014)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4968;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5sUIIAoYc6MSHiGS5Zf6HsxXAyxhNPX1Y1zZWLqfB6pGNfm92k8ERNre4NT7yKxpBZP/HGRAfUyrIp0DzaGCpOrAxpY31XpOqpTG7RJYOQo/RQriSslYrRO98t/sGySOzKp+FIMBhtQgfnbZNrkEjQuWqy8fqSAaMds03PonqVLp/yHbV5Vrkjt7UeG66F/oKYvDKj7f7aGbz3Hky4TyJeqjHR04VIB6Hn7PO9FuCocME1GDYGQ49QFZaJAzHzvg19HgvFUWYmV+DH7+mTL8p1yAWzBgSVMQq7zt+KcQpPQqqii/MJEwKkRpQ/qmDYgEzVFpLe+XRlgBCeEtB8aJRLf/s/7cVb+pJKFYRcyRE0uDm9a2vvDS5S7e7xNTJfyn46cIf2o9FDfgZtv3YFuOTALJVim9SYBFbAd7RlbUV4Vmkx95nSQ7/jocyXpI8pR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc465ad4-06cf-47e7-77bd-08d77ea1828d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 01:20:43.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQu9f2g8AaIopweQ1w5lymY8eDwFTVRO0TIOMoOWWKaIM8hhrJLIhCNbM8T+YQa77dnhvOVMV8NPSH9AU819Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4968
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/12/12 5:45, Arnd Bergmann wrote:=0A=
> These were added to blkdev_ioctl() in linux-5.5 but not=0A=
> blkdev_compat_ioctl, so add them now.=0A=
> =0A=
> Fixes: e876df1fe0ad ("block: add zone open, close and finish ioctl suppor=
t")=0A=
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>=0A=
> ---=0A=
>  block/compat_ioctl.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c=0A=
> index f5c1140b8624..5b13e344229c 100644=0A=
> --- a/block/compat_ioctl.c=0A=
> +++ b/block/compat_ioctl.c=0A=
> @@ -356,6 +356,9 @@ long compat_blkdev_ioctl(struct file *file, unsigned =
cmd, unsigned long arg)=0A=
>  	case BLKRRPART:=0A=
>  	case BLKREPORTZONE:=0A=
>  	case BLKRESETZONE:=0A=
> +	case BLKOPENZONE:=0A=
> +	case BLKCLOSEZONE:=0A=
> +	case BLKFINISHZONE:=0A=
>  	case BLKGETZONESZ:=0A=
>  	case BLKGETNRZONES:=0A=
>  		return blkdev_ioctl(bdev, mode, cmd,=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
