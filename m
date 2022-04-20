Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D1C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 07:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376567AbiDTIAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357036AbiDTIAO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 04:00:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B42668
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650441448; x=1681977448;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qm8NnlvlDlle5lTbtVwi73fqxKyX/sd5aEVurJ/Y1k+69sk7ufgqYOWO
   7mPo7FLFTy1C8E8nttesu+JwJWPjBOCVYczDRO4t1xGRXpQkjD8X8z5PE
   q9FQ3HqcFii/HeIYvt5gEkdV0Y5u7KI52OieYsih4WWiiy9ndxKKgpLHv
   nA6up/aIoug9lgwl7hzgzukPfj4E1xYrNLC8FIUSe/KpA93uVLXGe+0Sp
   89V0M0pU4DbSvlYNuenYG9+XobPyfMuGHDBXvjqv+/eAgOexf5g3yZvwT
   dYnRPVXLTkDHmWv4uzWRgUMPVt/Q0aKRsFVjBa1n2MBUec4vk5iQti5yr
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="302537517"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 15:57:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kccz6fMt7NYvRN7aifbuA1/46NSYb0cRqvxA4jr5J3djuHf1vr7sfQ/Y3RCnwhXpKNrBZNg3meB5thedIuK8NOIWuwliAaHuNx+b15+ymtx++7hbfXASVadLriDj3KcHNFVTnqOlIpCzRxXBA1a7E8B4yCcEpFiwA61jeA8ZEf8DhjQSTZCEZEF8lY5avruVHtgqLIKho71D1uPxm+BcXImdBpvgXxC8zO3uVxClu3q5QqOTVsPCuzzcfiZBewslBcOcsNTOQiPs7RKcC2LI+QOgFApzJzRo1XtlxjP5i/lZprbxwkvifjc41PWOUWuueIg1+l3XCnCOcFW+1tz02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HqbGDDmnxPQuRnIJo6qfdduvOzGXgQxovSTDn+ZeTTB7OBTIbkbUPnQx7053IgSkj6hsMlPv0PFpQASuy5UCu3+GjGLJ7AcpTq7QfZ8C5AJWZ6+XWt0Dln18P91fewYe4D27OPeGv4vZM9gS3E7ZOcVYtfvhbV3GgKI/uqzRzl9iSi47iMhhFlG+5clCoJVYFEqXcY0ggAb0YtMo0CbaPlOgk65vlbBv6xwYKHhUPxkUZ0PESNXCO41l+lx/8Y/fDcNblgDvmQFgN2n/cAnZzEZR718HAAUkcZ4of16Q1ScgS7KOWGD7GZq459jfacZHY1rSEGbxKapV71CfzGk55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NEfhm3qgZKAcaAJpZrKMUDXyxJPAjgqddABd/WJAKVOgVLNinh+cNI7LNxS+lYKAjGTeSItdprt93YzHLMnPo+OBimRp1rowDGJuyFCpxYeo07YopRAEntH8JS6EPbSUeMs1uIi8EpSts2/VhyBD78NgWWKMk29yGjpUIGHM/vo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5556.namprd04.prod.outlook.com (2603:10b6:408:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:57:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 07:57:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/4] block: null_blk: Cleanup device creation and
 deletion
Thread-Topic: [PATCH v2 2/4] block: null_blk: Cleanup device creation and
 deletion
Thread-Index: AQHYVFHpXOBx1lI7jUiiDHuxD9etrg==
Date:   Wed, 20 Apr 2022 07:57:25 +0000
Message-ID: <PH0PR04MB7416612163F343222702395B9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
 <20220420005718.3780004-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8214f800-7e5e-4cc6-c4b1-08da22a3689d
x-ms-traffictypediagnostic: BN8PR04MB5556:EE_
x-microsoft-antispam-prvs: <BN8PR04MB5556711D370E7D3B53AF67709BF59@BN8PR04MB5556.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3ZEneVOQPIVIt83s7X9KrAyp0swXVaxqNOoeyHn1jkJU3tPVJfE05amnKngX54kS9OzswJXK8aozJaoQodwvNmWIjnmsNG/OgNjduFFFkaGgv5Tjy54WZSH/KMEKpld2Ct6HUMA+8nTqiGiH8FyQud1wElMRNvTdu3MHB2EqGM3AnWEJ0BMPI8eLYvSrtjlsfl4JqR2GducClcLqtHiIGUNJr5oVv7lYygQa8zGGGA1rIwN3JfJSWSKhg/nFehEH+nOA4LuBgbKF+vluo6ujSLn2mPH0uzvxwI5lq/hXz9eTj4xTcK0EycVWKkvfHzTKAbaBuROthn8FMfukq7n+ltjbi4MT+7AAwRVGjl1CFOj9KHPOxWJs7Mk5dRxRH5haoDelf5XJ9nPk0gkBl7oab9xWU4kTZ3y5dZbZWoMZ8gQKi3JbCZoeyo8MbnTxh2Er0lyuFSMUqj0UIOJ/x8kYkPBRqp3zLxjUgRvZj0uT8ukPrykv6qCfoPHRBl/0w8I64eUYCDgHF00MT5KQ9odKn9hggRpsoaM2AaHgvcMf1Y4yKyArR43iOO6UKq3c50t0u+HmfMf8DDjxd69fWh2fzcuTQ1okofj2T0kl1zYbueHohYJ7opCRf8lCE9b8VCkYm31tB3otWEfG0lWSwnE8TA49B+0IS2dggnH7+24exdmVH6D8n8+Kn8nerjajju7ETaTuHmSdKmkwHz1TsDl2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(5660300002)(38100700002)(508600001)(19618925003)(2906002)(9686003)(7696005)(6506007)(4270600006)(4326008)(8676002)(66476007)(66446008)(66556008)(110136005)(86362001)(8936002)(76116006)(38070700005)(186003)(316002)(64756008)(66946007)(122000001)(91956017)(558084003)(33656002)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+bmsko8V3BTSl6J3ljxVXxrtozn9TS5H5TrSP2ZEcByW1u5flPcwiQrjkK6?=
 =?us-ascii?Q?E0qaQxhJglNbR9ycVKy3wGK+ZMKyE2XLvTD+gQmaoeIfbNNjOWFHadPqxuRt?=
 =?us-ascii?Q?w3RgMSD5XxUipjIjU8iDO8TIU4FTpw55431+XPbQn3FQsGGaZRWQg1oZePkf?=
 =?us-ascii?Q?jBHb/t0edEh6SxvLp5cdThCfpNXAIKw1HUKdtrK6hZ5IaobasJsFkmUhDtCF?=
 =?us-ascii?Q?Xs9CaKbB/SrvOQflX0UIFtoU8BdIeBQUe8RJEm4XVHv6PGIV89sX1P+CZ2bT?=
 =?us-ascii?Q?16welTD2CsabBRPqnrY2fNE2kFtkmqbiSQJABqiIoPyEXUoaPeYXay8/sk3A?=
 =?us-ascii?Q?RQYbuazH/JdTlRVnfXJeGVAV+r4ZNn9+SY62uKMCfzEZezAJaSuwc+bCeGZN?=
 =?us-ascii?Q?yrqQW6OfhPcXGbj2PudxxJ+wKayrHxPpR5I39cYeJwk54rqM5/TjcZZO0QGq?=
 =?us-ascii?Q?nwWA3pTl+QCbgWJoV9blZDtbENAsTNTAz4MuzgmQMhUefopi4Pe4lHEbk8SD?=
 =?us-ascii?Q?U5TOtKO7CyvTQ/5M176Ez3H2llMzUCd9TAj1GapfODv+nuZcEfcW7z0dwdU0?=
 =?us-ascii?Q?+e8eEzwBFhdaLOcGDiE/qUPVJ2i/FSU28sG8RxHeVRXE7vjf/FIDHyGdrhLo?=
 =?us-ascii?Q?bwsG/FyRxsI1ILgc2qU2GPGr1UvPK7vftf38ovpNScip3qUHnxTANkIUVxS0?=
 =?us-ascii?Q?GRmoZd0NGdFYg5ZzalQ9MDbjlJ85LNAg7fCEWp0UB8ttZeCKxvHoaJU1YWUu?=
 =?us-ascii?Q?FhGfHZTqo8XzTRBscRpwHky2mO4saIdAeRKU3u+B30zi333YdGO7+6lR3V3Q?=
 =?us-ascii?Q?Ia6QzKMykNCXrdDaDwi7MS0kReW2fl0KNl3iSRac36uM3hEUO7WKTw/LOF6G?=
 =?us-ascii?Q?VHMFrvLI42LR/7ssjUBiZttoWCW3fz1O1+psfzNeFv2onyX1xGPZ5QR1bcVp?=
 =?us-ascii?Q?7tTa/665DrssCwFlkOiY+dHm7vmbOl8oYFq7FUl8n/X8F3McDV89aG0Df15v?=
 =?us-ascii?Q?gIYhJZ26ukqDhhj02MueCG+78nznGr9wN4VVK2h4DKBweRuv2RkQs05pAEhm?=
 =?us-ascii?Q?SI9Qpi8fLa79ucUCuu/cbDjS6CVkOKcgbr0SKa8D068LGgeAycR7efEy0XQ2?=
 =?us-ascii?Q?dQ4isHFZVAiTi5EVsF1qNEBqS382I3YLME4s6GGKxENpN0rj0Fh/ZbQxgkna?=
 =?us-ascii?Q?19suLvC0Av2ksZwH7eDoFJY3c6HfdjvBvICoUL3TzT/Tj3X58UIvkzJUltZz?=
 =?us-ascii?Q?EN+sjver5beargtytMdLeO4S5Uf5paYvl4Rfsaxqj3x2raAtRZWTs4yJkuhO?=
 =?us-ascii?Q?QeT6BYqHhfoCpRKi9MHU+NvOKl0HkNeEUXhEkcciWIUHz4IMJ+KUFP0TCLLm?=
 =?us-ascii?Q?6+RjWrSrgJ1Byc/nod4A41B9Jh1j7ahdTEK3QdP6P/c0n/7LMBl5wDhWW8mh?=
 =?us-ascii?Q?Jqsq4wG5Yr3kCRwpt05sZv48bAwh0dS+72W6GXArsR91bjGZ7h8SBD8Lz/hq?=
 =?us-ascii?Q?KLBxDnvzCx2BUp2YNMhunjFUyhIlqrm2yWtTwuTe2T6+WKed9isMwQBDCop/?=
 =?us-ascii?Q?WTuw+L+DCD67YBfyolBnLW2j7VmuvsZobTLYSeiUqMsJnnHgL9FlUGrlQC3h?=
 =?us-ascii?Q?bXfJRXB5wqoGZ1MEEjVvf2zZcuClOxq/wy7S8QNOFScHR0fHgjallLyO9/tu?=
 =?us-ascii?Q?HiuufWPmpHsXC5kVPBqBLE/PNff4fzuzSbjpoxrBCYhqfp4qSFIqZmKqyc3C?=
 =?us-ascii?Q?MeCT/XR0w11+OpxXZi0+D79UtWU1EZNa1dLD3k6p2fN28S9jSToUL7/7RpXZ?=
x-ms-exchange-antispam-messagedata-1: qqYnJRfZVScQg8AzxdTZXjc/IRrLViaUrxupz2FRs4hy7gqSgxF3wZtl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8214f800-7e5e-4cc6-c4b1-08da22a3689d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:57:25.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGgM4lOyri73SkFTKjtDaR2waFjFdb6mlT+qxZecaau9hKcxtQKzXzqLJ1WcbwBXL5jkPmUhTa6cgeVHDNGa75/SG9liPwRCvEDi5ZrwqqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5556
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
