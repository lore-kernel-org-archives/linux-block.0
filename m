Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E349EECAAD4
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 00:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH3AAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 20:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH3AAk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 20:00:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2765E569
        for <linux-block@vger.kernel.org>; Mon, 29 Aug 2022 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661817639; x=1693353639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kba22XmPQNKYj8ZsKp2ILM15F/Hq3TaNVV2pAEZHuTQ=;
  b=DBV1UJOu8/nNqxiCn/NeiI27YT5LmR+ZoXwvpocFdCVlEmEmxW40Gg0n
   dDFZ9daIVI/KgpBn42rCWpoDUYkKi2JeCP6Il9Y4CwJhNPoWYsSXIASZX
   HPDBrqsR8HfzLDE96fVtMgsUqhTjA6eODjZfjyCcdwqwDcEAScSdt+2wR
   tEPt4mJV7oRm9ZYb+SkUXGhWpoZzvgLpKYmAqUShwjnbyYeIrhwi/qZrQ
   EcufmwlMSzFRyJ2HFpxorzWOlEs2zvKtjCBa3ni9Hd3aDeT+5N+2NdllJ
   J1ubob4e8Ua8CywkMu9B5LKD9oHTirVHry1CPInX9CIecWzNFbvfcKQFS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,273,1654531200"; 
   d="scan'208";a="322077344"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2022 08:00:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWscuYUCVJwQnpjHUdWeQYXm+Zmsb6X7dAD1d3Pgz87gVaGo9vTC0yWWj9jtVtas7J1CnmzxnO4OaV8nb3El/8W0ZRaBTU8HojGz69BF5HdkYWI5/+QNpDEXHT/4M8d77V1FBZO8n0l6QEswHRGQw+MiCzM/qeMIDpQRNFPrU3R5Un3nE6Rjzxg2x4IA9oSlI8T51Ny4h1/H3MeRl7poRntA9+j/XY1bWF5dJwE7TSk+ww0KcqnC3aWULYQs4F3ksYP942jlO+rp8IYCEryaVydgcB3qnerL9258e0AxsWLpGTCtw175n+folyTKcrfWAQzQ75qoE/53JQUZRtq1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kba22XmPQNKYj8ZsKp2ILM15F/Hq3TaNVV2pAEZHuTQ=;
 b=X4edtkg1w9rZiHdNF1ydZtHFVcCw8WbCazwQSp1FfwzBmilFIRAixxwE7CzXbUyOFpXUPbpfn7v2VDIuGPghqein6q4P5DoDu7YOU3r/p5GTJs0RohsEeXDXashtYABEQ++XDRwhE6N3YfZACYIcp9uWBggAMiZKKxaMa5WfTau0ANx08JHxkFdKlS3IGdWW4vEVNg2rtEuSiPpl98H1ElGYCoTGoorEbcjG9U32Pr0P19dFaGmnvP9pDDJlnPbCDBoPHPrQtG/MvD4M1e6PVewlYbITm+VBhDmMtpg47xJcroEYtfgUxwRATN5MXVHaAXtPq2b0sVvn1h7SsuH9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kba22XmPQNKYj8ZsKp2ILM15F/Hq3TaNVV2pAEZHuTQ=;
 b=wAZfF537e6enb8mRGkBp1QgK0NZ6Rh5UnICgOVSarRYd9uQqT1oyIlA8oCPLDDFiu7uSVsqk+Znq/shAksdYcsd8Iwrz3aYl6JYUlx0ScGfIrRkRr9IWIbjxTxPneJ0wWeuKsMMz0VN8xyZrPLCRGRYTcLKWA0smPzMI/rydbGk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB7970.namprd04.prod.outlook.com (2603:10b6:610:eb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Tue, 30 Aug 2022 00:00:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 00:00:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v4 0/6] fix module check issues
Thread-Topic: [PATCH blktests v4 0/6] fix module check issues
Thread-Index: AQHYtoT6kioMTkqSHk6pmPbn5n/KhK3GmgSA
Date:   Tue, 30 Aug 2022 00:00:36 +0000
Message-ID: <20220830000035.nb52bbnlg6g4c3lh@shindev>
References: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a17f0f4f-0064-41e7-1e83-08da8a1aaaa7
x-ms-traffictypediagnostic: CH0PR04MB7970:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDxAe3+pY5z90pl8lqzYPTaP1F6AIhmVfmTdKbxmI/KY4XqdS3aIBaVt6WXeRQOPLsSN/Xvwk20lKKTqMeRmsjjtoNTFByKfR6F5lIpMSkc8lA6ruS6001G9hHkbwZ9T1acJKszPAXOv6OCjiQ9zU5KtudWRv0vy+lQnftNWrBApq/lQ+eST5t8Ift2ZEf8yCrApyLJRESDypuARy1SaBzftIWLHtYx38LL+kNISMFehDKQkhGuYNoNh8KSNHB7asohpUF3FjYecZJPbTunMzGcT/W93hUKMsMSyyAm9omMpOP31PrhlUyJ06sdsafs/HSMy7SU1HVva8mMFltCO5AQx5fZYlSVdQobfZg3I4cYojIF0ZBV0SjJTO/ZcCTxwpZgOCcluJFdH+/64vrZJ0Sfamr2HEGbOjqXPnUsplNLVwNRQmux5+kTgQcRLhZynZuby57t+XR6oEShzyYTGXFaTtBpP/crSbxb8wr7oyfdJOFOIQqQUlhRBrscT7sGR3LGtEmq6sJMNPOe+aAkZmggrIGkp3uBlrlUxomPlqgawFzNNImIWq6IZzZvD7+oglTiH8k1VE9RDaixRLvhQeeZDfHvLK4JE9yy/wXMid8Nnoot5Liw8ABEUfiJqCplXHFcx8vyYBA0z1NpXnY6pfELfAOABrRcsdEgVlzwvap1gsJAWEeiULEYmlblw7lQyevw+ClLlpLuvh9RxieDm3WwM4GiRfcD/2chEtuVpwbTRjsx6MSJVd8aqne0sNFV5wUKoogUhRSIjv7fsXPkbTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(6506007)(38070700005)(33716001)(82960400001)(6512007)(26005)(122000001)(2906002)(9686003)(316002)(54906003)(83380400001)(38100700002)(71200400001)(6916009)(66446008)(66476007)(64756008)(66556008)(4326008)(8936002)(44832011)(41300700001)(8676002)(76116006)(5660300002)(66946007)(6486002)(186003)(1076003)(478600001)(86362001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GLRJx04u5Jyp7fiJ79JY//tBweEhLPIG9y00wAaHRgxKvQfmUPaTSv4noh0R?=
 =?us-ascii?Q?gYU62uhHvUSGcJSqUuoDLj+IJ1JwD3NAnQnwjSTJdVHQff50Y7rOjX8m/5Rw?=
 =?us-ascii?Q?98t+vZiFEWpjlw11YwFs8YaRnIuQdA/pJ5mgc9ORBM5CfD7hoAvWHAcjOOZy?=
 =?us-ascii?Q?nAsDb669FFE78QYxHuN3owgtV0ukfTjPh8rH0VXM/9P5Im+6YtXExvWjj5+5?=
 =?us-ascii?Q?ThVrDFKGKqWzQrIrwCQVTy3ice+Tho7dMAvjueWtiykwaL5NSOsQ0Ks8wwMg?=
 =?us-ascii?Q?1j/Vw/5Uj2dnR6F/yuo5pFuGL3n9t8imQNVD6mh7sfSDNbDTrPlQXK1wm4f2?=
 =?us-ascii?Q?kpegO6XQ+n5pxKxSnMFFIEUk33rqktklwlyuJiTWUrr0x44a/d0coEPKxcOs?=
 =?us-ascii?Q?JMKhMgGktk3ycJWpYBzRT9V0Dz8xV/aXcsVbhW0Xl2mCp/r6zVKVp8+f9C9H?=
 =?us-ascii?Q?cSPBm8P2xlo95NI//uXBWKNmDZ342OELDjeCHfkPMM9+cnMptD/WcMyeRsrn?=
 =?us-ascii?Q?xVgFqGm3XJpnb1nNqxgQQIxGeYuXTbfYiLOD5NkeQplj3SgsL0Kdf5BV9nW9?=
 =?us-ascii?Q?Wrrv3l3quBEh3ZojxHc0rUCLc8tfzwWo1ZoNCoS77m4aIF6tXahSeoxZCQmz?=
 =?us-ascii?Q?HntTTappQyU1gqfl5CWGhnVVviXSqDqlsLjSax6hjW8iMwxeqDnDSRjb7gqm?=
 =?us-ascii?Q?+wiC7HNbJHXi+UTs6fNuo8p1dS+v+jz7CSCxqyXpKkcZ8DQX/XRpVySvqAyD?=
 =?us-ascii?Q?9qU5SC8Yrq89HsP+B2knoxj425Gut9zIYFja/eQUJdcru9H/oQCiTMOBM7yJ?=
 =?us-ascii?Q?UQW91W7v0IQ3ExqTeWRcFzja7hJZ1IJwog4NLvvoe1k8+X7Ajvm+tH3EsI46?=
 =?us-ascii?Q?A3h9rSySwurVm5bwTwWHrFcWejgBH1x+arFlyQ1NCTqhWz26Vy0yCc3FhwWi?=
 =?us-ascii?Q?yLSagL5b+jFRDG8pfJEK5i60qnHPxUPS2PWsHhpTpc+XuxOfreAALTwpHlPh?=
 =?us-ascii?Q?1XpS3/RKLWyWLwY3nszsAp4cAb0yPb3eY9qWirD972xgFLI2II+XMWTlVAuY?=
 =?us-ascii?Q?ZTHNUL0ReLDj9QLVtsfnCFyNJGK94s0uOJPk8uPmC0TjjIyblZf5yDbc0evU?=
 =?us-ascii?Q?0CzWqZ/HnJAlu7ziAK/a9uPjEDK4w/RJdQVTPT7mzsF/d6LVCBkpd543iggh?=
 =?us-ascii?Q?E5lO6JvUYWS6nZGyz7z/R44ZH7SY8ddYuZ4fkAF6kB0muuwptbq2ldB1ObU6?=
 =?us-ascii?Q?uwAmNc4jgowbwGVvGl/XSY43AWVanc93BJ3/KkZcsrYM6TbmBmXHH2l7vy/u?=
 =?us-ascii?Q?A76dlKIm8J16n4zoNpnEC98b1/tQ4VswwBZdRzqbrHtH749zV+e7kHYBkycV?=
 =?us-ascii?Q?hEdQh0zbNZtDLkL4kDpDyjfVTRvABxF6MgaDnR2JJiVYiPVoeCdaGzlknCZM?=
 =?us-ascii?Q?60TzUvb97TVYnKGwjza2+hPSdHQD7uDd00+SaLrWXs4aqoifzDb3cf2p/urD?=
 =?us-ascii?Q?x9XglNT0iHNjHnNQn0zk07lR3Bx2RzUhWsKgWioEoD3c4CiLFHO7sv/OTiPf?=
 =?us-ascii?Q?ImBT9nnnrFXCH3QhkZhcwYugYOpgc/PQbZr2rvTNKKzaBH4R2gLBfap2a2yk?=
 =?us-ascii?Q?AyxXO4A4GuZB4h2yw+YEzS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A64A27379790E54F92192F3FFBAD0F45@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17f0f4f-0064-41e7-1e83-08da8a1aaaa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 00:00:36.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Wm/JzaoRPZUO9P7CjA4vuaGT5Qw8CNA9jb9TmMVMNBTbvWjneBO71b4cyqGKhTti/YzjFxvKWC9q6E1zQ5gzuwWLZpxRf8wLls4RJ/jIN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7970
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 23, 2022 / 09:11, Shin'ichiro Kawasaki wrote:
> Current blktests have unexpected test case failures caused by module
> availability checks. This series addresses two issues related to module c=
heck
> and fix the failures.
>=20
> The first issue is caused by module load by _have_driver(). When this hel=
per
> function checks the specified module (or driver) is available, it loads t=
he
> module using modprobe command. It leaves the module loaded and affects fo=
llowing
> test cases. The first patch addresses this issue. The second patch avoids=
 side
> affects of the first patch on nbd test cases.
>=20
> The second issue is in _have_modules(). Recently, _have_driver() helper f=
unction
> was introduced to provide similar but different feature from _have_module=
s().
> However, it turned out that _have_modules() is not working as expected an=
d does
> exactly same check as _have_driver(). The third patch fixes _have_modules=
() to
> work as expected. This change makes block/001 and srp test group skipped.
> Following two patches adjust skip conditions not to skip the test cases.
>=20
> The last patch is an additional clean up to change _have_modules() to
> _have_module() to make its usage consistent with _have_driver().

I've applied this series to the upstream. Thanks for the reviews.

--=20
Shin'ichiro Kawasaki=
