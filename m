Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7805695
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749619785; cv=fail; b=LDWXmg3VLu2gGxn66A5uvF8Jijp2LNnVkM9QC1W4IdbQWAbrIJ/ITQRhgXzRg8Ac1pjW2/LVfPJ67xUCh5vI7HRaaCjR3/7CgrE/L351bLcFoT3MJhOm9MMRfoMxdZvNEWO2CnokQzfudC7ZJLf9RvdoP/n5PnvWfINC1GApCOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749619785; c=relaxed/simple;
	bh=7I5JwDkhjAzkGs6TGpCXX49GTCLx8J0b7UgCHEQKLLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=skm5TDTYoCPomEs+ECOZft1hjaRGyzLxQpzYOg+wkcDZJCF79iGwOmZQQVUmgwIt34LT2DfmZLI03w7Xuwm+V0bhm2uAYYzQiYL+x8sXBe+cRyymzIubI7fcD5Rgc92crQF7c3c0RuoekxFehfCezyq4sjSLPaGUxJWf7Rm1M8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oiiK1f5i; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uPaEwNEA; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oiiK1f5i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uPaEwNEA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749619784; x=1781155784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7I5JwDkhjAzkGs6TGpCXX49GTCLx8J0b7UgCHEQKLLo=;
  b=oiiK1f5iy6Vmuc6WY/mR/rmO9og6h54LuXXSgvKyvbDrHUCFCI7Rk9Ah
   1vHwd2UWOf+NQku2VZr3jRA3GJ1z4IwEDreRNGcBgFq5nXo/iEt48VOyO
   19ne12VpTzBwHvPr7hOg3F6ChsiO/eoYLkGzktz0rxjRuwDLMOeO6xwnJ
   F7Sx9rQaYE2pOUdBNhr0Q84lSPcOsO5mxKwjvLkx/Stl44APTO63/oW83
   eC3OPSAS1QZDQWsht0LoHG/ame8RISyawdycNJRHYMqgcwIu8pqZZS6Tt
   iwUtyNCG8du0DRXsMtCjGHF838CxDwuTyMJm1HKb0gsC2B3JB/af9a7iB
   A==;
X-CSE-ConnectionGUID: TYH5Sy7jQz6r+7tV6Y3dDg==
X-CSE-MsgGUID: 8/tRALU6QfSKrb/S0FIwRA==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="85105291"
Received: from mail-bn1nam02on2059.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.59])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 13:29:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpC9+ws3CuHxESNdu76EZBAllVLp4iN7HH6aHyWLhcrKzZGMcNSeKfAUXMWH5B1uBb+0dYrFadDkRQMnrXXerdgajn0+fUU6GndlKHea+MF19um4f8LKRT0E3vLpPWcfFODwWLkLprisOQj6kgITB1PB7YvoWAzXWMslgmqZWonaiBfhevdnk157SNEfOR/aVOr9a3iYa2koQZAkC0SFJD8cLG575ESpPLAaaYaBdEOyyxC3i2lp7Hbg7Nyb4+QRb+rRKyyKsxlD9/RoYzz7rIdSgFF2X5v+VqatAiArd5F2h++qhkaC3+UsCInaxnZMh5jnfKLyMwgLNJEyH1RYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mgo/eygM2k5GYCDd8tkjDLYB8CdXbPlQArFRcMdf7zk=;
 b=or8bniOT4pGjP/kSjjoN0E16J9u7q2K5s2ztyhrDGUJbP9r2dfLb+ze31XDaTiDniuQPhprSJE8PG8MXkHBtSBtj7XFp5WOrbL9RuauCChBMd8byTjI9qIlcsQ868EBrjrup8MrocUTIQihcc4p3fTkdCkJ8KA7P4il1rN08mcwv2iLEGnKYKMCuyaigAzBx19omh4ljLQ8C6VK8siOEHHWhOjR34pu6jiAjQlXZVAMLM7s8GZ3kAMCPJWT8D/P5r1TFgkZ1R1lRvevwP1aW8WSD6chVn6ERWXYMKJZIwl4wao6/ndNTyd0hpoP7WbCz34+jeSAV9ONQNhdcSZH2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgo/eygM2k5GYCDd8tkjDLYB8CdXbPlQArFRcMdf7zk=;
 b=uPaEwNEAN/29PdglC3CJYAIJ8MnYWCRtNIfj7D1WtTBGEonyXhcVyrgnIwoDRDlBNRTaOxW1f/a5+TWK2kgG2rBNnWWArEtA6PwVu/63MG9mhUONwoprmRnRghlCdno7lnihw0b/rhioANZ3wSSQ1Y9HtTYtmN+65YWgPXQ0Pe0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by IA3PR04MB9306.namprd04.prod.outlook.com (2603:10b6:208:506::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 05:29:35 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 05:29:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Topic: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Index: AQHb1pcB8XrHg5kcCUm1uP/dxccmtLP7HeuAgACNQ4CAAOYKAIAA5TmA
Date: Wed, 11 Jun 2025 05:29:34 +0000
Message-ID: <3et7jqzna2n2e7henrbr2foiopjqxl64pqxaadszrbmmuqorei@xinbpunqb2ye>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
 <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
 <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
 <e9c4235a-1c60-4a61-a152-f65ae973992a@acm.org>
In-Reply-To: <e9c4235a-1c60-4a61-a152-f65ae973992a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|IA3PR04MB9306:EE_
x-ms-office365-filtering-correlation-id: 532e9edf-f9ee-4b4d-81d3-08dda8a8f367
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TaDhqRy0mGMdN9Vbkjdt7UmYhttlk2hPd6QRZz3je1d0Moms9OlMUi93Z3G7?=
 =?us-ascii?Q?aRIKzxKIJmQv2QmcahTieHTlkgNHbjNYXVD//rThDASzMr/Xk7Za4pDZgZmK?=
 =?us-ascii?Q?M4lZnS3vrb0FTRA/FeKTDfUbbyCO2GxqxXOJ2nxyV6t3Ov5z3ZE5Bj89y6Hc?=
 =?us-ascii?Q?/HKEpF+YoGy2EiEqspEGD0NnCI9BDy+qO4eaR/nJw0W2pJ3JNXPtebEXLjrh?=
 =?us-ascii?Q?ze4a9+5cbGPLL/AWAuI/tTBiR/0pLOOMMjmS4ev/rM/i99eVcea0ig1B7IEi?=
 =?us-ascii?Q?7qTPnqut3MXiqBkyuam7EFYoJolRxujL+qBv6UPoWkUpH8OvptfYWDBm7UTb?=
 =?us-ascii?Q?x/oAw3Xw+RWvEoXieY9LnLHL8kBwv29ucnbeumpZW/ppAU02V3k37JtxuR1Q?=
 =?us-ascii?Q?zdEMilvGGw0Yeugju0UUb6rp7q1QXswtyKwEY1ghqJ5CnlIhZKN2jGdAqEje?=
 =?us-ascii?Q?R1LN01tX8+ItSbL9uKaVxUD+MixE27ORc7KTBq6oYcpdgrYprFtSbipOuwBn?=
 =?us-ascii?Q?QpJup1HuQ2ENEibeM7ExdksCk1RzOM9jqyl7u7GCP44g9UGYs4MksLK92N6A?=
 =?us-ascii?Q?ajeXW4uOYqudOobR4sZDmSfh/Jaa3IXKeqShh4tM2jg+Ol1bGSPau7MkpVrB?=
 =?us-ascii?Q?czCyvDgdgpjL2vLrmeGLuz4KcLYLCYIXwVUsXmPDkhXBzST9wWxNTYXnY/vD?=
 =?us-ascii?Q?WjVOIgtajxx7KX/kYb3EtjZylAbmmebmlvjgs1d0jkoZa0nUJPwlk9V4zFHT?=
 =?us-ascii?Q?hk1ayudib1ZizdvyFwTWG6qI0t6uaNF99pDoAhsLab9yfe3HtchIT/91NRmS?=
 =?us-ascii?Q?gMlfLc1NH8NWj65SBULrdpsFZgqZ0YgTSu28Ij4v2dENvR/120eeEIlvoeLD?=
 =?us-ascii?Q?hhPgzfERzy63XEA/bxJas1rkB9Lx/+RKr9+OhdDtt8Kg6hbq5Oe4SCPiQPVf?=
 =?us-ascii?Q?Sr18rjq/qjboO/mYBxV3/5lDuO8hG9y0BESeh6rvlx47Yyf8E0LkuYkxGDrr?=
 =?us-ascii?Q?wPMqLn82It04oCnKSFy8Go0Bc4vfIypt/9aGr2jYD0Nv5+viNlQG2E3ZX3+M?=
 =?us-ascii?Q?TYiNN8dFkCR1NMXakSdfAn7fN0Bnzju+KjAGuL75wZV3dGND7+/OkLRtcLIw?=
 =?us-ascii?Q?NPjk35PoD8hWn3aIjPvX96xnj90Y98DnrF4KjC8jXX4TTnbk9Jg5+RZ+civ9?=
 =?us-ascii?Q?ZYYoZeTNWEqrs9ynlPV4PGRni5GlI37nRmVmkd4v3A02pBfcFMdQdygLJ5xN?=
 =?us-ascii?Q?TXoDsGYmgMAcNiKapk75Z8hvKgyCll5p6SMNwWnKCMkwzWco9zmFQw706rZh?=
 =?us-ascii?Q?qWkufmj8sFPV0XF4nkKOoJz0Oe1MehZQHKw9NzI8ADuoiUH55trB2nev45XN?=
 =?us-ascii?Q?8wv8hF+Ia0M5QxKOYONM5AsqqzTiriINpGNDishTQiRncY6N1uD5FUdeilyt?=
 =?us-ascii?Q?g5GCwgzvv3y3wr5NqsW7QgQPr61bufjf1qDLPECVb7vFrD8P1Pi4aMJUaszM?=
 =?us-ascii?Q?ZsRpVvPfRB3/084=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MxWbh59oiqhVyAfDnuoElKRduZKvsO4Kb8E8WxeyZqqkb1saRqmBs5x9iIy3?=
 =?us-ascii?Q?APSHKrwpoHFxr7HxaG3PMe/xx4JPwHQXqbTvugkf1jsjq7Ltklv9ba2hlI01?=
 =?us-ascii?Q?d2gvtRbIWvwszviTvGnYIn8cwK9rQd/iXXNirniJDK7nv32rM18Oiy7TDi1d?=
 =?us-ascii?Q?uE7YvpCAmk8KpnY4Z5VvOAtQEUAPjh6yH0JR8uJef+mM/kt9vTK7OmCvfBM5?=
 =?us-ascii?Q?CF38IqGCE1ot0ipLaGsQAyga5sk9XUvJb49NXBQyRabN2gHV6g6qqsEtQuK9?=
 =?us-ascii?Q?ldCW6sqsYKEpi1Eet9pV7bEOWGhU78Yv0epzcZABHiYwbvQgQjGhqQ8+Hw2v?=
 =?us-ascii?Q?33zwvZizXCUv09vWYoI48qoyvT23LL8jbO+nWtuK3qSFQnmfv6Qr9oBtSazz?=
 =?us-ascii?Q?Foa8D+zkFIqGY4qAsWtl3IkY4C+WZz5GOHBa1pZMGfi6LgBnno+W7bkvHIw7?=
 =?us-ascii?Q?P14cria8ugY3x3rlBp5Yb4Zrph1Db/f0H3RQ2bmfUIzRfvPH+/4B+y90gAgP?=
 =?us-ascii?Q?xdf9pyDULNo6f1ONQ2ph8VJ/bBwubT8PH48hqktgEEFYlBDXmS8hCHMN5Os4?=
 =?us-ascii?Q?RAKhIc1eJxFV88s/Rs1yD2Hx+KZn+5FGwB5zIy3ylxUI1mh5zUTyASdkusKi?=
 =?us-ascii?Q?QAlnRrSbU29vO8CTlndv+AS5PsuAlshxjqGODKb8VszAAumbBavU3c8vKDR9?=
 =?us-ascii?Q?2X+dH/1RZoRAD2oqam43Tkhpu66t/k9BVDS22Lsa9tck5Xw3uLJnAFv/qlOq?=
 =?us-ascii?Q?hoWLj3z9/X7TPJ3YbT4P369iCFFKM/ugZOhxPZ5To8Gd59tfpqPdVNVOOHZz?=
 =?us-ascii?Q?luxa7bI69YYCFPwHAWD0n5W0eRCTbH7nOwg0BUe734XqirQjNBibslb+27ck?=
 =?us-ascii?Q?goszPYTE9EE2YRfRDIQFfF08YhLMvuyZ7nFw6yia6829SM8k+01T+qKjmmjF?=
 =?us-ascii?Q?HGMp2pwfvtwfVDm/8ttfIG3iOn4MNvtRHDu92+CZXEHbjUMr4uX/YFkn/FIp?=
 =?us-ascii?Q?LWAb1hVMlOO1a0Bu0aA9zRRlnh2hR5AsRX7/WP2ihp/GPNuFvVcoQwPRId9S?=
 =?us-ascii?Q?Icm9gldzDVSJMXGlXmn/wVTbeu+m4gQaj8rQtEMo2MM1TL7k+ytiiUqpNYEk?=
 =?us-ascii?Q?fCEGSA51biLaE/sfM77w+QzbPFzNVU0Z9Sb/NAONpAuGaGzOzEHi017wxhcH?=
 =?us-ascii?Q?WtQHdyEtMbMC+oc4+W6F67bkcDNU7eJyCT+pRSXk+6NK8gG9SUtSuiqFJI46?=
 =?us-ascii?Q?eDO89t1EKWH1z6KX/8V1MIhSCOQG/Dh7VY6ig8Ro5d7GWNvttoHqhW5haYZd?=
 =?us-ascii?Q?SZ/7OodsB1TKYagrJiSZoK7ymPj7zx4awEtje/ARe+mJ9tpHwEfC3jM4G5Ws?=
 =?us-ascii?Q?iFX7/8oQfxCRBmqmNny7cJEW9MQQR3zFP/RpZ0jrZDl3NDegAA+LjNUunKnP?=
 =?us-ascii?Q?UfM8m1wPWfJxVJaaGvr525oRNxasrqhbMlFiukCwW16HQT/bdsOhvlIeF8lu?=
 =?us-ascii?Q?HECkWR2hvmBHRQ94BW6I3K/hrY/w07kd6i5J/wAp+rgbiSQJw5gcNK1vqGNp?=
 =?us-ascii?Q?Ys8WciOD1njPd7KgJ06PezB5ZxsdV2JnjWLx4/FXJXhCAACToncO4tYpc5xf?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4207D558C599DF4E81A8CE5BD8C6EF71@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5WwYpEe0FeJrwT7VNWiR2hzJpax6b/1+GkSenP4dpL80d33v860JutBGY5ZNQt2fJl6CwWrmF8YyPcMUg4rJXZ0CrmnDaL8O9BOzJVcLAzk/DSVXhlsSN040Uiu0jNkw/gVOyCFc35s9CEdtSVbACZB4qW84QpbQe0dzIqAgXlIPN4gNdnDE9qzNdrEjP1bcWNBI7GLj5HvOxXoCvZNltxUS8qh6LNXF6rorCKBARbXY+puh5EPnEJBKFrHBvuDAbdX7NziMOZO4sY6If+ouCxA6JHBzyRM5kGTe936Bdarpvz0ONlx9LUFVDGree9Jr/4jpG1I2alHkU6WNqgSjEhX/CYbg8Ir6c25seh03GfzhR2tXSkC6teDaEfWfWxYrVJbPO98aKd6Txse95dq8KIkxiZzEhBNFyfW4P1SYnU/ju0iUeLsaE/vJNfFzWQBcdY+oIPXKYZfswGHrAOU/FopnIesINgGIH4442a4L8q6dty6xSRPNG+Bb1jD99LA7mn4g9vp0vqSBaQaA5AaUd6u7k6H2aAle1GdTZDnEFnKZE1Q3HP/RW1BP58HDIPN/lnNtLVittMkkBJchvFS2hlyiHRwVnnnzKkjBy+nueRXCwWs0E3eOeTlkXq5bMiQr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532e9edf-f9ee-4b4d-81d3-08dda8a8f367
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 05:29:34.7681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIXi5gHkt+1d8NSE/d8N7+jix7ZZAJq6CPemLWWV4v2SNzUwf0bjekLkgqo1MjvkhyB0GXhPwaxXm5XYzmhRfvuqsAurmDIGfW1BUKsn//Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9306

On Jun 10, 2025 / 08:49, Bart Van Assche wrote:
> On 6/9/25 7:05 PM, Shinichiro Kawasaki wrote:
> > On Jun 09, 2025 / 10:40, Bart Van Assche wrote:
> > > Has the following alternative been considered? Let test script author=
s add
> > > "set -e" and "set +e" where appropriate but only in a subshell. If a =
failure
> > > occurs, only the subshell will be exited and cleanup code will still =
be
> > > executed if it occurs past the subshell. A disadvantage of this
> > > approach is that global variables can't be set from inside the subshe=
ll
> > > and that another mechanism is needed than local variables to pass out=
put
> > > from the subshell to the context outside it, e.g. a pipe.
> >=20
> > This idea sounds something to consider, but I'm not sure if I fully und=
erstand
> > it. The word "subshell" is not clear for me. Do you mean subshells thos=
e test
> > case authors create in each test script? If so I'm not sure how to ensu=
re that
> > "set -e" and "set +e" only happen in the subshells. Or do you mean to m=
odify the
> > check script to create subshells dedicated for each test case run? If s=
o, I will
> > need some work to understand its impact.
>=20
> From https://www.gnu.org/software/bash/manual/bash.html:
> <quote>
> ( list )
>=20
> Placing a list of commands between parentheses forces the shell to create=
 a
> subshell (see Command Execution Environment), and each of the commands in
> list is executed in that subshell environment. Since the list is executed=
 in
> a subshell, variable assignments do not remain in effect after the subshe=
ll
> completes.
> </quote>
>=20
> Here is an example that shows how a subshell can be used to halt a test
> with "set -e" if a failure occurs in such a way that error handling is
> still executed:
>=20
> $ bash -c '(set -e; false; echo "Skipped because the previous command
> failed"); echo "Error handling commands outside the subshell are still
> executed"'
>=20
> Error handling commands outside the subshell are still executed

Yes, I understand it. I assume that your idea is to ask test case authors t=
o add
the subshells in test cases when they want to do "set -e", right? My questi=
on is
how to ensure that the "set -e" is done only in the subshells. I think we n=
eed
to rely one code reviews. If "set -e" out of subshells are overlooked in th=
e
reviews, the impact for the following test cases are left. Maybe this is no=
t a
big risk and we can take it, but I wanted to know what you think about it.

>=20
> > > > @@ -372,6 +380,7 @@ _call_test() {
> > > >    		fi
> > > >    		TIMEFORMAT=3D"%Rs"
> > > > +		((ERR_EXIT)) && set -e
> > > >    		pushd . >/dev/null || return
> > > >    		{ time "$test_func" >"${seqres}.out" 2>&1; } 2>"${seqres}.runt=
ime"
> > > >    		TEST_RUN["exit_status"]=3D$?
> > >=20
> > > This change makes it harder to write test code because it forces auth=
ors
> > > to surround cleanup code with something like if cleanup_code; then :;=
 fi.
> >=20
> > I see, this point makes sense. I'm okay to not call "set -e" in the
> > _call_test(). If we take this approach, test cases can do "set -e" and =
"set +e"
> > wherever in the test scripts, but they must declare ERR_EXIT=3D1.
>=20
> Do you agree that with the style of the above example ERR_EXIT is not
> needed at all?

Generally, yes. I have the one question left as I noted above.=
