Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491D36139
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118518; cv=fail; b=Divp3YzRvLqotuQBvFGG5o8wd4YNHewlKekQz0h8lOQlJC/cOkbTYsgcvCZwQQasMMhTD4LE9Ztcn9uaa8YsAOVZHg2Bq1FVLmBZa7+9LhtQEbgAQKV4WTywSeE5H5oBF5Gq1WSLuyR7mjolm2Rrt6arPB0v3wFHEq7XuErWreg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118518; c=relaxed/simple;
	bh=4x4WP9X4XPCPDsLvsBf9ax8ny4y2mMJQ4Fwi8nhZINU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AYAW8Jc4lsCdZbL6n4ROHgZKQcGmcxU51JU5TlqkpmyADtn/VrW+1DtoK10aG3jW6YEm6XAU681PWZrf1DK8wDaZDfsBlhX+ip5ANrU0DoHgeVM7KGlkngUY2MZ26v3PPmB5Z3GJl1nk70XYQ9lPWC99IyctYGu185jdZ6Ozyb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nmU7vgKp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gnqRyvdW; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nmU7vgKp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gnqRyvdW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709118515; x=1740654515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4x4WP9X4XPCPDsLvsBf9ax8ny4y2mMJQ4Fwi8nhZINU=;
  b=nmU7vgKpsI1O01rS+6BUrMFQjEmvGUVlQx18ePMfdO1pvWMx0RsLC4TF
   d5+lppFUE8XHTOwROrO0im34AEyWea+dqRiAHQviTC95KA0UU6OU3BFnI
   Tkbd1IJHzris9QB2/QYEMpKsGeGHdViFa08d1PMgqfeuZilMzOXS9lUsL
   ylwJ44qVh46eOFxTEZJZIU1YkWc4JarEKcGbxmnrcu9RahWUM5cWLrTWj
   V4x2fwUnGY3YOZp6/vtQBRNkGR/IybhvU0Qt/n8ZQreEFnZVl/SA6YWWc
   3G5KpBo8N1tv7BcCUR/tbwYZXQ99VHUBT95Y+0EwW1lUCPhbtrTMcNT0X
   A==;
X-CSE-ConnectionGUID: KtVY7lKeSiKUqyGP9Xs3kQ==
X-CSE-MsgGUID: +i7inA86Sbm5Z5ACrfUAkA==
X-IronPort-AV: E=Sophos;i="6.06,190,1705334400"; 
   d="scan'208";a="10357348"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2024 19:08:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsoaC64E04pc1Zyi0GPR0S97y5mIyYzVl0P9EpRHqi3Gubu15f1gIYzuyx3TPSS7GTIXyCVg8VSB2fYMnbzPH5WbhNOIQWiL4eJqaaINhKDfZbgzMWRsGqNBaxy9J4VKggUSMS8VRnjHMwcAErwktV9ixKwPhaYc0y4qQQRGoHRkLBi+Q9740wjMdeZsJBwnPDJ9D2DeX5K7fGHJGwlGOgeQV8yZcu6RbhVDsKA9IE5IhpuzYcVfb7jS9Z0LzDtKgT1WbkDB8vXoAwZ7Vwi1J17oJ4lyyPtqUtNWQcp9zKfVzyPLLWPfYXxAwwKJ4f/KoD7DiUVzBxP5OLyf8gY13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqTQ66yq8Y3hxAJV66uLUDNxYGAbm7ulnkoPQuhb1FU=;
 b=DPeTUmsEZqCY2E+VnX+OhFoJPOOf1wdjNQ7yKJpfvuKW84vjwjPkWU7QDlxMn/1yaq53pv+X36g/P3Tj+0zYBsQsHNS1xYbtQg090BaLnYlUi69lUhhFrQ8yL2/xs/7ZZZagyyiLOq6SYgXb8c7bHUtw1hFjhmOmLGnQtPDL/nCvvlVC96tRGKOC+RsDShYIrX7X0MzZ6MhA71xTOHVDDqR41eRsXOkXnJh6faAeiXsdPesyX01DdxgoMU+bpNAysPNgv2SH2AWsN1BxXG7hiaoiAN2PkU0bP4bnqderm4+GDUoDR+7PBDqQPdP0QoIljjApJVHNrXTqf/pE8NiQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqTQ66yq8Y3hxAJV66uLUDNxYGAbm7ulnkoPQuhb1FU=;
 b=gnqRyvdW95tFy7+3Whc8fZc7+wZ4AeVbOpC3ECzO6aWnN8/krGjM2O3a4MH9q2886L7mqMomfCIc1ZPogMqHFBDszqG6+O5mjcPO8i8cEFKjAUoaleV2CGLaLvEtIIKzNdB7vfiGFoWVSvaPMknhesaYcwHAuSIgInPnsx3NaYI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8001.namprd04.prod.outlook.com (2603:10b6:610:fe::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Wed, 28 Feb 2024 11:08:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 11:08:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, linux-block
	<linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>
Subject: Re: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
Thread-Topic: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
Thread-Index: AQHaYovQw4Cp4i7GhUK8xyPo7C3fjLEfp86A
Date: Wed, 28 Feb 2024 11:08:26 +0000
Message-ID: <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
References:
 <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
In-Reply-To:
 <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8001:EE_
x-ms-office365-filtering-correlation-id: 6a1e1670-b593-4a13-b2a6-08dc384d9623
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e4Ng9z8CyAjEAbwVSkuNw3wb+ObbkYWyGhkwY+NGKm098CusMo+9GlHqp1mtSw11yMsvfq3eKGwzl9eySY00J2D7l8RHVDOy1Ej3Yitsi2dobyoUNLBWapTeQP5RhkOe+4N3Ax4GtUpv0uiSuuGvph/66RgitX26oGXUTIRhLw95asgGPAm+semVDEvA+LI/b/xBsFGqhlNv6PujiZs+HzxqJ6zcEdZWl2fg8v3J1aLFrpMvUKnOkgCjZ41QZw8k8G60sgw77fgJpvDP44qmvMjRNWfDB2FQ2RNHU0D1+hmY7/oI0zN5F/WCTYU2ATrBqOJxd8Tf/V6d+BqeE/fy2EWCXXtFJOc2Mv8te1iom7MpTZV6DsHhwVHwR6WToU5et440dd//iBulPWPOuYQ5gcG2BtsgZNDzjMOi/lhCCmwT5oNWOP7Pn/I+t/l04sZoxQIAIaYYYhdqW1CUN0ro3fhfl2We4e9ynXgYAgqc4PjACwYju2uoIE20rsvBF8OH1VVexMj3o+OPkb8AOhDRI5qDXcBWwgogDQEnwtLTHdMPz3QT5dxX7EDtV6lHY/bF6n5aXobTUWxkT64WamIwTZIOyaNHD4A1Nxoa6HGtxVSF7t3hZF+5PQrGdTNdeuXg1ES0ybzUNhhCuGwy/H0YxNDNz74A3OUTSMKZjDWy23B4RZoVqPm0WgDvHI4H9SIrXaJkUNHuRJQ+449qHaYhTQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yGidABvWHRCX3HUPyTjp7P+90b/zRKlsWCZOCSDuQqcDujU2cLVwPc7m89bl?=
 =?us-ascii?Q?EedqioFXra9WSTJ8PsaDFIUcXwbhwQvDMUqIsPoRVyahY82O0vtpqr5WmeCj?=
 =?us-ascii?Q?S+NiP8xk9G4tO6ghu7l2lOvJfKLSKrFCZ4CSKCkOA4hpWYcBCvQdfRf9ZVbu?=
 =?us-ascii?Q?k6ZqjzuFSyO9MwJ7CHEf206H6mMlvssNQ9ga0j+n5USF1dPx74Bz6pyV/XPD?=
 =?us-ascii?Q?kuKcIW4i/BNYEz1lvPeVq8ed/J417fzkRei4cfg5+x0i4azLix17LKkz5V/o?=
 =?us-ascii?Q?A/GJuME+bDbV9X+5kZceMNWydyMW5W6wma/Y6qWQ3AfZIPjDCBx38djuBOq6?=
 =?us-ascii?Q?5/ypX3dVuou2wbwGpd0eGBScQ6A/b2EH131g8oKx1a47Zy1/Onlf3ypPi4Vy?=
 =?us-ascii?Q?d4lNa9XS2rQUc6REDlrM9BCCScqmSteEpNhJAD1rx5v/z0VloyqYPhNE2Yer?=
 =?us-ascii?Q?gjRiH6cHOXg5Ax92mn8z8gnLVzgDNHMuIO50vAflECB8+tX1Z7U9q1DJaj5l?=
 =?us-ascii?Q?vEqlctctI0/adxK+O7CVBwhrylboXpzY4xb89+cUcP3no/OZBeMaCnAVTB+0?=
 =?us-ascii?Q?VwtANjiYPPvNkZfEk6IL9QOoowedxHRwTJUSMDB6rfc21FpgJ8jFAkdQOgCg?=
 =?us-ascii?Q?GsHwC86bcdv1d/JPZDRQlWmowiqDsHsU32xtZGALSkEmPuyDZ9X7TGqX9yiE?=
 =?us-ascii?Q?zirgTSfXD4LerIaFrTwSK1A84nR8xkfPKM9ilwa/iWXLkF3kW1IbnjPb1IZC?=
 =?us-ascii?Q?mqs0+MHhtk4h4kSs7vlUrADyEkwC1aVjrrRGxZ7pBqcaaoRGs1PdRzqrP0vq?=
 =?us-ascii?Q?JiT1xxwk1FDJvEMW5f66ms4rME5tO+j04IMzARXJYu1DS32/PLgX3KNkXR+J?=
 =?us-ascii?Q?a8w4y13KO+ufWvAQbMyAb2pOdJ4gZb2ge0zla7ArgN8VcTwIQskWcXxRPOhc?=
 =?us-ascii?Q?mafLj3MijYFiOAoywd9k7TIuk0eQUdzawDE+teNFHjnMr8OIgCxvwmKCpY8X?=
 =?us-ascii?Q?wYWDp3cOjOx5/cctvEktJpCEudkBWniI5ODeOeb6lk2VBhSJZwWP1a79U8X8?=
 =?us-ascii?Q?AHW7r5ICdDvzfQtWXJB0v8wmpSXznlJdc0o1mHXgKpkNwv8V4w7ynkCJDONk?=
 =?us-ascii?Q?DteuShoGNPGFA/WZxk9i8mjTAiTwrj1PFLVxyYrgI9HaNMSHtRcf67wm0MR5?=
 =?us-ascii?Q?IA/s7z2pEbOwDoUBM1L2qvyQLCXiedyD7fLPcjzy1T+mtCdjHhbBmMc7mpOA?=
 =?us-ascii?Q?e2Td0WmnW2UwsoKO2J+jGui9xUrj4tN8TG47VMTnu7Xp1uSS+8NWcUI0yWsa?=
 =?us-ascii?Q?NmzzrLIatoURhk2IjEeSuXrDgqSBINkSuMyT1gFiHPHHGPNUjIZxnH0aPBVP?=
 =?us-ascii?Q?pR6ePpU6gV7BzTTqy9tCfDtQzZN5tPiFw+IZZ+Tk+ovaXQ6TbnUkXHiKtVjs?=
 =?us-ascii?Q?B/YXey3NbX4HfMZDw8oIhNloziwwhm9Nk49PIl2u//fh+lzVjujkqqEbmCtt?=
 =?us-ascii?Q?MltUD1rjtTcdIBfz38dw/5e63HRtiA6VI/D71rkrMP2vwVBjY8CQx9dycCZZ?=
 =?us-ascii?Q?7QtQnr9hM8InGuDPct7zmCN9qTPV55ll/cqSoQ9iAOMQwbAsyoR/Sqe32EFO?=
 =?us-ascii?Q?THvkJssRCgr/4uXAe9TqEgs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19FBFA86EDEFBB4CA461BFC624DA84F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wrWHEk0Ks7WyVYpoIDWxAB8osa6CFfq2CxoEhOZW+ZMeGYwOGFWI5ZAgaa37HasEOYPRuJam0QI1jLQebwkuKyBAMQjeli9UTnx10nE9QOWENztRaqXyZ+BamiBK5Ys/do6EOwPiugoWB4tW5oCXsIyA9pxGlZ1kEjn4ObvcxvoslEdcAdsQXLRkP2h+3HYfcsR7x8PlDSG9pBw75ouHYwWIPLzSX7+ynz6wIXEWHIQzXo3N5+YVtsl8G2P8lpcsvCuHBLg1Sg1/hTUlxo2GqRodnN3MXTlFMg+J5IXDcltYxEslmp8U5T/zV3NywS7jS1zxRYVfcg355t0vv3QloYyrDms9uqMb2GepHRG2iXRv3Uo8UZjYBHXwgVv6JkS7WyEg+hKYtbzx7ofjHW10tnjztUc0DHLjoTfSYCab1SJYI1YlA9kEF74qrLV2+lkIfoxmOQaOSkLS4vQuDi4OJbk82wOy8y0Auyc0srJpvnSK1I0AC7ah3lJwl8O4oha46GcX4i2sqgVaKtZfkxuUmyjYMmn35+kY7sqNig3VpNWy2RO0Fw6hUPQw0+cW3U9ffBpUdI7vw9F/MhlVzE8XBrNmefqoo97yoqnTNN0RHyP/SpSMMOSbyEmdvkITp05+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1e1670-b593-4a13-b2a6-08dc384d9623
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 11:08:26.1951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DCB+zNu2XeZmhmlnwn23Ko+5kQNCvgu3cHZvpL3SCK6vk7ZX2vo3HJJ5hlOuIcWm4azAe4O3cqKRQcwE9K7tWtGJOmTt++8MWTEOAVqvIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8001

On Feb 19, 2024 / 00:58, Yi Zhang wrote:
> Hello
> I reproduced this issue on the latest linux-block/for-next, please
> help check it and let me know if you need more info/test, thanks.

[...]

> [ 4381.278858] ------------[ cut here ]------------
> [ 4381.283484] WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
> iomap_iter+0x32b/0x350

I can not recreate the WARN and the failure on my test machines. On the oth=
er
hand, it is repeatedly recreated on CKI test machines since Feb/19/2024 [1]=
.

  [1] https://datawarehouse.cki-project.org/issue/2508

I assume that a kernel change triggered the failure.

Yi, is it possible to bisect and identify the trigger commit using CKI test
machines? The failure is observed with v6.6.17 and v6.6.18 kernel. I guess =
the
failure was not observed with v6.6.16 kernel, so I suggest to bisect betwee=
n
v6.6.16 and v6.6.17.=
