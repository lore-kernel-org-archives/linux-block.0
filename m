Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079DEC64E8A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95179206D8
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 12:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R3iFAuuy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SNE3t5gV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgK3MDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 07:03:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3424 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgK3MDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 07:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606737819; x=1638273819;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NW/6r5/xuPeLPMOhF3pWqJQSGa4/ReNe5SFhiD/HNkQ=;
  b=R3iFAuuy9L2IiBzlbu2ebj1PGTp2tklAlniYmLzu8olBTBLezyyLBC/u
   GmxfV2mGm4E5qXuvvcRDVaF3hGyrPRQFJkmxqrlCabahJz99NQwgw6d6S
   Y4w/dTWD9Q7z6qswx48dXFUjQ0kRZhZrkLheQttmcsD3oXOwoCYqL58u0
   rs7NBNMUzQdptGBW/2e1EEP7g4f6ZJN2KE+EeFbQgaXc5RCOHA378oCrz
   8vZaIZeWK0why9hG/eqN3GbJkclBiJY8yU25XaPRe2jFEZovBCdf2uXnj
   JVfhzuW+cIEsqCjqG2afwDBXSMER97neiGXairXd2NgFcZgTffRAXx0Vn
   Q==;
IronPort-SDR: 1NmZc3HuqAgNrgZGFynpUOOXMI3TZgK7/GMnCyc2pT5uPstFzWpTzF185NlY9e6wiM0bp62V59
 W7dsL+fYhq3xc7IbBqgtRIS0YED3KvXXXEkNrfzG4qcJQggkNrAzgub9fd2M5h85zPXtcaSSBl
 pTfAHGmYqLkE8n5nkO855Ju/oHNKiA7c8yRehvC45PGAzmTFZugZ5nEHYVkSbpg6vsayMm9RW3
 JcqJzixFCl1lx6uDYg5CCO9gNp7KGCPVr2oVu6hhGwsartiWGWK59nHr0feJECr5Kss+JLP9xi
 x8Y=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="153743830"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 20:02:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyyOfGbuvDHv/avZ4BA2OZOyrdQTU7lNad5qr6NDh18hssFBJMIf/vYXgluV8EJzgJh4j3j6gExvf7KlAj3Aqfmff3pBcwKBqW4hdo9qGXg5jfV40U69wUVqTpHBNLZFTertoFX4fvX7+FQO6999rcJ/pp5V21CtG6grsI8GQhMP+072K8OOk35CuYX7l4qhGpNbIc7CXDbBrX2dXk60zP0IFoJ/zCEE3ugA4QVoCtkP1c7pU0T3d784vvU+zKbnKRHyhQiP8vsAEnlBbIEKOKs9E4a0Okl03Tqh2zt2RLQWqR8Yrk93GigBFANBRdSlHeWv5DwlBIIjlfG0uyxLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbLfnzac3N3c6ZXOViEHOrp4rXO+GPstbzBWx4l+tmU=;
 b=T2yAZSLoN7oH52OsHU8QrgMILRhqm2yRSLhKygQPqplcC7cJRv9MF4+dHr2SOQIklPg83P6DuDS7eF4C7nsCBiNWeZmiiGQY+DQ/+wBwh4P3Az4TAFXjCYKwRd6e4IcteX8o2NMI747F0RggdlL2tvZCvzs2y7C37edea+9M1TLTIlCKgjfPV9KoI1JYLaDrGUB6l6N4dBo+BcFrcS+AAKJtwxlKhjt6oRQsGbwCjyu2jop+rdh/8L1lvWrNXidS/VsBkwoCSgy2O4vcYp2s+dIkw/ns4Jn3BjGAMdAnkW38Tr/1tjbqVJskSs57ytNJiAKNGqhKP5veuCleABxqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbLfnzac3N3c6ZXOViEHOrp4rXO+GPstbzBWx4l+tmU=;
 b=SNE3t5gVBUygmYp0Una3IoTVpMlcGcmCVcOv+p7i3mFlic6wN7iu0eZ74FWex61lHKJ/45RFNVGdtZBAk77OJ7SCEUppB7sPPgan3a1cmNf8WMFO4duiohV94EXRu0qMHv/oXeI5QDM0EJZCZ86iRipprhO6H8CD/+x/CEg8yFE=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7047.namprd04.prod.outlook.com (2603:10b6:610:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 12:02:30 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 12:02:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V2 8/9] nvmet: add zns bdev config support
Thread-Topic: [PATCH V2 8/9] nvmet: add zns bdev config support
Thread-Index: AQHWxskh5M0+8HD+MEyNz7TqTCu8RQ==
Date:   Mon, 30 Nov 2020 12:02:30 +0000
Message-ID: <CH2PR04MB652254AAA057F2604DFCEEC3E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-9-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 026b11df-ea36-4b5f-ac34-08d89527d09d
x-ms-traffictypediagnostic: CH2PR04MB7047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB7047453A7A72619B7F0FBC82E7F50@CH2PR04MB7047.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mA/nX3sLs+2tkra7krGxeUCieG2nvVcmaly1CXx2z7ecucDWE2PNuIrQyxS2a6jtPcrIHof2dq597C4+V1+ynQk2iG44Euaa13L7FU6freaSDbzJyLOTPh3U+tn0nL5m7bmltvQK0eefnLE0IsoRhWlZZCpOM+5FSkdDXOgMcG2nz70nNajJhBoloKUNww5CFqynUUTukHfuLmiaD+CMSFVrGFEswe+HXdePw2+NyABMuQYkc0vDZS4gM7ylvjm8IN4CBQXSH8TSs+G0HUVHV2Ob9vpWJlVfZ2r0f0QSYj+Ui7xmJNmsQioTuqUZH7cZlQw3e2er4dx+F4mi6i4mKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(33656002)(52536014)(4326008)(186003)(478600001)(76116006)(91956017)(53546011)(83380400001)(55016002)(8676002)(5660300002)(71200400001)(86362001)(64756008)(110136005)(8936002)(66556008)(66476007)(316002)(66946007)(54906003)(66446008)(6506007)(2906002)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rfdK30CWe6KP62QbEHT1+cXiq4eLtq/OwKoae9Rwbi1FsZdl0XSjHR71OrEo?=
 =?us-ascii?Q?0OANq13XqLpjgcOWyZ7DnmfCWWIUvy+cQp4fdpBbDGGXF0dNezl1Oj6Iy4lQ?=
 =?us-ascii?Q?cg23IITPz8BUXiwvPlO8n6Km5MojUimW93M/IRVud+874ZKSZuD7Hir3JZPA?=
 =?us-ascii?Q?ZgHNtn+aSWbT7Sg6XELbgWT0JfzjM8ebJwOQGo9vabqt4lhb/nThJptP6+YR?=
 =?us-ascii?Q?JFN9auAYtVj5ibANOipH4HD3XFgIjntZBxd0sgPOP3RJnSX+gkI+r8eiOQBp?=
 =?us-ascii?Q?v/LZvdN/GPJWqIlt9lOjbkY5CACzKutdERI8UyfGaGgbQyuvJBq4MN/zD7fL?=
 =?us-ascii?Q?SMT0OBHqnajb38CppAroxdOWMIdHWjqSh6W+Ev3KhcgRHr6g8JshDmpiwsS7?=
 =?us-ascii?Q?Uv6/4R4YHntPSv+9JJnEDzOKpWIzjNvae0XCJNjguvIVzu5zJdu1QkUD5Cga?=
 =?us-ascii?Q?xuq5FWbWHr7rcy5I8ydLuJiG0K1MzNk2hGzzIPMS5zMjzw9POHpmqEAtBB7z?=
 =?us-ascii?Q?/8UuWdAnYuEk3jM/xn3yEvX5FEo63N+CeHlSa6vj03IW4Do0bP71aiugbjwc?=
 =?us-ascii?Q?QyOJibr0PmV2RzBax2tQsmgQNjV+Z4Uujk2tg0gThMT918iyJq6kv3FVAptg?=
 =?us-ascii?Q?EnoX+khICB0e88cVSOdmOQuNO/Z37B56S9T6gtJTg2DZsgVYCovhWASCSaRz?=
 =?us-ascii?Q?FoerjfklnDzDXIPvr1Dan9XdE2j2gFbhiBWCVnJUPs5qmogDT+3T82/hEEID?=
 =?us-ascii?Q?5UT3yJMvFSkXWrwR+Vy/OfX63/5TpkiA4Meuw2TIa6P+WBgJ4RXllFV7hDeP?=
 =?us-ascii?Q?0go1ESxjwcCeB85XMqaX5jarxZYEo7HeummsUKFX+4WyGRZwyBCvUpHSPdHV?=
 =?us-ascii?Q?3V2ZZsA+PuEsjEpJt4HJeFdBQjkL3OPfmgxKCG4+24EImc1L+AT3LuZJfaf2?=
 =?us-ascii?Q?SUS7piGKONcACcvmuhSsYT2cAx17C+UvDuvjRUMwo2JIVw4BM3yIyeJkllle?=
 =?us-ascii?Q?E9q0bd3Q8UVxmvOn06zjmaiB/V2kouoQf9pOnCPLZCy/7R7Ai1YmFuJPiiBH?=
 =?us-ascii?Q?QAn6IWws?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b11df-ea36-4b5f-ac34-08d89527d09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 12:02:30.7888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWYdt0rxltWYQOJ06atRnOOylUhwTpYC0vFOSyJNQgeF0D1AyNt/Q3Q3zz5Q+qQah11Ow8QH/wOaOpyaVVgsfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7047
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/30 12:30, Chaitanya Kulkarni wrote:=0A=
> For zbd based bdev backend we need to override the ns->blksize_shift=0A=
> with the physical block size instead of using the logical block size=0A=
> so that SMR drives will not result in an error.=0A=
> =0A=
> Update the nvmet_bdev_ns_enable() to reflect that.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/io-cmd-bdev.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c=0A=
> index 125dde3f410e..e1f6d59dd341 100644=0A=
> --- a/drivers/nvme/target/io-cmd-bdev.c=0A=
> +++ b/drivers/nvme/target/io-cmd-bdev.c=0A=
> @@ -86,6 +86,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)=0A=
>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))=0A=
>  		nvmet_bdev_ns_enable_integrity(ns);=0A=
>  =0A=
> +	if (bdev_is_zoned(ns->bdev) && !nvmet_bdev_zns_enable(ns))=0A=
> +		return -EINVAL;=0A=
> +=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
I think this should be merged with patch 9. I do not see the point in havin=
g=0A=
this as a separate patch.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
