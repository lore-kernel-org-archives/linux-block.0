Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1F7C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 12:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiFBM2g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiFBM2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 08:28:35 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B861B1CF5
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654172914; x=1685708914;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=brdbdCogvUf0PPR41vcE0fOKW7BxN74NqLFoZKyp9yXhuv+XC7JUu1S6
   RVcIcKr53K8DTjbiGn7qp3DhDMXyt4fwJE/afHTmuJqzcFIRC/uYDnV6J
   xqwb1wRvGFtqVRIuuyLjcS3mta0MKxJRzLy1sf/UmL2Yaa2xu4N19ynb9
   GhDX+2xmh8gleMGFq3CZNSuHwzSXtAbr7BWmKISbrq1sXqS8UCI8Dr0ks
   n7mWR3iY+o+qju/UuNlfkVE8G1qQz6CXZKnzZZaYOcWdRNO349qozCRvQ
   0dJWHi/cDJ4Ns5EQmOjLbWxsc5jraqFEMsIYgoZQlPQbPCmnGr5QWUe2j
   w==;
X-IronPort-AV: E=Sophos;i="5.91,271,1647273600"; 
   d="scan'208";a="200845237"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 20:28:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTxuWbRk3SfyRSH7rxrIKhbF1b/ceKr9fu8cNLdOIOkDMD69xwQyHDxPpOFvn592nlntwxu7PbqJ5PWtrLz4UGqEGd6Sww4OmXtJc9Fx0iqta/e7Y7GMzX3v1+pDWblSb5l8M84SKJRItfzvfp+trdlt2bw1gz7g+4tublwKqLgkQWU8aphVgHwqcE3+teK5ve8J34rSE3/XChZSuOnmaZnqBEXMlww5XblOqxi+WzM8rMwzNlwD4PNqn+HcefC0sZCfOB4rUKWgQq0Njyb3iGeAFTlh7T9H0j/92eX/ti/nQRSWnBFCqwFGZV6QdRFLr/kbp7OSaJ+uwWAWtiSYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lt0jWm9V2nUde9sYNQaMkM2lf6TIGrEfmxFF3sDFLMCRgRejSwFGbOCgVpDcFqRu5JG+XXhZ4rxRT+ke1zl8gJcJm/OzLnbZrA69DZp2ESjbL/uUFZ/9n0GIBaFr2kpqElTJxrcbGJnwpkLbD4VfUeEjDKsUaGwriIU1T/qE7laPASZwDOSG36OiXk0dIcCdy1s4C1idRiYiX/dml3elusG8TRrWlgapkkJqoFqpTNzo//YSEkXcSN5mW7U2TQNRQTRtaqG17iRjT2bMiq43v62hFtw/eSACbF8OPudmBU3cK7sdW5tevYmPlsKuIeuhFAQ1AWyXSYb4YRcdEFMslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=xwI59WEHqpD7chAToez2nbTGLGDfDtHQMc6np+VGYG6AMKjKYvNDA6dlnwVQDb5JdRIeb6t3VlxE91HfDuz7SjPNrW+yqgU7pDb2ZVblE2zlP9H+h6lIf2NHc98srhk8Hg49HFUKsvgDez5WCA4fKN83a8UCQca2EqOkeDUhb9M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5852.namprd04.prod.outlook.com (2603:10b6:5:172::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 12:28:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 12:28:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: null_blk: Fix null_zone_write()
Thread-Topic: [PATCH] block: null_blk: Fix null_zone_write()
Thread-Index: AQHYdnjhjSS4Pp3NYU6VVu5/O8EosA==
Date:   Thu, 2 Jun 2022 12:28:29 +0000
Message-ID: <PH0PR04MB74169B2C972022C990A3B7539BDE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220602120344.1365329-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89b78afa-611d-4f57-7a31-08da44936670
x-ms-traffictypediagnostic: DM6PR04MB5852:EE_
x-microsoft-antispam-prvs: <DM6PR04MB58524F50316E5DD61DC33ACD9BDE9@DM6PR04MB5852.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bo7Z6jLqXoOyiGJHyjHeJK6+5JrzwE32SZug2o4jyFDQcPhfYWv7YGDGkorlLlDZ7wPwib8nU5BqWyBLnMBbhq+Vt3oBeRh5GuXceImZzYiSNG/+27tnZIbZSSrPUggqanEyde3c9XrJuVzjF+6vx2JduXNrNdNzhfLIVZRnXEvqnhoWYHfHh8V//b9yMrOA9n+V7Ot+k/X3cwcL+39pnXJsE/wvkT1OXmxpa5a68UVX5B3dqSaKwYixw3xnwkjzK7Z7pVNEiTOxiQAvgX4dVCwIIJByAviLLaGHxjanvz3MPRMW0gR8DfpW6Qd6kR03zeWm+CYvHYaXEOl1It8LicbAqE6vTPgUGrO1e/yhSlB/Wrdb+74GrgZZTY7e/Dsgl5YNgz4TEYcGMMH+H3o7cx9+SRtlNjEIZzu5Z+l5DnizQyYN32Muzrg9LEQ7X9uAIt6tNco0uvXmpPOrAxWW+nT5IxDWbPBtks8MayOfe0pBvCQEFVstf5vM4Bcdc0TbxUlMWVy8LIfrUxxQiMx2vmzt1AtrsWiOhY/xQMJMUOK85cRRUBH0lVtTvSSYmOH+3SANvjgKOW/UVX+Il2JCK3MilzO99KP4oLBSa52EntiXkOQPaRkXifop4CNM4D/ZCQE6CPYTQs1YdXr3PvPZEjYH5nyY8IHObY/8b+YrWmaFmTRns1HU3cX4bOIfMT4ZLMzKF7cI8kzczhVdp7iTGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(52536014)(558084003)(8936002)(86362001)(4270600006)(9686003)(7696005)(82960400001)(2906002)(33656002)(186003)(19618925003)(38100700002)(122000001)(8676002)(76116006)(66946007)(64756008)(66476007)(316002)(66446008)(66556008)(38070700005)(6506007)(55016003)(91956017)(71200400001)(508600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n+7AiIdcW/W3N00nSxH/xviWNIH4mp+ENvtzBnosE5N9j8KFmgZ3WeG2uB1T?=
 =?us-ascii?Q?Jwrb+sS48jDNiSLDVlNAE97YbNEcL05NNT/u9At4jFOTGHQomCrKAj7WeDyt?=
 =?us-ascii?Q?55OrY0OsVT24KZ/IU8r1J9rCkWAlmIN96d22frUvKTeHUa0thOeOcLMEkSq9?=
 =?us-ascii?Q?jEwK4Hty/JDUALgkLaC6SYwTbQ1mAdFzTo7G9nlgKmjMr8QUvrETNa5NNfVp?=
 =?us-ascii?Q?dz+0r3EIIoJTL5evsXkEVqRtqT2/lEPZepXybLqCG7GXqZJGmrVLKEiDumLP?=
 =?us-ascii?Q?nXETxUHg4QzavXi6vy1FKu65pme9kGIzzt1lMinIfjxwdFLm48ES5HrmoQ2T?=
 =?us-ascii?Q?7Wo00vLoqHfDZszgcCXamQS9qt/KGSpu45qJRslk5VaFBjZqVb2c91PAATfZ?=
 =?us-ascii?Q?MUpim6nnLp9bu8kqGZuIDY0SWnCSmhhsd0SbSjZwl44B7akuYjW7yu8LjG0Q?=
 =?us-ascii?Q?NrAYtkw7uwWWH0J8i0aKTm3K7A5ZZ083NBCnvrQQ+drYhUh4x5iLJE2iskal?=
 =?us-ascii?Q?3nNgeOkEumKYJgJaDn+TGItUqJK6bOkPn2eaeE4hdC3LKQezIP7ivPalNZ7z?=
 =?us-ascii?Q?OpO/Oo8ZJYXj+3Ozfr+ASZcyUW067J7acUHh6EyJP1MCTyjm6Vca6+hhYdsA?=
 =?us-ascii?Q?hmQUeEaqvF7JIUmFsgz0dMqrfu0uxDOh6+a4P3FmNPP9+J6QhSEs3xLfhaey?=
 =?us-ascii?Q?06Q3cWIsfVGzjKL+yxjoaXHBCA1lD6N2dsn4XkgMXou90zDMtByizyekVziy?=
 =?us-ascii?Q?mglTIa4lt4kb3TsrWGeCa55+2BsFwjBDVlTL5zwqoDacBOojOGiD10CyUjZe?=
 =?us-ascii?Q?UT7/vAa0Y7rYKup8fOhi5cX2T9E72mU5uWEOcIMHuKfXen2u1+jhyqHeA/lv?=
 =?us-ascii?Q?SbMzZ/5nowO6gOl0202qQ8ZSReTsWUxJ8sUJuhNVP1oIoXo9PYTTJ+3W9MuI?=
 =?us-ascii?Q?TTYM0s9Sn24w+cMG8PQsBMPrvX/ddLqdFRP8d9L5WrCuVadXrVgPX3N0J8p7?=
 =?us-ascii?Q?D7xxtoQZsvx8Jns7Lf8coRTaXn4vcd1p92diynbHkYhj+Orqmivy3n5VOwh/?=
 =?us-ascii?Q?XF+8jY79HYS+xnahGza7oXJRFosE36pQvrNim9NR0pp6/tjN+UTFZRhoA5Cw?=
 =?us-ascii?Q?8dEooJExGiNSXMuo0HxMwwEhxsXCkBRwJFk/nbssSwsEjCkoX/3J/UCT2MwJ?=
 =?us-ascii?Q?JWmj5FRx6I0OekG7FyY3yTLr6DXjNIb3gV4gI9JeyJNx2VaEPuea9g9xsVOn?=
 =?us-ascii?Q?XPdTovQZQrFJIhVp+PTELPMueyGeujXyv37yv+MHLh1EdMhmOx4lL7iGTyfz?=
 =?us-ascii?Q?GLYcMy0T2mbxT6cxssf1oBYxVLDn5LJsKafqbyiH1uv2DIMopmG5yJhHxptj?=
 =?us-ascii?Q?VcKw3accp4a3IU0Q6E16W6V2Pa8FpE/Fg1BdF9yi8adxOCzxRDzNrKkAHGwB?=
 =?us-ascii?Q?mzoA1d1rqtKppTA8g/OMBG+fpPdmwJczRat4/49wDdPXMb6wmzXjPpolwNvN?=
 =?us-ascii?Q?QH2Ov26V5OJJe+Otruq2simecKoMnuf5xlpcCdCOgEFN+sY2p9aAYykzlKqx?=
 =?us-ascii?Q?IqE+O7kbOSDkXRtaJuBmddtOykU9jhBPmbW6944/CQzyCH7sgmJQdAUHP5Me?=
 =?us-ascii?Q?RGszJKC9F4kYqb+xdXrv3WmLLSzKgvMa2o2DGw61/mc6GadYPtFLtFA05ff0?=
 =?us-ascii?Q?Zm1zC3ZMj7yAYsOFRQix5rlyVOeQQQdczlJ7l265oVTiCAZsWaGR8XEl/inl?=
 =?us-ascii?Q?y6QOoqY7ygZJ4+kFqxCh0ggucou0RzBbLWraW/Sss6XhvSeAoiCX9kdJoSqX?=
x-ms-exchange-antispam-messagedata-1: dco5bumMbElzUhVTZKmzvrwRzuXwpo7lsBie0/f8Ha54/e+03vuxrKby
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b78afa-611d-4f57-7a31-08da44936670
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 12:28:29.5718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5JnHO/imAbXmbQD78SOZHbjH/3RLzmlYCQUrNCH0VmUv6LAgqbWqJbaTLPkKEXjLL544coaez5cDKpEdbFWoiz78vTwkbocEaHu/FSMi0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5852
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
