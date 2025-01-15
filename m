Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2741182C5
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903799; cv=fail; b=AOYRvlhkXJopOzpATGcBnEpQO59LkKUpxLc6eioUDMidWepcs4NBDK9E7kYdtROVqQVo37MW2WuL5Sm96RywU72oy0Vzi1F6kBXdq9IXq40ZiEKKHlFJG07l6W8ZlzptoEwjEAuYhZWdVn4IOFhCoyJF5n4Zu4eExF9pKb6gers=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903799; c=relaxed/simple;
	bh=rY4P8CclPVA+ntnkVeSxwXswDcJXKjBrKljfB16J6k8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxLzWkaw4oLgENriu687uOgv69jxdBO4lCnhglhL0qeUrkkxWiGaXD+KXY228PJWkonWcOK7awX3N/RGzuopoJSAwbPRtJqbWlChuc/m0gSH4PBvbCpPkHmMUzW6OJ4kqg5gD69U/rybG0cOH1AlYynJMC5NARlAopzZNIUzsME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Soq0ZUvR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XRvQlG8U; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Soq0ZUvR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XRvQlG8U"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736903798; x=1768439798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rY4P8CclPVA+ntnkVeSxwXswDcJXKjBrKljfB16J6k8=;
  b=Soq0ZUvRmlHch1Jlm/pT4mZ/Zye2JTiUIfuPTCC/nMj8OGi9sENk8ihx
   wRaeo+9Ew3xR9CGz8V7cjzEkbhT2tn6l3xpz+E+oXZtM6PUehW1+y7Lgj
   FAgVnvAHrFgBA8BN3eqo+BIGfAlefEGXDMi3LtPGDcyU8WPGa0563haUq
   GlUlxqYgpFRFgYhMuwDiGzuwG3HVx9O0793qsaLhJayWsj+HpwOiNbnGo
   XKZtzR6j0t/LcWQ/NUiNlkASs0ayTVA4Twi86Ep47duVVz4BT2Om7x2Tb
   gF3E/9c4UoOc1yXueKhnDhi/AJzfEA7VrXl6EQViUMsOrIJOFJXQ8M57z
   A==;
X-CSE-ConnectionGUID: DCCrnhdXS56ANhQArr3P2w==
X-CSE-MsgGUID: E3VwLznzRuGjDBKGLAIctw==
X-IronPort-AV: E=Sophos;i="6.12,315,1728921600"; 
   d="scan'208";a="35945577"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.9])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 09:16:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNEgga0ToxmATCK25GcwyKfgX18Z78dgYgwcq9shvt4gYNbVKmcMta+42YRJWRQIIbj6RHYutvnUvE1YucX8aT8E63sj5X2OD1VEv/o3YZY3M9ABjtJhqSGVwwbHNITI6BDgER4P7x3uXNu9U94R29Q7UzhLOc0ShBitVgt9sri1hohp00pQLt7mpFAFCPK7kq70VpOh38tGeyu8Y5JOXVmY6lMVP1vD8k4IGBsXZ+xD4/ad2HxnXwP6FYDLG5Cxb+25UitwkkCx5kA4parJg5UussSVc0znVIgnhfwyX93q5z25RxEoCtrPGCeUz4tvcFBIXYomVctAoFLV7yEFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY4P8CclPVA+ntnkVeSxwXswDcJXKjBrKljfB16J6k8=;
 b=vfiiyDVFreGtCLbhKThjEHzkiud2TX5ud7pnkXdtMlIHh3C+r3jYqn8dj7ZALMUM3IN3CW/xq9QA8aVMd9YptOhCC/7IDfPo+1vEn8EOrc1yGvP5aX+zFT0rcPwCjpZzy+SWHTNijbSNr+1C5yQ9nqdWGtAVLbDUXAdWb7Fe2gzWGrWGEC7rxL9Pb3G/Jhfy3KnVh6pq2bI+8JuQfP5+s6gwITkl8R+YgWAAJXO7q9269/wX133fPPWBFWZGt9eqFWF5WDIaLadUcNS/6YteQ0lUP6ybM80GBPLaQmEaVGdnfvRyAmXee1hMnJeGQvcNri4w0pGy/XbdY/U6ifMR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY4P8CclPVA+ntnkVeSxwXswDcJXKjBrKljfB16J6k8=;
 b=XRvQlG8UHWfVN0FAOgkv350Yw0qw0u/79laf1xjti+rwOFxpYJ2mhrzVEHt0DbFHEbwqObkD3nMgQMR85iFD82AMxEbpBMnihVZBeYN1OKXQI7cICBIM9yS+EsEDQEKhz0JOwS9HuqPMgBWoW1QmQ9yH7kBigBNCoEvNtsuTknA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO1PR04MB8299.namprd04.prod.outlook.com (2603:10b6:303:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:16:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 01:16:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next v2 2/4] null_blk: do partial IO for bad blocks
Thread-Topic: [PATCH for-next v2 2/4] null_blk: do partial IO for bad blocks
Thread-Index: AQHbX/6YpoOUGCoG2k6H4HVr7GtbiLMXFjcA
Date: Wed, 15 Jan 2025 01:16:29 +0000
Message-ID: <yceba34vhzfmhpn2vptq4uxdons2smxyxpabni7u6mocx4p2gz@m5lz75dztets>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-3-shinichiro.kawasaki@wdc.com>
 <96ef93cd-4555-4fd8-a1fd-8016573f4162@kernel.org>
In-Reply-To: <96ef93cd-4555-4fd8-a1fd-8016573f4162@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO1PR04MB8299:EE_
x-ms-office365-filtering-correlation-id: 42ff2ed0-ff32-4203-7fa0-08dd35023d4a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ogL27oqUql63aDb0Z0md8woe9vpwhnorNfXjJhR0ZQJukmebR0VpisGhPXlL?=
 =?us-ascii?Q?Vr+fCsbaZOaZM1VPSncqgoZTMvSsjmY6bhN6NtS7PERrjO5+s8dq+AUwnB2q?=
 =?us-ascii?Q?jTQbvEXfmVGWptV2q1ILXhOVZSpKHWbamQPMYvT8gCOjNMqX/tNsU2DIt1O6?=
 =?us-ascii?Q?f+OTb2vL7M4eoDHrLEUE9GPiz9eRhfmhNQwgu2bD9O2969YchGOTXGqYfvoI?=
 =?us-ascii?Q?VFk7CGBo1W+tdMZtDWAJfc5WO6+fUjRZdbjjPb4QdI+QVd1YuFoRAV+/L5oj?=
 =?us-ascii?Q?rukIMBGUAkgmOEiTu+DNP3npYvbExLLEKM0nxmbkqnyn5CdkajBx7UXOs5ir?=
 =?us-ascii?Q?SQdxD4kQycGLMKVG+zDsJgJy9AWec8f1A7w+GwhM7tLxth2Iw3089ThVsvn3?=
 =?us-ascii?Q?lN4Qv6IPYh3FDzFaGWSrcy3WLDn4OQhS9R0afw37xOY4NVLObJFe4Z7pkygx?=
 =?us-ascii?Q?LlL7ofrKv4bJmhQGLGgY/sSKahvrwV6p9Nplpx1kCTAHa7XrKy7OqKCEwoBj?=
 =?us-ascii?Q?JryvPQocEu3K8NaVHHIn5ZGZro0uILatSMj/fAp0/z1Hr/I8PdfG1ZFeMWTY?=
 =?us-ascii?Q?8jmn0z2eo29shminjE2evsNN103IUMoGFIxg3Ac7AWHWULuRk148F4Zb0HX6?=
 =?us-ascii?Q?R+2M5YGToX929KNj5412dtLv8bVv35ZC7kycEICjU7GMLXJ3yFoY4yy3H0It?=
 =?us-ascii?Q?QlMDpO6uopH0ygmmBLg5eFEjVBIq0BBFK9ov2zLLAsrf+d+JDvuVh6mOCHxJ?=
 =?us-ascii?Q?9cBhioJ1jDZsoua1kEcD9KaIPX9vAtfDHJlvnj/FyCm9///SZkkyp6lw9xKJ?=
 =?us-ascii?Q?9qTsPf6YB9s+cM0Lmr+noN/9wqaD8XnUQiC/UyBdViLx9XaxMSSmTiO5/QSk?=
 =?us-ascii?Q?m0jTmhF2eAShMWc2TVWEJo3g6TYUkQPL8pZdYygFByavw0/3vhCg9fKlxT7d?=
 =?us-ascii?Q?3vMATDaCPUJilGLp2sdGRVA66gwkMYtNkEbJIG2qoi4RaN3cYBMd/7IQdPSZ?=
 =?us-ascii?Q?9uGvnGnYWmwHCoc6BzKWEbFJdPRqgHMTxgfQyuuyfOddnYUd5VO1pEK0wywm?=
 =?us-ascii?Q?356wHzwRoAyWKiaEa6BchQKSlgLiMwXc7oto74nt6HOBWBv+9uRv2B6eJlU0?=
 =?us-ascii?Q?s9+WcXrI56c0wGFEUE+qfCLwfJpaB05jaFwpLJV5wVEKccxjGtomGTAKnCdF?=
 =?us-ascii?Q?h+X7+2tYiTYurORauZOhvXn2ZnP8AXUGAsWEck03qp+0lUgztOHee6NJuK6w?=
 =?us-ascii?Q?co7uj8/sqhDNGzsnQjz6DOyQZjEV85WWBkgFR8ryBHPmvWPbHV/mEFKz0/dz?=
 =?us-ascii?Q?KsE9nie46d7Y/oxNPPUn4o+btXRHjI9cnVyjNGbvLoZvt+Hu67VOaemMS93P?=
 =?us-ascii?Q?AQ8m7mhhWPOod4NvneW+vvn3vyjgm5pibtnl6N2fTIfyI62p4QN3DqCaoSJ0?=
 =?us-ascii?Q?gh+95N+CWug+vFLHs7aucyrsubbALrjN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d1PSAmoZ/9WrdHuigA36oeRhxQmHTCYcX3FG3xdTNK0NOFXlI7bDT20riZxU?=
 =?us-ascii?Q?tvlmvlV4jdny6/e9TmaL8aGqfj+QRdOrip/xeUKP9G5B+ZDOLhQ1XcUQPTKn?=
 =?us-ascii?Q?Q7yxAbqGGfvpeTenJRVuRkbrGnLB6JXR4CPEE/cdSeZ/anA+bHcikgrGJJPT?=
 =?us-ascii?Q?V17xr5uifxODnAs+XsZLlTk6awvnczk3zCGfhb4FHrHAmoEuQaCHg0Ljaut1?=
 =?us-ascii?Q?+60aLdYS2KG0EtwESkJXP1kmPfNNBXzyfxu0dj4lQffisBwBP2Q6A6RYZJxZ?=
 =?us-ascii?Q?3OrFCEKJTr2fKMcpQ6lkpog19HcctLG4mXxgb6L9KCLMyqtIOjh32f+P0qGN?=
 =?us-ascii?Q?TXk7LxkjfvBOSdN0qqFy035gqWHUTCa99uL83Lar7k1vCi1bM+TR5mRzCBzC?=
 =?us-ascii?Q?gPW34D7QwI6df2JoLK14Gqe9z6OV2/ITXeW8alrajYmSpOtS6brW35leDAdo?=
 =?us-ascii?Q?7DyzoA8/9TP7lnF8Zepys9RGOzfedFym82rszYB+iwp288lD5bBuwVsRT3l0?=
 =?us-ascii?Q?q5yCv8Yv7x9teu0AxcpGlSM8UawpS1WsCqxftEWFIDOYGulloj+f/Zmrpohb?=
 =?us-ascii?Q?QJINufkyDbr8/8u4b2AtLFO06HWZu16hUHErGPm8tm4z+VVRzgDl4F//a3Vh?=
 =?us-ascii?Q?6wSz1eL71x9sDbuJdRBDkHRAyo0t6dACZSHOk1PxxFctjOa5FyYkq7BzCMne?=
 =?us-ascii?Q?UZTTw1NK5z1TyFTPQ3h7Maq8pN03fXZICVUyntKbhoxm93RTS+fKEjxJKNp1?=
 =?us-ascii?Q?c0g0lsgR3adNs94xGIjo/Qy4URb/BogVIAmg7x+SJ4srGlulyYaB3zWugcmu?=
 =?us-ascii?Q?PYJSUkWoGNb6qXXuNQJ6DPKhdA6YZGyHC3zLjjWpER66f2ZuDg8CV7pso7E0?=
 =?us-ascii?Q?MNeBh0UkmyHtIJu1PybM6hHj4XaHQ4rJJeETKJ8JfAJ5SODGh6DGaRsgy7a7?=
 =?us-ascii?Q?YA3b56LNPt7rAdcLQIFeIHzCxjFzp7DdRdPhByTgSaGOrQfAUTJyvvdn1JLS?=
 =?us-ascii?Q?0lXTb0EO+Xg7X8PI0FOFRJ9ZbLwHY9K7ys093XvHFSq7ixpGbOQ+iUmEPbqa?=
 =?us-ascii?Q?eAGQYsT4h9FIfVcZTUgfiYiNZU7QyaalgcjlH0u8YV+7GXHUviBWNr/Hwktz?=
 =?us-ascii?Q?DqqIfRkS9bbg8tP0Z3Z1FdH0XhUQ4fBV9oFsPQdRkeQ/MvKasvo3u+1BOOnn?=
 =?us-ascii?Q?wdYPIqh7vVLLoeSgq1QSGrl7Oyq3hvjXskEFq9wJTVNUceuSqSbPfBp1uhBx?=
 =?us-ascii?Q?5Lh/d9nHefGOCoCc4Y63nnjue6JszKjAz++s7FFOVPRdCBZcrIC2p4RoZrya?=
 =?us-ascii?Q?kBcQ7o4x45GnLk/zcNCPp/5JVVQ2y97lOUiUssA8A48CLRfD3gEzEmzHJG1F?=
 =?us-ascii?Q?P6mwkOSGfjF/62tUuoAD50cq3AIu/NTDCsjfVCIAdbnpWcTHIpDv2+l5hwm+?=
 =?us-ascii?Q?5B5/bPtciHk2Q6J+LsxgU82U4sHanHPAnxVVvl0zER7wXVfBJnW/knYS//qg?=
 =?us-ascii?Q?LXU3N9lsxYe3++cgBrhRj7KEhTxjcNCgvvoGtB3LYleUO1QxQky55EJzDBPm?=
 =?us-ascii?Q?OTr531XFhE5CdnPfZ13cr8Yhb4qXBuACBdZkQjnZIenuTrtRNiROX4ilA1XV?=
 =?us-ascii?Q?ekp9ovdbrPMewO3gaMNMDb0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A27CCEE184FD341966DF742D09DEE24@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ky5SGCw2q0dkReUQRohyEOyCwSxPVmVr4upXNR2XPq8G3O3BC1xJKnR3OQSb74s9/dWtHMucgwkTTpUaZD9b4PJJxKS3C+nNK09H4ELbn+AfxIv9xMhHTKjJCQFdcc91T0cnBwCPSviKap+BT4aEK/uolGLQZA+8RhRrrKBSkWLxa2nYNIveoUlxjFzD3TQ8B1wGFT8WpjcStvsxtgrmzb6Rn+2ev+Qv8P3yC5kYGEOe4IDgWT7ho/9UWFHYPN/lj67A/Bwiv4b88n4vS2OVajziEyEArBMkOojl69vGIzvLJmuKRR8mV83XoIXmULT3JFdE+m5Jjw4MdYNFmq9444Jjay7iSZeS+99QWF7xt5rL1HjARaZfCsDIXpUE9P4/9FHzeT0zZZ3xy5SBp1IdJgGljLqGVLGAHoOObfacEJZUHmhGYrNFM2NyrflMaaMJzxk2gIBiV8f1FZAnmKl1aG1GF+8OG1drBGvQS0ORa8qMnHY0luyLuP8jFkp/0VkyqX6Bayci5GUrQ735JZRQqRrqwwSdAmPggB81xYmjEZ5kl52BUkxjxjSdTOM5NqS2jl7E8y6EUD92KMrcsWnQm2lUmjGShlfImTjiAfPAjaZBCkI01WVXzQ8aJphnX+cn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ff2ed0-ff32-4203-7fa0-08dd35023d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:16:29.0748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hu/RyaRTaXpmjK8Q78MKIKVLtGoYYvzhU71KEEHhUQvkgAf0yIa+bexBsOg5gXR3fXvj3q9+S8a9KSQ9FbfuMllTVAlpYgQ6EfcuBPmBUG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8299

On Jan 06, 2025 / 14:47, Damien Le Moal wrote:
> On 12/25/24 7:09 PM, Shin'ichiro Kawasaki wrote:
> > The current null_blk implementation checks if any bad blocks exist in
> > the target blocks of each IO. If so, the IO fails and data is not
> > transferred for all of the IO target blocks. However, when real storage
> > devices have bad blocks, the devices may transfer data partially up to
> > the first bad blocks. Especially, when the IO is a write operation, suc=
h
> > partial IO leaves partially written data on the device.
> >=20
> > To simulate such partial IO using null_blk, perform the data transfer
> > from the IO start block to the block just before the first bad block.
> > Introduce __null_handle_rq() to support partial data transfer. Modify
> > null_handle_badblocks() to calculate the size of the partial data
> > transfer and call __null_handle_rq().
>=20
> We should have an option to control this behavior to be able to mimic act=
ual
> devices. E.g. SAS devices may do partial data transfers before hitting a =
bad
> block, but ATA devices will not (it is always all or nothing with ATA). T=
he
> current default corresponds to an ATA drive behavior and this change allo=
ws
> emulating a SAS drive behavior. So let's control this with an option.

Thanks. Will do so in v3.=
