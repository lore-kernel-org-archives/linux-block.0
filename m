Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8887DC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 01:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D5223C40
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 01:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgLJB4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:56:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:38987 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgLJB4G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 20:56:06 -0500
IronPort-SDR: ZfuhphYgJruAwIceiOFy1up7VY3IR56fi0y7kNjLr26vVU01GWJoEkWHsJH5+9LAT5vElUQfom
 PwjRAZz1iJNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161231980"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="161231980"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 17:55:24 -0800
IronPort-SDR: qU6I2uzidWOkOjktN5ZXS0RL6oTLNSiQmuGX/a591yt4nVeVW6KBy1Ip8EObhTfs3HmB27Wi2h
 CnPeNLPrBxhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="318641867"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2020 17:55:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Dec 2020 17:55:23 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Dec 2020 17:55:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Dec 2020 17:55:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 9 Dec 2020 17:55:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu1djRKw/+/8G9gte+8PKTgYSkjEsOpNi/DD8rnT0/idEbTYhTjsjBkW8lpqKWXHtEtv0cnegbuoaYkSGTYb50BEeQoa84ZHGDNhjiIod8vaql2FmHQuO2azCNyJXzcsulBdnAoWrmh4WyleYzZeeHT4Ag5qvLrm8+nMHYEJr8upPz16tEMLxa6BTdQ0exwz9i2l6TGVbuAbX67Rajny0H7VB+GN62XYiGKmBZnLffq62MllinBhGiNPwnvhagLjANv1Y02LepTThWM1n18a9VjlUSD7JnKgZLY4Fpdx65Tb1r3Adb0RuBasrSNq2/WoNO9kNOdq+vCgISprE2g6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWKUHnrq8BKjeBIWQAKwqYmAP1EAGEiCt5l6LeY2kBw=;
 b=MlNQwAx8llUwZSHndFUWLPLDVrnb2dT1DOUdNa9/7dciIr4tgqxkGWFX2mEzs1UIqUlmdcd6yka/1WN88xo5GtM1XYuQCoWlNWputlt4Ja3gZsOtiU/fz8vZpFgVs3Rb9qTEA1mAiI/0GgdJZbRIasGa8hrd4ODHZQhPaWAAl8FsMIVXGQtnQzr1rIjXJIVJddrP7q8mBz7oRAnvRTJj1QzDO1UWXol9sv4gsDcStBlyKE/fTRk3Vo9k9iOlAO14IXe1GEQzPy/B3ZZ+aPhgKfq9CbA9G7I9cvouIZQpqY2Lr1MJWQh+Un15teZ1nDWtibwSk7ZOMB16ve5mT7TnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWKUHnrq8BKjeBIWQAKwqYmAP1EAGEiCt5l6LeY2kBw=;
 b=FdXGl/pjAOUHlyg08qxtZ5YifgwViSlMzopG/GHKn7wZLOieSOTreKJCZoWod0AbPhAmXMfwx98R+9ZTV7ZxU6Iml6405WI0u8tD4Z0mCeTx3sTCyxeXMO3lQeO75AwQmyUjyoK8/0FI/N3vH394hrdGlM4PoJk+vOmAZBfQPOY=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BY5PR11MB4103.namprd11.prod.outlook.com (2603:10b6:a03:18c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 10 Dec
 2020 01:55:22 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::10d0:b76c:2ead:8a66]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::10d0:b76c:2ead:8a66%5]) with mapi id 15.20.3654.014; Thu, 10 Dec 2020
 01:55:21 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>
Subject: RE: [PATCH] block: blk-iocost: fix build for ARCH with missing
 local64.h files
Thread-Topic: [PATCH] block: blk-iocost: fix build for ARCH with missing
 local64.h files
Thread-Index: AQHWzmyGaj384SACK0KSzACXBpjhJKnvkgEg
Date:   Thu, 10 Dec 2020 01:55:21 +0000
Message-ID: <BY5PR11MB3893310F750FB2F0AE587AC7CCCB0@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <20201209204657.6676-1-rdunlap@infradead.org>
In-Reply-To: <20201209204657.6676-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [210.186.140.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 066dc0ce-8c20-43ad-5c5b-08d89caea769
x-ms-traffictypediagnostic: BY5PR11MB4103:
x-microsoft-antispam-prvs: <BY5PR11MB410372C83B3DC01CFEDB8302CCCB0@BY5PR11MB4103.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOEiiLIMAuA4QYWbV+gTOcKAVMvaPxgdE4Txh1Pnf7ae5sK+0uUQzGau25Yg76LBOFu1zvHnHwyNxL/tsYx0xT8zEPSRGCjzb6ay6AJ2OYGlAFnuQcF6Obb7ca4aZUcl+PLBxql7NQxr3YCh7TyNd6j+Uom/idmXP7fbwIb4koTq2vjIwmt+B9BqHtFICeGPNC6g0wtzTRGs0Kx9RJ0+G0vIYx3PfAOLZuZGqxdZuNMVv7u9fAfWc1PzED11CNDUKT7qDvY91bbZ4X87jbdm9Aovrp1mbgxGdQsymOhI41ebeZ7X6xzqfOqeU9+6zG9VYbq0ipxHF+sZAVFtRwY5QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(52536014)(9686003)(7696005)(86362001)(6506007)(54906003)(110136005)(2906002)(83380400001)(4326008)(76116006)(66476007)(508600001)(186003)(66446008)(71200400001)(33656002)(66556008)(5660300002)(53546011)(64756008)(26005)(8936002)(66946007)(8676002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9QJ92V2PoMF8DGFYQU86QvWY9KRiXozjCDM+kDP8evpYbSQJEaeInu82x+WK?=
 =?us-ascii?Q?ch9+47+rdbfJWiB5GDt92yY5/8qt4Wbbrl0/iUgO+ZyrngHgZOwkLExrotlU?=
 =?us-ascii?Q?9JG4iu3oHa1FoptG+5PlGJfbmIxtSwizpWTS4/mrWk7B8ey6Otr3lACOrk4+?=
 =?us-ascii?Q?yH0OZVli7O2f7KzOWkDKzxCbQ+fjjwYMd18Lo+3KV2/fdjiFYL10MR1NXrWA?=
 =?us-ascii?Q?QUHdhQywcPu9gsQiF3BrV7ige+ckPMyb3IvhbKVJ4LjBJLWm7jPfg16cIdRP?=
 =?us-ascii?Q?cUSV6h6uYg8DBCMaxrhJnqRXwiIhkShG1Ao0Jd0rzTHgSlK24CWd5XpAitID?=
 =?us-ascii?Q?hvpGs75ugLUb8vpmj6yaHWCjnu88GL45IXAYiRJmLB1wNzDPoECIXVyvREfp?=
 =?us-ascii?Q?bztZ2U7eDnKIjk5CLl3sf2LF2eibQe53mQg/wAD/M3lfzFHQpSxsvFRgBwxw?=
 =?us-ascii?Q?+U/m0Woo9XLKG8tnZDvHj7uRZiMuORoRfrLS+VrPBD7FFlRPIUwCzq9V8WD4?=
 =?us-ascii?Q?BzBEffDk9tx5zTLvIwjqFps45x3gcF4r9FDNRnZxOuMqBoL4T076VOU4c2EH?=
 =?us-ascii?Q?OVPMQRoUJ8VDajqXXjv3T7JIISkNYRRe5qgq0pwIIPtWlvRhUBNoQPOgap8k?=
 =?us-ascii?Q?FDFt2lRo+dXJ54V5sWL2zmKHL5D4OOmik2pXVLAspDJWXSR9HgJVRJjo15aV?=
 =?us-ascii?Q?zUchhD5xvaM4H1uRI+2COCAgx3JWiYgXRn6kCbgfplrK+/vXTaMSxUs3063A?=
 =?us-ascii?Q?NBGqQ8WKHyXXW3Lubv8Q+Pvchs0GUptt0AD9lmTmmn3rx9o12EHvHj6Bv0eN?=
 =?us-ascii?Q?+IoP/hYqV3ViVJg2aP3WZHR+RfZbqiZ2cMMtkuUOhbF3WLhPn72a5lUSMP0z?=
 =?us-ascii?Q?omIJGbgtX2Rg+uMwkH0tOM3uRqvERR/iRVZHlLVwsi1eOpKRTgloI1nSt9jX?=
 =?us-ascii?Q?O8sRxnm+ZR7pxAEt/x5N8Kd91ARSrgUYXkgxggZyoVs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066dc0ce-8c20-43ad-5c5b-08d89caea769
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 01:55:21.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGGNSqK1ZDCZLcqrWPs78GzxYBAq1FzDT0vtWwlJ+Z5+dBagIf1VuP1EXHRPjdb5cdX1cwft+hTII/Iy6klbKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4103
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Thursday, December 10, 2020 4:47 AM
> To: linux-kernel@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>; Tejun Heo <tj@kernel.org>;
> Jens Axboe <axboe@kernel.dk>; linux-block@vger.kernel.org; Tan, Ley Foon
> <ley.foon.tan@intel.com>; Mark Salter <msalter@redhat.com>; Aurelien
> Jacquiot <jacquiot.aurelien@gmail.com>; linux-c6x-dev@linux-c6x.org
> Subject: [PATCH] block: blk-iocost: fix build for ARCH with missing local=
64.h
> files
>=20
> When building block/blk-iocost.c on arch/x6x/ or arch/nios2/, the build f=
ails
> due to missing the <asm/local64.h> file.
>=20
> Fix this by adding local64.h as a "generic-y" file in their respective Kb=
uild files,
> so that they will use a copy of <asm-generic/local64.h> instead (copied t=
o
> arch/*/include/generated/local64.h by the build system).
>=20
> c6x or nios2 build error:
> ../block/blk-iocost.c:183:10: fatal error: asm/local64.h: No such file or
> directory
>   183 | #include <asm/local64.h>
>=20
> Fixes: 5e124f74325d ("blk-iocost: use local[64]_t for percpu stat")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: linux-c6x-dev@linux-c6x.org
> ---
>  arch/c6x/include/asm/Kbuild   |    1 +
>  arch/nios2/include/asm/Kbuild |    1 +
>  2 files changed, 2 insertions(+)
>=20
> --- linux-next-20201208.orig/arch/c6x/include/asm/Kbuild
> +++ linux-next-20201208/arch/c6x/include/asm/Kbuild
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y +=3D extable.h
>  generic-y +=3D kvm_para.h
> +generic-y +=3D local64.h
>  generic-y +=3D mcs_spinlock.h
>  generic-y +=3D user.h
> --- linux-next-20201208.orig/arch/nios2/include/asm/Kbuild
> +++ linux-next-20201208/arch/nios2/include/asm/Kbuild
> @@ -2,6 +2,7 @@
>  generic-y +=3D cmpxchg.h
>  generic-y +=3D extable.h
>  generic-y +=3D kvm_para.h
> +generic-y +=3D local64.h
>  generic-y +=3D mcs_spinlock.h
>  generic-y +=3D spinlock.h
>  generic-y +=3D user.h

For nios2:

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

Regards
Ley Foon
