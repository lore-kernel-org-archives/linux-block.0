Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E76C433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB1464E0F
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 23:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhBQXNJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:13:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18376 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhBQXNI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 18:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613603586; x=1645139586;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Aeu85oI4RNPvURGem1zSszvJOTxf9ksXmRMc23k1Qjg=;
  b=k40RJ0kJmp7H8NULQeHEHcL6oLra8KfP73qStTLlG48o+aIfSqbGo5KY
   9Si3P+vW5RUzhor43I4Kz49FvHzRJ06u3GWFXi03o3URlDfu437vnIqDz
   +fcKfKZgMrLi4IrGOmXf5l7hblDtEUwrV25Cicr/jEAnPS/7nmHK9jdPD
   gK020FPmEB6V/xj6xOaNBIV7mXWiPrt1k3ae5qQs7/vmYeI/S9JYcZ730
   P3noMYRdbzDyW8/XcCouYzfgZ3SJTPPxjX+h6slR48kHoh8FubCZ2Jc6i
   qRv8cdn66MUNULr/Abzm7HbFzSVqQtT6IIW/nNdVRDcFYJuzW6eNx1yGm
   A==;
IronPort-SDR: 9YjwOuvu6zx62fiG6h8fkEtSHWhrkTbSr9P8iB/cZFoHI7KLGV8+332YZZNMLjGtyml5ACYu9F
 IViGpcx+bIS6pWdfkLPNL38L2o1XNHkGhe7wJot0jN3FnhMOKsDsymDV6sPn/eM6DB/ISLNJ07
 Ks1hhWgv6NaIToZdGemwFF1UI09KQFraA0j2O0M3QDQ6hsQPyWdxQvrRAS2QXiaAYkOzJlb56I
 IRnpZxLnUjxxGbQKCc+2k2DH5Sr5iONeigftNCUGG8h7l6+qitK2mvkKLbfZEjyAXZooxQ9iT/
 4LI=
X-IronPort-AV: E=Sophos;i="5.81,185,1610380800"; 
   d="scan'208";a="160226525"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 07:12:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvXsRjxVCk7J3C+7/ZG8rflYql+2SX16Zg2m74wJV1sKazK5CwbTqSrRx6RT+QIKDpXaw6DRYJyPgM7vpXWsQL6K2RkFcvdiSfHBXAmGbW7A6bpEF3zpw6gO5E7+PQ86JqTJzPqBswz8O+6c6qdBfLA1WGSxz+JT5T2yErdGAjwODGkK+dm3vCZkgCfxqAuckwY4Es4GzK1Vl6QheH64wDxswOOpZ685aaQaZH6E/9GxRJPbfY8lvWvxGBeYoBzlmc1J54MpiznS50m8HArgMmJ92YxrDAbPKBhOC71+q+2ItfUCDJ1T49oGpbWnHj+E6yw7rwXRpP4hPDNJiuUqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeu85oI4RNPvURGem1zSszvJOTxf9ksXmRMc23k1Qjg=;
 b=dAeSEedFAEIqT3y8wY3zHYJXwL4tZhIQxKwTD2SXlKubs3FR5YmGnBRmyQT+YVhmFnWDKhXcIIx2+XGB3oKVsGNOblVrrs4coaBTqY9Vh7OCEzRpIbFMdeaJkjmH4tvGJWx5lpUt40rphekHDtLueRiTRorYw8dVEeLUooSqsz/aCOjCVixCSge8pucC4hf7//0LmnDNZzuvK1iAYwfioS3SbdAbIhkTjcDBAeC1xZdvQcIUkWGlYqQKJ1zk5LZHdV7/iqZ9+tPhhSVhzjk6ZcMTQoHeCYU5w2OiX/VlDuHFzyBbncbWXGgII6SZ56W9HVyJQyp4xHch54aurfs0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeu85oI4RNPvURGem1zSszvJOTxf9ksXmRMc23k1Qjg=;
 b=hYmNQ3zKs56Z/aA9sXwYLYeEHUsE/zexH2Z1+Bhi76AjLNsY7NbH5A6S5hJ1p1mlFVwe0D+ZdD/kUpy+jQSCTmL8i6jfdH6JwRTcsSkj9pnuuEkkaBaNW+Y6ND/HG1ZmX/QA67mBle61k4J8GzP5lghyxFONNj4GzGYURRYyxtQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6976.namprd04.prod.outlook.com (2603:10b6:208:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 17 Feb
 2021 23:11:59 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 23:11:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block driver changes for 5.12-rc
Thread-Topic: [GIT PULL] Block driver changes for 5.12-rc
Thread-Index: AQHXBYD93/cIg6VIAkeeOLqTAW0FtQ==
Date:   Wed, 17 Feb 2021 23:11:59 +0000
Message-ID: <BL0PR04MB6514F7EDE37F88D0A3F827BCE7869@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <2026e767-054e-00ba-46bd-716eb827a600@kernel.dk>
 <BL0PR04MB65148E7A098A395694E93EDFE7869@BL0PR04MB6514.namprd04.prod.outlook.com>
 <9884d35a-489c-9b04-6d47-bcb7a7e44e5f@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:75c0:49b:2210:beaf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01519947-8aa0-47f9-3891-08d8d3996db2
x-ms-traffictypediagnostic: MN2PR04MB6976:
x-microsoft-antispam-prvs: <MN2PR04MB697601B2B8A38F76F767894DE7869@MN2PR04MB6976.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85YbtfDdGO0kWCv9UAjNeE4V/Vi5RTJ9vmS+QxK4q0ZfNSraHjSGyAHmKEC1L2a1s9/jBA3eAcyjzo5bDTGfO20REqEdgqeav09kY8uprvlJY7NIFBESBT19Q+hY7xRUSWWgqeJXmUKtwzkiJ384eM4z3r8N2M8F/Jm2SkMnD4uQ+WKsg+w7P5mRSwE3adVtvlGf++tzZOcPSYdnNp6zJWgCqlDcZy7Xrvsd7cof7AWVkkyG+EqNZ2xr2RRVQVKOsxn5Qe6T18e3xvKt1euZ+PcMGncVmdDHsjfYLkd6Q9/oSPlcaBW6U4Oljg0kqanC8TEBEMzXxHsM0w23k+qH+oUZxi2w5JOX4M4Ff5+aAqtrkvwu6rmcRMsj7GKd/J6BTr26AegSW3PSfTGRPslxhKb5uc9Wm6jQBPkOaJ1exUEDNgCfgvZgF4jpn2nGN9ciOUaaDPVYkv843MzOMtB67bsaP0f4OwB00THIFjsxK6M04xB6sR9LwqrZrnzqldjah8Y7oDcyssX5roZqdW/20Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(55016002)(9686003)(66556008)(66476007)(66446008)(64756008)(2906002)(52536014)(4326008)(91956017)(71200400001)(53546011)(66946007)(76116006)(6506007)(186003)(110136005)(5660300002)(33656002)(8676002)(8936002)(7696005)(4744005)(86362001)(83380400001)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r1+wTYVZOjZYtxFuQovrwcJhvwOtZvcd4ctTwLPPHAku2pPi091qcumggW9p?=
 =?us-ascii?Q?8WVTXQHPKl0CwZEAhNJ4vgK0sQUgnZ00Ha5BlqICUaa+heFi1JN+bbMvRK3U?=
 =?us-ascii?Q?9oYIM9HnW1WNid10Y5Xif13yr6Z3Cceip/0sW5/ifN+l5WPVqGRV2ezL4Raj?=
 =?us-ascii?Q?fL54V4wZXMZnicShyAYK38YkSQzKxn1mITReQ/L51sr6gEA4GAGJuAmpEYMS?=
 =?us-ascii?Q?Zs1UeY+07v/+IOBt+oY4ChTkieW+4oUkcOhUKDxJGmN33TzGiSMvk5OjnU7P?=
 =?us-ascii?Q?CKECFpJWF5nj4GXvnjiFchYq1uq0nq7GSuIzWAzzhePWUh8d7og1q9xk73AT?=
 =?us-ascii?Q?zeVKjzijEIvTwoIj0hzwDPn6kbVZKHY4YH7km5olm5nm+aMFwMKpIPIt+x3c?=
 =?us-ascii?Q?6C7DyVNPZE/AI5sbZnJJWTvJEQYeJ7QpnyY4vZnrSfgZE9o84FlSUmB7ujjB?=
 =?us-ascii?Q?iFa0CkF/4M0kcQhEqneBXqtD+6RFiGtDvoPK/c8DUIgltbCCx2B32dELx0Lf?=
 =?us-ascii?Q?qTyOD7iVLlRZVG/6dya0dpf2J8AJz3SbYm0WfaDwqhcspwSnoO1u+a51u6+m?=
 =?us-ascii?Q?zVBtAhK/b1M4+E6Ada9xISu6LkvXIiUWTP35F3IquA1T4OKvPQryPd1zgqL8?=
 =?us-ascii?Q?4wITD4V7W+uElDHtrqss+vNoFR/FAW3hi5yNvSK2rdrUAAJCJ6mwVoZIyMp/?=
 =?us-ascii?Q?grI3wD/Zjle7eiJouadpG/9RErAMTjUCnviJ6aWdb8wpi9JjcXkCW0bguHWS?=
 =?us-ascii?Q?+F46XePeymexuuEbYAw8mIdQpWa6koPtZRQNY53wPiG9itsT9dH/DcA9E1Iq?=
 =?us-ascii?Q?p1CDHTDKlUixLgQ+X4TDhuvjRM89eqaqkAP/8f4Kn51EQ9k4ePOiS/MoHcnD?=
 =?us-ascii?Q?BdYY+RfNG/Qa1D28x6+EeeBYLvSWVRu6G3weXoHSEXy4N4Zgeate7IC++g6R?=
 =?us-ascii?Q?g0CPZtkMYoRmTmzB8nHsv+3zYFC4s+Dr1i9xeMKUDruPxzVIwevvVuu/Fikn?=
 =?us-ascii?Q?7tVWCKc3P21MdUMvnVxPNIw7uBm+S5M5GAOVS+t4GBn39wDFfAiUnsuhZupz?=
 =?us-ascii?Q?WIPBOhOfnrFH6IzvEH7fKc3CJPRm54i1y9Kgei5zEs8hulD3lBU9zyz6fKq9?=
 =?us-ascii?Q?6aUX5omGROpBYXU9tE8Ob941YHtIKw+bVQQ1AmGvWWvdfQuteTsKQ1G1oNUV?=
 =?us-ascii?Q?njo+DOGEQTP1kQ+xRTFrQJ7fe/BBv4WFf2pnwXpWQsvTTYkQVdpg/fN+7GPs?=
 =?us-ascii?Q?ZJ8SzgTOtTKCuKoJ4oL5Jh6/ibQY0u+00P00xuQ0mD85aqzMLA41vDeyEDwk?=
 =?us-ascii?Q?7sV28VRBmDojtfLlm5dmBalCo7M/+b8aluJeRKPuRi1ubTLwBvWFvV4/1Gk7?=
 =?us-ascii?Q?mwyn2HMilD/giYpO1B/F0GpTjCNEAfsz3GMVFdNdt1Y/7Qdo8g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01519947-8aa0-47f9-3891-08d8d3996db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 23:11:59.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUy12HNDI/7n9V4n931ob1/bOZ5uayIgtfOdSheAp4evscxIIB97xcQ4/iXheMq2udQON/no6o4SlSfuinUXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6976
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/18 8:10, Jens Axboe wrote:=0A=
> On 2/17/21 4:09 PM, Damien Le Moal wrote:=0A=
>> On 2021/02/18 8:02, Jens Axboe wrote:=0A=
>>> Hi Linus,=0A=
>>>=0A=
>>> On top of the core block branch, here are the 5.12 driver changes. This=
=0A=
>>> pull request contains:=0A=
>>>=0A=
>>> - Removal of the skd driver. It's been EOL for a long time (Damien)=0A=
>>=0A=
>> Jens,=0A=
>>=0A=
>> Looks like this PR is missing the patch to revert commit 0fe37724f8e7 ("=
block:=0A=
>> fix bd_size_lock use"). Will you send it later ?=0A=
> =0A=
> Yes, since that's not applicable before both core and drivers have been=
=0A=
> merged.=0A=
=0A=
Got it. Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
