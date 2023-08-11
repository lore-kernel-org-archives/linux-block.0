Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B0C04A94
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 01:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjHKB7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHKB7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 21:59:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304022D56
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 18:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691719154; x=1723255154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nk0LCuvhhsDaotY7ZUrLNExdzYOxoP9d8emPnNv5Y+4=;
  b=f/B6xCOheF2bKskhLkCkhdO8Yc/I9p0G5jjg2ApVfJ8nqO1a0T1iDYIP
   FbjfTWvFKTjGk0TUDbtiSJbrMTL96dqeq7TbWv4SEmF4guUzsVHPhMAzA
   5hfIecR8keGw1zDj2hwzn58W/APzeDA/CnEp3sEt1SIkaAaFFrh6iPWFj
   GWoSL3Tc3tQ5Ywv8g7eFXDiU+87MRhPnrxXs+aB6S5EghaR7RoXRcvUO7
   khfE7JnAsXEhfzUlnTVgBUOL8+9Ee2Jv71LMwrNF5G4Kt0r/Chy+IvTi+
   sOpUnMXWVjweDqkdzGASLCZUzsNhZBaE9X3uX2/2/Em48rZfLSGAkqBqf
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="241083839"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 09:59:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8qQ7KItCs5I47jyCd5wEaoKamPdGhkx1nM+mBpWu5OvrfxAHlAmFlrZrWJyT7xyJMbytJjjRBjkefTvijSp4J2gDaW+DUY+8HEp8auT1eF5A2Jt3SpGPRMaKzlSVr/CVLj7XEm7jp/ivH5SraIMRAKyubr+3hTqJTN9Xk1ubO6DC8gdRE4Pba9x9Au6sHzWxlmKUD45VPJt+4rppPQyDqU1dhozQhHhxB5ztHGE71li9BuvEJw+a5soVLl+S+IxScEOpPRAOYC5+BTONO+Yc+/FxSMpNdXYNZ0jQFnAFsAHpimjUgAKedyME7zjRlQy/1CkRKBvZxf2pVD+b+JLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC2vea+w9iCyenyaGvZcqw517fLIpA7EeGwmzFHhitg=;
 b=MamlvCZaLMnzqTBSWTCBmn133n9NifX4GhF+letN6NrWXCP0GJl2DJ7aaF7XkobxQAmQXFkhzteyXazc8VKTc01Rc8DoCyLlm1z4uyIjHtyE0N0zT0wHfA+Ky+JzYd/SnVeFUM+niax7aWHlJisGL3/pUGi2rMMm/+sex1In737tiBuWC2gDpnTfgPTCaHpxfnnDgTzQkgr81wXYt3waC4GHwczVMMhkiyc96ZAnNlzU5NWLe1Sa4SvjSBMXkHEUsellCSTo1Le4vAK29/IIcmEWfp4zz0SxwsO0H2mtVyD41cqY1+kRRCZVDWUXkdCSPMJehthnJn253n5c8VSe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC2vea+w9iCyenyaGvZcqw517fLIpA7EeGwmzFHhitg=;
 b=hxvfSdVf8u8DvAhG4g0ZVHI1NDYzYShfo7Dwud42HMvWwr4XpggWYRWOhJBoYh2kN8Hb6dWV7Zy6JDnhytvBCuR1Avn3PMbBv9VfZzt88mAUPhBl/m8VpaG4Xy1pRBZMKCfU7VKmjJFvOWwcKI5XuHqiWY7fP4JImQXpGhDa0IA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8495.namprd04.prod.outlook.com (2603:10b6:806:33b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Fri, 11 Aug 2023 01:59:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:59:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 0/4] clarify confusions in blktests contributions
Thread-Topic: [PATCH blktests 0/4] clarify confusions in blktests
 contributions
Thread-Index: AQHZwUOzt4XxUvGxn0+Gx0F7klXY9q/kbE2A
Date:   Fri, 11 Aug 2023 01:59:10 +0000
Message-ID: <xgxijykvx4b5wd5aw2pn6quniltwx3gu4e2npbgch5fydmitku@vak55vsn54jx>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8495:EE_
x-ms-office365-filtering-correlation-id: 95ec469e-ed2d-4935-e0a0-08db9a0e8e19
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhr6RSPprs1Vz5EduXofNRp8ABXB1HShKg2CPkzC+bUUXx0JyR48IRzowuRXx213WEFWe7J/lQ21NzKgAm1p/41cGi31YPAmlzgNYrCsx5pDTWfCMqyioVZfnG00E3enRGx0ShAUAswqMsa9ySbTyBeYy9WZkCtKrhoHrUEaTWCAoErUFW6TIxwAwG6+O2o0u4rXpKKWa8iy/VEocO36fYstmfYk86dvimo9pTjOk1OMlkB0BN8pECvcK93HvHCQo/sv0nYxNM32Cjt+ehY0m/yboFBMyj8CYzDLQzwoQrubm31F+VXNf5dz+ilbbGUAgpQRfkYj9KwSslRNYhO6FGHQtbe79S1h1/TZkA5lY2znnCY3Ab11Qap6VTUAxZQXIrZL27GVM4inniS3zAmtO0E1CwYYUHTVqTc7AgqLwVB7yqubalvKED8XdMud77lWOyqbEMNqADJnzxDI7JPzRm0ZcSDmjHDkP1Shxm0eJzIKQ24dbUQe9hbw3PnzpsKOpiw5bikmaz0npboyVxzKX491zj685N2hWYMKuv7bzs/hf2I7IKqKMQbA1imDRpmmjHUEjs2fbgOs1FgaI8IBmZFRyJTBWywI0Vp3lIsJD6yoO9572fA8szT+76x531D3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(1800799006)(186006)(6506007)(6916009)(82960400001)(9686003)(6512007)(4326008)(76116006)(86362001)(38100700002)(91956017)(122000001)(64756008)(478600001)(66446008)(66946007)(71200400001)(33716001)(66476007)(54906003)(6486002)(316002)(66556008)(26005)(66899021)(8936002)(38070700005)(41300700001)(4744005)(8676002)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i9Ncp+UjhTUi5wFkRl5/76mbARcPh4/XuLmOO7t8xVtgf0VFFS1ZTQVXuiD3?=
 =?us-ascii?Q?Bz9rTPsRduKySaSJ9mmnK4wiVd3M8Nu8TGejIBunzdMz0ngZmYcWTRqoyLMD?=
 =?us-ascii?Q?oN2tvqkzo7g3+6MT+TaT75jBz2L3oaCZ/2BAD102BgIkLooP+jxWdmVgycJn?=
 =?us-ascii?Q?mzLR5pgZe4Qi/Ei59RLypXfwZJtKH0EgtXdNdDM5HPcW6qoAyvyz8XWtTHgo?=
 =?us-ascii?Q?3NAiBEqt43+4avQKisYDOPBLoVWfxphgdQoU5GCP2rNICUsyk09gozTtLnOm?=
 =?us-ascii?Q?gStBZlroRaH7bOriLmc+wGdy7gQg6tzxi0cFgSgohOmeKmU5y3hWZ9DD3ARf?=
 =?us-ascii?Q?14wkla2rQuq+GhXKUand9MjZebqzKb1MlE+CLkLVfGGsx+LyACgtqn/PkKHd?=
 =?us-ascii?Q?HtX9yfZfPmTr8WPNbHnYqvM+QrjrWp2kLHAvX4dVVaYkUzimxNAuG9JFXvKh?=
 =?us-ascii?Q?iaRFGLWJUqsm1yrF5vUhNqWdL9zu7eTdI77lWap8OER5lTHVQeIk+GOfELHg?=
 =?us-ascii?Q?v85Mz88HE6WhM+/1qPBLqkdo1OaW7XTDAoTKENvWDr9120ZIVSL8W6VRbaCF?=
 =?us-ascii?Q?9KEiv0mYuu3KoY571XopUKVQe7gW4H9uXtO2WxDuhKbv21lPHYkKCu1hXz7s?=
 =?us-ascii?Q?gS1ubZKF2YQOEs2LRhxMg7P8ks9TObzXf5pMASladke4Hf4vjpEvodoGgqTg?=
 =?us-ascii?Q?mghSqtGbRFmO9PqfP4yAD6nOVOSbuI5vM1qtPDt7OZpL2uJA7U+gRuj78zhU?=
 =?us-ascii?Q?19kHEUKs20Raz2EKwArpHjJMMeIYUjICQfkv01SuR0LuSQ1aY7IX9OFdSRy9?=
 =?us-ascii?Q?KgcvunfDaRV6tu3tkQqYBrAqVESQJsLbtmv53j86lh+qi/4hx5i79+bHzBVp?=
 =?us-ascii?Q?/3UMteIVOiujHbk8Al2TrzhIzYgfkGT/aRrceinz3/1goCzFpEKK7CoV3OLp?=
 =?us-ascii?Q?XkyC1eEu21Iwo0ByLVmudhJgKrGX92DN87mQyj0lbn+Pv3Q+Lu/fztWrbG+k?=
 =?us-ascii?Q?9BsiBVUwJaYR9bP02gSq+jwSFmmtRJxnyzEx2D/HXz4ud7zlcsLg5ZLkK2HW?=
 =?us-ascii?Q?sh9VzmrVnt0khxLV05FIjvuo0zOI2qJ6GQOvt/ow0UQqFXNytkdr0tk7CNF6?=
 =?us-ascii?Q?ys2RrFlVCTKn1a5dYhV9xt6gLhKFf2C6NAHzUEpMW5sI1rMZIb47CwQe3aRC?=
 =?us-ascii?Q?c90qMWumGkNX0C8Bm8jGde4Qvxcr+uTRbrwALniTxIkVRpMv8vlKjfC181Yq?=
 =?us-ascii?Q?SBaymXtJ2GczdARUuKmVghF0hsLCNQy4ygmUtb3OqIU741QTOee3H4PnE8I2?=
 =?us-ascii?Q?X0+PUVx7mkoBagCWupIQR0JxpabTaiYT3/x0ycB3BaAIXx1SI/aFs+hU93A/?=
 =?us-ascii?Q?pQR9cFc7CMJiMPjGtzaWop1vaa1fX1wsFi8o4rtMBlDN5JMV8fCOF1pA/9eo?=
 =?us-ascii?Q?8oSQ6ZIbQWy4JGLm0SVHqVvsEZhlsmoLBntPWYgSXeWGQq/tYX5W6tilR7zq?=
 =?us-ascii?Q?dK/2NwdJBmigVqfGGcm5Gz2U1xCAy9uhPQI8CUy0TT7t7i1K73PIOTgufLQW?=
 =?us-ascii?Q?J6y0ziVkzxq/2d528fPi7cMzLYV1ErHuvm/7d8vfdqxbSicis5hLGIM1jFDH?=
 =?us-ascii?Q?e+I+pUs9IiYoD14gQwSz1Hg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53ECFF40F1C3404990DDA4BDC1265528@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wA0FdNN+6SEnkMPulWA827yWi/oN6XCoglrrw+HkrvaPK+S6DOXZm4GBGyyzopGYBuPMN/b36ne0XAzVMzc7HI+lN5D/78e6T8Nie+npfF9rsnOkSUWR0sh/O/iiro9BXKkZlINY0oVIIAJ531rGVnJlfbgzCM0z9ehoD0/+JjN8X05buY/eEgLmuSX8F2+gv+dOZers4aacNoZestwqm17PTKBj0JQFc0JSmeNjSvIQHANhbpPKh5gsdLqACClv6jn8xZIm1JT2Fu+JIWlOxCrONlv7S4gw71+qIh6nMPvo/F/i1xyuAL0TfllvK6Qv2VJAvMQxdArtKiJb5IWe9O73XQ87VNJGtoHI1YpKadQ1SD+oojRtkuBVLs3uboUOeKhLECO8N36YtIlUDeSfIU5RSEMcOhcMmcDUqJdxSfCBpOFW5K9o5oZtSOy4JQG6VzY0CSCVhyJfLEwoUvSeuQ+rslh3pXx8mf4A0UMBxaHne3Z00WF9dDJ8jTPhq8AZVD4kra2TPRsdxQDVkbARuJ8JdhWRzPVJdp2frqu0Fkzh7QQ429Zgf5OZ9g34MGH7Gy8OKsnDbrabZVlkAAtbtuQWrGQMr85YcDV5KXNY2yTr/c2S/OuNy8ludtaFzIIqnfNhBOwjN3oxI3HCGkYEXnXkbOMX1WOa1AArvE1iGfBWmrWPQJA5xmWAQSnjR0ILH2WILDy7jQ55y3nv2hZDx19JjVnNeS8VtqEv+xb3Zv7m+rgjp9mRHKprmABG5MKGAeSV3j+WdFdzEjq+xT1aeMkZNkxtyObV4KLMz+n+fyMrTLFyXMRSJiT9Lb/0dxbfnDvowSVFSK3mX4GBiVgb4dP0y1P0XPWCgzHDhXj6NV4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ec469e-ed2d-4935-e0a0-08db9a0e8e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 01:59:10.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gihqd76BrUlZRE/xSRo4vkBPMd6Wj4CgCLpAlVydV02A1ru2htqDi4L6hVGc0Vb6IMOuFzL/pqmDYvWGnyKiX5g5n3JZldzJeTaS3ICRwj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8495
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 28, 2023 / 20:07, Shin'ichiro Kawasaki wrote:
> I hear some confusions from blktests contributors. This series try to add=
ress
> them based on my thoughts. Comments will be welcomed.
>=20
> Shin'ichiro Kawasaki (4):
>   new: don't mandate double square brackets
>   README: describe what './new' script documents
>   CONTRIBUTING, README: recommend patch post for contributions
>   README: clarify motivations to add new test cases

Thanks for the review comments. I've applied with the fix suggested.=
