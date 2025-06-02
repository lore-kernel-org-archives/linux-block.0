Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA22C3266
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748830466; cv=fail; b=uge/fNDI5LNWQzbcLVuog81edijay408lqKhXGsZGEyo6OuW/h3JehnMXU1AwOPjkefZisRA6qzOEoA0YpdxeUCF2s8s/I18/5tKzbGgir36UDvYkgMGUz52UVyzT0Xc0q+YSyk6msvvxzhhS1tUqG/t34MvN8eNI+fpnU32Pw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748830466; c=relaxed/simple;
	bh=w1EzeKZIsnJymM0lS8bN3IYR9VB37msbK1/pbcaq+MI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pXSCyLd76MQHzu4PJhbB/TkmxaJiunRvDEb7WEPM7Wf1ePLkZEH693KelMG2Tym+wFsm5l0d3so2WNw9e7SVx4vvx7vYMN8AkWDjSNnNbnQQ1wWdL5gaP5znTILHoniucxJhz/87md9opKa79ceaQHfhrqTF1+vPpUeyiZifbFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p0PHnBNb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=neViOQ0z; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p0PHnBNb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="neViOQ0z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748830465; x=1780366465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w1EzeKZIsnJymM0lS8bN3IYR9VB37msbK1/pbcaq+MI=;
  b=p0PHnBNbOCT7vOMRzpyTsJbiNp2Rk5h766A3oSOyfLqoOGJZ2zGjzwTP
   WpqkFpIx9H7PGjsNWQLS/TVP5M4g1TWtpJN3zZ4Hp53v4f/GS2Q7YEqo7
   iyfihpJzMi3kzqK0OQybKJTb6QfG2HS318ayNlmdYCCBeRyt18vzbWqim
   75CsqRYDicTBDHHxyx8DOIG5mt9bHiE0MxHiv+Fre3429NLdcfQXCLOWH
   FlZnbWwq46C1az9unsHlFtMdWEQlcFT31ffzQv85t5B+AfbAXDV1QmVj4
   g/AOY6A6mAP/9Oz+O367XfDZAgVNFRdqn5HNr21LmlwFyGaQS/EOEJjEs
   g==;
X-CSE-ConnectionGUID: 9c8W6UHfSiSHZU6x5dsr2g==
X-CSE-MsgGUID: 2D29xYkVRXWRs2LrdMWAPQ==
X-IronPort-AV: E=Sophos;i="6.16,202,1744041600"; 
   d="scan'208";a="84552820"
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.50])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2025 10:14:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsMpJooGiyaXv3/pZ62GzCsw7l9mbkmgVJPgMhSLrJajrFC7UVeC1tpOjLGSyccA8kr4Od7QgzfkqAs9+L/iDvaUgWcNAXvjmwFQvpiphMOa4HiyconDu/n7qRRQeluOqjX0sWzDcdmtmlIQ+z5pfNn8U1Cs/oM49rqcsFNdsiGFIcGV+P5k/dwli8Qh1Mqs1bBFx/DJ8IJVA0Zav05VQaaGhQCZDnEfGagcgRw44gbUz1ocX4dK7KH5EG3d8NuYyENoBeK4AR6dtlBJ7EEtN3J6weztrskfuYhAXhBeA78CgmUk2dRGcMjtSaDF8vA9qzYta16sWH+3VegePKi3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jClI+W6S/WyHozNnEWWvA6s1CWVtQsQw6HZ3qct1sVE=;
 b=hN6zkCXRsn36luA3KVzP9swC/79lYAu7h7pElgsEeMERYH+YytgcTn1u8pzLMzNJTAJwA+zXB/qndehKw+Ruf6HjXYptJOrCOGh7o0KhAWkMe8t6eDlkwxBg+vW1KD0bIdfNwXO6qscU78iZz0/KztB79L2S/PT0d+BYLUQ0qwYmWK8MuiYLN8pZkMKqJ2scbrE7ugQY/2tHYbxyINBiDAJ9dE1ufR9Ive44XWSg0ZXpDgdEZRXM8zFyhhb+UH6DBnF/a5M28O9LqcpXfQSOmdxdBBdqdP9klvz7AsqHzH+out9SpfYwb7YIjph2LhO8Xq4c+mweBq8A5RmoNDqmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jClI+W6S/WyHozNnEWWvA6s1CWVtQsQw6HZ3qct1sVE=;
 b=neViOQ0zyksgPlDuwT1B4+LdNe/S61aOcoAEpJO/t99Iu7ZNICBQt1EGw8KReCvkdUbxgzaIelU4U0oeOJWbQzQ7Ip52lFo6m832xF1ZDsEjve5O7zNcFOLv/oaseO8wg1/PH4vSZtB9ci/JHBkLCmMz7cARzT7oKDzkXswQ3uo=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by IA3PR04MB9254.namprd04.prod.outlook.com (2603:10b6:208:529::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 02:14:15 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 02:14:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [bug report] nvme/063 failure (tcp transport)
Thread-Topic: [bug report] nvme/063 failure (tcp transport)
Thread-Index:
 AQHbxl5rVv9Lmn0H9k2g6oqO9vi3LbPYKvgAgAAXfQCAAQNPAIACJskAgAGUJgCAEjqiAA==
Date: Mon, 2 Jun 2025 02:14:14 +0000
Message-ID: <coaws33pv7tw6j7uzd7xzamkpymhczc36nz65dfowrhj4maqb4@55zbe6nqd6bs>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
 <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
 <635f3315-a77b-4e8b-8454-20cb7c9ae2e8@suse.de>
 <3ef6roj5exuktcobnailtjstndhnyyw264y7uwzhtuaaptst5n@gl6id4fhjhcu>
 <f540dd31-75f6-4e1c-9bee-304530984610@suse.de>
 <czrjrtn2q5srlg664xryrzhjifkuz57jip2qx4b7aagky57xpz@fertvxdzaknc>
In-Reply-To: <czrjrtn2q5srlg664xryrzhjifkuz57jip2qx4b7aagky57xpz@fertvxdzaknc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|IA3PR04MB9254:EE_
x-ms-office365-filtering-correlation-id: f965c6f5-abe3-40a3-cdde-08dda17b2c4c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Sa0cJkLiXFX3uG87eYzpqXnUlRAh+USfQgzT/DK54o2y3wWrYUBSOvyp0iR9?=
 =?us-ascii?Q?5WvyhWxGSHwB5f/3C2g5CNFGGQWlogqsnO9j5C5z7KMY4Bx8bhBtx6p7foF7?=
 =?us-ascii?Q?P9pQo5ApkWQLvMM/XXfmR5WPo6aMNB1IzRAmevTp6q4vpDSMoOAgtZ49Hwve?=
 =?us-ascii?Q?/see+Bkk0K3lcKHcdafrlMVnznDV2pTrC9YMv0ya5eu9S0xCAh2NGU/GDxYk?=
 =?us-ascii?Q?k390lE/d4LbBkG3OirOml7qHZD9TWXfRSuDZTd1m0xLolViDydwlt4MDKzx+?=
 =?us-ascii?Q?p34hv5j4/C1By9vWEW62WEwnL6dyqGsvFnNlUDk4BhcrIf7sihcme0JDjLKO?=
 =?us-ascii?Q?mZR5bxDUzO7GqmBniKlswYiTnnbwIsFhkM1OHBYrp8Do7zmAGsAVczB5HQVC?=
 =?us-ascii?Q?/X2j+8dQebXYww2a5/m7fSNb7MH3ITP0JNxrYPyBV/+vzMagOHsyvRxPKcTp?=
 =?us-ascii?Q?jh2aWab5ccOag64va87Zr3ytLy4CKSWGM2h8J8swfswaB6QpCmaJVBk/BiYF?=
 =?us-ascii?Q?x2csWLExlMJA7p2Oe5GKiPxABy5svwLT8ncxPH+BrMOXpgK3kZU/DlZbTiN4?=
 =?us-ascii?Q?j57UxvVh+LXJ1hvF8yHDo1DIUPldHUzd3m31Y/DSysHNG2vz5Fg7by7DX1z2?=
 =?us-ascii?Q?z8rIXwk1uZCeFZ+tZoM3b/P4/R8//casmeKCwPqxSSINu7mFxfaWaQDajDcF?=
 =?us-ascii?Q?Y0PYYu+z9qkVtYn1ytcEApASgQH3IpY4YUGCqs9LDpSz8wcauAQlfzjdZ7v2?=
 =?us-ascii?Q?12hFiN0JVdE9fdOPeY6UMNSWfOV9wHCdbsitLD3W/6WorizW9mmeWMgnYA2R?=
 =?us-ascii?Q?WuHS3PLz/mOJ+2TPKoofOaFAVxDXKiLtSOFKEWt5k8yc3Z0LU9E+qjozd62e?=
 =?us-ascii?Q?2wrRT0ZMmujJ932DXyO5pzfUX38cYeN4OzxY/AJT7B0qmDk0AnyTnqYoJUs3?=
 =?us-ascii?Q?7IClwK4tCibqJcxgrzoybECp3FrU8PFEcjD76iVQGtRfYZIEzY/e8dZplwge?=
 =?us-ascii?Q?z6rEhX2umxO6pELWkHTR5emp/O0y8k6V3+ciD33K8mhLZAM4pt//YDOUgj1R?=
 =?us-ascii?Q?0rP+V6i0nwz28fx0obuuubqAbgd6n3Z+yY3FzG6V992YPilMNhMf7xXafM3M?=
 =?us-ascii?Q?6ZTI2OpL7mvuTHtXtDt7foyGgrjjSBEJeSxQ8SYG2KDXK6Axppk1BUCxgHB8?=
 =?us-ascii?Q?JuP1vdGc7304R4cUlszuGXudcTlBeYPTYfL5iiX7oTdx7koWy5EqiY/MoMCn?=
 =?us-ascii?Q?UpHzSPRrKCuZZidz+lPO+FA2omu7JlLtynnv6CHf5byBZGoFmonCAjC1M5c+?=
 =?us-ascii?Q?hvgr5Zqnnln/ml0dM4jPohuEL6MvPayM4HqfaRzcylEVaoQiJv/DFwfAO+6C?=
 =?us-ascii?Q?hMJhsaO+XqAGoIsYXTvz4qw7aJPidIqBbTad6Cat/ajSmaYbUGJSbCxsM4nC?=
 =?us-ascii?Q?OPVxm1AQ/u9Eeq0C04Sd8g49ouX9RJLEw3AQW13c18iSYA2fUOhGSm7l/yNw?=
 =?us-ascii?Q?soYhvN2uTSrW1nI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1caakiMANU56W/TaOuN2J5Gz7sZS6i6g2LjpfabIvTRxx1lpq4DsXNk1qKfe?=
 =?us-ascii?Q?55kdFm7hm3lXcGpWhhGH2Dpvx6XRxnaUrfRuwY/j4I04zMQbz87gX7Dw1wVg?=
 =?us-ascii?Q?0baHuTIrGSdtR2wvIra58qaORLhqPjiDNf05F6tI0j0YMxORyQjVS6eu4p/J?=
 =?us-ascii?Q?9f+xhmWQoWPCx1y/iwcjxmZeORn1LmjL1B2qa2PojecG1YWHXgPb66que/sY?=
 =?us-ascii?Q?9L8u48tGMflhUBUH4EJ3D7LQYO6DyHpF8nb+z563+iJGZoJGeb5FJLuZStM4?=
 =?us-ascii?Q?ILH7d5pAYmvsEmvCfHMi2qrdq03qZ3qhQ2XF5UStVCsKJUYm5Jr2Db3Lp9vH?=
 =?us-ascii?Q?BXQr0O1K78GTj1PnYNuGQFAtOVJpNJXGhUIZdmhc4wQRzm5Dnxi0PSIUn7Er?=
 =?us-ascii?Q?tDtMCd6pze+QqqJtkXYhMAFvm+EYro7Gm+V9jq2LAEEc72Lw3Q4E+IBF8Ccf?=
 =?us-ascii?Q?WHGUSfbapvgwdULlo2hw3uhRGOXzQ+xySozQEONeRrou0JQ5+aZR37k/44un?=
 =?us-ascii?Q?bKGGwJYrsCFTvpPhLd3hT7Z8Jg1BAoBwFO9W8Sh/1tnJI+3noVLM8ZFHSKJE?=
 =?us-ascii?Q?P+ntQjpZMchpRsiVBTMMmI2BaR0VYKL/+U0dJ5rIx44Dy4bISXRZMn8P31VB?=
 =?us-ascii?Q?ZX+2mgZbFdyYGIjECjJORqUbXOuzFQtv2HVtzv+oEBFeXDENPkGUWUzulKDR?=
 =?us-ascii?Q?sahW5H9TXJy8HgjCleyjmwjWtm7J9DUxPerYOX99pxU8yY1wpLy4SeAolzn5?=
 =?us-ascii?Q?k1yXvX8SqnXABPiHFHWnGs14bZqgWWpF0RqL2AEFNp2Sqv0KBJjQMh7sNWdl?=
 =?us-ascii?Q?kmLi53zsUfb4/LoL0cr5TZO76pG1pEWDhfcNIC6gVnk7AUzKO5AK2ubhKRAA?=
 =?us-ascii?Q?hTS4JIlTbJ0A6Jk7BbJfzWCICbB1d52v/14Vpf0r6upr25u+vvt4yux3pQjJ?=
 =?us-ascii?Q?/cuRA+HZrB0jUcnYUui9sldsY/nnKUIzUR1dabavIi/GIyxmEPrTA2cVD9dh?=
 =?us-ascii?Q?JHHwu6bqlzsAxhZjPsPbjA2E99Vn9BI/nSwptfZVjxOgTPVCwPuTuPiuwmlw?=
 =?us-ascii?Q?NThcd7PELVG3PkdvgdZWt7vbnRzcuouryhQ7QZRXCVjhTvIKmQkMi0ED378f?=
 =?us-ascii?Q?/1kgfjpAMF1XOiV8WUeo2HuGVB0+vt3V1wfOukqeu7/B0ZTIWAY6OG97KPHS?=
 =?us-ascii?Q?9S/F+tz3+WqNWjoROLmTILqND5NgK8KNAIV7n88f382NSgxH9ctqrt4swIY2?=
 =?us-ascii?Q?8t4V+JUTiG/yd7NlpPO6gMXIsl8Gcs7v33ASG64MtN91avn2YqagRzbmeDNl?=
 =?us-ascii?Q?eVoEOYwMi8VBKlM0ZyLlNLqgDPLPg0q1Z/iksgOzNx72Jo80h311SU5n35CH?=
 =?us-ascii?Q?O8/+fmjkNCeUprmRk2UgQswgmLdf28jwVaZiEqI8K49LV5RSbU1nLfxN8XuS?=
 =?us-ascii?Q?BJOtSZ+JCGF7z5sDEwbouiOrM39sxRd8Dzc2EByvOG6tOBlCcjzwY6l5aYmw?=
 =?us-ascii?Q?Gfo0S+H6DMgyQT/FNlCHo01yE1JWnKDF4BIIMz8e1m/YfaZae5u76aBaFMOk?=
 =?us-ascii?Q?KhFMFnMwnGAtSEwdz6ogKp/7mhtBrr5fQHWJovcBGTQUhf+YYQpj4KN36nFE?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <746B20D59107A4428AA8A265FBE9DACE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vm4HoLivWpkIak0urtMwbv2FF0T0xAvAvrw4bNtmQtU3cm6Runc/6nBrqgi15i9PLxEwEqgeea1wXRyVtbYBe+nEZQoJYI6MfKg924k427Oj2rUyEOA0UMsdrMXq5VnEGXPyjsLbOyugFmpqCu3TcgdwReZANtQMMJ4rL/Slz2WOChMqrJ2X1hHQT2orSXZJvxGmeCUGnqwa2lYW2id7XEa8UBFQVXBclDx41FHzTwLJXeVquaMvKUKDuS265BVGtYsVi87h2CnsyzbaYPIqzV74qO2zIbQxPAyIvRGmwY7cW58yQioCgCQvPoGPZYMFLd/Ll6fvZKjo5/5JugghdtGUM/2XlRISuWCMLPJIh9GW6uCKKvf7W0gZYfYcLsUIpg7HPR/V8D9mWtcuszslZNdNfJ+rldU4KnI67oxZhNowm2GAbTu3UpsXoSsPIrx0gPdL4aGbgMNbObmZXUPzpJTarGJLxyzDULgdVHwGZqD2oABpGUePL+WRrdhKfIIxm0syiOjNPVjSFEpLgGtimofduTNBPQi8++rWtZK8/UnZpN0THWnVDfGx/myDsirfI7bTtVg0gbncPJ798aGNSvxjH9k7XQSe0hyCuAAIn2t5W0J1367AyFqLx18X6IaC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f965c6f5-abe3-40a3-cdde-08dda17b2c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 02:14:14.9374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXZndUrNv/b32yKeEpmK66qUHZGzABmOjo55LGX3b8gdyYn2/2BnEgnqY1vo3W+zBX+MkX3ycP+Wgr7CpIIQtfp4X+8Lj9Pk6E2f9Uzr0sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9254

On May 21, 2025 / 20:51, Shin'ichiro Kawasaki wrote:
[...]
> With this fix trial patch, the KASAN sauf is still observed. I guess it h=
as
> another cause and requires more debug work.

I chased down the KASAN suaf, and now I think I understand the cause. When =
it
happens, nvme_tcp_create_ctrl() fails to create the nvme- tcp control in th=
e
call chain below:

nvme_tcp_create_ctrl()
 nvme_tcp_alloc_ctrl() new=3Dtrue             ... Alloc nvme_tcp_ctrl and a=
dmin_tag_set
 nvme_tcp_setup_ctrl() new=3Dtrue
  nvme_tcp_configure_admin_queue() new=3Dtrue ... Succeed
   nvme_alloc_admin_tag_set()               ... Alloc the tag set for admin=
_tag_set
  nvme_stop_keep_alive()
  nvme_tcp_teardown_admin_queue() remove=3Dfalse
  nvme_tcp_configure_admin_queue() new=3Dfalse
   nvme_tcp_alloc_admin_queue()             ... Fail, but do not call nvme_=
remove_admin_tag_set()
 nvme_uninit_ctrl()
 nvme_put_ctrl()                            ... Free up the nvme_tcp_ctrl a=
nd admin_tag_set

In this call chain, the first call of nvme_tcp_configure_admin_queue()
succeeds with new=3Dtrue argument. The second call fails with new=3Dfalse
argument. This second call does not call nvme_remove_admin_tag_set(),
due to the new=3Dfalse argument. Then the admin tag set is not removed.
nvme_tcp_create_ctrl() assumes that nvme_tcp_setup_ctrl() would call
nvme_remove_admin_tag_set(), and frees up struct nvme_tcp_ctrl which has
admin_tag_set field. Later on, the timeout handler accesses the
admin_tag_set field and causes the BUG KASAN slab-use-after-free.

I created a trial patch below. When the second
nvme_tcp_configure_admin_queue() call fails, it jumps to "destroy_admin"
go-to label to call nvme_tcp_teardown_admin_queue() which calls
nvme_remove_admin_tag_set(). With this fix, the KASAN suaf looks disappeari=
ng.
I will create a formal patch for review. I will post it as a series, which =
will
have two patches: one for this KASAN suaf, the other for the WARN.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d89c89570d11..74a388550995 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2392,7 +2392,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl=
, bool new)
 		nvme_tcp_teardown_admin_queue(ctrl, false);
 		ret =3D nvme_tcp_configure_admin_queue(ctrl, false);
 		if (ret)
-			return ret;
+			goto destroy_admin;
 	}
=20
 	if (ctrl->icdoff) {=
