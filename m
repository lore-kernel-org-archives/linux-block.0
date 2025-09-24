Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CB284B4E
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702891; cv=fail; b=Je6JpWpxCKuQW4mfWfDbPCaZI7FTf5AfKoeBRffd+A18/fX4HU1MLdMSFP/Oe5mnAJ3+QQuWyzFpFzT7EQdB9uljbhqFI97BXXvohbBj5uyAU6Bg67sGXqG5G3MDN0TPTHlODp9wmh8e7VBBV4kIFLXnrzOradLk3G8YaB6KEkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702891; c=relaxed/simple;
	bh=SkFLjx6qLVI91OwVUgIWAokCtumKE5n8Y5m1mSkaCsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kFHpg8vuZXg92Fhq44E2phvGVej57mVU2XE2CBe0KgFfAqsrM4/iNzsR2UADY+EWjfHyt66bsW6HFwVmfe5hvkrVeG2tK/OB0EZPZP4t1LuFQ8Vne1Yk1qTQwvFuufh8hhvIUjbVIATS9SOYWIc6lElDxG0y7AAxQkFCJRZpab0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eCvcWcGD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=alqoP8Ak; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eCvcWcGD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="alqoP8Ak"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758702890; x=1790238890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SkFLjx6qLVI91OwVUgIWAokCtumKE5n8Y5m1mSkaCsM=;
  b=eCvcWcGDQDr1ghZQeG4ni3K9Fkaf0ePhZUD3uOVuB4VZgfJonP8dzhYl
   d417yvm2JDy47yS15bXNFWcvSBAXzvRSLx2tdX0RXD2sGd2euObARkbsx
   mqYUL7fmzbhCGPGXje9I/h2WsEXP7UxUtmKkDSUM/qUR/UhWMjW3l/1IJ
   hHGbm5EJZqXJOx3oinPLVZRAQAUQ3mOoPRGXA4GFiMjDUaGi+yzbZqv96
   bKyZnnY5dENLn8f+21xNcsQAM39Q2S6NTx7Ev+C/D5ftIITlocGPyaYrn
   UU7Fhynwhuu66Fv0MY2rV76JXn4GtH+wiNANVh0EhPq9Q55Ea2VnBMDrw
   w==;
X-CSE-ConnectionGUID: nvH+37cWSFCRloD+XbBwWA==
X-CSE-MsgGUID: A/DtIDjyRqu6bf7o0FTjAw==
X-IronPort-AV: E=Sophos;i="6.18,290,1751212800"; 
   d="scan'208";a="130176392"
Received: from mail-southcentralusazon11012038.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.38])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2025 16:34:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2SxPISYxCv0FtmIBsGWWRfZQISS97OTWAOSCHjIWgCgxTrWfyvCkUbWnRjfbfWVgRl1YwA/pYnzVEVwIHkStwDfY3cJn5m3Mj8mJP0PCqXpVmr+NWI+/I55tUiBThdusevynynwHhGmWEhoCVGj9/DGsl1q7pP7fLR39K/gWiY3HGfPUiPXpUMPF7NuxFWyMWWuNBaOchCk+Ks0d7lTQ7RWyWQVinOTBVa0gVUpt9jSZ4Tlcsjd3XOL95WvXSVOTYzXcwGmSAn3jnwII2ZIreqeCVb5lbTmquUYKSITcUp/4i4nTZUme2ZSn42tPcSN+aL+5zUAodid8kfFItaVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHalmJtq+1juOMjU1qj/JvIuWEgNxkmPaRzabwCRokQ=;
 b=trO/QLSVYTv9bEsbPgv1P7Ace4l/MMKmyje20Pc5nZ36QBs/QBfTe79zzRJ2jvZtHMHXKwxRL/aQJjE9DN3Z+onMJFLqokAuKGsKKvJrCfOodZU+Dn0kHz1JmCG22IIws/VAZBxx5kX3g2i81EimHGt0PJ+Np+0VdHP1KF2OYhvWJoKcfylCBMfgkWfnB5CYw5xOOpJzWNUzlq0ku3DS4Oz+QxCuZj0AjORJ9z5CRrtW9/JY4/peVQuFwvD1GtYvqC0ayP3vFXB9qOO4hhb0ELtyPBkc70sGPjs1I9oS24p5QvhsaUyio0r0UmMcc8cPh8HUfPQ9J0cOQgjePWD4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHalmJtq+1juOMjU1qj/JvIuWEgNxkmPaRzabwCRokQ=;
 b=alqoP8Aknnnc++8rgqPjNuP7WgLwp9BaNWwpfJTj6tOvVYrdQS5i4qr/snzeRJA5uE7sRCc6BNs0YdvmMsnai2bGkik6O3T6HAD2rTGUD+RBf4buoA+v43nuGAQSB2fVrPH02PUu3Rcyd5eBBV87U14Z2O7gFKsi61T2EKTbPFc=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7485.namprd04.prod.outlook.com (2603:10b6:a03:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 08:34:40 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:34:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Anuj Gupta <anuj20.g@samsung.com>
CC: "vincent.fu@samsung.com" <vincent.fu@samsung.com>, "anuj1072538@gmail.com"
	<anuj1072538@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [blktests v2 0/2] io_uring PI interface test
Thread-Topic: [blktests v2 0/2] io_uring PI interface test
Thread-Index: AQHcKU3CMQGUL0uWV0mFhP4BEZ5tzbSiCYaA
Date: Wed, 24 Sep 2025 08:34:39 +0000
Message-ID: <zv5u2fjcnexj5jhispzyc6tuyl3b4qppqhq6jymw5kajbxsyzx@lny6c67qds7k>
References:
 <CGME20250919101117epcas5p3db87ea9641b5694dc0a44a24d7b898fb@epcas5p3.samsung.com>
 <20250919101028.14245-1-anuj20.g@samsung.com>
In-Reply-To: <20250919101028.14245-1-anuj20.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7485:EE_
x-ms-office365-filtering-correlation-id: f8ff29d4-ba87-4f4c-dbe6-08ddfb453408
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kY96Ew1ajzUpZ0+a4CU0pRi1gGAziDHIgLrPHssjwxGjQYgHzIgDXZXcFTYB?=
 =?us-ascii?Q?Czq9FeyqHF2jmT45QCMoV52+KquckrwUv6zsI1e0+4o+61fUEfjiVZegSK7p?=
 =?us-ascii?Q?H7jr3VFykGtT3W8qKGL+YyV2nd6uYf/Fbdp5Lld4pwyPPCIJyhmlyEUDe3qT?=
 =?us-ascii?Q?KVtrFbPil/9Hob9gl2BvcSf/rqSRHFMHtDfj+v2uReA+Nz60ftako3y+plNm?=
 =?us-ascii?Q?fuzymi1ot4EUZAa2WCZvt2RuAUUAC+HhiHkCKxiXVL2lTmSWIVLFnzmVd7Ih?=
 =?us-ascii?Q?NotSMNo4V88T65UZv1Ql5H7/NA1aS/7ko1uwZ9h7k6octf/9m989YwzEYlVA?=
 =?us-ascii?Q?outZ0DjxmZDvSuNLcamtmU+kPs7I1hUkOCg6bAOpeJu7MmVbxo+iFairqArm?=
 =?us-ascii?Q?VoY8Ej3h/WnzkgzFnV8g3rG73rCWrO2viB6r06LY/4laB5Kjqwx9QdoJAIZ5?=
 =?us-ascii?Q?COWB9Sbz0Y5kyQA1Hjra6OBcswV+WBU3Fe6J2vFKwL9fKYkqwFwVp+6OmKYM?=
 =?us-ascii?Q?eOKswJAx37pu+Qg4hLLazez7ZfOXXMNvFZ0mw7ChU+MEb3FnnBQo7ZhbKj7l?=
 =?us-ascii?Q?fWUxsFNE4MR2D+xo9cepNmSJcDmknx3er1r5v/un73DhEZeNeTvGU6Yrj9Qp?=
 =?us-ascii?Q?7rGWDW9uMNwyQKpMbuWAg+sTsP3xK+sZqU41iL8l5/dH40ehreJEZtIZCe9k?=
 =?us-ascii?Q?X+LRJNPWZIhhde5tX6bVis2VWpdfY4yvMgSY9wZ/FurJgwEkUvsVRzM4MLpv?=
 =?us-ascii?Q?hAmqC19NEBprbREqwmmTzlSF/wJcVrRal1vV4E9X1/j1F8sS5lnBSIWTstMz?=
 =?us-ascii?Q?xr3MGf/t1hk1+SoDk3UZ1WuXvTFlK4EZuI8HLCPe3sJSgzSzvOPsyT16UuGa?=
 =?us-ascii?Q?uNURpPyGc07/qwwwSGIIVCoVaDl3SuNhTRSoJXs2CCpJwWTcF5ymPssp1ejI?=
 =?us-ascii?Q?6C/oA+SC09XSDiF+XQBrg0Gfr623OG+A7G2UVS+p5XaH8U4rPKMrCmOJ2AvN?=
 =?us-ascii?Q?h8/fyPo/rryRGfYT19SXnHrEVRuYITYIeMInp/Qz6wqz/aHJu4S3dqCckKlq?=
 =?us-ascii?Q?Y1Fn6JOYEMVPEGRml4bRAWNrhMbjxdIJVVkmypN7MS1mXAdwXqX93OTb3240?=
 =?us-ascii?Q?CvQ1ahdUuMHMrPnr+P8wY5KAIa2nP1p3QiJI/8yRDe0xeDodELEIwMXcfy7a?=
 =?us-ascii?Q?lkCK0Q/zSpbhTYfCMQdlrsNv4Oqdzl0MTJ05VmGMx8Sv+baD7sTq6YLtXzLC?=
 =?us-ascii?Q?2Yt/91j2MK1pIR2mzeC3KW/EYS3W4JPV83ZYwp3xW7EEoTMWglZ9ns66v+6E?=
 =?us-ascii?Q?0+ScFRKP1kntrcFh6uOmx6sX43l/mU1xi5ydRUzpgZvsMrpnk5ECRW3JUqrJ?=
 =?us-ascii?Q?CGhRp4GfDJIfuXyMuP/dOa0aknS+MwWwoJNLcH6VxE6P5YMIpJ9s6WV9BB0B?=
 =?us-ascii?Q?xlBVGsqYP0qMz2p972EPixxE+dADMo1NksXxoDJ/5gL7dnxUtzrjHw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K5+WzicF7QMRLCRqnwMkbdZOjnTTeEaHJ6aJqty0iKtnk01ehMn+Ep5N5205?=
 =?us-ascii?Q?+4bYN4aJ3G6GfNdZR77FUBdxwdpGOKi6K3J5PtpfKiiPVC6ySd/sU3ZlbZgQ?=
 =?us-ascii?Q?qzo26Cm+nIR5/YU53qIfdoIp2BoFpzyKSK29Lik2RkqvfPMHuwvpSuBWzGBr?=
 =?us-ascii?Q?Q0OjkEqNCagETFVv+aMxlDq3mYL0olB5+7kCRG5CHin2nhk/C22UrMWRqqR5?=
 =?us-ascii?Q?JmiYXhdxvaDAma1K4DdwXxMBm1CoR7MMaZT+aRuvVVUbA7TPlVGo89ow+sdK?=
 =?us-ascii?Q?y/RfFdyGR2/tOD+2Ie/NWFsuxSdoah0UnPF6JcOu/I9nE8dQq78ub94j8keG?=
 =?us-ascii?Q?ynxDDrI4R+wUhrAahbUJ/xGDmTdcs6+DbKSGxktrj4iKyOPwOh88a+Gn+kdn?=
 =?us-ascii?Q?rTtOrMxBH77ga2kTdf1qqw2h0NHO9eppGKg5YK4mpg3SaU/xlATT/UMa5KVC?=
 =?us-ascii?Q?u3YmKT7Y0I/vh6JqJEIXKaRBtjCvEsMOaW8MSsu9iTsvBgKIpcS9r4ddicaJ?=
 =?us-ascii?Q?z5IJye7uL0eWl6Rq1YRKSkkLjzddJAXheAzW7S7Jq5WjeuPnjhybES4OEBCR?=
 =?us-ascii?Q?Ygfhn/ukBeWdQ9e5ntR/n9dDP98go2gdn39+w+d3UXyCuPAvm4zMfnqzyv88?=
 =?us-ascii?Q?tO6UyjwDMYYNSOvU1uv1bVhoQsif3aa8E8uzz8MBVatjlMN5CW9Gpt8ZJmS8?=
 =?us-ascii?Q?Z4yiOCnz8P9kxWKlfKrM4OLf9nMwFS2UySZkZ0Lgk5dS7h0B07JEQpuSWi9l?=
 =?us-ascii?Q?h897URKt4zNYLe0mSju/mFR0aI7nmUEdyNJkvserZCkY+O2UwqdDnp7Elr4c?=
 =?us-ascii?Q?hsAZLH/NW04I/NpNdeTIjZxGWgeshbUrztorScjPnzw+y+hvLKqSXLydaYQJ?=
 =?us-ascii?Q?v++P1fRluqxbPxlYPR7F31/HwyN89j+h72Lk5B1idCs5I1zYpFpg0Y6DS+KP?=
 =?us-ascii?Q?VxtkQpck9pxUBjAMMXlV1Tqmz6VGC5jch+9hTMKDSqsJWzUAsAzNwFZZXNFY?=
 =?us-ascii?Q?VZsH6WsQJs6ePI/d3ZyKWPLW67CXyOPVv788m/50GZezEFicbIbOs+s0ElZU?=
 =?us-ascii?Q?/iV5E6Yy+105gBTkKsvD8/WK12+/yWO82WTIR6G09AYfYlC0DiasN1oxk1mZ?=
 =?us-ascii?Q?FBCQZHXL5ICoCVC5F9Arc3XiGL6hTaLMyRAKEIGMgHPxTfGzcEbg7n7vF4c+?=
 =?us-ascii?Q?0aJmqstYf3P+IGSr1FCWGT4fsApkuO0Dy/zRESZ+udJf6zuroebj2orfXAMI?=
 =?us-ascii?Q?S3XvjjVashtiU811cktuK6rjmKydXxSqiWi/tfIPwcIOTw9+GJ7mBIfWH//s?=
 =?us-ascii?Q?8MhOs0/0VO4JUGfbkAIGz0YM3fFThHlnSYrN6/Tw4Z6s4jU5cosKKFG6G3Ay?=
 =?us-ascii?Q?8OvhhwjKyd6FfyISRSBB31wa6w6CVHJufiNtuy3u2PaYebUOEqO5DIepKdxS?=
 =?us-ascii?Q?ptTuJbknxcim7tCSvliOqbwoeym0g1XKAfP7fUp/lKECAd7XyilNDQZ7KtQV?=
 =?us-ascii?Q?1ocF9Ai3rz3KP3aiNsqS/IuYglTNwfpwCO+nCqCfm6MnBiLcY1W8sHWdIWAI?=
 =?us-ascii?Q?L4hWEMcgo7vi0ubyRMZvER7kqC+akEtUVmxB8lwc4isz2SSwyCiMBubb4CVP?=
 =?us-ascii?Q?IBNwxG9IZ8ACIPQLDb5cfqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF40F8F77D9DF54699D0B9A5C6BD8833@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gb7ZuSpv11TUl9ewwN7tmudeSmeaS1AQ1Lf6NA4tdoAQnjioeoe2ljP1uNj5DWUXIQkaTILX15ojQ0lLcmoYWufSo4S2pS3k2+jwlvwZ8H8JJ4DF/hkiEbWpO5pOERDzarC+KB/YxosPanFF4hv3wDlI4VKf4jNFdWbzoCAvKSXN/LQttXI4GUI/7kGQ4ZiY+byTd5R8dolGdRiNvf6lr06SKRHJrnLDNIwt74mGGa8k5jboB/koXvjzY+rHP5qTDXJ0frnkMGQDNq5LJAzJuP2vrY7V+B6NJ3+8fxz1HE6JBkdusso+svVJ9vdq4ADwgTCYTeSlVHrvheX5s9TsHs4o2W7DIA6hYGbA3qv+ecJNZaFnZcubokVgsY+5DIPXhEUqxciDXS9lB/Bp6UEbLj3zdoYXz5V40rOmFPRA/byqME02awm5VcYm0dd5v8yboA34+aDqkGj7hXepAqJqZB+XxHuMQ8UKxWuYx5vYQl9RDkA+6xClvW/0kBqtw6zxBJq+YmRgKyCxSbLV6lK/jRxZJrlvSotvkgOa1J8SV/KrmWSTs5yD7qfKchQyg9ZEJ+NYJIAj3ZQ6dluLp/lwM8lG3ycM3yGBYXN+Zto6H7mNBXrWsw5b43bKTet4HJrc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ff29d4-ba87-4f4c-dbe6-08ddfb453408
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 08:34:40.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkYECEPiuax36R1U7/6Kp9FqY94AX+tDPD4M1x0NuOlsp+d4GcRFxszm29oTj1FiswJtTTppB73iXBVOin8WN8DseAZV86J0EZ0jWe1p5sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7485

On Sep 19, 2025 / 15:40, Anuj Gupta wrote:
> Hi all,
> This series adds test for io_uring PI interface.
> Patch 1 is a prep patch and moves helpers from tests/nvme/rc to
> common/nvme
> Patch 2 adds the test for the interface
>=20
> Anuj Gupta (2):
>   common/nvme: move NVMe helper checks out of tests/nvme/rc
>   block: add test for io_uring Protection Information (PI) interface
>     using FS_IOC_GETLBMD_CAP

Anuj, thanks for this v2 series. I applied it.=
