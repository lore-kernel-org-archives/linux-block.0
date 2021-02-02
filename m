Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3409BC433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED27364EC6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBBBss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:48:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56045 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBBBsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 20:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612230527; x=1643766527;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5cdMPK1PQHS5dnaiGxVIx0cunoWAsz2nV/M5QbqqTjM=;
  b=jj7UKpZK8JNoogpgRGD9L71yb6/9+wSIRp+6LezomX+AztQf5aMUG4dE
   IyqxxabzSiljqLmg/xtdFE5t4RE6M84oSzwvEYKshLawHKd8UYic+pZtE
   Z3/wxq45IQVWqBlymPCZNIH6zcEoTE0TEFMVzdnRI3mcCeXxNTegkPu/Y
   2OgwEvdDZCtG5figf2hYC5nokYB5t1f+AVma/XRv26W2MUKg0Ol8Iit/S
   JFe7NE/0lWaoLjaNkd0oeckKTAjGkTapMJTTS92oVpNB9i2YB26mZmR+U
   0bmJpsOttn34Zmxdwr4GQRv/atEHwS4tNBRblufTllXWkhQ2v7kDsP9ba
   A==;
IronPort-SDR: nrByZrA0EA/0DYeig8tnPQNI8mycbcZmWUYt/saQYhT/Mal5QoysY1ku+1zMM4ThCgtRHmd2MO
 Pj/bQy0BxYwhT4YciXgkq85teh9kmpxTZneSoNJrw/atv3Lx8vbtdS6UcNQ8v3kwF/Xg51vj5O
 nBclXRIC99LVithHeb1trfuBzLaCvxUsnakhbQpOrIfe6vPM6A1kxja4NDiYs7G5oqwHvBujpm
 Yq/BeFBvDjJwahSEdpf+W0AXTuExAm69yCU5LIoSoEEOcn3B225sF3z8B8TzOm6XroPLfAUb05
 26U=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; 
   d="scan'208";a="163318457"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 09:47:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQuM7MvvlR6TMIf2b8xmHdbqBHsmOphfYlsIU4tRwTo0neUCyLaYDuKDJM5Rjj/SK2WQ1uaJnTDSWNCNlgRxbiKDtU0pCwW/mnzU8Bn4HGvw/pZZzx36eMVmWl51w+zXxvBWxzpN3mAr4e/A1yUJPgy36gbSoI1PA0VAgJP+uYpxzP8mKU+5c6o7mqbzQFxcQ1D5+M6AFpEJmqIFtySNnJwTGjxo1VsbpSqIm9qz/KVrH5Q2Y6nD1aEh5yF0iVYZexXBqklmxa4gjOXnuKTfCjspwPIN6x66dmCUxicfqFGNtupYy+j2o0pf8oiLQxzJ9oMJR2VPw+jr9zGClglwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cdMPK1PQHS5dnaiGxVIx0cunoWAsz2nV/M5QbqqTjM=;
 b=Lr9CFvXVWIPv5eNA7j3nMXFEg14btLt+a0jqVPyvwSppT7NCMgf5fBERKmavN5qpyhlEIfHIDYqjWKIRB2zcVsdegpU1O/Dfsb4upx2qKIjESMvXehME4eoMb6LcnbXfvWAMvoZQKn0+L3v3xFCEzGCm2YEcb7b3vozyBam6RAwxsXe+eEMhrMgpsmgV8/m1NkayZKo+ekpvXSuzuThu/q3wENDPTOnvHw9OAGBYcJ+8n2DkYu91LyX70f1dEu4qdDFnHFJFINmIxLNV4v6RUeFN/VV0jb92I6D+1mVzdiwjR/k1ZGGFgBueaFH/ziC5xsx74vnHx/go0fXviUEu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cdMPK1PQHS5dnaiGxVIx0cunoWAsz2nV/M5QbqqTjM=;
 b=ncucJPrZNygG4N/MgjSYzKhfyMZjyYBUpuXaAIic81N/UWZ8ipeHIGdZBAhIKBGJaD4oNWDTr/SpiL2RgZyWat3XNMUgcV6S/XR9ZxxdIZabKWgy1bMyzWvJHjHB643JkiVMVjQYID7BF+YpUQ6oInhscijKVZX+/C4hgUN/vkc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7678.namprd04.prod.outlook.com (2603:10b6:a03:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 01:47:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 01:47:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Tian Tao <tiantao6@hisilicon.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: fix unnecessary NULL check warnings
Thread-Topic: [PATCH] lightnvm: fix unnecessary NULL check warnings
Thread-Index: AQHW+QTrFthxtSGMfUqB3aCDkNbtBw==
Date:   Tue, 2 Feb 2021 01:47:39 +0000
Message-ID: <BYAPR04MB4965F95707D5C87608B4ADEA86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1612230105-31365-1-git-send-email-tiantao6@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ce251b8-6d14-45a0-4d9b-08d8c71c866c
x-ms-traffictypediagnostic: SJ0PR04MB7678:
x-microsoft-antispam-prvs: <SJ0PR04MB7678B7FC327053E1B039E30686B59@SJ0PR04MB7678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zq+bj9gz78D6cRByfN9TW0zL7Cxha+q/SHn8p2ghkOkqGFM4hAxln93xIGJajanwlSwYaBTzLR1xgirGJ3Tm5MNPm0JzqlZbBnk8ZNqKIuaVB/P5xec6bhjzsaY3pgifg3bMpuxG6IXKjU2kGCD8ZT/+FOGo49JFrFYg9geSxwcAihGcoEfc0XDV4Io2Edf4bo8QtFcjvDdvyDJHjgKW1T1aLSUbjwql/3GexqerbCrvkSvmwVlVzfzE7ER+Ht9aKwl2BsO6F80n8T8TEoC6jtLIqx3iSF/7fq1USmq/LV1NenIhNvPuUgEooIDaildjgeJV/r8Bdy5J/X0gZowwq/sGsSevz2V59pAgi/WmCdm0jAAYrWxoDnKWJ4j4u8DGO9JnauTP1uMEzC25/9eevvbUeqbmmmNTegpqxs9AElN65blhbUgdq6PC/skHlrAuZ4pyhHVmyupWUx/EqN7aunZRFng5b/YXbkieFph5jQyndLJSipDuKNX9UAngRDOe6+4sAAeIC3C38rTg7/C9yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(7696005)(64756008)(2906002)(66476007)(66556008)(558084003)(91956017)(316002)(110136005)(66446008)(76116006)(86362001)(66946007)(5660300002)(8676002)(33656002)(55016002)(83380400001)(9686003)(53546011)(4326008)(71200400001)(8936002)(52536014)(478600001)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QKbBoVUybDWvYFS83OEd1v/F8YPF7Ld6lGMcP0ZMJ5gvOBaigrq1OMkYBlVG?=
 =?us-ascii?Q?SxT4EfjNGrAJHS0aTGVRM3NUUF5zqz1DwoAYG8ekOi7KSi5bhpdmIiGcz47f?=
 =?us-ascii?Q?9d/yX9pYmeLBPI0/nUAVV1QzyXHk5ZOvM7EfhCDUGyzAWW7f/rDuglozrewp?=
 =?us-ascii?Q?n278zxB4sCrHsoAF3MVQja48Q5HckAxW+muwhTeEOMnn7w0Jfqe+znoato4w?=
 =?us-ascii?Q?+N8g7reHjhXytOt1Vdki6Rc+XBKMLfwqef2GdeGIl7MGQmGFIF+MwMtFFTDc?=
 =?us-ascii?Q?NHjUPDk4F7JJoCsQh+3RTA5OmlPUNtP1i/xXCGZfdb8rLBuz9XpyiYbtKAm5?=
 =?us-ascii?Q?JT2MQZMNVfdESau1Vr0Cz1sLRGwG2QUf63fF2Z+e+hqdl48viMH6sMqeJbDa?=
 =?us-ascii?Q?Ex2asXBDf34q5d+xGhfX3Gwy5+5E+Dob+1uG70NWj/QJQaac4CqldFiTShQv?=
 =?us-ascii?Q?ZqhgWwxzgDho9xUDt70G22yURRjTFWs0qSuH40iBrcFWxXFdVXniu1lkV5D1?=
 =?us-ascii?Q?4PSURZ1GdXqnJ7lYCQzmDeHXdhPDYftKhpEaBqugA19P1SiXEnAcZJgtQt4Y?=
 =?us-ascii?Q?Cx1rJsMLvJlIjK3U0N8zR2CxHlP9FX2XbCxFAQDLJVJFjZhizfC0T0PCt2XB?=
 =?us-ascii?Q?KXRYRNscin3L/ZTWgzgOcXkeEkphYa8/CAoWgGpYep9T5f/Cs7cUwk8vh/jl?=
 =?us-ascii?Q?NNPUJFbLs9nLXNX5wVkQgYbYs3DagFptFEWHDJizKNuBr+3Xf2+LFasUhKyL?=
 =?us-ascii?Q?yg0YnIGABaXv+SQeKufnOGQnpzCFl+CuBMWJbN9Eu9fsqe3mWUfzrvM+K3L1?=
 =?us-ascii?Q?Kz9mlQFi8lWl4NAu2flRXfY9hY+n5hDxzM85BUoRLvwATw3q/H6KIURfoThH?=
 =?us-ascii?Q?/r45L+TgVLApa4Wc9D2X7NqIJ8BB90G3fWwJIdpGOSq7ELi3HUF6A0AIZfpW?=
 =?us-ascii?Q?/zI7Pzw5BtVgVv/KnhcT6hiDU4p1wX1a6hMJMZcu9O8IY/LCgQ+3Xgt5b13D?=
 =?us-ascii?Q?uhaGbEs8O7BH4lEh3xVxhTcYiJ7hdjSUqbAlXklS4uuqtTYB2b1TRraeyM+M?=
 =?us-ascii?Q?yCuRwRBqAb/YOmq92e5cNIeC2kAi2Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce251b8-6d14-45a0-4d9b-08d8c71c866c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 01:47:39.9752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CakWemqfu3El/J0Dq7k+jRzGYEuYiF3bRl++6G64HgiqeZKQMF3L8GHZ/IAMIifD77M58M/xfuyaAlliKHe/Kv2OjpWe31cKKVWSUD2V3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7678
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/21 17:44, Tian Tao wrote:=0A=
> Remove NULL checks before vfree() to fix these warnings:=0A=
> ./drivers/lightnvm/pblk-gc.c:27:2-7: WARNING: NULL check before some=0A=
> freeing functions is not needed.=0A=
>=0A=
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
