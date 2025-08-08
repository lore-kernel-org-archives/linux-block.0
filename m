Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675125D8F0
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653217; cv=fail; b=O6TA5j8zlZyhCOvx8lEb6BXLsnppsMDKMsiEBhTKecOKBSMYfWp0IjfqMYozy5nTG2wv7ZvQnvaAZh/mDNQk01gDsPDE3aq5RdiU+ksvxamOKT8tDN2+2iO4Ytus+DPmPvw8VCG8Cq/XXen5OkI3vRL2vtb2ItrkW6IaCvCQa4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653217; c=relaxed/simple;
	bh=ZnJFcKgLzyeJGnoUQDz8vyjnHFvzguU84HyShrKMuRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TuAdCuMc5mGesmRQipTWQdLz+MUQm9rWIC3VgzysDh8c/dtyNeHcIDC3a6cRz+GEQmo3obCwr2M+GvCCWrtlX+7ysgwuC8m6b/bF37nET+jZw6CJ4KkjEVnPqR544UUJGG9x8DK1WNdPsiTARW/KmsuEBqwY0a8ZhrJDs4YDzho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rx5b+eGo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AY0qLmyZ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rx5b+eGo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AY0qLmyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1754653215; x=1786189215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZnJFcKgLzyeJGnoUQDz8vyjnHFvzguU84HyShrKMuRk=;
  b=rx5b+eGo9H4lOa8XLXK3VUWKNl6/QVqTIYKwk8vcx+BGGMqsov2kqtS3
   BA/7nrddltp3HejK5N4IFUdlSn9ED37GKrd+5PBH35EIecKYQv/6hEtck
   qPyZtinOjxkDyPB0Vl49Llqs+/DEocUZ4He8TJrFRXTiLPz6mn6QLvts5
   2TbWwOlW/N0UQUfcCjR8TeoJYVPxabvx9/fzLPSThPKY5Xs1PVmSTHS3r
   J2iJvL0JhF7bPqsVYcudCIZOE0guIViKdAsp3VTvva3IE8AxfdReFNI1y
   2MvJIF2Jccm83obfWhVrzYUV+58j+AKTnebAbSI5z+snvhFa1bhtTLmxy
   w==;
X-CSE-ConnectionGUID: 7CGRM0zES9quj8GR82LDBQ==
X-CSE-MsgGUID: KBLMWZyrTeyd24vAkR0uDQ==
X-IronPort-AV: E=Sophos;i="6.17,274,1747670400"; 
   d="scan'208";a="107617614"
Received: from mail-bn1nam02on2057.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.57])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2025 19:40:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0tvjBSz9IrQaohHabWtEGqySuXQuqh1P2Ry5Z9Ivdq7lAY2ILP7kry5C4sBBzde4PecbDuRZSagG/2t9d9nbOtCvzMpwM16lwp0gupAYBLIjWJcUgn9+TVBaUeXyg7AL5F8mevafKxncVW989502MbvlAgxAdYr6pNm+oUMkp5C7zf6EYTKtT8aRZa/N/zLG86nF4+43U9PwPdOuHgZd6zRL8wVQfC+I7KEzsSaYmqv5WTfM8Bt5+RH44M6fZvGr+siT7M7xxZ4irZVtxc8lq3yYrV8LXOBIBtEKW3/x5kQZIzVy7jcpcHGuH5ivki13mN11FQFAqaF6+iQ+/m08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I52VW86FrEAhrQvRhs4/ntYIFt+rLxyLvi2BvGRQKsc=;
 b=pefdcvbcWzVqqoqJKvcusISvHsHhGU7J8UzqjyGVCcuILGTn4oESjsne67K4r9qUOFizLyHCautY5+4QYGLGdzBs7OgSpUluNi/jbPGFSPaW12m7jskJ+o4m4mwensmMRxVbMsj1g5IdIgWbRChrSIgnGF46oxaEZkeIGA2JEYlzdGA/bER0BVWO9nWCpNfeBCYhFLJAyZiBiMOCfD0KANad8toWa7wT3t4sYXwQkV9WTOfZyBRj3XTo+hJxbG4bB7K7raNY0nCryGCj2eG8KClkh+ec1OQThZ7ZatNo1nwK4EaJSY9mqTDhPtYVhBsel3uBtDROExea5NNLLbeZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I52VW86FrEAhrQvRhs4/ntYIFt+rLxyLvi2BvGRQKsc=;
 b=AY0qLmyZy8Rk9y5kW9KbalOR1TkHCvz1sR6ZznweIC3MJTvfQxrtkWB3eVoRSc7VLMEAjZfe1n2mp74wAt+r8z/iJHHSR5nPc7e9lu8x5ahk1ZmuF212o5KmDGIALT6o8hI3PWZCN3tzrlio/CijEh7xDqv/Ga+eEYsyNHW/WEE=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7480.namprd04.prod.outlook.com (2603:10b6:510:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 11:40:11 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 11:40:11 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Anuj Gupta <anuj20.g@samsung.com>
CC: "vincent.fu@samsung.com" <vincent.fu@samsung.com>, "anuj1072538@gmail.com"
	<anuj1072538@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "joshi.k@samsung.com" <joshi.k@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [blktests v1] block: add test for io_uring Protection Information
 (PI) interface using FS_IOC_GETLBMD_CAP
Thread-Topic: [blktests v1] block: add test for io_uring Protection
 Information (PI) interface using FS_IOC_GETLBMD_CAP
Thread-Index: AQHcBdJo1Y3vqBce4USJsy9bd044ebRYpr8A
Date: Fri, 8 Aug 2025 11:40:11 +0000
Message-ID: <v23bumua6pdez2kizqihersvyp4c5i6d5mecagtddwl426aaec@wfnq7zumao5n>
References:
 <CGME20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea@epcas5p4.samsung.com>
 <20250805061655.65690-1-anuj20.g@samsung.com>
In-Reply-To: <20250805061655.65690-1-anuj20.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7480:EE_
x-ms-office365-filtering-correlation-id: 8a416233-adfb-423e-3c94-08ddd6705570
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GTI3EpBm4kIQtxNiwRyHvAVj88PexPKXu/pV8wzVGSaZFOitF7BJ2aFhhjmv?=
 =?us-ascii?Q?UAIHIO9tNzo7Vg1KRsOvo862hjRHwe7VEEHtVDvTYd45sivaoEtn7eJAVeD4?=
 =?us-ascii?Q?OdiUK3Yl9t8wQOr55cWLk1fwMpSINLoluR4szudb7LLsyXzsyUoibUJIB5j1?=
 =?us-ascii?Q?Ux4RyjLKRmt3M0OkKSmLOYRXhicBnc2dteqL26+eKdZUXti+UauW7qn1gFcR?=
 =?us-ascii?Q?PStiwL+MJ4yWAfzRkEl2ph32ri73MKNSBBCIYkGMfOFwVLmR2Us4HVP1KKar?=
 =?us-ascii?Q?4asH+ws7U/mNIIniQTEe+Aq1gkRmaqNZC2V4PmO7DVb6dKPRonQKdOOQY8af?=
 =?us-ascii?Q?7LC870rs9i8Z+Lw5SfShSr5IhZIRe3HAIIptwup7baZE8g6TEUyc9I0BH6f1?=
 =?us-ascii?Q?JTPsxIsW4Jr6mkWdgbO8OICkIILwCXKyrYLua+DzX5UhXUmScT8vbDsc7BUU?=
 =?us-ascii?Q?JyVg3xm868vk4kLRcGJTTHBNbeGKQ1gMegkxG9pxjlT4fXzB9Ws7IKwLqjtL?=
 =?us-ascii?Q?+W599XkuUZCuaYqP67H7pTBpGHDtE+tDenBA0t/SjQZ+yHJTXetb26tS8All?=
 =?us-ascii?Q?Qly2DSEUEPdwBYnYX405a7s9nU8SZ05F1b1VrbowafqMzIyRf3DMGfmlHp7v?=
 =?us-ascii?Q?RCnu0Bz1Pp794H0BIZJbtfx/b83TC7ZUiyC4buh8IUDniTuknFoYt1TdG7PW?=
 =?us-ascii?Q?f8uWEiDyFYaQu4orvo64KUDl4FbiwSneu8VB2t3E5duJwh1/QCmfWyzCP/Gq?=
 =?us-ascii?Q?TGsXZLODDdaw1Dc3yDgfty4Si0Y6uwQbKjTcaw/kLfGsDF44Yj/g22X61kQ1?=
 =?us-ascii?Q?crCmtuAionGU14iTzbxU/NBsFVSUf6ZIWhi/OyGvJSircoq0/G4pIGFhgySp?=
 =?us-ascii?Q?RDcJtVfagRSaZPvzS/vSiEFeEaHqkFscogagymcYfviOJ3SAig3XaZ+lwK6M?=
 =?us-ascii?Q?dNzSoHQ3DAKyDQc0kb7tyX+csGxqi9cvlJwXXqKqOsffpRVdDWIpVmOAo7zv?=
 =?us-ascii?Q?eRZreLUl09Ddd9EQ1zvJmchrr8TtxkaGjUrqcinSLXLnLf2xdP0c2nrI2j2R?=
 =?us-ascii?Q?uP846FVKLcVGy6dH21NOM7PzaxoyYQVV4g/0MZMGgpTatnekU1SNSxukuZC3?=
 =?us-ascii?Q?iFu0QgY+fgctdC+Ih9Gy4KiTEaP/joPsu4av5a14PY9aIR9ghFFqUI6zpywR?=
 =?us-ascii?Q?TMwzXZyaugAnoF8ZKb6jjDUl7Y6lXYlPwcFOyMdApPk75KgXOfIuuTTxzHZa?=
 =?us-ascii?Q?xEHD9wvIy0nScvTpE/gCemI4c1u2tGmSCUwb1Wncu/Hkqgi4zXOUFmX7gzrx?=
 =?us-ascii?Q?Y2ZcuO+rPikumdJO7BneKVQFe9k3G0IffLJO5PZraW7sw+2vuZE4UTpRVSzw?=
 =?us-ascii?Q?9VjtPt1ylDAT8YYlc2Z1u1gpPTHPrhGoIwAR07jJL2dfplyzgi2qu8/JqL0m?=
 =?us-ascii?Q?5OQtiYyR4Cp/7BMnDvrOHCrhhHamr5jlgLoz+rqxJpuj5BPRhwgsusSTTs7w?=
 =?us-ascii?Q?7tU894vvs2BdMk8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?etNntoZm6MxtmvB0j5fsga+NvSpOUvsMFhoHd6EuMdSgcM7pB2Ebd5Zz+onr?=
 =?us-ascii?Q?Kg5ikOenrhX4iGWdXOvNHJIYrBZ+tjeow/vHDWr1KfIa+i4ERWn0o6eKCRSg?=
 =?us-ascii?Q?dBedHrArk1DZDKz7FNf+wVgv9tbtj0cub3qXmTaPfJ5epMCHumDYiPi4HHgt?=
 =?us-ascii?Q?w/5EbIcJzc3lff4eO7Z7Ihz7PiHz1Rnw5GMzwm6Bx8SbJNymI5cy/ebmSENz?=
 =?us-ascii?Q?ZOSGYG+JcscjSwCLX906uJsDsgNn4LFNKfbszswnl90vPOP1QPWijnd8uRwa?=
 =?us-ascii?Q?9KJL7pqN2uWNq+VMz0kAfWxLCJo3sphCPNTDQ4U2BTryiIlwwCe1z0bDkCZd?=
 =?us-ascii?Q?yBUHtI5Hx7byheJyMIMAzWFz7RMMXl9vjfU1MNHU413wOd/6c/mMnWTDQXPq?=
 =?us-ascii?Q?KXhJSj1ynnPqw918J/PikcD+dCnGnJqjdp6lhlXYpN0lPMjsQ9Noqj/qHchg?=
 =?us-ascii?Q?0TCd7xoIXhkZLLmYhBHgQhDU//lLqPu9L43EGlxqUGo2jUAHIb016lq3sEY6?=
 =?us-ascii?Q?YE2Xmqe1mh/kT9u2CciYgpgYm0QWl77l1/pdf8WBQKYxYZNmDGPEOlhHTeVA?=
 =?us-ascii?Q?qrD4SdVtCzwT1a16QEVAPZ81kLs1H31kYO0tjyW/rYY+mUMiCnypt4jmf9dk?=
 =?us-ascii?Q?QNGA70sNk4nh9DzAbQlVFK0AOYT0VceS2B0QQJLYxUxIwj3/Q7+6w9I+U/vX?=
 =?us-ascii?Q?pLeXDPFks6IEU0j2JteOOx9CTn8htdjQw3AxUEms01j5fJvRkPIE1U2O+qa2?=
 =?us-ascii?Q?jGXz2E+KDXqgn06AbUQmEr9cVGo45FRc4PrVedaVu28mhjyQ3Rf68KfQt6iK?=
 =?us-ascii?Q?vquYqxe4hS45M4iSizneBrQ+aEMhrBl1nN5BKAh/TXWPl6t3dhV701//KJEq?=
 =?us-ascii?Q?AGILHjzqxoplQC3QFjHIKWSBAMSgHqjHpM15a20Xkax2CXs3JJI4OXJVwvkz?=
 =?us-ascii?Q?mVtxyYCgwtBpCrqNjd8FKkfoh1GRUwTYUH3/lcdii2NBUkBacI3K+Ed4F85G?=
 =?us-ascii?Q?sB8hfCyszJMiwUZt/9XSLNw0OwmRn8bjJAeL5Ip+WwBGDKkGvRuyCkfyKPz2?=
 =?us-ascii?Q?aBzXVYz6SDHgYh4ydDtOBBkdUqKB2OKVfzuCBN2R/Hdhwnl/EeFxrUH/Mc+5?=
 =?us-ascii?Q?CrxJGpXWwnBf/1VwUs7L0AJPc4eQyV0Y/a1R7aabtPSP5bannNi+2o5kXb9g?=
 =?us-ascii?Q?XzNk3dMGEVZUaawY+5TA1IWqiGLTBoIROKLxzWl/pmD8pcYv/JGGjOKf4oS9?=
 =?us-ascii?Q?SYz9uL0SYWjpzMejp3S1hXHiaqHNylzjtQ44m/nMs1z0YNa9HzlY7nH5Quhf?=
 =?us-ascii?Q?Mir310+UQFNymmLwYk/V42IogJC6Ow61UIwmKTH7xJm4ZHIuYgFYZ1pC+TkZ?=
 =?us-ascii?Q?cpl/1bAuLCPHGNzGICPJXyegjXK0zVSFp076GuveEmvYnyRJtyL68/gQk1JY?=
 =?us-ascii?Q?+eSpOoWR3i1sRSOXlbjNuRCgNJEyJCT1omFSO1PzrEqnCc/DFrF+PIj1i+Wb?=
 =?us-ascii?Q?Ycji7hQ01ob/5M/TfEsatquZ/dSbI1EUMdEpaBmqQJIwUkY+8b5f2WXetEu3?=
 =?us-ascii?Q?zh2KuKh/fa3xD+bhCTEFK0/S5iBRRBY+bLdf6Wm2RP5iW/PhaSC4PW/E4Md1?=
 =?us-ascii?Q?jLqT1a0xNzBnactA8fI2ExM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B787860CD86A634E88EE839C74E90058@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H6r6e0LI4zdijpW2sVxmMmX7vxs7tpPhaCVo0TTcbP+1VhSzQ46bQ5EGzXvSJPs98USAht2WUuZh7Rmfmb9iguzaVtGx3XXlPqBPoyfxHeyzC8cUCGGWJifY6NO4IKhrUsSE+iCpNzDUwwZcr2XN+q+2FnrNmGOhQ07/K7dkxq2QbZWvCSyl+VvQJ1xawlyqacTxBadey+0dxz7C1cchjVdwbdWoZfGM6l8GPtMZVz8L5IS0yLn/xPLU1ciRIL+NQL/QPLH6OjOhvbK6SiRyKSD1MLEgLZVxtQeQrI/F6CSs0GckZUIJj3eB8bCajMQRGw16YMe0YLasVGqLp0cBvCw4zY0NNQlD5OFUxVc6HlodqMvUPN+icV1Jc+e2ZWcUoZy+zSkhDQvyCTc49DUbVC52cgL7aURvbLyEls59WEzVLBFX7ozLEi+jhTFG319HGAIwHyR3IR5dYCnKGQHWJA5ZQqx0vZopaxjJeJ4+rD85BSpiO4vAPeZKuEY88xjjUNg4GXWoY4lesJ46HBXMgC1K1nUIKEzavVa3Cl0DtsKVg3E6HbP+clwGac57k2ad0qSt01To2u1X8j+AfUMzetNdBMc8QFFjVHJGSaPXmKQzcXxRMTaxIK6dmUWO8mo4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a416233-adfb-423e-3c94-08ddd6705570
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 11:40:11.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haOaM2PKefagovU3sXhYW7lFCCcfTYHKaKfszZpfQLCEmSnXkEB3+xOThFjZ+9+Riwo+uvClgGHwCCoumZmT3ozlBQ/6JA2J5yO54etoXto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7480

On Aug 05, 2025 / 11:46, Anuj Gupta wrote:
> This test verifies end-to-end support for integrity metadata via the
> io-uring interface. It uses the FS_IOC_GETLBMD_CAP ioctl to query the
> logical block metadata capabilities of the device. These values are then
> passed to fio using the md_per_io_size option.
>=20
> io_uring PI interface: https://lore.kernel.org/all/20241128112240.8867-1-=
anuj20.g@samsung.com/
> fio support for interface: https://lore.kernel.org/all/20250725175808.263=
2-2-vincent.fu@samsung.com/
> ioctl: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=
=3Dvfs-6.17.integrity
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>

Anuj, thank you for the patch.

I wonder which test group this test case should go into, block or nvme. IIU=
C,
this test case runs only for nvme devices. Said that, block group looks goo=
d for
me since the test target ioctl interface belongs to the block layer.

I tried to run the test case using QEMU NVME emulation devices with some
ms=3DX,pi=3DY options, but the test runs failed. The kernel reported a numb=
er of
"protection error"s. Can we run the test case with QEMU NVME emulation devi=
ce?
If so, could you share the recommended set up of the device?

Also, please find my comments on this patch inline.

> ---
>  src/.gitignore         |  1 +
>  src/Makefile           |  1 +
>  src/ioctl-lbmd-query.c | 60 +++++++++++++++++++++++++++++++++++++
>  tests/block/041        | 68 ++++++++++++++++++++++++++++++++++++++++++
>  tests/block/041.out    |  2 ++
>  5 files changed, 132 insertions(+)
>  create mode 100644 src/ioctl-lbmd-query.c
>  create mode 100644 tests/block/041

Nit: I suggest file mode 755 in same manner as other test script files.

>  create mode 100644 tests/block/041.out

[...]

> diff --git a/tests/block/041 b/tests/block/041
> new file mode 100644
> index 0000000..ddb8117
> --- /dev/null
> +++ b/tests/block/041
> @@ -0,0 +1,68 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Anuj Gupta, Samsung Electronics
> +
> +# Test: io_uring read with metadata buffer using FIO's io_uring PI inter=
face
> +
> +. tests/nvme/rc

Cross references across test groups are not recommended. I think you introd=
uced
this dependency for _test_dev_has_metadata and _test_dev_disables_extended_=
lba.
So I suggest to add antoher preperation patch to move them from tests/nvme/=
rc to
common/nvme (_test_dev_has_no_metadata can be moved together).

> +
> +DESCRIPTION=3D"io_uring read with PI metadata buffer on block device"
> +
> +device_requires() {
> +	_test_dev_has_metadata
> +	_test_dev_disables_extended_lba

I think this test case works only for nvme devices since nvme-cli is used i=
n
_test_dev_disables_extended_lba. Also, I think fio io_uring engine works on=
ly
for nvme. Then I suggest to call _require_test_dev_is_nvme here to clarify =
the
test device requirement. If this suggestion is valid, _require_test_dev_is_=
nvme
also needs to move from tests/nvme/rc to common/nvme in the preparation pat=
ch.

> +}
> +
> +requires() {
> +	_have_fio
> +	_have_kernel_option IO_URING
> +	_have_kernel_option BLK_DEV_INTEGRITY
> +	_have_fio_ver 3 40
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +

I suggest to add the shellcheck control comment below:

  # shellcheck disable=3DSC2034

> +	local lbmd_flags lbmd_size lbmd_interval

because when I run "make check", I observed the shellcheck warning below:

  tests/block/041:26:8: warning: lbmd_flags appears unused. Verify use (or =
export if used externally). [SC2034]

> +	local cap_out bs md_per_io_size
> +
> +	# Query integrity capabilities via ioctl helper
> +	cap_out=3D$(src/ioctl-lbmd-query "$TEST_DEV")
> +	ret=3D$?
> +	if [[ $ret !=3D 0 ]]; then
> +		SKIP_REASONS+=3D("FS_IOC_GETLBMD_CAP ioctl not supported")
> +		return
> +	fi
> +	if [[ $cap_out =3D=3D "unsupported" ]]; then
> +		SKIP_REASONS+=3D("Integrity not supported on $TEST_DEV")
> +		return
> +	fi
> +
> +	# Parse fields
> +	eval "$cap_out"  # sets lbmd_flags, lbmd_size, lbmd_interval
> +
> +	# Calculate md_per_io_size =3D (bs / interval) * size
> +	bs=3D$(_min_io "$TEST_DEV")
> +	md_per_io_size=3D$((bs / lbmd_interval * lbmd_size))

Also, shellcheck warns about the live above:

  tests/block/041:46:23: note: Increase precision by replacing a/b*c with a=
*c/b. [SC2017]

> +
> +	local fio_args=3D(
> +		--name=3Dpi_read_test
> +		--filename=3D"$TEST_DEV"
> +		--size=3D1M
> +		--bs=3D"$bs"
> +		--rw=3Drandread
> +		--ioengine=3Dio_uring
> +		--iodepth=3D8
> +		--numjobs=3D1
> +		--direct=3D1
> +		--time_based
> +		--runtime=3D3
> +		--md_per_io_size=3D"$md_per_io_size"
> +		--pi_act=3D0            # Host supplies metadata
> +		--pi_chk=3DAPPTAG       # Only check app tag
> +		--apptag=3D0x1234
> +	)
> +
> +	_run_fio "${fio_args[@]}"
> +	echo "Test complete"
> +}
> diff --git a/tests/block/041.out b/tests/block/041.out
> new file mode 100644
> index 0000000..6706a76
> --- /dev/null
> +++ b/tests/block/041.out
> @@ -0,0 +1,2 @@
> +Running block/041
> +Test complete
> --=20
> 2.25.1
> =
