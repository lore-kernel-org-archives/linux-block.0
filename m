Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EF8C433DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 01:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B0564E83
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCRBtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 21:49:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38645 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCRBt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 21:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616032168; x=1647568168;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z40SsBKDJ2qhsLfMThl/4D/ihWJqcGeCUlyAwI2+vsE=;
  b=KSkb7du8DCUulvC2zgXGnZORg2z9NB/Wm7oJ1HdTAlZDooEsBLzMpKxv
   7aWwuJcJY+XTUj4TIgh+ahAmG6MNLjD4OBiLf+E0E7jwx/FAT53L5ePQ/
   KWaAk+P6h7VjeXf5JZ/JA4tuPnbw9I/tAPQNquVBcxH9NB9bC1KBobV4Z
   0lsOQx8LrKdWhV4PYRQ03IXiG91G6O+2OTtYDMDNbZE3uXnWQ0W1rudc9
   FdzUyhPXrSQ97o3wJSz7oAtSnnCujbXvVL1Ja8ynKQ+/EKLc4GycQfqWx
   yDEYztxqzMxoyCnMrYcSQ2Ugjb7r30N6lmSM2guPID+LbgWQq3Ot81v/u
   Q==;
IronPort-SDR: fjV/hKDSeEznqltAT74tzOgtcp3qLjWXk4lEZNPdJbrhl2rM1WR4eG5Q8EVXEEjcZfojNQKcRb
 lqHffjG1A+znIaBbY5N1BR9aflCVHud7Oz52uVJvS3LlhSzm/aRQcRwgOSfNBa2PtODDfF+XM4
 3PVhp54rvshIAgc/2ycSNxvFiCFZB2Vfi68WIqFV31SpV6QfGk2eFBljxUFfuwYN5eThvD+bmf
 nDrl0BuYI13lj2WnvPfcqIDUP4l3+z4IIYve9ljN868sqiiS5tOQk8cFN/C0tzm5+pP4fIQ24e
 AKc=
X-IronPort-AV: E=Sophos;i="5.81,257,1610380800"; 
   d="scan'208";a="162419653"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 09:49:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzFyMeCKFyl7gvXSTx6fHmHZmc+ow47osj0RAMChYiEtZbih1tEoj9a7PqAf9pt3BIdwW5OjbUUF55Q6pwHTO/SDf/HClIrzToJnPgQ02rII0u6hCisVgYGLKLPmGtOUFDXvngpiYRRqlFlAcy8alZu5ai7yJG+DrupkGtQdRiK1+fplzhOYy2PymbkOUNz5t2k+a5qkbGgEK45iT17m2DiiIS3Pxp2nvwEGk3c9hBuujK4rWPqYSAaFMSttM/uobu6V15WjSKu9YH/Zs2Y0rg46SjDTX5RsmdppjX/fv3wPn0rqdXPbZjyhkAizsQuqUItCzX3HmtMvfdbd5sBt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z40SsBKDJ2qhsLfMThl/4D/ihWJqcGeCUlyAwI2+vsE=;
 b=AtwUrpa39odKDE16geU2CiUmevM8r7Krql9UosfPuB+VirN/NsHNbl812waET+BaE4W+eI0syvoshOisy3ZsHxRAHaAKwyZyKwZBcF6zoqLQk0X/QAkqXy1sERARSGz/F+jTbOnxplIKiIj59bo69dStIzjxeQbx4YQqaSuxmkxr9696poC8/yn8QegNw3bkf8W5oFNoYLmjtw44DfMba4/8JzYpi1YO5STrKRe1sYBlNkvqqJlCsz4z38fO+qcutHiwBpyiLCnlBVsXuhLnpOu9x209smU1f/39gO0nhkC4Qb7l30Ctm879V9s/IS1dWlXZEgfJ18oHIu6X/UmowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z40SsBKDJ2qhsLfMThl/4D/ihWJqcGeCUlyAwI2+vsE=;
 b=PTxka1MRPgPcj26K/Nod8ZVrR3wtM6DgwiFCZQGGdoHrKV3gajtDVMCLss6gxdsQ1sIrbKyLnoa7jdlfrM0SJLjWchaq4WdbqQtsiQf740pv83mMdYfQKcY1muAOVgL5fFP114Q+lcrLSszMCYh+/prisnmUn8DBY1ykYrz5j98=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 01:49:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 01:49:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove RQF_ALLOCED
Thread-Topic: [PATCH] block: remove RQF_ALLOCED
Thread-Index: AQHXGv6d9crUfcZY0ki3ZcRzNz3YQQ==
Date:   Thu, 18 Mar 2021 01:49:27 +0000
Message-ID: <BYAPR04MB49658854C426A861991F85D886699@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210317072122.155380-1-hch@lst.de>
 <20210317134259.GA9958@lst.de>
 <BYAPR04MB496513686CC6B6560595880E86699@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ad61f06-c81c-4347-ce52-08d8e9b0107f
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB68844BE9C7479FF4EC449BBB86699@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HZx3GJXs1sxwWHvM+Fj8HtSkbjtrmX3a4JwNVcDj4pgN1tlL7QItlzt9PYl/4FJcgjgLmgYEu6D69/iSYzB6QhxYnhnOtfiK+qK30zgEgmoaUNZ06Pkj2PflTeRfSHTcu8BP+TzwF79tS+JHFtMJAQB0l+r0MrWEBGUiUIor195fcLR3q/jCv5ICluR+vpJvBee5WJQbDrgVlJstyvfOa5rv8uwyEuEiA3KjYvct07CvsoxomQunt9Bo1DQnCj5p/59d4g5wVvXKyWU9KhmxR7GrEdkTDX6kWb6z2mpQAF/Zhypy2RuYk4iRcejibOlpoTB8LvdSamtMsjA+WPbRTDfLTYElAW+3MOFk3MY8k7vTuxlmaUTITE5cwFZ1E2THRF2+Qkr/XR157Dc2rVvYvClheLXo3SeUDyIRfPOhVVVHZMuKI1Gk7HEsonLXkZ4rE/3syRA9oK8LViZgEyMaZ4ECuM28oeoBAHKWKlTONwNjp2bTyWD3FrN5Jedr4mEj4fyICwr0tTcKcUWvAo0QqHQSM1xX8c3/FEEZaW2WmBnlVvyscYfJKdwrGWPTZF8QI3anpzrXzQJtN1uo1FV9lwemzNx3qP2z67n2DlaE9QJrqqHX1/h4Xz7hxhq1YTd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(53546011)(66556008)(66946007)(4744005)(8676002)(9686003)(186003)(26005)(316002)(110136005)(2906002)(66446008)(64756008)(76116006)(8936002)(7696005)(66476007)(6506007)(4326008)(33656002)(52536014)(478600001)(71200400001)(86362001)(5660300002)(55016002)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q7j+bKs4T3/FvU2D9kE4NJwaoodGKcbyR3yuxjkeJPmqN7F+GDftZVKzG09g?=
 =?us-ascii?Q?5DakRXzr1PB+lmqNxcXkfobTgGAtHQH8zR7imb0rhhw+gmH55lsw5P+9VIkN?=
 =?us-ascii?Q?vFLd0zE9KSt+U3N2Mh4flPnaKr3jiPy5vSQnKzhQ92TJ3vNhdekYFkVf71Qu?=
 =?us-ascii?Q?Klw87AKqPDUs4h0j50PHTnlEFoFAeY2NL5QRifDEGP7s0Gwfq0v0RGiuDbAk?=
 =?us-ascii?Q?wQczblaS1x/gvTEPs8OQdvaxmWx7qL0ZhZdv8R3FPO//X67CLJk4WF7JKPcm?=
 =?us-ascii?Q?zfv73JdIpnXyls78n+52YXtL68vUezrUaT2/N+t4xi4rxTDlW3YYE5extzra?=
 =?us-ascii?Q?cNoM38Z3rjXLigec63s6ycBA8zklI65UnBKcunWMBZuLGOW76FtUlYETp7XQ?=
 =?us-ascii?Q?Q/E5hRJmCnU65E7OfxVItyrtCVLuImXXS5HGoFeizNv4FXS9jG/ABvRUVc9l?=
 =?us-ascii?Q?rPgidpbe5GytDau7/QzGO/nW+7vaealPFvLwyBUQ/d1LGyaowzLb2z8UkjCP?=
 =?us-ascii?Q?t2yxGIpyt5kPBZ7OvCnEltWRkAHnER3noEZQQSLFatrZz/RdwLAjMeF1C/Ki?=
 =?us-ascii?Q?gbpCyBui41smxXRBlwYDUbpFRJyi3GS4KM7D4Pz/5/2XvZkntmZMyMEWgDN6?=
 =?us-ascii?Q?N5wrad+WUOekrHRZp8PnhIaDHKryP/p5wcqZPE407qwHR+niHo0oKTmGP4Fp?=
 =?us-ascii?Q?X+ZD4gdFWPY6IKPyqNQshbqBgayd8nrssAz0X4MBhWALmUNcbjbmRnGjvvdY?=
 =?us-ascii?Q?fZ5qwNRTCNwmxp+Z72hxMvEKBwCATLvP4njOXrmGPTcSZyKoh0AlC3dYSIO4?=
 =?us-ascii?Q?y6tPurDHeoGyPgXVcoaIucscAg+t24BTAJiz3VTPBLLuf4jaqOtVVp5Phphz?=
 =?us-ascii?Q?dlxfwY02LcFmBmgfBif2QFNSQK5hyM1oihoMMfnzaa0v8cPvKyVwyeYmMWIC?=
 =?us-ascii?Q?WXybO6XyXWUIp/aGfwyTvbehLngZjpsvcXpseS0ZvgBwJR8JWx4i7HtAKwTu?=
 =?us-ascii?Q?Xu7jw2p23uzPreGUQBPffjnJ/fkl1Y+iByO4SpuzwAd49QP7pLJiLYLMZk/F?=
 =?us-ascii?Q?+jfYI4gsVu1Qr94OhQdjeFUZkXkDwj8IXyosFMpv13nPcbFB+C+ngAYfPM7J?=
 =?us-ascii?Q?uxd42u7PGLf8Z2SoevZfWpmWJ3DAV6C8voKMwZj3BNHb0VdJ+Ovhh/4+x5SW?=
 =?us-ascii?Q?nLGCpOs0Kgnecta+5kx3cJUbnakiLetWh3RNPYzSVqWzdDqFvF8WFgEG2Ghe?=
 =?us-ascii?Q?j7jdJypYpVGw9Px2WTAtUnePULVZHkjRbfaZFMuXfdZDELREt+P0m/T0ci29?=
 =?us-ascii?Q?hC/N3jvnpUxeto+zjnexLZwm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad61f06-c81c-4347-ce52-08d8e9b0107f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 01:49:27.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6ZgOryWGHJjxn42wavkp/eWCAxlu2m3G1bnS7ziD+B6E2zr69z6042yySEYLaHwWMI/Gh7AgAOphbkV2jb/+pRkU0vKjj0P/2xN6noO+QU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/21 18:18, Chaitanya Kulkarni wrote:=0A=
> On 3/17/21 06:43, Christoph Hellwig wrote:=0A=
>> On Wed, Mar 17, 2021 at 08:21:22AM +0100, Christoph Hellwig wrote:=0A=
>>> This flag is not used anywhere.=0A=
>> Except that blk-mq-debugfs prints it in a completely obsfucated way.=0A=
>> Sight, I'll need to fix that mess while I'm at it.=0A=
>>=0A=
> If you are going to fix this, does it makes sense to fix the rest of=0A=
> the obfuscation ? such as QUEUE_FLAGE_NAME/HCTX_FLAG_NAME/CMD_FLAG_NAME ?=
=0A=
>=0A=
>=0A=
>=0A=
=0A=
If so, I'd like to send a patch to remove obfuscation for blk_op_name[].=0A=
=0A=
Please let me know.=0A=
=0A=
=0A=
