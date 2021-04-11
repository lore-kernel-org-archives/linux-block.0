Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16255C433B4
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 22:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FD56008E
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 22:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhDKWNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 18:13:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15173 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbhDKWNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 18:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618179187; x=1649715187;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=P1MEMR0klfudMEJjbukBW8jN1d34g5ykvcgdC+uRh4w=;
  b=aXW3V+kCyiZP9JUIKJf9eTontcwID0zHaZKaAUpxtC/o8s9IoduluJwa
   T9zFCYfxlC1oQQo2cUucLgLOuSJ9dLz59tThS9gx2agjY3VRsBCjsfXVD
   0O88sSIdfDBB1LdIGYh+iXGUppAGSuHDCp28IBnGgvt2WQXDPZC/iz4CF
   jUeK6FxEFVDDe94EN9Rw5CZfHecCXq7jRDn5Ayzh+oQ/nBnOZxFWIhAPy
   58qsaH4pzRmolzs8nhaJN+/R80nueCRqVdE14bSt2B76coMsCwl09CQux
   Y/s1VpCKIY+6yEJAxBVU4ytLvW48y1iXh55Pq8sXtfKmX9Ctok6IPnsAZ
   g==;
IronPort-SDR: QYGPWUUEkY3XiwdPYNqkQXpjpTS1NSDqsDbvAwobXCZndpOsDUIrgU4aL/ugK6zi57o0cMg3sN
 1pOFOGDlpsEejgat3KboFdAbHS6WyZKFn5ONlaeHilnULgl840koePinc4tbVAcI/6KbryhzVE
 RUPpuRoMLciBb5R3QYkZ87z3yjowdE8PKhl3oQ9ix8ThTisYwE55X7+wVSUvjdpemj6DoA2ohG
 imSV6LNeh5px651CnnvV9BZY5Ufm0DsT4pE1UV8pSkOXYZtuPWt2NBPGO36GqMZMNIadt3QjUQ
 YY4=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; 
   d="scan'208";a="164433262"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 06:13:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLSIvSUG15flLYNWimHlCeArRvQUsR0tpIIPc3dqMsWLRJJnLXPSFxbIe3FD1bWotnsupBm54l1ULeu7oPTfufmzfwbZKTkYGVOHoWMiLjmkV+owToS0RJbjxxTQkOhfrG/+W+vsZW5/MHB1/4rewwEmSl5XdcZlZq7na0LzZu0AbnTITCLLDuUxiTJhjWsDmvU1Rdk3DLdRTo7ioU79ZTU+ckqaAqQs9tSqJq7H6WPhgcml/R5DAdRSPTY7kFUPUsE0COtKs1TsdfNDh0aR4bl2BI4wq2BYYh4UbbzbnbExkHuethGPGVP6+aYiKBW7wnjkxwgcitXR/9vzvvJuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1MEMR0klfudMEJjbukBW8jN1d34g5ykvcgdC+uRh4w=;
 b=hCCK08sqFCPhGdqTmbzzeaDC0K1wCocGwRSSbQANy+zeLgKMqdfb8sBTrGumGZ/EwACOhFni4WWYolPoGO139Gfxakt1dwIRFgjNdkK2QQZKpqmvtdYpHjsWfgeh/Aw9EVbHJ8iEvr64/SzOxVWhmm9xnmHv00k0k800/os+/lLEpGNiGfVRiC7RZ/aCg6bRFumSnfNYDgk+YPanC0tz0osQYaAovRFmclGh9riniAaa+QlCNHCiVY27G9fyEbcrdkzZcuNe6xrSBpJAW5AOyLcPayvmOAceELiWaoN+IeDjJ0C/rRI4rHJO5R+5PCVmrDZMrdriBaJqFMZPn/j1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1MEMR0klfudMEJjbukBW8jN1d34g5ykvcgdC+uRh4w=;
 b=kYklxofweThRjRuw27tJFUpMbXevhH0Slb69VqLLvBKQLnYKraLbs2PUwDJuDKOunUATWwQzBQIy98q/lIqXw+JhGofTI9rfdYyBtZLBqUU3YGXHYR9Wq6iyZz4bo7kcMWT7PeZWRmxE9CfpYoOYelBHMB/M5RqrrLIS55+GGus=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6415.namprd04.prod.outlook.com (2603:10b6:208:1a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sun, 11 Apr
 2021 22:13:01 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 22:13:01 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Changheun Lee <nanich.lee@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [RESEND,v5,1/2] bio: limit bio max size
Thread-Topic: [RESEND,v5,1/2] bio: limit bio max size
Thread-Index: AQHXK5LimbigZS3dMEyF4qJ0Ir0lcg==
Date:   Sun, 11 Apr 2021 22:13:01 +0000
Message-ID: <BL0PR04MB65148B0629FF23847341BAE8E7719@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <YG1iC944hUkBniDM@kroah.com>
 <CGME20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7@epcas1p4.samsung.com>
 <20210407092836.13016-1-nanich.lee@samsung.com>
 <BL0PR04MB65146F70831B61CB6B9AFE7CE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
 <cdd26ed3-2013-7edd-b25e-557a56397614@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1134:9421:2151:4ee3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97d91cda-3a1d-4e7c-80f6-08d8fd36f8bf
x-ms-traffictypediagnostic: MN2PR04MB6415:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB641543100CBCA32CE3746261E7719@MN2PR04MB6415.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+7Q0CbWxU6IekS7/iXvI31LGuhfrLcJjdFP4sBNMih+s3zSXh+cIjYABo1HiqqDlpV3z67ou/nhavDGE44WIgpBI2KkYNqtilxej3kmGRRNPBLmLGB8zWXG4B1Z+TEaZvFjRxCTErvnJ6sxy32D+8xTmT1Q+r0RV7PPFk8nhDkt59vvsgu+UZB9sYQRoLwRgqoKil29X1Rkdn7f/ZUHixV726M4VgdVX5fqOsqPp+yJVQW40xSIQqZ6v5r1jLSJbIpLapPQRX1gvdsF61JN88ETggs7FdYp1fPct6WzgvfQDojKOJiANyzVhx7aJGiL0vzjKuea2WsJL8SsqCB1ioaTl02OKBNJ3/KRRL+Nj0MNTQceUL75Me07RRPUWroXFgdL91QGnk0jJUXfB1+1vdqumJWXahe1nwMGoZ4CIhGBV1SAMDBOSAaOtZJx0IjTE0xUW2NfYj1lVLGFwx3RYN//EwFFUk7ivck2UEhJ8SYL8fyJRYPEUJR9pV43MVJP193wuBZmRWPgZ/xWdBc9nTicb4oCo/xWuoAWjKrj8zlBo3nC6oT6dHGobBxAbHDF928JF1nu4Qs3Vsr6htUXE6IzE2rzGJArRaNI9l3p+rU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8936002)(54906003)(71200400001)(8676002)(7696005)(38100700002)(52536014)(7416002)(5660300002)(186003)(53546011)(9686003)(478600001)(2906002)(6506007)(66946007)(55016002)(66556008)(316002)(66476007)(110136005)(76116006)(91956017)(66446008)(64756008)(4326008)(83380400001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v7rbXX5A5lD2v1O1TyJUmUALhbLtf5RJf3654sqB8VOPf5tcr9UdcfuJM/gT?=
 =?us-ascii?Q?iE36U7bFGaGdsft5t/gNqmplrLnGCOZAC0BycyuAWJlZ/It8hdCH/7mlFVb0?=
 =?us-ascii?Q?1FAJObedc/5iCR6jXG6o5o7PItZqV52ZT8iO4Vq74t+x5e6Lim5lWqgfjxcY?=
 =?us-ascii?Q?8ws1iTMTxKzkzUnjuCgwkgT8yFgojXm1dk3nAXzsxKGlvMtsS20oUO9oMZ6J?=
 =?us-ascii?Q?fXOdUBA2RYd0ySy/cvZZLLX8BiNC8WaBix59UWyKJYEO7bLSJCH9UVjrbtQR?=
 =?us-ascii?Q?JjqQNxOoa3gZqyQ8IqjriIwvBzUqIppZ3pxMKvxPnRXbbyqEjmIfeIHbaueW?=
 =?us-ascii?Q?diylFebNg0lI6fp6ZtDqFtR+OqktiWfLN2SrbJ1pJStsJXYSaq38/9bqJ8By?=
 =?us-ascii?Q?eVHWe/cikBqyoXqoXSAETeZR4Csxzt0agNr8QU3HRW2XrxKnYJ1dYCpU3cu6?=
 =?us-ascii?Q?XYMKJ5+ji0S2RTf21oOCfEq1tcR3WuH7Ks6hRWHu+0tCw9J5HvQv0aeD2ei+?=
 =?us-ascii?Q?47JRUBGOKpTtSObWnerQa4O5YrXls2Py2+9BsT7cjZHI1eYPa/YtUmPkPM2C?=
 =?us-ascii?Q?Ms0JZBapmPcUyhnFXgmKx14mk4ubbkB5LKchKZNwlNKqC7oKmA0OiaZqdcjk?=
 =?us-ascii?Q?I/iZh1b3wJo70e7Mtj6mlOedJckyRjGJxutAX9eUHTV/u3CGhTgFLiQHuruU?=
 =?us-ascii?Q?7PJl4O6uTr4/7mY1zaDCCwkX7xuDwfg0A8aQY3pxYAhqHx9iTJOIWAhEjFGL?=
 =?us-ascii?Q?kP9F5vFxvvs5zj15wzqRPmi51hFJzQpmijSQEb7pdxthczwDMW68fVfTG+5Q?=
 =?us-ascii?Q?auX3voYurrfMe/F5vBleFPWa002SGTRSOzEgMvnw71mE1EtxjTron9Xz02Vn?=
 =?us-ascii?Q?/cOLLcKiTjqkhUa0jDwyyWHIWuvhT401n372ehBTuQ0IaQwVkTFjVLq3pGW6?=
 =?us-ascii?Q?nqlbYLJpi1k+KNbXspRgwONsBbd8Maxy7wjmYOV8j6ndxsPRSOAdXeX9ZBwz?=
 =?us-ascii?Q?22chVpkfzo0l693QjR6Jg63NCaLPBFdQDoCoyOfrCEDtymVV7lNxA6FM4CMd?=
 =?us-ascii?Q?Vua3nf0qdKdv9eOES2ZZYxozX4+jO2uR2ZPfWnxCNEtak1Juk/4hVLwx5YXN?=
 =?us-ascii?Q?3yybZTxjKKQpFSfZI4415d3bOVtExD2oLqGO7vojozSHZYb+wEDcuTYgEpd9?=
 =?us-ascii?Q?eVH9opYa8eXBzPDa+Dw++9eqPgtGbl0MIQ9FUNqAbmJGmVZPfo5ATs8FWUvc?=
 =?us-ascii?Q?4c/3pBYfDsEQ33ThZSQHCfkV5gxUO+0yKK7Vv9mTcEKVdhXeV8CPCarhgVC+?=
 =?us-ascii?Q?etAapv7eQ31IHTqmXlbpJ0EhPKVo22S6L0cd14qfltuJf6BXSHyHG/H8PzKX?=
 =?us-ascii?Q?XC8kueSjKBO2PlNwglm9sShLfsj0Nj8Jx39H6HssCodwzYk0/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d91cda-3a1d-4e7c-80f6-08d8fd36f8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 22:13:01.3877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGNrjNVzQxy99Ajxu0QL7Wjx9grNFoufFnhZDPX84WIcVdzcKrwwRG68gCIiuk5jJoVdilRFLmeKyhz1WZIk8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6415
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/04/09 23:47, Bart Van Assche wrote:=0A=
> On 4/7/21 3:27 AM, Damien Le Moal wrote:=0A=
>> On 2021/04/07 18:46, Changheun Lee wrote:=0A=
>>> I'll prepare new patch as you recommand. It will be added setting of=0A=
>>> limit_bio_size automatically when queue max sectors is determined.=0A=
>>=0A=
>> Please do that in the driver for the HW that benefits from it. Do not do=
 this=0A=
>> for all block devices.=0A=
> =0A=
> Hmm ... is it ever useful to build a bio with a size that exceeds =0A=
> max_hw_sectors when submitting a bio directly to a block device, or in =
=0A=
> other words, if no stacked block driver sits between the submitter and =
=0A=
> the block device? Am I perhaps missing something?=0A=
=0A=
Device performance wise, the benefits are certainly not obvious to me eithe=
r.=0A=
But for very fast block devices, I think the CPU overhead of building more=
=0A=
smaller BIOs may be significant compared to splitting a large BIO into mult=
iple=0A=
requests. Though it may be good to revisit this with some benchmark numbers=
.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
