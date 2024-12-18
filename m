Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468718A922
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517054; cv=fail; b=BqOA+zjbFQVYMxo81HIANsWI11V/B4c4KNHPAIUl2/Z8cayVSgW+ONn+EyPIm8LrZqPkLXzZdIcjnYX5TU/1+41k2D8PpF+r1C4F/6eEjZu7u92tO543b9qirtRUvTdLIUhvnjesRHiVJCjgGboz3KL+XaXP2pzEd+Nh+yrbNxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517054; c=relaxed/simple;
	bh=+chAHs8nPFAQiatiKctIxghqmV3hZoJ8WjB4gEsrOVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W65Gyz6cYVup2Vxa2AOhGyQX2EgCDZtWF0w63jUoubNcP2OZ2WmUSitUwlXvCTWPMUXb0hnaJvRPuuwntB6vWmxnz3D5dgAvWEcZVKwZVZPHpIrZfCHc4xfdRTFERjfTYxNgB0yHdbvRpE9a8sHygnzK+K+oSMEfZQJ7dBXMZJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G/6zpwi6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gnDFvMHD; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G/6zpwi6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gnDFvMHD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734517052; x=1766053052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+chAHs8nPFAQiatiKctIxghqmV3hZoJ8WjB4gEsrOVk=;
  b=G/6zpwi6aeLtqX2OxzQng9lycYpJeIE9p7HJbC9yQAh7CyolW3jKLnrG
   yKcxa6tYghlzIXt8ASDnp5ugJ+9hAPh5pxNKL++On/1ezzAE/XRpu9e9u
   l0zQflcMqw4qD1/my5tUJHJTjGq2H7l9Y0t6LXlDJzT6vIq/8di3dl+3s
   WRkrDhah4BILAG75W5FdGuE1DyutlXPNul4hw6Sg0ci6fmEYBMyvI6UQ1
   lNvIhWyi3+TCSvaUbYZoCZ6uQbBX3zWkVdboB9MNCG+V3d49iXLIfIn/O
   NtqClVyw5DG45wwiQZUAuVAQIMs3fGr6qrIM47jetIl2brL4DcM8cO36H
   Q==;
X-CSE-ConnectionGUID: MX2iMLLVSoi9fA9MV9xQyw==
X-CSE-MsgGUID: QAPngMwuR8m+DCw07WT3KA==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="33463057"
Received: from mail-dm6nam04lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 18:17:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWXjMkoz2+bGsr21tT75VPuDuStw87qFroea/TBLPKXBDv8vQzM2Xzm2cRT8fdcRR/KecsPBQW8P7v+L+2Wp4KMM6Db1SLR42yQd0n8tlAjyt65k0Hu8JZTKJG57LJLuD/QA5kSReDS8OjAp33MbCBOzjCuVXoE1nOMN3HReiyxPzCVxbVIG0gAo9ZokWpXqTWHWmdQWx8S03vS8SU4FzD6m57cYqYD1INWIFlKyIbXll2skizQp3IKPrmxCMw+dXm4rAOn6Ml5iFgJKbsJ7q1/QuLR4BAUsJsiSz0mn603nbkd3PQZD3JOphcHjWkPdiBfZbxdPie5GKu4rUt6RDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+chAHs8nPFAQiatiKctIxghqmV3hZoJ8WjB4gEsrOVk=;
 b=OfTDJvA8AzRNcOjrhYaFdVXWz/3XuCEzkTT8jWFR0gtA/nJ+9do2DYeu6r5V76RYw4anU43ysF/yrWFzIgRETjeIA21XWjOmYE/+35+LV7usJKGZvyS+fhyQKcXvNXSulhnws9uFHmO4nFgYutfwX/LPfnBI1Iql8a7xaKCJnkJ+xmWWZl+CQHFRj9/WdcdrgUvYx6fECvrDSj9+CIqkVbjoj23N9ML9QBkYgiZeOK87Uzoh5CwLEAB/mFuGsX57Oc9APe9sznikzM00bfuyzzBYdSuA79h81yoP2dxYxmihvznY+7MrL2hgV6Zmp0qqdGUg4Da8jvbLCf66D/pVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+chAHs8nPFAQiatiKctIxghqmV3hZoJ8WjB4gEsrOVk=;
 b=gnDFvMHDeZ36rMuz9aHq4NThIchPJcA9cg9F2rHyjeDhTkgeC8CAJM8kffwn4x/sBSsDhm3Z3X3RfhpwRUPdp8ty0BBZs1MvxAiCBlFd8nlwcaaCQgRKhXCvxaf3WvUuj5Wg+fvh1q0hVQKhJsS//D+XnuPQkys7rXLV1pPJ7i8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6698.namprd04.prod.outlook.com (2603:10b6:5:22a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Wed, 18 Dec 2024 10:17:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 10:17:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Zhang Yi
	<yi.zhang@redhat.com>
Subject: Re: [PATCH] blktests: src/miniublk.c: fix segment fault when io_uring
 is disabled
Thread-Topic: [PATCH] blktests: src/miniublk.c: fix segment fault when
 io_uring is disabled
Thread-Index: AQHbTTHNvRo4M4q1AkS+FYuAUGaM1rLr0aqA
Date: Wed, 18 Dec 2024 10:17:24 +0000
Message-ID: <57fglxl5mwxugcgj3aa3hkwdvmcfsfwdamlhd3r7r4fcfx75bf@opaflvrpqa7i>
References: <20241213073645.2347787-1-ming.lei@redhat.com>
In-Reply-To: <20241213073645.2347787-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6698:EE_
x-ms-office365-filtering-correlation-id: 0140de46-6d20-4447-a426-08dd1f4d2abf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?845P4DTR7xuxDNSAD+LaaKuPuBEYqzpIT0d7TNPWewTNWIVCXajXCf59gvFv?=
 =?us-ascii?Q?8YRwc3TOWVfm75XcswrTD6nj1MwrGwrUo0PVcsrz0Khg4TNz79xqD2yJsCTv?=
 =?us-ascii?Q?wcGvD1ndBClhBJ3bKuRAQMX1LnLTre+V210zhxrrxCvf0U9t//W95RmJJ7C1?=
 =?us-ascii?Q?jEaqrMlKTMCRpfk1kHwdtzhi4URdUl8S9d5ADECue9nhkPGR26RgOQ1ZsnuS?=
 =?us-ascii?Q?ZPVlehC6QqWfDQLojez9f5y1NcP1IRjOOjnoXe3R/B4unp+SnOB4jdz0XYyW?=
 =?us-ascii?Q?LS7bqsJjVKrNb7+m/DYlQ7r4ULpWQazqqsHZBqe+UvDbO7sgFQwtbKuO1c78?=
 =?us-ascii?Q?jvElNiUQV/MfnMeygogUDzIxUPBVV4YhHaSVH51DyjPyIR74kc+9ExHf4/PA?=
 =?us-ascii?Q?nqRjnklyOb2QJcJuaewABiI1q/mzICBWBN4wOeHkiOvrq5D6np5XBjXPwF0J?=
 =?us-ascii?Q?I8nQN2n9vepg5ppd9Hz8KKNIGL9L/u2CK7dx1Lboq/QiLky0qjHLY8KcsnwI?=
 =?us-ascii?Q?+A+stbWcAp/7Duou2UEmcz4trccExRXCdUQP+BRzwIhZQmWHhwet2e8kNoNt?=
 =?us-ascii?Q?MnMJcOSwKAsWYhe0qv4EfBWQwyNoR2d/q0dedeO8CbyBN29Yaxs8cfHfUI1j?=
 =?us-ascii?Q?i7eJli0VLGixtchLweNyPZud0KaYqDcSBhCUBl02b1/TzVHdNOXmiRJrqf2X?=
 =?us-ascii?Q?gE0zJ+B0rWr6YnE78Xb4fjLfHAJIEohX++vDPYcXvOkhXYwUbIV2TgJUIT43?=
 =?us-ascii?Q?K47Ni+Wpf9UOFjsdkLJBOmTn9T2DZcNJ3bxchehZh8DFCilKpUQZuT5/u08K?=
 =?us-ascii?Q?uemm8zs+TcHhMw3Du0V30wLKvQ24X4HW93SeGSkCrjCxO2XYzls0HZsufS12?=
 =?us-ascii?Q?+tl0C8EoYuLHRvIgW5vGMXE0+syTJJNUcAOQy7t3vDOt1+xevlESLsCf0/Rz?=
 =?us-ascii?Q?SuVXAsx5NMWJNYYiR/vZnVfL5x1wTwxjqjzb/s1DljechBzckUGQbZn0TLcJ?=
 =?us-ascii?Q?uefHbW0OhQHVS+CO6woay07XRY8YE40Q8ZjHDyToisf6KHfPszeE+vFHdDLN?=
 =?us-ascii?Q?7ThurlEIhqTREaqnUTHVlYVpsBfzhD0wUN6j7TzV/D05v+4MYOeGYEskV+zM?=
 =?us-ascii?Q?Ipn/xopaB7dtY5h2m54h7liglb5h1pDt89Vo5OSd95OjvyFUOcT9X2i9Tg0p?=
 =?us-ascii?Q?2COxaYDnQuhLnJabun1NpxKsXbwrs/OuFgLEwgdedNiRONAvh5MN8rHe25Qt?=
 =?us-ascii?Q?/ctic++DvivvoT6ccre7B0hGagSCuH1phBIIQXftVUvH5QVVYSGLtkgOv2vv?=
 =?us-ascii?Q?OOAYbEWhG/Io/J9iXmYNrqQk1ieSTnexrE/Qx1OxzcXCyYjk5jKzEITnwdkI?=
 =?us-ascii?Q?jsLkJaGW3UuO7/d9cHazapPgzQyCfXczl44zen6stCukzsmcy3TB+1JKiVY7?=
 =?us-ascii?Q?scXSuSDCjdl/jBawkBKgIij+bes47CC9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8vbi4o0cgP31s+XUVTqpYxcs4OUzkdh7kULYt6NtQmmpWER2rcfMZtChIgE1?=
 =?us-ascii?Q?3/sIrAlvehBRoSvpaY/yXInrIf4yfmpr6shcwNoGtdSBEpTKcteVBxMrbbh2?=
 =?us-ascii?Q?bf3FVz1wUsxH9HCj56mYSKpvhdllasKuh5gSkKwJCVzChbNj5SeFVsVQuVCc?=
 =?us-ascii?Q?t9bbVyMSsCs1q09C6pp9HTo0tGttDAOROZc48TR2Xnrn2uxEOHVlLyJzR3J/?=
 =?us-ascii?Q?JxHY3T6VkVMwsRFCmzxbU5rRrCsBNHtrYqjEOGxXkxWiM/UN/BVEKSw8F+4C?=
 =?us-ascii?Q?fTptSqTaUARrJ6tfw+H4oAeYONC1QUw/23hO6uIFz2s06cAa2BsxsLishe+Q?=
 =?us-ascii?Q?aoNxKErTBWKQCQhsS+9xD9JQVm/fF2QwuOsoHiVgpOtAtdd3Fw7vN8hugAQE?=
 =?us-ascii?Q?kreYgS1ogKZp4ud4njgmHXxXDJE3G3BXYr5gY0we5CdA8YpZAb6nvJR4V91p?=
 =?us-ascii?Q?kOnbubcI/BPjKydIVNSgixg0iB7LmJPO8WaQlZrYZPuWwKQps+SHVcL1ii68?=
 =?us-ascii?Q?381GMJ55wGP7XVYZHkVTgb/c1fz++N3n5xvo9DoqBWFhpxZYyG5sJrImTyTG?=
 =?us-ascii?Q?cZmWRaOdhdjNNS2k9QfMrJMcVldC4poYTEJfnPeAdk3Tp8priYwP9SV4cB2/?=
 =?us-ascii?Q?0fQFGGC4lpRUl810+/bO1q7wtZFAcffTvAaX2eY18Wh0P0X9NNIWoOrehaUV?=
 =?us-ascii?Q?oUHnpaDRKt+EaXdieFjhD9Rz3+6Yz9mN0RNUDcsIhvgqGEQiadu1z8RbNXgs?=
 =?us-ascii?Q?mN7pkym1x+IGJZzOEW6PsTcukXTZYY1BwE2VS/kNBE7DsPXnqvsTr6eLv4J4?=
 =?us-ascii?Q?hytZ6MQQXStvpryEeVlVTYOCA0SrQeINMX2CBsVJaOZqoJNlBHJGs39L/suN?=
 =?us-ascii?Q?pTaWQJJd7EMP+/lZZ4+CESTd1/V0rokkQxXkJXXNRPbLhn4Hra1MBMqPfoI4?=
 =?us-ascii?Q?24By5rkApOZ7SbnYGnVs4ShooiyNKfBr56V9kn8WOUy+KMCF6M8MrGHSQCB1?=
 =?us-ascii?Q?dE8JKqVMe5nP9y2Fz8Fz3ZhjIT8wvAQYhtOaktjTp5755M2X5MC9oijtQwVa?=
 =?us-ascii?Q?dhCxBmEJpp019tPDlD8IeILzab+WH91paQj2q5I5H2Mcx4DlEUr7/eM/4Gn5?=
 =?us-ascii?Q?Euh86zA+yHOuYxA5P8BGb313JmuynobiBTLlMOPg0XqylJZiWyNky5U3Y64N?=
 =?us-ascii?Q?5LBF7JtqIFz/AsPMlDaahiJ0cELZ+a8EhHDj0ylFTbaZqfYZzWVmI8pzU/tr?=
 =?us-ascii?Q?ZOmy4WMDcx8SgGDwbfn2RirnKAsRaK2Cvbo8f/h4P4LgVPQ818CFaiYUscog?=
 =?us-ascii?Q?fWt2DlQ8WUSknd7tR7Pg6WOOLJFY5oXFhaujTiUkP2Lw3r4EFrkNzJrmaYj/?=
 =?us-ascii?Q?V5W5AK69BmClQ/U4z7zCQkfZai/ogpJAEaLmeVOEERFA6DavshSjzembxihE?=
 =?us-ascii?Q?d0WvGfNIe9TXDPeVc12RMxlx766nz/UdOPrtiKjFpkG6W7I91liIqkbScxtN?=
 =?us-ascii?Q?n/pDaCAnAHGYUZrzwsFdw7KsCnxPW74l6zuMrLH2eDa72CTiJwpKVX2UZZG/?=
 =?us-ascii?Q?jHPl3KRhCUzbOhtULjWXvsmdg3IlAXOjvbvVtekCDnOC7eWLcKY73fMUP+p3?=
 =?us-ascii?Q?CZu2sz3CzxPJp6aVuyPFDlg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1D9FDDA386BF24DA48D77DA0291DF8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HVpMn2ZOYx8Dw3kJf6Rzwt41wrHqqP7Srb9huLWL9vNevqIwebYnsy5giyffLp+7gepMj2V2E3J1YmB/SyGY2++7t0Y3yq80ccSrJAPvjOFBSN22xdlGurBuQeILHiICML2/ru+CTml422bhCn/NcFgMCFfcW26HsVlHtkR6birL1NFZ2kjGAg8Fe/X+ODyE7ZIo8COv6o/tx4GA1Vk0S3ft5G7urzJHg+dw2RwAK/BpUov0IxH/k0yWXZICMjTqL2Y6eM4KLszr3NU9zaec50DiqN2C8FnDWP9rn3VCDgdJ7vXmszcxrClzXqNBqCeWBEPXUCKV2QXr24JrZEWa73PKRkYmE2boieYDbutWI1oTA5S/YaS0KYfhUz4AAYeDEUBFlBrF8F1WQTWOGJ0ixDQ88MEmQLKbA1Z+KPZKBiLBEv5+TaWlL6Tb7G6xMQJsHoXIYim8mHb7EEh/+HvyX8p3Kb1Xd9QwLugVALtWNCdenTUmaOmxPxNH2qsnkebYz5oz/3wyTHdzRWjHW3fhJ8zK7dLUglZQRa7X2btTLskabrUjrn81cHWx4otxMPIljPgqfmvDyExX1tqhW/bU88AX30mzlfhTdT6c301VEWnrLm7EDgx0UXNCO8Jq1Dgz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0140de46-6d20-4447-a426-08dd1f4d2abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 10:17:24.6201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6v8L7eR3q5g8qNKdNfhlebifiMiGYwWcnhVlGgx3VhMb0pxtv4xlH2/fZ71Jfg2sbS1aNmCfZa46sQSdVuSsae/4+JfkITNz0wRC3UNmMsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6698

On Dec 13, 2024 / 15:36, Ming Lei wrote:
> When io_uring is disabled, ublk_ctrl_init() will return NULL, so we
> have to check the result.
>=20
> Fixes segment fault reported from Yi.

Ming, let me confirm, the segmentation fault was reported in the blktests G=
itHub
PR 153 [1]. AFAIU, the segmentation fault cause is in liburing, not in blkt=
ests
src/miniublk.c. So I guess that this patch is not needed. Do you have same =
view?

[1] https://github.com/osandov/blktests/pull/153=
