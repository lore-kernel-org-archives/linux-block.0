Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527387;
	b=iRQp15WwjE3qJZ4Qg1TezusUwEs3CX2aS07uA3icRBHrpHUzk8ba8CR06wncYm8NS09X
	 Va5GlvwLNX9wNNfQVEO3dLw4Ksswqz1/NfhQIerR7K5pSe5tG92o5s+arZZgryDVMyjlR
	 nJo0I39Fs5IbQHHyIbbCLzJEXcHgR0AK9MHw2NhV1fw63u/u9/sHA/W4G7eJWhu2LHqRY
	 PSbmwDeKTYfPhkbNUq4Yb6pstzW0+vXDzGZUn2PES2CC6T8MjYeObHMN5LLeAobQWQkUz
	 dxyylLYEsLj4lTyS31Sd08YmpsLujcjYbIYYhDWAe0+NTvpQ9GiKEzFe2OOTy8XnCUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527387;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=L1uJ82Pl0vqYz+C3m63EI/HvAwRaP2ABCqAPLV/vGDY=;
	b=AOX67bBHl0k7zTLBRKOxHLSQZhiuxXyhuuounhJqmHKpAbXPhyU4xeq+m9BV1Yg1VdnN
	 UdZGT625vQ5WKOXPMbqVyhcXKUdvI20tNyixAh50ftR69AoZ9e9eKiJBhi768gD9w+7pV
	 oJQywaZ1duCn04GX6sxz+Qu2BdkQCDx7dPNt2Wge+Qa6vX11VZO3e7XToK+uBjewR6XJA
	 U61OXziSEqNLXr3Rw4Tc3j6lCLjY+kolhCgcYsrxLQHrPhUHyU1IfObRszaCsLLxQFDEF
	 tpS7vRGmtehOAc5uYghumZ6A44C4DX9lp+2fk/Tn/7dOaMMJV4oMrFrx3dmPH9YFKkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Q3D5kHj8;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=zN9jek4v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13D606A321
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D13D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Q3D5kHj8;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=zN9jek4v
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527386; x=1827063386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vfSRKqfdUlvLDTJCZA+yNTQqpTmSStT6MYei7Ghiye8=;
  b=Q3D5kHj8RTSg7YJ/5svkhjQ8fMhrCm6KY8eQ24rOhAUuL9ItL7S2naW3
   bru2Bbv2JzGa3ovxQpN0fmKmZlF3gZo4Xz4t8tt0dlFuSrvUElOgo8gqh
   2nfBNO3h9zVE4+WUXwOrw93EmHzdNvA3Its/i4pFJ4Q6YtCdER6OrA1mo
   pFlwpS473bXsSB9NZANbvybkhlfFnEJ+9caZO8/sea4BQdcu3qIM1XEOD
   aos+CxGAzYpn95+sPG3IJkMmyVPIaTmPHvyAMnzYLrjMnN5v1aCSMT/OL
   s2DaF4HUZP+N6BS1yPT2drCxfD9gAEYUO4qi1N1piojXvZyHps/pWoMF1
   A==;
X-CSE-ConnectionGUID: Fnaqg1G5Rjae+LNycergHw==
X-CSE-MsgGUID: qREG70x9SQ2ke2isTVVY0w==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161579912"
Received: from mail-northcentralusazon11013027.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:36:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+ni7ovF9CiWmHBLO05SsNTtONA/vjdCVdpyfpIjI8TTRBlGbGz3H/cpqRQYnGYvWWVl0VyxF5vZAOoG4DjT1YiabbpX0P3cKzInOPfKXSY2hLQFMmHtJulTQe/9eu24Q5JiAeDeZpu7Kde7Gt0NKATAty659X+BsMiree7btbKFfM2S+vN2TXL91/T+lMXgX1E3lG9X/M2VYU4zMhnG3uQQW/TJoEbMGLuOXnDTTArKX1IetTFjaxUERhqVAvDgSGUb01gIUytrwfs/smLP//eJnSziUmAv4ulqqU8tiruIQfB/XnyiCBWX4Eh3DX2XcEi6Dae71SzYDTWlkRBCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1uJ82Pl0vqYz+C3m63EI/HvAwRaP2ABCqAPLV/vGDY=;
 b=DMg10guRlDs4HXDllb41hGLoGEZnCquFIUO2W0QWmsK5JwR1unUbnf2gk4SYWbGPFMXUphbtjKB1WWSON3u1hf5m1bijmtiwRySQg90ys4CL8s7G0ZKhiLqLtlxxbIEXOV6ALIFYcpdwZWX2JM47WcRNu50PBxc3bAtnTYfGTN3Qq3ejjz+9EAbItnlDD4wDTEw8vKbVADojPRmBhBfWAOfq26dL47nzQnZzJPb3FpOUXlWT29o07OhZMISfrDNgcPxzq77Q9zc2xnoT3oFtjRGbjpsJFQ/KvQKTQDwSaFhAV14MhjDuYNuvk2o0KNg306bo4z1EK8mKVFQCeNdVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1uJ82Pl0vqYz+C3m63EI/HvAwRaP2ABCqAPLV/vGDY=;
 b=zN9jek4vnASV+GkzAfo1OrpJkvcuC4BBohCv/wgNjqkCqeXaDGhilJ7Fyw5e76QW7XooTjZANALOLgb7RY50M4rCQklbY2FK5Xjyi4qo1nPLv5yyA752VaQRFsiATCc4YOUVIzte/nwXJ6PiYHy/IreNTQ4SuhnjQ2BnFpWd6n0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:36:22 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:36:22 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/5] blktrace: decode ioprio on ftrace block tracer
Date: Tue, 24 Nov 2026 14:35:52 +0100
Message-ID: <20261124133553.152463-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::10) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|PH0PR04MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f67847a-ed10-4e88-c511-08df4a2fee04
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xtUCSSmbpO84cDNNjDq9LrxZD352GqFA7pP9aFJ5QP1lBAiUwK+tntMMnoa1+D2SY0IN6xfLxQmqEUVmg1r9kbRszMxNIHeio4odMYGvmZ171uIJX3Wn7kxy25VnStBFRyI96AQcKwFZka0IVTzEC0N43Ad4mRbsWLBNS8I4A2znnhUVY+oO9AV0QZxrZ4kcL8WtK87VxeJFHReWzBbVFQG7US4o5yoqmEl5MzqNawiOm11uMG0ZRr7L9oE4CgKvWRQZw3LNjgHXq2iCkz9vrhEztHaA1227/0j9aE17mr4HhN7K2zxUJmgTsdr+s6x9Z5llJQtoTNSVKZfd/orgWkLufvK4SCMgsL87uVubWNjFkXSw6DBsDZgUriM1YLC9cKwviuMei0RCxj8afHsXT7L3uUEH8P3gDNxveL7wJSxOkP0B2tqf0OsvIIilWZ40movttGh80fJoKBP84HYUhJ/I9lLWILKdnp2+jfLUKiJDhwtKrYyXLf4AIwTn5lTGrhWJcGKgF/gpUqfAR6Ksp3hUyY8WUjDnCAUlIddteAHQV5x7FzwPV4eCPxlKZ9CpadaEtoti437kyjURsKBr23HA1zeTo0wJEsjRWFIIg47EAESBaj2Q6fdLEp9b+uWUFxXx1L4HJTgEBCVPeZXQ+Pla8KV2XrllE/z0lYQZw8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLNUKTFkKjzhOmlS2e4z66T9vRf4kITgzQDpx52CPiD6avtmb70Zepq0bTHw?=
 =?us-ascii?Q?+X3WSVFcYKx4pdFc0VEDrqqRD7wCO2rV/2GayWyhDbwsRvb3eVbiTJJdyr5w?=
 =?us-ascii?Q?uDecI4PX5S1ULVU4jWIUQbAOK8rQLXxK19MTBfoqDJJzald/VSi3xI9hg91o?=
 =?us-ascii?Q?m/DcCnrjGBnn0OYjbe8I5LfVJ7yPLA9lL0zKi/H99/OzUTwHLBNvewPnIxO/?=
 =?us-ascii?Q?ilbD4/uGLFmo3VYRvHOe1SnsWXGK7MIwYCc1jTUhzWN2a4FZG1qvtLB6T0Dd?=
 =?us-ascii?Q?oifNB2gGJKFEWYVNCnCNkUta8veABrHVLCyBgxzcG+zDzs5p1fARctP/ML4+?=
 =?us-ascii?Q?kmMAb8k8nxBWN3Zu8bU1LvkkL/NZDVcGJpNwTgKE3p2UMByXifZgPbLqfVJ9?=
 =?us-ascii?Q?vV4WsVfEINYEGDK7aEAS6KzzjM0ZcIDnUw3oi40lD/wn62S9f0XF89ng/ydF?=
 =?us-ascii?Q?X5ZcbWhLbLTyYqu4LFTJnTUtrH7mqJ4g3xMpaRYkLV+i5+XEbVPdaHfstQrF?=
 =?us-ascii?Q?8XH3jLYBRHHV8phIjTf2fX6KW+tnPkpN8bPZSf/HD2lZvx5wgZCwXWgIYYhK?=
 =?us-ascii?Q?y/Z07E0pu73Fy66z/aMky3LDvg3y7+9Gq8g8sSo7lJDFUXeEJQ14ddBQa+pC?=
 =?us-ascii?Q?TZqI2MYkRJ+3coG5spuabzQ/g0wNNCfAOagYw9ZZXDB0Hz8Q9s2lC2c3bJKG?=
 =?us-ascii?Q?NsQB+sWAHc4PS9kQMpsPNk/hiEUbxug6o8c1kh3tdvdrP6fE+XMJSeNx9Me9?=
 =?us-ascii?Q?UfiN5XghAfvqKTwYAP8ml8e3CZT0Y74ihmw1lPf+SdNzPLUTqoOre9OLvKGA?=
 =?us-ascii?Q?1rbklkIt/qH4GBYa0kgzWmmwTy+lHrLdnjKXkzjv0I/tEDgeOvFgtmlVObQz?=
 =?us-ascii?Q?f+BK4I71OJLt/gVunSOo6RPBxzVtm3p2v4l6jWKi8JrWU+vRmI/B76rPeeib?=
 =?us-ascii?Q?4ksGiRypWHnfrUNZmkhNOWDbhIMV4E3+mKGZBqGTCiFuR14eN5N4CYAYPI5I?=
 =?us-ascii?Q?p7C44wSj/qVZzB8xXxSI7MO777aokfOD3w7ogZj3y79P9aaa4uP4jyv+wAKo?=
 =?us-ascii?Q?moHSpWvGBzyI8W9fnyClCyj2RULzVhVm+EdH51BHn+XQQtmKNl/7p8uzYNZo?=
 =?us-ascii?Q?fiMEIxTD3ZrBhVIrroXtzaVenK96zuIFm2srWUaJZKRV9X1Y57EyTg1ONu/f?=
 =?us-ascii?Q?99EThiDoXbbg2LWQfwdrooTznErFR0PFO0QCWKyfaLYpGVDg1OVJ36PsRVPk?=
 =?us-ascii?Q?u1zJCMP2nMR+xqzcOLrDvcSlSW6+7MXp+5VSCXKkBDOJqkXNpS1vBajraV1+?=
 =?us-ascii?Q?Vk1Ny+YD9dFEKFSIHs8JLgMtUWFSLpj2Wnn0JaUq3CPXy99k+MkqV4bV3ind?=
 =?us-ascii?Q?QfGDE4m3K3FHzKos3ddgq9gEDAqzpYpnWCPvAycXhoOTLZ6bkdrfwhtopuux?=
 =?us-ascii?Q?Jo3KQBpElF0NIH71GcRvGyDLVYCGgL2fcEtGgZeUIxAtzozg26Ocz2gPfNMa?=
 =?us-ascii?Q?XwbqpjiqjSnfrI7JZ36yQ8Em8O4tXwfwHAmrIf/6VDh9kgMrFv4Lk7kJV7ID?=
 =?us-ascii?Q?L/TxuAAGCwNLmUfkhv0mnqxOJOzUPpzo5KvxiGVMQ/+AXEUCp5Hq7G/wC1PX?=
 =?us-ascii?Q?Zc3mp/dw0iXyh/TnQDnZW1wTDTbAXDUuKUpKRH6iAXR6V6HNrItSs1pZ/DgZ?=
 =?us-ascii?Q?RLe/VlE2GLe3w1KE4XkioYlwww24mbZ8D7o/lonH1GyW6b7AgQ/cmv9+Ut9T?=
 =?us-ascii?Q?RGneHxxBhN++5tkafjt+cHIGPOkryZpiXxRi8YdAdiWMSbqKHNF0BRYOyaDe?=
X-MS-Exchange-AntiSpam-MessageData-1: YHvsFAiNuMRD/NViRl4gRYOtTLxpWgmKPR0=
X-Exchange-RoutingPolicyChecked:
	R1YfyvJMXErCUEuWAaEhZDgsI0icG50DCbEGrr8wF0m9XNHWJP1Yq1v8KOnysal1JZyBFW8yq7ahXKyTYOM6W11i7TVu7cMupi9PchtG3NA4CozK3oFXY2RzchJP9H9CT9EPwTfAVOP9zF8Fp0mndE8kainRVDHMkQNOEvM+FDdFidEl3mbfnyFw3h/fbLdYuoeMjWXKwEyvVpCDSAzTz05B8sZgR9bXHqmk0SAWzaBHHK55ljKJ9Tus8RYhoLsdCStrXXbo06M8bk/0BwobdqyhemfDtAjMt9QBcLT2LyhXRbKa3jw43evrmzXjEwYyKJaD+lNNwHRUom2Cgq2uGg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bM7tJzuGehvPvx11nJ7ytKjHmq2Crqdsj1+UiIpZ2PY3O6+u/KtflliolCNdA+Q1KEmsVNKEnUqfE0rxWg2L7JJ2r69ZWAtpmxjs+xXC/nVWzhEh+rUnNovgBiTri47hxuTFIYpdivNFM/Y7iBSyYNRUiiTk1F+QXGnX7wZKQOul3xlNIsa6N6mvxFoXUsivDGWbfwKpC0mwpMvim40jvMiRR5vLAzR1xe3PA6g/l4ZCnIqw+/koCNWjJSymWJiVOIRrvEpDWdBZgYp8vJAJNt337TCGsWaA2ZlTZxWJyQvLReO09TsiREKfKLPSDnfIRGuPY9Z6lh8VmdcP4Q1qQU0J70cVzmpGNcXeX3eHUtcZd0wz++Xm6QShCHAIUmq0tMf3F/f4D81c5S3QcaUzefcYXGMjesoGAVabf1kRY2u6Ls0hspKN4qJKc10fzpD79t36gzqs7qarKIwUOuK9hItfI0txsAMROmRc4+mEilsc+hKEHuWdXACjMTKGrnh0GOhHBgwOw7MahtgGam05u+mgKIiQI1eQZ7PaNpmSPugrnl/kc+HAg9ZBfHAzHIwL0Og5+QMHkHphXz+DZg5ZGNsZdJfAavRkbBR4wBju+DQ4OGiLQbaua3IBRLSM/WoO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f67847a-ed10-4e88-c511-08df4a2fee04
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:36:22.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVpectvx9Jm0Bvvl0tOWhnnZchizHG/xBNVybkVjelwrSalYt8lfKqCfrS8uJOpL4QYAOXlrV7rlOmtltTgJsn6M8wzrI4gCvvsNp88WSJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527

Add the blk_ioprio option to the ftrace blk tracer. If it is set, events
with an I/O priority are marked with __BLK_TA_IOPRIO and the I/O priority
is printed as "class,hint,level" after the RWBS column, in the same
format as the block_rq_* tracepoints use.

Mask __BLK_TA_IOPRIO when decoding the action, and when synthesizing v1
records for the 'bin' output, which has no room for the I/O priority.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f1a3407d36c9..c779263d2937 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -49,6 +49,7 @@ static struct tracer_opt blk_tracer_opts[] = {
 	{ TRACER_OPT(blk_cgroup, TRACE_BLK_OPT_CGROUP) },
 	{ TRACER_OPT(blk_cgname, TRACE_BLK_OPT_CGNAME) },
 #endif
+	{ TRACER_OPT(blk_ioprio, TRACE_BLK_OPT_IOPRIO) },
 	{ }
 };
 
@@ -1513,6 +1514,33 @@ static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 typedef void (blk_log_action_t) (struct trace_iterator *iter, const char *act,
 	bool has_cg);
 
+static const char *ioprio_class_name(u16 class)
+{
+	switch (class) {
+	case IOPRIO_CLASS_NONE:
+		return "none";
+	case IOPRIO_CLASS_RT:
+		return "rt";
+	case IOPRIO_CLASS_BE:
+		return "be";
+	case IOPRIO_CLASS_IDLE:
+		return "idle";
+	default:
+		return "invalid";
+	}
+}
+
+static void blk_log_ioprio(struct trace_seq *s, const struct blk_io_trace2 *t)
+{
+	if (!(t->action & __BLK_TA_IOPRIO))
+		return;
+
+	trace_seq_printf(s, "%s,%u,%u ",
+			 ioprio_class_name(IOPRIO_PRIO_CLASS(t->ioprio)),
+			 IOPRIO_PRIO_HINT(t->ioprio),
+			 IOPRIO_PRIO_LEVEL(t->ioprio));
+}
+
 static void blk_log_action_classic(struct trace_iterator *iter, const char *act,
 	bool has_cg)
 {
@@ -1528,6 +1556,7 @@ static void blk_log_action_classic(struct trace_iterator *iter, const char *act,
 			 "%3d,%-3d %2d %5d.%09lu %5u %2s %3s ",
 			 MAJOR(t->device), MINOR(t->device), iter->cpu,
 			 secs, nsec_rem, iter->ent->pid, act, rwbs);
+	blk_log_ioprio(&iter->seq, t);
 }
 
 static void blk_log_action(struct trace_iterator *iter, const char *act,
@@ -1548,6 +1577,7 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 			trace_seq_printf(&iter->seq, "%3d,%-3d %s %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device),
 				 blkcg_name_buf, act, rwbs);
+			blk_log_ioprio(&iter->seq, t);
 		} else {
 			/*
 			 * The cgid portion used to be "INO,GEN".  Userland
@@ -1566,10 +1596,13 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 				 "%3d,%-3d %llx,%-llx %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device),
 				 id & U32_MAX, id >> 32, act, rwbs);
+			blk_log_ioprio(&iter->seq, t);
 		}
-	} else
+	} else {
 		trace_seq_printf(&iter->seq, "%3d,%-3d %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device), act, rwbs);
+		blk_log_ioprio(&iter->seq, t);
+	}
 }
 
 static void blk_log_dump_pdu(struct trace_seq *s,
@@ -1762,7 +1795,8 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
 	bool has_cg;
 
 	t	   = te_blk_io_trace(iter->ent);
-	what	   = (t->action & ((1 << BLK_TC_SHIFT) - 1)) & ~__BLK_TA_CGROUP;
+	what	   = (t->action & ((1 << BLK_TC_SHIFT) - 1)) &
+			~(__BLK_TA_CGROUP | __BLK_TA_IOPRIO);
 	long_act   = !!(tr->trace_flags & TRACE_ITER(VERBOSE));
 	log_action = classic ? &blk_log_action_classic : &blk_log_action;
 	has_cg	   = t->action & __BLK_TA_CGROUP;
@@ -1798,7 +1832,7 @@ static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 		.time     = iter->ts,
 		.sector   = t->sector,
 		.bytes    = t->bytes,
-		.action   = lower_32_bits(t->action),
+		.action   = lower_32_bits(t->action) & ~__BLK_TA_IOPRIO,
 		.pid      = t->pid,
 		.device   = t->device,
 		.cpu      = t->cpu,
-- 
2.56.1

