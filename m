Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1047C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61C96109D
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhITM5U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:57:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36345 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbhITM5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632142553; x=1663678553;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O6NtlzVdncpMVaZGe32/NeEQ7a0R8WRJ2q4sHSgFqt4=;
  b=TsuF4hzQPvGcvaQh95wvdzWlIkQqxYQ2JIQW0MRSSLqaGFB5h9lxXg9B
   fn5z0y8cCSBu4YDAmoIvLtlON8qWCjnroF+oTipjtv49Y5rEBR1fZHsh4
   zDyLsEbQtRFM3GseOcuT0kzhtz/EC8wB/ZAWKLTIop0j5bdOgvsHJ6DLV
   cGPYXcxceeeZEbM8GDs1AFASGwGpzklZPHC6GTDvU6FsxSTPA38Ze2siw
   xGNQ/nLiCSjmN8Y1HnneN4FzhkwLlPc8zTfcvvDTd02O9FFLfkbK1l48M
   /lQR5oSFI9duyKgrTscUTuOdo6FtLg7Ev1gBJRJdXkdaSSks+tuSy8QSr
   A==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="180961776"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 20:55:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POPuFogHb1ZcAGUBcEnNPuIm2is1SrRw2NtlfkwlUBjZGK+W6DalF0tE8leeMZbFg4vaaCoYmR6nTho5jsp9ubd5SwOD8hGf8OXJTFTBCw4U7xk6tfN7ZSLSfEVCflv6RA0L+n9YCkGJ8rVU2guoal67qv3lN9JV7/UmjiMY5U8RvMHJ6o3rt460jaHBYMDJiFY+tNV0KZzxjwaRuDnn9BXxZx+xWgGqcduNCg9j7Z9tpXYTsP76IQ+uS3sBdRH7voy0Jri6dvEgW7SmF2VqbkZVadGtTbBoeYE+Dv1vt1SsMinnRcR4b0QZuYs0lgym3XzU1dGTJG4hk5t9kkrEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O6NtlzVdncpMVaZGe32/NeEQ7a0R8WRJ2q4sHSgFqt4=;
 b=XVfSht8vrH612pkb36vFaIpeSwt459MzdPIT6FYor8W5lL0HrW1DJNwvaQVXjbPcpf2+VkUY7mqyGSKjsCnZhsytTbBKP/EzLhqF76Eaeur9DmnpKBoU+OQuU2MRJjJyMaKTVTjjCPFXvzECItyrjEvF9A7lbRIbrPCmgMPLG0PDj/F099cnJdL+mZNGrIecr88Qgjbj177vG9IGD+Kt4dG23wtRR6JiqBfTNKwhYSF2V4UB88eaa/G7kKtiTsagNAWDLrUKfw/H0ORFeai6nq8vBOWtDgTvlb7/jZpWW9TgCFcoQRswoDQ0KoAQ4MAzaXR90XBjaTnB8SMKm+sFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6NtlzVdncpMVaZGe32/NeEQ7a0R8WRJ2q4sHSgFqt4=;
 b=B07ikORu6UoENT/W5+Jon6eoBlagxbeA2AMXQU861qwYZmJOJJrwa98vHY6NJCh3u65PwJk8xJ4w6USNx4EtuALIiCqqHNBqolhN80BtHJv4ddgv4+Q91eYVZK0sTRz4sa/X4c744UnDKW0oN0XRu/Dv1Qc6aFflS1BH9jDx1Pk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7703.namprd04.prod.outlook.com (2603:10b6:510:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 12:55:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:55:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 08/17] block: remove the unused rq_end_sector macro
Thread-Topic: [PATCH 08/17] block: remove the unused rq_end_sector macro
Thread-Index: AQHXrhycxnpztkEH1EW/H7carzRW1g==
Date:   Mon, 20 Sep 2021 12:55:50 +0000
Message-ID: <PH0PR04MB741616E7AEE73BA72EFB18979BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 076bc941-cd04-42ff-061a-08d97c35f96a
x-ms-traffictypediagnostic: PH0PR04MB7703:
x-microsoft-antispam-prvs: <PH0PR04MB7703E1822D8C0254A34340739BA09@PH0PR04MB7703.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6koLorXER7cd+POpABFoagKSGJnNQ2sVs6cf+fYn5TzaYzOm/Q2CGzHVMbsi1nlmTVsASGpsH3PxD0yNVXQeTyNejNjHLHC+iIzAxKIfxAvaZt89jcu88gNWRN3zyBDD27JTGt3BFWybe6SOJYoEvxus9UWswjtvLJSTHgQBlOXX8osxzcDWEeg8IFj9OetmStSU6V9IrzuQZT2meEY4scT9Xqn+OfXJmi98GlqqReyXpNvzBBnmkRHPoCSZv4/wGHIh1CxwcC6mmBprS0g4UPUEEf7lIm3Wfa5iLHvEQTgl45u7auQ8BNeXUxqQ4RiwCkuvjXXXHBkCdUHmh0AH5nAnpnZXqcbFXcmsYowh/WtgcuGgXKg3keBP/rs2V5vpagrG518GvnhULDZU5+AgQhlxlgR9BgccSyt9yHgegQYkpOCiUMbS/wA8Fy7gZLYWgC/Lc2uDDOijey0FI889SCEYs+4YIatYaI4dInboZ+nfHh9Uu99dklOUWO+ugtwZnITPxZATFO525XgseizPtXomgXyGBQBub3faNUFLTh1AZ2hVX61V6HBmVIYN8drmGO9pRPQbqeQViE0XjimGDvjCtXGsVhs7vD1wFAokhT+MVuG+Q6YQ0YFvOXaDnUGhenMhL9HloIGwsbnVX9EQYnjNR0Z9fMT2m1fQrMkvwqsowE+TbPO1ChZxuP0gL4uuAG3N6GQCp7Qfri8R5TGhcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66476007)(64756008)(66556008)(7696005)(71200400001)(66446008)(33656002)(8676002)(54906003)(76116006)(2906002)(9686003)(122000001)(52536014)(4326008)(66946007)(110136005)(91956017)(38070700005)(316002)(86362001)(558084003)(508600001)(5660300002)(8936002)(38100700002)(186003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aV85ixy1qeTD9hLsc68kIgQk8LJ+86SfGjqV1YK4nYSBmz/KMCg6MAhOezgk?=
 =?us-ascii?Q?6NeOdx0tJeiJE0SRnTMN/AWIkmDSWp8enO4xWFX1fMa2k++UF0Fh5AXEZYKS?=
 =?us-ascii?Q?2cGBK73UyEpiJ/4ajwWabShEcXSGEfgp4LvwYCXV0VxEw4J9ddz7bDb2R9Yn?=
 =?us-ascii?Q?Vfdwrjl62GbNdZxy7HHk5mUXHJIANe5bn3zezDYqzNXUZAcZ3w0+ItqdWu08?=
 =?us-ascii?Q?wWBGHpoQl1RdF28eKyCsp/IpH3su+gBsd4K4+fAX3o/deTYi2FeZ5tbCbJJH?=
 =?us-ascii?Q?MqI9ooeQctyUyFoywIQcXEoqwiV4O1N2ySqsqxFxOpn3gcSO6we/XybJY6Rx?=
 =?us-ascii?Q?AeamilDtLWJM1SlLkCKOKWcPKtVPgin5D9WsEDvI84iwm6PoF0Q4NIwz6be4?=
 =?us-ascii?Q?I8UJ0ZWBn4wAs8mwtCE03afeNy6NRK7RRZgfEF+1VuiOkcRNxHlY5/3QiLz3?=
 =?us-ascii?Q?ITpwqRvTgDt4ygeFaOgxgXO8ny+3pQBrbT/z/fHDdnvWQONqMgF2Nfl5K8hN?=
 =?us-ascii?Q?k843wl/ybVKcqcWuOnA0U4T3RGs8vXqh2PsnUH6Hg7DW3eYy4snduhDt72F3?=
 =?us-ascii?Q?uL6lyiH2ZxNdnuhQWsJNkx9uXdAnDk7DS7Os4W+ttmmb9NivZyrhM7J3ahD4?=
 =?us-ascii?Q?sj0xCubN2LXB78NpsiaX2eH0g/uH4o+Mv+m6zUKKfopi51TvY7b6um20A73l?=
 =?us-ascii?Q?tH0VPf9QLOpyYVRdQtdSXieb9Ks6WJpbQ4rTK9ZysMyBXjmAx8z++67j1Cm3?=
 =?us-ascii?Q?tayHII8DjXSxrleDSeCJfauiv4iWvve6xWE7mRFH0/s6PLTU6BeFaPqAjUed?=
 =?us-ascii?Q?GNYLvG3Ri2bQ6+0PHbuBucc+i7bpFsdt4y6c6QrSInhMRB3UQhgSJxb3j74Y?=
 =?us-ascii?Q?uDREXeXsonccPKBpoiuaLEvNtEYG2mzLyKaijvcX3uisBDrIatYs3ucqVWC1?=
 =?us-ascii?Q?obhzrs9ueH5gvJjDcm0YMjPH4gOPZY0v5qjn5kJkiepd2JEHtSe/d3vvi4ph?=
 =?us-ascii?Q?7R8eKBpleylLgkf56mCyY/tLZfd3+h2wz3MxRDITCt5GWyHKJPJxm3ppipUZ?=
 =?us-ascii?Q?xjIIRgA+gkQsdwPtjd7z+CZ9Um+PQrqyW+/q+RlyZC2vy3E7hEXPWMZ2chJW?=
 =?us-ascii?Q?wpQy/UrrKC0R2NmIxugT6VlY92Df7v9qsWWYlTu16XfFu879RB6hju7rY1ef?=
 =?us-ascii?Q?qU+9Z40h/Y4W+yVl0iDG0evAMHjGPTzC7e8x+C/vaWLjyJcrkTbQ7LagLbR4?=
 =?us-ascii?Q?XiZVOBv40sk+ha3+juRSvyAsXhoBkzNazcNUEZhr/LO8N9NkTDCgDiU1k9RC?=
 =?us-ascii?Q?7TXrlq0E2J3X0okJ+hiY4VLJOIon4BniAIgz4E0hqmBD6y2hCM0IpwrWZSaS?=
 =?us-ascii?Q?pax1woF0fu6o47cwsKLQJ9CNchhp+puaVECC/9a6n2v/VTB7RA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076bc941-cd04-42ff-061a-08d97c35f96a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 12:55:50.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TZvMlnftU9Sv35oW8+lkdxVES7dq/8bxbVfFG/uKlNriZlpDrC+bRDYKdyjNGTcAWUSauc+LLWZWxxDDeN8LlDIoYTQeafezJLYBXckMvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7703
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So long...=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
