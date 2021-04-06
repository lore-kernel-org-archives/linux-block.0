Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C7C43461
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FEBE613D5
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 20:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbhDFU7Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 16:59:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48318 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhDFU7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 16:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617742745; x=1649278745;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=h7rmZbeZLsNabW8xvbSGyTN5jPgTqc+Nf0ljtMIZ3PE=;
  b=b04TJm2Bj30A0r9GI5aLnwyYZLmthGTRON+1psLsseTIiqYZ/pKE+woB
   os7MWkETEsHJp/Ez04hvi2mm46noydUawTftiArJMZx1NFZbQp6dhLSi3
   tvclKz+ER4W78YWjiPqiPPzQXwbwWJ8AOd0GOQY70LWyAcvL3fTtYKTpn
   Y/KUbwYMLJ6Uhmih9iRGq6s5ieZrSb9oVHMTHfXwwfS0ESsPFe0adEX4o
   s2eP/7CJSTcSEF6IVQhvX08NTPZ0QTbhdmyFt/SJJSW9P8sAJY2TknyCq
   Wc/wFe8nLYYRe+plattZNn2mdrp+SUU4yR71S+RMEnnHOG7/Js8SDjV9I
   A==;
IronPort-SDR: ran3bcaK0igG4gnruHCg5VBjTJy0r3khsaP3LrA6PzzugM8mLDIcU5A7bJgHEcAiecuczIXFqu
 FZtOgDGyLt/7BMC92FsoHH4RStypxn3JkEH36p62jngwBVAqgpf28OyOMOpZOLBLOKwffPS7V8
 Z33KSiyLr1Yrdl79EjD6m9OC8USX7Tei1g0JrVyfhRErkm6FV+d3vDJJ47PyRym8kHYnyv/8eE
 xB/6BDfBzGVERNQeDKsg8QbEkzrBu02Vls4FaYXPOYDWyjUgmcYip1z8v+vCzxDFzZz/wO5C7P
 UeU=
X-IronPort-AV: E=Sophos;i="5.82,201,1613404800"; 
   d="scan'208";a="164001680"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 04:59:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D07/UT+osJ+fiSlucmbAWn74e59Z519NH7HFt3Eeu5SsNAMTfWd1AR5UtESCi0U4wxRvWZab/jv0kt5OCmyLexJzxELZCKEczJDpdpwCzFi9I4THhtRl0n4zVNy6UNwWOPBF5x2ZQmsROzVn2bTrfnrJ+Cv/T2BHlnrrYGHe09RO8ookTo5DkEWdYnUU+D8bZtN1cMjXpVL84WX74r5hUMe6Q/ynuSpL733iFECwoGoilQdcsADP5LI6yBzmzTbUP4FMJBuX8RyTDf1spRs92FQ1pqwzjmiVpabcsFbh7/aHyeUbjO22/5x70Q8rduybII8dhkHWChmYrTXYiya6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7rmZbeZLsNabW8xvbSGyTN5jPgTqc+Nf0ljtMIZ3PE=;
 b=Jln0UB2LnViydABrjaNE/FoBuX+yaA0YIkGFJgcvSxGBcKbNiLgZ+/0+AAuRJX2CKZ9D/LI7HpWF1cnLwCwTKfM0qlgncBON61QML1t/k9GfBPgcM/jfzsplpO5Hkz58blHM9Gi7G82yUOdBzNR568Xzq0cIM1PgJLVu5FgGUT8pu8JXgT8wWhgah/Ay+uhdO/uPsfbOpO8RMXlsgPl5JXJ9W5nxtZY13y9QjXJ0P15XwxujgRDGuQqj4z6Asg+ubhVH/JOf2SuKLq03UAv5YFYR1iwmxSsX5a4DoOtEDSyMc09wBA250ELsZgxJMjASHcNvkMJ3RuyMEMmme9eXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7rmZbeZLsNabW8xvbSGyTN5jPgTqc+Nf0ljtMIZ3PE=;
 b=qMAVJ/aKtRo2oVqk77j6WeJaG6RfgIEeDWkvNUiO2HynIs8IIo5DJML3wkXpXsQLiGZTEF2zP62bAcNUjQtPnf8r2IqshAbFFbOmrVZ3YSu10IL4SD3VJINF+3SB6kexS+H6JwxbfHe3bByzd5voeKwVHTTjabgz6nulhxJAAt4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7536.namprd04.prod.outlook.com (2603:10b6:a03:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 20:59:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3999.033; Tue, 6 Apr 2021
 20:59:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
Thread-Topic: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
Thread-Index: AQHXKyCkNN8JLp6bNUCr4D5uN/jfHA==
Date:   Tue, 6 Apr 2021 20:59:02 +0000
Message-ID: <BYAPR04MB496592C2BE54931FA17AFAE286769@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210406200820.15180-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f07dfe4a-8cb9-4313-1a43-08d8f93eceb4
x-ms-traffictypediagnostic: SJ0PR04MB7536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7536E2EC17587C1866D16C5086769@SJ0PR04MB7536.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCKtCuneiVEsNxzugDycUAvZagNw8cvLdTsNlYgozUUS0uWznukJAppdBFuGp4lEx0JrzpdKjpBXx0C0P4sswH/cMnKHL5ZjsZD30LECaQVngLucc/43rpJvnvvq00xdLpmKvl7U9bnOIwb5ycYaYeZziiZ9rsjpDUIsf86S8Jm66nxtTEIZYmvlsK7nPC8WvudDmMxhBDotK7JPLQM3/2Mwok5NWbX1v7kv///t8piFTSoWh+0GfkUUMq4sLIPW8B9yj5vcJfbIt7+M4dkpac13F1VZSUTFxKAeccO7rF6bg6P1rEDK1yxpYfGEytalbNt3Dlss16AOZAda/Mv1jqlReXkdcbwN6CJ/6IOqIopmv7EqJ1aHqEawBtSGcZtlBzKwrAhDtgRPQ829tmT1snTA8W0zRKQUm+7iEH1u2L6AsD6lMOLUi7QEdIo9BRd7nlJEppbsTC/KylQA/kCRwmT9/0Q7CGZvTVJuxyIVRibunfZFSCzCqKsrjZZf/Tpeo2Q1Cc/EcRSTe9UBMT/Dj2OkHkQQpDPzzJ2oTpGI8q6Y5iXRuR48w4BAS0CmXcz8KNNq6VnPI3QbcAYl2yxjOPnK1FIGcSOAcpIJHp6SQtonPcW5wBufnvZBnyZUf/x07AUp5hn+ZLEF216SgAmGRZsCPdq/CG71Q1yZJWKDf7U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(66446008)(66476007)(66556008)(33656002)(52536014)(5660300002)(478600001)(64756008)(7696005)(55016002)(38100700001)(2906002)(66946007)(71200400001)(4744005)(4326008)(54906003)(186003)(6506007)(83380400001)(9686003)(316002)(86362001)(110136005)(8676002)(26005)(76116006)(53546011)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?41AeHRuSw2zdmyqTrG0tKuHhwaY76JEuNFo3+xD0v2YYOXMTPe2dU38ZM+aw?=
 =?us-ascii?Q?Jty+PIHhSmPb8Zj3rGsdtaqda74m47VPJdQjYsEVcKdqD0g4ZzAYQUV0TWAi?=
 =?us-ascii?Q?N2TJPtSUaRHMPXTJHIADcxRtC1L12HAxunV3WC5ujrnH6S8Y2dzOIy9sX3hk?=
 =?us-ascii?Q?DCfnX5WrI9wDjsYhyo9DqGqqLDJzkSz/uxmdYQxM/9wkb+4bNfKs2R0Ba4fX?=
 =?us-ascii?Q?/aB9iYjaE7bgZdXkhGb9QRA8GSir5yGHgWPbChPBz/6BCjCcDVPBuI8rX6DJ?=
 =?us-ascii?Q?uQ+2U7+421sya++b78du/S7qCNyr+2Ihn9t4z/dJpGCMqRR0wcmcxSC3ulRa?=
 =?us-ascii?Q?l0E90lcPSEytNNKetoG7R4GaKCjkRtwF7Z3l+43aaxi6VVf1HU0jtsCBZuDe?=
 =?us-ascii?Q?rXicNTEnhZArSHqiDPPIa1A41I/Lx5QtBaSXln60juJa0t1v5MC9FVo5WYA/?=
 =?us-ascii?Q?Z6lwUXmUAe80Fc7+W4MQHQTwvLcXgmR+nNfKZ6iXN101nmVVjvbK0CCiIQn+?=
 =?us-ascii?Q?YtBH7+hT5L120UcW9b1po5bpgJdPKvgbWrMCPjRMckojy0ZsbWW93TOWgtee?=
 =?us-ascii?Q?mfRpodY+0J/cyL6f5PxNnMJJI+2CEIaA6CMRCO/U4NTMdXbjvndjQZAqyQn/?=
 =?us-ascii?Q?gKtvN5ZBoeMA8HFLKfyZqj+RavCgncgIPA7If6K6diuVgV4V67dxT4AZM3Zh?=
 =?us-ascii?Q?v3zzf0+NLzHiyIpeUXVZhHdU4s7HEvf2G84pBbVr08bfR6YMuP436re6shRF?=
 =?us-ascii?Q?eSjnC0pV1ARD/VU4eKQySABhb9ny8GJR+Hv6TrOu+RTPGYU4i+gFlwFABE0T?=
 =?us-ascii?Q?PVB5fLLPV/zVcLdeJlqTobdS9xgKlo85De8cFmlvzhuuDjBFwy17V5kxpE6c?=
 =?us-ascii?Q?qXUkaUSD7g4M8iIGRbYdNBsoOWkFMP4gQHntHGcLcLBVQnGCwQMp0txN8c7t?=
 =?us-ascii?Q?JH52HOo/sWiuwd7XvtJZJlq6AL3SAXFQUjJhAVKV/6s6XTqymtsfyYCc1LDV?=
 =?us-ascii?Q?8lvZRNKy7Nk2TeIkQ1BcHg6cJD2jCSxMpy2DyfDcWBJsenifb+Lf//ZDHDAS?=
 =?us-ascii?Q?IkUnNSBqptCAC4Muatt6ql8cNt7EByTIGRhLO9yA862bQ2KqhNzxs0G6ZUMG?=
 =?us-ascii?Q?8n3WPnPB0V/eCYUmxugBHfzjLrwCXE7yHnRpofA8/4cKZzLig0uxSPW0U/bg?=
 =?us-ascii?Q?uTvEorygqE0YNeQfrTqEIJl8y9cJr6v2RyXIywB9k/jlpXebjGcHWB30Et1o?=
 =?us-ascii?Q?t4ve2nBb/o8+uiab6TcYolkei19x1W2JKUTkmTuojZWsK3FQEOm64RUX1cLe?=
 =?us-ascii?Q?F2XnNnGU2wzkvh3Zb5tzm2jy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07dfe4a-8cb9-4313-1a43-08d8f93eceb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 20:59:02.2964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N48QLGE5X16c5lF3VBk8gp4+htc6pQwA5egPXtrt4B25qqcNQKlDpxgc5Wg9PlY+uFF7MavUjCAec5vgP4UA+TZ8CGhVz/MsMz9cwFgQF8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7536
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 13:08, Bart Van Assche wrote:=0A=
> Commit e76239a3748c ("block: add a report_zones method") removed the last=
=0A=
> blk_zone_start() call. Hence also remove the definition of this function.=
=0A=
>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
