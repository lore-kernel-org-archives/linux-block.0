Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885EC4708A
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8879861028
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhE0Iq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 04:46:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32073 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhE0IqX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 04:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622105093; x=1653641093;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=rACmCwMLdmFjzW2Yr8gRHjsoHsCl8bQ/Moat+xI0WaNHRreQ1oVqb0DZ
   0Xm+p3ZzNAzLr5Rg77SsqaaxoCabXJ73Zt0QVjRTAcIYSosqX+YMz62WW
   OgNrJ/OhPbUHIOiFyqOpwue9O7/8U6tKz1nmSHq4KoghScHBri106X9gj
   RIZdFUZzJHM846lKCB13UWuKc5c7Ahwtrwc4YJUsfULj1m1jMdNr4urnH
   nnJLtCBI43/nQjFcGuIo2ZRqtisg+FUYLNQ321C4GRMtELhrNymEvNPYw
   kiPmUniONFXSIZ2O7/DlDqzPWOrRe85KUXHniAcsaXrZJgV56ZuQBXuJc
   A==;
IronPort-SDR: MgihBga0YNKSxdWoT9dYczgiIQy9gtj7hYHDGF7CPCj5zZnZYWz+vxYY0srzTQKDIzsoVGtDqo
 xC6+l1QAmgNDEAFJ7+qUlTu91vt83fxphe/URIc1XUM9NoHRqGUt87JrMYDsZsMqB0RJ/9H411
 tZ06A2Evbi41CFTYYkYD/wQSFrZPr7ZFm0qBgqyI4m7gaZSWeWPR6uCqNQqxpTARo5Duj7D9kp
 nao01Ctqj73VB7IpCl5HM09Fie4N65OZYqDfFl0WAEa/Cl9HAft5HywfuH4SyAmhI7/wJfp8cD
 N74=
X-IronPort-AV: E=Sophos;i="5.82,334,1613404800"; 
   d="scan'208";a="273538093"
Received: from mail-dm6nam08lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 16:44:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FshtAZyMvpHyLHNC4gY4j3XJ5v0CI8FDNcoUIjiIuOoiJR1YmOqgM+SFg9SNpBLf9/0L50elkVxHUY1IH5pyBISuuPVU4QRsjrAb2i0Ak4Un1wX0cqQbMf8mBeketpADpxKVomc1EccBD6djqTtYWiaYJbjLJY9nEsogdz/LH2ldyxYyY2JCYOJgoi8omINEVv8oKPJ11hjLUV7vPMhMazf64FtTksYKmYOIekfkQ2zRIoaorKIFzWAHai5D92pLR0V5kovo11sXoQLCyfUZIUK6MQz0m/UgzXdEgkkUD+uCDUDgtCpGd30FGCm5XvRbkX6aG5i4AAGH8EQOmxSuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=m6Ggh7m5zdPyIGqLoFM5UqfHstTenTCtg5EAn2X4IRrl+N4LPvyfZhphaVHFZ9Amyr6OHGNtWJjwAHNZN8KKKaV79TkyKpP2u1RNj9xocl8MhIwahiiM0bzWsAs95RoSuNwvLK9LT3yavKF2NZxdoXlNgCTVsq3eCtZ9PTf1rySQbULfTVaA43RDca8MyDT70J+kW2Nk2sXOisxvvSjNrGvfW0ARRSPJMHqqsZWOD+0qfhE4fTLiDP1DL8ELlirqmC76JTgaIsQpZ0SqSyZKgyh6PSAufj7ETKSsNzbyc5ooiaF7Ktcjd+Z/pZEkMTyV0hJJHNFFeZT4vYGUapAvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=y9XTi4WtlINfi2geRx6PvSUVHmpJHpNWiT9m+wrvbHlXIl/PZe3Z8+gI/H+lHrHyXcsTbRFlsrk9kLArscCGHbtli55tZVx0qr7Td7xKuJFg6Y3RpneNhqg2uwlzzBPYOKruVHPV3UxsJsdFstpyHYNcRXKKnGhSl73zWE1oLKw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7622.namprd04.prod.outlook.com (2603:10b6:510:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 08:44:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 08:44:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
Thread-Topic: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
Thread-Index: AQHXUpPliBmZxnIL0E26tQzlmDuWRg==
Date:   Thu, 27 May 2021 08:44:49 +0000
Message-ID: <PH0PR04MB741644B07BE47CA6BAFC74E19B239@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb560990-333e-4a25-d965-08d920ebb045
x-ms-traffictypediagnostic: PH0PR04MB7622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76227CBB97CA395B01477DF69B239@PH0PR04MB7622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QEHbYUS4tDV35q83XVpK9GY6RCE0RcpRwGLf82a/jrcOEoVPeuHzdTRDYrmy3z6vdEsfOMw79NlUM4ZwK6MABDOs818GeOChGAnBwAYLf+VI2czrekh+BZB2MZzBymGsySM/yf8UMhVSv3e4/90v0/aDZ12BR7HHe3Y7zaUkrSq3lUTBYtjKBeVpkFemWU9epqIBhhtQpRTRjUOO2CKteE+SYPdnB9jOwV6P9kRy68SoPKNOeh/ngYxkhWOH0AAccO5YjXDatjXDyw1WqNznwiWQJBm0vGe7Z6NFLar5Pue/AedMfTq9F35TBW1nKkwfYXW5ayRg1+4sV6oEyuEZx7Rh4/6CkWTj5erPp0yWGanFXmX62P5Vd7cr93IZifQfV9MvuDDVzmtXDsyGEWynBVRNwoYdaOXhaQLGx8S+7jpjCiAyRxAR6y4kuLahxZH8JgqY2+4W14egxxzWY8vL4wTa98hdoiYytDaAyjc/3UuE4bTw3zPilKMX3KmFE9mrOXiaovzl4kHKDvCUQY2gbLBdbYOF0f2CB1ynYqHhkIi+5XYoCbE0/nKqqy/1xxN5VXUkzIOO61lH5g9Jvv2y0b18edm7rPnrGaIu8Wg6Jh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(26005)(7696005)(478600001)(6506007)(86362001)(4270600006)(55016002)(186003)(558084003)(2906002)(71200400001)(9686003)(33656002)(54906003)(110136005)(316002)(4326008)(19618925003)(8676002)(8936002)(5660300002)(122000001)(52536014)(66946007)(38100700002)(76116006)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Nse0lcKvLAp1aaxWM8Mg6654az6YAQ8pIIuG+QfaumZLK68OxcHsgbtgcOjn?=
 =?us-ascii?Q?5LmOw//bU+mKpEaP6XoSrSR8N7oZn50UXd9UqyeBzxASYzlVyUgMncKf68po?=
 =?us-ascii?Q?jehV+7qSjlURXMMzmAbdXSqFVyHA6R2uUJ8tkR+bNecUBhkB6EB7bgaoU5wD?=
 =?us-ascii?Q?cyPmYBCTpG17Mh0gQtR2jdowKUcuOEZgn4c6Hwg532VonGuIHqEw+Vk7MOzb?=
 =?us-ascii?Q?uTzPvRidSv4TzZKtrG5W3GEOXOvEUCZdlyaNrVZsEo/MUO7H4HTSJxolgkVT?=
 =?us-ascii?Q?wt5BtDsux9EHj6/4kEaidbJDb4BWnYEyAskfhfQzU6D81OqasbheJbnU2dgv?=
 =?us-ascii?Q?6B4fSeujXINdpUHIyRVSq86wk7H1dSWkrYx29bCNJlWUtq2VcqEw7Bl8rPQj?=
 =?us-ascii?Q?DdvOE8iIVn210fPC+KOa9259SuhTPkm6wOi5TBkQ09KFaGa87o/iYTO3FK6j?=
 =?us-ascii?Q?gkprDFKfyh3ryAeScas/LzIPTuF72+pSL5R42z9qHCuml4ctpStxx0SLZwYP?=
 =?us-ascii?Q?z5TmkgPvcDE5X79s9Z2mvwF5662FJywqR0JXsZZGEa9rvgravrO4vg+SPtv0?=
 =?us-ascii?Q?zsV6BenaC4YupJnXuuH2EMo0okkrcHa2efj7ABOspZL9eKZ6z0MFwFD5G3W3?=
 =?us-ascii?Q?c4YhhBxhtCxI7TEc5EcsNVUguCqB+g9D7lZVbWqPT9UxgQgSeP4RzvkYtdTV?=
 =?us-ascii?Q?xSJUtYyISRoQjogt+gVMvCblx2L+R5qL3dXpWNGV0woWD6pa0SxlPtbtCevK?=
 =?us-ascii?Q?ppYXXaN1JLw8N7oPTv9Qs80fvO0+Sq6xSYbf0oIFzo6ywX6rQv+lKZtaf466?=
 =?us-ascii?Q?Enffy0YzpkwhVqI16no4xpU6zM2B7aaIginJQISNaWO0w/z7/yOVmaRux40U?=
 =?us-ascii?Q?W6WwgN2JtVnQssfSRt7YhBbEfYg+1eyk/1aB/4AK/XjSbWkGdGd2w6jn/F/b?=
 =?us-ascii?Q?mg7yS83dZRC8Uh5YjPCmV5stQi4JyuvmV2T2qbuCjfPrX8Tf4hHGO4hWy8E0?=
 =?us-ascii?Q?BnyC7KsodwEk26w5sKYa72TQ9s8tJOPr6z/wB0gJ4Sul777s/lYzgbZMHUsj?=
 =?us-ascii?Q?30qoIMtMZ0bffQm+7yL0sIhWZhoOEsa9lh2uBwmzz8ukn/fj5D3fY/ZBv2G0?=
 =?us-ascii?Q?AhOsgM3ikkHkFl0wR3v6UJ2gw03SAT/MK/oKhnAZsKISK6Hn5MvEkCgDXx0k?=
 =?us-ascii?Q?yAWKoLgC2Pfy8qkNyL3tbL7S4RuWJ7wmrDypmCYr2ErwSMyKs9eQnF+rNlKN?=
 =?us-ascii?Q?GCdtwZV4lN6q+Y4LaJKSUim9bnRf2WpPELBJiam3hVdiDYUGa6hnbdDHaOEB?=
 =?us-ascii?Q?EyzYtOM8ZYThfLZTk8+t900TbL083gbJVw+CSPlAjqRB9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb560990-333e-4a25-d965-08d920ebb045
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:44:49.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: An/sp7wB/KuGwDvuU37uVv2/hC7TIvtCUqem5G4TL5Q2VaNKNV08U0qij4Ec59IyahR+SZxNqA+WmEyyhGHvyWJ172lJ1DfowUfXDWCGHR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7622
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
