Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966E36494F
	for <linux-block@vger.kernel.org>; Thu, 18 Jun 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769874; cv=fail; b=NHPdyF8RABTgdIUHqPc/AnDe2TYoJJfLlmUio5V6UGt6ZXVM7MnR5K6iLbfYpTykK9XEmFgd84GB5mJGG+r4PkN0Ynn0UDiM4+xp+l0s+/pzRvbVfG9wSBAZXNWAk2G5YiG3rifls/VYzfnSk9PsUKRue3Pp0W+R3c+qgfnM2VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769874; c=relaxed/simple;
	bh=qk6Cg0kU0xZnXI3NBIpenPLadIGvc+Pv/9Co45zYy6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fQOGFLDw+f7WZJrCiJ4ZUNOBNUDF9GrHnoIKT4qsnzJAJTXkfNWCZtRW6Iu5XK3cAgoMSPSKoJLxqOLhO/7kbF5T/7s24wDSGD+/I3YS9PgFTgEmzy+sseXDpEnxBBbDAfGrHjOIb6j//CEm2DtNz+wugy4XivbzO0lAH/QlvB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=De7EFfY7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DtERtwVr; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="De7EFfY7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DtERtwVr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781769872; x=1813305872;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qk6Cg0kU0xZnXI3NBIpenPLadIGvc+Pv/9Co45zYy6k=;
  b=De7EFfY7Iv5NWWX7c5ImBaPVFYbQLbIkIGheODY8S+7KQSU9goX8sGFU
   Fr2A6ynixaqqYTCuiPSNdRfiMsDXLMNzItbSlLfxb+mCMD2J4TCXLJcgR
   Cmr/hbIQ7QkfT4BFbHSJ2Rz37gVV5czklhH6wjs4DWoByYLNln+WgvudY
   YBR+OMQEqad3nebsc1Y+78TBwFQkxiLAI5KHHQ6AthIL3KkkvmMUPbvYW
   5kebDKU8U+jXOEFmUZ4OxHIpi42k77/s0HMHZEgpHkBywqCnvTzCubzqV
   2vOp6/z8BWoOkPKQ/glqZ1aVYSbQl+JK6lM9PolQQbVUs0okKsRrGiRot
   g==;
X-CSE-ConnectionGUID: njTgR5pZTVy09cScrGpXQA==
X-CSE-MsgGUID: Q9DviaxnQuSYtLVu3saZpw==
X-IronPort-AV: E=Sophos;i="6.24,211,1774281600"; 
   d="scan'208";a="145255117"
Received: from mail-westusazon11010014.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.14])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2026 16:04:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGeMBq9X4AUosNkt8UuH6sNSqVBmNAfpYGyWXielkwitueTflTnv07wVJd0Sdqzu6rasL4vUJHwPp2SYEonput9sFofi+Wgabp9ld9O6248m+8ooRWvwND1lsPxQ6Fj5cGcT9tRpmtSFxZngidjVa8UaMvzCckMQIglP7ct6AkO6x7v+7EaI46ftbFpRyiaUN6iJkzc9w84IIbSBoYAImjuO/eGYxZSlDexoF1/PqiMMvqNcpudENX5w3h91hyILpA/NWYsFGqUP/O714yqHLVriwLVDXKH9EsIepgrUaoXcuhrycM2pkKR8g6lvSY0wXNxHN4MTy5r5sNmTvvLzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk6Cg0kU0xZnXI3NBIpenPLadIGvc+Pv/9Co45zYy6k=;
 b=JoJeYtpwIbkjWYhSL2Po9/QM+kL+1xCxa+kmYVFAKOS54lx9LLe2hEw7itYWFRC3KCPK4FUcFbDMr9gexcdN6pYka584l2l3Mi53kEML56Q+AGK2ri3VOIkIL/qmEwf4epTleKLWlWowRXpkdb1q8eKxwarxpCONU4d22d8CL3O0fdZXdwoWnSN/qc1vQ0vccQrL6JN6edZBctcMogIXNb4e3xU07VGTdBfR3kWP7HAc+5zFsdjk2dVKa+FE+Izwi0O4WBXrpEjDY8EnbwhVlOAMealMG5LlI+qEh+pABplg/kZWTsxGOkWiyGkldgbZEsMw6CtHDfWOkRjDgc3zMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk6Cg0kU0xZnXI3NBIpenPLadIGvc+Pv/9Co45zYy6k=;
 b=DtERtwVrAfEj8d0LQdAmQYrGwwLlkCTrW7FxfqQJ37YT8vmR0VgRi0R0IaTwld4bYuzGzP9TICrOOWFnGguimWWtEEwc4Ttw4PspDLC/OpsyUtAsRArTkxkqjQdo/ZevekEiUvURYZtTyBogjZqK25sSGN3XvwICvdxTDeRq5Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SN4PR04MB8349.namprd04.prod.outlook.com
 (2603:10b6:806:1e8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 08:04:27 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:04:27 +0000
Date: Thu, 18 Jun 2026 17:04:21 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 0/1] block: fix concurrent elevator change failure
Message-ID: <ajOmO7BWZFaR3Nn9@shinmob>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
 <aiqaXfTqCLMu2DwF@fedora>
 <aivMxPCd305WbBsk@shinmob>
 <aivoHk4DE_pkKkDm@fedora>
 <3db036fe-747f-44eb-93c3-595350278297@linux.ibm.com>
 <ajCa9GrGoB4uXRpS@shinmob>
 <2371227f-43ef-4a0d-ad8f-da23eea43357@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2371227f-43ef-4a0d-ad8f-da23eea43357@linux.ibm.com>
X-ClientProxiedBy: TY6P286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SN4PR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: ec38285f-aeff-41b4-7c4d-08decd1037ac
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HzYRKwV0YyenxGgY/aFh6R0ZucBnLRg1Fd1rmM3xhFvCyumXVHby2u3VV78dfi9mcyXW1rmGWJQIgw3tFsn02m5rVck/PUl8k8OgehgMnbxPuWnt0NxVfKvlSbhWGy6HeK50OI7HS9cFDLUpeRkAfwI7yK37KWYh8kXOklmVghuN00F0PJ4LO+1+x7XxF9YMQIImryHo7NoE/T28dQaz6JBQQ0oXNw3nKzzGv1b9PQDJkvStfFS1TvtpLiK2Woa7hU+dLWD/0ixoFn3XbSdl2sZFHmpTwxrVoo30spRqh+PHILb3wPkVQZVSxsF8h3Bq6VxaV7jiskIUQyGzeq8hnNI2NyIFsSxibZKbVkwsNbAVzC5lRtS4CX6NqOhovlTHFU9qNhnFluiTeGta1vSUSWa+XTLLhYgGhSJjsIrI7rC4hj8ClYVPJ7Y0xICpoqYqczBFKvDmyNYBD8u/Xe6yRBDGWXUu4EnstlqiYWnzLTU1UkkjAWFVejuRidGpWoygUbkvCMDY0lPdPdC/pp6t7Wyn4l1lFJ7ZlvlrRX7STRZp9U+V7ZbXjf31B5tukSOAMwX/f2PtwxLpimE+DBbkaBiPtGTlIy/nlNx8F9PkUQ2QevFcOHgNSO62+Pu3RIvggjiufW5RJEJcdwkFPYCtczwIA7I0Jy0GKs8Mt/NCK8mNlR/2voPw0Jzoy3sKEFcv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zp0QObuYe1ArHRW4MdULBv8Zp5Tbxug8QnIb8jtZtQ/s9SKPoRNAIFSMtK83?=
 =?us-ascii?Q?JHahmCoYPzal1SmEYzQehj6wp+qr2EmLov+jeZWJtv9bxYIx2lxDgaw6RgXP?=
 =?us-ascii?Q?j/qpjHpZUtQsOisyz4ARRqM0iEfviczbK74re+zJbCl/Nun74zQuEYC7N7gy?=
 =?us-ascii?Q?t5n23yk3Xiw7fEwpTRCIxNm2CSeY87phV5zcgZO2eZT1CzgJRYFaMnrgD07z?=
 =?us-ascii?Q?/mgxLhsA466CdO/8bdoqVie6d6wzeNMCcynrLnBKz9ifowpZ0SL6IHxX+Nas?=
 =?us-ascii?Q?VhsdifU7wm9Ga/FpaYCJ/QsKjgc62irsQiJPdCrVsvUsTNJWbqGN++FVAeGm?=
 =?us-ascii?Q?r7aDa7ayc+QTooMATPoaVigFp6zdsp66/iBi0YKw6C2PGIZFchoc1eEQ1YQ0?=
 =?us-ascii?Q?wrdQw64cUaAzDjb7tdJ7cBpL/y+omBR6PpL356Fni2a1XHymPkUvq/9aDZAx?=
 =?us-ascii?Q?RCXKLg2MplCNKaQbVedibyPaA5IUs11/qK7PrWjCI1OLsBKRVTclQifY8XSq?=
 =?us-ascii?Q?nzKfC6XTcnQbzKBH0UebwISudBgfz0iBhBJuhlR53wPA6V2T2azj3VQN+/Ib?=
 =?us-ascii?Q?Q5m++QziYV94p99yR/8CgY8OwbHvOVByVcUmQ/DWDB5j8uaQW02mhix6WC1I?=
 =?us-ascii?Q?McaJF8J941bPXhZXCoFReeD9NIEieIUrk4wcofVYGixzQkaXPes7CwlcD7tn?=
 =?us-ascii?Q?Y9G9DIxZzLDRutMaFujj4NKrYz+pVU7wQXlgnoAMUPRvSFGYysLRJFRCjXh5?=
 =?us-ascii?Q?NgFJxdb4l3TevZRJiTBsI5x/q8NesTr7qL7VHas3N1UA4pi0BTLvQ3390LFh?=
 =?us-ascii?Q?6bzR058dgH+LVZpw1OXl0C0a/QvjYhnB/2JDT/kFMqYhLC+i2c1vKOSVPnS4?=
 =?us-ascii?Q?DyhXzXvLig5RFA51RMRLul5ty1Iz7DJ20mIBmtm9vdvWKdE0Xt1jMyOIZ5ph?=
 =?us-ascii?Q?OdcIsokrCPR6/ArDqgxDrLnrEvtd/Bkr4ONj+4Na6M1vGLl2/wJjtsbmmtP6?=
 =?us-ascii?Q?pB6ZSBOL5vvc6SRcIewoX/ZA86l3OM/QC1/yd7VOHhFfqcq2dRPIPaU4L+Pl?=
 =?us-ascii?Q?JLa3FunWTE5Wrm7U86lVZ5SL838ZzU/JnOb94uLGtbCw3d9ETW04gWuOh37/?=
 =?us-ascii?Q?A97uWrAaTAhcPdGrMji2ZGTIrz4ecCmrZhCJnypU3b6RY4aS6c2C6VMdF1T+?=
 =?us-ascii?Q?i3TT5u30jgEUQQ1uNjaSvgg7h9zXstv3KLFwt6wGGb52UTQnbnWU4/ff+tyM?=
 =?us-ascii?Q?3qjigNXgSZiicyzywG2XfodUpdi1W+HYMXjN/ojd/MDpaRzSztPiOiszpt7K?=
 =?us-ascii?Q?gWICmT7jFYB6dIaRo/4IVW/LqM3UhElqBfwq4nygnfwjXMRz4edl9rZzxaMa?=
 =?us-ascii?Q?QgP3tXCzM8GzgEfp3ShpGvNrixCeyfw79A8PGIkduZftbmHc0dY47K2dPfJT?=
 =?us-ascii?Q?MDHXqmBo8eW+XxcldUPYqVZ0fAZWMd6YwEUbUKeesAhE/5C9l25XTlZDk2wE?=
 =?us-ascii?Q?Jc9Razp3wIKIB/lz/5YLAV3glT2aK9OOoB5caemeouF/ZRNQvXaVTMloXQL2?=
 =?us-ascii?Q?KSZCOOQ3DuAHauuTpBBOgmuDCxsL3RkQpUFzDDHZ1lf+dJUfBZmOvTo3h+P5?=
 =?us-ascii?Q?VojEzV6W+lERTNFc1ile7chZLrslev6ac1C69PaDbsB7zWA8YFQTvw/f/pTN?=
 =?us-ascii?Q?S3SoVSkQmmG5dT/6VwMnzqldQe2swtSsoQKRe8md5VHOlGWkpq50jdAo4Kdd?=
 =?us-ascii?Q?K3/AkCIpxJz0FG0qi1A30ukeTrmALiA=3D?=
X-Exchange-RoutingPolicyChecked:
	RP8qxtXm0kuI66G22MGtgZjxOus2JCVdDZgbMgzTduLg4L8RunV0FOCIq9i+hrYHj8HDXGgadHra8ibcfjVrEg/KzefigWEUyqHcjO1yBrcAqoWj3ASCXkckcrZ5RXBdxVhe0yr0z3NVPdbcxp7Ecwg9BsBECku2eNlK75bR0hTCLaYT/u5aQaftn+LIZpysX/4sq/7JI1J4YnSsEYSUZWUTV5HTiIikOcXHJD351iDHwlyd49r9FCXKMw1Ku+4VGFbHOYQZ+rWFASufMpxcMXMPf/vDTMZwoxtG5QWTdSG2TWkAGDwjOY7EHTlOV3SrR2WUQEXSfKmpbz63Pf+FKQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EtxDx4a5dbkT59KOU1LKporgxOP/Ik7/EYCWoZwn2bAl5sA3XDCjVRJb+qBAB0pAa2kqOdwPFix40hDwM7vcgmkhSLBWO+7NUVVEfMrFlNk1eWRnbsE1sR1ZLhZNlFRXwMZuPStFSw1SJi+yV0Is9bbRDI4Q4thumolync2txCR/0vkW8YwSIZw4JXJLVRUX1Y0lN3D2oF9FJz9bjYwIH0W0aVUVvqy0teo2UXpzIgs4BXqVzhA0QInNYkun58LiL16nsrIhTWBV221m6V71zydj0Di3RgYgoKQ35Uzs5oVLjyQrHrQG2alnx3TowOxaHUK0km6/EWqyX2B6HgzdtAtCVMfLAeW1UnerP4GjW0lz9j2w75DdUWepy1EqtCKNL1W+4fn3IPHxwsfFc0t64/OUlFBx0NoOgV4lXzNxcktjW+Z1XsU40IEiyfQXIUI+JFtB1YH4mY+FvN2B5XgQ2OMdB037ewhNcZJMjAZ+dm4shXZAwlSDzod8chHrBACE3gJduLOfCg90RXPDO0mbsS1FdIn2lNwApy6fTUsdsX9F4kkDNN9bPo420hYqsKIRPW3LcGNcGs3Q03cBULONvFWeup5WqjCPrOq6gfr0FvNe4PlPoYXCVznk50BvEjA6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec38285f-aeff-41b4-7c4d-08decd1037ac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 08:04:27.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6VNtiDI4e3lRzn0vdS9N319GbfbOchtEEA7NxSrX0J5jwojF9VB3rwFOUxA8Vwv7wB99QW9CH95KlK3VHItdSn1yFqHJLf6oSUgLvtAgMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8349

On Jun 17, 2026 / 16:38, Nilay Shroff wrote:
[...]
> Given the above, I'm fine with the earlier approach of upgrading update_nr_hwq_lock from
> a reader lock to a writer lock in elv_iosched_store(). That directly serializes concurrent
> scheduler updates and avoids the race on q->elevator without introducing additional lock
> ordering concerns.

Thanks for the comment. I will prepare the "writer lock in elv_iosched_store()"
approach as v2 patch.
