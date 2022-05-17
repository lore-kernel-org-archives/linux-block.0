Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 07:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbiEQHAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 03:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiEQHAi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 03:00:38 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99E3CFCB
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652770835; x=1684306835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pa1YAtHt/sAG+BPqxenAIthm3NeaFCPIcX8Unu4STTc=;
  b=LYouk02Ao829B2ohJE/T1SZFPkp76DO3K0aseEgU8w8Gzi/KB2q38Grf
   SpFvRxMtusmM1FqTYYsgFe7z4f6WwsH4CRR5Nsu2eibmXpdC5/+eJRxmq
   pME1j2A4LIlu7qb/4BQqZBFAMiM1Ns6YJdxhheRmmKQstf4a6yEHiAidq
   oAXmlZ4W+OPPx4EAcfHLv+wsreVB/olYDHsTm3Tg0wcIQvMg2D32wGCe2
   TFI+5JboWAijHaxG3++FxVJqy7AEZqFLOq4XAoiwvDh5Zp497vacC+kV6
   3mt7rJaqvm45GBnYyenrK0d0K7n4aQEV0uyXAj12/I2knIgY2oZhgbbVc
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="205396231"
Received: from mail-dm3nam07lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 15:00:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlgxo+rxVjeMPGpNLG/8uO882lg2aC97HOH2aiuFw05pHYHf3EMefvJqlvOkuEkrOzjarbi4SmjAtOGL4LaFkZaTRSClzDy+lVZtO3T5+dqDT4z5zDi+2c8YdqMsm49Q3Ht8J5QzT3PPat3clCRCuAgWsvVyP3RwzCGk09saXSoIC8ZJLlmF/HBUPk5Mz3H0HQQBOwc1LVsMQrKry0hD59+rmIhMbm2hHTAwdAgKp3deMY9h49E9QbUyYi9I587mSF4symtkAWo+pOef+DI4aalRMFkqtfBdHEHJPyl7eRggPIkoN1IR1pNjf44liezwePV4Rn2hsCr8QvT8oaMQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa1YAtHt/sAG+BPqxenAIthm3NeaFCPIcX8Unu4STTc=;
 b=P5p63Gtn/M80aN3Ga4+34NMgrE+knUbdVBMngmrr5Il6iOnybBHnw22iQOFAQ0ZEShSihIssVIFOayIRKjmkDA9iij6Im/W0Ng6JpAd5ddgKf1sJi/uZ6qizvfScCxUKQ4Z3CA1MzB/Yuyy0sH+d9Pv9upb3QACXfuhNWJR7gxI/BxRX27P1yTgQ1fOKHUw+PIC40hHyydJPMtEloGFlV3FEgaZ8o8kXh3ZIVLGgiYu8Wol26+tsXwvTG5ij9Eok784YpdNTSJug5MAX06TCuW1zbl9mPufOOj1lDTtoVzFS7PbHFjnP2enH2OwwKY5tT21nDcQeaXtzbeBe9L9EDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa1YAtHt/sAG+BPqxenAIthm3NeaFCPIcX8Unu4STTc=;
 b=tngWblT41b5e4j8thIogToKKRGqg7BbLjyLbqeP/oLa+xGMl326NZtxcpq/s870rL/9CCU/8NMJSgKgXpbcyhFHgpiFfE1Fjx0jRdDOIlK9ov1aprdhCYvsjFIAopSYTV9N3S5eRM4CICvOL8piiUClfNQrLP7v0LbjI0/QB3+0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB5250.namprd04.prod.outlook.com (2603:10b6:408:3c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 07:00:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:00:21 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] Documentation: Fix typo nvme-trtype ->
 nvme_trtype
Thread-Topic: [PATCH blktests] Documentation: Fix typo nvme-trtype ->
 nvme_trtype
Thread-Index: AQHYabvFgEwAB0zwAkykT8wK0/AORA==
Date:   Tue, 17 May 2022 07:00:20 +0000
Message-ID: <20220517070020.4pkyeyk2ozgoylhg@shindev>
References: <20220511030059.205953-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220511030059.205953-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae902e2-d7e2-49a2-42b1-08da37d2e892
x-ms-traffictypediagnostic: BN7PR04MB5250:EE_
x-microsoft-antispam-prvs: <BN7PR04MB5250385F1D228AF560F1E1B6EDCE9@BN7PR04MB5250.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3QIHKQW4U7cNgYdHkUtS/3Qgkm2yakj8dDHWkEChYNbNIUvRAHmP2ZyVK+d18lpi5HJ93hXL/kdcQ6EuD7lkmdD7ybkTd8v4sbgj61c7zKQ+mdLWWnpQavw7E7dFBqAG0WI7B/YeIM8L015m3Lm2+Y2GeSHKJEfxZz5UKGRlyaMhZmPkYsltlWFj/KadQcXnFqe6umS2EAd9N0WeSGY57gvH8BPvLvL4hc2c3s0ddNzM/StYL/K2P+S1JwUJi1omF+wiTiML4To8vthzQd4yJKaR3geo///vut9aWFONbLLkdvQV7Gew9N8E9IS4s+IuIVTeC7t/26I2y4/8O+B3gYhOuKERlbPnH52FFnpltdUAkIxEAFv2bkGHgYtpCE/wu7UPjDMCGqDSLbVFwo+Re9vgLYLyugBDoKThcd022jxSeTVQbSrD4i1yZiOklHUFwN4xqugfHT1Vk1ZCgdIqdlgzhnc3GJIq9koURYBtBdZh+e51CoGGRM19GCngsNDnj7NvX7dChTxzijGgbTBOk9RwXk+8s6KOg8F9qYf+sCW/TJTNOLiVluGBnwleeXOycDb0GwmFEoAz4S6g8sN0NjoGTgSFM9+VPYAUpaWl0SEOm1FhfncmVxLueArayeGBMglaUCqIMPpkPxFC8BLrp3kep2iH0RQco6xsYAiqEjaQ43JwMYI2SOMGOF9pw77DFhve9yBXoP5WJXU0GvXUPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(122000001)(186003)(38070700005)(38100700002)(82960400001)(1076003)(33716001)(66476007)(26005)(5660300002)(4326008)(558084003)(2906002)(44832011)(8936002)(66446008)(6512007)(86362001)(54906003)(6916009)(71200400001)(91956017)(8676002)(6506007)(9686003)(66946007)(76116006)(64756008)(66556008)(6486002)(316002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m6ExF3rFkzggKD+dOy/qHiov1xFvQS5OXKG0YIGpiDgWNKriEsfCVRH0na+4?=
 =?us-ascii?Q?f4MbyyewufAkk+f0L7WiORhFkgoBT8jh3dO3QZBj2i/P3m+BTa1MMJ1tqa3X?=
 =?us-ascii?Q?7dcq3xnWO9Tbk5yise835mAYoP0OduckLbIKvOhkXmNWLyLSVFNkw/JlJHVL?=
 =?us-ascii?Q?bKu9nnmlxN58zrBknyhS0XAirGCxUxSCcvCRmUzkwVD8CZFnnhbvL3g05+an?=
 =?us-ascii?Q?fAK7f2Vgc3YyZb/7+1c4kFqwMEUkyr4/lCE+LOxp4zEzOTfHRHqJ+l8OLQg9?=
 =?us-ascii?Q?ClyEqilwxm6/BPHp2qE3m9y42jKe8umwQQtA+1IcN9JgCnCMnl5XpII8NnR7?=
 =?us-ascii?Q?NLaKOq+GkiTQ/QdP4aV5FOI2LVVdV5UiIJMoLJnfXJKxCa+5/gUNPBKSXa7e?=
 =?us-ascii?Q?ItTwxsmkAzizcu7iOhGSxCg0S3GGcirbPxX3CQauQWNBny2+ICbYqDQ+IIAQ?=
 =?us-ascii?Q?EuhFJMCv87K3YR0uS8QyYk39JNpNPiSQPQDKnZYoh0ChUZl12LLZ+jNArwEC?=
 =?us-ascii?Q?7a9aFnOGHYGtCO3ckTU6wXA6vRjzYjhonxinaF8J8VpZi5UksFrkn/pYqbGR?=
 =?us-ascii?Q?OFEV0CG3lQDAmaJJlU3x/VAHVrGLpifgH4OrWXdVM6C2KTmdcBm1y7qSIKXt?=
 =?us-ascii?Q?zUj8TTG7btyz9fenc27a9vy3qV026Qxt6U2/biNPmiStOMdybgsX/KY3DpuH?=
 =?us-ascii?Q?N0OekbzCS1h0+MAS2U+yHJacqo+HwalxAGWtguVVyq6Bc1NUTVESqa6mXMXY?=
 =?us-ascii?Q?3Cl/pekEc/xWmvlzJxzTjcztve10pcUEEhw2bqVZemvw6Sb3wFZSqA+dGyCF?=
 =?us-ascii?Q?a3aI2X2wZTAOel1dscJGvsFNnkmkF6MLoaYnN+7TRD54aHjVQvE/8JevZD5L?=
 =?us-ascii?Q?ShoqGv1cejOWwYc3CSaBG1As5YkDDSkrPsfx51sO7XDXv+5GE0SOhmGzyH33?=
 =?us-ascii?Q?rS+GVR2YpOt2iqWY+So0wa6Aa+3ohlVOi4d+8tjhiL2Rztmx0WQ/dLK4S/nb?=
 =?us-ascii?Q?vWaACXYNy3eui18YGFxo8yX1HQGevTE/m7sP+sy+j8Ww+GshLiLM/PQZ5Vb1?=
 =?us-ascii?Q?m47yk+vELdDlPDeiRJ4Kr3MdANMAfL+9ArLigwnTCYNNubHl5a+4zbLh+BiS?=
 =?us-ascii?Q?RRKk2Rremcor1sDS+odjoZh70FOGdRBC/JbQ0yjZiAhCnbE6bmxm75/Un7Sy?=
 =?us-ascii?Q?WMqwlYtuTvo1K24wdq6AB0BgFEDEIgOWHC7tJRrNKhYnWFh8UzaeFrt8Hcih?=
 =?us-ascii?Q?qDHWMfJ6CGahMq2Q7jfU564qH8Y2XoOSkeWwAZRbmMHrYybotG/SvJwOlTTG?=
 =?us-ascii?Q?kG/lIcQ4j0IAGliiWCrjVrjkHh+RqnZ9gtfO02DzFEXqy2JDDr9C7mug30w7?=
 =?us-ascii?Q?r5SgrlqYAsgt2pq/jTD3BDygdrbioYHqGTuHC4WlBWVeyy2vpA9drmq+6a+E?=
 =?us-ascii?Q?6It4DVvGCXeRB82JbD7yggHGg3SYVnZAmUtNPN6LCVvMOlqZjCGyLxkvYavp?=
 =?us-ascii?Q?a0Qd5I010BQTpJFKHHGYT5A4rpOrNqCDYjnJ3y00hQplo6weabITxXgAURES?=
 =?us-ascii?Q?dMzpq4m9MoOvOtFMeefpxcMVzh7Cy2yK0/JoI/tdkibs61ya2weLNoXAk1hV?=
 =?us-ascii?Q?mjJy/MDrXhdN4nbbXaYFTrxMfWkeVx4ZVQyYk6c+mdAljvcS/yJ1VFD/lXxk?=
 =?us-ascii?Q?N9975LBtFiaBWi0TbRPZYR569ep5zNf89OkNYetTA+o6UZ3wtQwwpbE3VqS9?=
 =?us-ascii?Q?uVbJ/k9+qusZmzZd7QwPU5NUqfDIMX5U2/juQt2/EwyYqcVEDEOW?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3234C7824B77F4C9AD38FA4E3437E20@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae902e2-d7e2-49a2-42b1-08da37d2e892
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 07:00:21.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCFnB4X0N6aZk8scd0nP+cVffAB/iBCO50WTnsulNTKTVYVnfaXCm5nVJ6Tya8IPpvlci5OhNHnmnCWjDgAwnWWpyacUzLtPSkvuvjZYpOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5250
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 11, 2022 / 11:00, Xiao Yang wrote:
> Fixes: 3be78490def5 ("Documentation: add document for nvme-rdma nvmeof-mp=
 srp tests")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

It's good to fix this trap :)

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
