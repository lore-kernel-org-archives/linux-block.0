Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE703C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6449523A7C
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgLJGW0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:22:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11060 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbgLJGWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607581341; x=1639117341;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/1cDH5Lj9mukfdPiGr1zPW/PC9GzMzkZqVJQMauAfZo=;
  b=IpJHne3oFFGG/xG8jmNY9oxpY/mQ5U0SC2Jrj5fXuu2pVGkEOW+nFMls
   XkbaZESnpnzonpZsaYVzaeTYkSUiRnD03bmWdVmzZth7cFfr3leGuI0lR
   Npd/u5tE2K4CRc6+79QFMTxGvfg8cLX4hImyfX+dJU3nK94uxhte4TKeS
   94IN0YM7AWa3cchsLG4EmX48Mwz/hUJmz2l+WHYgmzkgUjy0DNDwkUYpT
   P+UFtY0i7ozIAxURyyXCO8waJxKm7hT3QI33PT49LXd8eN/itdM4UQRBd
   T7sNIOdCGgnTY0XOML96RWVCWblExxQeRZQe+H312HH6oW1Z8wsXzump1
   Q==;
IronPort-SDR: A8plzeTI99yx2NMo8piJ3zFmDrF0pDWRwm9miC/VeBSPgj9SnXUzeEwEfhmgNTiPmBo0zgWcXY
 pz4Nbz2AmMmXpaEJYa8nNOXmaulZKhv9ywtBt+YHYbne/ZibFeD2C0Ok+Bb4xZ2BNXmi5ubDXM
 bFjy79NdYw/aHVfgGcT+Zyb1bB7Cf6Dob7BoQWX/xzQWtz+SyNRI0dpcGZinmn9im34WFr1Ihm
 GgrsNzBVUmdquA49VKwv1oNVr7R1FZ/XJm+tj0Pl/4LpRDXffxSfMqsvVcW8XMwJi249xg11Kg
 5lI=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="154877825"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:21:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnSk/fRrxVmUDCElJVqFcCkh+Uhag4ArEovPZZ8wGsGYbbt6/iHTO9t0whfRztwGQK5qw+cEwkKW/pvE+KJcaRTY6Q06VU5Ljegdl4dBddApKO3s+tYiCvgs2ecKYYFoA8Fhtp6EqW8fXG57QfwS1x55bqQL0qubM4xys4EDeppVmt9QgnZws0WtCaUeuR87NANGdMeN86/a+4jdCHbPpdADE/0/NSCZTQ61VnPPoLYm6i2Z7DP+zXE18Vq15o6ixWfdUSPJ6XA0SMEh9M2bPjPkF5EHIAzlVFytyK0hu54dGaUOj6xHwreVfPvsW7Y0xH29J4w0p37IbjIS8jJRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spp+Zd4SBXJNXpeLFMvlpwLLGYOJTE7KBFvykPW3kOQ=;
 b=SlRncipVDLLqCiy/0II6h4MV625I/ieEkhnLN25FRz/z41gfjdxyh/UFcUwm81D8ZX5/EoyYPzBel+ud671HCLyqvppm9A8npKxI630So5jx2M3CyGgYNxbWSRrUsSwAHnANGApqF/NTa5HrxTFn4ldcFOThg/PyRVSHJecL6KLBsAFaNY1kiG7oqh8w5CcfmtWYKcLEuLatCmRx40cBqBMcQ6CEaxjd5Bec2cFGGTR09Uvu1E6Iuh+EckKhTK1Rfpy298Qled0K/sf4Z1Nr2+FSLWaqC6pmXczfV1PNOcuYrduIiJ+QOt2nvn3kFvAcFjGxNxgqWoikFK6QmDoUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spp+Zd4SBXJNXpeLFMvlpwLLGYOJTE7KBFvykPW3kOQ=;
 b=JiT46u1R1dphqjg1nremr6J9+vMvcUQfCr0/5iEF93NTVR+EMbmqwFFSPOB87iN9RT3DkXkDo5jQLd527onV4hFyT5gV2PWCh5+Ui15SUAYT379Jf2o1w6tp8nvCV18gI4v2DAqtTD+XP8BBzTbJAp03g9OMV/VC8Iw4yqDG2Ek=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7694.namprd04.prod.outlook.com (2603:10b6:a03:32a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 06:21:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Thu, 10 Dec 2020
 06:21:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Xianting Tian <tian.xianting@h3c.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Topic: [PATCH] [v2] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Index: AQHWzrqYK2RyrJ+Y0US02gsJbT8PFw==
Date:   Thu, 10 Dec 2020 06:21:07 +0000
Message-ID: <BYAPR04MB4965FC5A5F69F18A1F0BB06486CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201210055307.1024-1-tian.xianting@h3c.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: h3c.com; dkim=none (message not signed)
 header.d=none;h3c.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 756aa618-c191-4294-9fc9-08d89cd3c7f1
x-ms-traffictypediagnostic: SJ0PR04MB7694:
x-microsoft-antispam-prvs: <SJ0PR04MB76945B520F4A93BB42C2E63286CB0@SJ0PR04MB7694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jduF1bvaDiFNKa+QD0iKbjse8yn202GNS0gcI4/XISSdDCzpuV0FfmHufRTw0TIA3HSnWiRXgl3KcYuVJ1F8fM+r82oj8zteCEDXI6FSNP2MXFX2hbhFbBpyS/EI7T1vxCEdizZq2t6b7R12C6P0eax+0whl4YnEjasfk1APMP63z8NNejSXmeHSWTwPCuOsjw7j0aPviM/aE3KeKTsOGrydPIpno6WffJTTgk7a8u05oLIW6G3koo7dZLnqKT22xVuQrNYyz3XU9XFlH6fZXMA0vqR2ti7boywx+n67kO3IVIXtcY1LuguILfbxhgHU4//Cp2/vwH8twPZEIESL9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(64756008)(66446008)(6506007)(53546011)(54906003)(83380400001)(4326008)(7696005)(26005)(66556008)(76116006)(186003)(66946007)(66476007)(55016002)(71200400001)(86362001)(8936002)(33656002)(9686003)(508600001)(8676002)(110136005)(5660300002)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DfS1FsZbRGJW06MUxc41lYt6o8vnc0GYKRCf6PY91EZfUMKVS0U0ZBQw7Mmi?=
 =?us-ascii?Q?6kup4KujGM7+NS9mayaAWqHMIPp5blgVmuOKVAUXgy/mxK4zcZQqrZZCgEjK?=
 =?us-ascii?Q?s2aOvzPDHmzPUGqXR7mlLc85QFdiKaeCh/617SbaSo+zHnT+ujJgozQ+lLa5?=
 =?us-ascii?Q?WM4QxP+dhaVyRG8Rrlts3z6ZRgfkkDOxKtsPU5lD/ntaVO7SBE+4R8cznfFK?=
 =?us-ascii?Q?0pinpHAUCV05aqzeimDWc971dQahGqmbTHVuMgH1gSGR5+QAjDDgBSX/4BDz?=
 =?us-ascii?Q?q6yUNRYROou1QusBu4/zMw6IyYiRWkCUJ90q/TTJ8Yy0GGeAMlvrJPMTsWEc?=
 =?us-ascii?Q?MRXg699X0zwGIhP1y36QT1x+wA8/KM5G3UgxrmN7D79kC9tDeOel5jRFDUv9?=
 =?us-ascii?Q?k+52eQudgS2A0g/XM77WKggIIiQ64zJGcrS7TAjechomVe/o8Zm04C/h0wmC?=
 =?us-ascii?Q?PMnlZJVRNce7UYMGJ0FoMVucVHlhWP1uiLX+CjxI2/NVr4xaSAA/S8ucahUF?=
 =?us-ascii?Q?ZmVjVcco5VfV3o4W1C85Y7uTVfIPD1A60IhyHMCXzF/w3qmEhjIeH1E/svFC?=
 =?us-ascii?Q?MLhsM0FfKbHlI2qzgE96QXlmVwjzHjDBlPsUY/4ZxXCEo2wyp4wfQUZjEobh?=
 =?us-ascii?Q?AGsbagLAjKJ2forbMshwiyvRgpkwLC/MDxmW46exSIQc5uLjQFN5EQWdaDOI?=
 =?us-ascii?Q?GTDvljHeCicXv0+vllh6uuBKr9vp/UcSoEzhr28mwqCdP/ukKlfJN2tZGrB+?=
 =?us-ascii?Q?WyT9zBmrNKIbHKXBQkGJjNr8fVipupxp7ASBK5a/SWtu78B9HjwRSw049XXp?=
 =?us-ascii?Q?UdV4xCsxGEaTfl9IorM+LMjRetCSokcRSn4ve0EtsRZHHGQZmcwPgdHKTvk8?=
 =?us-ascii?Q?LDHsG18Q5MAc/xZrZsshHLaL7Scmnt5DDDDunSsi2E3e5IIB502xcua0y1Kx?=
 =?us-ascii?Q?wI29wwYV/BIm1OVuMz7GGu0bgIRez23aB79z6/vl+Gj4Myw5M+ht3Ge9L8jZ?=
 =?us-ascii?Q?Iwh2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756aa618-c191-4294-9fc9-08d89cd3c7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 06:21:07.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkNjeUG+DxXEmD1n1MrYT+QTf2dFKpdvO2LNUZP/NPSNkBFC6c8RXI2lIZ8teCFIlHAFDrFjdUFg8JicACjcciceEY/fXNtEx+a+6t4/b14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7694
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/20 22:06, Xianting Tian wrote:=0A=
> As no one cares about the return value of blk_mq_tag_busy() and=0A=
> __blk_mq_tag_busy(), so make them return void.=0A=
>=0A=
> Other change is to simplify blk_mq_tag_idle().=0A=
>=0A=
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>=0A=
> Reviewed-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq-tag.c |  4 ++--=0A=
>  block/blk-mq-tag.h | 16 ++++++----------=0A=
>  2 files changed, 8 insertions(+), 12 deletions(-)=0A=
>=0A=
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c=0A=
> index 9c92053e7..21ff7d156 100644=0A=
> --- a/block/blk-mq-tag.c=0A=
> +++ b/block/blk-mq-tag.c=0A=
> @@ -21,7 +21,7 @@=0A=
>   * to get tag when first time, the other shared-tag users could reserve=
=0A=
>   * budget for it.=0A=
>   */=0A=
> -bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)=0A=
> +void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)=0A=
>  {=0A=
>  	if (blk_mq_is_sbitmap_shared(hctx->flags)) {=0A=
>  		struct request_queue *q =3D hctx->queue;=0A=
> @@ -36,7 +36,7 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)=0A=
>  			atomic_inc(&hctx->tags->active_queues);=0A=
>  	}=0A=
>  =0A=
> -	return true;=0A=
> +	return;=0A=
if above return is the last statement then you need to remove that=0A=
instead of using return with no value.=0A=
=0A=
Also, please add the version history.=0A=
