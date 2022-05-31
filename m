Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A7EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 11:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiEaLTh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbiEaLTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 07:19:36 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D0B994F3
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653995975; x=1685531975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Ad3kFIScA4OKTLUBi5kyZpVQLX+C7WI7lWSsQtdyh4=;
  b=bDIql6X0Kovd/gStCEgWqPENLPNTq5HCXuefsDeR0xHTIbXvgsylAgBe
   jQjMeBnNtNq91aEyfcYLeElAE4nVjeJVAIDxYWCMMkuwn+sdzbJgjKSBg
   aNYRX2DSqgA0xkBZ6L575DgR6w/MYzhxnmzXeyRR5Idq2/hqCOXdb5bqw
   5XU9HpnTDo6s+MMJBu+udypRuU2WNSDmGtl3wLze3If3vzxmrYnr9wyG1
   OgkgDjVotP8wXdq/5rG2nCxgSjgCoesnjdSqqMyO/S3neAqmtSkAuQnjo
   S9VkioI9vHB7JdOVtZsvTrgvWnobtaJyOpkjbG9knkZ7Vj/a+0JQmXrVl
   g==;
X-IronPort-AV: E=Sophos;i="5.91,265,1647273600"; 
   d="scan'208";a="202686679"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2022 19:19:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdIPnB1quubzlv2Xn+hPna01DglAYN3sUpod2VIyhOu0IxLHQaX/WS6/NbXEgdQY1UPcAq2YEXu6gRrQDx7wYOpwlGObSdeP/u43ooXhxHUK+Tgh/hPFQP4LQMibz0B2sMpGdiJtATWeAYcEORgDbAH417SkGPrHNfhnU5daApYBijP204zOkR+3FnwK/fnj5+wehJK6dlVi/rAWHte7j1GcFdchLESzKEEZLnxUh4HGqR2fJoPSaEA+seoIDAfUUvw5lj1eEBZIajVbxe8HuogXzXuIYRZgqqVNlsnp1gOMZZqltVQGr3r5jLD6xrCgZ0VfymWXl0pSEEpKnUBZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ad3kFIScA4OKTLUBi5kyZpVQLX+C7WI7lWSsQtdyh4=;
 b=P41CZ3OGSr7LmWkIRLhJuTTdOmijTV5sSjhT5Yu7FO0KrbUC991LffhPjX9Xirr3UVzORjQc9oVwAlwMmwycxOT9BYFiP8hhxRR/c1YoDpcmJUjQL4IRgq4fSNhETRiFqLNdHJW3+HG119+pIU7JQjp8snG6WVc1ngxJUg0PQp31eKbDhSz4YaI8tkratT1nVJjLcL4TiRg77AfJOa4BW1sxudF6/p/BjCThc4pg8oICr8zKooVDxAHFpdFyRUTcRnxtrAf7MocBcSuyP9g5TAi3R5Sya/AkP6vDHiv+W3HZc0goyiVbpATp7iG6BhRRd8qCxa55IpE1uV0q3rON4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ad3kFIScA4OKTLUBi5kyZpVQLX+C7WI7lWSsQtdyh4=;
 b=XbvR/M1A6Y84Y95KUAW9YCHXBQWdDakb682dgrcZ38839ID9Has60ZH4jaJZu4KbsVkk8pyDmu1Ie3FvnoFX8DrS0aETHNcw8WX4oGFCRVNg5cNi7UaH5rpJqsYkQYV4CkBcW9xkFjiE0u/YVl8wz9q3kJT9MGUAgX5ZxRa5Xug=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8421.namprd04.prod.outlook.com (2603:10b6:a03:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 11:19:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 11:19:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 4/9] common: do not require loop support to be
 modular
Thread-Topic: [PATCH blktests 4/9] common: do not require loop support to be
 modular
Thread-Index: AQHYdCZdipobMl3pE0OUhcV5D1KGBK042E0A
Date:   Tue, 31 May 2022 11:19:33 +0000
Message-ID: <20220531111932.bvwwxobipyk3zi5v@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
 <20220530130811.3006554-5-hch@lst.de>
In-Reply-To: <20220530130811.3006554-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05ccd183-9faa-4bb2-a7dd-08da42f7701a
x-ms-traffictypediagnostic: SJ0PR04MB8421:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB84214EABC475E734BBA5F18FEDDC9@SJ0PR04MB8421.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C1cQHx8rgeAP5qdZ6cbR5nyUm2wGTg29JamEt6NN1neEicM42+WAYnp5RHCcrgRkkWs+cQdBW9HhPT4r9qEzgYuHg3kXV/EEB+oZyPLSnF3uapTk/jJjFbzXAqPS89GezmvhQB9jj10LBHuTZHMQWT7nVT7ZB3HM1pULgqETZHMvL7R6h1aAzel6z3pPg1odPm3UFa4sBxVmPSAoYH5Ndrg0fnD5WErkJatfaRp2EAaaHsgRZ+livd8FrZutFLmlDC8Wlyc/i3dIpLqyw+wP7eVdnt/NqKbmy2h0zHs+9Qt1/BDSe9ZqezhiUQ33ESaceI0n28Qt4nNwYwPWMDFRZuzNtUHjZWs/7iLwpvO0OAit+2Vj/URFatkiry37XlZ83F+Iow2/05f7TuKTbV8cXTuMnMwwdsri070jkN/wOs2Ph8wwg8sJIR83fTUVv2Nd43QrchUxbs9lOEdLdOj7b6H61QxVCGYaIswpAIS5aoksPum3ptTF97vnOQIEM+iS1OVJNP02OhMARb8D8wunjZ+e7BMTRrEs1xxMt8pZ6WJtC3xMEGUdvZrjtaxVftzuoa7O36cQbEfw3cfPa1/IUGOfdVcu5P/YQ49Nw7mSFkOy8Ipm+MdeSpv04nvU+kubP7qfNag04Bl9rXy5D+4WOMZeHOv36CFvd+DQtI1xgCH/eXXCzewF+Q4qzLnF8BlbCOoCSQlKRtxAvEicI0+CHEfrs44BAftDc+QbqIGuvFPaDTtol1doKL59Wcd2JsL+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(71200400001)(122000001)(82960400001)(33716001)(66476007)(6916009)(1076003)(186003)(44832011)(66556008)(558084003)(38100700002)(26005)(9686003)(6512007)(316002)(4326008)(66946007)(76116006)(8676002)(6506007)(86362001)(8936002)(6486002)(38070700005)(508600001)(5660300002)(66446008)(2906002)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GkdtiZPpQoi4/aPY+JGGgD8vk3QOrg6QevOUk2N6Hv8c7NweVM1tXl0lxXW3?=
 =?us-ascii?Q?boGq+oR/ij3akVRt6qBxiEFrqXuP/uu2TNNNr6Whyq3yYdri/754f5uVhGhC?=
 =?us-ascii?Q?SyBO1SMA9xYkqfnEeunlXAxdWc3fB/T/5c6OWFczTiUAC0INEv73hBvU4hpV?=
 =?us-ascii?Q?yCDFSFlsPH/J/ceQN+w0y2x0OnwUhaChW1SGcUrl8Trnxe0CN+eGLuCGAkWb?=
 =?us-ascii?Q?cQMZG8O+akjQETZfnkEpEKUpga0lSazCQs4Ze7R0rj/HZq4Zf958TU0Hblz6?=
 =?us-ascii?Q?t7ttEYiOdGXw8Uid1y1EszceBJKvScf5+iCiMep35NQB5QPaf4+mQzWkmqdE?=
 =?us-ascii?Q?SEV6vD92ninkRTcT4dAjRgyXaV1XUJnZgowMs1R/iOw9lW6IcwV3onCJcBoY?=
 =?us-ascii?Q?NEYDsQD4BLONOWsV3d+d5loIsv3rgkfM+Is9jzHHVSL4GIeq70kcNu3TTwIy?=
 =?us-ascii?Q?aSjFx3gniW/0ItfFZOT1M0EEhfLuKHOwE7fO6T8y0evfYhJVAGGfbFpIPStn?=
 =?us-ascii?Q?jEwns1CJSHN4Q55oRCETpcH/Gc+fzf+G7xPn/TQiDzB0VjzWGMpOA15gIp3y?=
 =?us-ascii?Q?uKiZt8tqUtz8KDXqF9SDyjnyxuyjq7pzZwNgXDieioVDe2tmiwr3Kpe1hoc8?=
 =?us-ascii?Q?gR9t1twoHjuAloJk+Jl1SFIn/bQhAfT8WzRN68WkSikUf1/w/aZH/6ixVzve?=
 =?us-ascii?Q?mW+S+t7bZd1D3tDu0rPak8Z8tnxlEzxrHcdXP5/uMxF+R3aamjiggSasoH8q?=
 =?us-ascii?Q?JxC7pHJZVS30b5DVK/N4Fd4GV/UY6/qu0EXCRxicFCsQ7dN7DHlWDjiMBImZ?=
 =?us-ascii?Q?190yrFyjxmUIUiNPhDhTVuyhrLXI1Ygi/LPKuw/Us8oUUwFxruri8ShFovWz?=
 =?us-ascii?Q?66m2PwuJ3fa3LxtNB8o4xk7pI9KrEwVPs8F67IreWjj71y+C+kSSGBALdLei?=
 =?us-ascii?Q?0zmFN9w4O2b23uA9P4xN6/gTds9bNPQdUPBXIe8GEacRzTJXiK4wYn6F0LMJ?=
 =?us-ascii?Q?r5vJlGU4KLj4P/fbI+8xM1Zznq0Tr4YHHHLVdEknigiafUMpQALp9co90jM5?=
 =?us-ascii?Q?RgC1OSetsc4Ajlf1kHBRTIVrwpgArb2PJiCDmmDyejskyqDdMYxuGTsvdlr1?=
 =?us-ascii?Q?szqT62/SBaDhnGj1oIvocaoBAVLG4GGaITb3gVILaI0TccY7nHmJ0mn/7XN2?=
 =?us-ascii?Q?8Ek2bqqAHP70U19QrUQuwiclV7KxZGChs6WiufSDIf3W4sVLgG0CkjsBtgqx?=
 =?us-ascii?Q?B7ScQ8eIbg29LqsotfWxxE+YshbtaqocQmpZWcK9YkIdTFppfI22QsODO6S9?=
 =?us-ascii?Q?fYxKgtRIurHlVfyMJlxgP+N44aGFkjBipkZbOn3PRt5ghND6wQ/EZaZqpPTI?=
 =?us-ascii?Q?i5RniqDXGKUrIaByMReYXTNXz4F+yljadTLIDRZdmHI9JTvluWkxYTUuL81L?=
 =?us-ascii?Q?j5cCVQWJBxC8XZGz3wTvrpyBGGAl13Xo08bcIjexBAQysqMyodXx51bDv7aD?=
 =?us-ascii?Q?OkITVywKhPw/iEx6OmBoYrFFHD+JB0cSfF5V4mvLGkcqkLBoymnpE5pf21WF?=
 =?us-ascii?Q?xnBb5reF4FiU3VeZFRlyDysn1CSVlGazbFNXQ8QuBZ5yv2R809qjuw16ZwPE?=
 =?us-ascii?Q?/LdGs1/4aZV8cr5Uwg1NjyLRVhM9WLtV0b/03JJ4hVaiNO9CZ1WhlKpQPYRZ?=
 =?us-ascii?Q?zCXhxwUxx8GFKyTkCo6AbPNlCp5mSICTKvTUNxTQqAds6dAVm0MHxYo+TBQ7?=
 =?us-ascii?Q?ov4uMW9NU7bG5zU7yvgLNFdPa+LWyWCVLxJUtkK7D+36xLcfSyQL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADD0DD07B72ADE4ABBED6EB1127F9AB6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ccd183-9faa-4bb2-a7dd-08da42f7701a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 11:19:33.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mexwXIt9M7m+74yHJaH0M5bxhiJBGdvVNqT1QuVDZRliUwHjBle0mlgicscnD9BrJpmESiTFxYsR++vM3MZrxz6eVJkALq/SISntsF+jyfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8421
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> Use _have_driver instead of _have_modules in _have_loop as nothing requir=
es
> the loop driver to be modular.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
