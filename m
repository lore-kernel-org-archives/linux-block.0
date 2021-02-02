Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59589C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D03564F63
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 12:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBBMJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 07:09:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37621 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhBBMIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 07:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612267721; x=1643803721;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=UhTVrRmDasFagWCEGVz/5/upIHAAPkvpFhNr4HMpLqhSoinaWIcWxll1
   ZkcwifP1y7ujDpzhJoeA3QG3w8fPK9YXLj2gQoungziAPvMEvhlb0GXzX
   4J5MTwB5fqJST4+DmPcDYAiRu5UJDtRDYNrkrtn419sFcRTnR1JXekqtM
   x7iZoBtpKYcZk+CXSh2UyT+TaneLrS9aJ1LS4D1guFCzFHee1Z3sF12N3
   0YFreJ7ryV1K8Tf68F6w5CQZH0QwenQIM7wwdCP+sHWa2O1aEzCzp+W89
   uN2cqrNOcc+FeWNaiktDFzvNURkwJeCuhHBAhrNBZ9g3fGPMsCoFyyufK
   w==;
IronPort-SDR: gAPxCcpkiOaTUeotuPGlylAMrVD7yQjUxwL7Hycn9AAwB/nLfC1SDRA03Fnh1aYiqLUfRtlt65
 dvuEhzpO1+7xKC57q/TmQh2QCvhMcQ9rf8JZFjan2n/GeO6jDym77XQSHlIVkpSNPZ5Ul/+RTq
 QuF2YGF8FE4sbStmXyr7pgdF7XZuN+uoZoLhPlCe9/Ft3x5fk75qCvliaU9eker7F0AMRATFUv
 OxyZHuEBflTwbEvLSMdm64D/B9k7izsjYVERgfP2d0YYNp5LfhqOl8yx8DmQ6Ak+nDfNmEGlUH
 tWk=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163362848"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 20:07:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLPKnE07eSySqYrL01/2F02oQ1L/T69SPkDXjE7s5d3en9noMw5sRQjlrm1fops3WLVRBFqkffhi++kWkbSZWZAVaMZ7eR9MA3u4MFrzKBzttQTIiEMagA+2QP6K/eZuC2o8vqyXsF+8TUczAeOMmGQT7eOJTwDHP5OI4jDF9C4aMqhBbaZrQVjPY+Vs9kQmZJf8FmDjk4HREvEJVTrg37lxXxmQ0l3DFVwkilO1GQgM/AtXhdKDQY4DmuuMc0V5vB9YLpJhDXAS5l89Jcmtw/fQPUrxDLiDbH7TCw4rqiQ0GLFq34SmFSXif6KTpLpVAbE7vEn/l/U0UnrzD43tcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eisfLRBNUSMvJFKrnbdW9085zfppNCtBsAgo3RLO31RtFN8HhBqdtNnzOEJgCv2QT7EY2GyA3eDx1SkfQPikcNB6rPK+TSgDgc4gqLeXL+X+9lQ1ssCQJT9o171Y4axntheUM8XYGLOIkr0/O3brIbY/FZ9MS4jvo7ZRqU2vIRURiteaTbpnyxmMbDZw2Sm2UwWX4Qil9l5IiEHumNPXd3FsNuU/X6qvwKBRO6PR2RGSLXJDUQhvNOuoq/Dk2/1uh5la0rWRZ8bpeYJ7TfXsHPVV5fkeyEQGHsRRugfCnmhopS1V9iJ7lP6BuKWxoXymmtJ3OJwnlDQiPqNWn1UkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Xg6Ix+HIdXDTp1MAOWZvf9PDX9uBhyMCF/SCPfxiQ73JYFJcTOQmj588ENSgeRgRtzvhvOPAgAqlBvYK4PoEDiVinkIWkKWAIrGxsObiQ+UKv1LsyM4BQEaqL2B7D1hSU1XenISeo+PRdfZB1xb4/mpgtDBgSMgkZ3tmKeco0eU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5119.namprd04.prod.outlook.com
 (2603:10b6:805:9f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 2 Feb
 2021 12:07:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 12:07:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 20/20] loop: remove the extra line in declaration
Thread-Topic: [RFC PATCH 20/20] loop: remove the extra line in declaration
Thread-Index: AQHW+SYDzk0/uUrMYkuXsUmttVE6fA==
Date:   Tue, 2 Feb 2021 12:07:32 +0000
Message-ID: <SN4PR0401MB359868DD9593A8B5B638F2819BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-21-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39d7db45-fee1-4621-402b-08d8c7731f28
x-ms-traffictypediagnostic: SN6PR04MB5119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB51195EC76E352CA16226135F9BB59@SN6PR04MB5119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9B2WAzSydf1gE6oZkp0AmESXD50klkg2bjI30jtDc50jzhTN27zmFEyWnN/taIAXVV6xGBxWz0INAQymvhbHsK6vu1va0c7wIkTfJmW+e/iGMwNFkp/memAiXgOBQChQa2VEODblNHIrYxAr5W4gymQZdwQyL5vE+cPJQYDKsdxllJSQOmR7di6pk9VQ7Cc27AbMvhSxRrPHXKtiIoJfHuldV3VmSxKXguE6mdlEWMUb/MKbOohq+8vjwN8PE0Jl09zSZ+mKfShwxeRv8Svj0EqjmHbnIpmHfENgtMIlXsntQPuykR/plYttqiXvpTTFbfwWLOUSgUzq+0jr4RMHbOGMVjXwP9KtkIrTm7pWaDUNRZJd5RKhgFV/n5pgqPIA7vbzKyWo6+atlwQ/sHloZ0IWIEFSTSKU2e5WR9H0KJ4J/gDH1DXpUWgAAWaYcrpW9wQtqiIQYB6/FsoZtNTGSc/K9G8+mx8TtQkjl9GwJ/Rlt1+NyVGklMm197lHE+EW8W/2fzPd2188FoLioG0rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(7696005)(558084003)(52536014)(66446008)(66556008)(66476007)(66946007)(316002)(5660300002)(110136005)(64756008)(91956017)(76116006)(9686003)(55016002)(4326008)(19618925003)(8676002)(2906002)(86362001)(33656002)(186003)(8936002)(6506007)(71200400001)(4270600006)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LfQkvnjIJDPvDwGbfiVwaXHCyq1H1Elj2MuGXNOgMexWxpRSF5uR4coL1Pk2?=
 =?us-ascii?Q?pValxc/AyqNftwHCxhKmNgrhTN7SUWT+s3DM5KNAORrhx364joEKBSNIc1xo?=
 =?us-ascii?Q?nuL6z41b04jNoaIQrYyluFdTpTT/5nnDJyaY14qFdoz34uA0DJg+6UQVhEur?=
 =?us-ascii?Q?9XWhuFQ7urIf6qyQpmoiqThqf8e/yE7PzHkgk/hYgfjSIVndCE9YHtwHkq60?=
 =?us-ascii?Q?kriSpbW9nUAMakbyEMVkEcThJCHlu1aVfjIFuD1J/thI4c3mu/jOOFy/ZhW5?=
 =?us-ascii?Q?AE3DGgakA/LG+MF2HowfKQmxMjo7zt9T1fg5hhmsES5MwI6BrhGC5rl0H7ts?=
 =?us-ascii?Q?YfOLhDZJOzEnwP3a8g0UjalSfwdcbbhQzuE/VNZHsMPjIvQp3wb+ayo9uifR?=
 =?us-ascii?Q?bituSBRuAyZgTs7g6eNeZeoAz9A4tBiJAz5Gzg9TZpBuP/NfulLrRe+WrLNs?=
 =?us-ascii?Q?Huvk86rHIrDLNGuZtP7I5whrxlgxrVnxycP0NhP3t73Ma/SsAS9MZ2Jm5cH7?=
 =?us-ascii?Q?SjA+d24v7p/okHBXY6Cw+QrRoHzKfWE7MvkwJ0nPUcHrTR8Mj5aM4eUBKlfb?=
 =?us-ascii?Q?LFqXqNxLw5wkPgsrcew4u4yBqLkgQXA+N+Er16RIoDe/NcF+3Hp6xzgntC9D?=
 =?us-ascii?Q?VsnpqdIIdP1bcFQFhoBDIQOhLBiINAj3AGrTwX2qeeuqhXVJ86fTNhH424eQ?=
 =?us-ascii?Q?BoRLXXlL4O6z8ht5dtHKT4ELHDN8UQNatS7XAS7CDTdF/leXnPmAkUokq70g?=
 =?us-ascii?Q?euDnnB1ddy4GyNc59Jh70iuS06XdKkWAGwQLG9l4gp9Pup+tykNuYCnqVRWv?=
 =?us-ascii?Q?8SOqWoQtwIz0Jb43h3/V+ahQJYlJaXN5/uEDqSd2/9QZveGedc1tD6a7GeYv?=
 =?us-ascii?Q?cDOYLdqfSZGMquYuZdeCpN6QSqUugwXS380wKoqgNGO7olStWT2N3BTcel9I?=
 =?us-ascii?Q?jR6Q9N4pSBUAw+SevA2LgOR5xBPazrkYSeTkCrrGttH3S16c4hs8YQBHQ+FR?=
 =?us-ascii?Q?31u9LZ3JWEBmbj0uYbyrbAgA9kTb+9Uge0moZemJiRDAWbk0XzB9AGuMk4Zq?=
 =?us-ascii?Q?dYVzcTdYO7K4kcFUdErCezduVSdJ4osxn4rFEmjl9ukdTgPDChUCmt2NreiM?=
 =?us-ascii?Q?PDw01+OpqJka0jflXByKqD2teYvEP5VwAg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d7db45-fee1-4621-402b-08d8c7731f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 12:07:32.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7+YOB+3fjvd2bm9pFIT1iduCdo6mlgnlmWJMExGxFFaPmb/zBh7jv8QLi1MP0KjFbgx7NE+UswhDKfrVhMCT/9VcofUjFkAy531EEzb0vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5119
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
