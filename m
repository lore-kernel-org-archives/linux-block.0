Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B16FC43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23D720748
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 23:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RbAd9B9i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bavHFu1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgC1Xmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 19:42:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22625 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1Xmd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 19:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585438990; x=1616974990;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iPdwREVY6PO7I2w/AwRdzqyi/d2qkQl1ljlr351pMkw=;
  b=RbAd9B9iwJ1uC1RZMUOItUqB4F3rmsKv+OvmUP9oxNZkQ30dBVhnqDft
   F6Wa2lK20IyI4boWBVs4detndEp8v37+ilaO03NVPGmaecmkId+S4mg2q
   4vw0sWR8maBofSDHVrQhVisnulGqOLTT1Xkd0uGAC7mCZmV+m1EBzOsUi
   Jwf0rGMTeOz3PvNv5n7/hkv44oiG31ePlA4S1+xRwtj6KVFByECO4t3WA
   kWJwm5M8CpnX1GkzJ6ps0oTHpf8bsQSSS9eFG7gWJwNc2HsOgistOZua+
   98SQXIAdZby02x8U5VKFJqcuFa28hnR+dkPfVnXI+b6X+ucmb9HtLgwk8
   g==;
IronPort-SDR: axPwDsDarOoG2L896ic70Bv18mDQEhEx+e9c6OrxXKfb81MABcgIveV6nsqiKI2aXAuXN36pg/
 /3xV+mErDJWAo/s754mUc+r9cAfkJ3dRbh9SUXauwH1P4OJn03KLQXDmv9fKd/HflKh6O2LdYY
 JK4VcqerM6IRe/cGdjH6F4UP7NC9h1qbNUeM5DoDXdn0gf2g1gOTeRq4bsShd0tgjLBx0tRbo7
 lP6mQnY3gRamvomtP12X/VtUyivmLKOEaILPKVp7dpp3to5gX/8aSCm23eVhuRmoZkWqCdnAEn
 yh0=
X-IronPort-AV: E=Sophos;i="5.72,318,1580745600"; 
   d="scan'208";a="236041300"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2020 07:42:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOmBA2d2lhoesgxY2GG+YT8zzF4w0RSQe2YHJYOiABML1eJ03VAMbDQ/+RYLwBvpLjloznGKDXwic+GxGdERGehEo7OhzyGqsvAOgsAULQc6ewQHL0u+JT0q2weF2a8TDvAc1adjWNXbjHi1/kwNOIGxHY4nnEHBIzizN1q4bXEsiW9UHd/0g27AqCNt0FgzXI+8hYwHwdcNZIZy9CJFOEowIe7x9RO9uZIfpplYDIXfpsPGMc2bg//G1nEaPyHUht/DM6hulq6Fr93lKnBt8iPGNgK7NtRJXD5xmIDsCUO+fCuqqW22aToWp5jHbnC8Juu/zuzO7zZtjhml3UvUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z53x2w1Dt7aH7YNddk50rLAP4sTt1oebI+nIy2oZmT4=;
 b=LNomjyC9vpj24pMTRnM2e+xCsdRieZQoMoJ6faPGdL1iJIO3UpaqjAZ+IH8OGwrhsafb8KBS8PvEkeoEoi5w6ARcUALjf0ALXjJNz4diHdWaNWKD441uxKSaruGbKqO+L2R8B8PIaJXcgYClouHCZjTyc+HD5r99wVaayS4wrLrySaup7By8bxCUddp0HPkpJF4CWYxGJVtHPQyJI4SB+9ftxQrRr4dniiXWMlLZnDe2DQ6XlBHBdeKwMTPH1ubkrPtA2U/wzBNto6MuelUcpo6rSwIdeS2qgj2/TSQISEfovkHnqa/9zHb4IPQBkbIoztmsAgtqTejWJyjaExUPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z53x2w1Dt7aH7YNddk50rLAP4sTt1oebI+nIy2oZmT4=;
 b=bavHFu1JgnkEkv+1bxseiCKhJyiacbhKUINfVf45jI1fkIjblyf0MamUhsjvQ9S320L5DVJFkHNLMV8OlG1u3ikk8a6cDRk4JjS4tuQkmz5Ihl60zUyX2WiaPtbmuf++T7Z/S/rz9ENfcbDCkj4sEN+xiWHjSa/lMzl9RiOGAYE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3974.namprd04.prod.outlook.com (2603:10b6:a02:ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Sat, 28 Mar
 2020 23:42:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2835.023; Sat, 28 Mar 2020
 23:42:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] block: return NULL in blk_alloc_queue() on error
Thread-Topic: [PATCH] block: return NULL in blk_alloc_queue() on error
Thread-Index: AQHWBS6R2yQGiNlOQ0SjSVx3uWgB7w==
Date:   Sat, 28 Mar 2020 23:42:17 +0000
Message-ID: <BYAPR04MB496593AEBF503ACC8DD6EFAE86CD0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
 <22e5e0bf-49db-03a8-d81f-00733f117765@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 646a0491-74b5-4f65-8ff8-08d7d371a693
x-ms-traffictypediagnostic: BYAPR04MB3974:
x-microsoft-antispam-prvs: <BYAPR04MB3974133C0EE6D02B16FD464886CD0@BYAPR04MB3974.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(6506007)(53546011)(316002)(33656002)(9686003)(64756008)(7696005)(66446008)(86362001)(478600001)(110136005)(66476007)(66556008)(66946007)(52536014)(76116006)(54906003)(5660300002)(4744005)(2906002)(4326008)(55016002)(71200400001)(81166006)(186003)(81156014)(26005)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZMir6I0SUrO8Mi/G6A1R06MZ4APjq7sKqL8ylA8qlfwSeoUjWvwnTGTxVbj1q0XdNt7YM6tcyddmvlJXNc5mMCt8f7QKkrxo1QXacOfghaHDnMNQGdUfRcPbK46vBpnDBUOJCbNH7qbVBKzGYwdh8c8Bnisji/gfSw0R6hz6PqCPK5RFuNAWXakp+xee2dVt9W2Bd30w2qeMN0Auux+Y+TCn/gSdKKAISyWjCalZJx1JjPAONCzq+d9fcGZag6sWWkKhgFmazrL4wjb96DJWa2SMfR2OGXu7u6QDs/TLd10D84DQNs8QT+VIsNjARzMPDgV/Vq9vrYtLOmx1uCnb7Emjuv7D4auZKQY2RZsx/HsJNJr2yYznWkrD7IBKp62fCZnM/2CHbF2ZV7ANDcqhwZCqrkWr/OBo+k+6uLYolKby8iagQwmY39w4gpAtHor
x-ms-exchange-antispam-messagedata: 32KFgS8OlTjY/3cVpQbaQ3yLXsXSPeEXfLRX+bKYlpbdNvg9o8oGE0N+QQqghJE3VucG9jbodxIqXXbfxRLpm1gotHhJk2NHh2IbplPefqscQCv6rHcmzdJoZY0z0hp04yzlnxQiE6L2sf8p0mgLBQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646a0491-74b5-4f65-8ff8-08d7d371a693
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 23:42:17.4259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8zpXPNULWhT5Uuyl1uPvY1eQmMwY7HIHKY3HTDQhA+MW0RFLgi+Q86o2dg9mg0PFpdlCNMY8q6LiXggvBu4HJKMwQKj+W94jxJh4kjjbP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3974
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/28/2020 02:32 PM, Guoqing Jiang wrote:=0A=
>> >diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>> >index 18b8c09d093e..7e4a1da0715e 100644=0A=
>> >--- a/block/blk-core.c=0A=
>> >+++ b/block/blk-core.c=0A=
>> >@@ -555,7 +555,7 @@ struct request_queue *blk_alloc_queue(make_request_=
fn make_request, int node_id)=0A=
>> >   	struct request_queue *q;=0A=
>> >=0A=
>> >   	if (WARN_ON_ONCE(!make_request))=0A=
>> >-		return -EINVAL;=0A=
>> >+		return NULL;=0A=
> Maybe return ERR_PTR(-EINVAL) is better.=0A=
>=0A=
=0A=
Initially I used that, what if existing callers are reallying on=0A=
NULL vs !NULL return value ? Use of NULL just makes the code=0A=
consistent with existing return value.=0A=
=0A=
If Jens is okay with ERR_PTR(), I'll send V2.=0A=
=0A=
> Thanks,=0A=
> Guoqing=0A=
>=0A=
=0A=
