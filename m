Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234C2E62B
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796158; cv=fail; b=tfYe/0ijLMIG8KiXpkCHNVH8K3+kGW4+WMbok7jtyh7RjpjSTN5K7UM2pp0XQGT1ndFTGWVZ1AtjWASUHVjIzbmmkejMz1f28Thfl/rz3Mtf5/VsT9SG+hbN4nzNYy5TjMVXUp7MM3LR+VHYP6bl/SDfl+CUGNrp2L2BW9qNRvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796158; c=relaxed/simple;
	bh=8WQY0M0Wixgln2qlJmevr3jsC4WBGY94G7uig7sLXk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeTrOOv+Y536zNIRn3OVUyhFwWYXjjDw7wjEk/fXtTISWOHddYAIKGdsiDqqL9CsO9Z+YaEBOmEe6c/gCtuZlsKhY8xserhz+rkmlByody76+Ghn64PS2wP8Ak+EAnNiA253G9pW32OA7trHfyrZglFz7ihc130qHeA7x/7hdmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k12YBLAT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=viHA+SLP; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k12YBLAT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="viHA+SLP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716796157; x=1748332157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8WQY0M0Wixgln2qlJmevr3jsC4WBGY94G7uig7sLXk4=;
  b=k12YBLATwBcSi9NdMD6OLls8Re4h6s6wXlrvDavY24UG+ZiYtS+kYimh
   28g9c/bTQsUwno598xwAjFSvM+B2ZLk/GeNVD2wq2471hIr4+7pd3/nnb
   epMikgp8vKIDaHjmWXFH8hZc9VttAaPog9fgSKVk1j9rsAOopFjVI4ZjA
   9ibhG4pBHQ4e//QwJp7H6Ttp6HiNel9KlGUBemwmiD5ss3LG1P95BhzBz
   AUAsvG8kJPmxES+YB073FBkyEzK7KAFuMRKGgv0XpBUrbkksTA+Kgh/By
   WC60mDHxOxW2ff3omadXzANPur6VU7TAtRSlrpLWC5tQkzEY1cNWz6uci
   Q==;
X-CSE-ConnectionGUID: 8tOJ5bbeQ/W3+X/IcbLvIw==
X-CSE-MsgGUID: 0nXcsf5rSiWhKwZswY1Emg==
X-IronPort-AV: E=Sophos;i="6.08,192,1712592000"; 
   d="scan'208";a="17409831"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2024 15:49:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3+HDpd1zFdzEAR1ObiSgHwdDnWJZcHhIzzncueY8hreMLQ3rEWjEHkpRaK8/sMbuE/BSliuANPJb1DZxTnUbOXTp8mL0BH0n7yya502ojEpjbbOl3T/aZ2+V/uAYAI0FtbOeOgpKGh0CRDUIh/fDLMRcoj0siBg+bDAsfuOxVaFWzX3TK9Qs+hEd1p9tG/Wt13vXbVPTUjFcPm8jNFv/wXpXEin7sPtccevOxvwUR5X07tJGd3OYfbYxWKaHkel3yG67wSCxFdxql2yU0QrOIVskiKIaZ+5arRs+V8ZgGHh9XMytfpXVYhqIiCWvqx0Ld4DwR/4pkLAYPpvDK6l0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx4mrM+HKOOCe9FiFStCgDuDayZWV16o1j3AF7VrT50=;
 b=BJEsa8kqQQKfwTtw+ExYUbur8FPI5Bd9GGDZVYUm+uKB9hlo0/tiPTAAffCh+3IrM2LIhBGDV8exwc4++amA3LmB5WgW1yf6Hq/0A4icG/EkBzV0Sel5l3gnvl2aOWDGvJb39PMT8PbDKNC8qQmTYdkXg5rH1BpETkfdibpGSbjkUm8kcrTOmplxrLYdobiSgdPRbNJPhxY01Is4LXQ5O9+Jtbc6jTnU24N7bFcX2MkCK/l3o7bVMGUVVKcoT6oneaLWYKO/+tc1g8XZWLNtB6ZDCFrXiMR7AGhcpA6fFaGbt2dJ/oZhwUp/2FLKjlUXysoFjPAAyjDc7ma+v1Wrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx4mrM+HKOOCe9FiFStCgDuDayZWV16o1j3AF7VrT50=;
 b=viHA+SLPv8Ee1wkpSvyfrAS2SDUID6hUa2RnJNnuXf8d+wtIwvRsmehi7CxiIuQrhp/xhf3Bm1efY/pBUP4Jqqy7X0j1ynsk+3cjF1tMSlwXALUIB8KWXEt1JMwlDMO9ZQ2yInbhluniUrWYwiIXkefVi40yLMDIDZQx6H4oRP8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7799.namprd04.prod.outlook.com (2603:10b6:8:3b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 07:49:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:49:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: fix how we handle waiting for nbd to connect
Thread-Topic: [PATCH] blktests: fix how we handle waiting for nbd to connect
Thread-Index: AQHaq6POIzbQh7y+cUGT2zs6FG/CorGi1NoAgAfokoA=
Date: Mon, 27 May 2024 07:49:07 +0000
Message-ID: <zv2aiq3nmbvpnk7oiubaxuxv6b4tie26ojfm3nnpboos4sn7qp@rnm7gycicli3>
References:
 <9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com>
 <p7qubalwunuxohkn2rfxejl2jkfpcfqp2d722xra4vmqpiofid@7niwetngzy5u>
In-Reply-To: <p7qubalwunuxohkn2rfxejl2jkfpcfqp2d722xra4vmqpiofid@7niwetngzy5u>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7799:EE_
x-ms-office365-filtering-correlation-id: 8299222c-e627-4ba0-629a-08dc7e217d37
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OyoNe88xye9UavPB4xYnQ790yZZS0h5w1gpuUv2OHiTbNzWEgSF4zh7d9dlG?=
 =?us-ascii?Q?C8RMq/SjsRztUB98yyiVkpmVkGeGF5Qrk7XYHnwpDnDU0whPiWG+T7SVkHCG?=
 =?us-ascii?Q?5KmhYcjDpbvr+sy+mf868b7TAewz+i8nfAqwXhygbZqJHTuKUlRGCvRIJ886?=
 =?us-ascii?Q?4uoNpQ4guCPjj2Z8juUQTaTUb+rIWMXSPk+C/DxqB9AJwVceTR92eoiNde0P?=
 =?us-ascii?Q?kM9KqKOkl57YGyqZR4IlGMNVO6XRQiFnOp5UmxlG9tZpOc30q3BSgtzX7Bag?=
 =?us-ascii?Q?KmL9W6VLpuLyBwhM74Tt7A37720vijOnSMFrI0ueuBKGdzyOj14E5LERAmOV?=
 =?us-ascii?Q?d5RBXVpReQOi7MQhJtGMWcdGiC9ZOg815nFicbWhHnKI8osUCbqC/Y0RArEW?=
 =?us-ascii?Q?9940DdLiDsI+2pbya8v7ZnT+Y5u0NAvP0g2lKhrns8z42jHIcBIvRxwOeRtP?=
 =?us-ascii?Q?xPksnX2XlMLrbmuWNXzCXTlJqAYOSxWAaf2Wbdk+sF5ac5fMYGP0HgEwNcPF?=
 =?us-ascii?Q?jM+i86rkAAq1MI3DcGbC4K3Shylt+OJsEPa21t+2UyAQUCu1ui83XNRKdIOc?=
 =?us-ascii?Q?zAqGEQK5pg3UEwMKXbT5n3qrlWBEpwwCC3phvBgH87fZAKXucqpRXUe7gE3/?=
 =?us-ascii?Q?yOmIeCk+OtzP4rTa0/VoNN17K10dx9QOOaOfhBrteZuqfdEXtQagUv9/vtdr?=
 =?us-ascii?Q?JtmsY/ySleuw0UuuInSlUFS5D2wukHn15kuCOCgvxkkhZTBeNfQBZ69nFF1M?=
 =?us-ascii?Q?JqoOzyurWoyrShxy0t+vHC0dvI8tndbM1OTmROnRyJCUtpMrjTF+77b8SOxW?=
 =?us-ascii?Q?XzTIVgSZUL/QO9JwQ+aBSWbeve9xg6XIczU5yLjYN0IuklROlFdLcQPTWD8L?=
 =?us-ascii?Q?Nn8QwW5PpPqTjF2qDoldwiaKOteeYBhmSxOyThf1e7u/dS5zWUJc6wV0KD2E?=
 =?us-ascii?Q?g2MqJWNJqNA8fTYc9Swc5pFI71cKoVpP1u/5vxYFB296l6YlWVCio+23Wszl?=
 =?us-ascii?Q?YL0VMnU3KxTfdk+VQ0w+aLf+TKBFZ6f1wEJPLDUAs2HNb/ZEcIDsveCQ7FNY?=
 =?us-ascii?Q?zswRB+JUI/2hsI37UjXhFJ9ScxC5YKAZWl3J9j4ju7KwbaliO0T+H9dwFLdg?=
 =?us-ascii?Q?y4c3J9oo/rT+bpdQ2Bd2JgYP58LKGffqwxsDvCdXKcBPUulup7G6d53ERv16?=
 =?us-ascii?Q?CuPzNchDIApN6kFvI/jD49wslMC/BtVvwUTShK0fqvA09aPp8lW49yChXco7?=
 =?us-ascii?Q?BfxlcAaAXJTemXe9g4vJMPdYtwo3JofFk3uY0heyYA97bHdky9XWDyQQoeMt?=
 =?us-ascii?Q?QqMbRJe9AitJVfncHDq7RckRqNy+2Azf8yLUZG74zNUb0g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L7MA2+UB1Y8CW/xffaxYoqflAJMPl2addA1zywrtm52j0+D4qWt5IPNR+nFC?=
 =?us-ascii?Q?qEEeJD+AqyHi0xRAFjEWWE1Bawun0L9Trapx6DRKOnu26eU8mDyvH7KElHGw?=
 =?us-ascii?Q?3gcnBZoyXn0amx232LIOJvddpDKJ2uvPapD1Uc4BYu8su5I1Uglt/2HHodFq?=
 =?us-ascii?Q?aRwepnGrG9ebp27zZcnzChId7eYUr2FeS3hsTMp87SqgJo0CE4VHdCmrEFcx?=
 =?us-ascii?Q?eeTOJDOnDt/d0OtG8VTwQ1fCgJSY7FL15eeVlRmSyrmQ5EFB0nHGacrbeamZ?=
 =?us-ascii?Q?aeQ+sl3c9faS88MKRh8hoaL/TAQ0JX6nSSD4jUpnbo2zIhJvEiR287Qi6mdD?=
 =?us-ascii?Q?uwYBAPCAB0NhKoZ3Dhl+0b25XXmj1u+aFJQY6znZoSzG5E7fGI97gk8nLy0H?=
 =?us-ascii?Q?JUGT+sgJEyI5mqOG0jgqegn89hmYw2zFBfgckjljAfb12TgmAQINW34iQjHy?=
 =?us-ascii?Q?iXD+k20JJBO9a6Z9hgru+uzOu569fAPCTZ/IIupmAy99PcEL9/BJL04Iy1hl?=
 =?us-ascii?Q?x6BvZiAUwQL9o0zbX4vWzug4GQU+r8u0vP2zRRQTANRlHdpYCcm0WlhFJlMv?=
 =?us-ascii?Q?XXeUQAZHi86VSewpOfoVtFcdQWArgO0Rvq9mcQr/mVcKzo0K8V1LfNfrMNmR?=
 =?us-ascii?Q?Zw9pniJBfBAB1/tGPdIuTwBvyoDAAU/tyvZsKdfyYk76rOCNQXGkUA8NR885?=
 =?us-ascii?Q?gvUyidiFb99++Lk2841v1GIAGWrzzp8uwojdtHIyWXrTLaZtOMOiZ3qoo2ji?=
 =?us-ascii?Q?eSMNzI3bJJyi0xoHBUXmaEj96ecYQyPqPNt+oydpXFfW3R/ODSdcGNqyDMro?=
 =?us-ascii?Q?XKmVKAbugzV/9X0S9hukKJR/tMlpX2Sqa6xveMKgiWXFqeSkMuQEFAu6/Ict?=
 =?us-ascii?Q?4ryV2fd+kawpfU3lElqpeV+xDGxvpm8qIiofaegc2umBoElL6vVRjL/GW3G7?=
 =?us-ascii?Q?dH8Tex5zSrcmvjeTLybpRAh3TN72kdvTY+aaZJyQsvwj0FtifRYr5MPMNlQB?=
 =?us-ascii?Q?VJudMMlt/hUgW7Fi+Aopx3txqVcUgGer0R48hKPaPN/U/PZRWU8uT1XdiKeD?=
 =?us-ascii?Q?5ORhpQbNq9oYR6wfl/kYY0B17eBd6zDlr5iwYRpEEyBlKWslwERheRPh4xS/?=
 =?us-ascii?Q?KkNVzhdf5Hvb1ka+VKXtAd5vd0WJMzhWCTcDhnsxSh4zFd5OYCgkOjbfsvGf?=
 =?us-ascii?Q?+e9NgZQdjh/TIqyhTB12/1DcvphdrSLcSq1OUJdWiJJNt9M+YKJrCDIDVcFM?=
 =?us-ascii?Q?SlssWZA9mvMLew7WqlMj+t1sR/npkxd/khr5ugmyK+YMgfE7Xj2RT6346h+D?=
 =?us-ascii?Q?8hK3wEy2sLKJCuXh9zX/cd8FWksQKYRmiIM0fvbX/Nsw+g19w5HLmjjI2knS?=
 =?us-ascii?Q?nH4//ZmnyC5jeOrfKFgZ9B/Ml+fLy2/i30JN2yFlwliXzD8ocXy2c1ptVGDP?=
 =?us-ascii?Q?SiedN479SUKw1r42tiHYvgIx0PYkNDu2TPpJTxKZDWgNhK8uc0sYkHrBJj8X?=
 =?us-ascii?Q?Wq5fMZeJjZFXJwd4IRAOm2ZT741PtQCtoEP40aLCOpi2i7+AxUYRjEcYJf/A?=
 =?us-ascii?Q?5eInG2yEwDxnQsFY+pdaM9o5C4J/2yrvxwu5buQhoNhmHwTTB9CTk50rmSzF?=
 =?us-ascii?Q?eI1rB9Z4NthYgma04OnQBVQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DA29756CD787A45A4EE6A9DE6F596DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tBJT9FzJmkrqpk4POmNxpSTHqjBNzPxprQTXeZ35eBkLBExCVsCty97cCCyj9RpPWwELwr+kkPeB31MzC1EXybU39snPnIfGAVAhWacztE1R8Ltm/d/ysG1w52ET12i0uypCCfdXWQytla8mDjJ+FVYsN0TGeKfrItAG0lCu3OVcX05Sz7apFhyJa7K2CI+sx2/yrxfdMMfpPc+9nrsxI30pzOQhK07iBTB4/d2bq2u8I6QMLEIbD73eZ5/QUtiWeqpTC62+0SCu3jdNNnv6xrFxz+WIB066bWj6vA+uoNCWW8yKcQqoUy542ENX0NtB2QadECFnYXw+zUmGMGwwyK60jCCf/9cIZiNnAcBeJwxvlvinTcEGm1gCfeX79FTrrqm+UuPFh7HPj8x54UTnA1A0qHeHQ374KTkeOrJ+mD09RpvJwXMhxcFabBQKpBqmUvCF8fbcYjMv+QaFGha+GZhvmD3imMZapWV+LAcQbDIcVxlljBmaBpYJOoVNVcKNpUfFuA1dA38f5qSkPaeSjLc9hZx+k/12BoVInV692O3QC/zMb3mA+ScmWq99sndkwaG9/wvRGPWT7Crzv4mIyDsrrEnoHmD8amu+XdSUgP1SizwDdeK0OutSOQMSJ9jx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8299222c-e627-4ba0-629a-08dc7e217d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:49:07.9466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWtwa2mYNc5riwuHebGihafhqpGzIB6J/GraJuNi8hYVHkIwE84HF0pCmGxr87EEk8FRRqdZ4DMQQ8g75W2MAjbXCQ6OrIvp+Xm7Fc9RC1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7799

On May 22, 2024 / 07:02, Shinichiro Kawasaki wrote:
> On May 21, 2024 / 13:24, Josef Bacik wrote:
> > Because NBD has the old style configure the device directly config we
> > sometimes have spurious failures where the device wasn't quite ready
> > before the rest of the test continued.
> >=20
> > nbd/002 had been using _wait_for_nbd_connect, however this helper waits
> > for the recv task to show up, which actually happens slightly before th=
e
> > size is set and we're actually ready to be read from.  This means we
> > would sometimes fail nbd/002 because the device wasn't quite right.
> >=20
> > Additionally nbd/001 has a similar issue where we weren't waiting for
> > the device to be ready before going ahead with the test, which would
> > cause spurious failures.
> >=20
> > Fix this by adjusting _wait_for_nbd_connect to only exit once the size
> > for the device is being reported properly, meaning that it's ready to b=
e
> > read from.
> >=20
> > Then add this call to nbd/001 to eliminate the random failures we would
> > see with this test.
> >=20
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>=20
> Josef, thank you very much. I've been seeing nbd/001 on my test system an=
d this
> patch avoids it :) The change looks good to me. I will leave it for sever=
al
> days before applying it, in case anyone has some more comments.

I've applied it. Thanks!=
