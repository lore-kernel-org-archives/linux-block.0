Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6FFC433ED
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB36061181
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 21:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhDIVF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 17:05:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23935 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDIVF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 17:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618002342; x=1649538342;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=m+OzlR8a7Bhy0iScniw5yn71i5a2X+ld8zYLpHW2l3g=;
  b=o7eiyb9UhEJm4CsZZgOyn0NJkd7gviLrGl167V9ZnRPPISnZ91HapgtZ
   Nc4HqpdAF6YcQo06XaD0AU+50Gpcotzr3cS9R3Qza2u5DEoc83St8lj4I
   GNxP1ENvvUp/+FshSTFjttVjKl+1KovaNCpLZT+9FOmPJ9iHE7BI1a1wE
   T2j3mjCl/X+QtonH7l7IEsnfOvdimAiUf3dWwHoGbkSOHXw0YXx3okjXZ
   NMGHnXSPyS23/l8hfP3B/HVYtK2Ma1vOBJMBKbhmMtfS3gdbTLCMXBrCf
   JYkog63LSryTDHiM/WvyDj6nxjmIzopvjRYO+Uvni1GBamMZF7Bn4q+vc
   A==;
IronPort-SDR: BzPRSZTXrEn9D6xV2UzezBWkRigIoatoACXl65s76hPZ+tGGEm/tA6XF4UuEi9auw0kSGIxdoc
 XYX91HXQ8nNZunqr8C7EaFU8/FzfrjLCit18qsbIXWVxymJubzsKi27tNej5RQGUH/akzC6FLJ
 bUCa9DdrdqS4kpBiOvrPNR7ONrwy97TlX+AIaUtra1CCHcMG+gF3DSK8gZ/iHIa+dostwTcQKR
 QpdTO1ljAYtMnF4jQMMdLJ1m654v+viWXOrc4ARQmnBvXZ0e2pkL7K3PbA2KgX4+3L1sOCi1Pm
 nVo=
X-IronPort-AV: E=Sophos;i="5.82,210,1613404800"; 
   d="scan'208";a="168838965"
Received: from mail-mw2nam08lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2021 05:05:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr4Ws3KOzHhdKzGwHy+ZCNk3hL0uWGs/7EsE4EKsBX5SkM0cj9mO27DyQgJ5tDClwrhTsp1clxQ026Oiz4VBQIYh/2dKqGK5pSx0SI4eI203UkHAgoc3BOlmYxzNyjib0gBLoLICGY3BeDYJ/y83JGoR4M6f6fxjdzLclEmF0Zurv50yU7C0QHRoEQcPpqQirKKOsKQRAaP1g6cbGeHua4LDg9ItCB2w3BNiHoeh02s8qIHb+S3wT6nlk6gMqswVC3zSX152MgBdF98uTWRDtVsRb6TYBDB6kftcMOXRQlU2HdLgcJFdVhbfJVSncpCPcO7esp17tZwKBzb5Dt+eGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+OzlR8a7Bhy0iScniw5yn71i5a2X+ld8zYLpHW2l3g=;
 b=gtaSB1qlpbAgQ/NG1QbF8AFa1vor//Xf7RMWc+yDNcaVZ/ilyyRw/eCsbkvwzqKwDY0yWBPEPzExaeQdu12w2Dht5gbwjXONXHkP12nBnCZKV/QdoAIH8VKXpd2i6o8QdOd+sAXC8C92k6styoYmB9W+QMQ76PZHZXuOinr+WMFhlXu8TXhi5vW+qu8Au2fqqp86LbIDWCLMVNepyRZaHT7HvACbscRiMn6OBXvSpLe31K/qQfft9MtW6/m420iUDEVjmSzB6Tf98JOMsh25KI1TtBG1aEsgKYUs9ihqsn+kWzMyCwuQ8vdUX7Xny4FEZC9WAm0PfDBP/vWXUcUOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+OzlR8a7Bhy0iScniw5yn71i5a2X+ld8zYLpHW2l3g=;
 b=tChoEnvDJ5egthuJtPAzDVQhcwGLVstXND8CCitwQBceQRsCu9bvzgLKE6FFLfnvcUzhtsSusP45HGvzsd1Mbev2DJJkDdVHLLsmBt1WF0uIXmLOXsDhtDdh9qRH0qk3ZukHuUWKWhEU51EQnuedbEQra+A1YpzEmfjoQZfVEHw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4983.namprd04.prod.outlook.com (2603:10b6:a03:41::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 21:05:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 21:05:41 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] block: remove an incorrect check from blk_rq_append_bio
Thread-Topic: [PATCH] block: remove an incorrect check from blk_rq_append_bio
Thread-Index: AQHXLVIhnbAUCrjeUEWRiLlw2HVagA==
Date:   Fri, 9 Apr 2021 21:05:41 +0000
Message-ID: <BYAPR04MB49650B2BA566ADC01F4323BE86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210409150447.1977410-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3791c23-0bed-4c1d-6562-08d8fb9b3bc2
x-ms-traffictypediagnostic: BYAPR04MB4983:
x-microsoft-antispam-prvs: <BYAPR04MB4983642E637ABDE17099D4CF86739@BYAPR04MB4983.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdJeKza3SDG3WLZ3Q5C2OPenHKbnzRjo6AGbR0HqT/0fkwO4U/Y6j2aN2chLa6BRWPDFGNSRoyzZeM7C60c1bmbAmsHFQ96vVXDBfh8LDFT882wvaqWPIc6co4dQw/2uUT525JFXQ9NDGZYYtv48xxkPlS1/B0+NxmOlX5VpSfgRXNeKZJeMoa3PQ1CCPT8lNp3h90XDFH4TlGU49C8coz6eHr7sbUWUczJiQIKrxMng0IT87v3OUnkb39jbxQzf4CUVOP/AtNcfsTjo/hVALZm0Qrr4R516JTDdLnSVwUB9J6epTJe4qjy4Q6QBaS8vxjxRNM614zJaPndj9qsDp4O+zrt3hkr51IuGUsOqsowDwHFL5KH2ZIO1K4gs4zD2tMUWd6HT+wt2to4W4qbf84dkkBv04iYLTPjyn5O6HB8/Vi5WQAKpN6R5YirR+Dh4FBWA7EXcFwUPMnMiMC3HlWQ38tQTeBZI7aXmuBQ6O8g6UjhqsgD1bfsUAtbQm5xmc3udgJwYwzHNSnakApPLuq9CVNjLvZrwSBTEBEYZIqC117AGMkspqn9Z9wIeM/4OujCEeyBsxvj/KQ68XC6wFNmmGbrOHaJItWDO74wLtJJYEV0xCas2CoOvoQsIDGxWgU/+gvLBdIl5VRn4OpmGvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(8676002)(33656002)(76116006)(66476007)(55016002)(66946007)(4744005)(64756008)(66446008)(186003)(2906002)(66556008)(38100700001)(478600001)(83380400001)(53546011)(110136005)(8936002)(52536014)(7696005)(6506007)(4326008)(5660300002)(54906003)(9686003)(71200400001)(86362001)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Kf1hoi/IlpDphvn5AYCO0Qo/sLonso7d7uzWugk0CiY/COpnFLD7dD86vnV9?=
 =?us-ascii?Q?oTm0zKaTa07DpmiHF8TrgCd/WousV+xxrsWeWD8ZNbMZdvZXPVbrwQGkxk6e?=
 =?us-ascii?Q?5XNgh8pUt2vMDllN8ZOhdlv90LvyQki3ESSlL50g6tJ6s9/5QqmKSFf/gsVc?=
 =?us-ascii?Q?fnYth2bfjp3jgK2YalhBLmQgjjpLyCHVQC/uLepbE+STmdQcrIBo+PeQ8eSV?=
 =?us-ascii?Q?8dKIOpYFCxMx8+41MWpUI2kC7a672aw5MH4tZjzlTPBW82qs3nCBHQoWBGAk?=
 =?us-ascii?Q?UNBlaNTN/EkTxhg57nEVTQO3NVXDwHi4g9XRWd4fNxft2bFZH1Ts/RnbOn39?=
 =?us-ascii?Q?PBx/Os1BCs7lJWtJDjS6YBAImIPsn0H87E1a/Q06EoRsXqyozLnBNDRkU37P?=
 =?us-ascii?Q?nk704+w9BfWU3CqquT9+hKRykViHmrVX/ahohGSPfjsvw2UDAV9OdDl8uy1D?=
 =?us-ascii?Q?aX6S+T3klpvUW/eBR/zvk8kXAxyvr58eELhKat5KctYXq221+9KtR/pam3oy?=
 =?us-ascii?Q?5SGaqqEZKfxjngI+i/3SijkWehLusU41m2SJKfi0uLCb5MWnOGZbkLcQg/Mi?=
 =?us-ascii?Q?+8w6ckRSzIsaLOsH25+Bg2NvhnCby5rH0htpq2RIKGkBV0VfKZFyzz3cSpH8?=
 =?us-ascii?Q?IHmqUb8BlNFYzUa1yZvcUn9fdgZtOpzbacegSuZImLpEz3pV881tYLgLwvQu?=
 =?us-ascii?Q?d7N8ly0yXRTQluKKgtNBN3QprHyIUV3fqzs0pQ/ZUxsV9yxdjIMBU7uRKEms?=
 =?us-ascii?Q?rfmdg6YIXPd34CcpHdvcblJ9fjqd2/+l5XqkD0VEywwLL7wvpIJNWlJSKq9e?=
 =?us-ascii?Q?EoqBp8cxBAY5REO18kzZ4BS/kC08ouTBOFrzeADlQILKOtU/oBnEnAlRGgba?=
 =?us-ascii?Q?OhNViJpRRmQaAL9LRmSwe/6DNoFgkEDFtQdZtDsivy3f3oMbVlc+qBqmSBx2?=
 =?us-ascii?Q?IoU0fkDK6MmuJohQFNsnP/YyIQvwHhQfruk2Oxl694DH1GTu50zNNcAmVvaH?=
 =?us-ascii?Q?ufiM3XChEDYe/fMM5i3nwiWbSzUm9i96Q8WxymLR3YhS+N7VQKh8D8+UqkAo?=
 =?us-ascii?Q?EXI/SFQQkx2nYNGYFNWnWWpQF5iZobfBVpB8o+/dwnr+lnjMf3QUkPVH8Qmy?=
 =?us-ascii?Q?omRfDh7eyLqrDwHSm5y1FJ8+MLXpsqTUmy6WYL86kBFlmvH359+25Zct8bGa?=
 =?us-ascii?Q?BpEdySPiDi5JM7LgzTrsTx4+t3YgbmPfgT9a8T7DKQEb1KC0BQRbHTbAhleI?=
 =?us-ascii?Q?1zm7dFEkje3O5fBTSJRuX97XVluo8TC9+TaCMdLQQBAEKQNXytiRbu/U3cYQ?=
 =?us-ascii?Q?Aofis3Yn5AZa44pvu/+voXpX5I3p+AdWJkr0Ewly+b/GXg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3791c23-0bed-4c1d-6562-08d8fb9b3bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 21:05:41.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQbBSSzU9V0QMaKfjV1FgyvXoSl6aDwRyCRgs/l3Z0U2K7X33uAJgm/z4QmAGN6UZpL7iQLcU/mX0QqCFr6a0TjfxMrgzQrxtClhS1KQOuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4983
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/21 08:08, Christoph Hellwig wrote:=0A=
> blk_rq_append_bio is also used for the copy case, not just the map case,=
=0A=
> so tis debug check is not correct.=0A=
>=0A=
> Fixes: 393bb12e0058 ("block: stop calling blk_queue_bounce for passthroug=
h requests")=0A=
> Reported-by: Guenter Roeck <linux@roeck-us.net>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> Tested-by: Guenter Roeck <linux@roeck-us.net>=0A=
=0A=
With 's/tis/this/' can be done at the time of applying patch.=0A=
=0A=
The commit 393bb12e0058 does add check in question here.=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
