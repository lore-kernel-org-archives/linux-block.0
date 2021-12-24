Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB39C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 04:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245672AbhLXE2c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 23:28:32 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64707 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbhLXE2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 23:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640320111; x=1671856111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dGny4mZL50deApf7dDkvClShLncl+EY447DMUCRS0+M=;
  b=R/sForEpltsY2OmWXok0hy6s0b3TMvTW4vcL2MYKgQYSVhyxbOVgWVCa
   Ls0Tda+Fcq3LtPOqRkq1htvFpgl/B+DgBTUiTOZiBC1WKuleiB24N8/O7
   2TPcsioRO0vQ2TQn7BeMWtcv8DOBi84w38xTZdTxDizVe9Z3hRZpj/TQY
   kFRnjkGUiHtHW6KxGK/MSr79mNMyBwEGtkbzUZcbnUiNhi3FENzhHrJk3
   vshZu6CEpnrB25Dqtx3hQjAyOj20ArA5TjJecTRIFAM8XQlgkrw8zODLu
   stHwtP9N1rP7L2xojrysEJCKUz4Lh7bYkfNZnFZ+6yqwiZWhakWKMSZ5M
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="293023647"
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2021 12:28:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebhr8qZn5vFBbH4ZUmu3Y28BQUOXZ7IA1mlc6UJpHKdYD4nQb4MlLEPOOb2tZd95nztOWaTcJG6u3ANUNBUsuWSgZBHyh7RQ4Nmz+C/K5hcDWtpQXvZCfqD9oCRaHK0q72gzq6SIhTAmvx5U55BMG/qBFJtmSBGowaRh901tqp2BRkDTywAfNs0oELXW2C4SyTNq0IzIExV/d0DU/jWZa3xl5kFRRFQcvIqzam3Yu6UdjoMh6m4RpSySd5nm3nSj13aQ8xiqhwb/vgp4H6ad4m0ds3raKpHNmwIboLzEIXlSlatoLuAruGhPqXjbj+FHwwySAP+Sb36rLDGfJm6gAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGny4mZL50deApf7dDkvClShLncl+EY447DMUCRS0+M=;
 b=duMI9eG5AlNMOVrbHSxtY6+afQINGZVH6wkOVlDZSXy5enzNZrDZJD1fiIJKt9SkYdH7Mie8hsVN5rw3jICpv8aPvc/msj6IjAHrUlitlXaNTgrbk2uCRb9C7lg/kc8ZLmSDwG0FWimy8IWZyAcKhUd+y7MEGEpCSV74tBdZUmVrf7llwvRhBlHp3U2HmqqYusnp/7pWMwfve3/kS91SkAnBrVRNypdvQKIDYV9vYvOKhN2zIZP5+E+9GlU4JeLnMVzbc3yLIs7MoCFTPkhcPFYR2sSv7McQLXWM6kaIygn45N/aAlBKof2UpgVoO8VBxoSmWSudEbr/RGKHszZc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGny4mZL50deApf7dDkvClShLncl+EY447DMUCRS0+M=;
 b=b8ROk0kr5/eKDzO3KFVMYqcOhheysxlqAdyFihYv+npi5RYYextPOLT5AR3kyP9CbvdkU4IqFxDSEw0JJVy4lG8abi0s9CPs0cwR1rLhhuld1W/5KdLRUvQUXT1hCNRWas2jFxtmhXPRpATBI9+vdmvi0dyyA7vZFI5G/KQTQLo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7944.namprd04.prod.outlook.com (2603:10b6:8:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 24 Dec 2021 04:28:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc%5]) with mapi id 15.20.4801.020; Fri, 24 Dec 2021
 04:28:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: null_blk: only set set->nr_maps as 3 if active
 poll_queues is > 0
Thread-Topic: [PATCH] block: null_blk: only set set->nr_maps as 3 if active
 poll_queues is > 0
Thread-Index: AQHX+GLRCbcVfxvnwUaV2/o/tSZ3N6xBDKGA
Date:   Fri, 24 Dec 2021 04:28:29 +0000
Message-ID: <20211224042829.xwt3hifsne5asv3d@shindev>
References: <20211224010831.1521805-1-ming.lei@redhat.com>
In-Reply-To: <20211224010831.1521805-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d93de67-0502-46ff-4604-08d9c695d63a
x-ms-traffictypediagnostic: DM8PR04MB7944:EE_
x-microsoft-antispam-prvs: <DM8PR04MB794414495D7B1EDA456C3615ED7F9@DM8PR04MB7944.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peX9BKAN3Kj8XdBGxPISFHzZ8a2C+bJO/b8eE+4fhFeaKdy15OdXxaWR38yQSE8in+7pRJY3zbNWwNm512Ro8JJqSgtjL2edS3271qFVYVIuBScTo/3O08VGrB003XPJmc5yqa1cmchhruIX8xt/diNN0NRnIOT2+l0sW/CSdZRI5CfckOGTug3WbuFg/QMgkHXLe3iu/kyfDV6eswXJ1slKC8X+Aw+KjO+45YzeT5/412xBqScfyiXfWueQSz27Jg3lZQccyB8mzNlCIXsEhgVmNAcNXbF2I4OTHjZUzM46ZAmcRJMXl6KirVBkB60+HJjGmN2RlJvhIvL/dPH6bKJ4B0dQUF4m8ItFuVbrQ6+r5yWUKWuS48mPedg2eKTFhoidsV2DanGRXS2wHmjFV+kJiRQpteSDhChy0vnllhyX2StlDRDKotlqjPUuVhVeza7DM+3L2v3ZpFNj+rDrqvuJgNg5B2/BZq1lnqppp+fAR6AKTG8jdsrtfSbNZr3PF4/c9w1W80PSCBid0DLfUWPKMi1JkXt6I7FKzSLm6xjoy4oGMwTLyTGJO27mnql7VXKDP/sWhe+6jvDXd8UZRwzg4xIRmi5mwcW28QtcAOttFDmY59YNKZpWZSvmGejOVCL6j4eaRlD4SGRqEf+R2jEv/ofU8bxBnUOsvS1BePiQTCo8hpqzBS+jbLmJw3brsMqIzt9mjfglV111lZcHUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(83380400001)(33716001)(5660300002)(8936002)(6916009)(26005)(122000001)(186003)(4744005)(44832011)(1076003)(54906003)(38100700002)(66946007)(2906002)(6506007)(316002)(508600001)(38070700005)(82960400001)(66446008)(64756008)(86362001)(4326008)(66556008)(6512007)(6486002)(91956017)(8676002)(76116006)(71200400001)(9686003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+GXHRso9Fw1Ru8nAB1WBww18R5gCbYqL9tPf30luuxk2hEmrsCcHL1nFjFmV?=
 =?us-ascii?Q?KG4EY5Ztgl00GFmlx2ih1k2tiYgjcUmJJEyM0PKK+9PMSVjsHER7pQ7LGu8j?=
 =?us-ascii?Q?NsjBjFGcrJbYW0AIOHxymYx+FZIGKw3W8VacWlSOEI90JM4jIyI0kz2q2zsU?=
 =?us-ascii?Q?5m+YlG59ekjQEeo5dq/8TWMG7oBJEeRAc1pBZk2Lf+n6zEZq57aldUok4dRF?=
 =?us-ascii?Q?Qjk0XvDFvKuoylaboG5DDO2JDNdNc9d5hhr/8RqVafvuamy4Dd3j4uMM92k+?=
 =?us-ascii?Q?dtGsrJ+c9t03+zhHUdCnEib/TflF1O6wABwNtisaGX954gArvisSv/c5nKqo?=
 =?us-ascii?Q?sh5uyvYZBmrqzN3x2rqGkzTUwPaHM9I0Lvtwr9xyavhBecrZ6zek5nkkqgGe?=
 =?us-ascii?Q?fgneoTrGuQEzWEwZxKej9TIvVkMwRwlSQDAs+B0RpKqtBJ2yAiJwSepNR4p6?=
 =?us-ascii?Q?/SAqTVtcvcOeFprovSh6iF9BnvBorukzKnYJ/RbqoDm1n7aBir5uSy+uyl7V?=
 =?us-ascii?Q?i/q64WUiYcx3XGZ1rWAyJaTtU/M1HZEWZ0NDd3xDysQvEG8RMsRuJ+6jkFkK?=
 =?us-ascii?Q?WCOYrFDDf8UqgvDfVNBEIgvASbZUOyAp6Z4c+fyx65c7GzwcTNlk5iccccCq?=
 =?us-ascii?Q?9c5/ArhI5a5yKV3k7/W5PK+GdKNHhXtRq4Z6OdP3TvTZM0743CXfhpRnqs5d?=
 =?us-ascii?Q?jZJAFjx8T+FELiBUGajZ6sEA5eSnb9awKkdauUa5oopp8imIi8uvdGl4j7Gg?=
 =?us-ascii?Q?VVNQBhnH+UkAFKqT/ViJX9JM4ODlj8GfDYeNsaBNe67Ch4aeNUSIML66qvMy?=
 =?us-ascii?Q?yw2qGBsHR2Mz1pn1nl0K4nVI47LvJ1wImPfPnnjJp8pSYMHJAf0ZVAM3w34y?=
 =?us-ascii?Q?uLuQhGAbWG6OjxrjNKN3WUVUodeOZjhYAAtFpjavMYlrGA+9Ie18/kdIxvlT?=
 =?us-ascii?Q?5i0VtUWeo70kfhW1zkoy7rudeHsKbs+HTKlGYf8CZ5Vbk5EH9gej93Pd+BjS?=
 =?us-ascii?Q?ZyOd+rj9OV2X7hJ54/4bxqNlKtpmi5D9as78Z1iEIutpGySW/Hdpoo+APWIL?=
 =?us-ascii?Q?czhM4i9yRH6hWFhecgK3uTqPlEEowPkez6yWgyMEOZAC5a3YUlc6fQ+ybSW9?=
 =?us-ascii?Q?AhNd9yl8YCc7ISXV+sn3hKVT8ae7yjEGbZRLOFxt6HjlkdpyLVKT3Ke12Bnv?=
 =?us-ascii?Q?Orwmh2Wn0xdi88VZMm76XFS1VGBMlX+G7UaH31d/vNwngGVz4UK35pJjrS0e?=
 =?us-ascii?Q?MWGnueHNEAzSPLrckQ5baTfe9uEnorzt8KIENWDjqDn+QIMQEgOK5304G1Sm?=
 =?us-ascii?Q?OBmJE71GV8F5Lqamp6LTBSJkSS5d+LUIiDJntW5sDLgPGy2zWODlWUrVOurQ?=
 =?us-ascii?Q?q8QphelnZ0zcTwOhzpqXM0YmEwUa9uaBpA4OqGLGmKKuX+nXs58PrVI06Rl4?=
 =?us-ascii?Q?nkdC77arc6h3S1xUgDyVgIuIgesygI0kOnR+VmJZGouaWdevnWIr3VBFknBP?=
 =?us-ascii?Q?voECWa0sSHfsDW4NJCknT9HRhJLyrD7eI572cZJGjd/pC3ZPy0vT0S9gIyF+?=
 =?us-ascii?Q?AtrQ9tDSezIoj1I8g1PdjMdNuUgJb4IX4q6VFYecpqMNTasruJG1uR68HSHn?=
 =?us-ascii?Q?xSQ3E2s1yCwAasxCatec6UkiQdY8LJy7NcUIsCuG3vtdrSLmCpuSaDQOQawu?=
 =?us-ascii?Q?bz5dlS+Dgrh2nxb5MMl+oH+XYlI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C916F3E1DCEDD45BABF1FF24127C8EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d93de67-0502-46ff-4604-08d9c695d63a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 04:28:29.5893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+hjRjQkpQnSyIuwCkpltt6lwBg3NrKwAD9h6KJyGul1Q/0Fa5QKMKmrSx1oiXtUYJ020mR2f0Xr+nCV/+Mzylty2/FZJexeyCualAQsu+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7944
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 24, 2021 / 09:08, Ming Lei wrote:
> It isn't correct to set set->nr_maps as 3 if g_poll_queues is > 0 since
> we can change it via configfs for null_blk device created there, so only
> set it as 3 if active poll_queues is > 0.
>=20
> Fixes divide zero exception reported by Shinichiro.
>=20
> Fixes: 2bfdbe8b7ebd ("null_blk: allow zero poll queues")
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks for the fix. It looks good to me. Also, I confirmed the divide zero
exception is avoided with this patch.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
