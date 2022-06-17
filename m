Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F15AC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 09:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380291AbiFQJ7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiFQJ73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 05:59:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288D51323
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 02:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655459965; x=1686995965;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nmmbAFsKbXMM4NYicReCsxcInoUjt38lIPpduPPE/5afeJSUE4IO7BDK
   daitIP1gLwKy4QsGdagXss/C33cEAK+5GiGmQTMYMCH1P5xe7mA+wYdVf
   p3gnyDV/INwJfnG3mvT6uRwQDfAt5fxcER/ZB8GpgK4NCpvQ6c2Oum5Sw
   uxXaq9G2upU/oXMdD5U/6l0mhUfJ1Jk5LhLM0z/Udt1ohicOxaSaSy7uB
   gij2fxNDGGHKSyyO+WZO1Tweean/SZWhjt0hIfN6X0Y8T68r2uNW73sew
   N8tVJ+OP4jLuJkUu7Euz/J7ZuI9LzDaWmOcwxcoPh/PnAfX+cEa49dxC/
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208274485"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 17:59:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEr57PpUzJaCilBkypyJ4PlkR5To6UeiL658Dz8JTzuxhovm8EzBVWGLYbW0jEx030rLc5CdC7+UzU7jvhoV/ASfx/QLTlW3C1RQwmu5K6l+7WlRSZoL7n7hHmQevSUGh0NDeNCYkqOOcqay1p/KEfPjRj4HrS4XzUDcY6WiGO3VpBHRH/xg3wyNLHLD8QuSD8bmp+Jgb2Rz3Z0VtiG2+Re7RwAmegrV98ILz8C2K0KTzypqc4tMlTuB7ab3cdpeeA6MvHl7gLPgZyMvXoWhBfL6QgNs4Svqi2witi14+ZfkNIIIytFfclL80opXkGoAC6isJqtzQzq7/va4hdt6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hg+MgxP4x4KjeT0qdFUUV0psjOksypGv8pi2xWvsZva0WqKMoXtiCFkSf0RZaFim3R43f/QRs7K7GTBT5fIxgrDNLBnMsMaJJyY+vl+k8Hrg2ossSw0HM2b/qS26mJ0WCkYyighMpKQ6gDb6SkqW9W46B2depWA+8mFH+pAbn7ZSGawUyj8MW1igy3o63WaZtrDvJHZ3TfvFUomKX5NktmqxQx5P4dA1CQMgMvWeKQlGQKaBYB95UACNtpXCfwE7sdgV1U1tQj50zeMxsLqswEh6k9ie2NtS8l4uOgxOR/HjN3I8yetaed4Y9+EzTn9GbEinQqVSKw2SCzN9hS712g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UqGyUxktySyDIfD1wvU6UDNu/zu9XAl87tJJTznrGJUd5l0mNzRrAd4xbHv25FrJX7QGYqioqgy16OeW9S2LUtZZ5PzrFZLAONBADxTLoreBOq7cAURf685C/W0ZMJup5EhteK/8345fgwPu/4NuDemIajsb1G4VUOJIze/RMMI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3973.namprd04.prod.outlook.com (2603:10b6:a02:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Fri, 17 Jun
 2022 09:59:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:59:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/3] blk-iocost: Simplify ioc_rqos_done()
Thread-Topic: [PATCH v2 1/3] blk-iocost: Simplify ioc_rqos_done()
Thread-Index: AQHYgPszsjcBPBFu2UKmwlrAA3Zpiw==
Date:   Fri, 17 Jun 2022 09:59:24 +0000
Message-ID: <PH0PR04MB7416B56C860DF3DB09EF72299BAF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220615210136.1032199-1-bvanassche@acm.org>
 <20220615210136.1032199-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6441c92a-f2b5-491f-1b4d-08da50480ec2
x-ms-traffictypediagnostic: BYAPR04MB3973:EE_
x-microsoft-antispam-prvs: <BYAPR04MB397393F815AF38E9E1D9E0B69BAF9@BYAPR04MB3973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezPs3rKBSH4eWbgNatxhdNCa2V2szl23tdZbU0n+3g8j21YYaG/nwxp816YpZl/rNTBTAzLsc3mvFmkMbiwNKeMpDBiXvgLZvgyDxhBY54NzETI5OAXzSAdS0W6aQLNmEYTwdA/vqG1uNoezL+pGFKJ4jIpee1UGg3TdlQfe4aK57YMWbfUKonoi6V1pnPwOsP2oQzu6XHRyTZS/xyvvz9zxHDWyLJuenMeoElkGoXejAEHC4wYMlHOd3YfsYqgOY02XwbU5tErOKbQ8kxqQtp3vAe02E+kBD9E71EDLCSI/vbJ7EFhzvdYDA1Vk8eXhukQSFSF488ujh14wSzvIN3nuZipE0swEUs7dKGjH9HDMxyM6mhLIwWYO5Sf9pxw4iuZtuzapT8fqED3Nyva1jz03GO0YYxzTCIX4CbhVh997LM/6PEib80HDfAwP7I/JSc6zxSlyLQOFnANHVByF2D6KUHhT1ArpaGVx8jdtXI3jkACtcajeHBGJhIueFwoZC7739/1kdq1utrAecnWARbw3uhHwWMxg2gSyRTMZPP/+xDZgejM2N6IoQ+xcAwBC20giADVAO5cThiikrqTTigQnH+C4GbuwphaP1YpV5GW9ukB/TosV2NquRymNU34MrwlKtg7/eDLAbAu/wr8aUe+/PJGulqFBxzqTVs/MGHU+9Wxkylm1X9sGGbp2tDGK2iRbxG8NTIeOH1E9Q26fwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(110136005)(66446008)(64756008)(55016003)(498600001)(38070700005)(66556008)(558084003)(4326008)(7696005)(122000001)(76116006)(186003)(91956017)(2906002)(66476007)(8676002)(54906003)(33656002)(6506007)(82960400001)(4270600006)(8936002)(52536014)(38100700002)(19618925003)(86362001)(5660300002)(9686003)(66946007)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aqgHc3pYzjApRiW9uuqf6FV+0I+uwW0vI8Pq4X9Y2pEb/OkU2I9i8ADUbc+D?=
 =?us-ascii?Q?pYmNN1/u9vszzxMY+PtPG8s+XV/otw2Dyo2sn6xoxEIcAHLfv+b4yMzhQQVI?=
 =?us-ascii?Q?/l2HLWQxD+oc7/zE4Jp5rh1eicXobDQvEIk8mMYN83aQY/Spzf1lHi5kFRtF?=
 =?us-ascii?Q?oknXeyrgF8PwZFPVVD7fbVdLqJnUbeQO50Uh7DJsfGzV//lGvK6ogG4Ngy82?=
 =?us-ascii?Q?fJsNcT7BfZyrRBJ/kN07cIIcoQrDq39bir+PbzTl3j7J9oyv1Rx1htteTjED?=
 =?us-ascii?Q?Iyx8eAC8EgEuKgeJH7xJiqglmqaUs1oa+03NLDYr2rt1ZJbu/Ppd17MDgNTj?=
 =?us-ascii?Q?h6HRgIEtQ+CmzDUW5itAuuXNCGVEshL5NRL5poShfA2kl7kzi/uFtlV8Cc+7?=
 =?us-ascii?Q?H06dkAwLO4xrhI90r3GBkrbabx3sbLg65OUSu/7ytOFq/Q38nw94Inhy0ZbX?=
 =?us-ascii?Q?n5aoq2colHBR/h0VctheK4pWGcyzs08YbwZ6rDSNF/yS3FfnlaB+HxE68xg+?=
 =?us-ascii?Q?FBPs/w1fIo2exH83ZVwPdPUmOW61kPD/8DGx2Kf7FD5ky92LofzsKO2sbmFz?=
 =?us-ascii?Q?JXk3p9rW3dMHeEYAdAmDa3WuK2VgUHvJC3g9o5y0NcdUCfAH8MyiIHMJZ2Ej?=
 =?us-ascii?Q?4Rz3Fd2w3HsBIv09D9lpEq7LEksdE4lWdXwzi5diEg7kx9Bi+aUWBCNvTo1E?=
 =?us-ascii?Q?Jwc57L6V1gqTWxFuQKzEmX5iMxctWN2XihOuXSIc5sIdQ0ucH798tQy13XDv?=
 =?us-ascii?Q?l8uswLYVj4/SIBx5/h9EmsYmhFpvuVvZVEpSn3dwQQZXts+TrzFwd8rrJ9FV?=
 =?us-ascii?Q?JDYfubzOcEraLnk1XWIC0ES8wO/gsdWdfuuG3a/rpgT970pOhNfclNESyv5Y?=
 =?us-ascii?Q?bhROSXXcPwCwvqEMWXduMaBLKmInK9SxVbA32wcd7SkdwvGRSW2V0tzNkNwt?=
 =?us-ascii?Q?eYvG5OnNXG/N4g06JzMs2Mc6ZJo7se3bUe2rfZfXean+v75cnOAYOW1CAuGm?=
 =?us-ascii?Q?5iKTho/d4qEDe5+ZdQFZHjq0jrApJduhoggfIUuHRiHCuPgD3eBUe7D2XiKg?=
 =?us-ascii?Q?MxaSQ79OK7QPULzpE+YVFRRCu6jsrDK3/dCCGF58hl6Gl1SGhQp9teIV43/O?=
 =?us-ascii?Q?uWj5tKrAn8VWM/O5UnkftGG+r0+ocJrDt/alfk3vN+nbA/JIiWp573YfZRJV?=
 =?us-ascii?Q?KJpKvZNCfLgRrLuMLbHI/Ktqfca4/rwCicHapVvGSQeCow2Th1SVNAPCC5dp?=
 =?us-ascii?Q?B4SIehUK2/SUZPU5wiW8SYo8DMTCsuycJ3LLi2Raw/4dkMSd7SLq/7obcoVR?=
 =?us-ascii?Q?8YglP5Dc+0/z/GX6mA2AtEWqtTMQG3N0DtD7XpEppB5AIkobn0cH99n1SJHO?=
 =?us-ascii?Q?wSZPEDp5Ij/IGOANOxxPLtCbnaGn1GHWrNWoNvgPBnToYTSGRM/usyr7COJb?=
 =?us-ascii?Q?VXAYb8aj+tw6l+e6JnCv3zzmUAPuw2ZSAXjObuss318yR8a8+NqMEV+xj1bJ?=
 =?us-ascii?Q?NQczHMyXGQzdqNiQSULEnUMYI6HdFAnPFW0RsHmP1snQlglyIIf6K2vFfz/L?=
 =?us-ascii?Q?Di68xtB3AbHjXaCF2oSGjRp9o/z276ppz/w8wZqlHWcbAYxHs1c07itvcC5h?=
 =?us-ascii?Q?Zqa7tf2ea5Vru6g8PRJWGoKXpMDDCDnldrEL0kO5W5leX/T14Ccg0ARIKcH9?=
 =?us-ascii?Q?tyHW9WjHe+uf9QoXDBLC39sQ0XcPlujY5ScNeBfkss4SdfmIONMpR4n57qCa?=
 =?us-ascii?Q?gZQoHVtjBa+a/kJNsGCbON0g3pSmQzIEWjYXjhgm62vzX63cMQ6cqXIkDCwe?=
x-ms-exchange-antispam-messagedata-1: S0Khomv9UoAPyzp2zWj779BgJ8ADxTJlB264LCVWHKPp0amjIFrUWqYM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6441c92a-f2b5-491f-1b4d-08da50480ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:59:24.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPgDhq3KSk6TpPFgKjHgW/z4wpDBAs1Wco5NpmBie2doL/EVC6Fe1ILD+v6ogfnC7V2kWKrXUaSXI5KPXZCTinaQOl3wh9gUGqMu5ZI2c98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3973
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
