Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA18F5E
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494246; cv=fail; b=LkiazVZiOo62lLIuaqYe/Qw38i3J9DVsAvxt3n24K0jThmMsAR0LKId7op0Hi/lUFdVp0GP5EMj98C6d0BlFG807m2zdOz35BC0/P74EeHqlMakKbzTc8Nsv1LpKmpvVkRblcg78ON/oV+XS1sidygiR6pMrUab7zireNtKbT2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494246; c=relaxed/simple;
	bh=MPytp0ZUBvsCsoBjEg8tAGHw/0QI6uDoW5TBw/3j9P0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dVsMWEzAP3fencr6z49egeQm6KXnPazI2GjZX8lqhBHKJ2qUgrJQqPBMKvDmtJKEV0Q5KcM57YvGlByM+xvQS64n6MZaifkQXn11U8Bd/xoKwnGNA3fB3PQd9qUUwoeW8KrlhhHXmlSaZD2DspwP7tKUMDE1L8Uz2+dYPXTZBd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KCTy2Ir3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TRGM4Il1; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KCTy2Ir3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TRGM4Il1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745494244; x=1777030244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MPytp0ZUBvsCsoBjEg8tAGHw/0QI6uDoW5TBw/3j9P0=;
  b=KCTy2Ir30xKI6E5iw584sa/zjWdf1cC2e2cEZBUcK4Wq5elq6168tItO
   66ERzuXv/PwAFmY9bTXXbSQ4RLEPnBMBQuKbdtaPNem7tYzNMH4XZBadC
   jSBpHuC99RVJw1NSL63Rbh/33OQWb7BvP1cH0mTYz7YT4pyJkP+xTnx56
   M9QA8cpHPQA/XZCwT5/4KOHBDYn714gXuxvOf5P5d+GZ/kY6cz+wAU84t
   UJd9oi6vVLsjn+Scn4r1Balh6BIXDjjtMao0HAYZ/lvNUjN6ZSoEu6eiA
   f7aVK1/W/b038BLjd8tsFbP1O5DJjQG45dlhcjuUgIzOKV8bZRUdaTYGJ
   Q==;
X-CSE-ConnectionGUID: N3Tr4wXcQvWzLwA+aloGjA==
X-CSE-MsgGUID: Im3rsKI4Sm+WKL+H3RS4Mw==
X-IronPort-AV: E=Sophos;i="6.15,235,1739808000"; 
   d="scan'208";a="77033797"
Received: from mail-southcentralusazlp17011029.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.29])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2025 19:30:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVH4UMyHz6I6DgSSYFYffNGsVvyQnPceE6KGWNrPTdOGA0rXQVAQHVuFfiSvfTXheSLCMD7tEo0bo3ZD9OG/4DQvDVdcevFMsHZQNjrQpE3FogzqpTV0L5/mR/b53Ixf5wHz7dW8SLCsALDWUk22nhrCwsdsexrCXekaCV1TE2ZJi1RvtqtyYtkdIf92tPUQnzHwAJ/4dtKTxPGe5vZpdrx0+g0vXsi8hCy8kmIhEnvE0cu57pMzkVuVCGrTO6gjN0OWzpBLHj8R8yiQ8dt3Am9c0mat5blBTCTcu43vmn7a45dt1PlcgXg4BHQiR43HxH2NHPO5jnR3np4R+pt3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD96uU7voGg+e57N9VNfLglQukw9oQIV8r1dNsfOai4=;
 b=CEsbawWa9qGaTKqAVJOmyU9qT+VGhkjmcTVoBv2oG9C1IR1iBZFCYT+Yj6Vnk7mZT/3CddDMXAkBkwdcyXSOx3siD2MCmfZx3LbSMC/+J1lv1EfFhQkR4P3O6iq+Ar2d0mfGjf828/v1dLw83yRCNbtNNRLfmN3LiK/aweNoulBd93GDhVZW48LAuaAR4TAcsQDX/dsCDuuU41PSIbd4tFaQ0WKrPz02BJaqVxS+fHeihHjYE/Ay5ht+5BjVDW0eLtHyc8Wjyduc5e95RvYpLU+vQL7e9xJfJ9Bp7ifa3MUM6nIFTW0lQ1+2+b69A/jqi4StBNAdHu+xjiCSoWldYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD96uU7voGg+e57N9VNfLglQukw9oQIV8r1dNsfOai4=;
 b=TRGM4Il12e2jzQzyFNljx9nvtl0LSKf+NvPe7EuIwniOX/QQPXuNn/t12ZTVjRR9+03269ku1jLsnR+hGXjap/EiR65mpK2wkxgtdSWRD8sYMxin+RR9OZU4YEFHn37aqA53C74VtPpEYApii83dlc39ONqj8tD8vSe/bqzl7wE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6451.namprd04.prod.outlook.com (2603:10b6:408:de::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Thu, 24 Apr 2025 11:30:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 11:30:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Sean Anderson <seanga2@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Thread-Topic: [PATCH blktests] zbd/005: Limit block size to zone length
Thread-Index: AQHbtG/EoFT2vdN2oECRZPl70ecZtrOyd3MAgAA4O4A=
Date: Thu, 24 Apr 2025 11:30:33 +0000
Message-ID: <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
In-Reply-To: <aAnxqAv41Quh66Q1@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6451:EE_
x-ms-office365-filtering-correlation-id: 6a211572-0472-4875-d15c-08dd83236d1b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IX5jYL7W8ca0fE0SitylGbBP5GBMNJ753oJw8F1INxftSpZkESdOMH91h8un?=
 =?us-ascii?Q?vTzKkBGtvSpvEHPkpuaizyMxp4qzmyA5RTOHJ2owCnGgvPs/jKlXJsO6q22C?=
 =?us-ascii?Q?1W4Fg8ibHoJf45ncl1TJ2F7pM2eEED4h28IJuIgj74AMBgmZZ6RVlKfmSCV2?=
 =?us-ascii?Q?yZrGUlJDHOm5Y626SBZJ3oIVS6LtBNSnNVssxlXF9TQJ2losgBbdA4gmUBFY?=
 =?us-ascii?Q?H72e3RGvsOaWfHD6ulIKFc6swJxpLLFQRlssLhvvAUDyOIxfZHzKzGeI4KVI?=
 =?us-ascii?Q?lkESVc04Aj9s6RK/fVnhnlCZOHnOi7E9TRaqh6feULB0dbE1bkWulxlLdOVF?=
 =?us-ascii?Q?yns0SNNQjoZCZcGUSbMYE0OQoK/aNh02seGFXeKBSZjtM+ruXMHIB6rg98+J?=
 =?us-ascii?Q?+pHYaAHuw73RV9oBKQrgZm2qJuMJDw6Ld7YNge65C+pKiIBPRhGIp0S3G1ZV?=
 =?us-ascii?Q?bKUmsauJsBf+9vepsDqJ7yBvCwBR35zwsnVzcQcJbH3nrc9/ABRbiyXtC/av?=
 =?us-ascii?Q?7cRnO071ZoajOiVPNE+DTj2L6YkOQuPGk4/ZQHjvMYMOum0wgQSrxEQXPTlL?=
 =?us-ascii?Q?KeCnZCmHrGWyxGkqsfWTUF8F2nHdKz46MpJx84fB0Dun5enXLu3dapBJVzf2?=
 =?us-ascii?Q?lr6T0iKt7WGyW6wTqd9mDL3T721vvtr7IvyTu/lP6O6PfXoBXrgYTAzCBdp7?=
 =?us-ascii?Q?rbuqaQiACypbWa6dErkTMsjXt/5nSJcdiCangbwqH1dVXHDuZJz8UMV+mT0X?=
 =?us-ascii?Q?DoxXS6uUpTw+FOYdyq72e3of84VUEUw2aZodR4HzyLwG7FmUNCZ1pebvY2Ru?=
 =?us-ascii?Q?1qp4qBbqY0GRCwH64rTCuM3CRDg1FDyoq3ylOWJKhfbIXF7R/g5Du6hRTjyN?=
 =?us-ascii?Q?43B66ZiqUeK7u/6NT/pE9zYKHqWJ6OgQnuD2se5esZG20UHSb3/m1S0PONTI?=
 =?us-ascii?Q?fm+0ThamICldu8WspWJwHy6tk3qMSlDzxLPq7WSnRx2OG49ZvG32q/EINQ21?=
 =?us-ascii?Q?6Jx3Gq2UCduMOBZO78LbG8bRbhllKsgvD94cK2UTly0vvttMpjWSt9kFkf6F?=
 =?us-ascii?Q?MorV2i7OMZZe9BL2pwFFD0K5i4VDHE8ap/7wxTMNrYyJp3JColto+6/94CNq?=
 =?us-ascii?Q?+L+RVOwb3zpE65wqUd3UptUOn1t72LpXV5R9UZZeMb2RFUXY2ePwFBmr4n4A?=
 =?us-ascii?Q?Gvrlnp63+6sV8lvFWsnnP6DbXU+5op+WRUtlFUG+C+ISFXJTzafWgg7Z9NRk?=
 =?us-ascii?Q?nJUpClVuYFP7F1YUAFUVTMwJIwWFqvz42OjgRKS+/oT0hIuxZo5S7WhxCqr6?=
 =?us-ascii?Q?Dm4WQiIcaQ+3i3MRHQFyXbcnZHonGzSVYR5MgrBuUPfZLa4GZCoCWCp0g+eQ?=
 =?us-ascii?Q?cyj51z7oPnYra/83Xv1NJ4sws3OhA1MHjmfe8RT/U2zOCHdacGwfNHqYikdV?=
 =?us-ascii?Q?NwBrjOA3/YKeMNEVZ3aluTucfXVmSO34peOLRN9xhwTBuHWnSXXB9hZbsaCY?=
 =?us-ascii?Q?U3Q1TA8zX9sSetE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s6b93lGEP0sqb5kfpoLBQwnhJ8uB7YcPqCCZ+dT4AiNle08+XIFYrlS0ZJml?=
 =?us-ascii?Q?OAy+MxnHaZmNqriYEKcPbZaQqkE0iQW5HfXVQJNKAXHw0voCD/AcFarsGehH?=
 =?us-ascii?Q?iLlhFhrAuS4plmCc5JQYRSTvfQ2m5FV7MzcPajZwQjjLVMPoEH92wsZciQoU?=
 =?us-ascii?Q?dzgaPpPRwHqkV7NBahZyrP6A34raGLfoJzfu2RSBY9UEFhX279qcY9zWNngE?=
 =?us-ascii?Q?BfGusRxRQkDpHl2NHf5ClXpDCKkg376CNyb179MLn8i1hdknn9Cn6CGIrqvW?=
 =?us-ascii?Q?ZwzGWbvhvMWalOSdey9vf1U8eRSDtiLMZM0Azu6wwjfoVX2OT8n1GmwBTQKU?=
 =?us-ascii?Q?iFc0SPukOZK8Ztdwbv2r4tjI8mxX+WsjYJsic9gh+CJEm7Tp66qRfExUOd2t?=
 =?us-ascii?Q?x9L6urqnlMqiWgg46XsJOuQt1866fvipoPdtvvgM5TAxsJUVtqqKAJqTsgWv?=
 =?us-ascii?Q?+novpjfhBZu2TZFAZq9nEAXteRRblXz2v9JykTcdUXinRNQ2e/bzPkKRbWWc?=
 =?us-ascii?Q?KyRsA1GaKPnSNSPmRcc0xIIM6jiHwFNUPbFo5I4Ex9NguCyHgL12aIN+5ZUs?=
 =?us-ascii?Q?UuNIcMs0aKoAQL6ZGuL+1uBgWGA7ZkklMlFPmsi9KFFlwiLQOlAZRoXrlezn?=
 =?us-ascii?Q?/YPV98lsPFpC9ntUWPNHS2InS1Wc7NfBmfiDdSh2r6ctUs7gM7XjGBal2FYs?=
 =?us-ascii?Q?yUA+J1NbzWbb9TRUO8wbMfb5KAd6CbLgUdkK/X9hAs1NJEc8BnYW9oHf7CXX?=
 =?us-ascii?Q?p+2BVnH85ReJ8Ojz+dqAa8bfSkYT0QVL418/mxuqGfPLh334M1HBxRjbWo86?=
 =?us-ascii?Q?kBepJkNSNZYMoSKwMVSDnooyKVHZnPzVoXxTpoHbFDzQBbdbVWZhAqcv1XR2?=
 =?us-ascii?Q?ohbz/yzT143uIbOzOzg5nVyUHxYNnnsfFSXld52j620ANY9s6YGoabTaub/v?=
 =?us-ascii?Q?cCVGi+X7HNRYg9cpNrsACDo+xwk0oTumuA24+cQ8F9/r0E8A8WdRFBiAeKmy?=
 =?us-ascii?Q?2hFxKZ6UszLsd0dtj+SWiYYsrYcwTEenCWMrKgMr5oEEMXP77kNQ17+JggFD?=
 =?us-ascii?Q?lMzF6I3AEBl6nXg+vVd5V8+52fQTvj4pNyeITZ0JkT5o9JY1whOIioDOf/V7?=
 =?us-ascii?Q?LFEnTMK6+6JfC+K/QmPTPedx+2VadkIan3TGElCzMlJaPWpR7GSSAhGy9CKk?=
 =?us-ascii?Q?pmfZkoZ42scW/Cy3txjO+98Wcy/SOxO+NiEKMa1E7ky9oBxHV0aNuxu4irLV?=
 =?us-ascii?Q?G5JDVCQ41mEEIiiBelSzoYmJHOHbV5OF1omAMap86XqE22ZYEDMdeHuK+Lkh?=
 =?us-ascii?Q?6L+W86HKGQtDY6fnxOodfzBEGB5ktv9lBJ/VCyCAYT20MZlWZjYmk7/cA27u?=
 =?us-ascii?Q?Wd5zktKfPKZ7T05mRVttZfnoGNCIPf4ASMMTLX2wT+eytYOTVQJHEteB2cW2?=
 =?us-ascii?Q?M79lXHiqzENWV1A8RnDH00m+0AHHwcLQ0V8GXhSyPIFpUNGset8K3YQ4vzJg?=
 =?us-ascii?Q?3LiMzA/vJRyscvRPpPRpARyk0l4m3HEGU5X8zI5pvrpDDGgxe5IRqIaZFNZm?=
 =?us-ascii?Q?zTdLclJIDrQfAJPXgWMb530R91X7UUhXPXNtBYNC3/Ais2Cq4QXcc2BCMupo?=
 =?us-ascii?Q?GgLanXbv4I6vRZ6319nKmSk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F8BF92D8CBA8443A403EF85CFCC2A28@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a+QQXO+l5gg0T0l03jbzbS6qnxyakkLUhyEvgBPxcPcQ+w14hu+RSLHBWQW97sVgTqf/JwGm1zDYG04rpUIOTh8lxaGmBMQeceh5t07+xtXoHPB/2X1culUXMmBDy5NO5ziCBB0Cj5SnpsIrWMqyt4OdpkOSVGmFUae+wQBYyER8qCT9uZjIqDzvOI1Miduin0CxzH7DHS6zKv1bmmu7OpTwotiwrwkYDuqj9lcwBE+HwDFrcyTF0hrBmirVX87y5fDNoP01Jk//QQJIONp8Y74VpWnkLwrRm2zLMMzLUVOVlbR8NbSm/qaC6Pc9csD6mZ4zO3oZzRGAl2FFqsfBFP62YRIP0tTWxi53HFELdeTN7dksnmSUNcmn/7h6yQpjZV123iIhmRqSaJeua+Z9f4bawmVaTTZ2swOMBAE4UEu32NE/Bw7fkjQogvtv23prscW3GI4wRVrK4kORPLuR4Jk2taJAlco3p7v0oLb8W/E6znNdQzFPPMkzOrhtCrySrkHyu+0Ypof0Es9yEbkyLnLN+TQiYKf38zhXhVcT8Kf1MQbhr6EZGmb5f28Fswm8B7KYH1x3RU0nxQzV84QDkIAkPPjw9kQP6zPiCrlAPc/qdVFneSpSxR8xbwtbLcZX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a211572-0472-4875-d15c-08dd83236d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 11:30:33.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEGNAw7feZqQtDFpQ61pghsRpRvls2EQVA/Gh4sw9BC8poE/COFIVwO/1grMjxZDM9f+Q1W2AuT1Dt44KaEjkeY1PksXpwwQp+Lv98+Yf90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6451

On Apr 24, 2025 / 01:09, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 12:49:57PM -0400, Sean Anderson wrote:
> > The block size must be smaller than the zone length, otherwise fio will
> > fail immediately.
>=20
> In theory yes.  In practice such a zone size makes zero sense, and will
> not work with any zoned file systems or other users.
>=20
> So instead we should just warn about a silly zone size here instead
> of trying to handle it.

As a similar idea, how about to skip the test case if the test target devic=
e's
zone size is too small?

Sean, could you try out the patch below? It will skip the test case for you=
r
device, and you will not see the test case failing.

diff --git a/tests/zbd/005 b/tests/zbd/005
index 4aa1ab5..d23eabe 100755
--- a/tests/zbd/005
+++ b/tests/zbd/005
@@ -36,6 +36,13 @@ test_device() {
 	_get_blkzone_report "${TEST_DEV}" || return $?
=20
 	zone_idx=3D$(_find_first_sequential_zone) || return $?
+
+	# Ensure the zone size is large enough for the fio command below
+	if ((ZONE_LENGTHS[zone_idx] < 512)); then
+		SKIP_REASONS+=3D("too small zone size")
+		return
+	fi
+
 	offset=3D$((ZONE_STARTS[zone_idx] * 512))
 	moaz=3D$(_test_dev_max_open_active_zones)
=20

