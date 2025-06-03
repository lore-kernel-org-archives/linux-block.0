Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB723221DAE
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948003; cv=fail; b=NWlOP+eBpYoDfbbSEHm0rhH5F5DHfZCPwHDTPuYa2wOX0WXd4q1um+FccjWjh4/E06wwCFwK2jVhgdHOIvEfDSxBCGnABMQzvutipaIAZd/QzWs1FhO8Ol5enRn2hdCsQ6nqyuYpkj+/UEdmbGu6Ky71JpCAkZzhq0jsLP8dvN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948003; c=relaxed/simple;
	bh=XFhLmgtVGtZn/Cyrfs2h0D9XA9ZO9b4D95I6eOKrjoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RkFos1Wd2XVIW3su26TCAsBvrLkQ3NsVWijfkQjCbF9xiZth4+4uM/zBzMDb11G6odPk+AlnvUQ5HbROymMYNAHYJ1go3ZXJa28VruYtgYtwZoalGd9wbbIuUobue7zXxFveiljtjH/R/ridpQxqHO1vfZIakS6S52N4CrGyuDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fsMG+XIQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hS+5Qx0r; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fsMG+XIQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hS+5Qx0r"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748948001; x=1780484001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XFhLmgtVGtZn/Cyrfs2h0D9XA9ZO9b4D95I6eOKrjoQ=;
  b=fsMG+XIQEnqqhyXOB/qdhsC4OhtiTlG/ByK5RERVdb2PuYdmRhwa62+c
   jDDc0uTaMgBOpny74O3SSqWFWs299ore+NPUrwbn1DdQXLlohHHBpk9zw
   rRWyMfvzKkYQVzsnKoI9eNEX3bWq9GMgtgWQDoWmHypTL23ptzvULP2ga
   T45DZKY0hDb+aagPEyT9czCLohd/daMM7ypcU3Dt8MtkB4BTb5cM7zEfK
   ETlpKdeKOpqn3152b43JwDUlg8a50Z6j2Q7Y1h9f10uxsTDrLFzCH8Zng
   QWwSWZDkLEROnq/crpEyCZ7j6yOd5RVbZmh5WHT38dkpSTsYKibFxdrUa
   Q==;
X-CSE-ConnectionGUID: NRKO+pFeR/OSLCk44VJQvA==
X-CSE-MsgGUID: 6gDXtRA0S7KebvoLD9zwvw==
X-IronPort-AV: E=Sophos;i="6.16,205,1744041600"; 
   d="scan'208";a="89880887"
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.58])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2025 18:53:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7TXRstUJq8lofcg2dY+L/Dp/ZRKAiitvC1fdzCSvoiuX3w9YGwJxu5MC9BCBAZvOI7GLWtIExTXjVMg/irfy3E5f+BH9rIf2XdjV9vrzHUAHsyN+WZqEfBXsOwa4Ze56NJ30s75oDFiCS4pnzlkNLk0DF4Qxq+M0FxGOy/L4e36kgqHxLve5tuALCsY4ssSDbinzY4t+piOkePxI50BHM03su9R5DkP284P5allMZNewfVbc/XEfISCdfMOHbw5mSPI82q3XiPKCqCoIBuQjgpZ6xPiWqltsr344nrhmA8hLFcnJ5wG9PSYV6n3dQTv4P5VThk9f3ZuFtnTauQFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDaqglDE1/Zqeu+TEAy43ldFsErpIGxz8AVJ4X3Xmf0=;
 b=n9iEnOI43AMXv5/tdQb8JK/MRhCTC1gXi/FjIcgX9BlDsRJIyNJs2ZcrOuUvH9G7SbIysuDwt8FumlCsSA2vxmrzm3uThZhz+qQWjnrH+u2fQ2uB6c+8GBgmKrplPg6y7Uyo2BdlTkM+SVNEyaPEoOvZu/VAhsw8OI74WR/axKT+PEZYyXHsc+kgXA7OlIVfljxm3vFa9X63oDm1o72xs7bY9bhpmrYCrQWYRNvVItQI23N09RNrA4aHlWo39W6STkHorVkwrx26Z2yhUlNqOrVLKACh5TR/8VOTBRBxbIhKpDxjjEtNmXaa3BHhJLioigj4bDm2tJkIg0cnnUpkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDaqglDE1/Zqeu+TEAy43ldFsErpIGxz8AVJ4X3Xmf0=;
 b=hS+5Qx0rLW62AIOc9JTTkDbj4EyfRNhUQzpSZ8fBDTL6xiv7ZLC9+mN0s3GHqRu2cXQBRuR8qTSUSU1rN4OVE7jXmldGw8sXpO8NOYx3+G91w9VxASeafzTZIJmNtsM2aQXJNk960yXwMDv4ms/IWDGI66Kq3iutFGh2sWGj/SM=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO6PR04MB7505.namprd04.prod.outlook.com (2603:10b6:303:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 10:53:12 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 10:53:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests RFC 1/2] check: allow strict error-checking by
 "set -e" in each test case
Thread-Topic: [PATCH blktests RFC 1/2] check: allow strict error-checking by
 "set -e" in each test case
Thread-Index: AQHb0TgY+Y0axsWXrU+Gyn77z1vAurPrVIOAgAX0cYA=
Date: Tue, 3 Jun 2025 10:53:12 +0000
Message-ID: <2342ymnkotc2dxbs3pjotaaoa3s6sgtsgxdwpyvfj5wz7h26lf@4ubgyhtdgt4j>
References: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
 <20250530075425.2045768-2-shinichiro.kawasaki@wdc.com>
 <0d4dec4a-7a47-459b-876e-d9e3c4d24f55@acm.org>
In-Reply-To: <0d4dec4a-7a47-459b-876e-d9e3c4d24f55@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO6PR04MB7505:EE_
x-ms-office365-filtering-correlation-id: 6e04fcae-6138-49d7-0652-08dda28cd5fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZyS5S7CSrswWUOkNFIrgZtWVkyjt8RB/6hbwDMHK1sRyFBXvaeNLaiabiFk8?=
 =?us-ascii?Q?/ljad21ZjEyh1LsLuLzqGozMCi/w4FLoIvMMCCPsRn8HHLmLFe9I50No8e4k?=
 =?us-ascii?Q?+FB2nlKV+zvxJJeIzmkE4u4NNG10Cn/gTIFUerk2CqNFSJbDsLxZ9aufCfFZ?=
 =?us-ascii?Q?/xVSHWsJ5gqd4170WumhP/GYLcHF9PVrADfX5aapZp9lS7/jReCmsg3IPFUL?=
 =?us-ascii?Q?XV3lMQf0l9vE+vFO9USMHjvFxfb7PVIQdKZRzyVNnICiPDQnTPsKJoOYtT2K?=
 =?us-ascii?Q?Q/8xwLpfFLKzIYK6Id4cUoRtARViLftOoXMJcapXtHiDeme5CXw/Lihmjyyy?=
 =?us-ascii?Q?hzsPguOO5Jk5BII7+GfTLwt9Y6hepXCJ3tO9Y4pXOV6OIkObJG7XWR3K2si2?=
 =?us-ascii?Q?wX0uZ5noDuLOSMr31D/0NU+h8AbK88AIYa/gHfrebH5lwzZUcRPL4b2LUWx9?=
 =?us-ascii?Q?juzG6vl+jIqhFXfXxEf2Lcv/nPlEPFTTwGxfz7OLO3outm5Z5JZ5ZOF/t56T?=
 =?us-ascii?Q?HAlX4oUdd30D6jSt1aKMkgw8foz+tD0SfLEuZTeuZzRf3uM2T/9H82eMRTO/?=
 =?us-ascii?Q?kAbbE27SPklIghNH9kJVwTFE19yMIFV44DdO1yyBLPpEY7TPukfUsKaVvAm6?=
 =?us-ascii?Q?+5ZrIw2HQvsp48kxKvC4x6KDg9NjQ+vUA7kkTOvEHW+Jwd6fWzbiT7OHF83y?=
 =?us-ascii?Q?XH0bnn70q+++rZ1xySs5UiAOHgX4/WXh+pXzx+dLBFErqwkissLx6VrakiLU?=
 =?us-ascii?Q?NxCar8nY+FwwN9460d0KjNj6mBq7vz6PUDmLKDvT4lWH8PatcGwv9F0jB13Z?=
 =?us-ascii?Q?KeZzX+65KJlIDNtwKtnw/5RGVmgve9ZFWnDJ9BJHsbQNcSp/UG8ctgZniF0W?=
 =?us-ascii?Q?+kcRKcNxtzYNpflGksP/e+E7dZggR+W8yb5v3bcMDkCwnagYmq9xmS7R7t4Z?=
 =?us-ascii?Q?PLbtLCjYkUXna5THTH/hnvuWnb5mwNWcJKQxOi/QpHXYTngF3pNI4oU5Spq8?=
 =?us-ascii?Q?KnRlJszjYNYshnPYb7B7i57xn3HrbsK+sQy88RtJ3tpL5sHU49heWIBBYujq?=
 =?us-ascii?Q?Fu9Pj9XWCgA8TMUUJ0NP57LbzRN5jQai6wpNVVoDajCqLWkwnCxTmZQj5dd7?=
 =?us-ascii?Q?B7Pzq1yshGQv2DjcRpsOsKx6rnXYH56fkUCYWo9tk+I9Xf6CP95O76Phgw18?=
 =?us-ascii?Q?boxh4Q3Lw/dHAQCiQ6LTzgygZKYP/nw5YfiTif6OIMuGj2LDQN7kLugzAI3/?=
 =?us-ascii?Q?OTaFGqql0QBrd3x9vKaSPoB22U6iomNXBaKq9LEmwr/Ba6egojPrkEOjMhFg?=
 =?us-ascii?Q?MIF+it/Ji9oPq1sua6er6bWs7Ageu1wla6+bOYKE8PHXwnQpqXH1TUs7QTGg?=
 =?us-ascii?Q?l0/PR3cs9Ph2NpPCSQaYSDDujDyXbFTwxx7g/sJOtnsCDQ63MAUrZQ22hCYb?=
 =?us-ascii?Q?qSnlEwXpGPqq7tArFEPRAdtGN8dtWfKN0oP4kvTCK9R/v1i+IRVizR6T+k6g?=
 =?us-ascii?Q?FGOoxA+q3ebRJNo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?23Ke4ZFeEHOjBHxSoW2aEwFYsmxE7tmteNEewmoZi7M95y3IuZ0VRGgExOht?=
 =?us-ascii?Q?1CMcBF66SfCBrbT9onIH2hpV0WHdRj1RcEReYQMtYA4K7i8CIZnv07+yUb8d?=
 =?us-ascii?Q?WRSjW8xRdu7moGilQLy/y77S++2bh/UBH/Nsl+q9PWYfxsZxmeC+vCcZXUiB?=
 =?us-ascii?Q?Jzr9KLikefGLClhGA+CXERiPNCGjtwARurTG8QV9w3xyPZ77HmeX1hrlsYjD?=
 =?us-ascii?Q?0YxrJUq4YLqZAyn7Lu8K+9EKDf8NUNAXmSFlxxsk1LpMjFkyXuif4vJCrkyJ?=
 =?us-ascii?Q?+7DBAPrFQm/F2YZ8HhUH1WfrLiQNSzW4KjzbiaCZl2jpheFLh+d99GmvXH6O?=
 =?us-ascii?Q?i+2npczmGgC5UVE+fFB5XiwYB4xmQG2IxHa0EE2dtsRvLG/e84SQPiv8nvEt?=
 =?us-ascii?Q?gE0Whu78A72xE5XT/Z+KXiusoQ4TLQmnL+6tOoffJTnFcm33KzMBydeTDfO6?=
 =?us-ascii?Q?72ZTG++puOeQDE6GN3Ue/IiRDIe//CAMC15RdUqW3EePJ1XBZ9hhRSLWzmqM?=
 =?us-ascii?Q?bg9djcF/n3QvXjq3Wy1HRQegs0B0/n22GbAl+rHt/vn+egrmCYqy2yobJNQc?=
 =?us-ascii?Q?SHj2vkc6Hb2eO/HfCGoxl5vHhfe8m0zaHe8pZTKRkREuj2Vm4GcARyzxUspw?=
 =?us-ascii?Q?9LhXKooWU0mbIvQ3xnofCNojNtVkAtk6GQJQeesYnmEQI9kNGcqhmd6tgvSO?=
 =?us-ascii?Q?Q5da6DWURabiPbUyJE97JhXR/+7/EPvQT33wbLeVI/VZmY2DQFqRXsCn/b1r?=
 =?us-ascii?Q?LG2MOOdf0WmdQAmPyt8Oe9bQqlRT6xeTifFm5rKQPlvNlSOrxkisUqhfw4oB?=
 =?us-ascii?Q?8IHSHsg4wD8p3CMDkGw+7qGb6ws3fqPlsDAWHcPnPkTtrJuFdTehPLNgDamq?=
 =?us-ascii?Q?6h+VZh/23DNNlf39cB5dm4doDn8Zq1lWuaDqHbwL1Rlj5ihIdA9hSL6GuFIL?=
 =?us-ascii?Q?lNYEVVlCpXo9/zd+NnJeKc+J/gl3sCTcUBXw1d9lxMmWdPMNeoeZiYtxTh6C?=
 =?us-ascii?Q?e/2/PJoibn+Wl4DelFc1iIuidyNLM2UL8u6QgS7ic2ogNz/VxG2VeMUJEZjA?=
 =?us-ascii?Q?1r4S06nb7JdxL1b950Tne+WNfsE2gW4t8ia3UKaBYR2rJDbLQbPHaXFTgAaN?=
 =?us-ascii?Q?ERfE+ctRnwOiYivskdcCn6TPovTk8fJSneIVqWN8tKqcfn4IX8H1tpBhrHNv?=
 =?us-ascii?Q?YR2QGMASaVGoFXbKDJbxzW748Ur98tJn/Gagxt35vffey+dfV4WHKHGgEQNt?=
 =?us-ascii?Q?ubcH40ERQewsqiATfbcFEy4T/xhpNKpiSw7iW8Iz3ZNHnlsK9zFwcTbmRm5S?=
 =?us-ascii?Q?EveYRoA5d2RTjFowATOSBvXak7GqzxFxQVc1wIls5Uxqha92P9IqRNUCBv4x?=
 =?us-ascii?Q?Xcu6TFAOq9/OZ2Vrav+BRMr+W22OZi5C9n0pg/wSIVc3a3JnBV2abb0TOSiW?=
 =?us-ascii?Q?sN+1CI2hfvBu5dqgXzuE1X/N6AHRjc7/cxcHBg15aOWm7DR+wHcx26UqdABW?=
 =?us-ascii?Q?QRqi1o55Ry/T+kC7YLwpofMYQ0bzuWzI2RTbAOQ1eiwDMVDvYzuum+UusPHS?=
 =?us-ascii?Q?iRKLpySuUO8rINQUJONjJcQZYOYVuQMqaTfnMUozqu+nf3B3FTvatuS9B7yB?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFF6660B30DA47438F95B39C01FE2CA2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r5bsOkBsorEiLj9PBTJJU15IEWQXj8BgZVZb/Nw793JEyTYROYvXUi15dUpiIc+f4jjnKgL3RnyUdcahfbZZ3la55BzMGkT5w5GyFnOsyVOAuejNFjNdbk5u7n9tSnSyj/nOpqqfp4ls+9CROfN6w5uYlywGiCoEKWVLcWnV+7VEKVskMjWmNg2Qq+s6Gz6O1M/GstuZ6p+jL29oXbUWc6ovylMzHbOODlgTY7h28VZXmR3NexdYtgJPRqJ1sks2iO87yLF9cuPvs+0dsRxJ+1XYfbytTw/3b1nWF/9hEJ53bZS0APihYBR4pkqPglkVJ71gkWrBXl6HYESj9IfQpt3cQdqlCa95GtcNeK6Si6rBYgyh2bVR1FTiA82ugMa1pnjzm16Osta6qZBeHZK5jFHNu2zkIcMomnTRWriBDEle3MiMTG0fXpkFkHB8IM89F/6fFN8ernbR7tYjIazH5+gUdBGe9MLm2u03+YzPrFO6jjoKJo84R7DdNRpVfRTpfMCb3ba6QIbRQe6sM/ZvP8mHyYXvWkKqVQzWvJTitKQp6878HE0+uRvlAVnXh2ssZ2CLZw8putQNUO8aQqgu5hdVf2T4kNPG0FNBjTHK0UssyoHszjFu+TVslItCHyjU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e04fcae-6138-49d7-0652-08dda28cd5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 10:53:12.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8++8mplJz03IpS1wkBCi93S+z5yrqciBL7rhS+KCUwG7poaKU0cPQ3/LZbU8ku2E9qGVmafubVGiCSs4T8pLUEFiOPWk9rrjRBK2gRWP+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7505

On May 30, 2025 / 08:56, Bart Van Assche wrote:
> On 5/30/25 12:54 AM, Shin'ichiro Kawasaki wrote:
> > diff --git a/check b/check
> > index dad5e70..3cf741a 100755
> > --- a/check
> > +++ b/check
> > @@ -502,9 +502,9 @@ _check_and_call_test_device() {
> >   			fi
> >   		fi
> >   		RESULTS_DIR=3D"$OUTPUT/$(basename "$TEST_DEV")""$postfix"
> > -		if ! _call_test test_device; then
> > -			ret=3D1
> > -		fi
> > +		_call_test test_device
> > +		# shellcheck disable=3DSC2181
> > +		(($? !=3D 0)) && ret=3D1
>=20
> These alternatives may be easier to read than the above:
>=20
> if _call_test test_device; then :; else ret=3D1; fi
>=20
> if ! { _call_test test_device; }; then ret=3D1; fi

These do no work either, since the _call_test falls in the exceptional case=
 that
bash errexit feature does not work: The bash man page notes about it

  "..., part of the test following the if or elif reserved words, ..."

>=20
> Additionally, please add a comment that explains that ! should not be
> used directly because it causes set -e to be ignored in the called
> function.

Will do it in the next post.=
