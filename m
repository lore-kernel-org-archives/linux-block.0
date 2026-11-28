Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795833304;
	b=DneGSTuQ2CZeeJIgXHf5HpfAeq3Ym1bmng27aa4F1nHYPyZrh/RtH/Hw2KxzHPBpTm22
	 ixxKj5ZprsxJ6PcTusncIR4ZYVKT71s4su9xs83FGyB/Fi2QadJb4sBGg8G8H60WMzkLr
	 OlchVssqWi4FRGbm489Ex2XxipTTtLyVn4o6KdlhBgLOIoZUaulbBWVCOGduCppQip/Sz
	 iAf0Tji6ADzf4CDbvQ37B7udGR3KNk9rfVNiUSLpLty9DON9vGErkO1WDYyGiGWG1LlSP
	 mGMHIlcypyVhCNaF5OX3PuJfiaOeSEWxdqgfmCFdSC10WQ+FmSVlWmBBry0wOzlPpug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833304;
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
	bh=Ej7xURvLe7jTT9sLnf1WTICXCgdWDrSnmhU2b7P93VU=;
	b=rL4hGzV/61VPhGhBD1AfHply8uz4F+893Ki6EqeMfOHQ5x8izcFNIL+d6876GOQ9dAza
	 OBJk1n0KoKT0sdLROu1X42u/uYlp4D2Shy7J7OKO/qqOinMtEQms45AJkP90Uuo784Zrc
	 5/d2FKDH40+R51xyv1BHuBXsBVbrrzqC+/P7Emzr4A8qQsKf09bD5MHoUa9+6QGoQiIt7
	 E8zvmaVxS9o4AtKg5hUrnI/kFBvAL3Fz5skQgF+ED8D9JQImPwabnwWnlG2FL+g7qzp0v
	 HdoHmWOevRxMcoH2FFPMujfRW/hb6M/4WBBaIF4cW/8Fo2igZqAaAk+6zeE/YYXk1hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=gZgj235i;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qmKRTCo7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0085606A31C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0085606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=gZgj235i;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qmKRTCo7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795833304; x=1827369304;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uTck6B43wsT1VYTag8dppjMrij3qmSbZYvoZSNgdiP0=;
  b=gZgj235iLdLa7jwErT9FSXwl7UQYbRg7d/OiBnpmwEY6RqClMR+15oV0
   rRnrHeEHdWUiVO+GJfs7QhejxDNK78uDle3jHYFek+jnS0WG3os6i3c6O
   kJFmBDi3f54t+5yzHcCTildqn8BKwHD3mMxod99IctoAcDnyavxCJlM27
   ezmI/QTuQhCfN6MeB+6Jtpwc/Gpz50E91tEMvMecP4Gph+cogMtZMzNfG
   Nf700xwj167cuOoOFbcXUSqnlC9aZNhhchEDOInVol7sxTa7XneBm+8AF
   FT8tfuXLKoUbEnt762S6ySSpD6Aj63y8+n0LmV78cMGEi2AIyUEkZa/Ql
   w==;
X-CSE-ConnectionGUID: Cv11cOGMTEmwsRH8f/xuNQ==
X-CSE-MsgGUID: T19f5IJDTZijYfgIwe6B+g==
X-IronPort-AV: E=Sophos;i="6.27,238,1786982400"; 
   d="scan'208";a="157702406"
Received: from mail-westus3azon11011055.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.55])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2026 10:34:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLUaZPddzMuus4vDnybqFpJnDnxqbC3Gih80HYyYO3aVPHS+80Ac6sp0Zmj8h/uZqE20eD0rfdzhInGSgKtMtTJNtkF+MdoebQyBSOTl6e9e3HUvzm5kXm9yyRH17VzfdnUj53GzNheSTAq4uYx2Kzg2LTQJtvEbrbbBidUg9l9auMAtQ1+ZSbBIi4Qv1Nnb3bDyHvaqwNcob8tTe7lXKka8pxKMBm0JHj4A5xUjZIeuyjtpoLOkyeT34+ZDVspDRkGBq89UO8rFhI7CLzWEeSuHxCtqPBA34+BBe1diQRn7HFwYA65LiFkkWvYKwxbz0kDAnNuL2EA/nbXjUaxy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej7xURvLe7jTT9sLnf1WTICXCgdWDrSnmhU2b7P93VU=;
 b=qq9n/F1AmK1u22Tjpnzaz9XNVbaUqf2xp4p/5w+rAYhM1kJRw9hUPpSwmSM4OmN8bZJcR4VtWdgmD4PQOoE7n+vsbFHbvruZOx8PvqXuD+KUiMizFSgxgxevhUg6KFaw3ZcZpPDMD4A3qOBi53GE3MPjLthUYNDSHoxrLw6O/EWoYWYiQHFh499eHipMR6W67ZnE7HLLhCwwPdnRE/406L3gxNh8cLtBLWB/ey0yNmvWn/lf09as7P3UotF5alAyXrzV1HYGz/mnqK5ot/uqoZnxd4G6OOwxIu/EcySz5n9mVJUBE7CCKPy0XrBWdanjM629T+vYBO+Nj+8xsXwj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej7xURvLe7jTT9sLnf1WTICXCgdWDrSnmhU2b7P93VU=;
 b=qmKRTCo7RVuR330bKNqVUTzEbGXMX7L8fOMphpn91Y3OkBeFtIC2tHeFDMHzmfiOQmDvD5ODxm0vqtewX//ykj/ryCRvdie3Q6Pzuy9UksbCDy3yeOox3OXiZO7m2zSkKX9CdsljY/W+34ozG/7trO9JUubqtgj/GqmOxllkNMo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB8563.namprd04.prod.outlook.com
 (2603:10b6:806:338::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 02:34:56 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 02:34:56 +0000
Date: Sat, 28 Nov 2026 11:34:51 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/9] nvme: make NVME_TARGET_CONTROL work with
 remote targets
Message-ID: <awo9DiUGqtD2JESi@shinmob>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA1PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: c7151318-f494-402a-b8ef-08df4cf8308b
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|23010399003|11063799006|22082099003|18002099003|261102130727099003|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	uEzvzD/gcAEadx0avG6M7gPvnKjB/snkP8vJHrnbEBfFLPDzYxArJfjTg1OnXbv/OKmSCeqY3sd84JjOxWDfwBJ/0oaT+01cAwjoKfX+07r47nElVmir0oQAdV3/2QgQsyPyFgwJlgFtKL6dAcpDL8GEAgxtH4PUJwzyVpDautyj0otSQZCiupibMnzJG3QHGsL2egSHnTEjWoeLdirYM+NTVTR/LSNCWg3SSj4M6bhAIZrxaqO4HQae6lK5f/vaFhLKlNWcrNkf+wZVYOI8n3C/YwzRbIn5C29QZO6a3VnqH9HguKEst6slVcFsQOp/CwGBGBMtpmfxsWqrFI5ijzgyWVHlB8LkV2cHGbb0LksU5X+4XRqom+CPsD3LjkTCVgvWQt2518L5fpTfOX/9iZzR3GVtgCuzgzNiHqt9k8CE7V5+jUb93hbA+6Q3cxeVtWdOdxCfd+NHd8zztkngqqSZdzeRhrBENHaa+YUM0EDR7nQqF+FKDu1j0Y6RaD8dOUXfQn1CHsRLwxzqDhCfxrmri2mkqfzMIgEgeDw9zzuo8OoqNQEDpLqrclf7TXISE2YDTP7UISSMbOTqrreHq9N8W20c0Ijn1ySQVGz66Y6AAzVe7wHFffzI3aVD2yVC9urSlE+w+Yxv60XNApR9mq/malX2qy/DaB6A4CELCmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(23010399003)(11063799006)(22082099003)(18002099003)(261102130727099003)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KV0lOwP+yIpkKqj21/1HZhTzEXszXZONUXGhAfFmD3SpUOiHo0uT8QfTF4Z5?=
 =?us-ascii?Q?OBBqPTS0wzdxS4arp4F2oNoYq50ZcnRH8wU8LSqEfXqfLBJllU6z2cp8H4OU?=
 =?us-ascii?Q?DN1BqGaAPq18kxYhWtZc98BtOqdMSwYGB7G2bWXTi5AH68F88M4nH9sJM3Oo?=
 =?us-ascii?Q?AOroGhAveLsFNnp9sfrJnw0JbF0el9UmbQmuwJ9LeGkcMviTe25B/L7D1RvP?=
 =?us-ascii?Q?yp6qAjVJx7OzFu1vzZJBzTbu4P495hI4v+7SyP0uUjjP+y26I1LIKCiYnZ2p?=
 =?us-ascii?Q?OmnWwTvl3C25XT0egAKw7U2CdQsOcummcLiZb7ebIBTBOHnDza1I33T34+f/?=
 =?us-ascii?Q?slzhnuHHQnlufdzHsfPDm9ovE+XgqAJzuKttZpF0EYW4ES8k7+JZGpWH+HPX?=
 =?us-ascii?Q?pI+G9eF472BoksgfX6eySCo+WuKzp+I6PUzvzS8inOpb28rycJWx8Smo8usb?=
 =?us-ascii?Q?BiUDT1ghxJyJn0TuwmC0VKdQ312UTyqq2/oKBU3yES3h867S5SQ80sUNz03V?=
 =?us-ascii?Q?HC2uxEBs2AYCl4BP1KM3CKqmPp7gwKbVUAPqTv9gerIvv4+ZmepVh563Eq2a?=
 =?us-ascii?Q?bd0eq7qS6GIU8CSl7uyr9uVl3jJsSOIfe92IALji6l3HEOKlqJ8UZQkxb/kt?=
 =?us-ascii?Q?WXZNgRoZdP+CrAWkEJIBDQO7m9d8b6+su5mK59kyzEpSS2UANtYjVqIIeHCn?=
 =?us-ascii?Q?N18FeSjz27j+Mc6qtmnQ82oVhTf5xrXVcX/9YpDfi9/cynqB/i2e2DC1Y8Mt?=
 =?us-ascii?Q?h0Y52C3Ini2Lg2HliTI/6HJpnjVYbWO0JS5P2/VMoS+pR5HMjxqqgElOkQQS?=
 =?us-ascii?Q?AQZLyjunQrfynPN5a6pPtAdfQwh+vuaAzx6lhWhy+s995O1lurZoR62J/gRd?=
 =?us-ascii?Q?jmOLzTmC7AOFZeJLb8Io9yBc4Vu/2XpbWsGxsnVbuMCaiKIy9KXGkTVnHAK9?=
 =?us-ascii?Q?dUwoyQkjL6ceCUMPKwSdy0D2I5g/ESrGgkEyvaFlSeyQ7kNCNUrYeqcYMQ0u?=
 =?us-ascii?Q?nrazZmzRCA+VW7fpxJGTxctUTfDiCXVr2Hi715S0/7jwsVOv64DYf70a0VNb?=
 =?us-ascii?Q?gnaG9e6n2p0WgDhTCIJ8cO2TLb5V7S+AevOcO83Bxg4a5XC+GaGeGiLo+aGW?=
 =?us-ascii?Q?NjvpLxMrsK6KDjIxlCHIVNU08LD5UzaOKTHjBt4VjqIL+MCUh3sBKVQ6/zmT?=
 =?us-ascii?Q?gYocsIEn101bJmMyX2jjzuu35JBqnDknaqYexCop+Onat2ViaGdJCw/D86ya?=
 =?us-ascii?Q?XlJQDmd/LFXlaK3ErHbbzxfsfF64v6Z6+L/vkh43THyIX2Vv4Um6yhYyaXQg?=
 =?us-ascii?Q?nB2zXoX8SfP1Vkq0LiNaP3M3fq4R0cyncMQ5J8fZhAy7E9yhdWqNAfgWxXtx?=
 =?us-ascii?Q?FbwMgmej+J/SA28fYD4XJ0UhXblIrBTlNreJRWG/IQJEuDWFBumNwZtcHNTa?=
 =?us-ascii?Q?f/rTk9ZDhTdjdfxn9wD51fG4ge25FEOn8mjeLqn0tCicrrEQyUUeOA312Fxz?=
 =?us-ascii?Q?Vfe4vb5Zfzge908bHqnpbICJVXiPpzZUZqzho2iZDMPKr+aiMieab+/WAb6G?=
 =?us-ascii?Q?ApXvTZQASUb2s7LdXgE0Dbr4sWo+OoPaWeessVvbBfpPJpgIeHzptHliVBVc?=
 =?us-ascii?Q?ZUhE29q6XdtzBLhuY6fVdhrDeO1+/Pv78vMD6LF19F29iIgEqI8wku1xKN3N?=
 =?us-ascii?Q?zS82WIFXtz4Y3iMcEk85khdDOnyhKih8kSkmlHzxmaIngWiC5Btav/y/hMqI?=
 =?us-ascii?Q?0JvKAy7gt425wBE5hBflp0q2d8LYQ+A=3D?=
X-Exchange-RoutingPolicyChecked:
	Lm5g1HeSiQvOu4uamZ/hvYXHO6umEipJPoj48xorrSnfCoI9Fl0D2DhFOXf4PAS/oKQRDJkmEbkwxINud/vAAYdkViXBYaPPKM7MbDmseZnR2dzaa+DBO0R31zMF4hu9XGpudqn4fAffFkrfHxEGNzDMa1VNQWpLO1PJWcoOiqXl3n/JvlpgGRojZhL4gGRzgBCyIBX+UoH2nGWg2wlJf/3wkbkujlxpaJHw2TE1bjCbKEI+xvagBc0g7OGYqEYYpoQaTzR0/31fanf0u/t+mWdasPPkdrdJvvkVZ8XTYsVcYf9lVKrO7Ze4tA3aN+V/uykihzUxjejmV2jrFJIq0w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ru7f1P8u+AKsKPzrL+GemP/GIy2yUU4F1zb2TFVhevNClhX9UbL16Wn6RXGpqSHKOujSqennSW4p46pFKjnqEJw21fFiKg0wJOXpf7feihrhpoMUObPxIvnmVva3hPH8OTXaMGwtX0eXf/00tW2tq8rPcaMDygiw2pFn87qsK0L7SoiVwGUbgjEA4CFYzza1f1rYhchL3/nrwbfARgqBcsZ2yw3sf3WC2x00YDYsLqzfBfKLiCVvSra7uPj9gpONQpUj03Q3McFfpszgxl2MiU6kecM5c+K96SupoxgpFv9xxYnuAr4idCHzoG84Kth4A8ieUC+Nj5ljYjLSDaNSdg1wcbQr5+2lnGBkRvLu6HDk5E4t7hwZQ6OAWusEeb9dHJP8pwgr/DzxGKQdXZJZB2EfW33197a0uc0wZVKstml9ES77N/wc8XYpWzteibdld4XS8Mcm/RdxUm6Z/qLHZ6FuTG2cyGLxXP0VVebKkDZdTZLhvntssgleV06YNR0hQWOMv3S2oQxcljh8rf2GYeDurlJCUxwFAcyzEaBU4mM7isyj5XwlciH2rS2zZ6b+SanmyZVM3DSuSn9l2aBOTb0j2QXgUisauWkojg8Ad4cfA4PtSXe96s3xncTtEJJZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7151318-f494-402a-b8ef-08df4cf8308b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 02:34:56.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNLsvVwVjV14cN7KN66K/miaV/qVhHpw8/2rNJewHrWqAvk+4skXT7ic/XY96mJYsx/kLmcnUeCAmAAFmapVyPfHhJdvwNypinitHfaTPy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8563

On Nov 18, 2026 / 10:26, Daniel Wagner wrote:
> Hi all,
> 
> this series makes running the nvme tests against a remote target with
> NVME_TARGET_CONTROL actually work. The first six patches of v1 have been
> applied, this is the rest. It applies on top of the series that makes
> tests skip when a program they need is missing.
> 
> The first two patches are fixes: nvme/047 looks up the namespace again
> after reconnecting, and the nvmet target picks free service IDs for its
> ports. The third is a cleanup, nvme/042 and nvme/043 iterate over the
> DH-HMAC-CHAP hashes by name.
> 
> The remaining patches let tests skip instead of failing when the remote
> target lacks a feature they need, including the DH-HMAC-CHAP hashes and
> DH groups the target doesn't support, add port and host key support for
> remote targets, and add a NetApp ONTAP target as an example of a target
> that can do less than nvmet.
> 
> Tested against nvmet in a second VM, which also exported other
> subsystems on its own ports, and against a NetApp ONTAP array. All tests
> that can run against a remote target pass, except nvme/077 against
> nvmet, which checks attr_qid_max in the local nvmet configfs. Against
> the array, nvme/061 and nvme/070 fail because it refuses the reconnect
> after a subsystem is deleted and doesn't support Identify CNS 07h, and
> nvme/068 because the host runs a 6.4 kernel. The tests that need the
> kernel target still pass with the local target.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Daniel, thank you for the series. I think this series is almost ready to apply.

Hannes made one comment on the 1st patch. I see the point, but IMO, it can be
put out of the scope of the series.

I made a few minor comments. Let me wait a few more days to wait for some more
comments before I apply this series with some commit message edits and with a
follow-up commit.
