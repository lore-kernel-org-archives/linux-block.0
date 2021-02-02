Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFDCC4332B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2502B64E06
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBBLGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:06:33 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26831 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBBLGT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 06:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612263979; x=1643799979;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZJV2BQh+Of1qgPOGj8tNsRvLPU7L8cb51HIyejEa9ok=;
  b=jJhJYCKHUhLkk9fE8os1pUabzRtGEixFPVNufR/91idg3sIrn8nj/IE5
   6aQv2fZVj7M6BTfKCrDxJq8XCHod//uWSvaGNsIFlUODc0oQjBfqv5NDW
   +uc+cZgNhkuGgsMJvQa5683zG38oaK+LoGwOMDiojdehsS/7NiMHIrVol
   b30bg2w/RWGLEoS4ui4TMFrqqkHi/TV+pAKm4l6CXS1RO5te5Z+tdih84
   x1jgpOBhYl8oQ57igT80oB41MH80Uv+ORElzE1uEoi0ML/LdLGnkJopcl
   ryEiiyKRrHtZJbK9oHckb5oMkoQPD60dssID7oyvH6lWboakVsE2Fh/VY
   w==;
IronPort-SDR: QMvuv2PrEcWMU/XYE6aHDp5aPs1R2cZXFYxJeKZ22diORAvC1YUUYxOtHblKYv/FHwemzc+mOS
 m7BDcqTekxG7kJLMfGQwqhae7M9eo+3PkYn2Vtf37H8hnanf/HKfS0rIQCJQrqvtM6ZnseZZ3g
 6xYOOXf/uhnFO1zvpus+z8g82MjNLNp4KnIFWNNspbYji1h7EO2DkJL0C1y1brknDAiN3WvcSK
 ND3Xq614vVYtGz+hCQXr1F7ugtzHaTNhVkGypTQ8QcP6JzYqpW5v0sdGkQObcDl54SRJB2kngd
 e/Y=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163358779"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:05:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5sTpRxYDeqGIJ17aq3b/o8F1TZCfNyzso59aRaW+JTdTygPQz0XWt3aJEoB80GV+LEdqVCoGwiIwacezxbKkV2tq8JMkoV81iF/kZvgFI2RplYnfjaJe8+/KY9XiHFA9KV8vt6H72jkZyBYE5bJ75nLY1imPY+YwJriXh+oFOzDbzEmpuUJWBbU3Bsf7p0jZJPyB8WXpUh01ILKy74Lfuub8qI13yOoquE71K0V9gFwtgDjDwYcA9eBvDY1VGT/z3zGl2o9SCH3YbjRgiRUM6QIqSmi1ZL+9EE84cfwEMu5QgvEQ5fzvl7GR+2S5KP6sLsMX/hggAWpnI7AVM2hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJV2BQh+Of1qgPOGj8tNsRvLPU7L8cb51HIyejEa9ok=;
 b=R+/fI7HLY1fp6qm9W7vr1ZjY5qJ6h/ouGqzFRYeLwknnI9Sm+BR0nXo/6YHh5BO8Kw6k0YEIHKXrsOaNDMlAhY6tp/n0cr79ekHwdGzufGUPO2hztgG7sCt2WBOn6x5OGK8yNqZEWlpXlb9vS2qqBRdarSHO4liSevGlfmew6WhUskocNeYLYKbRNtkerO/1nu1CWI2tNbSRGHIhG2e48TjHbhzaWEU4zqsGcynqHJFs8TakKOZfy68mYprxctKBf7UG22nnj64Zk9bSRJ+0fHDnJk7PMlbd+kJhCT0+vgX62hS7HKIZZh5BCx+nH53JfF7uqhuAWduss7AWhMlz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJV2BQh+Of1qgPOGj8tNsRvLPU7L8cb51HIyejEa9ok=;
 b=NyK2UHiPR18gjqUfOmRsErZXcj6Hl62GtPWNDucVkcLFhWdSxmt8vVopk7Pnk57M8lI2+WAWy6F4UCL+OG5zU0yc0p+0S3ftwvpQeqwLjki/lu0Jq9r0yg4EHXD+nZwavuV/1Z8/rVvdTt5ONp6Q5IiQFbLJLPiYz3Kb1Ra4o9w=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3886.namprd04.prod.outlook.com
 (2603:10b6:805:44::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 11:05:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:05:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 05/20] loop: use snprintf for XXX_show()
Thread-Topic: [RFC PATCH 05/20] loop: use snprintf for XXX_show()
Thread-Index: AQHW+SXRzAJVVYshqE2xAh4KV9k1Qg==
Date:   Tue, 2 Feb 2021 11:05:07 +0000
Message-ID: <SN4PR0401MB3598CDD73D7AEBD1D7CF72AC9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a19bad2-7c2e-41cd-99b8-08d8c76a66e9
x-ms-traffictypediagnostic: SN6PR04MB3886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB388618A6FF7A7756D9A843D29BB59@SN6PR04MB3886.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODjkZ5dGHI/grXNNodtX1+tkqR3yy/jJv2rh5TWDoALS31J8F0ZMeTRoExVSZPAkSMiRorxOvUvHkSvxVnqN0V31arC6x/XHEb09finUmESRV+YbIeMkBNgYqHh2GvI+mTN6sfvidLgxCtjwS3MDerZWt7haq7S89NOYUSWmxzPubVYhyQOytUcFGusBaQ3ZTD86Ld26QcQcUQ0FHVsyUkF1JMlE7WqQlp0MyA7KRNXIlwtTO7W6Gqe6NNVlh0WDin1X1p/OyWIi+v9aB3EZRxAlOGO6XDMDbStz1ON6GSYPaaHldXruBe/s3x6Vvxnz92Z6KZw9SOH793MNdB+Z7T8TRkoljCrjnUNWyeZvRqx3bA75sAzlKFjYhj5kyoC1eIbM5cWtEtgDE96fjPzrjunITgqgIW2i2NIUQldpE/x+lHeXQn0qMsTv7k1SBFmwo34z+E9kLGej5pfI22t6KSMohRK0li2FviatXuyek0E5FlIo2Qua8SiOtI0xScLpZ/1cU0imGymNXtxt8h0EKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(33656002)(66556008)(64756008)(558084003)(316002)(8936002)(66946007)(110136005)(52536014)(66476007)(71200400001)(55016002)(91956017)(66446008)(7696005)(9686003)(4326008)(76116006)(5660300002)(478600001)(186003)(53546011)(6506007)(83380400001)(86362001)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?g/PpKz6G4PiNzS6ZPWX4yK8RyBjbcY2CzEpn4M9InVpGWkObXEAArv3gIrp2?=
 =?us-ascii?Q?YP4ND8RvnZPMHvvKyOQr0QQrHjt2+XzlquboQ4OXUrQIvmIXDqfBUpNaMXci?=
 =?us-ascii?Q?xxvgVOUjqRZuKWgZNjukp2YZSvtaR+j7vjiWtydqJOOFbNLGSxvYKQOsr6GG?=
 =?us-ascii?Q?wYM/nMus+TZixbWHzwebXEOC9yXUdmMnXx8UtGEYiGqcFr/ySHT643HFdfQD?=
 =?us-ascii?Q?54RbOq05K9NYfuLCavnSIM8BiDGLMqomxUjzPLp9+R8KWRf3AhPoioUl5W1E?=
 =?us-ascii?Q?jFCxu3I+dNEL2UuXavm+VYCFh2GsKiGS/ffHX3Amre7qbIf6NWPAbuPvIcsn?=
 =?us-ascii?Q?3i6qegs6ihxdTSq91Fcr2UTENta1yYdunWZpJ7swI6e/9qfMTfUNX+nw6vQP?=
 =?us-ascii?Q?347cXUVatELMeTpeoFO9wTY5mtLcnR2X2QYrd0s0ZJQnpY70OAtEkl+PNrH7?=
 =?us-ascii?Q?8T6InyNLeoUhxGV2GZRbM1oAXrCprwOKHJPbBLS8XpqlEZmrQM1DT1us11SB?=
 =?us-ascii?Q?SFltyQbrE2BsOxka/ZtYP/EHzJh8elJTXSQYZLp6/ds740JRvOHMTfADa1iK?=
 =?us-ascii?Q?IHpWCxT5QS+k73r3aacVpxzGFGXeqAftBCPbY6Nh226maJ6fYWrHAKuusdiv?=
 =?us-ascii?Q?tt1YvqYvT8bJLJLO6WBzbzEUFDMhZSnJKWNer0sCvrcCmFKzBB4Tjf83Mzle?=
 =?us-ascii?Q?QnPYhyKfyWf3YE40aStjv7d4TLGf3sLugrWFnDFh5A96G4Ol8Z//TOJKCkSW?=
 =?us-ascii?Q?LgdnEyahKsmYDz9anneQMeiQbu0EGtjxzX/Yk3ZTaMU7TjHvWh0XV4/ZKKvP?=
 =?us-ascii?Q?M0h7DWBeK5PK6AK4DDP2cKcuetbeob3Vxr9NlHkjIqrPGAInBbIafL/shBQQ?=
 =?us-ascii?Q?cbrpCV6yR4LKZRkP5CP3zSpcoJQaDcDxDjZg8ButPnIqLOpLTK3i8NKbGEaZ?=
 =?us-ascii?Q?kOO71nJJ8flNDTrMG3Vt3p66L2OEVZQxpi3iTWspdiKnZADDfHLZxWULN0Dl?=
 =?us-ascii?Q?0AFPLQyMzC1xX7YAyTeTib5WVmu/IDX2IwqPNd8+UvBj8bIlWObHzF5FCA2j?=
 =?us-ascii?Q?uwCaf3e4fMgVpYTWa3vEyn3l41TvLtifv+GOSUvJFZl4ou00t843t1mr0BUM?=
 =?us-ascii?Q?VwTZeo69DRztccF31uh8ipaaT+Di69a7Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a19bad2-7c2e-41cd-99b8-08d8c76a66e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:05:07.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwG6YKR3ldnaAndOzj8L87nsB3T0mLpTSdPFQ0rfHTjMRvzW/u+bPQ5EIanimxp66pn9VMHGnnsw+F10yIGLPNCZbbqRn0lR+2uoBPu0PIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3886
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/02/2021 06:39, Chaitanya Kulkarni wrote:=0A=
> Use snprintf() over sprintf() which allows us to limit the target=0A=
> buffer size.=0A=
=0A=
Why not sysfs_emit()?=0A=
