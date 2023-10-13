Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46ACDB474
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 02:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJMCcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 22:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMCcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 22:32:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6093583
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697164350; x=1728700350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xA7fi9IK/dtkF/nBFR690sMXhzXY3joCQyWIxUK9X34=;
  b=eJCqSQiGReVv850AtUzbVccO5AvH2pvodidJ9Q4L9/UHDCEhinK2+X/v
   gJlGwi9Nj0ECXUwaOz8XHKeiKPy1zQHZJc2PQiZVqi6D7/qtZgDdLsbCK
   LhPEmKA5H04hEE5mNcg9IQgNiOs1ek2/ExJ/P/QqEk6yQsfSH0rPh1XAU
   9SY/AbslkHbPY1LDHqNpwBYknwYkiXdG28RgvkLnSopvbUjpmFKTnLVVp
   pCwYVzVAvliNJJWE/gqQlZtewxgwmxierevk3E4R2HKEGo6T4ehZgBjHK
   jXtgyYB2bj1ksMBzCGe/m46LGHofloGcRMt7CmLZGgcPbpWmqh9TsAPaY
   Q==;
X-CSE-ConnectionGUID: nwvBPUU9TYqnh5mKcOcb6w==
X-CSE-MsgGUID: GWcUJg25SheBJey5MkDmUg==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="351794870"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 10:32:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb+DaDmbUE9Zmqp6s+OTUFkkJ9hChJ+fwotJ/qMsud8dU/OAfi48AMq+uAXDlgzyeeWxUsXMFidUKNamQP2bJnGTsPhpT1ZyAdntIxa0K7J8vXuGZs/WAoesWXax/G5cfrqL1xdco1NOQ46G+9oM1KJcdeelESCbZpdkNe4+2ApWmHozUm4EfshYK+YvdgCRT9AVa1jI7lzwYpoAb8aUe4i9p11Spf6GtQjxdw4bKX+DisubKy3niyosEnuMi7wbUqYu1uCOtHtZpi7WV7jO8nveLOBsVxIzhJAlJiKSVtgdeMbaX9qKBXu2XKaJ5xjsPVwipUc3BxSZhlotIiU4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA7fi9IK/dtkF/nBFR690sMXhzXY3joCQyWIxUK9X34=;
 b=XfYIdJx/GKMp1FaGDvB8FaF8p17qSfnWVamz76JL24oULMGtD8VyrKj63R/ybCNsEBbnQLm/2/Th2sy3NE2UMalrMx+aSswECBsvikYeOSbID2fh9eEH7dGsFur5p9r/rtbcT9S4Dr/ufNxdFHBMzcjgp6HmSkUnN9ZuwjbCzc+d+hobpGypvITgixQAI6NKgeYBUa7WTTPP1m80b27PCBzbBaauLZ+vjb/2yqoP4bVYIM41T6Y1wIG5FCeCj449aXV8yRiNRDfIKm83VUMj8GXCQrn0ABXvrnJ7LtBZ7H6Ip5FmhLteskkJZ4Gf+qGIzKulOJmz+TJnoZpRDkct/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA7fi9IK/dtkF/nBFR690sMXhzXY3joCQyWIxUK9X34=;
 b=WuHcO7uBuexQ1yjsNJ8fYTofBugjNAC2AWIh8qacCJb53EFnLjNWcynxT5XYWLEtBUKJ9vebs38b6a0WOQ+vi+HvFxYyPvewi3iKbBjQCHQyn+BpXtbZLzXkjYZsuGRidAwmbJV5c55mLuqo5q/VXY/8SlaoQK/EepHg/0UiLh4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8893.namprd04.prod.outlook.com (2603:10b6:a03:542::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.17; Fri, 13 Oct 2023 02:32:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 02:32:27 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests 0/2] TMPDIR fixes
Thread-Topic: [PATCH blktests 0/2] TMPDIR fixes
Thread-Index: AQHZ/LF9M2AwnLZwYEyJ8aJOXRn+mrBHAZ4A
Date:   Fri, 13 Oct 2023 02:32:27 +0000
Message-ID: <riyqvkdskplsaikpazdt5mcdk32bnpobwn3t6rhpqpb6sbdu3s@s3htleyvexev>
References: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8893:EE_
x-ms-office365-filtering-correlation-id: b12d42b5-393f-4456-d275-08dbcb94a430
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5TvdDEF3aX8eRzPxcy5E3MJGN38hO4Ky8ugdIDIGiTouu9LMGGlWmFjQLu0I2mIqF+XxIEB7GTthn5/0D6uE//OX3FU6aPHxuJS25sxB/4Ri9CFKz/vQOSTwmq2K9pZcClnNa/D90dmJyM/9Inig27iYfBqaoL3Vz57NFxgPRhJOV34s40Dx4Re06rTMLNfuzxaJ/ln5GPVFEi3ImwUZnB6cT2O9g2Xopu82/4u65hB8Tn+ylGl+XfVXFmATWy4zQ6ihz3XHtvK5R8QULt8JngcW3mKuaRpFfi40y4u1Z075a1xb+SYeV3fhtDp+st3Un2zJUcOhXZXWxeEkDS7t+24GElVlbHieEy2r+t5IIp2NQf47v2UAt31L2Xp+4BJHaIfG6LisjnxjfZFNsnKWoEccP7YX5lx5PQ8PzEhdxx9IuBzqbP0+mq0sG8f3CNeJ0QpGbX6nMTX6Du2Hjn3gtdgbGRAGXw/degVVzj/15VAkhwcz34ptXtCrTI0chICgyjhC2SoRn2kh4895AMyIvzb3CiM+2bb/lGq/ZY4o52MRlh89vIZejWfuw5og0u38qhCJqfKyx8izE0AP1TmBobOH1PF9LiXxPOovQnZh2UBwXGWTT/4cBAd2SSipI0DbOI1SjUkUGpSsHRTeCqdIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(4744005)(82960400001)(38070700005)(38100700002)(26005)(478600001)(33716001)(86362001)(6486002)(966005)(9686003)(6512007)(71200400001)(6506007)(122000001)(83380400001)(41300700001)(8936002)(8676002)(4326008)(54906003)(66446008)(66556008)(91956017)(6916009)(316002)(76116006)(64756008)(66946007)(5660300002)(44832011)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V/vjHHK1O8/HkdnxKAFcn36s3uBtN1dS8mApxAnNnawTq+bP8zBcG4PJZZVY?=
 =?us-ascii?Q?GYYWPX7Qb9QQLbdg8JxztDQAEAd/EUCwW8o76JGn4yK95KerN/UIVCqmvy9B?=
 =?us-ascii?Q?N8hULQ/W06YRyJDvDxqFmxL0YBifK0r8uoSP/riz9XWISp/nQlvjhOn1BFbL?=
 =?us-ascii?Q?WoGZ2qcgDyatUL1ZS57ID4JS5r2wWsMa1n0Fjzd75eyVRLb5shHZ7dhVjrXh?=
 =?us-ascii?Q?vAcTZ1hfpBeqPOI+31osIjy0o+B3CFkAk4bpDlk8y+pskFAWYVYQ8DMJgdBU?=
 =?us-ascii?Q?Ir2LvWFkPvBfHQE5KdZm6nktLTML07iLl/bndr4mHK2LYoC117L9HqfEPhnw?=
 =?us-ascii?Q?poQk5p2dgEVO+JFB3krQLSC4TN8wj+ySA6b4CjOKTU/Q1LHkzsOQ4VxRRiwo?=
 =?us-ascii?Q?r1mG2fl0Uvb7mN0wdyVce4ayQhVaSb+zTPKXq/7jFw4/fkQYzQhZAPWA7Y6q?=
 =?us-ascii?Q?kbssC5c+Bl4ha542BBvZf+T2AOCP1wZsUTf1TVr2qVn+CJhOsuzd3kpKVH0z?=
 =?us-ascii?Q?o9PTYecJoDfoSokUfiQpWMmRIHcwk19lkuO3Ri5GDIXHej9URf7eZAh6Vcqj?=
 =?us-ascii?Q?T6nOf4JonqryNYr+Eqc7nNP81PMI/lBc+QfPM+wlOyu+LIWQhrKAXRATNkI0?=
 =?us-ascii?Q?t2VM9l2zONb2HOAO88ll0yL94z7qjf+hgZcUdJKvVFtyUckfmoBmsjvMuV1D?=
 =?us-ascii?Q?PWDk9xERsS5FAakXWPGQfSAQQ0ukVJQdqJaKLYqiZz1iOhE8DBbyVgCY+X6S?=
 =?us-ascii?Q?dMZW8GF/jXavXjGY43sNCzoBrKVhpLPfSSPFvO6GfHjMZ95oeCnondS/8erb?=
 =?us-ascii?Q?34fy1GgEc7LwyHqe90mgMG55VShtOQm4yZX3XaJqsBX9lrgAWHLh2yjIBzI7?=
 =?us-ascii?Q?u5pdxmUr5tW/l1lAtYSWUK2Qdf8UJLVEva9VBJmsgdnySRO20xG3gieYCRBN?=
 =?us-ascii?Q?IHmgJ7N7uiq0cdC2VxrKaZlWAklPta8Y+EFIAMuraKMTRWuplxKZildZ1YL8?=
 =?us-ascii?Q?d8fHFyUlKojN0u0bjPmvPCaMhzTIAglfl7r1+baJUz1udrYRrojEHXcSdlVR?=
 =?us-ascii?Q?i9srplTa2+LJ4xUvv0GHxPuSa5mOldLQ871jK18V4kGv7joroHIqvOEsfeBE?=
 =?us-ascii?Q?jR+je+ZaUTCJ013xoxQxwzMOjuJb4jWiDEaesrccP6E3kgmIOYeNmO8y37Rk?=
 =?us-ascii?Q?lCbe0chgAfBw1TlURMnYYNYVV5Q/wMnnNUOfVAfZ9w3iWAdmim4k/s+tR8A6?=
 =?us-ascii?Q?AD3jafogBrkHfDk90h9bp0ZrVDrF7ZLRw7kKRBd4dIU8ntDEXWBe2xDY9tGF?=
 =?us-ascii?Q?sKMFj+DmKUCuedJgchNCo6UmCb+C3QsZCoxEMqx3yOurK0mX32Rn2Gn4nLND?=
 =?us-ascii?Q?/6zeRZdgg6L5akVNPVmwmWiFV0AjMTv4doYdXTr8/THYzfumt0/c0SOaiSDJ?=
 =?us-ascii?Q?6LIOPZwmwT3PoL5T5unL2ch5y0CH8DTgcIwtoDv8h5DQE4qIajTQZP+158A8?=
 =?us-ascii?Q?575Ebv0xvYqK/loQJW6HJ49IUGc23a/wMANyFE7fWGKj1LNMeRw7zQZO4FBD?=
 =?us-ascii?Q?vt6lFcFlMvGx+Sl2mvjYo9OZ531Ljm7a2ROKvFaqMg/YCE8MNkGEcQGtPAE8?=
 =?us-ascii?Q?b+qP+7K2+bObUIP5KPLlRlo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E04CA39656577B4A833E396E4BEC4629@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0NkUjwsUzDKHECkpS9HbcQupRPAc0mwjs2VzJiqTrLg2tfxdbJRZrcxTYDvxsXGo9Gblubam/ThiS6Cf8zmUC5x5WT9GRhDWWGvvnGEoaM4mSxqwT6VF+mPWMr1dPW5ZoOckk3uzPGld9lSYaOtDP/OB/FcSOE5zevnqxVcdj881aT5Do2KcpyQ4II6iogGMIjIsQXpERFEbUJMMfrmm/gf4dQbBiCR8oonD/CSU5xVc9AenGWpdoFvDqVYsu9JVEjKd1aXDZ7ouYuI37mmEgaCp28xBiGe2gek1LZNTU+EI/CuvbJjezeTPBy1mydHoL/w2eSL1nnSsJFT5UIaiMG5AhDyGCFbKBDtcZuJ5mk+C1pEz4bhFUQPDl7hPkteF5IZCnrIP/WQ5swqLJ6445g3JMVLiQyiHkRgMvUfl6upUYqm5tGtoCXfz8maRa+TATsrYm/ONeTV7lOQuyZBLMuZmoRiRiaAgqhny3svm8mM/dwCgK6sAxnQiiHYZlJXl4lUc1WojE3AGcZMeVhe+38YTp17xGy9J0tcnYiGSlAddqcge1vnSNETMMwkPuCDGR7UjOfz735a8AThqbbjrPRg2COHZJVNiRKqF26CPtuasqmZ95d05+yMQ+nBLAYQfqbLKUwHaVDybELORq/rpwHi4GO4xH0Nc2O3gzcx6o9vKCnKzgXR3kQR6cQOk01tUPKLJy+FOExsBp6v9/COyJ1+vKNUHTSqU7pTXWYr47gy/a74aJjs7+TuMgSOpTbz3iJt6e6dM7srzCDSf0iC1i/fgnNh1MQg0r8qOA/OrFEVYNj5MH3+oYvlDw4KlS8SPetHsvQ8uwLedCUomjBvx6g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12d42b5-393f-4456-d275-08dbcb94a430
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 02:32:27.3138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYAN1EmIJvb/xQAD6W7Y0KVakqpuzfrDgRRm2Ts3THjyNZ+2nQztwtemUxRhS1kL8klzY2ECo836XIsPMjhhizwO5r5ci+C6FUrm8Jt6GyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8893
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 12, 2023 / 11:11, Shin'ichiro Kawasaki wrote:
> Yi Zhang reported that the reference to TMPDIR in nvme/rc causes an issue
> because the reference happens out of test() or test_device() context [1][=
2].
> The first patch addresses this issue. The second patch fixes another TMPD=
IR
> bug found during this work.
>=20
> [1] https://lore.kernel.org/linux-block/20231011034832.1650797-1-yi.zhang=
@redhat.com/
> [2] https://lore.kernel.org/linux-block/20231011072530.1659810-1-yi.zhang=
@redhat.com/

Thanks for the reviews. I've applied the patches.=
