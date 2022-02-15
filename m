Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05771C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 17:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiBORER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:04:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiBOREQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 12:04:16 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CB117C80
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 09:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644944646; x=1676480646;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FOq9P8YxA88K74C6hulAs1noTZG0X6vfpNfSRdvLM+mS4uHKFkZqUqEy
   Z/748EyMeLjSvTle5Zu6tins0jv1fXhNIcHQS1WP1EmSmmpZFMpZ+swhu
   MyWWX6lJJirTYo/9JTkJ8DB/K+4185tO1lAKeH00Lp8ZsnVTThskPGnLx
   OWMOcAIPLjzkjSjpdl7e2DyLqQ8U+TMxZNg92kPe6XyCaCBRWQQLWcOGx
   i3a7B1kmYyw0NieXZokc+h98ZMb1hRreq0cR6avPtUJk/8tMW01qhm5WG
   J9VkWdNAvxcN6Po1DppkdKI+Qx/W3E/AHjGiN3xZtpetIRZPJotZA3yfc
   g==;
X-IronPort-AV: E=Sophos;i="5.88,371,1635177600"; 
   d="scan'208";a="193997497"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 01:04:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpmLwOaBqtoo/hmLoNPYGbUEKkLJdQf7OzM2W4ffnvtI5ilk4IbpFt2WFNoWf004TBKDsAuZUce35x58+XdZZEbILiUOdBA1JLUwi2vqyX8QnyvVoBED6TqpkFhKc8fj5ZbcovFjJbXfYTH0Q8ufJrK7phzp3VxmcL0arE0RL92UrOvW7VVfrY+6Ujj8XM7q+0grdeDsBwx1rYR0KgAcSFAcGAdW9qDnGob3O5e1u2LQnTTubSiwVCvDbHVMQ4iYBm/jI0a+oxGY5hVXSBuTLsw4qe0OME8rnJsfUrI+vK7Zaqw/r9qycmo4a8Tej824Hld9q6l+EwioGngAucrOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZtIlSAkE0Pr7qZByB9UMbhRbiy0J9JJb0mqX5/euxpunIYFowCoVepJLIwZnzcAyjwK11UYqEK95AfYO8UDfzwVAj2DNCjy1doqOB+mKo2ahVEAuJqmZnq47JlVUaoz+IfNthTFGTRsHwN9zIIEewsaXjt6NnwBjdu2jEGaPUgZPXEIbMxXRFYpXiHRDjPZ2yDoKKsGv4SrP7FvpaHVFCSVG1+bmcrerZKRv2dAjRj8BNSEP939xm1yyaA5GZ2PEA8AG/chqebgtQE7/9WEteO2HVaVG+iyWAvUoFdFtfbOsnatcfNoz4jFqJR1cNmaumqHzrITGlVWt2iCMgPYPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=b4rFu1gxy/wTeBOM279yQPezAUDfCSk2CqbkltftIcIRZp3CoaYnN4RUzk1uV+pg6SYzP/PsQtirN37SU9ED56FfvcU5U2ez/jUGAV7+qjrbx4J6LoK4v7hVy4NqpLu93KI6I3uSfOsTng68k8vXW1SOljq6xEnrkQiH4ZQfAqo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7269.namprd04.prod.outlook.com (2603:10b6:510:1c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 17:04:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 17:04:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH blktests] block/008: check CPU offline failure due to many
 IRQs
Thread-Topic: [PATCH blktests] block/008: check CPU offline failure due to
 many IRQs
Thread-Index: AQHYFCvC7Sn2/GDW4kKXTSOFzqoQhg==
Date:   Tue, 15 Feb 2022 17:04:02 +0000
Message-ID: <PH0PR04MB7416337F103D6066559EB0329B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220128094512.24508-1-shinichiro.kawasaki@wdc.com>
 <20220214025645.if6ng3m5nrtybqz3@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 893f0c6f-ab13-48d7-0eaa-08d9f0a52af8
x-ms-traffictypediagnostic: PH0PR04MB7269:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7269BDD6FA141FEC53833AC69B349@PH0PR04MB7269.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rv1Y9goKdeITe5maPtvPqUj6DtdFRzuwj0IRYGnhAQpTrLON92akrs7uFoW70hkl5Sp/7XS9Bd6VIJsA743BI7Q2lsjpYk5Mh7g0Hrya2AQQTysHNuGzkbCMa/5M/J4OHa5wPATU/AiHAITSA3tPiJamOhrMf8Vvcde2YXyreh/nBPN/5hL/4G1tP+U4MU10X9Tm7t/peYZ7I0fZFyyl1jaUbL8DnzEBe2OLqKfug62yT9//lxnmn7P8ODZ6oSuEg++QiGigtwV/HN2m/FcTOFun65/iWnhC5VKEF4EdSBYaQowLHB5uSaehhYU0mcij0f9IxG6ejUR+F/YIOLYL0edEyrsqX8G2uic8/hynmsd58ZUvZi0bYEiR8PGZzIQemDzLmOfQZhU08SnhGYQdBGzMWTceKNm1lad+Nmd3GZkz3Y3oSMDpZ8frP3dJf8iSEnTkcMCdIeen9VAqnpQ0As1Ja3G6JjcDYQYLeUmRtihjhhpYQui2Pt9UKzbR9C9JXaRKauAGpDDzb6sIF4LKu2o3Bg1cJlzXtzEh80ydHAaabU3TG5RZRe0T83JnG2vpNVhyHEpDHWzCVjxr9X4V1R5ljvU4ITth3GwLEHbMIuDuTLrXte1Evb9CEMr0sx4SK+1xS4aa8gEgvWtcM2l0Z3I4XdMwiUAVuQRJc3LnnVAghTY63bvORQSrGhFbTQIW+5zyOTUBqv23LpJ1crU8jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66446008)(33656002)(66476007)(316002)(54906003)(66946007)(66556008)(76116006)(71200400001)(110136005)(558084003)(64756008)(26005)(5660300002)(7696005)(122000001)(186003)(52536014)(6506007)(9686003)(38070700005)(2906002)(8936002)(55016003)(82960400001)(38100700002)(4326008)(19618925003)(86362001)(8676002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?koZFBbFkCEBiKxmD4FmVzOFdG2cqT5bkSXQQso7PjQhkdY4cQdcBIM1jOte5?=
 =?us-ascii?Q?m/Stnqv7PlyWFUd9Tt6lv4k2E0+3jUT/7mxGcZwxwY1N8JOD+17cW6l4RI83?=
 =?us-ascii?Q?SnfhjukMpUMKc58WJTWuahFl4wFlnmqle4NPLk02e1n+KAxhomNQ6ujiuhfx?=
 =?us-ascii?Q?1UPvpTkUjakijH/S3CFvaSNePdofEECjW0Zdjd8AaCmETuEJ1gkTT7bI1o5a?=
 =?us-ascii?Q?6RfE5slKG1k5u0rOKiOa49o2PVXBsskjfythw6WMRYNsjG3HHIWUN463pIGm?=
 =?us-ascii?Q?M5HwnfG/AOtA333YhIeSYO1Cp+YSmXpf1n/xaTtzW4TaRJy0dXkyOgGefVBi?=
 =?us-ascii?Q?nFLPjwqvLp7rjwKhMdENfZBP1+GdKXlfMF2oD9qecZ89xvWOEArEF91ZV3pH?=
 =?us-ascii?Q?vHHUJCelCWxrPe32OClstffTUiKgZOD10fg8fD8kPBZShsi4YgP9F59BL/FN?=
 =?us-ascii?Q?b5tNWb7MDTnuK7p6hjdX8r5HW5LEx9F4vOIPMIIKw6o3mJ0mf0IH0p54rUS8?=
 =?us-ascii?Q?B3dlTEDzjq8ACqEbr3CU1McpVPzNySkemmG19rZgg1vZNpaa7/JM5QSayRNo?=
 =?us-ascii?Q?AGxnyzdDg0gPRy+Uud9W9d2eT1IFin6hC7qAqw4XClL0qFFr2460eVCq5z8z?=
 =?us-ascii?Q?23v+HTWOm8gQGhYHDbCsfWH3X25tNsotVHnF/930u6RLMAJyWswPTPtKcDBu?=
 =?us-ascii?Q?WeIm6sd+bgkyAl2d/jyb3ziXuzdSfYr0n7ita+hViOWLARVDfQ/MFWDDhT/g?=
 =?us-ascii?Q?LGg9BQlexLeZN+B+Z/hj746XYp4/L9aUIIN5AOVH9FvrT7Bwvf63iuDT5uty?=
 =?us-ascii?Q?pi7P7jOk8JvrmBaTVtLqv3edNdIxiXJKkThbPwjm7/gmF4fuEaq8aHxMk4Ro?=
 =?us-ascii?Q?uBy3+lOPtAOwGyC8pe1/Ot4GidaapMBzMDE+aCyoQFEGMLnTNwey8/pxMWOC?=
 =?us-ascii?Q?h4dcFcG51IWvNJLBUiBbC9wCkGX6mqd7Fvcw55NCWG1hXnv56iqIUQAO+3ks?=
 =?us-ascii?Q?Cn4HUs1RhDG1qMJnFBw8CGvGffiaX6OkJQvt7Dd2o/LPoy2wznHE8ABAC+tP?=
 =?us-ascii?Q?WBbyZT+fxoEfU1TvlZu+5fQezkl39AqBPJHkUeh5uYKyGDVSIsKi2IEi1h0U?=
 =?us-ascii?Q?lovNPPjqXJCBQoDz41Ny2eUkWHhyyfq9zLNIIxXnmlzLDePYMt4+DvJlPeSx?=
 =?us-ascii?Q?0jV7P8mMS9LBDzoMkvIEkyNRlunzqqdU2kRE4fLmZ34pmHTkyVLgPsfigSE8?=
 =?us-ascii?Q?p3qyWM6vCznobBoRKSQY1ZJIa9wIFCy2RURqOlq9FfJPR2/Uf4vS5MNlhzG9?=
 =?us-ascii?Q?usxMrYZ2cy4DRqpUjZp81L6qr3OimgP83vZuy9kYzB550oShNY+Ko9L8A8GJ?=
 =?us-ascii?Q?eGz7alN3Zc81MWwlSaYebePY3585PaTlLBiQLJ7LomSpCdDO9/rEdZJ5hRbB?=
 =?us-ascii?Q?FBTEv8/yNXF11+TiUJg1NEfWCjjUPcaLFafDhtvLndPmiZ05WbiV2CkSbqoV?=
 =?us-ascii?Q?XWsLik39NGRJV8eS3yHx4otcaRugQ9Xn95l/b31kPlby+JzEn9CJVKVnvNhB?=
 =?us-ascii?Q?AF7vFqSZC/50Fv9B4Co/dDXwmtOn7cIOAEqGuTL0tKGPhvyzy3AcJwlvpZ5K?=
 =?us-ascii?Q?7JrAblBhLYT3A88/8lHNOZMaqXP5rMPtn7qqV+kK6zQopsN8WYGGWy83ZSd5?=
 =?us-ascii?Q?NNYv1QSOzXeSluCqzOGqqWs6s3k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f0c6f-ab13-48d7-0eaa-08d9f0a52af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:04:02.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kn76yn5Bsvh78l9DHww6VKksplpSYpwqw3FVtrFJ4hEN3hoJ4jHohBf+dG/SndwtSzrziV2vUePYENUEGE85BbLJ1dZskWNMVT85wiZ10DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7269
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
