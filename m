Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7237C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8556D64F6A
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhBCDTe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:19:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30968 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhBCDRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 22:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612322270; x=1643858270;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=n9623xAWJpXus3YoVx7z4Bi6pCRGmCzu4gUeN0GwOvQ=;
  b=bTBzYbx1yK/Nf26xlrHsw+XzG5aFOLXUBAbgAbaUmBZPUOlm5qRDJ13L
   R1v+M3tb7bWodhM6xe8IS5O6pWXfpXG7ZxoUcMIjoHtsguPZKH0ggNVVR
   FtiEkHZ1hW3zoYbSRc3iN7NG9dsEffHstbKXxdx7kL+MSvTjO7rJsCo2f
   kDx8RerR2uzwJjlwGiO1mPaKIcKmq461eXYepDpCCDYphXE5GFssraqtj
   0RZsLtUdjtyl51Vg0dfuCOqXmUu8CZU+3aMung0glRvDpIMMQq8Vj7eSx
   pwg/8cpqHxCs4WQ8kJe0DhpbAnN3mW0kJr5Kp/KOz8imqY6+zM754xKKm
   Q==;
IronPort-SDR: NlujDF7d6rR15xLCtRnhT3wCBef9mot0p48A2m49ndwsIvvohqcN2QhEBRAumACD5mjqlo2PWe
 H6FWZN7KSa6iltBZOA2xcnRJF2vMsmwTHHI9riLAJtakej9RZxAnVh5nlh664pYqKDj4g2vCII
 wIWvDY5inEVwc+/ZudEH0A9kgQ3y+o0eWRfQ4Sz0O1RK4QH8v8Dcsa38GHT+qmtsyUoLlIyE1M
 CBVSIsMqtd3u8OM7Tq/F7597HAGWBlxgMEXTssz+aGXJZ7zt/GtNLfklqM6BqK5CF5bPDUZkHt
 wJ8=
X-IronPort-AV: E=Sophos;i="5.79,397,1602518400"; 
   d="scan'208";a="160166524"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 11:15:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5fhHE8oH5TpiczcszARxJYI709I8lL0LqwDMMHFfx3IC1qebigNM5UgNejzCvDFWvrh9Jx3/Uh+l0bj1sjk9lC1VFdjJDHINvj9agZJvgZoyNsf0uyBlvCzWfHWKYm1cUDMOECAfypWTX7eqSKAHDqE7cKIbM/Na/oQ5nQt5cfuFuNwwDyqqzYCH97ndDMAfkV6uHdStbmMg2FdGt4e1+GHnS/SLjHRoQNuzKawOrmyOCKobZjNC+Z9gA8BcbUfjDGCXjQWgpm/3n3twylZD5F4gvXpMBlHsTnjqgHg6NoWA7k/Ud1oiQu5U3QJsdatBDuU10EAwAirfZ+z+3V07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KtOMVr2LN/7/gKYYzE7i4ok99HdyocQLSSpoPRAiZY=;
 b=f+VcI6DKY0st68YC4TyXG0LeQHsNLd66cxWzb2wbmBgxCctziFgd2sRQVNTVs8Ugx1yF3+P41a6/yVS2Nfz7/L5KZb+zHnLsn+2ZEF9rtGanJGTCHsM99RdObbb577Befqbmy4C+/WUedCXvaiaclV7d+YZpac1g61QU9j4dN1NSTMSLDfhi7UzsaMxDfu9jsTyUat6i7gIbhWRGUsudb04ZERXZrqXQ/yhi6X1lhjR+jnoo/jLvL3R/Rrctp6HDsNMbIvH02xMVa4FJ7cG6E4+DIcQAi6yV5Y0DGoThbs0FLeEpK8KnyK5SE05qewU1Uol2Jpv6VlCrbxWqrsMGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KtOMVr2LN/7/gKYYzE7i4ok99HdyocQLSSpoPRAiZY=;
 b=A4cVo3Hfz8exo21i46mEAhQvu2XS4cEvrL+qhLDnspeY8wWcblCikZtAjO4KwuiFGXZuw/CCjBxkOBuhWwFuOX97oLBZJv2jdAxo4QoVnUclGKO4t/DncNHqBIzW+JwfdO9nw8O3M6uagq3+YqTBYH/AzPpxnlZpEmZnbfvjYS8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 03:15:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 03:15:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, David Jeffery <djeffery@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Thread-Topic: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Thread-Index: AQHW+LqCC5Q5kKmvR0+PLotT7t4iaw==
Date:   Wed, 3 Feb 2021 03:15:57 +0000
Message-ID: <BYAPR04MB4965222989DE60A2F198358286B49@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201164850.391332-1-djeffery@redhat.com>
 <20210202033343.GA165584@T590> <20210202204355.GA31803@redhat>
 <20210203023517.GA948998@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfabddac-dd1e-4ac4-5349-08d8c7f206a9
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB4325D08D214B689575240DC886B49@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnlTvYFPLEwsB2JQkikUOmpsgd9c3WF54Jd0hK47UwedEt4uVPsBbkFAPnCgtcWNUOhw67UCupMjJHqNliR9eJSMuJio/6rIugFnaIVDCbw4mdBO1rquzPqJRLaKyU9PxoMEySKTMacMpPzLpRWkGup+2xE8vuMt3GE9e1I4uD349eqdu4KPGrMXjJmPCLU/NgcF+xfX97liMt8rxyTe+I7c5gSFc4p5YQGKmcMdPGMxrzGMBwaEOgGLZeqv3mQDt44mo4X9BSTUfzj6iTvqd2nQXedSKSMr3XCqXFXUopmByh8wG4X4B1r52Fd0wQ1iMQb1/df/FEzuBUsrJ0oPxS2kqvigXr0Fsqpu47EbmAGDj6Tge+bZfOcxIxAOgtNOTUJFMRZFo6fY8mBC8AM8vYLRRJLi/G9WgDDmh+fZ6GH4VKIiqnzshaiBjjbVru501bg9xR6S2yzeHDFKuPrcrA0LhR0hdFoFO0I7PCPrwxoN36umkUQtPHI9WqGTXSRMTJCARA08RdOPw9gZEBxe1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(26005)(5660300002)(8676002)(4326008)(33656002)(186003)(316002)(54906003)(110136005)(9686003)(55016002)(8936002)(71200400001)(52536014)(86362001)(53546011)(2906002)(66476007)(64756008)(66556008)(66446008)(7696005)(6506007)(76116006)(478600001)(66946007)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/bpBppqXxykkgN7QUP1FjQKEP8mdl+wSi4ZNldAuOow5ywkuG+G/9uXrzxW3?=
 =?us-ascii?Q?S0E8j2/JQggCDTb5jrNacMpcd6rG1t6fCxNiJ6I1xaZiliihzAuHYv5cdlSa?=
 =?us-ascii?Q?TqnLF2JOb8hJr/aRNWCKB3RmS1c4FIZid7KEOBwgqWy5/NihCCjo+vCGe4fj?=
 =?us-ascii?Q?I2Dtg+OVgc/T9WEZyPZULb88r+ZLX1YHD5HEviOIvoHvxAuefD15lCmiyIwA?=
 =?us-ascii?Q?0kBvAseejqFr2uqJLEfESLeTPcIa5x1V3arT7ElS5jUUui6mluk6IkfReFbd?=
 =?us-ascii?Q?Dx4AMGSmjco1wGa6FnN5/jjTUspFn+LdVpeQw34y19m/aMiiaTWNHQq+l6v2?=
 =?us-ascii?Q?u5MpVkUAq1laDwDBouhWYHxYmJ8+/JOcLqZe2W3lRag3vNG/wUj0+jc4CdGt?=
 =?us-ascii?Q?WQpw4doNR1MorRRATwUtZBVHzfKV/cu14jTCzeDSaSPjH8bCtY/obFZNsKdF?=
 =?us-ascii?Q?FT+nDyVWAadTJ60Sl0RyJBe9PGa5F5c+vQd4La5d36khjZ0UuLFBJtYVmL6G?=
 =?us-ascii?Q?jOM15cVROuBEoF0zVrkluWnQLjkRRr0uzWvhOkOSNqAsF1Y+F+nknDdhVyG4?=
 =?us-ascii?Q?ilRxPFztiihw2FY9at+Z3d5XgJUBi9aCPvryII0bU+Vsuy1qgrnhq4WCi5g8?=
 =?us-ascii?Q?klgSdoXfiQckD97NQZMpV6BnddI9gUMTnk9gxn/Mqn+ILtYGRHORyUF/apxG?=
 =?us-ascii?Q?3Pg9A4VDV8L4svJYl5d7xb40TtrbppeIUG2FPeONx4RkkxkZk5gc8Ot1uXmP?=
 =?us-ascii?Q?FBRFmZAQFrLQ5UmkhwZ6jJRl2SLNFwRWpDGCYy7sj6Rgp2HUuhmppW9fFv3J?=
 =?us-ascii?Q?hZf/nd4Ir7KI4FeKuYYTGdYgusVLC5OGgWlKqN2rAaI9HlZqd4TAORS2T4ch?=
 =?us-ascii?Q?XWHz3vxEp47d0IdlTpcgTWk/Dit8T1rX49DLfShOK7cAVHzlTrbATrkBIKoq?=
 =?us-ascii?Q?ujGesyqZGAYNX9BW9zTWAMYfvPb1n6tfbAppc9gGS8UqtxbW4EXGM9KYOhaM?=
 =?us-ascii?Q?JfLHahEMpZ0kPRwaPjiFmAPKwOjX2DeNPneiuEOKJoL63b2del26iDmT7eK4?=
 =?us-ascii?Q?wPh2neRtI3jtgKeDdtZryG4QzYtyfQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfabddac-dd1e-4ac4-5349-08d8c7f206a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 03:15:58.0138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZOf85fN0oKfbIcQhQL47bhzVv8tYOUIjoRKd0d4cwfmbjcTDnMrZBRWMMRVWNxTrkxyBP0WdfFBpyv+R3HhIEN/uJ8bm7C269/L+dr/cSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 18:39, Ming Lei wrote:=0A=
> +		/* fall through */=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
> -		return 0;=0A=
I don't think returning 1 for write-zeroes is right,=0A=
did you test this patch with write-zeores enabled controller with=0A=
the right fs that triggers this behavior ?=0A=
