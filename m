Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC48CC433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB85D610FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhIGQ37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:29:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16411 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhIGQ36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 12:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631032132; x=1662568132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PSqUSa80HbVl3ZSuv2dLzFZM90qRLyBoxrB6FIkQYgw=;
  b=dK/r3mbY9Fw9H/xPdBuBwNpfb6t5QvOE6uTVfbgz866NjQHp2OKf4G6M
   3C3uOpvZ+xE/Pm99sETWf4JF8CaVktS5vkynhmhfS5VJcwysKdekF40BV
   gLxhtq3DjR0510h1s9t5C/9sf9sLWd2pn0v7SDZHDhE4ZBp6jL+qOpvnB
   58vt5eLbp7wdr5Z3kO1kTsnxCquGTX2j0esn8ywg9WYlF1WySkH1+6ww8
   ePpXuZGLZOFDrjIVCVjx8OrUcaTIjvVwKW/TgcHvcJ6ZfN69MNA+54udJ
   l0lTYajVaS8M0sPivk+2tf1Axc3VAv//bAR6Z4Y9UoA16lCa0R/rBdqyu
   w==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="179919608"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 00:28:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw0pGJC/qrVOLgSb6suk4+rzGgThg2wSnEKlQ5nrM9zUtwwluh1nIkvaKd7+fz8mYUEF4j6te6DmvPC3EmEGvxynSpVvuPbkz7aP+LDNlczdFkGZ7XBY5Sor6dTExLAMoZz1uDSoTlUiDqJy1fblHLmaDcv3i9h5FY0bIbZ/C5K7eXFv4MC+RkHpApx4djJ+YV1xS8q+fxZpkGubS2Z0USVOCSgRPC5ghRQHSFB73/+ZU1p52zp7h5MM+KIyrClEEnO0bHU9VmunNnHOg9GvsqKvod+z8cLVbQS7tOGVMk+cC696e4anoyiLt0wJ4l/iO7kqOX1OJYfzmDWoV6FBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PSqUSa80HbVl3ZSuv2dLzFZM90qRLyBoxrB6FIkQYgw=;
 b=kJKO568fljlJwamsftdwhhFkn2aVIEqL/QrMsaijULsSjE//hSEPM22nAAHfp5xhtShwzfAOFabPc6EvpSREpSrpm81uu6mmv4qARb/IAxXff8ppe2ZkkS5couINPt2QfwtyZMB6vf9WLnMYftIjbcCz1k8dMcZArch7ZCRqVmmGXKwMYVBureBq1zjUN8+uedEcGGS36DVKUtgTOYkoq3+VuoZSprrAdtH+HQFSAdwEv7L3OhGW7G80jjbhvopt1sIWeZDOEkQ86Jy3x/bgJbdUyi3PrGz5+NX7/c8MVK8mPXdRiT61eOd5CqWdAGiYeOCsoAdMBILYtv1EssRL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSqUSa80HbVl3ZSuv2dLzFZM90qRLyBoxrB6FIkQYgw=;
 b=JN9YHJDUL6Yaz6IxMQsU8U/j47CJodrE3ZjAlU8Dzp7oJMeTHNNXYIURv1V3a/xFCyjQj6DTc7UohOlruda6o21UAZzB4pg5SrjfYC9Eh0lTfdwujYi7JtwJrwhY7eaqUnq3+d+q9fuNjzDfVghOlKbLRlv24znU4HiuoHWB9HE=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 16:28:49 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:28:49 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Topic: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Index: AQHXo/O2L+LBuS/YJECb1WaT3ju4YKuYrlyAgAAUmwA=
Date:   Tue, 7 Sep 2021 16:28:49 +0000
Message-ID: <YTeTQGrw41k08hgf@x1-carbon>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-3-Niklas.Cassel@wdc.com>
 <fdd5ab2a-af90-69bd-2d37-c5060ce68de4@acm.org>
In-Reply-To: <fdd5ab2a-af90-69bd-2d37-c5060ce68de4@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04b03ff2-1279-43b0-72e8-08d9721c92c9
x-ms-traffictypediagnostic: PH0PR04MB7382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73821F324F2B51E406CB0C7BF2D39@PH0PR04MB7382.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iH0WbcNtEIGIvhxiMRPEu/CnenBqseBE3xIy5/WqBYzW11Mw2yZNCRwDZHvg/uWbvOMedTKAC9i+i9x9oe65h4N2y4gOThn7WpSEdt6jtGhyV8UUb0KopOQchcXvzUSvCI+9kF/gYCA85xzsPhqt3nwoeV+hUqucuQRvIq2i22AjOGkbuinxbwtp4OA61yqt2F8f3CKFzLwOn7lqD2BMuIcUEyqA1jPtZ7eAGpERbvhDxCSnJzp7PE+17v1mB55hyH9NBOiCDJBJyf/rjSlZV66E2V/oqTW9kaK23RYX/eClsbm3Qc2ohWLZHtYghEOI2trEoKODzxK6ZEoj1CWeIWtaBP1j4WQxlFJwnIyHtQaW0xxBcvhfg7aIQ3B/lJqArzAt32h5KRUMPjvSJBkOKz1h9HOB0qobWNMoOvtx/XqVOvqHEhVDXKhA4cqyZMU02Yzo6I2Izk63vibUf5jb7VxmK2PZl6M4G+Ql0rPWKV2SAenHA4Wf3+PuKy4JaQVaabb6DeHqWQQIvu/SxEtFWwbHlGNA5XGSevg9hjrUjEeXiagZEXgfqnrlTgKAOkRGKcBGEYUb6bqDAiWAJe4W3l+0ETM2s+VppynwPxUTm1NK2DwmcaAj7bxfYUHUOw2RkNuqysnbnTrpW5tFeXITsf/N/kiQe/7nSVlAxbEhAEty+mPbIbTSyYZF8QBdAun804Zynj10sQx7ywAjwXm8jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(136003)(396003)(39860400002)(366004)(6916009)(2906002)(54906003)(5660300002)(8936002)(186003)(478600001)(66476007)(64756008)(26005)(38070700005)(38100700002)(71200400001)(9686003)(6512007)(122000001)(66446008)(86362001)(66556008)(76116006)(83380400001)(6486002)(8676002)(53546011)(4326008)(6506007)(91956017)(33716001)(316002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WML/CqWsYBlbM5MkbUHNN921O/s3ZCFJj0b+GiSQ91HlhT/qCf0F97QiiM4h?=
 =?us-ascii?Q?UyxnG6yJeDUv+xMaxUBZL0TRQl881wWUQ5wnO7HD3GYwuyAf+pP4vejnPeoO?=
 =?us-ascii?Q?RwapyLLRhBxVceZ4xCqwmwC2pmt/7O8a33T5RytnXp0RSuX9IVj/TNytdW/Y?=
 =?us-ascii?Q?EPRC4rNT9F1Uj0lFRdt4R5tmdZHjo2fWAyky8SUHzmOEWpn8dAFkvEUpMhLg?=
 =?us-ascii?Q?QD9/N2GnLVH7C7KD5vfT3H3tY8DQsmZ5/HxRN/v7PE/Yqv27WWVFIgSisTps?=
 =?us-ascii?Q?UA8zsGwdyX6960dNfIMF4tObw5yXFt2sHWQRMYBiR1yfWFwNmZ1TBA3Cpt6V?=
 =?us-ascii?Q?sFoFgvnKXrfXnVWNxclwa/QcuD2IpqeSxJcO+JZ3KU9pK72J6IJpUIh82t4x?=
 =?us-ascii?Q?dTv3JUU84HrcjLUmVDHuocY3eAUzD1HhcNuwWznXq273VbIAljUAv4vpGm+T?=
 =?us-ascii?Q?163LLWzJnA26AVuf4LUbZTXrcTyEg13BBRb+P5vRp/3QBiV13NszLnSakud1?=
 =?us-ascii?Q?TydZ7gLtu5A9vBds3B/NVBY5FWPilBrFdhWl6g4a1LiVZerzf7RmlrUciJgp?=
 =?us-ascii?Q?AOFmRJO32BGYvDNXnafvgl9I7DxajsWMDSY/yHf1ovFu+IyMdeMRLSvKgHZ4?=
 =?us-ascii?Q?q/GPbT1qAuWzVfLulw0dJ70wL3DFywEF3tZ6PPFXzKFlhP6rLnUdDHzpuROf?=
 =?us-ascii?Q?saq0YgQJNkPdMpJn9JVb4fTDdsAtQHRIyjDHBUvnuxtRDkrPKolgUERwdI3p?=
 =?us-ascii?Q?z/0G3zZu6ABMVS/OPvUHb2B0lI4z6x3E2adDWmGhWYJaHtjiKqOhcY8fokCp?=
 =?us-ascii?Q?eelaw2yQx4JVWcJnAM3/dYr8NBrUmbxEnPlIXuLXpIl1ejBoTNg650XoGB46?=
 =?us-ascii?Q?L0lD5vBXXZy14siW6mpVL3ZKOh3th2RT5TmIFN+aH2NjMhdkV9U6oo0xp35P?=
 =?us-ascii?Q?HSGBuXGNU2HPib4NTpR9++Ons6SA03XpnLOdtMxNJkNdx71bGQlVWcv2lTnx?=
 =?us-ascii?Q?L1YsuMTQ0fieCXUFSiOEovQetjfnI7aCIta2X/GipAskoummzgUssMruLInr?=
 =?us-ascii?Q?qVwcdnGw7Cwb5WFPJCe4ZAtfN51pFVjirZZ7zUQ0V6dowG3CAuyYlSrZ47GT?=
 =?us-ascii?Q?M8yvTCpniQA4xOnZ9+k+sjQ5Bnd7IWvxEHRbbEZUioU0wKhmrcwVQwx0fnpf?=
 =?us-ascii?Q?/mD/hSCi2JuUfXwNjSPX0tmCnDbswmtU81N0toS551m1fNpUw9f0TNKBh+9T?=
 =?us-ascii?Q?jF+bV4/abXSJeJGyjLSEH6u7RE6IwYY+qpnZuc+5uq+z4iPIFHV7G47N7XOL?=
 =?us-ascii?Q?QyvrA9B2Ax1L22Ll95315xb8reSLH6M7zQXEPvAVBkOpXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8EC5349786523C4D957D251C3B9C2955@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b03ff2-1279-43b0-72e8-08d9721c92c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 16:28:49.5359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfWOEdgFM+evmfKJ+hORLDiiVUBaAJehUVpa09aNvSmVeebXNGeW+4UTHJiRrCyfmjgOh/KAaFwA35KPqVZ5iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 08:15:03AM -0700, Bart Van Assche wrote:
> On 9/7/21 7:21 AM, Niklas Cassel wrote:
> > blk-mq will no longer call the I/O scheduler .finish_request() callback
> > for requests that were never inserted to the I/O scheduler.
>=20
> I do not agree. Even with patch 1/2 from this series applied, finish_requ=
est()
> will still be called for requests inserted by blk_insert_cloned_request()
> although these requests are never inserted to the I/O scheduler.
>=20
> Bart.

Hello Bart,


Looking at blk_mq_free_request(),
e->type->ops.finish_request() will only be called if RQF_ELVPRIV
is set.

blk_insert_cloned_request() doesn't seem to allocate a request
itself, but instead takes an already cloned request.

So I guess it depends on how the supplied request was cloned.

I would assume if the original request doesn't have RQF_ELVPRIV set,
then neither will the cloned request?

I tried to look at blk_rq_prep_clone(), which seems to be a common
cloning function, but I don't see req->rq_flags being copied
(except for RQF_SPECIAL_PAYLOAD).

Anyway, I don't see how .finish_request() will be called in relation
to blk_insert_cloned_request(). Could you please help me out and
give me an example of a call chain where this can happen?


Kind regards,
Niklas=
