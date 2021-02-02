Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC23DC433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A643B64EC5
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBBL4c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:56:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15245 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBBL4a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 06:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612266988; x=1643802988;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=YPaaTDEJlIprh34evxsvAT9LFqSHk/z0NIIWJbnrcIrpBwbrymWsEOSs
   EaCP1LdffZByB+Ou6afe4TogwagAGf82irSZCzdNj7qXpYr/fc5hHWYQQ
   PjI6HcMYxNVksTWzcM90nBB3pRXoh/HzuWx2dUhC+nsE7G5pU0ogxpTTn
   hLMKYc0R70jhaMpMQVohPygfi/n7lfpQ3FiURBbtiZQzJwlhjwFFq80Un
   XFy7iehfpBgZ1Fr5b9rK4G9pSRGthO8p81rH2aR69jF7BGz3yZXdatnUd
   rfmwp8V17ryAHBChd3M5DhgUnDnPCIpObP8VzOmQq9hX6t/87+AGBNsze
   Q==;
IronPort-SDR: KCtI3gnewJJYZnROBSOTXFILcUIE9I0rywMGnGpkTxQFSiTZbUeIVGHQJd+Ughzi8Bp4skp2vh
 LwkB9tsm5Ena0MNCPq2ogqEQERx+Q5MM+kMOO5yP2ra+sle5TrPUt74aAp7WjuKONSW3Dda0Lt
 zLWDQQ8Nv8MtZNUAiAiQy1S9fjr0LA4v6f1JWZUZsAUAprWxAdxxkdQ8qipchcRzxzqT8IJEhF
 CYOArV0lqWgXgyzd4dUNQZ89fYHALWiE/i2Dg8ztLdHlf/2Dzg/kj6+/qO7c2frpG24DyFbhn3
 sMU=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163361824"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:55:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkxPxgoQz6ttdT5NreCJIMeRO++q4mwWG6vOxlUe9NmByFHqMLp+ksoWdma22WZTYS4jFB/Ztsjs8ltEfFwbwO1tno0KvDVu0r3RO+fRB4kzAyuubaiaW4DxhqmpZCZ8WceWVET9sP7Dr1dqL7PttNJHdKdCwY/PagATe5P4Kv2+vIJLFxA6iINoAFIDjKkhPI2p57aGjPkhrq9Ft2/OfyuGmqqxU6fl6npH9nfPCLib5du7EJuoL8vmpVof6dlEKvja38LOJFS0/2YNVEMKe4F/6V8BNTJfjVKPKTXggDnGwMmOndyC10j2L3GKRGOLZQUd5NOmTvVLLa1r1So2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HIL3Nqa/tB8ebMJiJxGY3LZENgQ8KnTw8lyGiEIWtcwP49jkAtyUqqVJv9ICovkEVG8Xg504IN6+mhoEi851VWCENR9f6p2yVpS2yBnjAhc5XMWHFh9JBsRelIqRJA7QZlYCUSFMydRfABJcOCkrWTCbh9YDdeLNn99cKpTOhI3QAtKbCLhenWEmGOIwT5QSEB63zjWZ2Yd/uahl8+4nJFQYH4cd04g1h0l3SHYrTbSRfqaT9hfdO9twErK+H7AajkBfrZHl0C43Y8XtP3v53jD3V8YA7wn186rxXDAq1RR0a8pTB4zK9FNhjEPE9rusNalDCTignT4jYpV+uVQlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=o3j8WIesWWxQeyd3KLKdOeBf8e+IymO01JQIw91oYKsMvG3salB/toutPHGqGVHPl1VLmgezo4HDMIucSTlPFnaJES/kRqGmhME8OPK9eyfQNwBzNJZFa6my7FeVsktz0Yx0UEDEtyoAfUK09YAl/iVvc7cvu39EU4iIMJRh+6w=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7593.namprd04.prod.outlook.com
 (2603:10b6:806:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Tue, 2 Feb
 2021 11:55:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:55:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 14/20] loop: remove memset in info64 from compat
Thread-Topic: [RFC PATCH 14/20] loop: remove memset in info64 from compat
Thread-Index: AQHW+SXW8L1MHcNODki4BM//xd6x3A==
Date:   Tue, 2 Feb 2021 11:55:46 +0000
Message-ID: <SN4PR0401MB3598049EF36985BA19D43A0A9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-15-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18bf5f9b-8166-4429-96d3-08d8c7717a50
x-ms-traffictypediagnostic: SA2PR04MB7593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB7593F3AF3051C6AD2AF67C159BB59@SA2PR04MB7593.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeLhCxW/fkZXY48bikAohLOJOQGOoT065jnbCBBEexIR4OcV6OhG7Do8PBLqlZ0pX1Gk8a3aeetSOpw6a+GXuz8X8lGuV31+ZHRq6paY+MkHVETIFCPSQRDEqAhIf1cKGW1GL/2QsGH7TIuR2V+qr9+ynjLAP+uSu1Th80wqDECfOVGSaLISlPhnUA3M/AzTn6FtB55+2eas2NYp7+WTXz9eG9Rg1FPYEX3Q+GqfTHDqvymAEeTPxBeroFr+YO2gSuCY/09Xr+Qzs4lAPZ/QNYrO+rASm2kebMMKmsdkpZDrRHuoJmx4vdzBKApHk7OvBOiFN2xYXr6RXl6OmJLfI2P+fKxIlBMCanFmstVqPzL5r8RMZghtu7MVhwVsv2tOHvZWljdjG3XNN6qCnoMzkLJ1S8wpQ8GYMWY23IV7DoEeec0RrrzeJKV0Z1Uhg5xdbgxCEtAVyJnec2sstIVEUAX8Tp5doncUlGFsTHABbAtj6TDmi0CS+VYmDqzSK9JFN9fy1bM90bwjUFQ4V9UI9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(76116006)(55016002)(71200400001)(6506007)(4270600006)(316002)(7696005)(478600001)(5660300002)(86362001)(110136005)(186003)(8676002)(91956017)(9686003)(4326008)(33656002)(2906002)(52536014)(558084003)(66946007)(8936002)(19618925003)(64756008)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AYFeHvtRgsYd1QrW1n+4jiHnvWmSEmWWTZcvkHhKjPZxi4oNBM6j3fs+0ipH?=
 =?us-ascii?Q?2sKZgt2LSa5TxUz4ZzKPNLIAweb22skXuZx90b7pZtnTV9O1Qk1oVhmLm5np?=
 =?us-ascii?Q?dLnRKsBn8wsoL7EcFmKL5PqWZGF8NMdNcNL2WfZ6rvE2ZsU8o5CU8UpJhqRD?=
 =?us-ascii?Q?aOQHdbCq0aEAON+ujF8N0xeLYUE/Ek2yK34cZornZCG1wCwotYxnZDKrlCtv?=
 =?us-ascii?Q?mJDaaK8Tlr8kMhhlXg0rCdXR9aACnueYidLrW44VPaxv/Yt5DafLlXTvcyjS?=
 =?us-ascii?Q?17Ms0vkdPgIkb5QFACKktq3rDMLDFjW3UFFxNxoKqqVldOfLrgjpVdXt7aY9?=
 =?us-ascii?Q?eqVoxBquLfsdfJ3Ek0rsxoCXNILSTWVZhULnhPNP+A/HCTYZIdCK8NR3gxKk?=
 =?us-ascii?Q?ZBQzVMbJ94w1r/cuBgXoxaRkBkTvmNiP2dKy93e5MMi95nq1b/MK5T6Dh8sN?=
 =?us-ascii?Q?u7Cge2zEEs1CqhNp7fyUwKKE56xacugIGaN05R+3eKz9/lCdrKDlHbdgEZfU?=
 =?us-ascii?Q?HovjdbuJr0OmXm27WbDH3puvbU9vA3HrXrcAAGQDXNniRHfOxbk2fSd8Qkdh?=
 =?us-ascii?Q?yQwkbfWrq7AMYlk3Y0tdlVisdRAmxVycVc8J70CXzESrc5u9Korpn36ZZoFy?=
 =?us-ascii?Q?Pcl9/kE9A5lnHmr4KNab+NNPu5zucQx7DQfxQt4ouBwfzHLHiUQvQ+3byQ/p?=
 =?us-ascii?Q?j+2xrFep18LuG2pZgn5lrn0NjQbzX9aCGpCgjm42vI08oosz0RhwM9svej4a?=
 =?us-ascii?Q?zy/K5tGFY+qYaaEsg35qqwcbE1bUmxtfywd114V0RW3WQAyLW96e3YZFNwl0?=
 =?us-ascii?Q?XprSxJza1Qkl+RhW1sOZ//XC7rQHjEBYleVaoV+oMxrgdiRY/KcpPiF3vN/u?=
 =?us-ascii?Q?zc/jwWQ/yD5+Hg4/kUB/yHP57gdPx4dL4IMsnjSCQPZLh3GcDCRktFStB5kl?=
 =?us-ascii?Q?bR0AtSOjW1ezyhoBlE9IeTlfhhmbhZqZbourVEcs81pUfQwOVA5eRMx+mOiN?=
 =?us-ascii?Q?hLBMcpLaLyl06WW8fJgcNHhvBzg9ZcIV5reR+LmAJXnHKXfBF9wwB+mWS1EW?=
 =?us-ascii?Q?8FlbvtSYf8xDxmjDkkoniXW7ekI+/Gf8mpkWcM0FZLQGnD8ayMwnMSXDhLo+?=
 =?us-ascii?Q?kbjGu0c95m4C7djvTSqbrdQ2io3Xou5AbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bf5f9b-8166-4429-96d3-08d8c7717a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:55:46.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLlDwmwPwBepQX+/4//Jy8aCjRX2NwJ9p3JwJGC8dfZo1RQk1B6Zm/3DzHSId4e5DDB/kS11mfxmfD/IZ4W40WXJTgrBNQjLIJA7FFV5KW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
