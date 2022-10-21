Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDEEC38A2D
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 23:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJUX5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJUX5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 19:57:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610F28F273
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666396621; x=1697932621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sP6CQwrqogta/W/PytrGJI9bLlX38lInKS3K8cskhzA=;
  b=A3Vhm5jmaRqe3ZwYR6eh7RgF6wl9sNuwvR0NlLej0JDQ+I8+9JiTdeo1
   qct08KMAofPlZCyB0PAa3wmweLP8HKbgaTbf8FQ+vfBd3dhkFfWM4YGyw
   0v+eCOMyOEQQGJ87vjnm4UzfmDnlzf7RyURfcpeq8YzGTK1Ul3Vjic0SQ
   vymU9T4wDS0fNzJ9W43jc8GTGMRiPL9xcaj/hkjVAh5b9l4yLzpHLjA8m
   oIFMtSPhM6DYC2sA1YaDeclSqbaKnzCoAyQJ8kbZbSP9qSG8wt4JFtY57
   SDD6bkfB+LKC3J8AmaF/+EfnHPyau4KfyVNJRRnFUTF5Lj/HcaxVOkqdL
   A==;
X-IronPort-AV: E=Sophos;i="5.95,203,1661788800"; 
   d="scan'208";a="214845386"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2022 07:56:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqxpl/nSyp0MR6bfVA2HhufRAvRBK/rP1siOGn9h1YpyUtN3XotZkI71i5LuJcXwNui2AVQxSO2RFmhEyVm4U11gauHNhskAd7TFHAYfvOcRwy6U98yCm1PuSedChBHRMsOkir/GW99YB753z1yrmMsFPDLzb98bGtsUBGUI7QMGink6NFZ8M7DKOsR7qjLy7PJl+bK5GRLlE8KEoE7i1uUDW1IKCWlLNfNrOb+JAAuG9dkXc/9bLZbPw+yjoYcoKT6tnpSEk4XLH3ZmUTAqsIFHB7G0GNH7NfWp5Pf8VmY59IJatcjqnZ42V+oxWQbC1ZaOC/r5kBM1VZi8tS3mQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP6CQwrqogta/W/PytrGJI9bLlX38lInKS3K8cskhzA=;
 b=Lx3Y5MfpDA+rEXzrUSO8+XIesDMq0mIdt7CUTFEp9N2KybTCxelNop3Xq4q4/rhGKXUoecWZyg5Ov1ZCSWx5aljK8A+cXpPUYgn/aUAig1IapDJ/2khEgvzvP+EIHn7J9Hp2eKa2mO34r3Xa/YJsC3tBhIxKVXQWMcxo2an8VbkmOnjq5YcmRABVePQLnlg7Zlr6rPfvIx969NH4I7NNJ6uFBYO9a6umJhx+N1JLKMkg/cv34uderrIuLq5dg9/TLtR+Kun3+SFjhK5SXAsOZw+755BLm/gs2LSj6c2lsGecc7xTtuv85rx33hUbYbdGGJpLdpWTP1kF7euq638Qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP6CQwrqogta/W/PytrGJI9bLlX38lInKS3K8cskhzA=;
 b=x39XBWIHAfc/+NZ743g2QIPaLVn7vAqW/Imhbyp81cuZ87ch6ubABBfMcRJuFBTFLPyUyhTHWEocZFPrIYf9RbtLBDOhx7aGP8P9t1p6R5rJmAKd9XyIegKEihoYXSHuVh8kh1qBPMAP9ShGCSQd1LeuQsNUl7a9Z+cd8VymJzw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7663.namprd04.prod.outlook.com (2603:10b6:a03:324::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 23:56:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 23:56:57 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Eric Sandeen <sandeen@sandeen.net>, Yi Zhang <yi.zhang@redhat.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l6J1B4S//4t0qObxFCSR9tRq4VPZSAgACG/YCAAFOEAIACd3OAgADVjYCAACWRAA==
Date:   Fri, 21 Oct 2022 23:56:57 +0000
Message-ID: <20221021235656.fxl7k4x3zjbbaiul@shindev>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
 <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev>
 <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
In-Reply-To: <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7663:EE_
x-ms-office365-filtering-correlation-id: 1bbedfa5-0f0b-4406-76a8-08dab3bff006
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +r1n6XmBSQ/hJfcpFiUXQwTgwb4XhtZdlkgy7qi5JoeEw1WgZW9P0zDt7pBSh1KLpwsiDmTqZzXyLQm8AfHhmv1ck15yZ8rW871dTe6A9+PlQa/kMOr1pWLDKf1d3gV6AEBT1WLDqbP5qdu8/QENdBSE+PKt8NFUIwsqJ+qmsltHWQ1wklMOQh06IzSL5SPt9C7Pe3dEO8dZUm/fBS71FmPcnV70XZkCZdwxrgv3XzqR0HXj7/bmHycurJA2bo5jIDqh71i1/dsDF4iRJAcrd+MWHPu55zD+uDF09PKQG/OBZ3sVIyf1xbiQChkGTJTdXVZ1ksTK/9NUMzcEzxEIDkqYDwT5gM7T+V5CxZ7kq4JWp9aglDJovASkwLo39ADi9eKHPAiT8Us9GIfWFTXQlLEDeCGdjOuAzRzKN8DAnSOuTQ7f8l0kC6rLgMqCeIJRgEmn7tfxDu5lb5+hSvDiH+X0S4e9UtI3j9XR2WD8E+nUzmyd7bYuoPlbfeFQcXyyGmwEvoW2QlyEjs4W3QdJkq/hxIHtZIcAoiiPV55nIEzak81mT3Lgp1YW0BRpNyJAWW4ypCepNf3DrCUqaYrWs4Pd36Je/bWAU5lpcr/sPFXX56rYNu5guqNsYlVRYAnLQSzz4/tngP0RQ66NnJ/l2s4WoPOyZ990H3z3pXiDbbkM5YurupxFd1M/Y3wVkU95FKFghUmicixsQ7gfmS8JcU9ec9ctFCfykFR6ikVH0x02MDhTmlta8mDFqDkDdqClob4ZKi6kKGcuSlc7kkMFkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(6916009)(71200400001)(478600001)(122000001)(38070700005)(6486002)(33716001)(4326008)(76116006)(66946007)(82960400001)(91956017)(8676002)(4744005)(66476007)(64756008)(66556008)(44832011)(86362001)(66446008)(26005)(6506007)(38100700002)(316002)(8936002)(186003)(54906003)(9686003)(2906002)(41300700001)(5660300002)(1076003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+zoZIrk3XCNaONX158XIanf3L2SXRPTaVfwUJjZbgrDkUlPxMmlWJAnOB08p?=
 =?us-ascii?Q?FLB82N1lqMKjyDsx9aHdmkNVjMQU0TD59RwDgyOAeGFTVIor6lfyI6yzh9N2?=
 =?us-ascii?Q?Z7t2BU5P2fzJwHfK47Lzhgw99XoFGIJYzJiVfeIdiLOFL+ZbYkRYPpik1DGD?=
 =?us-ascii?Q?VodlGkcOw0b2sk7UOAydOHmryW5FsGdVTAZnHeEUHEPFYdkeNGmwFMVtz8kQ?=
 =?us-ascii?Q?CO9Z8/AM0u5DF1whpbZV13gaC4lnfGMbNldPKVH+5xyhH9H3zp5+NVY+nLP8?=
 =?us-ascii?Q?BjZZNCnq7P9vNM6KdNXdSXvuUotdV0OYh2v1ZNTR7SkJNzqIHS7r+bWtL6cx?=
 =?us-ascii?Q?paxqA1IXq9NDrvZWcAGZBwlTYZEpshMrGxzdfcCsDdgXdgHzI3U18aDjJy4V?=
 =?us-ascii?Q?uwfCgFDjE1aiPFx+rg3JLAeWtAiQD7nfY0CUE778p8mtGcBWy0FHkPebtFyu?=
 =?us-ascii?Q?kOr9AwsflOO21nxyPAS7Oq0zDxjpB9eZGarJGqUsEMegIC6rGdM3XLUbKtJr?=
 =?us-ascii?Q?Xmm+o4orLLHtAXJM8pp+MMwICDCEFG/OnJuyvlqI2CCoL7sPJ1D8ujn/zwB3?=
 =?us-ascii?Q?g9L/3i/9AJbuPkDxTj9nYjoEGp+2aUSEeDoLErnQjxGDDwQ6sKW1Ks23HI3t?=
 =?us-ascii?Q?piSNyYi82J1YvhY3IgrYN3CPqPfxewxCvwoP38aiFFcTiBE1WfP/BYGWd79O?=
 =?us-ascii?Q?b3T7XDr8LKsP1hx/hErOgeBG6KxeMDhc1ieETI5nX8F1Vky6FP9ApS8iE6En?=
 =?us-ascii?Q?AlFSG7CQ99Ulan9GQFrGrXmEFHFBeeX35BaT9xJ56DO/eb4LJwOQrhOe0DpY?=
 =?us-ascii?Q?SQv1DTPUxpbtLZi+HYoe2YPClfO0Sg9ZLP2l5KuddXV26J6RZ3aO44PL4Fkr?=
 =?us-ascii?Q?Xe+hnzsYbMNWwVnRLccKGdUkXN9JaJ8nq0r//cyWUsy83rFi6ef3GXaHRTO7?=
 =?us-ascii?Q?rCdlz1A9eCp6JFwwwCZmggKyP7GhcWtQ+1+bI/yNGvzBKUJEDtYI1r8KBct7?=
 =?us-ascii?Q?Yv0cIaBkmN3VfeDcQZhoPr0fgKkm/sJo+1i7yPRd4b8CDLT7h/2SeJBNb5Bt?=
 =?us-ascii?Q?QLleWN2gS4BrwMml1od/S2rdOxSlelru/Yo6wnvaVYZj+kdbv09mkZANmFDM?=
 =?us-ascii?Q?6tnxpH0pt+e9g1TnjFcCzEuGvGriEVNtEQiLygRfP8NcDNYV4N1jXNLFwaY7?=
 =?us-ascii?Q?bQUBMh5dFysHFbOIhrEiJCmaIffBq2veU6fcI0wsGPu2pgzkExv0y6LK9Ijz?=
 =?us-ascii?Q?TlV9Bw81kogYAo2Q4D5qiqM9pgwsq2a1EscQwwyVnzpx+5mketzVxCmFoV/m?=
 =?us-ascii?Q?xAmO6tdn72cHd9x8YyKYRy7lzxZEcY7hstNAfos5BvPo4F2esamAyZrQ3mJs?=
 =?us-ascii?Q?N9bySaIfzm4+Jof28Z6lYbfa7OxFEgbrJh+DP6qrRs2brkYqlJK3LbZwH3uQ?=
 =?us-ascii?Q?HT+TqDTJBn1eBaijRX3cGy3pjnSr3nH5LmcFUYGGRVzoHKtycfwnGHeF0ocM?=
 =?us-ascii?Q?3eCrC8fcm69N4Pd+jKBRphuDF4iifKdSdcGBxvOyB1fM5dYN29Go1we9hPq8?=
 =?us-ascii?Q?CvmoWXAyVNd3vaSbw++05q2zcf/yZbIfPAjZj8Lcomxkra341g+aZ6Y04Tio?=
 =?us-ascii?Q?Gtczm9AA3lXLV8UsZkrt36w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45A5D3A09CFC574CA45E04346F07AE03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbedfa5-0f0b-4406-76a8-08dab3bff006
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 23:56:57.3114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrdcSiAFyCbv4RSAnpoh/j1zrVkt+4/youkiWITriGHTT7Dq2xQ9g61VfguNymquqHOElz4cQeetQhfm3EoXrUrMa1L+bgruoTAJMgTJHOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7663
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 21, 2022 / 21:42, Chaitanya Kulkarni wrote:

...

> I think creating a minimal setup is a part of the testcase and we should=
=20
> not change it, unless there is a explicit reason for doing so.

I see, I find no reason to change the "minimal log size policy". Let's go w=
ith
64MB log size to keep it.

Yi, would you mind reposting v2 with size=3D64m?

--=20
Shin'ichiro Kawasaki=
