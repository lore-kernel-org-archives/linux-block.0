Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B620C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4063C64E75
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 20:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBBUSS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:18:18 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4100 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhBBURF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 15:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612297024; x=1643833024;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O5TFLcjVCKPVhbqTZsMcZQSQsLe1JWZsNKt/HTReRf8=;
  b=jJX2HPrcuOuylhTwdlRzI1k+7Yf8FwhstnTWYrosOGuLJnaror7CyV94
   9M5BVx93hShoMZvbND5nKU1iHaZd+SLiDRqt14qdNbtZFFrKIXaz1v41N
   k1I2aiZMms/Yi6QKfvS3vOVtVdnrNgllgwlZfE5Iq7GINGD4G1A+0IeRz
   lPH/aNExV6Dt4UHFuDP3KSfTIJTykbrwbuNFEyHzXL42L7OA3Ji3jcIch
   aC5++klGv1DSTz255nD1B9VYmuYMPdsiRu5eRUkOI3vOCv2eN4/DjOIXb
   7UtBkTw2gvDVLP0/6K8efPwUjiJg7O7xRo2IObrq7PPUXOtNy+m5S/XX3
   Q==;
IronPort-SDR: E3holTGOSgcHq1woS/cq3g0at4FRIhBO2U0BRpIK8k10A/GRJ+SnBEL5CX8Ikg6AF9/GyAdx8U
 DGKDx+T5hgaIIFLI01lJCyAE1GQGqbfBKA+/96PhvtELDBMeYQEq9rA1G9ke//aGmQDCi+lU4v
 KpErrbIGmURnAGtFVsrcB5jGO696QxOFiaHA+gPO914R63NIIQYUBCFB2O4S5wj6ZDYdSRYzYX
 hHRhGgmUFFvX9Hnw31Ks7xBuiNYSbhi7cfNUqKkmA9vcMfavdnC2JDUMMPEfQp4PrGThq/RrIw
 4pI=
X-IronPort-AV: E=Sophos;i="5.79,396,1602518400"; 
   d="scan'208";a="163405285"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 04:15:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1ysQ/w/LgesZy6r8Zg92bJhZsKOdcLnNPNHoBjHfXOits4AqNtRYeGACZxREj8JOP5k0CXSbGmVhynX/5sh1hlyce+bU/9Nu8jF4JgCbEUPXrUmSHYK8NKx8YomdAjR5hmt9eUCEoDw1ToWJDIUW5T7taz+Bk+2F8Paf4txRnNt0uDCOw8fzIJNZhWsm8zjFQEWmsTc8WaFx7x4AUyArSyB1yCpVAouscpm1VhDo0WbXMZhvROzxRxcm6nHpLUU7SAcFPf27ZXM70KdUYg3jY4AJ3VR+OJiJ0YTxzSZKFu+8OfUAHzXgMmMQZm7qacHTpDozAE2uSP4ChDdg0M0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5TFLcjVCKPVhbqTZsMcZQSQsLe1JWZsNKt/HTReRf8=;
 b=lE1CB2/I4ub9eq38USUGR50ygYUwRBBYXZo11yxZURPpXqVcHzm6df+AAcMzn51YmQfTSrZ4QGlgjjFEsom3EWavMjRcoPrkDzUzkNSrrkh301ddTsyy09HgOhNVjDiNLSNGpo6MCIY1BC4DSecPWWdWREA2tpRkHlH+RYOMIanuuc8Bxg6xeM195PXBlhADXrjIj2FJ5QjQqEHcldhJe/tKQUCIdwuDtaP9cWQFeb/ggNhQ+4HHhyrrjFdPVk8NX5DJDWSGpvcgg3pDhkao31DEoLIqawA3m8++U6Xvaktn2WtY51usE+dYsglw5MNHn+jYFf2oQeWREC6Q976DIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5TFLcjVCKPVhbqTZsMcZQSQsLe1JWZsNKt/HTReRf8=;
 b=ibVLp2M6jejIGmKgNjgtGgfUbh0efY/YgNx49Vho5SYQ7rLJoJ76olPU3Ar2CbAQLuptklWQ4gOgJKJNUruksr/c/BCU9GgjcvYPhvd7brZ/WZ2mbqN6JGbA9k5wvVlCpOwmC8xQl3o4pZaW2Hj8WcJfYAOcU0jKinhd6ISjlEc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 20:15:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 20:15:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH 6/7] null_blk: allow disacrd on non-membacked mode
Thread-Topic: [PATCH 6/7] null_blk: allow disacrd on non-membacked mode
Thread-Index: AQHW+SQ2CnC+kvMZMU2DnmnnzZp5EQ==
Date:   Tue, 2 Feb 2021 20:15:54 +0000
Message-ID: <BYAPR04MB4965D3A571B152859BF766EC86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-15-chaitanya.kulkarni@wdc.com>
 <20210202093622.GF17771@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d408ac9-f23f-4c3e-d6d2-08d8c7b75829
x-ms-traffictypediagnostic: BY5PR04MB6550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6550FE87F1DC2E284C3520B886B59@BY5PR04MB6550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vZSpNZq8ANOWd5qJnJxauw8td7tFskzjmGgN1YkXD8KfKAX8aJ28+QIdDGqV7RZKjGMZb2K19rln4httfeUG4B0/WptpVLxUCfOQILc7a0fejPCWNaXIYgK2NE243oG9PC+MJLXJwn7bga2TwLVceKygzJXufODT1CLhTtJhuchbSskzq/wXxXosFvrCZrddFL/OsHEailzqhh3T2qPNudsyFPPtkhraLCfZMSsuLos5srAH4sDCVUg9PQElTnd4fyp82+OChpP2ZDyFhTKtljCXnGk8K1azY9487GchJeu8I31X817zbAINYfFSCVlzUqfvFqhUmM9MlqQTK1hM2nxz7P3qRRJWsaJv85MezpkexFEmRv0ZDSJqbxJ2GfZrk6uMwh8QgCnoExSJMO1wp0l8WXJWCvCyO3U65FUtOej30CTYeSI+55H1qrBKB+GtlEk06fU9SptK2OFmGX/tDRZv1TkpEhru4v45gd4hRhYWW0Us+n23QuJkgIvL0wPVe9l8wftnCRKJPWHCJPLvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(478600001)(8936002)(33656002)(6916009)(66476007)(54906003)(316002)(71200400001)(53546011)(2906002)(86362001)(4326008)(7696005)(7416002)(5660300002)(52536014)(6506007)(66556008)(83380400001)(76116006)(66946007)(186003)(558084003)(66446008)(64756008)(26005)(8676002)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eVAWgPpZic5/SmpJYKBhPlrQHAyfIjmG7+W+3pk2dmYst9W9h8Js3CP+cB3a?=
 =?us-ascii?Q?8hyxSUwZWEucwxVXanTfQFmw2KeOkXdpN8ROGVzij54FPCz2jISgH/tCsOip?=
 =?us-ascii?Q?fOdicft3EnlFHcHQoPsmDfo+fVeZuwRj2ZCJ42ApeWnyJTcu17MTzKv5q/5m?=
 =?us-ascii?Q?2PPC4yNJEzmzBCLbELBC+BJtxXqr+92p6gwJyCg9XN/6FTGGNELSzSIafRNQ?=
 =?us-ascii?Q?79tlZ1Gmjs3ZleDc4VMHZ8ImPq0Bm30OncKGrnT86BPrDS1TqQJIHuCw2xe4?=
 =?us-ascii?Q?8VX1Y7/R6hGSTr5RuBtys/GBD8MrKfZa3q2QwszxfQKO2QGmm7jA88g1FAqJ?=
 =?us-ascii?Q?3VUM9U4w7cFkm787avP2rvfjj/UCEG8PrJTJSACeOHQXLfMK0bLhSlkTtu0+?=
 =?us-ascii?Q?T90Uq+/gTW5YqLBlO223bpMa7drbRk9rUemAfXCDbrskdR7z/+t8V8G+WI4H?=
 =?us-ascii?Q?GB+cRmijijWx3NWagDW4GdszYmElkZmZhk08bYunhwwCvgP5jf7DBHFpqnC1?=
 =?us-ascii?Q?w8j1/C+yPgWdFU1t6OaE7PJniH63PAKYnPifTOMgy836D5BjMWBiGOX7iSw1?=
 =?us-ascii?Q?boCJChnjRHIo73e/QLEZdPGjiO0DJF/klSZMxS8kfaTUXln87ShxNojfmuic?=
 =?us-ascii?Q?tk8+oLOkgmU7PjyEWhMj0ssdrKzXim7ElsQ5MvklN5UDoCM1s/K70ugm2yPp?=
 =?us-ascii?Q?+Xjp4MUB/iBflpdIDmxFWwklKBDvebHLS2ZOkkEwUL1OIb60RlNq8SuFPQes?=
 =?us-ascii?Q?cHuAd0slB6aRUCDr74kASy4p+zmIDaVbqTMz3AduVn+lGQxd20bDHlLwX/Ht?=
 =?us-ascii?Q?8xwXuWzNOhwx0SAoxUYvDvP5QYptT8DAaKG5cpnSv4HpMyhw2OURTh0Vehx6?=
 =?us-ascii?Q?j+6B2jmmvUVnmjL/Wb1CnghbVgvNDnXVVItxS3s8AdgYlrbMRmVZAOzdowRz?=
 =?us-ascii?Q?Q5n5/bz3obLUvT3hoI6DfVauCG0a1ZDy/QuFQnKqwJpKukFtHgGI60GZqRBe?=
 =?us-ascii?Q?aKQ0qkTEyF7F65L6qFtXQiPLeeS6VmJy5wsXaNEY74Z3CBWg4WMNea4KZhnr?=
 =?us-ascii?Q?jPAtThsetNE+I+rWc/XXvAv7kfY+dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d408ac9-f23f-4c3e-d6d2-08d8c7b75829
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 20:15:54.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9dlTwwz4rUNe9TgRdVlnME+MFdC2uiYIOfO+MmpDSOl5kYgD4jRpFv+uPXRR82BUIsS2+Um3SBhOOtaSXlU6iObuRBG/YnnxnepOV0S0EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 01:36, Christoph Hellwig wrote:=0A=
> What does this have to do with blktrace?=0A=
>=0A=
> Also discard is misspelled in the subject.=0A=
>=0A=
=0A=
I used these two patches for testing as discard is non conventional=0A=
request which I think needs testing to make sure all types of requests=0A=
are passing these changes.=0A=
