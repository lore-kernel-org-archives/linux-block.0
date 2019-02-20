Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82478C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 01:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B26521738
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 01:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SfYOI7nI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DOa+gyB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfBTBdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:33:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2427 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBdm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 20:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550626422; x=1582162422;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MHKRSi5hsdl2WlOoJDJ9FFelC5DTX/cIxzBV238ZT6M=;
  b=SfYOI7nIeNxsd5qV34I8HwxSN06RKjpU2SvaSnzfV9XuLKrlkgG6IgkR
   Q0+tdPaRHx5BbFQOu8rzK+GM53Eh5nNm15duqOHwouoP0BupQnSAnfKXr
   6lGnWPgB1QVF3VpfUbiLIKDLixCqtI40/WPVZPhUfuJX+Bhbf67UaezzM
   xGvc6Y9dphP3yvBgoQNffF2nsXEzRXj++qJr7ST7Ml8J0t4aMKcxLBepe
   4aKKOPIH9BisK4KnxONlLjR+FFX2yAfDlD/l4iViI7OK0yB/C2cSaY0Hz
   dcWqo0H4nc36gwquq9Qc2ta/tPVIuYIrFoU5X3gPNIYTfhkFfz11i3fXV
   w==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="103439119"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 09:33:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bILWT5pucpH13tzFZWEBo5n2ZJFoDLYhkZq1rVM3hT8=;
 b=DOa+gyB6WnBSvd88GEh7jBzixHH7CdP4VaaYwD1gcq4kuzQetQZWqL1/GjtfBo8R5QAUdNYlzF85rF3fNyR060u1iEL9LzRvilXrhjj8rKoWdqbiXOZQjzNEGXlNGZZFTdlzk3G8Gr6lnnYqB60e4OzJBie2PAW3SeSHlTL/Vhk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3919.namprd04.prod.outlook.com (52.135.81.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 20 Feb 2019 01:33:25 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 01:33:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <keith.busch@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Omar Sandoval <osandov@osandov.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] improving storage testing
Thread-Topic: [LSF/MM TOPIC] improving storage testing
Thread-Index: AQHUw8cWY/Lzvrp1zEiECHyARXLTBg==
Date:   Wed, 20 Feb 2019 01:33:24 +0000
Message-ID: <SN6PR04MB4527328C158EFA37706D1BAF867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190213180754.GX23000@mit.edu> <20190214215634.GD9819@vader>
 <20190215030202.GA723@mit.edu> <20190215173217.GA11055@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [76.89.205.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5a5d82b-cdcb-49bc-ac30-08d696d36831
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3919;
x-ms-traffictypediagnostic: SN6PR04MB3919:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB3919;23:GV6PyQk3TyiQC+rHzYqxhnlCMrpItnRQoTc5HT9u+?=
 =?us-ascii?Q?U0BO0xYMfanGc8brpKEgolwGIhaHQEH6SxXwQI6g1ZZy+Q+D3WqTpknrnYGD?=
 =?us-ascii?Q?jnpL/tiUOgaHIhZLOt0tsfpJslwkZhmwkXQHNCXRajEJzHcHKgtMspTleCLi?=
 =?us-ascii?Q?x2WECswXPPtGZW/+jKFjRwfNmCoUmvEK5Ofx1POvHptUrqKp9HD1z+styuX8?=
 =?us-ascii?Q?0cPkTZ60OFPlJYQlByHxDBTntiET/6Fcu2uBcMePcvqdz2bpb1Xb2TO/a5b1?=
 =?us-ascii?Q?juWPl5siZZQ89TLe0i9v7hdK/E3AsouhQ9E3OhNSt4pWKDPGd4LRW+5t9+Wc?=
 =?us-ascii?Q?S/8LBJQQZJrzkcuhzNN8IyGNhI/HmFQz9bdEa3JgyR1PByEIwsUc8ryvVyxZ?=
 =?us-ascii?Q?GNWGMqc2z+tejnxtGt1j3XGlDPNQx8uIw0ajo+2HrV+P87z/JncBu6qwYPRt?=
 =?us-ascii?Q?6+4QMwyNdx/GyO1ZqMjt0Mt0kQX52dcfYUg6Ka2xmKjw9l/IjJp6QEhqIS+e?=
 =?us-ascii?Q?6ZYPkCaFaZUgfLWuHlA63asxCa0P4LWbulADrwIUbPF4OXLvDd5NoZA4hsSG?=
 =?us-ascii?Q?d9Q3bZ4ni/wt/uMSFMJfUrXNUiRWkGFxLr5q7QdfTMO7dA/n2HzTHsyfjek5?=
 =?us-ascii?Q?0aELCsFvbWKFVntOBEYcsA5RNW5eD1qFKTzoGVczY5d4KYRruQW00b6aURHq?=
 =?us-ascii?Q?8mOINSsYOEnIdjhGxmHi9Qz6TYgN8Cgbc9pkNDpcYieHaOuzhjPGwUKgcQiC?=
 =?us-ascii?Q?x70/LoAMPYzMFnQ50K5w3E+WppgHc6Vx7Mr3ZQn5SXiUHlp72dLOSTx3hKiW?=
 =?us-ascii?Q?G7e7jW/usD6VdUNY/CQ9fRKlt73AfbKm1hqkLH5D8IKd1Xxajwzjk9qhVNGI?=
 =?us-ascii?Q?SaAHtGbKskqWMLnJk8LqvU9DWl0OtKTL7b9VQOblyLUrdSiZpIs/t3XhlH4Y?=
 =?us-ascii?Q?uEgrPNYHxGfyIaWXMOTDuT30rYi0IEhRyPPRlpmpkyOFzCVdAo27kCWkvCKH?=
 =?us-ascii?Q?TXlHL9+zz/iQ2HHhNRbp2p8zKQg1S63nbaeHkgkyV7YmdAAUgWyP4Zi16i/k?=
 =?us-ascii?Q?q/FQEPdlHaEe1Jv1lQN2hBFn4cLjyMX4KkIqbB7+d/O4zYj5lrBamxOtMy4X?=
 =?us-ascii?Q?aBdIklzOeVfDU6eXOJFi7Qq5lN8yx/+J/eZHHChEKZKFL/oE7W3CAvakNZab?=
 =?us-ascii?Q?h2HrUxw9oGuG07/Yiid4TfdGrUxAfxOQRWMgzLUHIFdeyW7xQVHCJaF98R/a?=
 =?us-ascii?Q?U+r4vjGIpsHmj4BR0QT9hIfO9Ulh8pAa0HtWJNs?=
x-microsoft-antispam-prvs: <SN6PR04MB3919490F87DA850158684EBB867D0@SN6PR04MB3919.namprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(26005)(106356001)(74316002)(25786009)(14454004)(14444005)(105586002)(186003)(53936002)(2171002)(4326008)(86362001)(102836004)(55016002)(229853002)(6436002)(7736002)(66066001)(6506007)(305945005)(53546011)(316002)(256004)(9686003)(33656002)(71190400001)(71200400001)(2906002)(3846002)(54906003)(97736004)(478600001)(476003)(6116002)(99286004)(6246003)(93886005)(7696005)(486006)(81156014)(81166006)(8676002)(5660300002)(8936002)(68736007)(446003)(76176011)(72206003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3919;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W851E8vRxA8TNn4yxhDuuvTneScXoVsYpZZgv3BO9VTILxXA6Kn5NKb2YdYKgCvdiXrE6MNP8F2APVxL8KYLIYjP9c1luraS9GOgmhlZUlTamFF6WA33Ep/StAkPorHsAVHxRRSuf48/3GqhNY+rmSFxvikVEwnwAAQ4Q0Qu78X53/AxwfWcCYqMAo5hSV+ePoyedAuaI8liuMJ2l+qjwtHu4tQy5VwjtVRcrqG2A9Vw57y65A/rUPiMPs3R1iMkXelt8inTb/o2zD6JTX7sDgfvst4Cn255brsv/qPcrFyxCCh2tyM5f0OPO0X4mJZa++SJEMDLE+2z1tKmoxIGbHK+Oq/PtNVNB0ZryreSYBvs/Ls4jo/mlTLBjqynGGAvCRj2kgQ+IqNxDDOQ8IxwCoUUVZuztdlBKNYTyL/jtvM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a5d82b-cdcb-49bc-ac30-08d696d36831
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 01:33:24.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3919
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We deliberately check the generation counter to make sure discovery=0A=
code path is working as expected. The other text match is hardcoded=0A=
as per the cli, I sent out the tentative fixes so we can move forward.=0A=
=0A=
=0A=
I'll send another series to get rid of the all possible text based=0A=
comparisons so that we can avoid this scenario.=0A=
=0A=
On 2/15/19 9:32 AM, Keith Busch wrote:=0A=
> On Thu, Feb 14, 2019 at 10:02:02PM -0500, Theodore Y. Ts'o wrote:=0A=
>>> My (undocumented) rule of thumb has been that blktests shouldn't assume=
=0A=
>>> anything newer than whatever ships on Debian oldstable. I can document=
=0A=
>>> that requirement.=0A=
>>=0A=
>> That's definitely not true for the nvme tests; the nvme-cli from=0A=
>> Debian stable is *not* sufficient.  This is why I've started building=0A=
>> nvme-cli as part of the test appliance in xfstests-bld.  I'm now=0A=
>> somewhat suspicious that there are problems because using the latest=0A=
>> HEAD of the nvme-cli git tree may have had messages printed to=0A=
>> standard out that is subtly different from the version of nvme-cli=0A=
>> that was used to develop some of the nvme tests.=0A=
> =0A=
> It does appear some expected output has hard coded values that are not=0A=
> fixed. Some of the failures are assuming an auto-incrementing generation=
=0A=
> number will always be 1, but that should just be a wildcard match.=0A=
> =0A=
=0A=
