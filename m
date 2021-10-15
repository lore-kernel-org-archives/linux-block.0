Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87029C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6713260F5D
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 07:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhJOHeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 03:34:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24562 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhJOHeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 03:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634283144; x=1665819144;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=UHpqDW9Qyz3zc3l6OBHmype+PPQGrMdluaDrgYuset3TaK6rjcBQsi4O
   swXT1fw8SHHdaJDi3/wrOfzRqwChR6KBvTtPZhz/4QLQyeviAzmZrrazA
   Pv2j2wC1wACuVedSKBze+Ic3YB69C68nJzlm43hWNmkUhivA2+XWsmTUc
   cO23b0FOtdlRpHsEHJTvLDOLJIEP2MjwFgx/8WMM5PcCNfw98JZmxgB82
   gaRmzHmTDGGTCzwPoZqZI0sw+Ch+/GUl7WBkXnYCKbzEIIOwj5Y0f7v6l
   4cDPcg488cLL+NpSzmFcnATgLirCoOAkISFCi0vfPIOs687+4Z94GuBmG
   w==;
X-IronPort-AV: E=Sophos;i="5.85,375,1624291200"; 
   d="scan'208";a="187709118"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2021 15:32:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSgM4VEGbNGeOMWVPLNrlnPA/R5ASEhJSi3Ls5xs17AvMNsfnKIxatN0BGjgpMGi8zJkaEz7L6DnjVGcLM00Add4WJu0rHWkAxrDmuNHTcTYmoe7x5zhAd/Xwq2WO16Eb80ct1dlLHBVV6H0qT4aA+UcB61H+EvQSTec938pBuVeB11S2hVzdj2bJI/StMyAl5PJ+lDvQv4WD2sLm24fxoMy1vA3wyd7rk2bMmfIPjKiwuvIqoUzjH6As0qGSfPYCL2Yio3r3lzEIdklKVrrrGFIsfxpAd8ZoRPdtR5y1flR7jwTslgklrTKtzByne6nBUVEV5SaNOmjmKqe0q2I6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kRv6CTmLYilkz2/pqswilueiQ07lj4d6KQ/ATnjOGYNX0wjK7G23Af7/Zp7h4OFqkcfRKyFQL0b6B6xCwN5IdTtIm7y/q8R9PF7SHNzZehmjeiOmpQrzJQVaMYUEZxMn0xjIk6SEe5qzgPW2syGiv9mcxXWqLtR1o/M7ytqteUUGk+Nd/veqSFW0rUHJji6/0YSLmmwJGN430G7qw14j1apW0vX0wccKTKqk2GJQBPKP7dv74gKtXCy4ayDw59eNE+10OSDbu561lOzqOwQlXLdi+sOqVBtxaT+NNTOa7LtNMnUXmgl58RYCyp9j+0a4qpWKQleXBJ+XsZHqwtFPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ecJ4GpujZ2oOOqkPaQak+fqgR7Nk0HionCQzs2LTfOpWSQUaSSpBQ+TnZ1EykrPe/jfJo4odmdxLAyVDCQbBcUh1UwwjXB2JDvIkJyY+deO5f47vsgmOYUKFOirYQq3evLvpqKlnZUUYQZqUxKW8MREPgBfeLGRckQMI6ah7aNY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7223.namprd04.prod.outlook.com (2603:10b6:510:1f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 07:32:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 07:32:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] block: Fix partition check for host-aware zoned block
 devices
Thread-Topic: [PATCH] block: Fix partition check for host-aware zoned block
 devices
Thread-Index: AQHXwWl0AAdXSz7Es0iWXa3QADK9wA==
Date:   Fri, 15 Oct 2021 07:32:21 +0000
Message-ID: <PH0PR04MB7416EE6CCCD344146BCDEC319BB99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211015020740.506425-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a5f50ba-ba98-4790-a33b-08d98fadecac
x-ms-traffictypediagnostic: PH0PR04MB7223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72238583E33320C0EF6CB6889BB99@PH0PR04MB7223.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U143VX1HQIzcmrt4d3gLH6lkE9Y3EzXFIUZ0DE7oKsLHGFVJHb4qSSdPKEixYS/PW98z2b/7OJLTqFA0mxFpvjI8LRUKq/T8sTPag5g1BA71NHRU9xg8GIW5vTHVbwSvLIJtxUuxcrthr9vBIFmdbZ+Qzuau4geoK55zBySAtQmkOYoIpFBbELvoguu7lQEHCpZS1+3yqtd1TyVXfAbbMaoOiutiQnO+qoLjc6sxK/h0WwhZ3MBzymoLX44M4UH3d284FPPUkYzTNBTR/uefWh0ky2erpTh8AEgbqQKVSeN5b0lP4MUohMN79J7pbGNsfh9NIfuTKd+sfO6nvGhFZWDP7ahLV5kDVlkhzSTziBrxynvhHN20W3fPWjKb4+Nlg0URHGqd+mBc2F7uz2DbjqS+BJ/ZCrkieSYASsS9LEKKAQqO2Dc4veYZaY0+a3i/YzRZMDWKzZ+rFmuYoQ01gMllVz7m3ialfCvpx1VZ3r5N4ESIHkYX7/aJ4Pes0KJH/3Nhtq92fcjpUGtA3Huw2//z1brH6z9dLk5aMtno6XSA2gY5hoKOemuiDwmgWx5n0Zauxu6FmvTlLSvLYCOE+/tAi5EK3zqX+yqJRXNb9o1ZanV0Gbr+3pLchkKPEduVpEu3JiB1IY9ElYMK+8OEcK5pVe+1nxjKpPk07kG51d0/XwdAjxup1ICcgdD0412scShiXpFiMjfDefaA8eOGjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(4326008)(33656002)(558084003)(19618925003)(2906002)(82960400001)(86362001)(91956017)(76116006)(8676002)(66476007)(66556008)(26005)(64756008)(66446008)(66946007)(4270600006)(9686003)(6506007)(71200400001)(54906003)(316002)(5660300002)(110136005)(52536014)(55016002)(8936002)(508600001)(7696005)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zpyXX5AznpVsKZUMU8kf9sr8/lWZDoEqh7W6EtYOMRYmqxLCRwbd2I4G3DEs?=
 =?us-ascii?Q?ObUp5RtguCPZ7nuhNl/pPACgUnbLtN5YMAU7wUkxByu9+P8ptRqAxlt68whe?=
 =?us-ascii?Q?qLH/s6WhKIzq9FO41b82R/cv71hc3ZcOW1SuNCTEr+gkBQkSl8WV8kqa5AK6?=
 =?us-ascii?Q?Y1Sw0fcLeT1ewAyQqkHG51c2NIMS8nqN2qHdJ9VYE8pnk5ecxYtkvj6PGd8q?=
 =?us-ascii?Q?9r7MWs7YHINNkxHVX7ZsHsTqVYVWDqFOn2HGj82kL+sdMG+L3f0gncC/EIhH?=
 =?us-ascii?Q?F9/7zP6Yfl73vUsAPEZGTwp53hR2QPjSsRjJGADi+drvEI/4pvTZCAu1l56F?=
 =?us-ascii?Q?jEok55hw6VhtZa7PQP3S0V2+VGXEszE7wB9H6Fna53WJmmg3wAaeC2TA70oH?=
 =?us-ascii?Q?41QwUT4rT4PdoJ8oBedlyYFR+Fl3AwBljz7P7iAPVWdEU9WbvPxFpmdnWNVu?=
 =?us-ascii?Q?7OWUtegqQw1htTvNEWYp3afnmkt77J7nPZLeqY4sgyw8ZOzsdoYHgpA6D9EH?=
 =?us-ascii?Q?fJvoKmcoG7nxM1h1qBIWLq63Em6z9AIvvjS70jJh23FG0XSTx1HzGQWGrMm3?=
 =?us-ascii?Q?br4y8FkUgpE6c3UfyKwwrAkQ5ZuNVZLQ2yxoEeBQBVQupyBO6weswWV/+bDc?=
 =?us-ascii?Q?ejHk1CCay3OeSlryepT4QdF6EJsCc6J5J9t44BaeGVK4BgiTW3iXdKLuQ/l+?=
 =?us-ascii?Q?xIkcJy7HqnMA+zkgZuoWYb18KCx0edwRBjDLaPmdmbDrmbvgNEdwEc+j2dyJ?=
 =?us-ascii?Q?5JZwxfWgctsI/R4xf3bs26rjDXwdMwsGnOYVKH4V45BNescdrqBWVfEs8A62?=
 =?us-ascii?Q?sEpaFCYMkLD7s5qNmz7IleplrU+MdUZM04KEMRF+xLUVZ1QfBPRHUDCf0S6e?=
 =?us-ascii?Q?TCqlRDfuEL080ba0zbI7JCcURQC+fti0qB6X5StO4RKCu3auh9j5wvJwyrHW?=
 =?us-ascii?Q?nPKqEeKjz/iTufEe8mjfgL288ODYwuD1oWRJhRQP+shc1+8ixCHgHg3NWcFU?=
 =?us-ascii?Q?EiF3lmSxzaxugW37MUrLri9oYz/fBAgJPCuhncRRqnkWt36vSyhik2AuREki?=
 =?us-ascii?Q?xCztjYCIA37i1L722DABilAiB87jW7rOAm0kj3ekrXZHhS0ygKl+Tx+Yxj6Z?=
 =?us-ascii?Q?HDfpJ6Njf5GWvlKjq7BGErrPWEjqCstWKxOFf6WPZM9mRVWCe/gL8k/iG8bW?=
 =?us-ascii?Q?48D81XrOqJSVfgETc1lQAnSx3H60LLuzddukclaSPZ1J5i1X7RRJprLPcTWO?=
 =?us-ascii?Q?y4kIqXdLLNnUi1HtNmH8t8wZwXjDe4t+6jUN0a1uVoTRPcOlKNLSo5ftscfi?=
 =?us-ascii?Q?wLjH0H6HxSQ2A4SYwxwkG4PZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5f50ba-ba98-4790-a33b-08d98fadecac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:32:21.0714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACHEfhz7rmLIFJ14hDfsjtNZxpeBcS4iWZgwLCzjDn6HhyaLxlZ5eKQfSXWyh0iFwbT2go+bmV8Iwu0EC+v1AbqfEWaupxmtkFkR9LIBM3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7223
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
