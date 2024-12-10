Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAC22CBF8
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818659; cv=fail; b=dwipQxQhtFInLKBbXTA5E/InjTntArneFnMBST5ddm5+4krx+U2c+8BKsTyWYSdyZqEm07g/vHJyUzgR8HpWg9lbeLz/PrgWU7j8/Oqlnw3koButIVOe2H87M3nVLNl0q4UYlqrBNIse1bpsai0ItbBNA4XNAm0/DqpgnfqWMvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818659; c=relaxed/simple;
	bh=rZVk6cnQc6VsR+hJc2V8FSNnrEt0QTmRmwI27lKCuGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tk5d+aWwFCgEymzLck/XPnflmxxvRUNgehNYqnkvo75CH7d8upLA9qdtYP+14jndyuKFbNtJiLthVVblNqGqqXS7kjYtY3YlqubEsXAoEtp0g2gFowv24si0lvh5Gp4wZS2lVGNgkT1kjLEwAnT/XXwUbEnDpyyi0M5n0b2FxEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BCc4OXQS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KDPmuWTr; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BCc4OXQS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KDPmuWTr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733818657; x=1765354657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rZVk6cnQc6VsR+hJc2V8FSNnrEt0QTmRmwI27lKCuGQ=;
  b=BCc4OXQSSMkLRWixgMx2f8txHdKWKnu/8Gn4YmGjovh6OzC9aPL0otU6
   WLXN1OURZUtzm+bHglD8DEmaG95QR3HFkHMuY0+si1cgegi62NJuav1wN
   /ml25u9ZFxr1BhWnaEmKsnv+70VY6KsGg3uyVuwPXYzi4ZWm3NDg+24Yi
   qRGGiLrZVUfdH40z12JeFEe6zmCud9XQG7YSwQWdcUBWZ2zOXSr6K2cV2
   akoQNHD3B296RLvlAf5denGrja0Bj9GItjYnNUGYKGMOSseISMN1aXEma
   pVkiaXozzHkXBg/dsu7Da35iheB70hszz87e5BErXwYT+jmP7nyv4d4MN
   A==;
X-CSE-ConnectionGUID: WADXcS6vQEmgr48ZrQdKSQ==
X-CSE-MsgGUID: lZq0b/SHRZas+W+zCyJxGw==
X-IronPort-AV: E=Sophos;i="6.12,221,1728921600"; 
   d="scan'208";a="33977033"
Received: from mail-westusazlp17013078.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.78])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2024 16:17:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUBVmgX9qyLj3epapesCTF0ZJlqetUQL28WP1wzLKPeELi4EnQrIMZuVUarmVgFZmcFq/cPrKzYwOCOHWhgy1b/+nB2OgFC5XlTErIzCS30I7Z2nPKNvnBF75B5W1U3YZnNoRVdRqa9UkeavAeUKBTBia58h3mLM6H49cF/a9SbrTsdtjFCu8uiXGyqJmheHzXdWjBVxsYLWmLJaWfAgXgqHQuNrjvpWB7YocFE4mzsyPPt3KmHy0cScdoXdcTA2KDDc2CV4rehj7pOKL2g/DFxRtaCQNZ7eoHudQMushglU9AYQSohyFJI3EtHQii9ie2HnecVv2adhGOF/vRB/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYZ9TKdqZmN3CpDck0VyBkQcsgds7KUa2B+hVwgik2o=;
 b=Bl92vMJtlZwK4yJ5uJjCG6+kNcQRTF9RWBKqFV4wJMsjPGWeBcnpRD2nBEHrJRX6CwH632EKh+poZPSslrmxzOxONbNYrepGUCqILFfGdK1uqjvucbFQF5ACJg6QN4JauFsRosfDFoEDmoxJITpeohG5LO2x4wUiayDSMZ8fPXAeSyuQsv3j0svfaQB+Rm9JBIsWxvRSypYOgUYWd+BVCSZgCDp30KYzpDf0sSLKCLLnN8txPy/p1BGCXql5whKMgY6Jsqu9nz8gpD6KNBnfmitPIiD6QqoRGSkhPC7UjpdOegclRmumrqbF54y8Up38AFTfhBnEUcxTnMRqWsR5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYZ9TKdqZmN3CpDck0VyBkQcsgds7KUa2B+hVwgik2o=;
 b=KDPmuWTryDwz2pkHotyxcEGA/Y/VwccZ+/+CgyZVLx52sLkO3Axbg8kjEHNgpYex6u3zIjJDNyBtfh5EqhEFDJUOOJgEJPnReRBQmL7nSE5Zs0+oOGYgikSgKmGIN54/+44RiYGG0kaODR3eAQvOFLdA1Gips0b5WDDs0Vicb30=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6956.namprd04.prod.outlook.com (2603:10b6:5:249::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.14; Tue, 10 Dec 2024 08:17:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 08:17:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Aurelien Aptel <aaptel@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Daniel Wagner <dwagner@suse.de>, Shai Malin
	<smalin@nvidia.com>
Subject: Re: [PATCH blktests v5 0/5] Add support to run against arbitrary
 targets
Thread-Topic: [PATCH blktests v5 0/5] Add support to run against arbitrary
 targets
Thread-Index: AQHbR+X9NLy0IWfzBUSjxJTijE045rLfKB0A
Date: Tue, 10 Dec 2024 08:17:30 +0000
Message-ID: <fokufczaxuwcv7ng3hczz62sb67y7c5hxdqgwxm3zu72ugw6bi@xwvlwq2qiiz4>
References: <20241206135120.5141-1-aaptel@nvidia.com>
In-Reply-To: <20241206135120.5141-1-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6956:EE_
x-ms-office365-filtering-correlation-id: c719444e-7c86-4e06-70d0-08dd18f317b7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h2mRsan4TI1EpNoeDH6Uk/Kuw2QyQuRyWr5dP9laRs8jDj1D6jaYf8zEQ2JK?=
 =?us-ascii?Q?aOVKexIb2FVPZsGMVDtOENAcZEb8IQ/BRG2IT9IH7wQbwz3MGU2hCKgx9R5f?=
 =?us-ascii?Q?ViM9p0KIHFnToo2J6PVF1LgHca2MRLUnWH6g67yQPENUy6pUApGEuFLIBblJ?=
 =?us-ascii?Q?pTTPZ8L5UxDTTFSizvqDmc7Zr3666L7YrTVnMX1JMpqy6JJ8fjkw4XjMa3YD?=
 =?us-ascii?Q?KeV418tTB6SJib2aYvQGJPO5tuiyDCIEaKsxVqg6DLLom1V4GQxJvrFVprdN?=
 =?us-ascii?Q?L8huESOiMgL3Wj/zYSUfag+KnuKJnstMOUz2oDYxRNxkoph1hly/J6+uF0rH?=
 =?us-ascii?Q?QHe2We9H/ZF1ipdvB6n4ISNv8MuXXd4io4Y5HPycjALBnHC7gI2G1DZbiFGw?=
 =?us-ascii?Q?AiMEdLy9VqlsoslHV/DAOe7OucYr4o9vh9aH5J8z3pEq9dbaQDjFNnPjqurz?=
 =?us-ascii?Q?QaO85VQ1usp8+DBdv0oq6Z7FwjFAFIzXx35V5ALI9yrC6FnWHsYd1Th8vrYK?=
 =?us-ascii?Q?hH7SesPkAJ88L1hQdb2dUtuTIh20zSB/pnST96X/r7Kd0TrPdzJRatrsThlS?=
 =?us-ascii?Q?lf1/0AE/Q2j7ghsqnXFSjWlCZ6VhRA5l+ajnBPsGjn0ZPkLcYAhrC645Q+Ft?=
 =?us-ascii?Q?RhKYyQ1n3H//M4E6te4xA4QynWH+lHBBWRUlEnsmqO9TbX80n+nuYk4D/K4U?=
 =?us-ascii?Q?0XdBKG//F5U54KjdtLiQg6cRwY5H1VNJgqMkzoZb3R//SvArmP5jjWiveU6J?=
 =?us-ascii?Q?enxAvf9W+n8EFu/SjDpp8pET9tBo2DaDIkjJDGf8WCXnh08B2MFiTS504Knd?=
 =?us-ascii?Q?pEkeQWK557Z+7zBZVkKhLa3ZZ58Ktyp2DJglCQLytz2Ln7MesEzVlqFvVC4C?=
 =?us-ascii?Q?9Yj+vnsrWXlDSFZ1O9t0oYDa6DxUN0PCCw+fPXNud7IpHkVqOth/9/y0yBno?=
 =?us-ascii?Q?CfA7IYtxS4aohe72J12EYQZVogHeqv+u8gXb0YvSrdEX9neHrKMJnSYAVUl5?=
 =?us-ascii?Q?+4SWcX7JKFiSAY8kdrYOghRPVegG9+ZZ9CMJpFcSlYhuE1WuOqe4tCDh6C8I?=
 =?us-ascii?Q?xPaxK7J8GPW8uYz3uZgLgd/eu+d9rcjABcqX4Jy+jyD7o/jQpsQsUkbuSayJ?=
 =?us-ascii?Q?Pbl2EggMNybMm+fV0uenOzP4xE5LiBt02SffR+nwSTgu8hylHteZh3yD4K+o?=
 =?us-ascii?Q?Yg12SgHlztGSVtc/gh08dpzNyBy8l3shIYRXSavFp7E7kxtOEVSUYg935j3u?=
 =?us-ascii?Q?CBUiuxkJwWRzr8/NR/ZXgGsYgmCXlGjRMvGwkWL99HWyURU1dtQIqVSXVo55?=
 =?us-ascii?Q?OMIJWoDiYAc6GVjuw9T+HqahhyEcpw+sxbijjVD2sN8cCgfKumyyls/rgCWX?=
 =?us-ascii?Q?nMjMcrlTlhjiCalhygXlw0MJLgM4V+nmphbuqRiWjO0v1KVoPw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ihO1aIHlT9dJqGkHSF2JNsILBeZSzwNmpx9QnUMld5yI0lrc6b2Ssce9/+qK?=
 =?us-ascii?Q?AAjvF2bMUN9MergKr0/hQsYeOZTp+xmHCQFFnDblUj0eSIWgf3BXzu+QX4BR?=
 =?us-ascii?Q?MpvNFyi4S+heTO9BKvCRSxOeDu9WngD4RNcaojUAS1d5V5ZHd0hIsRy9pnso?=
 =?us-ascii?Q?LnvznQ6/EuTipJ9YG9mnvH5E9g7N936v4m/PE84e3ZDAh65jMRMff+jPkGRM?=
 =?us-ascii?Q?smRg9tgkT10vKUyTYJK8tBwz8kQkPL4ZMYPtFNP3laqw9UzQ9m6P1x96VGhE?=
 =?us-ascii?Q?83e2wxedN9KsQDekjgNUSl0s9j0paqNSgZqjj9XG/+vKU0edbhBq6aGSqn9b?=
 =?us-ascii?Q?omgVFhQ1cq0qEYHTLmJwOo8yHjh9UEU/izc9U3XUrJFBnE3t3otzZximplmR?=
 =?us-ascii?Q?de34upyqLmw0Hvs2N+JOgS32A4VjlVxqFCNl54rTytnWXPcllNz8m7foBnfC?=
 =?us-ascii?Q?u8fAMgDCZNxWvR8mncOTOpEoj4Mc+ovSHXXju6aauskk7nTRSvQqrMU3Z+nz?=
 =?us-ascii?Q?J7T0GeMc/l3xe1P9Ff9Vo7tBjFjXr0DqjS/ity0rhRlqS2pfGf5vqvUqwQtB?=
 =?us-ascii?Q?XPQs/GEGhUR5CjRYAMGlfhhGH60tFTHLiW7awodTDPsdhQod+X3NrYmrqfRj?=
 =?us-ascii?Q?OmiZ1g/m5hp4lPBGFJcZ9dzcgxxamCzDuIPHfayYWJcQU5KVsOXwrfuhCgYh?=
 =?us-ascii?Q?AKYKR6sHq9rxbtb+dRXNwFupmMb8N7Hb9ess4DfuvgHtWVZuR0DEz7N7Npt4?=
 =?us-ascii?Q?AjGl/7NjFY4I9MoWjNjdP0pfY/tt0YdNAJzKSQoHAxZ50Xn1dI7pbYYQIAl5?=
 =?us-ascii?Q?47YE7dxq3293TKukKAKXKKKsy28Hh16M9uBipM2+ak9cDK26PX4GYqf+UhY4?=
 =?us-ascii?Q?KLBk/sfpREcnJdE1uHnexj5CLxIIWvjKr/NbeuHwc40uXHW7Qs+GAHWWtum1?=
 =?us-ascii?Q?gvik2fozv7ZRInuJXva9yDU6Qw5txKt9QX9vQQTlq9YB8KZ2juyKvc82ednv?=
 =?us-ascii?Q?/TQIb4WZJxlrW7XSNI0idyYwCe6R+ikcPmhOL4dzHjos2wWid2mvXtGAqd5D?=
 =?us-ascii?Q?NQzrXQpsgQF2QkhL8Lu8pyNVQq3i6gdBgGAJfxkX2H2sgAveqWwM1Bxo5CWT?=
 =?us-ascii?Q?Zmzi8SpqrnKNNwF6dZojtNK2q1F8FRLsz4k9vJkowu8vRqk3nQKfXiLZiCvj?=
 =?us-ascii?Q?J43ZL9u89Hg7EAye2XaBPVUgybG2dV1QwMYLp3ABrmPebkAJvv3JPwjSildW?=
 =?us-ascii?Q?FRbmLRGg1RukezCsMTwFW657JGYxgkogDDsnx4eaT23T637/UUL2sXZ/BjiM?=
 =?us-ascii?Q?kOLOPG/9yrcsNnh/GarZgVc5S3BuonyQWyI6TXAV4T+RAqzByhlI6huDo5V1?=
 =?us-ascii?Q?iNgRVelJUxL+cRf9NrmIQakhXivhj6Ph7Cp5cfyU8leArzHaZRgyMcl2uTOq?=
 =?us-ascii?Q?tcyoqBo0sh9DvHnmR+gVWoWpnJN5V2kfRLNF9NvhTA32GmYm59zZqkbk0+MH?=
 =?us-ascii?Q?/nSANQhy/FobaqrEPL1g65Wi6Fpiqsjx+sYzXiivD0HXADPpVc4WNQ0aSuNv?=
 =?us-ascii?Q?MrMTej0NZ24II+sE6GaK0YzQFpKrnfQ2h3uJ48Uf+GWVv3liBP4co/rQvHer?=
 =?us-ascii?Q?GF4+BzogL6v8LT69MAhLLqE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FC28920BE84974C813A1D64C32C0910@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VRLEr9Fjvnduge2OLrr6Fdsz9o0d8NLY+YjP5w/DVTLtwTQWSqdiusMsDS4hM/B7CTNzViJHC0pgfNaeABKQ9K+IeC4UAXja77ARiviy5Sn56+lL/ZLZ/6tZNICY9xMUe/wxQq3I21/pD39uAWaCxPfoj8cgBTL7qZgFOrxqffDAjKH614SveF6hISOkBUz15cd1JTvHScFxrmMbeewYb9gjj22MfHAtiu0anVFdA48EtE/57W9b20kYbk1hnAArxUFZ1J6FQl7D3vF1eeIgONAk6JAqjuqQmM2UrPkZUs55YOqvfSasH8Oy8/XF93oJ4mnegnTOSlKht9A10zcgsSOLp4s/QlSPCA7QF8GE8TYAqbgDqt/+wwQ5kW7SnHz1K8bqw/ApXN220FdpEoxTwf9Cj4N/V8EXtlYN1ok5kB+q/uWPpzYxuBtInbsD+cgBar8YWXaDBPWiCN+3C/9LT+eTVqe1cBve8rdYflifTDbveat9uxY/yPSrPzLqLCS1hO5QPTuy1QoV1j1IpeWBa71AQCHHfcGrYYiEgyBJLWs7GIib/lTmcCwsSEVokNX6fCpBW/E1uYncZz+bZLr9Lebm1FC8DXbNU0exb9U3bJNYLVVgu/GlGwiG4zaSua9G
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c719444e-7c86-4e06-70d0-08dd18f317b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 08:17:30.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BupRhXXzrJLn8NA6TBPDAswEYjsRQ+c4EvFdhzrkpsrmNj9Cfl0XGuimLNqWz++ZoZQEBXEjbXRt5djnMnRxhVb4/uCrUZf9TlTVwEyItc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6956

On Dec 06, 2024 / 15:51, Aurelien Aptel wrote:
> This series is based off Daniel's patches. It is rebased to work on
> current blktests. It is also available on github:
>=20
>     https://github.com/aaptel/blktests.git branch remote-target-v5
>=20
> The last patch adds a test making explicit use of the remote target
> support by testing the new nvme-tcp offloading.
>=20
> changes:
> v5:
>   - remove duplicated code, truncate regression in _nvmet_target_setup()
>   - remove def_host_traddr, use of eval
>   - fix shellcheck warnings
>   - cleanup test nvme/055

I applied the v5 series. Please note that I renumbered the test case from
nvme/055 to nvme/056. Thanks!
