Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8222CBE
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbhALRhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:37:12 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29645 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390299AbhALRhL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 12:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610473030; x=1642009030;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8wBC9qQs0C0PaRwqJiw1JekockygqVCHXt8rOS2lCTs=;
  b=rtqiETAgt0dBRSqxQSIMaxbZBUoFsiIc/oAD/inKxh/INX3r7fMn8+J4
   QnrS6uO0zAdbA4aDCadZAD5lrAIVafGv+sY+yAQ4XV/kBr40KWR+AgenO
   /CrVt+M60fcE+N6kc3jFxDTSavr1A3DL7jeNqP6bkaZBxx1CuqzmlGXs1
   nX8uCbq6cEsxjdsFnV7cMADAMuWeZpo6/0PWj2JfTCcXfzO9nwyHT4stV
   NwzYE80h4bhLaq19s1RLsrPgFBP3OcK9ahsBqEKIA4Lc9yl4tGs0gfNAD
   vDUWSd9KkjGcdqPxOhHLjqsWNlmfZt+u5CR3dkkoyGAwuijdJMhjCBERr
   w==;
IronPort-SDR: hXAac4vZoWCn9ee02BHjMp+y9ffKZNQjEOFy4L+dHnCGvtVmJF9LBWFaKjM9h3Bjl1wqc3M5Op
 YI2XTWevWlYRI1aJPvI/lJovxiVtkaqScIWgJanlfNzSo/TUy8yyro98LbrxL8iHLuk4k+TAXH
 yLOk0AwtN+U3BcDSwQodUZ8sGrESAINpd1k9K60ieL7Kq4ETUjRBYD7eV2Hn1hqnvKCiyXZ6WX
 vZH8yFE9WZqT7OLycSLHkCuPGXXTQc+BMOynR4m1Az70tOa+yvR3FdT14FLatJPPTKQ47lsWcq
 2RQ=
X-IronPort-AV: E=Sophos;i="5.79,342,1602518400"; 
   d="scan'208";a="158436375"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 01:36:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gww9EfT8z6eRlOIOVEMvuCrwf+EUy4WJ5C9oRKs9R4O/df9e5DfTGVffvEbaHcC3/k9sPbvoyj9nu3jGnTIDpsvpr0y2uuTs7aDjgAAWBkDIBZVhsZUvPWWiRZHs+ZlQqHQIuDuISDgRD5Iis4g0qxuKm6BVa8mXilGUm/8JeWznDwcSMPiRn9DxGhELSnASCje/pwMF4n7TEorZJY3qbAPuhr0cUAV5EOfg7Cas0tbMaOzx/e4BZ3mOACyLMZWyaycuUUuneFMBFwx8x+sKuClIzFYQ94shvPh0XxHyFniy0KI0Fm8YsF45L6r+iFtD0IUmu69A8Gi3j/d0XPv9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wBC9qQs0C0PaRwqJiw1JekockygqVCHXt8rOS2lCTs=;
 b=ifJpnrsDpBi5DOZddv+YmRah3jD5xdTE4h4MyjaDJMfnei9U/pzF+tZOgP8muMM+zRU6Qy47iBq5JLpGJeMxiJ17SuUYyo3FToMNApB745qlHQtDiD78MBaNMkgH2XIc6RUYgUkk2nAODNvRi+1BxW5TD4rmVEc31kjLrG9mZ1S5b7hQfnSZh6Wf+27cxOS0PDDt6bZLXHQbjLaXpevcbbR9vE2HjXH4094Xix7h3eBaJvtnFUCLjsYIhbnAkmZLFviD5+EfupyQZ5M4YQx1z/5c7gStNTtVqlJtkYGJp8VPQCgBNx/tdP3e20EBE1a4CZWgpot09RzdR1O9XbUz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wBC9qQs0C0PaRwqJiw1JekockygqVCHXt8rOS2lCTs=;
 b=pKhVseMWjP4ToGovnumM2cWXqG6BK7uw7ultJ0B7zf+OAbB9syIdtMKq9koa4K/pj9wTwFSfdmSU72B+ufkPuxVdeXWAOGMythQcX1QnATaO92vLFWzFPw/uMH4JTNQathi/sPuKwPhH5zUQJYk9PucrQ2mlbIOQmziamvft8cs=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB4218.namprd04.prod.outlook.com (2603:10b6:5:9e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 17:36:02 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::61b3:1707:5b14:6b59]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::61b3:1707:5b14:6b59%5]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 17:36:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Feng Li <lifeng1519@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] blk: avoid divide-by-zero with zero granularity
Thread-Topic: [PATCH v2] blk: avoid divide-by-zero with zero granularity
Thread-Index: AQHW6PwAHqu3TS9LQE6lI7KxZ+zOWw==
Date:   Tue, 12 Jan 2021 17:36:01 +0000
Message-ID: <DM5PR0401MB3591FDAC44CD5665D6CEBDC39BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20210112152951.154024-1-fengli@smartx.com>
 <20210112155502.426331-1-fengli@smartx.com>
 <yq1v9c25bm1.fsf@ca-mkp.ca.oracle.com>
 <CAEK8JBALYE0_OzfhrppF38=dD7HKSn-U0ggPJTGgx5849Gfiiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:38c1:d5fb:3079:ba93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f12fb02-51bd-4a46-cba2-08d8b72087db
x-ms-traffictypediagnostic: DM6PR04MB4218:
x-microsoft-antispam-prvs: <DM6PR04MB42188DF2CBE72283FFF38D459BAA0@DM6PR04MB4218.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzAWLcoRTGfR2PCCBDVJTZRRmsdmOmTnNjWKq2N/dhMpGLf0X6JTK3lrDLild3bU0KDgUqvEJijt5AQvuW7uaHJIxllrX9zRA3G09pcJ8HgwWX1XoPfUsPCwMua7K+J9IT+nDQx6Jx7RlXBqYq/d2shc7wrE1Hvr0D0SNhAWXnDUi/JCcZHVSmHsv2aAILiLgmgeLS7D1iz9JVBwEZyGksd/O1W+s+4+Ifjn2rRB9Vf0IQLRaULByy0DTnbtiG1bpy2ZMN+2ooMRdp1QDJJW340Zr/EAZGbQEU69F3s01Q7G63UteLT3+HMnsfYC/bpll6RTTGKNn6diH2BDciAeyS52i1NJoxt2jpRR9yaoHaDgu0siGj6M64CiSQ7BxqfwivEeNjjRhkEt6kZ/fXqaZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39850400004)(71200400001)(4326008)(7696005)(53546011)(8676002)(316002)(6506007)(558084003)(186003)(478600001)(9686003)(55016002)(2906002)(110136005)(54906003)(52536014)(83380400001)(66946007)(91956017)(66476007)(86362001)(76116006)(33656002)(66556008)(64756008)(5660300002)(66446008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M7LEOKoCwy7sSittkSTO04wHhvBmXn7s+pBfseMfnKsGcE8Zj5xxBkBbUMfX?=
 =?us-ascii?Q?3gNVFsqiPFZ/lW61T+x1deIjkAoxFEyYgoVRn8Pt/V1brZGabsxgBL/kwI8b?=
 =?us-ascii?Q?FCVeDGxiWos9f2RTN72jeGkbiQ7ED4k6MbI5u7bDuPQ4qOoLz5e/yj7pzIfC?=
 =?us-ascii?Q?S0sTl/ATSHXMr4KwNkrkmDwU8BDXYxrMX97xrsBA9kY1Bk0q1WyvNkr0+bND?=
 =?us-ascii?Q?eA4GWVQ6ZYELrH6gjWr0lusEDAJ2Rs+gWjkNe86c3rJ1GR0DehMtwMEPUWDP?=
 =?us-ascii?Q?sdQTZLoyVReFgil+/hOFxs/tIZDjmHWgiy5InfIGwHLTF9/G/5HhqSl/u1qK?=
 =?us-ascii?Q?s/HQxsAvN5bA0/RK4iL0qHEe5YyEH7z+XWuZewWBamVBLTkEnYq+dNocTEwS?=
 =?us-ascii?Q?2MRlX2Fm/QcQYSa+Lb5g5Vvtg2by4BIJNdQvfP8ail4lk4xrIpTCIdvmaQc0?=
 =?us-ascii?Q?vgZfIzSQFEQAbhA0Nx6o1UafewK7lbIEr915TXn8bsAVePpj5LCQ8cMRhEE4?=
 =?us-ascii?Q?TtvlUGalejcUIJUH865u0DNaQ5bEtf70yvlxMvJRv/L491NobuNbsOgLRE6n?=
 =?us-ascii?Q?itOoBqZ7txlRRbHMpbc6P/Ohx92y8W32Z3uiQsq24cFKwXI121L8fbkvmXnm?=
 =?us-ascii?Q?VR9v29HavCjJtEuGAcjmtuQjL2tKnCWse+/Tm6JvJwA0RiAk/RSEzGa+mB2j?=
 =?us-ascii?Q?1xL4HhnnFoZgxrfwBJSNP+rwxTz8HcnZMIB//UgNua934bcaCuiZ7ErQ6DlC?=
 =?us-ascii?Q?7vdf7Df9KwwnaZ1T1JR3Ki/ZHIeJpWPqiQDlKVc4IMAamVUseICpUfp1/bBw?=
 =?us-ascii?Q?q2JFk8iHOsrNCewIOadyBZv70u7JHPk0dw5VSGjLXDwQqjpL7jiWgh6Br94c?=
 =?us-ascii?Q?Lob2aKfIP2g0wcEnHkiqOIC/wtutciGwEyjZcGZyl4AAN8kmiwYFtxYVJB/G?=
 =?us-ascii?Q?CVgC0cP8gC67OMku8+gr0Arj3DXf107lBdbr9rDAWJ/8IpUY2GjFm5Q1cVUJ?=
 =?us-ascii?Q?4M/bgsyJyZ0RbzC7SSekxZ71Pdq8p8FEWo9IrcLFbzemRCZw++MzPIwFAqCA?=
 =?us-ascii?Q?xaGpRTzg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f12fb02-51bd-4a46-cba2-08d8b72087db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 17:36:01.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXfwPGGSAEwrPy22ALNZ2A844/5P9AgPgWYa8Wqgo6Dzs1jgAsALmHrNZTOdo/QQv/FWbzQ9ioOQpXv6MZseyb0gaIWDuuT9SGeIMyup94w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4218
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/01/2021 18:29, Feng Li wrote:=0A=
> I use the nvme-tcp as the host, the target is spdk nvme-tcp target,=0A=
> and set a wrong block size(i.g. bs=3D8), then the host prints this oops:=
=0A=
=0A=
I think the better fix here is to reject devices which report a block size=
=0A=
small than a sector.=0A=
