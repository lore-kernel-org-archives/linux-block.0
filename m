Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC61C433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 02:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475DB2076D
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 02:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W1CyBsgi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LFY5LeFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgHaCr4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Aug 2020 22:47:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42829 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgHaCrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 22:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598842076; x=1630378076;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/11a8Td8yyguMpCjNUHWquVGQ3fbLksnSUo3DmyO0OE=;
  b=W1CyBsgil51/VEvKqnLuGWMs4z09cEyUHYNyVHh8O6e8Ou0elMKtSi78
   LbbFu+7KjT7RLTsfVFP6YrMA9Lzxh9TRhJkqSfAbW7BLv2vfV6fLrNdFp
   K4nkA/x7O6PZDztKvkzc/OjmF3SV2EQzKT0qnXW4jqGlQj0lldyHyjy3X
   DklgEc5lXeV/aHpGGOB4XYO6pI+xlrW5VWwaTf68V6sY/JSZ2+Ttfa4k8
   Sp+6BnsJEtxG3jngcRywgFXFUDqxMCzsGQHq05cpAt5cUztCbvSAA2zzK
   TRgPdh+qTuWYVxJlzwzmvcLu9b2dRRGRfKyh3u5e3ml3ftACm3uMQyj/W
   g==;
IronPort-SDR: MAwE8fjo+pWVM1/iw/HqL5inOa6AvG40vesk1FpLobyNIKGqtx7NzhF/qc41351YetOduBCZHT
 sNdmg7qs6SZcEySVbPMX2dlgx6MknjkASdN9ZoR0xMiEy6QMbs91cwAvBZQEJJGISoVZsTneEZ
 jh4+EQz61Q6m9GhXap0xS+qEYoXxzsu1iAvMwuSXcFdK9mi8zoGAYYfLD0RujIxfyIbI9TXcH/
 9tf/5CU5DSPMrjEE2gN0UGp+cO27hpc+ysxsaGiwPmE4jf2drMIbqlrCEjQp6URZUNmUj8l7qo
 yRU=
X-IronPort-AV: E=Sophos;i="5.76,374,1592841600"; 
   d="scan'208";a="249441950"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 10:47:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z79E5kb+uEQa3biCjAV0pKwkA7DMZpyXApDemQltAZQssXFXEu0QQUL9L1g6maI6wMlOdUKyU7yaib97xvvfG79YUJAcRbzVPLoeaLMfyLXIuG9x+4Gza2f6apjsnXytvNK4E+jXUIiV73VdNJugTIfiohAH9ysV6p0JFFrx9D7wnr+eurrQu0hm6ZHPVdhcLJOwAJ3FA5mn+ayXnLJgTnKFiid9Z7GBgG+zEqpQDX3mjiTJLqdmGUI6XxbuSUEHVW+nKXcQ39Tt+copanloGhIZY6lwiqnzd8TwsdpR4I+s8cU50a7Hr1pmf+/96g2uhS1zsKAat95JY3YW+Og8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/11a8Td8yyguMpCjNUHWquVGQ3fbLksnSUo3DmyO0OE=;
 b=jhzOTQWVpSisrbwpWxcPNlNjpCkE+Y10WULKK/roiVJ+9XzyjiY08xutrfOPH/udC59DLfaxm7+hZXQ9Ya2lyh40KgFgCOXVkBM77SYANcvSI+CzFBvPmf0fb+1LefyKDspnlvoj6s8I3aMDHcyB4b8N2jD6zdTCapj0+JLy3lLrtpzvR8PDn1P8bOXILSRlCWVt0bBH6ozZwrw1Xx0OUsSrowx0PZxsTmb96HOHtWNUD0s3pjQKnbgyWd8l9zJN1EHHld1BnluxuKF5utY1xpX8HRI7dc0EqQJtFdfNqOCt8JTmW+xEq3o4gcq7ydxd1dJ0uFO95dy5xeChkZvEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/11a8Td8yyguMpCjNUHWquVGQ3fbLksnSUo3DmyO0OE=;
 b=LFY5LeFChIawrzm3LEovztHOr5Jo7YExiq5HbtUoGnb96XQHbYKM2kS4vhoC9MMcqtovwzwjS7brmxngCywJ/pFUzQ3lOldwP8BZL+E8RrX1ucCKLiA0p1EQddLjqxjn4RDclPem+rjHsr7Kf4MdBXVafhkcQKEwkkf4euad3N4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 02:47:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 02:47:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests 01/11] common/fio: Remove state file in common
 helper
Thread-Topic: [PATCH blktests 01/11] common/fio: Remove state file in common
 helper
Thread-Index: AQHWfKsqMIaAh46q+UeHxECpT+6G1g==
Date:   Mon, 31 Aug 2020 02:47:47 +0000
Message-ID: <BYAPR04MB4965AD9B75FE039D7A71698786510@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200827194912.6135-1-logang@deltatee.com>
 <20200827194912.6135-2-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53e5217d-3fba-475f-4d32-08d84d583ee2
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124AE2D9986F7812809A93E86510@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAOJ2yIsUwCYv/GYnlVay+FG7fnZxm9mYO47yjr0rHSqnH/yq+EytfZKW1ntJoSPzAqiYbIrIrhc4VWSPYuxL4qPmqccn+83THAhvyr+GTyw9deSsq1s3KOymuVqVUJblrfSqgR6MNi4aTen0QimuVDZ5NNVlKJCawK3rGuzOsvK9sw+00SW5STZMzKIBzdB+NYf0JLNCR2C0fXlMvS2cpshwqZUHp3ffL4XbdwaILvT1+s2lByCbfEL/oetpiGZUa07mrY2PkqJnXwbqiicmuXMP4rfX69IB0Iq35SrcnS7NgaLdV70/uUsVwgAsgg2IjCWeEzPApRUqrqx6yw7HA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(8936002)(66556008)(64756008)(8676002)(4326008)(316002)(66476007)(66946007)(66446008)(55016002)(76116006)(86362001)(33656002)(478600001)(9686003)(7696005)(2906002)(5660300002)(6506007)(53546011)(52536014)(26005)(186003)(71200400001)(558084003)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Qx0eMK9/bs/zDADeYwzBP+SYn9Elhya650LgSQTgx0z2nMd43ioGkY/KbeIyvzTC/auoD42iyvZ2LXSkO9i/67lr9ltz0PeYtrRIpRaKMyttlO9zZBgiBZjDMr3u78T4IR1KzOaGbGZo4zrXmObsw8bog+IOzCIhKoxbb+dzw7kKyLNNLjQCu2WD7dYcXMcsbwGS4BQ6i4rlrSjmjasRpbP+Hrc4wTtDEQaveSR9HG9Y+21bMVESGL6oJO3gCPwubSt4l38g03wi5wMk+Rk75lOzxZuEVik7FzZuPXhuAhizbFSvAk2uaDiqGekGhw+VYUPd8okSLkkl7/kOPQgCXhK52kZ+gR8zRnVnQ4tJPlSuD1CwNXgpQXQ920jw1MCcd3NiXJmMyJ48x8RbzcNU/8cTF00jyQQ+C68QfCcUhBSH7MrqWJCqJjV/kbQdQ7lR1XqjwOkhCNYasdi0M8J/bxZCRhJy0EZRn8orueyhBCiJWU9pR/vc7eYaic4sTALcAtkIsqZfe7rd1Z/xzkibsuO8pmqe7F4HhDUC2qQ5To5qZyl0fWf1Fx24hEg7REwrR84CeX3kJLoLNwDBJg7FRTuj8MBwH4p9o/t7enMdQ97tt7z1W12vl4DiCYJu9WZbxEcidsePsCcVAraw1hk6DA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e5217d-3fba-475f-4d32-08d84d583ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 02:47:47.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WyVNdAzATQOD+fYwF3DX/tosjzBEwaDwbDwJ4YBBBvoxI5zt7lpPuWIO1q7ou6fEKKnRYw39mYIdCCavM2Hj+50s84PgSnQcDRMGT5eO1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/20 12:49, Logan Gunthorpe wrote:=0A=
> Instead of each individual test removing this file, just do it=0A=
> in the common helper.=0A=
> =0A=
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>=0A=
Nice cleanup, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
