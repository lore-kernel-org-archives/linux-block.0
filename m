Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793086167;
	b=z9/WWkXM2JbAwZlMeRkx7kP8TcT2XtWOz4jyBHGioF0thwuN4WXg2vpG76CtmHB/TOpZ
	 fSbUdNA6XeiziZBUqYa/meRnItpX+g03O4qh2YR2tbVbnbqUTKQkUOwxcGd5SQEyl3igC
	 cpZV21NlJehtabO73xVm0uDVU9HbokEi2SsU3GJXTE8tAjMWDXxLxeK+qAAOz0cFUKGdU
	 omJmQDn7Um4PanHicJDFp765CI9YFdfUPqG7jWqjqC+SFyZs4mI6dhvBZ0Sd5c5YtU3KY
	 Uw07LbYzojtR2axPp8tTPPq3WmTGcStFYmIt/eHnfxQcBmno8PC22TorOU6Rzqh2zrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086167;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hGt4dkBcZh6h1ZAlfe19V9vzl2UGlvz2npQhuo4CkV0=;
	b=Ztdnp0D9Sh9OrJD+WLE55MmNkTc4x2B1aCgsQSfI5xa0fFOYayvxdOCXjT7LLJm59etw
	 v8khRVi4+Gr61DDGGO9bgVqPz4V+NwHflTY8Z5e9fSxl3HYoFEMrBWSWzPUUK8vFmoMjY
	 8n28feN90vIJNzapi4R7lgCwgJAdLFQYhzFXsFTC2ncqqFMCisBrsAyopSfVx7NgnkAzY
	 h3n0yAv97jmGEQBE0fT2KUiKxfzUuecvnhqU4DQq/25zEmI7sWOS0rtVwRfvjdmAhVP/6
	 Z4+VjjrsnraN8MQqPddvb7NNVuzF3q7Hc3ZRMrCTuBPd1XinHz+75SVCjh2SppfiYSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=i9nDgGjm;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=YiaYdikr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240B606A31F
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 07:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D240B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=i9nDgGjm;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=YiaYdikr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793086167; x=1824622167;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aJak0LsYnVdKgl++v5BrJVkZstE/EgzwzrltReCJ9ww=;
  b=i9nDgGjmqMFzzuEAHQmaMxuMKQrzJzvjYyhFCjJxAwnnyjw9FDnuYIgV
   53I4KNiB1IxkgPoWeFSK+zxWKyUhmwQlXsHkk1M0xe5R2TGF5S0Es8K9I
   iL1a0n1eK7M+O9tv9K3DSdEDylQaapWvzDq/u13r8WcY6n+7pul8Tmpf5
   nFki9cZpWLZIf6qqfxtOqqlK2bppGKEUVs508orY9uIBvEbadr25hAb3a
   U5NXsdeRyKZUZmQmkRfWy+oUA9i1tbKc7Gi6mY8oMJQbRZgM7rA7YSJ3H
   OCGf6o4bBkRCWdBsd0YM9cR6JvRy9dXc7RX8s253DUGhHhrmBUDjnrNmH
   w==;
X-CSE-ConnectionGUID: 3aqAsmrGTuS5NdrWfbEtiQ==
X-CSE-MsgGUID: +xUr6duqStqYTNtmeSI9Mg==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; 
   d="scan'208";a="154863727"
Received: from mail-westcentralusazon11013064.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2026 15:29:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+9wS+YBgzV6JwoxAAGKErSQZIyDrsD2pnvwTiiU4p76RXnDLJBf7obqTUGVLFLSjWhvErqPC+Vw0OKqUK1VPp8mSFvKXI2LDImhnqj8SBWqK8hAe/BMiOmcDAd5hYUdQI8I75zsFM+osKuZyCkvoskDMOcabD2xYOqI5B5e11M5lOSMSmX08keWHZT9TjQz5ZqcpkvMJTpmvJptgvN5gScytakm6RTfOW0qyRCZKTpi0HzCF+HWaWvYrf6s/SkLs9VwF721I85M/Ao+8iwl+8cn49A8zXMDXQI8t6gpNbxfzgor1UyOxKl7mXC7cz7H83xgsgiEFoP5S5RW/WUbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGt4dkBcZh6h1ZAlfe19V9vzl2UGlvz2npQhuo4CkV0=;
 b=i5DgreaiIblvhWMEu7FCd4RZ3I3Oj6Bul4Grw46/3+2edbBGfY5CNy2EzYlw/agPzDq1+cRLM/kTqvwIHaKI50nIqKSgqsxEptVyXXFl3FIkPz7avhrIB4mJXiEFMxZ3N6kPhneSR79EYgWTSJ2Myg3f+/VN4lRewz4ggwOtGdUYLatjEysPiNsodwMIZ0phdU/N9kwih5lcoes+1SRe56tC+CqSwHZ4xvCp3Poj3c5pUZy3n94FjcqPalZ1G0H6DGTku613wmbrgDtFu01qhxDsVH29eGXPJnDkfOTkp4s2gtbE9vnlBLSBrJ5cLO/OABL8rwKam/PGSGAk9XKvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGt4dkBcZh6h1ZAlfe19V9vzl2UGlvz2npQhuo4CkV0=;
 b=YiaYdikrobQ5xNGxx71fAzRTkHX7LuSFMwWv4Ckft4hNEh5Q0WxZW19xRyd+l31o6eLVwOuGCPl3a5mnSTTbkFT+XfkRNCREU1QVh2ZpIH0UObpkeuICYJIbOtKECf20C1Np6uv1NXr6xrNESq8LQbX6FPOhHq9mV8K7laQZ00c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6996.namprd04.prod.outlook.com
 (2603:10b6:a03:224::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:29:23 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:29:23 +0000
Date: Tue, 27 Oct 2026 16:29:16 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-block@vger.kernel.org, jack@suse.cz, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, mcgrof@kernel.org, djwong@kernel.org, tz2294@columbia.edu
Subject: Re: [PATCH 2/2] block: take the inode lock for buffered write
 fallback
Message-ID: <auBSp6kmdP_E2JgJ@shinmob>
References: <20261015091105.1315605-1-sunjunchao@bytedance.com>
 <20261015091105.1315605-3-sunjunchao@bytedance.com>
 <auAmMShKl4S2lc1u@shinmob>
 <b8e77932-d22d-4c08-b163-f60ffec25553@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e77932-d22d-4c08-b163-f60ffec25553@bytedance.com>
X-ClientProxiedBy: TYCPR01CA0203.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd6a467-da2a-484d-6800-08df33fc060b
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	mj4bJV2OF7joUwaEKCA0f5DEt36agSJxTIHTL/MZzYJwg3LmvXaf9gsZch7s47dH6k4S7lqfJ12pqM8bqXM8MI7mErtsJmJRlUQMvRIUMyieOKS6Vqozb2e1wUB92+Q07CV7OF5F9tNaej6P4yq0P7Dir4nWWZq0R2UQ+LhteqwrhEGh6HDTWfirH2yNQRVNmMJzSfOkNo244szf/yM6PihP5MkvN0jVp0fqJAleFUbZemFfQma68oO37KIQjgqLPUR/uZjGxUPLvMSe596HiB0btADY2JMkqP5UsG/S30oe10vnedRoISG8PxeI6fLyWpboA7YuakEfUy0uFm3iXkRAxwppL0L1WRq3Z6LJvyZU0MgfOXRVMurL7FalC2wJ/7vXJW3rOqlh9QApk+6L638H1OoCya3sqD3KhNQpnYjI+NOKA2EZ/CnoExUJmWXfERO7F6FndDq4aK/N8vKCjCN6DljrqiQpYldISKsQaQCau/XYxmqGEEx/CERDkDm2F/aDqNF62lPMBEPPHYd5DXO6HUHjJFZRKLM1Q3Hs/PDc1la6hFMyhKV6CB3gUuY70lLlrUYgLPPnJ6tM5bUOKZa+KLI/YZoR+x5Vw47D3GlLB4gMEc+iJF9oMiZ0YgJP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kAhoq5CwsgfZT01QJuVJDDYhS/dUnst//f82D8KbcYDGGrSKr7Z+ZqiGNIkv?=
 =?us-ascii?Q?ZowTKKQ8Hguct0FWJfKVNFH+hb8AKEsY4hbGU91BQZl/EzYwS1R7+Lcd05lV?=
 =?us-ascii?Q?KJ0P4CKNZtGRNcKh0BXuJGA8fttcq85tK/JftnL8mpAP91rcSt/GgesF677p?=
 =?us-ascii?Q?5+2mnEKNJkDY8YkRh4w5aIIDAkA10lvBmj1DUYSjR5zW5s69A7my6/6rCEaM?=
 =?us-ascii?Q?LnygDI/AjV/g2S6wukSEh5TDEYNJGQS/obemTtUyrPtfrOdLvL1iXm/AQ+hg?=
 =?us-ascii?Q?50TdFXWr9ZyhIoyHqSMZljrGT1EGaGk2V5DwKHDf4mzhb9Pt/bLAZngVKG/A?=
 =?us-ascii?Q?y3S462ITxD7duUvFXmd76yBjkntAjefXDI941pmDho1yEcS7vgeMxj6e2Hso?=
 =?us-ascii?Q?4ze+n/1Uc47I85dcxyhRl6BeY0SVjh8s/nVZMpDony9fSnhS+FEwKOrBOhmO?=
 =?us-ascii?Q?45AjK4wv1TAyai0/QapwgP4Hdit5fs79z8ViEZ65X3jEP3zjZE3hgHAj6BKM?=
 =?us-ascii?Q?pQhgSn+77akTwch/Jaud2sSXaQvOOfeNZWV89Ayklc8+doIy8wjf6PVjfjOQ?=
 =?us-ascii?Q?/VkGYUuPI3yb+qzVbobyqwL49YPDLlQ7X+nG6Zthkd++61hDhYx3jLma4FXi?=
 =?us-ascii?Q?3nTJMcKVmXio2roTMynVlpkFB8aEd7ZiSGB4kKAtje7quHHEyAKUg+7dlAVw?=
 =?us-ascii?Q?kqsHAh2f2ouYrs41ICAU8jYp+pmhI7kY0fLgDGXxcePJnFXSue0pfu94hrM6?=
 =?us-ascii?Q?vWUqSml6f3vrSyD5+FOV/DasHQH6cLGAzKvRtE9SBMk1Q5qkE1FHMRY5V9XS?=
 =?us-ascii?Q?4XNVy8nPxWuIFC5t1nGIfcKvp2G7CruYDh5Y+++jkX9I0j2/EBf9Z1YIxBfG?=
 =?us-ascii?Q?GhKCU4iHZI4hAEvxe9pe4HgijXmVMaxBGRBndXcEFQdRczZ6DgCc/1V9zmMA?=
 =?us-ascii?Q?kOweRjRZ6chUMCJaEMVuRgas47YeVGx4hNqCeocRFmQiN144jdkpGYBfsKNV?=
 =?us-ascii?Q?25MjKl8sf2U4rfj2Os9sULvYkEop/NH9RhAyl2yWLdauAtGFrhyW26r/sB3i?=
 =?us-ascii?Q?gEvxd/CJ1qcRlHuWEyftnEos98+uSkCqctc5i3tf8MSCrSkGLDqO0Vg9+qxb?=
 =?us-ascii?Q?iSeFOUFrDRmPe9/048HbqBbAGr15AIeSXYZyOw9ExNzwItJQS5zVZ6qXH38A?=
 =?us-ascii?Q?Qtst7WcwIX4VDOqI6kHTft7gnEN9xa728KTjXS0i6DrCYOShqiusVLohZbdI?=
 =?us-ascii?Q?d9Q5bnzsKHusClER+SMkJwvLL1QXAh0MV2d66oSZL93zEoK+quPtQMfs5M33?=
 =?us-ascii?Q?zWsRMcniiiuA38XaAhZT4jMNwPrL25SeToJxtIuBzakhqjEXtAoeHe/E41mV?=
 =?us-ascii?Q?Xkw3UpKVdeIIzv1A+oJDCzlLzHlL7gpYmVKGdjJyOVuaon4Yw9xz5HmLAfoJ?=
 =?us-ascii?Q?oyDBiEeCZs7H31+wbdg3gUTkfM6m+OgR/V42Zm4Ee6cUoL0MavkCbO+VIhMk?=
 =?us-ascii?Q?FnIF0R/1p2PwW1RMHoB/gD76kgpnBBiqhKJA1trESbQiw83QjZHVA7Rd94NF?=
 =?us-ascii?Q?2LfgRGVkn4x25i7SZMyNdcGeVRxHZRZgTT7Dco4ov2f8UKy2cB2refnnhaQV?=
 =?us-ascii?Q?ayPAG9bxgnpRiwXOqpS0tYBUhu70RiW5+02afx/JafwKAGdmB7AN0KXt9lTa?=
 =?us-ascii?Q?SGg8IWr8hbHIyKyP3HD24mYXgccQm5zYZu5XkT3amM1Ydpb0WNDzriHWnPDK?=
 =?us-ascii?Q?cGb9bmHd/j/DMPJbWMxn1W96QMZR0V0=3D?=
X-Exchange-RoutingPolicyChecked:
	aKo4FociqzjQBgQoOurNXWiI36FWSohyGFhMpFnSxVPoS2BDmn14GQk5MgsfSLiH1Z9OO2eHZfBWxFTsFrWa3AeR5XFFX8cHRLZ0/ouRcka66nccYl98NBuuLfIJOFfyrHhWtgazCTudyoVPXvfL5i72hEi5/YuBqJ9/q16qYD4I8Oqy3vsdUBotsceYYjIgnZ09QT7lmnBCPtNLqftU0ThEqtllNA7JEzr7CPRWW9Ub5Klt5HIJ71ZJe98nOJsyRrtBB8J1EGeIZVMvH0MqZDY0TxxvWIOLvmWNtOpe04/kXNM+jL1+4MPuBQ5WkqasFbufUVKzSQtaxQRWU4+Z2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQj1ZZWhdti6mqDir6j4zkXfE1sHXznvgfw/Yx8gEDR6WGmE1cO7ZAhQzsQQ5UoU52P1SjYwijZwxc6uCZbm3HOJ+IULB7TIn9O1MD3EJ7msutl3lcR5xSAZC8QTx9gM/K3a062+eI0BlId6SVUTtyYEMnN6LbT3jcDPGjtZEahQyIabozHP2WqtXe4ybOO/7gyI/YjYK6ToyhYT0iPOR+foIhXaI7sa5nRcOBI8bBrxC0ky2URMWGdk5s02A2V+GGItgBoUltoGHkEcClONFcI6XLpA6zogvXGoyLGK5vRBbGqnYhEugkKd5XcIWLV+K2IY0fLoFnu5TmSmz1ITiNXYRbqSTt9TDMDNwyXeqAyVo3L/j9ABP8LYM5sj8xqSHrzYbS9OESUvdXB9vVkpeZAMJTnqFDTSlHpRolbM84Ahk1oWPasZiIVrfEMBbU7QbWOZsiLZQOZO5tMJyEyDnmk+5w4nf7Egdbr/W85HJaASWrNJHGMBYuAk8TYj03Jk0mvIXjwz3PKwJjG5Zwxe9Hiy/TQsYzsshI/b6coWsIRgEzbYI9qld22LXrS6huh0VwlgMSOiq5V+sBoMoVXYVF4wN4nVBTjffsAU9Ozz3E2dIQ41JyaMPanLLo2UF1pG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd6a467-da2a-484d-6800-08df33fc060b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:29:23.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVIVzO2s1An2YpLyW7tkOYL9jWDNHRO/tsX1vY89urU3CP7/TDYXlo/wxKnyfrWK68lm5Xbb8XJfDwNt4a5beVgnLzBBKFyPfUD5TPACww0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6996

On Oct 27, 2026 / 14:13, Julian Sun wrote:
...
> > When I checking the new blktests test case block/050 by Tal Zussman [1], I found
> > the test case hangs [2]. I bisected and this kernel change triggers the hang.
> > 
> > Julian, may I ask you to take a look in the hang?
> 
> Hi Shin'ichiro,
> 
> Thanks for the report. This issue should be fixed by:
> https://lore.kernel.org/all/20261022062513.77372-1-mzx199711@gmail.com/
> 
> Could you please apply that patch and rerun block/050?

Thanks, the patch avoided the block/050 hang. Good.
