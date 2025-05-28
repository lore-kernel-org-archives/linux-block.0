Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F71EB193
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424520; cv=fail; b=o4NGjmGP+8FMag79Qy9YOCAgDfVUJtXRLnfjdWVSpaUY2SE/8YoBtc4YsOmSTMn/LCwN1+cT+0XfJFyo/VJh1h1oZ7RSaZ0jPFuCicP5mTTnp5OczaD7XKV9uHlDzTWWHgbrH67E3KkbHARmN8CIhLOGhPlhkPy6gLlcZC6d4n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424520; c=relaxed/simple;
	bh=L7xGfuAZKiL39PzuhKw/YOJsRgm1BdE4RIOUb2KqpW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QezXtmaSeq5wlmcwwbitzMfX/oZoMHmaD4Sa6t8Ltj1OxQxHKtI8W4kOGhyWNjPAE6kcOdB5v0doQgkLzWpl74O4Cv4pdq7k1Gva7jYwRSsKnf+0+7fGPxKeYcAWd9WomG2VgDowVgNbl4Fsyyi5GvEDwf9TmoPkvF8reeja1qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EKJRnpRu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=brspYdm6; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EKJRnpRu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="brspYdm6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748424518; x=1779960518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L7xGfuAZKiL39PzuhKw/YOJsRgm1BdE4RIOUb2KqpW4=;
  b=EKJRnpRuvwu/VvIE4Npdccy8Ljbc1R1Ac7sl6YYCD7imkIh3Rq5tjYcP
   KBIEA2ttsSVKLr3mvGUhXK8cCcsmJWpjoZEoPWVAukRE+zyXxV7mSndHG
   1WaDnVcBzVqOYWyktJGAxWEGIdb/5g9arOg0VrO43z2ptgNiWNZFCOEnF
   wmfaQUGPEME3F0+gljaXOSTI4/zldOqYLK/5TP4Im4SXjuwXlnlnd0DsP
   QGtc+l1XoVLay8Hm3hK5jGmg6Lt4T/7ExnMwc3lgY0FJtbQUntKBD0m45
   xgnZVmV+z+yA++u6fmQ13HuACoJn5HWg00XjFR6AyzzSlb/sm/vttLGQd
   Q==;
X-CSE-ConnectionGUID: tU3nZgJuT+KxbFbhLRCb1g==
X-CSE-MsgGUID: yfmr0QDMSUmbnSGkGT9d6g==
X-IronPort-AV: E=Sophos;i="6.15,320,1739808000"; 
   d="scan'208";a="83397575"
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.70])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2025 17:28:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjowJJLwze9t9FJaROoJYoM+/ksXOBwLLYxSU2i505CqnWIxvcUTGAw0lS+WO5EqPusC9e/BZP/x7jAnN96X3TKS0zuttXtVElK2Drj6AZb4BP+R9mpx6Nj3vX132HLaCH5OnM4fSOS5xFj0zlPy65rrcP1a93sOLsdJx8JSrIZIYOU6tm3gxjVT9F70dki/7FJh1AInznHSKGm36DZEkYPJ57YDhQe5ZVLZiVzdC0EnWvAAK/rZqK58/xy8ri47enc47sZcpc3Pz/x0PxTVrZxy333s4hpsYlGPYvRJnWpdrPpBYxEecjTUy5QOvRZZyA/tFhAzq1iJKiIN9jnAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7xGfuAZKiL39PzuhKw/YOJsRgm1BdE4RIOUb2KqpW4=;
 b=u5SJ5q5W4ZZxIsNcE1v0otbkxwWQnA5jXzKqzRVKbdgBK0E7XkHNuP5XVAt6/LLXmlpIfu9Zy9jl8CblqUp6QnlMC0i9kp8inCi9mC99w/PZo9R2n6AoBuvToFP10zBYP2gyPJ9NrCWkkhvJKrXb792Kik+U0TFPY63hzDbZgoCm2CDMswWygWQsfiGAEEwODslGeNWFsbht4Qz1eexnPlEoSZE2bybyMP5KnfWegBTodtn/AOC/moEbZyZCsMU3Y2VvmIcZQQRw+J3lfyLBukvAO7SFyTJfJu2ykAPn9X21Qhmg3DoAq4IdVJLmKGdly5IGN4MC2jDAfoHP54sATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7xGfuAZKiL39PzuhKw/YOJsRgm1BdE4RIOUb2KqpW4=;
 b=brspYdm6vDbHHTL4pw9n9a62iaRTjzXsuPXb/J6E6wu6q3EkbSecYKA8GyA0S5tlCAgNaUiofkjCa8XqtFhY2bICMK0+gLDQnf0APS9Fx1Ulr3BTiD6D+LK2d+FOGdjGhR40kD3AXYysiCAOWqpphVycHni8T7F0wjLQ7mwd1Lw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BN0PR04MB8141.namprd04.prod.outlook.com (2603:10b6:408:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 09:28:35 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 09:28:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH blktests] zbd/006: reset only the test target zone
Thread-Topic: [PATCH blktests] zbd/006: reset only the test target zone
Thread-Index: AQHbyVen0AldUEXXAU+J2+5YXNW4cbPn0xQA
Date: Wed, 28 May 2025 09:28:35 +0000
Message-ID: <ikiqwnxst4p2ekhbyj2xfimqy4hor3t66yl5iiut2lhgnbdapw@ehembl737r32>
References: <20250520072018.1151924-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250520072018.1151924-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BN0PR04MB8141:EE_
x-ms-office365-filtering-correlation-id: d287545b-9a94-4f11-fe0d-08dd9dca0550
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q26lzCusG24RPtFesfX6N9ohMu6nQ/WVh2BVBdJqfc36Tvyl1SUqwtGKTyvu?=
 =?us-ascii?Q?tG9yutBs8lYdFODU+yeqPi+U1SHeP241BfmI/s2uMyjjzi4Q7b2aF3WHy1V+?=
 =?us-ascii?Q?JT+OyjkcClxqsZWiIRNt/q2lT/5LZNcHeLhNDkomTv1J2XNts08/TntkQ1wP?=
 =?us-ascii?Q?Bq996f5m/AEckPLPuvpHi71W9O1OXkhbzwHIyPf/DCHOvcObKeChc2BF/Dsz?=
 =?us-ascii?Q?4jS8S3D5oVigqad2U1DK/C1YQ3GWQd2tspPNL1/0EKRbsXHTkwSSMPcYxPQu?=
 =?us-ascii?Q?YNZHbCGNhfk/o3b3nl58AxinMG2z3C8DOKGzkigkVa9Q7BxQb2L9dB9ZqQ+5?=
 =?us-ascii?Q?3DrEPdSn05Y2tqzanA4WDSDdZ1+Q9qJdDMBcPxznPSDw3HXfehChsYbTbRFC?=
 =?us-ascii?Q?bf2l40fEID/5qUNkG8CSHTMtwq+Y0+eYgqD04jxMIyryPXeHe1r2+3Dlq/O6?=
 =?us-ascii?Q?Bs5ue5WzA3QwP8rO0zRt47WoUhnzQi8uEr34hVGIblMDEMFICC9aLz3L9M8u?=
 =?us-ascii?Q?kctv0s6/9mLfP5REDHXkH0bDjQcNvvmkzeesOt+EhOZfrUK47hx7ObtSwL5F?=
 =?us-ascii?Q?o0ZHDwOD2l9V40tvP5vGwLOA3rMPb4AySDtA6OzN4M+Loo1xup/JStTYzVRA?=
 =?us-ascii?Q?4tIDCDWG50lOMFP54O+f8Ve17tE7befuN3qISAjbw/AogJzSi5Cb8mFp9Wwj?=
 =?us-ascii?Q?StO2zZ5wKrzwAPZ8E9sgaNkJ4cMJcx1pGDOnILKogZEjoL4H7apC0PTyMK+O?=
 =?us-ascii?Q?mKKR4LJQzYggxBpG0+l3NjM+lwL7ifd7UTbh4x9UIl/mIrp1pFTfTa6B2MCj?=
 =?us-ascii?Q?bfRfiq8P4CP2plUur3fyCuatf3qgwnjUXdeg5od6Y/oDS6CGnFFky0yU6LPv?=
 =?us-ascii?Q?UoNcttgqr2FqfE3Zm3EL89sQfKa32zYJhRKFfjfQLNuzoqqHXZfsLJ0ZBM6k?=
 =?us-ascii?Q?c37PjYXECAqMQCqP8FYjKLtYmvnywrukHNoDg3EGKFgJHr5r/jH63doGpVER?=
 =?us-ascii?Q?kkmOoG9VeJrosWrFxgmr8ozMRuAqRSRQ9rhg0VwoZAeRBzPZhFdlOWbhCKo+?=
 =?us-ascii?Q?Kcc1OpFOBVlGv0u89JbKAH7HXTpllIdLXKIHWY81fZr2g7aWhH8kW1W63RE9?=
 =?us-ascii?Q?9xESVtcrGA0bXw/wq/L8GR0UqTQDf3pViJsu8VBwyNvf6bkDC8aSif4Rxkcj?=
 =?us-ascii?Q?JSbDDntvF1Ni2J9uzsEAaG+7Josfqv7JCja2CLo+ozBRe1ZjUaBENjlv0Cqk?=
 =?us-ascii?Q?118kNvzpufbRAA0hIPbb5hvohvFCCnxY/ZJRMHF2iN900Fotnbv3xgIL9zrF?=
 =?us-ascii?Q?ohUMsvHEU+HYV5+mXDRqh8ecs0wP8Ubq05GrM0h8XwS15xQuINvpA1r4vAnt?=
 =?us-ascii?Q?Jq8SklYZ34t8wPsDD5ModHWqhyj7CTLmFiTrs7fK091gBAvYJXLRPWcQxoDC?=
 =?us-ascii?Q?lDF/O40Iv8m5QZcgep7Nigqvg8Qr4Q8WsphJfr0HUEUFL75tBhXWhdtuh8RZ?=
 =?us-ascii?Q?EhZ87At7CklkhkA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BW5Ruc6XSP8Lv+7CGnA1v+fsYCEL9gf1NtI52W0S2JgYsqPP3QCH1S7iwRTL?=
 =?us-ascii?Q?CkAtBrp0cgPFXaV6jkTQZtfZ7ypOof2xJeIg1ciLRv3PuRXTVAhV9Y40Sk/g?=
 =?us-ascii?Q?2ZRIyTT5ejGlTIDkAXkJdmtAkFYtfixpdPjGUoiIZXQBedVnrCRuMPeWHwCI?=
 =?us-ascii?Q?XR4vG6zYADtx1zeXCcIkYUzokF+8gqsqSgTjg+ee2wxks+thnh9jywpt11B8?=
 =?us-ascii?Q?IxSkrY+lK/8ezt/J97Rop3cTs3QFomyH8hgtMNs+293WhdkiuMNWLH2lQ1zN?=
 =?us-ascii?Q?OOU2NessfjVcXXOUS5MStNo1lAnvRXZvif2XowEs2+Kxy/ln8kUHUxd+Moaq?=
 =?us-ascii?Q?FDAWE92OFtXP2S3/ak0l4Fsp0ydcbCcZ86zPCo4X1MMWY1cXgud1wlxPoGfw?=
 =?us-ascii?Q?qwFPyUA931Ldm91BZlU0dyhYFrJJPipbJhPfXP8N08o3OsfWH4Ok9oY2PS0i?=
 =?us-ascii?Q?NKvk8voebVXIaf5ZsZLrAoY6QrPQ3DMpf1EOUFFSKC/MTIKwi5VkSFH96jui?=
 =?us-ascii?Q?omgtppsyEQDSW3/zCok+FnRcJp4tehan9b++gkvSlDtR+zVsCOEIKTHv+axv?=
 =?us-ascii?Q?0Po2qkPBG1gsLAKC4y9BSPm7TTv5WR+cQGIHoTCQd6tHaS1DHBRzZZqT/Wqd?=
 =?us-ascii?Q?qOpISFjQ89P08QlYGDQHvE3LtraJejPatwCSqJykv+yKdRMEv493AQT+Rtyq?=
 =?us-ascii?Q?G/4hiBGl/feQdpN6ischn0fSnx+u0YBhiF+Q0tm7VoKu8X9CYvhggTe83rWb?=
 =?us-ascii?Q?g2I66QUhfyQ84LVIJC1yvb+pipDAPfs8C3zm90yCRAUZkZaO2RszH/5Pf7x3?=
 =?us-ascii?Q?IuWd92UwX5rkeS+iufALBALMBjTu7uBAbdDAsB4brT/q+3/c5+AoU+9EOxtk?=
 =?us-ascii?Q?mvsvN96ebHk0v7QRXECB0mN9NaH9KrGF74FcCzkicUmDNuNDAGB4uOw1Z1k+?=
 =?us-ascii?Q?MHCTjrsY1tEgcVes48D6Um+vfLQoS9KZlLFY9f+AJ/xtl/EeMOLLHgwXvMrl?=
 =?us-ascii?Q?O9sXc70K5OAl1I0mEDCdUgWsniprzbw0XFkulAlMaC2zs1Nefy46XmUFvor0?=
 =?us-ascii?Q?gSfhHwRTW5468CP0vOtiWVt9WGlNc/OB+mfS1p5SHSX8pg8kV47MjUdpQdIi?=
 =?us-ascii?Q?39QGTMDtFRn2WuslUIFkn5pNghZLcsNeMQcoZT+cpHFloXaUoBM9rN3xFreY?=
 =?us-ascii?Q?SFuRxRsfvALoF51ZayYU3krp2J9geGx5/f6GMVuphuiooXfFrhbmtZRAgiZ+?=
 =?us-ascii?Q?wucyEtnsw3sZiikMxHO/Zpu/PkP6lEdKbqWJdLn0t7egpqpcYKfAWcyRsyqj?=
 =?us-ascii?Q?FftWDYRkSqEfX4ZR/pMq/XABXiWbniYlXIcV3spMOr/MFgTYkw7DNmHWr80G?=
 =?us-ascii?Q?YF7g/g1iS1BzX0NyPkybvL0Q5hSVXK1BhN3cUPfdkBDoDoV1RdJbkfqd4eKa?=
 =?us-ascii?Q?Z9DEogsxMSADnlVqwQzWTrvuPwJMTE3Tj+qwJdXi5kevPdZccL0rnQAJNMaJ?=
 =?us-ascii?Q?L7446wSmblRIPPCsBaVcSv9KGYsv+mED4lF6MfwOXWciF80CAbzFqhze6uIJ?=
 =?us-ascii?Q?ivlbKxTrJMJWQQhH1rwa5sBahtbP7aSYE/ng6K1uN9SncjpxSc82qFbdJjHl?=
 =?us-ascii?Q?cQ0IshWp3iF8u0hlY3dpAtk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC14D7865668BC4F90AE8F8F8B6DFF5A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0L9rt5tttUN0Ot+xoRj7FAPlT7hdJdZXBhwrEvBhfcVfz55kC7vwGY3C/LAsTBNdemx8RGcSEnOwKloGyryVewLnuUwHbAIM929BwMwci7AfzkRhp+1TWs20ONo1QRf2iUxj+xi82elv5sKvSk+nkRA/O6npa/h7ABzefSH7cKbvpSljhILnCKgz/KGONYI4wk59DoJtrCDO/z7GA+DZGuQALUhV03kQOsjzTGCq1fh0In6rqcSaW0+PC60K5rqF3fB03PRPryUbb+7O15OOx7UdCnZCIga5ZP02YPnhW9brh0pNtPqc9obh/WiAF6RH/vk48VRRi4ZR9szhP6Bc+ZpMIsaNfBxFegmWk1BrHwso5w/EQksn8hkZA5V8AdyjEHeUeK6Z3j9xZn1wqUPvXcidDVl8VqFRJjotHYZPwkMSzKfFDsdj9URTmm6KTGE1PAxCO/2LwUTg1qVhxq5izTOgbEzYj9VNcMOroipXLIElLabo+oEiqFhAalgH1jGephOay6nREfEgHfO5tEfDCKMsrHiaKIWmYqajRkWc0kD41aDzcmPU2LCa0fZlwDf8diLUmnvR65jl9ANcTKHqXotupl864VqsMmj/UDZ33NNtbDL45mbCCOQGXyby/aNW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d287545b-9a94-4f11-fe0d-08dd9dca0550
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 09:28:35.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JPtHM84cUrI+YH1p6Q3JwUTjyv8qf3iKE6tm8iTlAzlEq7sJq4lNF5MIMMprPjc7AfSu2ouBPIKVQ7SKuUHmMO0yHzNbCEcfF9R1zTErU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8141

On May 20, 2025 / 16:20, Shin'ichiro Kawasaki wrote:
> The test case zbd/006 performs random writes to the first sequential
> write required zone of the test target zoned block device. To prepare
> for this operation, it invokes the blkzone reset command, specifying the
> offset of the test target zone. However, the zone count option is not
> specified to the command. This resulted in reset of all sequential write
> required zones on the device. This zone reset operation is unnecessary
> for zones other than the first one and significantly increases the
> operation time.
>=20
> To address this issue, add the zone count option to the blkzone reset
> command. Additionally, use long option names for better readability and
> clarity.

FYI, I applied this patch.=
