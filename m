Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E26EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 02:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjFUCqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFUCqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 22:46:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED210FE
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687315597; x=1718851597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LT0VKLcZSjU1T1Cf+nn9tIEsdURmyw5PPPlc3jaDLvI=;
  b=qg/nWNrL1i6OPit1Yv+OSHsClwH+dXvCmqO4pxpCFEzyIA1vZjnzKUwL
   E1qIk+XXD64tkh6LzdZJSy//dp6fg3eldDYNzeH1qSnn73cZvqpWIT9sB
   /VfQNYm0qPfzkmeIGdNvGfEin5FdzeDZ6FtmUEotePq5OYgt5VWQG4rlU
   2RhDWs/0A/2tmzto0gqffg4wk5rBGXgclW1Rn9vxgyHdiBLslMXFQjrMz
   9JIs28r4ZEwtGWXyiRmd/R/kXMkW0wYU9dWai5ar5KhX0qkJ9CM2eJKYp
   0VHq8DDZR35CGNlUFQnPuhzbxUkldwJL9PiRld2FUhhNFhi1FRTyHbuLQ
   w==;
X-IronPort-AV: E=Sophos;i="6.00,259,1681142400"; 
   d="scan'208";a="234538819"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2023 10:46:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW0eZqocJy7wG3KF/DJhBdW5rOTmQ+m+5t7jyU/1qhh+DZH2EUS/rc3wtueYR01czVrzDU48A/mGYGnnIU9PFfxDonBTm6wq2cQd0pazYYPiQXGvv8CQE4MHSKJvG39KW3G8otToKT1A6dmk0lbi9X9S63OpqA7Vg6JE3+NN9s2zyyEhudr9qrAZm5FQRVQKx/jGGovvzcgEsyNks2hkJxflK9LI7FEum1X9gKdCaEt1Z1Pm733KRC7qDBoVLK+H0GxrIStTeblo1nS8+JkXb4O52GwugCpq/JAqhZJo+K6A4OGO1xGQEriBoj41GC97Qbt9maO/sSZdj+qtVRfG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUeGs5cfUw8Mw6L7zMioagMeORU6WJvGQnLAQylF2Tk=;
 b=jXnRU275MEhK9rM73Slaw/ngA8xyhMtUoQpQMDNg0Zrue1w8gSonFMayeGOT1sh9S+8H/IP5eNY4l3iW2gODnL21FI1+mENVxEM+1ILU4v9rM5577AU98b+Ry3Rx/YYRelXpVvPjj6eihbz0zigrVz8shwCb4Vh8coFFVIztewHz5WcwF45XLd2F6t9QrX0bodMSgr6H4bFuDs3eDqtxxvpRKTXpDSwMLfTb76Bljv0U5ldXosrwyS4s7kcfc0F35Hx8frVCSa18cg+wpGRfD6t/AH9Smj4Q/s0lkrBqk02YGERjg6ZTtYXv6AA5QuHMjG7jEns2uDhptgKl8N6ZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUeGs5cfUw8Mw6L7zMioagMeORU6WJvGQnLAQylF2Tk=;
 b=Zf3IjT5et1FHldNbUFqhcDv8AoZTnFzxNRITCIQQD/zilnWlViHaWtGr28RQVCTJyR704L1XctnuE/05nijfgTEjwwXpNlvb6ndjZ36ME4EmmN6P+UBDsCMNdxKzeflT9Ms3uexbxkXZg1td1MlD9wKu1hgRtQKAmiKTwQit0N0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7209.namprd04.prod.outlook.com (2603:10b6:806:e8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 02:46:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 02:46:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: block test failure with scsi_debug
Thread-Topic: block test failure with scsi_debug
Thread-Index: AQHZoz4ASIdURrbyrkmrUr8AZ5d/zq+UjrAA
Date:   Wed, 21 Jun 2023 02:46:34 +0000
Message-ID: <zgp4nnbryukbgnv4cdtdnn3hwqvgggeknljmobk4moobiffseu@hiytoqbf7pol>
References: <1760da91-876d-fc9c-ab51-999a6f66ad50@nvidia.com>
In-Reply-To: <1760da91-876d-fc9c-ab51-999a6f66ad50@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7209:EE_
x-ms-office365-filtering-correlation-id: ea703afe-ba00-48c8-fa04-08db7201ba41
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGWrYtBxiYZB/s19KAqfq323VhQVdq/X0NhwWmGHkwRnfCvVGonoUHyOA59vQ0ntSGBPy26u5Ixxl0fJjyXYEweAd/XBbocBaSHWlB1ATBEtiRUumLNUkMHCSJyYU8fEpyMCRysWKdGjT0y8m3e2A4XwYEKDollu0sbsrlOEsep9FdICovtTcMJwZ8du9pu/V4/Kh1FacSlnvc5jgj1sAKICGBV0js1GVj7xDqFSM9213hJKuhpq1zuOKReSxsincQIXzwY9lZ4kR8uZBRpSbRcG0vPLGKs6f3yNnydlMQy3CTlzOCJp/vxMzkt8rKdqB8ax1+m7fNv6SM4ra+DmKl6SbjOzL+BFuyUMw9kcMMULIdwvV7V4cyoU5SJgStViX5HGCCe+E8o5BG8jimYmCH5E2h5R31V5q0Olrhvb9txN6wbUrTRPSEiZ4VtYePXJQAAYmKURwZmHVT+ALxq9iUe7p/YKu+BEavO2Sfy2OmDAgrip7TGhlYy9d5vbYZ0qifuTqy/+0BrfPSfFZH8Tu6aRB6FVI2pjOqI1WsE2oQO6xDPAKZPZuP/++hKqlspe5fyQtkGrIZp/kTen4xWErIzoQZIXvsEQLUZONwfQW3HK6cV9MrpU26BfvXRNP4dp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(122000001)(38100700002)(82960400001)(86362001)(38070700005)(33716001)(66556008)(66946007)(71200400001)(4326008)(64756008)(316002)(44832011)(6916009)(26005)(66476007)(186003)(5660300002)(6486002)(8936002)(9686003)(6512007)(6506007)(66446008)(41300700001)(2906002)(4744005)(91956017)(8676002)(478600001)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WgXqI3gACKNTld1vdDi/rcOABw3ph3+wZ5RBN79YzNp0h7eX4l/jXUSFnHBN?=
 =?us-ascii?Q?xKh8kmKIaJ70H3s3KplIFRyfMt306IC9AeQDXr/aIL9khrr4Y/XqURMZSS9R?=
 =?us-ascii?Q?jdmIrG1jjsRiEdR6rvw47WJLzd6eNruoQ6ooVDsxhHlICu7AslcB6jNcIPwv?=
 =?us-ascii?Q?O51poJrdjso5VNq3gaC125mXcgjQECY2+023SWptHTMUSbrT0X0okAtVi8BK?=
 =?us-ascii?Q?BoMUMzLCI1n6sEQmSigXhBC9c5WONLr9KA6EP41HbAEk4SU43McxPwvOOkIi?=
 =?us-ascii?Q?PbmgWk644Qh+OBpGp0ce//Scpx928dA2eXcFk1TUcOanhw6QFQXbAizruxT2?=
 =?us-ascii?Q?sRyg8PMUsVbzQltU283Z/srbrtyFh3/07kwcCftN3TabJso9EvxkmmU2UAog?=
 =?us-ascii?Q?s5IqYgjYs2uJ2CmVywKJNpAYH5EYSqE4mKaKNIHxrzNeFVRMMhYYUNW+qvzU?=
 =?us-ascii?Q?Ovs5Ao+xisI+Z3fHRKaZCHFYH65bwQZgkDHt0RGPNxrqrmmJeKBDccpplagW?=
 =?us-ascii?Q?qhOQkhJzgC4L4YYOZGu2booysiQVeKM2/KRaAUgB3e+q00x3o9CuZomdrcK7?=
 =?us-ascii?Q?/SY+dSN/SX3+ZrUTkBkJ2mAQkVaYFR5MkLVIypjlDHEHpJbMlb+MuGp7aVUp?=
 =?us-ascii?Q?BEbPKBztySmhYpXGoUp9NpgTOVfNZrJSXVlfc7YSg1u4VosEU/XgvZbWOapo?=
 =?us-ascii?Q?RPRNxBKLJZnDl/rv1RWvJ6NFnXb3PkLpwp+vpYDiGKugj9Y5ycM9J929t5IV?=
 =?us-ascii?Q?mUQa9yIZUgiqNLyZ9J0AeulMtjJ6RT6OSA3gXcif8Wp7dxvw90wvt8naQTlp?=
 =?us-ascii?Q?ym70/1H/iP2YZs5Meq9ZuczGfKtMFo5rLyOmnRNvJ+paX4jnXtz3Sxkts7qE?=
 =?us-ascii?Q?tSSZB3HENGUmYd0R5O6jbBld+Yk8zu8QnTteqa+UiSYS9qNTNG1am4d+palk?=
 =?us-ascii?Q?xwUGKpjeMW8vnSUCB20HfHw9FSWDjjY/d6zaaKKgn+K7Uej7dXg6TIvdi3ll?=
 =?us-ascii?Q?pvd5DEwYUH1HBGresF00J998umJATjSS7b526luPPM+kOtK3NFeX5zwTRfJy?=
 =?us-ascii?Q?DNzAzhkLBGbxWamwBmhQHSQ+60lqDT3qXZh7cDBYcICepjl20WjrhwMjuQPX?=
 =?us-ascii?Q?Sp728SjDwDPeF4sxuLa7XVzNS9eTjOQmjrBoKWjBn/EvpCI6FpAhqrGeFuXh?=
 =?us-ascii?Q?B9+tuGAtTw8jexcY29ARdef166MYXBg3X+QYRbux/pMKTGHv7mk+/kX6PzCk?=
 =?us-ascii?Q?vi5kL3T1pPDHSZN9lr5hWPjH/NlWiAw8oHZf/6IRW1H6ajGkY4zvxLHFUgXD?=
 =?us-ascii?Q?CpbetqUjrZ/fw7ilt7ILWi0760ythn5Yg4DETxTbrzuE8pW3qSgmIssFY5iY?=
 =?us-ascii?Q?yrJdIdZFeKW0i5wKbAuegrnE7bKnuYdUL/DNRanL01OJacdww5hcCQfoDYjp?=
 =?us-ascii?Q?jqziFqH5W3TJrFuoCfy1nKkf2MdTAiDgnqtGycIBKAtytvD7bK3XQB/9/HLU?=
 =?us-ascii?Q?RiaHTHSXE34oSk95sExECAEG00Y4L7nT9bIC5IOiUfCrgwOfZHCwfqcINFGe?=
 =?us-ascii?Q?UmlUOLa7jawY7UtZuFhzUc2fd926MRZ+4thVL8W4hdmWyjTImrRqYNFL5IH4?=
 =?us-ascii?Q?DlCE4U2lExr1Nzl7C7Lu0n4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5A5351346FCFC41B1BF32BA64D70B49@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dkdshFUwpBuv6FUz1VSACYvj7X+hYMwnjs90b76vZQyFa2W3acKdAfGL07ETXcYcmEoNCrLQ9/HsjmcY0EEEIpY41iKUG+6BENmwy3sOU1dDHaZPYsbE0C5URkYJDt+NHAr8a46yFbVUWsm1MaEf1RXiTcl8Ig9MMxGJjd+iKlW0xsdHmppfDURBDowbi5gomeYPq04v8zCmEfCdrKemeIv/HoX93R0VHdKoqFKWnGEQvFIxay2YtuPDuDQBnGqMsTsgEe1LxSea4n3x09t3pviTb2N2ltyv/yzOKJkgmHDXL8a4bS8/RiQMV59Eqy3WQnAgOV7eY0UP2dW1dS5cP5HpgAUQe+K2+k8LdzIDjuXdUsk0xrkl+7/bChqA9y3dFLgQU9STZQ/7VWGJGrTQAdqOK6z1331KOEn8W/vfW85n3Rt/1nq5n/1/pU6vN1Irxvs9VOKRW/qbP1ueVUm/dLt6HGXeuRQGVMUiTIxToKvirCiMwUDWsrUo/HoJnEbu9/uz0zT4JIpWn3P9qb8xuUD2+V0+vs8e87PDsalf8I17jLU4nIN14fpzooCG5TQVydYoqC+rapMobxyhz5pM1Qxd0HbJwU1DHkD4lTzvDqgGWQl+zo+raRDNiulj/lQ0Pr8l3VV7y21wf19qyLsP2C+lRu3KjcoUUSysSL0j0mDfmRF+rdU6pZeQV/XZWvmErCa8zzzlWan7vlAV7AODjFXbS9dse24IIMDz/IlJPa+kAgg93B8oqRFtI+aNHxu49BRWMCOVg8xllHc5H700tDKbtbW3RzMe5oWv0I2VLav2m1EMsk1UnybIQxX8vH6v
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea703afe-ba00-48c8-fa04-08db7201ba41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 02:46:34.8449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3E9PlxeqCqjBPo3KwOTgme525BJ19UFxeRAUOs75z4zYSYco+QfTnVRgLDf0TXjUgTpETq94NlLZErTwxBnKuLbX3GFRL2l5rj6mrWNQhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7209
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 20, 2023 / 06:11, Chaitanya Kulkarni wrote:
> Hi,
>=20
> I found few failures, are you also getting the same ?
>=20
> linux-block/for-next observed block test failure :-

Yes, I've jtried the kernel on linux-block/for-next at git hash 334bdb61bbe=
a,
and see the same failure symptoms. It looks that the first test case block/=
001
left scsi_debug in weird status, and following test cases were affected.

I tried simple commands below and found that scsi_debug module unload fails=
.

    # modprobe scsi_debug
    # modprobe -r scsi_debug
    modprobe: FATAL: Module scsi_debug is in use.

I'll try to bisect and identify which commit triggers the unload failure.=
