Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E1EC48BE8
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECE6611EE
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhFPNo5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:44:57 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50346 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhFPNo4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623850970; x=1655386970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=slGU+C6BgQ79hfY1A7bYjzS/bPQiLwANcpuGgnIajMU=;
  b=GYOu/Xs9izAQLkqR52Ukca8OVisqzB4uMWS0T89Bo7z/SxRBnudXRbFH
   i9UGcoOqlRcaAeMjKJNS5QXWr68oT1/05/urLLB3arQ+P6eDJ+eolbwr7
   WjNddS9GWjnhMySLMrou2+Vv5f2ZxLPYthXvLrZZnVN7G4IUj2IgaXcgm
   +d8jyXNcu5LwGC7P39N2ZYFA8chLMWzhqYRYGDrXc1cYkaR42O5srZWat
   jKdzpxoIZK/USyAKbZuJ2y1MVFzwDEpBOZ4XqaGiPgIKV7xjwR+LyKsaU
   9e+Tk2xtIl7Vx4Og00YEchvIlnN16m9HcJQgGetqSFHSKomJX/GH8oGPm
   Q==;
IronPort-SDR: bQbRRKv4mVQucX46Lw6rk71W/S95/nK39tmX32jXLrknhDTyQe1nwe1JX5HPCKMUx0D6/bA471
 fXrplec/jqu0NVOv5liFeMRVRO49ZdiphyflbDEP/RaVJUCSSwmZLvQdBpDd9h7apaQTrd0exj
 lxMGntHKGARIOyuB0Mh6zJVbRR7WpSK1FKrmOEePDdUGstfIVIm9ba1w5EzbBYwVwqA+1Cjvvb
 whf3hhh5gEGoa65WvGQV1MtF3LdjVdBiV6ysji9vajpRgkRR/CdsDAK2l2tmcoXegj0hb0H4C+
 2ig=
X-IronPort-AV: E=Sophos;i="5.83,278,1616428800"; 
   d="scan'208";a="172662505"
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 21:42:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nncCBeoh9oQY8mOKLSAjzXrfPpKtLI5XuCjJR9tag2FZUgCo7e07yMeT2HDM1onRqgl4uRTw9m/VPwNVR0q+pfp4QeFJiisNLSbT+JJKyQ9H+96HPrH2HBu7Ix6MjQdOzIH3aCGY/AFJY5Q/rKrbwK0afYlhybOF4j1Uq3JsXYsk/lgyjwxpK1bAPtj15I6KyaLUKlbD0V7LFS9GF8fMzuciZHb3bRAhAYuF42u3T4NeCx833A1559owjTb/513UprGxj8jOd/YJ1FGF+0ZJzo1QMw41DJwiu6/aTFnnr4jQqcEhfGE5cJ/gfcCNMLom9xLAAHHyX9NzQSoIIvjjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IluvvDDcs/Ahv5yLehVaLEJ2drh5EBj8+I4B/U7oVH4=;
 b=KuUNr7eNFJ2ku7axpuiiL4e826PSCdXbUVB5DdS2cW8m0W1PQ8enwU041Uu+XVdPw6vSmw4/97LvdhnXzDSpI30Zfsa7V3G8XRX1azVnTw6rC3WzWh4TwPapdRFA+qLBYsEMzqL1XL76r4wpDoYmk5mzhcTrGy3E9uM4WW8KuO5g582Gz5gxU8XErioePrhJrhhTfYi4fA8IpdPPmAJqsxOVH/KfYoy4xgmmEKC4uf/s5ALhsCAM4pbrGW5qUSnOjgh76oWD+E7MJ0Wzwm2Aeqqv/xEy0icIhdE6plQ8YSf0aF5eiQkvWBkV2AoqCwrzcvNvo3fOT+nrLXLPuhNC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IluvvDDcs/Ahv5yLehVaLEJ2drh5EBj8+I4B/U7oVH4=;
 b=taig2Ppp4nX1snJ74hmjNKtVf1aKMpe3cF5fw4tmn/cLkR+OK6wTcB5bsHv5y60ZMs+JONs7V7gmjHKDzHhkvNPQGjeQzPrZn0bux/lVcBA2aTxfONSVpzhHF8m2BbXFaou8d8B8JNgo7c7ibtJfjBs817HomW66SwkJZ6JcIeY=
Received: from BYAPR04MB4056.namprd04.prod.outlook.com (2603:10b6:a02:b4::22)
 by BYAPR04MB6133.namprd04.prod.outlook.com (2603:10b6:a03:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Wed, 16 Jun
 2021 13:42:47 +0000
Received: from BYAPR04MB4056.namprd04.prod.outlook.com
 ([fe80::fc71:bcb6:e18d:6973]) by BYAPR04MB4056.namprd04.prod.outlook.com
 ([fe80::fc71:bcb6:e18d:6973%5]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 13:42:47 +0000
From:   Aravind Ramesh <Aravind.Ramesh@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shaun Tancheff <shaun@tancheff.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] blk-zoned: allow zone management send operations
 without CAP_SYS_ADMIN
Thread-Topic: [PATCH v3 1/2] blk-zoned: allow zone management send operations
 without CAP_SYS_ADMIN
Thread-Index: AQHXYRgmF8KejSRZnk+qFcY64aClOqsWpS8g
Date:   Wed, 16 Jun 2021 13:42:47 +0000
Message-ID: <BYAPR04MB4056CD5501CAB658B2B274358C0F9@BYAPR04MB4056.namprd04.prod.outlook.com>
References: <20210614122303.154378-1-Niklas.Cassel@wdc.com>
 <20210614122303.154378-2-Niklas.Cassel@wdc.com>
In-Reply-To: <20210614122303.154378-2-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [87.116.37.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30d8c825-6cf9-435c-0ad4-08d930cca069
x-ms-traffictypediagnostic: BYAPR04MB6133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB61337DCAC9A24596EF0826FF8C0F9@BYAPR04MB6133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3rnFw1+WA2XgGlhlTp061tvUOeFQLB5ZdcQa5SApFcd8KyIn/Y9WnKagVawYC+TEXTFVpqbSQ+4BXpWUW6V+UThVpJE91OC/VaM/a0liOn4MOBw8tQUmMI28DdDMxd3m1fZORja4bNc4TR5Jcahscxdb1iXvxODY+NPp8uZt9U3YPDLM12IhsR+ce26CSvfw5GIybX0ySFBWCkucqCqO1Rjri5uGbGOCtXSZkDZFkwdquoNKfFzkMpoCV/WymDfNycrNCj1IwkcNVgv0JNxuwDDDWDNsWAvq9OWdSNbRErVHg5dGEllquXU3sQNHAqOy1SgA+e0NSw9WaQEXiZ9dXSZFIfyiEQ/xlCzmnPrNJ0lKgJ7Ocb5Yhwygv5nAzj43xFZdv+f4sfTyMx2+/N+V5GFRw749MDIatDBRS9ggNNGEio7Zofbrz1Zz7pfn0BGzwJ84lGu1slJZ1uSMeYIsyxQ2aiSPks7xzPArebEK4B/5PXrojp/E3g4uwaw9N/BKc4C7zNwvXPgAtRXwNYZBGDS/rjNZ8iHUpdF+XajLaqOgb6eZu8hV7feGrBAkML0nX9EXzM+elDwRdsR52wwN9/qev68NjzFHz3/+Rlyro+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4056.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(316002)(76116006)(71200400001)(110136005)(54906003)(5660300002)(52536014)(26005)(186003)(8936002)(8676002)(66946007)(6506007)(53546011)(66476007)(66556008)(66446008)(64756008)(38100700002)(2906002)(86362001)(478600001)(83380400001)(33656002)(122000001)(55016002)(7696005)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yTnuYAarFnvtiysiJve1O1+Pdewp0Ij2eG02nH155fU71gkb42tBU9WI+z0y?=
 =?us-ascii?Q?XhqlEtORQnlSwMB71/bXPt2T+Gpv59KpAGLR2Ft7/N5rLcsMHo4HBQNYHuRP?=
 =?us-ascii?Q?bpIdGIWvIXG3pBmJxQXDKpG3x7eVOjU+a0HA2THCU7RjP5yiXTPuTh9eGkDi?=
 =?us-ascii?Q?JPqsUp933Gt4F0INDtQadSOPppHBWYxBS7e+50loL79FD8kgr+l0YY0Hm4jD?=
 =?us-ascii?Q?PwFET5JLSpMfAtnjD/I1MELwE0RRk9Hk5AG8ABN9BN+GV1eaLdai8TJ7ArKz?=
 =?us-ascii?Q?DHpoUxIuoNrXtsZAkcTjM7Mu/zGyqNE57EAlyJ64Y8LgAJBzRWsHALtgJ/vF?=
 =?us-ascii?Q?NFr9M1Hwxw+eVwX1kuC7xPN6wiCm48TqeA3oepQQmJKqHH7jdAdDMESlz0sD?=
 =?us-ascii?Q?dFjaEPb3Yv0VsxzjFnpRTsEyyVjomI0HoFxE9nfD6HynG7+dCuvzf7p1CSbC?=
 =?us-ascii?Q?u7IcdoJrfgCECaX3GMoaY9v/LdGmq/WN+z1c774/ujlwWBxqdqaLoYtZHlIM?=
 =?us-ascii?Q?jtQymbBVhHPgLGW27p0G0rm8nU3sQhaT0KUYDCzvBH+3OFieIAi0KOVPXuWL?=
 =?us-ascii?Q?fwa1yJxbFaxFBeCcqICdQFtTNMVMcr8HaaZlNfP96nRpqlCGlVB8NqWDCJb6?=
 =?us-ascii?Q?dxEUcGK7I1p5Bz78Tff7JEM/UbhZs+RuHnQGCxwNLOpqShQk/hlJWhfFe9l5?=
 =?us-ascii?Q?VSUuh4XmJwxzlOxa8t2PbFCRbS8h54q6U75I9VsOYMuIytuU/z7XgVqCKxs4?=
 =?us-ascii?Q?zUZek+5pYYD74aOrG4g+psPddFVe3Rj2hJA1dN4gZRhY+rKylftbZTD2LQfw?=
 =?us-ascii?Q?QAtOMMMM/+e+mLt5jqE5hV8sROxxTeC/B6CNaNeS2MxRclFspY9q2tqJ50D6?=
 =?us-ascii?Q?D9ZNX67uF7qj93f2sZO2CSm7yHYVbughjevrt8SpYL5NXY6BHJ7TrscFoiLR?=
 =?us-ascii?Q?gwzkTzrvNutSPAB2NOzTuH/FXDH917/jzhrkhUgFvbGyclfpusxD0JHObnY7?=
 =?us-ascii?Q?gFs+PV2z8PMtBpm1lUwOg3AG2tNW6+MChTxOTcoK67RwsThUoFQupd05WfO1?=
 =?us-ascii?Q?uv+p3XYk5cNpKOkf0CLbtL+7tfZORh+VVkSKJA5avy9xrizXpJ71VhKPeIZw?=
 =?us-ascii?Q?8DD4Hd3kZgYqfR2TD3zLkDsDCHrfEa4buF/k5quSd1U+nDus7HOz6IJXWXNM?=
 =?us-ascii?Q?2BjVya5wvXeZQN+f+OYgVv9XG6foqfh/Qi/veX9TH2rKoWQwUqgLEtY878gI?=
 =?us-ascii?Q?SoirTrFPnEgnPLtAgdi+LG3QC9tPUP7SH0Tli7+Tlfh8g/7R3zIKZBtrQbx7?=
 =?us-ascii?Q?Fw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4056.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d8c825-6cf9-435c-0ad4-08d930cca069
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 13:42:47.1176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vA4ndkPUMciYh7WVlDnsiGHk2hwgS5ZcP2rBTRNbH2MrDpS11UOe0+hMb4fpEyQVx8LCf+HqMBZV79o9x6CdCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6133
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> -----Original Message-----
> From: Niklas Cassel <Niklas.Cassel@wdc.com>
> Sent: Monday, June 14, 2021 5:53 PM
> To: Jens Axboe <axboe@kernel.dk>; Damien Le Moal <Damien.LeMoal@wdc.com>;
> Shaun Tancheff <shaun@tancheff.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; Hannes Reinecke <hare@suse.com>
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> <Niklas.Cassel@wdc.com>; stable@vger.kernel.org; Jens Axboe <axboe@fb.com=
>;
> linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v3 1/2] blk-zoned: allow zone management send operations
> without CAP_SYS_ADMIN
>=20
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Zone management send operations (BLKRESETZONE, BLKOPENZONE,
> BLKCLOSEZONE and BLKFINISHZONE) should be allowed under the same permissi=
ons
> as write().
> (write() does not require CAP_SYS_ADMIN).
>=20
> Additionally, other ioctls like BLKSECDISCARD and BLKZEROOUT only check i=
f the fd
> was successfully opened with FMODE_WRITE.
> (They do not require CAP_SYS_ADMIN).
>=20
> Currently, zone management send operations require both CAP_SYS_ADMIN and
> that the fd was successfully opened with FMODE_WRITE.
>=20
> Remove the CAP_SYS_ADMIN requirement, so that zone management send
> operations match the access control requirement of write(), BLKSECDISCARD=
 and
> BLKZEROOUT.
>=20
> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: stable@vger.kernel.org # v4.10+
> ---
> Changes since v2:
> -None
>=20
> Note to backporter:
> Function was added as blkdev_reset_zones_ioctl() in v4.10.
> Function was renamed to blkdev_zone_mgmt_ioctl() in v5.5.
> The patch is valid both before and after the function rename.
>=20
>  block/blk-zoned.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c index
> 250cb76ee615..0789e6e9f7db 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -349,9 +349,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
> fmode_t mode,
>  	if (!blk_queue_is_zoned(q))
>  		return -ENOTTY;
>=20
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -
>  	if (!(mode & FMODE_WRITE))
>  		return -EBADF;
>=20
> --
> 2.31.1

Looks good,

Reviewed-by: Aravind Ramesh <aravind.ramesh@wdc.com>
