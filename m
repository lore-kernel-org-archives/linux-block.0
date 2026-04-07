Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8F2236F7
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533056; cv=fail; b=ZoPvo42RZZEceKeCnf4/6nRuK4GiL2q63sx5+Vi0JwDyXIiAFCpHg7fP7NEGse+MrLMvggT+eI/moQxqoUMeAsULGv8YY00t7+laqRAmF+dY+gXMm+Bi23p8+5W3ojpMk2dBNv2GcgYbYayFCCFTFF1Jjuyv8dD1YkIHKXLILSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533056; c=relaxed/simple;
	bh=x3aRJD2D9mWgcINp5VMk8JLRCMJF2UzKpuQsxoRlVO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TpGxbuoBnPhPrOh9vfkxoYgwiQJRhPuwDlarrKvm/86Nt+xIY8yxiM14APvXfqAke8gixwXzYe868EZ4cEE1jg0/+8hxb3drjDNAEgsdItGN5k6ajr6iC7dQy75wEnd1GGVGxkAVeZkHzrHLpGxZXA6pY0gdHhwbEpbGp2yEUnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LVMea5FX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Pli4U2cx; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LVMea5FX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pli4U2cx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1775533054; x=1807069054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x3aRJD2D9mWgcINp5VMk8JLRCMJF2UzKpuQsxoRlVO4=;
  b=LVMea5FXB31o1UYtxIqDj10ctxEeCGNimngg9TrT9lKWsyIKiK7noLKZ
   B3LlusNowzZ26khvbe+OLyxMWOjuKVGoMhA19DghmlT/JZLqwJgsX0QZq
   oSmW8G1jOFPVU+3t4yVouxQbLJzbiS335rYs8MiGF9rir7hRD0oKzBquF
   5r6eP5kLH7YymL244Rg+zAEZCKmIH919cgez8lWBdGyIUiECkO+gqJ4p2
   uh3P4yell64/xnRXiJIMOMjqvPRkdZ3zuGlfPtYRV7l9wmcnPm2fnuoSO
   bXh0nq9faH842J2JaLXRACwHukGBwx8Q4tzlw9JjCxX9uY1/O2DwZhIdp
   g==;
X-CSE-ConnectionGUID: bofrRrlGQjyfHjob8IVXyA==
X-CSE-MsgGUID: wF16hYArQmaA7UJ42RIBDg==
X-IronPort-AV: E=Sophos;i="6.23,164,1770566400"; 
   d="scan'208";a="142939787"
Received: from mail-westus3azon11012045.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2026 11:37:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPxCK1dQG/zhXR943rOKOTd71HUsL0VKOc7WzATrV8cPa2x36mybeDTbm4Omzt/ytGuhzzRA4yLB0ot4+OUO84KWWIH5esRJzSjf32ArL0JeX5JYppEfCTjcaNg7U/j+hnscXbibBU9fo2uLCpGC0/3YS2WUdDMgI6B7g/nv0q1ukETCe/J3UHDU+p+EIudxe72VaQkOzfOXSCl+9DfDvMsr7zxBbLYyLVndC3/F5jSTG255I+CYPkbw7H58cuXJs9nk3YSZtAiQdHUkND09+QpFxZyaq1ri4IXT2x9DRDwuKe0L0+O17mko0TrmYVVz7IkvDyLMWlUFE6S5g77aAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJLs2AhxyHPkb3o9Fmn3og8Enh2e9MWmUMow2GpGIb0=;
 b=vGhJ6Ne9Ex9TZDM2S0vuQYPc548F5wqz7BVHQOWavgI7oOHQX4qvPVo3GDXQHxR4ap+az/35XXqs8ij+lHgVP9bykTn0xELiPJIBOAlweEBhkkXacjraSNNvSrDPS80Bj5H94PvXoNp+zst14cqYgXF6dM6BUk6EK9e8Kc8TR6EKSZ01v+GSSMO5Xur7aVmuf0mN3Y0ed3RLigZA36RLOs01r3ooLJBgjZ0TA2YOF3j3S4tnvX3GjBkddhkXmFlrO85GlQPYrMQWQo0/9DleZ2KWjNkjhue3/QhX6vZgHq5d3pi6cZTfuIYmTxa7vM3z1cc2QIHmComMd9NkELOSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJLs2AhxyHPkb3o9Fmn3og8Enh2e9MWmUMow2GpGIb0=;
 b=Pli4U2cxDJ5712jw8ulp65pJ0kvbDcenLCG9yuJc+IJpeTz0NBcr/WUB9aCqSRgcMr6gwboZXMMhT3Cx26j6Ms3+OqNOBx0sb1I0Ww9HDtCDhcyGyY+bsisBtrwhRndBA0VwefqkuyuhmWcq4fgvAgf9f0ROoVnXr3br80GKd0g=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DS3PR04MB10030.namprd04.prod.outlook.com (2603:10b6:8:38c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 03:37:26 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 03:37:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests] src/dio-offsets.c: Fix err() usage
Thread-Topic: [PATCH blktests] src/dio-offsets.c: Fix err() usage
Thread-Index: AQHcvUcnhqOcQO/6mEuwrCVIigyhr7XOoYiAgAN8zgCAAObOgA==
Date: Tue, 7 Apr 2026 03:37:25 +0000
Message-ID: <adR70_hLiVavpvK1@shinmob>
References: <20260326173632.3259254-1-bvanassche@acm.org>
 <adDM7QhRRlnntRB5@shinmob> <020e64e2-8a2c-4e91-ac4e-21801fe5216f@acm.org>
In-Reply-To: <020e64e2-8a2c-4e91-ac4e-21801fe5216f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DS3PR04MB10030:EE_
x-ms-office365-filtering-correlation-id: b02adf30-ecb1-4d82-ae02-08de9456fcb6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 R3VWRfobSzn+P6FX+1j2asbl536CVVRIh84+nwmfxvODE7Las+zRea2NjzNvX7oeheCJcDEOyGsXrAi7slsgTiy2TozEWxtueNpDXDWdQ7MNb8jkHm0uxBBmWIkUk//n9Nt09XqNiZncHsQRcBAZuF9YJw0fJDs9s2/6hngigygpB1rmJo1/CFFPKaP8VxDmxNtYnMrnmwiNu4Dl7HaFWGeED8nzmK5OGcNE9ZewZESZvprxH4V22ycs4zm3jIkzPO80LJS/HTOPqRhkm8E1WSzDz5QF0vaGsxcvRc5PN7k5L1XwT0/Rez2nnmPPgXVWp8jmUP2o+oLPBeOKAc9uRIP/Rtl0Bu4JHsHUzqpr9U5/YZn3Xnj74z4Z7oFdGhV2HpvncChafPryL/1X0muj5Z21jVbaEa6EpuTWqoD0rqfxlN664M3NqGMC7EKQ0PLPGal54yJG33TTt71QvafRQRGVmXtNKj1bsOurkyKP1Sssa7CKzY67SJPrBdkHrBKfXQjGteuTBSGCsyBaAGgycbSN8FBFXE2jgPeQSqDTCzF//DjYny48RFoEKCECGtx4GOey6vJ//ty/FGvQBrQ5b/9ucHFS/xR1Pu/jUuHgkXte8VrcjyUpmatbhn0IKcygvSoMdccMvbXYDz0zrzc4BScNi87Rbd3T1mEM0n9zHljG1by9HnVuIcyPiA1S0hfHrVrJ8ixuD0bDIMw8xctPg1k3U3yIJeTczlFY9/xFf2tHwFzyfFQ4XjLQGSaqWpp/PgE+jV8F4BJlmvPI9Q9kYEMLZVlKpDz3ghdZg6wRHps=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bxZYXM6VxHOPMfP4srvNsXy/N4xrfYb4A6RP00I56TYjRu8c1SWG+2nqFdk3?=
 =?us-ascii?Q?K6VZgB53cDasuFVGzfOr+ytUR5i30gNR8/ejwni829YWd4NvqYA0eLFa8qys?=
 =?us-ascii?Q?DtbOBoqxgwhrBG+Kof986D8NGC3Y/N4mi6CtNJhN/E/IEXfDihnNHQ0WChRc?=
 =?us-ascii?Q?iBTZ80wv50Wn4qX9Q9KLF8SoOuq5zCY+5uUXZ17ERM5c4qRd67Qc2/nUhj/N?=
 =?us-ascii?Q?VPdOj414qPbqZedN+XNRv5RAF69sqx/tBtPtW4ArgekZpbAUHwcQVWBGVoIR?=
 =?us-ascii?Q?+yqIlTjP8Kg+b9e3vP9Wk8Ajod0OvRDCJRKdy9GOfd8gesfbSlllxeAPJxuH?=
 =?us-ascii?Q?CME3KJtjBIGdqHbUw4LH7A/jqltXIYemLpCzwxUIFXqinEVEojEluD8saSDl?=
 =?us-ascii?Q?yFIInFHauTa0fxfzZU+6DXpcj4COKz7F2nwQ1wMvWoF4Y5LnjeHEWyCrXFc9?=
 =?us-ascii?Q?QiG5fzosMMKG61AEK+e4TyfAjOr+U6s0d+x9/NrGGpEDRZuSIpxQUQB4Iliv?=
 =?us-ascii?Q?G/GEv+KWTCGMAcbW771TOr3Kz2fkAA4LPgt3d+zF0UMMcV/d8VlCT2wpLSq0?=
 =?us-ascii?Q?DX6rgI/yC0kHIWVjnpIl2nZZ1eCH6GUXa/6oEYxB9neyAfAlgpmedgNgmcrV?=
 =?us-ascii?Q?B5iulxYcx14a8pndKatxTLV7sogON8TYL5WnxqXKO+pmIey41M6l53fIqpOV?=
 =?us-ascii?Q?qBYEccRdmaPGwPxeAGvVUrjMAXkACLv7shkrvEBP0mO1cZGueYo7QdbxC1lH?=
 =?us-ascii?Q?cJzFBikAhSKqAQ0Mm8Qaf+fmhydF66EjzI+eDlGGRSd1Oc3PbRJP1sJT5zSq?=
 =?us-ascii?Q?dl5DhQv1xn77kVMVmoSyMOtEpUDBSH/Gcy1UPr8d+6qNCIXDE2rv5x8OhdQj?=
 =?us-ascii?Q?roDn4IQNJLK3wchj8pIRYfwYBK1n/sj1XT8+XgVWUE2nbN6rn3+s09skAHN0?=
 =?us-ascii?Q?x5vgquU1eJ9/b4wrPEtT23iSfqqV/po5jL+H0/GUpURbW5tkig5eBzA/l2NN?=
 =?us-ascii?Q?Dfb7At54aLhnoXW3RGnkUCBJi3cFVZQJ6u5EY8D1ZV1tRnOHkihElhvwCKJI?=
 =?us-ascii?Q?MCm+xYMHxFZmMOvz/jTFQrJmWeZJkem9vDVmbZS/qJCr+MawSDXhBnisFjcy?=
 =?us-ascii?Q?AzGnjkp04FNXEFLUTERO4/oySShgWUXQ/6ZV7MwH6HHi9YmTZ79avvk2z1/T?=
 =?us-ascii?Q?EMep+e2Z3NKliwD2C/SbFsne4xqlFw9otWzAWyToQPkyGaz0GdhE3uc6VbZ9?=
 =?us-ascii?Q?dySmNiBMjAdZj3Tjj5RZs1X8+ICUVawAtMnxPNXQranmf3A9Au7tDvtQCBkY?=
 =?us-ascii?Q?xd0YVp5z3MaghZLG2qYXHPgGSqce3c05jzD28J45oa5ZWWABTVFy+VqfbEUV?=
 =?us-ascii?Q?c+7ZaS2WRhKpW2bIuwL9OnaqnhBq901aUYQcewzhc7gCDP/9KRSm/+n4ocy6?=
 =?us-ascii?Q?0hhAg5d37nBg2Rjz2tmL1maVqSSRMckuiv7e2FxlOHgmCdSRnb/UmUyqgnJl?=
 =?us-ascii?Q?ZajOIrniIr61XAX4jWY8XjCbQ7bc00O53M/J9QMngVmnrUgjwK/fxpSoLYWS?=
 =?us-ascii?Q?4a5ltVQyC1QZGd+TAHvlLVIQYNzuBE69wLGgLXvk8Qjrdf/a3uGJ8EcckER9?=
 =?us-ascii?Q?XC5RKR3fPSiKQfk+22o3DDAwCNLGDOvnumbaG1YkOXkmo+czB+LPScoHLyUP?=
 =?us-ascii?Q?V/n1WMBQp0od4rfOWzN1y6Ntqdwc+tOjlNBnhOMQYnaoPVX1Iammz7dUX8ys?=
 =?us-ascii?Q?c8mPeWRxOk7mN6Gxm/rUYyOAvQiOKW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94C1699A6BC67C418581BADB80FE2D08@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Ty9nLetyIGS/wZGZNLZ1Xiw87rqSIR9i7BAG5YLdqPki46wZM2UNpp54Jl+vrokxxHtU9QPs8qj848mkakYC1l1gV78VKmAlHfHn6kiH7LeP/Ihna4WADZymvj2mUbpm0nnb0YY/LyrU5LbsYt6Y3D7NEkK8mtLELOZkm9SuQG3qh0iWxiMM3dCeaamZw8Cmt7Vz3QpjH1QQaX3uoA2y6WrmSHUwvmVwolDpwydSKOjZmoqpCGHIjyBA1IoqN6gkWflvCgsH6cnEtOXpLwXjft86ujQrAMmXvxnqxPWQhAa1p3t5BWVY1IoPYUSD0esqH6SOrQf7AQIZAxdbW0VJfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	El4PA0WqBlhkxz3ZLgjgWv4gYNBg5nFXE2sejUYov4cXiVUk4eoWN4Iiem59Tcf+HpCDPRVEWAPH2r/PpybFpdc0DmGyW4uG2Mf9Cn8Bbmcfkg6zr4qh4KsYz+INhH3sqaL7WKkE3uOXzP+7IPr46ZEG0re7+Nj2a5AKp0U4K6pdFnk6X1TvA+6TBzDCXblbYJX80LsmxOYW/6NgcG+xddEk0ekav7FeoBzbfbZ6N53J58IqONDRuagzPEOXmzoYqGLsOZKv3htP+qGWMfMK4AN3u5ZLOyvz/wSxOXnDZqMuZRAvT2XFpiGALbDThLrY1eF1Wg5npisE6X3ShgQN2QYNfP27mplqkswz1/j3Cu5c6VOIbrgxQNg3XRd6pCWu13KuSH7lNjkyn8shfTg02yhRDduDbUacaEc27x/LYjF/i7XMFC1LEf1t0M24P3H2qe4BYHjsGNhfVmMQ3UYR2fABpjRTueP5YPvndnEAv5Q1ge9oOqsJDc5SFrd8mA/A/wRNuzbr3NsIYOG3lli+NG2H1VDY/ZIgcKHBEBnWrlD9jJ99+K5MdexerlLIOg+PAhDArhsUVkZLejktaEdeBEtNyISFUw857M55BzNYUyLuq6Aov2WXI7lT8RF+ukZZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02adf30-ecb1-4d82-ae02-08de9456fcb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 03:37:26.0923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxAKdjAwFDiUv5kqu7mJO8iDUDf1tGVPIsF3Od+AQYYuxKMZIxJHR5VYkk1MkfB0pAuXTBaYD4fA7Oo+/l+vqYkn41bRkLmyfqkLL8vFdj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR04MB10030

On Apr 06, 2026 / 06:51, Bart Van Assche wrote:
> On 4/4/26 1:35 AM, Shinichiro Kawasaki wrote:
> > One thing I found is that one more err(EIO,...) is left in __compare() =
after
> > applying the patch. Should we convert it also into err_errno()? If so, =
I will
> > fold-in the hunk below.
> >=20
> > diff --git a/src/dio-offsets.c b/src/dio-offsets.c
> > index 9fc7b92..c40ce68 100644
> > --- a/src/dio-offsets.c
> > +++ b/src/dio-offsets.c
> > @@ -131,7 +131,7 @@ static void __compare(void *a, void *b, size_t size=
, const char *test)
> >   {
> >   	if (!memcmp(a, b, size))
> >   		return;
> > -	err(EIO, "%s: data corruption", test);
> > +	err_errno(EIO, "%s: data corruption", test);
> >   }
> >   #define compare(a, b, size) __compare(a, b, size, __func__)
>=20
> Folding in this change sounds good to me.

Thanks for the response. I applied the patch folding in the change.=
