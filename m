Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC00BC4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537D822517
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgLDDbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:31:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23493 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLDDbU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 22:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607052679; x=1638588679;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=96+Isrlx4RGs25/p4eO9yNSOD6jnLDF4aQ18XVcGGxQ=;
  b=hpYjuC2nf7qu+S2ECagv8rkidKtb9ud/+U5fhfSFrql8FlpDjjEvZTUU
   CNlvXJOzVvmJLun23mdQU7dbdAvSmqs1aWGMn72IMi1LJNK7gFi2axGsK
   +lXfHv8LdBTXrB4wn4kTDVjfg5O/K9e6r/hsBj+eri4RfH2B97LXvsN+m
   R8GGC4hgdCjLc9AEmaxR8Y4nGGKg4YK01AwJF2EZbYTqbcU4FKYDRHHXC
   JkU54nxqL3jddTsbldmh+zrRWbiIfcv0tVOgm5MCCeUDYfyZYQ0jtpxoj
   QtzShUulXRBlAmn8bFqUH4XQXWY4pSiZ1Qw/zC0dMFsRVhvnNGHva0/Gi
   g==;
IronPort-SDR: fBStvlr0aD/HlZvGlAQ5s7oU3iw8OtoLW+JW1/8+89dUALsM98VAEZjsR2CQ6TeIyfWN9ooCxN
 x8t0xIaQYMGYB//0vR6hac/tTqKRAvdXkBHeOm5h7hQAOl17NhLnV/Db/IugZDorRuUHUIVQ5m
 ZU/9zRu8tmep2gQyNgBi9Ywh385xVn5Gx+GDL2qwvHGs6+KW1DpZ5WiCMed9U9MBTk5DUYhlH4
 lZnGN57uSGX2B34iPK4bFg4cg53Q/OAxrgHYN7BSf2URJt+k7VTjtNF8Cj+iYv9zxvyHYpeGHA
 hFU=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="154367317"
Received: from mail-cys01nam02lp2059.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.59])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:30:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAf7hKUd67NLn5vdgzeMp48+qMinh8bq11K1c3Cd7TncxKT/vYep8t3BR7VDDKi27WS1EfObeJ9x8YF1V3L59PHc957IK1LoKqk/gEWiaKCAVSkuw9SCYI5YvQGuBxTVGIUZjXpBHdc7FeKTz8jQXjU/MYerfRpq4S34576zXtNxEMc8MctMTw8MC0o7UvTbOXK/VA2ejihUrHjT8DLkAI0295kt5LkG8my/Lku0xkDUewW+LZtAyHw6eKBcyt64+OjrGY4ZO6BTT2sJHE+36vvIK6b+tyPgHIh6Vv9aZUPjEhRqigVniAqxOMh4mXdKDQg/yqYNISUMDv1y+nJBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96+Isrlx4RGs25/p4eO9yNSOD6jnLDF4aQ18XVcGGxQ=;
 b=jdZO2QIOB4ee9JZ6DXR3PbGxOsB4/zg6dOfGFY7PN1DLS5fxHydxVcQVTYiykRZjSW66iUHwmrnBgXujwtL6/qAwV53U3HgOYroABswqw6D9X/SxefJOpfmq4/lb5ymY768rRjLduvIshnBwYEjsOE5WeChDAB7/s0a3KNomHSfpwxi2qAPxB+YVwfQ7S3mMziiM+HHrP50+BvRTWt/pBMYoTidv5Th8furFX7vSfpe6T/iaBDrKg9cbOdfo5Hrmd+eNXqLwOgapR2QkhUt2J6rEOIu82XtH61VY3rRmuRxYZdNZWPqonasgDJhgpKsI/iH4RZTehuNNWENk/LsM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96+Isrlx4RGs25/p4eO9yNSOD6jnLDF4aQ18XVcGGxQ=;
 b=XLigCCtr3marfqb9I6WBIdcdBJx1Ss+pbqqjtmRW3uTpX99xjpt4eG7IPB0K1o7l5zwrF44WAuGqi4QOn6kV0a903qypXbyNM/YW6KulNSFSvmYaPNvZzj/pm2sgpJ88urrhp9iG2T5EGF/1Stg6ZrCm89nQGGju2pquzLqkFis=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 03:30:13 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:30:12 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v2 2/2] zbd/005: Provide max_active/open_zones
 limit to fio command
Thread-Topic: [PATCH blktests v2 2/2] zbd/005: Provide max_active/open_zones
 limit to fio command
Thread-Index: AQHWyecjvF3LeIMaQEyxzYtp3WGC2w==
Date:   Fri, 4 Dec 2020 03:30:12 +0000
Message-ID: <BYAPR04MB496572C530AA38D19A1060AE86F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201204024235.273924-1-shinichiro.kawasaki@wdc.com>
 <20201204024235.273924-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60f07178-74a0-4c61-ae22-08d89804e909
x-ms-traffictypediagnostic: BY5PR04MB7123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7123B0F6A9EF47CF349A532C86F10@BY5PR04MB7123.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiLnDFl2qdnK4yeiUp8ia/LDzvkb6ARBEk9nKki0ggsB5nNDU9XD/5+ZYJG1nB1t8hoIgRuLg6d1Nc8I5h7xfg/h6IOqUidras6qgu7lqImIqw66esYyADbCphrxH6B4+DWIcCkmYBd9bJzIQ4VUOt8ShF04OdUH9D2ve/fDkRCtzsafk0GQ7R/fn1TM0582+3P0MRdfiHNveKkHofvA/EguHOLsKg7xC6rCijzLMe3kBRkJypaIW3hubg4IJN6tGsQ7/WTfeyfCWoLZlSSOb7ntY6Cs3SSvCQ09o+3DFibEWyf619ZfLB7c+QnysMT/oEqNZL743R6rGROCAZ+2sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(6506007)(33656002)(86362001)(53546011)(71200400001)(26005)(7696005)(2906002)(55016002)(8936002)(83380400001)(9686003)(5660300002)(8676002)(76116006)(52536014)(186003)(66946007)(64756008)(66556008)(478600001)(66446008)(66476007)(4326008)(54906003)(110136005)(316002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cYl8jR1JQdJ9GsfHIcFtM+QJkgoiqipNPePYaSIP1mXmQHnxkToW4iarOgl0?=
 =?us-ascii?Q?EN1ErkebLZbEhlz41UBrzcYQoR1mF97spYn+gWW5WPZ99CK18OXjSeKOB0hM?=
 =?us-ascii?Q?SrbguhA6RCYEasXFHzedLHi94stkDq7aX46ATTShdwYQKzgV2hwoangE5O+b?=
 =?us-ascii?Q?C90ahu0yGusu2mPGW2SaiX2CKUvtfrOxSCO9uXMOpJH9avq73M+n3+NPupVD?=
 =?us-ascii?Q?6i/IrrLCerHdhVOcnTuPtPlp3BG27aUkPRrX1cTCh1DoTMFSDcBMdO9ZBakK?=
 =?us-ascii?Q?z/G12VG6wiY90RfOS8FFYMgalS+Emo7YlaMcxzGUP/uj+pTJvx3hCKBOgLUL?=
 =?us-ascii?Q?rLXJjsTPTlXpM4/zhZDP2BDzlNnCS7wyI53YQwHl1UG13v3FpdzpYzR6g+Zw?=
 =?us-ascii?Q?hFXrHKY+gy4MlRPUYggX4brg55i8CF/yoQkTlq2jKWmWQbhe/NiIQS7x3Xrl?=
 =?us-ascii?Q?ZWynCU2A2QY5TMKV50GmI+w3dGlksaJQgn/VNmtP0xiy1yZeOFtTJG5MSsGU?=
 =?us-ascii?Q?2FiwcH3EuODwwfyvgKQfd+SXwvEPDQNG84GaDA0pN1A3DM7VOVcdQ1tiAbqb?=
 =?us-ascii?Q?sCPYACvAdoZ75xCdKdB+GNj/Kyni3TwQLaxDYuIxUXydXmXsLloZkjR6ZsCP?=
 =?us-ascii?Q?I3inwLKXgHC8Yrf6p7U5VyrEew/rGqhJV+WnZ/aKskVNmxq62PHdnCU1d4lh?=
 =?us-ascii?Q?qb2cvEUT7/coQeAtky5JMcNzm7IEcHKbAyM+NMBT2fTLIhay72NrcJnc2xvP?=
 =?us-ascii?Q?uQIc9X33azQ6yOs6fkEEpeLm4sTVquZaiXhV6wFRfpGZEjL+2JhPkSCfh26L?=
 =?us-ascii?Q?TVRC4GGso0kTfg05wLffVqhaZq6tq++UOBxQrIv93CaC2D5jyHhWsrKC64w+?=
 =?us-ascii?Q?E5ty36Fy8AvB2sO7kwbASfad7v2tISypbJl0k1BWbWF/yek7qZBuHbX+kJxK?=
 =?us-ascii?Q?oNzRtO0GM19Qmq3Yaurw2AXFR9dXW/XDDtbjG5UEjroPhYti6Li/+Zjnu8oq?=
 =?us-ascii?Q?98Xv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f07178-74a0-4c61-ae22-08d89804e909
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:30:12.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mp7bDzjqWDvDEq3U8oBX4qkALZkbwwaCj8NfFNYSF+f9tbU1oNWe6NU8Ku9YPuFAPJlVSKKBFagaGFb2Nv+c/HC8laVHMF30D0LEyXNvYP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/20 18:42, Shin'ichiro Kawasaki wrote:=0A=
> When test target zoned block devices have max_open_zones or=0A=
> max_active_zones limit, high queue depth sequential write in the test=0A=
> case zbd/005 may result in parallel writes to number of zones beyond the=
=0A=
> limit. This causes I/O errors.=0A=
>=0A=
> To avoid the errors, specify the limit to fio command in the test case.=
=0A=
>=0A=
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
