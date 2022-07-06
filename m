Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8DC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 11:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiGFLX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiGFLX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 07:23:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8A15710
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657106634; x=1688642634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JxKiHPkydbui6nKC/EhAbdWkJ1K1VyLfQm3b3/Pdjtg=;
  b=HA5dByEl+asLK98OgXpubdDOgnEIs4Rdevfcn9KWyDyQ73c8oUlcdXP7
   Ex2M32A+VRDu44omWv2SvSh2Am7RS/ucbKOpCnJ88GKgnklUPwNoNmjuu
   K1UuSxFVh9HB3Xr8EhbAShsTESoGCVnqmHoITXwnvIQKiwrsA622LGHCs
   SrTRc0joak2q12Il8x3dIY+eN69IO8i45vkmM50Higpkuck2tmR63UaEg
   mTM2PzAAN2oGgX4YZ9b5fJD7z0liGzgbF2nmfvr9K2eUabe9pvwmtzor2
   xm1ATRGM0vTFtwoH+OWMMzIol8raOH8gZnZm9sO9NtNy+IjsgHehjqeXm
   w==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="203631322"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 19:23:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ3cp7HX5sQxtJRmfiB4RH7kqkAMrYcnripTL6VtdmmWrplyeEKe7EGz3Aii8Cx2DfNQh8xCwB7FO8ON8U0owjd3i2xsdTbzuEmz9pAKgLnAlTRBrEmiBH8TLLyQTuWV1a4hPi3earZT7bpzfj9XgGYWtQPG78RGQhAA+4cPhg4SvX0Hw7T0vddOZLLsP/qIaZ4a1tD5EtehPAozLXshYUbg9Q8oVq8qO8Y9pW6veidAgah6ndlH10I05+0HMYPQI7U9FE0sGWeT4aufvYXgQyPFRqp7rPwsnWagxAZgGoYE+G1EswsnzOtau/nto0RXZhYpw6Iui+L2fnomW6RPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxKiHPkydbui6nKC/EhAbdWkJ1K1VyLfQm3b3/Pdjtg=;
 b=k/1K/a8MuQLLu9WuDIqnj/wlAnWz6QxPyZXfFW9pPiLh0UN27OiA6+6FlGKzzE01S8xa68a4MlVsnOUAQB9TzXXsBr965MmYJ5rDDqvooVOr4EPE+1CVAIqfq31G/qlyMr94KeHEZL+r233ufP08wPfB57tA8heCpoObmKGhdbyYSoEDsBdz1l/2z+fZTR5r52fwkveMB7yU5o6jsrS1LvpS1eUhSQmmTSF7j1OqaZX/wUQbqVA/Kzz3eH8+wu5pCGpjUcWjcQm31IFLK2SkKITfYE+QRMMtqSQX6LbdFFf9w17bGygUWZcRvg7xWfXBOrJZZqgFkkhVBEFTkebMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxKiHPkydbui6nKC/EhAbdWkJ1K1VyLfQm3b3/Pdjtg=;
 b=teTXs8OvGIr78rCiTRT3uh02xy8wRTVh9icZPsHqKE5ceUEkKR0xySm4kzvVlMp1bFT8aYxKQr1BUMLepGo3bEAQbL+N3tPfvmN1jgvLg0F5iwz8n+lXVgs7MmG12k4zkcZEv12PWFhe9o43f/et0pv0xaQQIkwFF8sE7pNaKd8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8420.namprd04.prod.outlook.com (2603:10b6:510:f6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.17; Wed, 6 Jul 2022 11:23:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 11:23:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blktests: print multiple skip reasons
Thread-Topic: blktests: print multiple skip reasons
Thread-Index: AQHYkF3CbIn6+UHqqUaQcGpiq+iSva1v9W2AgAE/kgA=
Date:   Wed, 6 Jul 2022 11:23:50 +0000
Message-ID: <20220706112350.r3lgd6hfeteu6lfd@shindev>
References: <20220705105537.hdjmbq3dcok3srmj@shindev>
 <d5c0ac21-47fd-6aa6-43bd-0ac8052094ef@nvidia.com>
In-Reply-To: <d5c0ac21-47fd-6aa6-43bd-0ac8052094ef@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15d3b3f1-e749-44cd-90f2-08da5f4200a5
x-ms-traffictypediagnostic: PH0PR04MB8420:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBJTdZpQDRfHkUhB1gTwqp0yGL/XNeh1rvwnlc2Kit98GYxElaNbOOgeltoTRJtl+oROofgQYkG6uqyE0sC2De92FRycEJayk+bNiAQSkoflkkePmORK/dF8Y3oZ+6/y8O2tbWcRsWjQ9aMHtqU1rJOhXU4iU3rZ/KeXzO6jyZRv3kBF7HUVft0u73YJmvHLxRM6ocF4lE7QGXyJNnI0rWjwzzst/4DTxsZ+2KMPKTDpxGBU1pL2NpDytH5w3O3Zv5XqUqJCSQFxojBe/UMJZSoWM3+f9Gk+hoObhOwaU5T8jOhE8+OxwNPHxkjU9ul1MxAIJ3muQyPcRPtXE7OiQm66KoIgEuWsxk3WTNHk3I0II1kMlSgXnonMIaa2W3m5f0Ac2312do1rkx/whHsXnE6Uj5LvJqFf7x53+xMLW3yWoDvBJ2xV3ZAxRDA80vhUifTe8iwXJrocNBQwsto6l74fQVljvQmA6XN8oAuj7VDKuhQ4/lV3Ua/RSvyuHqX3rr6YMOg5LD3pmgdzdiJRXetNmsD97VpsDA++S1hVBp7BjdJp5jkAWP30nGz4YOdy9tpU8f8bNYVN+ep5zLbEr1yS4ATMxT9OxM2NTsNAbsW1ZbfatojGdkUEuunrc99J8KV1i3AKjzfqUIuHToE6WbeLImpX0VXKrtde+FIpYBc52TR6tolnnc9vQQgCZlY3fn9skO/Eax4G3sgZLTItFoPMOJkFC+Nm6eAvfLeD5+C560M/bIZuxA86sPYiP5+1/D6kbb6IXAZgtlNIQAyG1JSnHxtINiV9FI6YDHyGdJls3KWyHn/Wi0YGu4f2r/0jpNkpECzWCV+V9HZTWneEqlbuDBJO+9B89toMI9nozQk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(6486002)(1076003)(966005)(66476007)(478600001)(2906002)(71200400001)(66446008)(6916009)(316002)(9686003)(53546011)(91956017)(66946007)(8936002)(6506007)(26005)(64756008)(8676002)(44832011)(5660300002)(86362001)(4326008)(76116006)(66556008)(83380400001)(186003)(41300700001)(38070700005)(33716001)(6512007)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aUKIYbegySU9f+YZ69INF+vDDs1/Le/250S9lZYW4Y80eyGUkahzglG7V3Nn?=
 =?us-ascii?Q?P9tXU6gYDtrLCzBVHiN+K8Yn7USqrnYo8QpRJ8+YMHl514DaS6N/foVbStd/?=
 =?us-ascii?Q?e1zhtxASIlB3C2hTo/Abc3o2B5EaA0cVLxnz2a/FUlFsXHIwMaxSOvRgUkUb?=
 =?us-ascii?Q?Rx6DOKxe84Ocv+ea0YV6fcPbT5fwJITO9hPfrxUlXf4B0agQDA+F4uvaSb/n?=
 =?us-ascii?Q?zzdfBouo2KJiCJfRVXXk1EqgK3TRrVCGeXSF9kfdXeENbQlHm8GMXc9+Oxit?=
 =?us-ascii?Q?bKjj6302PIsp7M5lb6+eRsoodRymyF2rlB95gNHkucg2kIXCHVU6P9sHfSXB?=
 =?us-ascii?Q?DnZ6Ri1bDndxOIAR7d5PfkIqFwRk6B79hkGnR/UyRCEqs9mMkh5zrpl+4vKN?=
 =?us-ascii?Q?Tt+H6fX1pN2v7kMyOQ+rxMblV4bHL8/OQ2Dno2gfp7sYXe2q1Ctj/4PTN3c1?=
 =?us-ascii?Q?1ZnDOM5Qo1Z7YM0TB4IHSFEzI3hluEA0OCfb+2lVnk+fFuK1899dhaXRa5UL?=
 =?us-ascii?Q?SBWi8DS9qdV7UyxiHIS4xBo8Ps80Cj2qLYL9xcLrWF0sx4Wy8VWHarwRHzJp?=
 =?us-ascii?Q?0VV59KjmFnGi7un37FYP5n57/e/H44/+JvYmfNBjZY+wzkrg74ZpCeTyh206?=
 =?us-ascii?Q?IQ+R1uqHdhfLedjjadcDl9jOkmOl5hF7xg8obawQsTrQWxU3fOLi8g7A6Z5r?=
 =?us-ascii?Q?9ytkMaPGKaq/HVKr1GpUoBs4ZpANrH8Wx1V4mzFwHwBsUTHH7ioFR0X5je4y?=
 =?us-ascii?Q?P00brPPfgp+YSZ/7teO2Z3ar7RltI9iZoTfYPxr2JObEt/0PKMKdIrn1tEjd?=
 =?us-ascii?Q?4SATNRzCNIEBdyhekbTELAOIcV4IV7j9EVKrl4lD9+U22DdwUlRgATXBNFpq?=
 =?us-ascii?Q?HAGHQgEkoycr+ulGdav5s4mGQ5VopYGRdgtX3L5SHe6ugODAFr+0eg37Uy+0?=
 =?us-ascii?Q?7ICq42S98Rv4wWFsSXmFlO6Fc/hZeWrUkjMqiG91nE7EAalA2bM4nLH7f4eL?=
 =?us-ascii?Q?g14mNMEzFNOk7O6NpqxUWoYqhP4wmB8wKEPfCnQXOT7XkDsKu8v/axBYWn6K?=
 =?us-ascii?Q?lOEvczKot3RW3xCeOW5mBR9MELoLsvpwQUgfQDDvxKgAEDQ60IiyxPE/MnjH?=
 =?us-ascii?Q?YCi+SHpAfet1vukzy50n4h/ZpXYS1GovmpUfn+58ffnZiaPBku+jmIY4EH2D?=
 =?us-ascii?Q?uxkUEr/VTtT6OftAMxf17b6vx/RP4QRd4EW/V4h2YmAi1tc4BGGUpKxXbmDY?=
 =?us-ascii?Q?4ekmXLXTz+jiRLvHFX0FJqimvkG82dCPwQz1AVXeEEG7U8xT4FPuNjLHI1ad?=
 =?us-ascii?Q?LJPFe3cyUyso4dssNBs9wmjHpsr4Puwfg2YKxebDuMA8a/odEMCN3a5FgPy2?=
 =?us-ascii?Q?j8ifcAQFz2jcb5Iv1ty3rZ98epw0B2R4O+kpBZL/8jweHSMPoseKmJmur1zK?=
 =?us-ascii?Q?brpu1eEmVqo+hjpKRIZxxsIGzclYct2sNuS31OtmeSnR3qWIYmgqwuy+i2L8?=
 =?us-ascii?Q?rEf49stbuRvpN82Lz7I+16ui5kp+05AHJUUxe+Jtr462xhmNW9B3yWUUqeGV?=
 =?us-ascii?Q?2WTIoT/Q8MViB73Sl/ZIPQyuX+4WULE6HUQstJ8EpH/0h1Bw5S6fkD4YjimT?=
 =?us-ascii?Q?wJl+l2MflH74U9VjV67LuQM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E4758E7EC166E4A8F4FDA42E9BD64A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d3b3f1-e749-44cd-90f2-08da5f4200a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 11:23:50.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKSxUDrfrQd3a/8mnEHdEAvjvHhObl78+Q26EMZtxhUROwj6lCKu1vgqG8jp33+ib5HE7efHZtx3x7cyuo/XHzP5W4fcHPRCTgS3/oCKvt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8420
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 05, 2022 / 16:20, Chaitanya Kulkarni wrote:
>=20
> Hi Shinichiro,
>=20
> On 7/5/22 03:55, Shinichiro Kawasaki wrote:
> > For those who interested in blktests:
> >=20
> > A pull request is now under review [1] which suggests to improve SKIP_R=
EASON
> > handling. Some test cases or test groups have rather large number of te=
st
> > run requirements and then they may have multiple skip reasons. However,=
 blktests
> > can report only single skip reason. To know all of the skip reasons, we=
 need to
> > repeat skip reason resolution and blktests run. This is a troublesome w=
ork.
> >=20
> > With the suggested code change, all of the skip reasons will be printed=
 at one
> > shot run. Handy. On the other hand, it will change the way to set SKIP_=
REASON in
> > requirement check functions. A new helper function will be used in plac=
e of
> > substittion to the SKIP_REASON variable.
> >=20
> > Just in case you are interested in, take a look in the pull request.
> >=20
> > [1] https://github.com/osandov/blktests/pull/96
> >=20
>=20
> Is is possible to make pull request available on the mailing list
> as a patch-series? as far as I know not every developer in the
> block/nvme/scsi/dm looked at the github explicitly ?

Okay, I'll ask the pull request author if the patches can be posted to linu=
x-
block list. Or I may post on behalf of the author.

--=20
Shin'ichiro Kawasaki=
