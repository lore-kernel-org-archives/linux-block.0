Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E9C10F13
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D10F213F2
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HRqK55qd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dy8JDT0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDICIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:08:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20265 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDICIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 22:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554775715; x=1586311715;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1rdfxsbObk3hNGDwpwMJxB1pJNKvSEB1idnAiHb92/E=;
  b=HRqK55qdHzWk1hRp0BZLi7MVs9ImNkDL35fm8NQAld8ojY+GfF1EiuwP
   flkOs3l79CYUFdbYyv38HC8JO9ewZ8uPEcFoTILA/mAjYjJdFh7dgHWkv
   IhIFigprNBHX2Zhh9a8xstgR4H5U7gbIRc1xylcqPFZnKr16fk/IHbMkD
   54wSNI8rUf67Zb+gP6FTrR7QMFcDhZWzQhouWYkyEuLypA/1EC9PjAXKG
   kRfIIzerpzpqHDpe8yY5YAAiCLcHUtbBOYnrWl8IFAoSCO4S28oHibcqK
   20fE0DlEjzYotDQXFRcH4dD6Bf8li+3a2sr5UWtsij5bLyhIDL3YckVEA
   w==;
X-IronPort-AV: E=Sophos;i="5.60,327,1549900800"; 
   d="scan'208";a="110346699"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2019 10:08:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8uXr2+YiHvuJe+Mz56E8uDeJvEusasCaIm09TyXccI=;
 b=dy8JDT0ZfYk7cQZ3n1NxwIheAj9zcMoNZLIvPnXfMxtrRErNe9MzM7T7KFwReFpYEQdaek6V/VnsMHx8ACvdCcBeVswp3BrDGxQ8OUFORTYdhetkazzTGwrm8TqQRp4acZiIM0bLM7GPcbI6BFgqFmK/kbZxemFUTXuwBEl0N98=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4143.namprd04.prod.outlook.com (52.135.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 02:08:32 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1771.019; Tue, 9 Apr 2019
 02:08:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block: null: Add documentation for "zone_nr_conv" param
Thread-Topic: [PATCH] block: null: Add documentation for "zone_nr_conv" param
Thread-Index: AQHU7Rq0HKHfKyruAEKGF3cQauDN7w==
Date:   Tue, 9 Apr 2019 02:08:32 +0000
Message-ID: <SN6PR04MB452731F423F89EF90698E287862D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190407081938.20318-1-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5211abf6-556d-41de-7ed7-08d6bc904430
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4143;
x-ms-traffictypediagnostic: SN6PR04MB4143:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4143770D7A0CC99E67D648E7862D0@SN6PR04MB4143.namprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(6436002)(99286004)(72206003)(97736004)(68736007)(53936002)(6246003)(9686003)(8936002)(55016002)(478600001)(105586002)(71190400001)(71200400001)(76176011)(26005)(106356001)(7696005)(186003)(6506007)(53546011)(102836004)(256004)(229853002)(446003)(2501003)(486006)(86362001)(476003)(4744005)(6116002)(3846002)(5660300002)(33656002)(66066001)(14454004)(316002)(25786009)(81156014)(4326008)(52536014)(2906002)(74316002)(8676002)(81166006)(110136005)(54906003)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4143;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9gHEDM2VX531fzGoS2JskfIzyROfnpDQnsdWJ7rFsxj6+iUbreIVyi8+WLlAEPP6YIQCDGfBkntpFMeIPS3TqhuXYLWtY9f+LbkcPVq3uH2gEMi4/o61+a74gVRP+y005DhsSqkyD3JHbnnA8P1jobrmQcSoCjXNBdScOA2LNwH82WFDqc5o5DOWjbw8OJT7dVvmKHyCZJshiJsFupzrkecG2wZni1+ZsyW5vA/RRw/hCXN2F5CHOTCBbOQqwKuW92t2+hNOuyXPGjS5n0/PRt3BsRRgf9t3hq7tz5FeB18Q+TTZWo6lQgMPTMJU3w83uUVP/c+j+IXhZjIHyMJCbI/Du/GEjVAQrNYPJCvJVbvCtO0wC4KSGQsmUm0MS8vvdF5P5y8mCs6H/G5l7DTXsphd3pyLiBULZHdfIitZvtI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5211abf6-556d-41de-7ed7-08d6bc904430
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:08:32.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4143
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 4/7/19 1:20 AM, Minwoo Im wrote:=0A=
> zone_nr_conv module parameter was introduced by a commit=0A=
> ea2c18e1("null_blk: Add conventional zone configuration for zoned=0A=
> support").=0A=
> =0A=
> This patch describes "zone_nr_conv" module parameter to the document.=0A=
> =0A=
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
> ---=0A=
>   Documentation/block/null_blk.txt | 4 ++++=0A=
>   1 file changed, 4 insertions(+)=0A=
> =0A=
> diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_=
blk.txt=0A=
> index 4cad1024fff7..41f0a3d33bbd 100644=0A=
> --- a/Documentation/block/null_blk.txt=0A=
> +++ b/Documentation/block/null_blk.txt=0A=
> @@ -93,3 +93,7 @@ zoned=3D[0/1]: Default: 0=0A=
>   =0A=
>   zone_size=3D[MB]: Default: 256=0A=
>     Per zone size when exposed as a zoned block device. Must be a power o=
f two.=0A=
> +=0A=
> +zone_nr_conv=3D[nr_conv]: Default: 0=0A=
> +  The number of conventional zones to create when block device is zoned.=
  If=0A=
> +  zone_nr_conv >=3D nr_zones, it will be reduced to nr_zones - 1.=0A=
> =0A=
=0A=
=0A=
