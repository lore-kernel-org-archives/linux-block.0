Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795833040;
	b=DCc9tIlT0wI2sp6zlbKcuCpjylPEppZViazeKy0R0wjj13CjSjOrO70FovjJfiXW9Em4
	 WESHTqC95g1gh+tVO0uaYn7q4KG6PRLIrGM4pgnwxGN7ZVRUSCRYrHy3/TcVluDdyNW3Q
	 2tVsj8AfGc1SvVcJjMPgrD4s7NxIJgdV6dX7Jc+cFP2LTFWfoHnEW4iybW9zWwblgfFo+
	 3g7AOnymGEcHYtnkqdNFE7Ibm1rlEu6mNB0IR05LGh9tWhkaWNJsS1Oxwa9XpplpRhCGs
	 xjzMRQvRGKSuCu/Z97DH53p2OYCSm7NKetzmlO6zhZH75QNbM342u0fJ5TFjBY2EsEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833040;
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
	bh=/npjpJwdiiPjqPyVOpI+rLq5dAuKJ9Gsmu9khwAwt6E=;
	b=RF5QUVbcGQ/B0WqtW8qEPPVK9tGKM3mlqGeF78oihPlBfs2U3XAc4X9YH3nhJa0sLv1j
	 M6kwPSM9e3xAN6ZjMFPr7e44qSirs1xrzvJBk4oFhREx+kVHiL7sYsybNV+oVubODASV4
	 T9Xb3o+yaw2U7FOo4QkSOKCvNTlqIZbxl5zDfY1ZXJizgTp3crSIYlQEsJL/f3YZ6ShY8
	 Adq2Yy/yCf+7uCuLHa+xiM7SXl84rKOnYL1dxWi8oV1A0fNtlQ2O+suZTMv2PZBlKC/Hd
	 m9trK5Emvb56a4rPhuMtxzcbdjLKHvV+duY8T8lzQ+TbTbS7xP3hw2FAVmY+7sRu6Gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=msQnFLGm;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="sVgBpY/x";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743F606A31C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E743F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=msQnFLGm;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=sVgBpY/x
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795833040; x=1827369040;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3tqgCM8GMzK0ATyAT+w5IMJ/wiLdxCM5+P3LmHtO/VM=;
  b=msQnFLGm3svMZ7AYcfDDw8TDpPW7G9Ne1EXA52hwD2sBLIMhBEOcyJY4
   ohiDMxSlBLAsi07tdkqu3803DGhWBSn5Wh1l/Taik5+hgTPMvpVhQ1xOu
   L/0RylB/85YvLPEj56au0K/9Pd/3Wj95Os1jBlXzOzQsn1gvpJNX+K7Tc
   wc3vS/kFYDi/H7qkpEq7pFQq63e353nfWSG+8xnTTMAziC3HvzWbdQl1n
   7uEgZajDIymFYCw0cwZeF4n9DQdLgakAfGDck73TIHfiWRYN1lU/wCBQn
   Xy+rXGOCn4S8C6XnV6x0l1cHEWjX0Yr8dp4Q6u9iiCjPTSVIbzxkBDWyO
   w==;
X-CSE-ConnectionGUID: sI821BFpQMSQ0mn4+v4PWg==
X-CSE-MsgGUID: 9rsKty59RiWeq/6h5fz9qg==
X-IronPort-AV: E=Sophos;i="6.27,238,1786982400"; 
   d="scan'208";a="161943681"
Received: from mail-southcentralusazon11013039.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2026 10:30:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2L1YNWLf2waQh4SymSpXvpL8KYRAKk2BfekRICShroVfzRQAzrrtLYRWlkqM+iszbNF+cQYGnuzhi9y669VoRw0UKrmOru5KHezMm5E7oIvRm2ZpBnDtcjjscaDw4bf5UEv2p7dP60GHm42+BmZKJxlDra449oX9Ln5mHLWcxnIjgfxp48NYaokAlSVxdwLL0AiPLIy2OTVhVebbxz4OnZqtc++7hJ0BPUvuwZVnX0rxjXRY4qIg+WU7LrNXAlHScha1O8TlZvRbo8NW/GeXk4OVTl/TVN+8B4cGlFirlZA9e7hAoEr8J9YXTsFLDetFM3Lmr4OX3DdnMHWPDXfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/npjpJwdiiPjqPyVOpI+rLq5dAuKJ9Gsmu9khwAwt6E=;
 b=B4JJZphWVd7lA2ePivEhVLF1U71UCnNXf6ApCq/tp2livsFDm6WjVrCu/XYy4LVNDUzxbqEnlLVhkaELAd5ETTaDuWVIF6BeZ5LsoxVeXXgG95AryhoGJVjQtkwKuJVY6pP4xJaC+4BITSoK3ZtdQm2EDTLwpToOVo9tjy2iZuKWrdjV6IBIOj+FQ7Ui4PtlcmPY1st39CFdHXNqqZe23x6rrtpCnnwrAuOHSlg0+4RH8lJEauoucSGNa8AJThCYg6Ldr95bGOPAT8o8PcZ9fNUTXxIS680YvW4PX+ShTtWsl0A2z0zfFpzDpATldY1fumenNfUsaJp9oMTfI6sNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/npjpJwdiiPjqPyVOpI+rLq5dAuKJ9Gsmu9khwAwt6E=;
 b=sVgBpY/xV7E+3szcIKhX1T3tPD9hVM11SGfJSH48ZsZio0RXcQeopbYtha+Fz2PblL0bFA4UgSuK6sznJshYtXh2xa18k+36KzDBMqEEYcbGgY6ssNV7ESDUrze0XXpc0PTDSwg1P/sZGYbb38+a5wYt+zWucjp7OUa3JVNJ+G8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB8563.namprd04.prod.outlook.com
 (2603:10b6:806:338::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 02:30:29 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 02:30:28 +0000
Date: Sat, 28 Nov 2026 11:30:23 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 6/9] nvme: skip the DH-HMAC-CHAP algorithms
 the target doesn't support
Message-ID: <awo7lbuEbPHHuIm-@shinmob>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
 <20261118-nvme-target-control-v2-6-d191bbbf5dd6@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-nvme-target-control-v2-6-d191bbbf5dd6@suse.de>
X-ClientProxiedBy: TY4PR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::13) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 03576eaf-c77a-4810-cb30-08df4cf7912e
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|23010399003|11063799006|4143699003|261009223027099003|22082099003|18002099003|3023799007|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	X0FsL1A338AZqi/36kKm7Q10+a2Us9UdCK87rdsQ6lGom3APrpGPZ/ugCGMohskSGeG86Tx5oDIp5vnVdM1Az3OjXRW7K2EZSCVPT9I5U21DHuhmSzZlD4+AMwjRAFeIRX9t/QAd4LDAh8izoiOOrpwE9JU9QVfDRDkyopytU6MSuz+piot4kRRdMOZs+EZU7XFKLs7m7Yooy5ejkZtS/XG8CkSWJnT07E0FkYnu6kZUg/Hnsza/ofkfF9uwe8slleUVQofwRmKvgt186u/otn6pkcu8IGkEcG1PuE64Ik9vitVa0OWNyWJlov9V5baO3uepcWBpD4Yae6gCWEOGbVbxYxHwL3EGRPJ4kZ3/H1w+hwBUYBPCqQmUuYieO2PVgu+/VayYQA+GNJ8yaZFvAII+z3G3UIS6HYu/CCUGgbDWjJCe+GtcM+T2mZ3xq69M7vH0xdJZsEPnRM3IIIXXWfVM7eJDqauAAfDsB1yXoI65DGjb7Ark327tH7dS6be7dCiFJiC8ofc4IWAbfcHdNhEgZCPXHN8DEyf4JqM25Y9ve1RCNL1+P4ggHSoCz8TT1JyqF79eS/wSid+jkG/TogQo8awB6B2QDL94wpQkmecab/3LhmVqpQr2V6m+hvHZQQgy+M4rgqwS7/SQwaPB0RlP3Ftyyl6vnvjy33Y1BGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zT6oWjaNcmD7p3p/2ze2oaH7VInZ4+5QhNGoxUuO8G4XDbnylWnkDh+bAl1z?=
 =?us-ascii?Q?bPQwqn+DuZlBVjTIasNdqsRmpSQPmsTj0VNdcZqvQ6MUwbarO5UE3u1lJLli?=
 =?us-ascii?Q?8qt+nt3cn7beZ7BHAK00M1L52HmPgXk6NWBKfrv7inQSzok19drdc1i0DrY0?=
 =?us-ascii?Q?39RIKZZzAUWF1w7DstacZqoUKeL9P3nWDKqJ9LVfD5oGKWaXrCl16xwjQZfz?=
 =?us-ascii?Q?lrTsRqgbXvMKazm6URXHvtuQwH/rei8a8+9oXgVvPZYzbD6N888vuIsO5kdx?=
 =?us-ascii?Q?bzB87OZYWIvCn2LpLJEL6JnKp2y/Bs/HUjKhtc6oLU2+s5F5IUYihr077OeL?=
 =?us-ascii?Q?9Go80/47rDQukjN6C+d12oNNX8I8X19rkgMJ5dCgGG7nbcjcIHWUHaoQMP1F?=
 =?us-ascii?Q?knyuGv2/ORYkv5kYwQuevdU2qw9U0WRjoy1THqu5v1MOM8ND+l4Rs4jXAgD7?=
 =?us-ascii?Q?XExE4Vj628TqCt3a/Zrj+kuRvJggIng+BgqDmbZXBicyxRnyyMu1jwFQXyr3?=
 =?us-ascii?Q?RZc9WrLprwkOOTjL8POhmo49Bp3GOWR1aUmj8ufjOpqU7x+vLNb0WA5mAl9+?=
 =?us-ascii?Q?yyYIj+Nm3cYOmei6sEnpAtaLMgYmF55Zck8QmLw9g2mlaqhBJB634bRzTHQt?=
 =?us-ascii?Q?0KubVMw4Tj+b2gsGyYlYPe91uq9844QLPLRNI+/54xTb3JNemSD2ZJQA+rlC?=
 =?us-ascii?Q?5LUXGOtNP14yqwCDLPVgld39cjFcTFgj07BXZWKYdzV4sqy2Ww/BrXyk/B2h?=
 =?us-ascii?Q?ebn+9gqdCgZ/kZRxEOliRAg6qpuUUK58rW3KNxRG0mmeXzEx2o0Fgi2dX2FT?=
 =?us-ascii?Q?JjuXSaCMjznv517hs0LDbKnLN4nqp9qQHjeixZdRMVgNIDal+lCYvqmP7s+y?=
 =?us-ascii?Q?ekvyIlwiNREaehp1sQcQGQTWZ1zf685Jro+HtZAKDTr0W9Yw8KYotSZiN2DY?=
 =?us-ascii?Q?r4qTQhKnXr18ubUwlFnvt2wJCotjY8y5ko/9UE/mxntmjHYvkZl4hw8Hca8l?=
 =?us-ascii?Q?P21lna9wAMgbVbBnyc8EfP5Cp6WHoPsyMkO3oRTdQ2q+w4sLPDtqVdBcOdN/?=
 =?us-ascii?Q?MDXSUWQic/gITU0FgI3OUkltDYc7lDejqSjS84Hjl4EGPkcTuTRSnzDs4lfK?=
 =?us-ascii?Q?LBlEWq2nDAHa4t4Ugx+tFsJgtTEl5Yydnm/zKVqkURRbWNYXfGFAvf3+uRxW?=
 =?us-ascii?Q?aSasUaVO0NB3rXjglx43SwWhktaqZ0rUKWbUqDcrRdyRghLIoSBgik/9aRmi?=
 =?us-ascii?Q?neOi/fZIlhRLvH17pdA93tUrz5bCJkYNM4u3ol/HBEtQwbvExEu3lVtxwxG4?=
 =?us-ascii?Q?ZF+SxcVCWWlLwFdW1Vnpt5YptzSdz1MyxgHqa6s0TWiGnQ9Kq3tUy9VHPs4s?=
 =?us-ascii?Q?nn+qlJy5b/fq2UyJEDg8EhYMRinNfdJJs/VuZC+kbvMMNJU0+CmT6BvaJF62?=
 =?us-ascii?Q?lD/JHo1l9wkXpWN96QMYVxxoZLbDVIdnLCWSrCO8V8+aCRP6+XSTbQAsgMxW?=
 =?us-ascii?Q?tE6R+XF3/7HGsgCVIZ727JC9FfDOdQysK+zpepc9IBG8eH8Z2uxfRZnUNpe8?=
 =?us-ascii?Q?QPCYp/U7rv8MnLfytt8PIkRdhiHcvbwh8UG21VneEWdamtO7tu8+GxOL89dX?=
 =?us-ascii?Q?fwvsWFYtD6MwsspUfHNhc54GljjXsP9WtYK58cX6tcaMU0ItYMJj2TcAuaKM?=
 =?us-ascii?Q?MhTFjXFiU5KZMV49hfhyitPIonRm4i2xWkzEc7qVLEkU4Gum0fDqHNYM2O11?=
 =?us-ascii?Q?HcLqkyY4AZlaD0v2IjZdc9kvyqZ7hPA=3D?=
X-Exchange-RoutingPolicyChecked:
	NEAwc/6Oz/oKzhq1qUxAg0YyIhgppPfjgUSjWvKG776QbrjsyZ7et49WfMFM5hfc52VpnPokCULQg2RwYddqITLLK6HTtd/bxFFMhmYP6DnOwOO4ECjZM/JA5FiOUe8/w1kDAN12V7KCPtUpizzS5uJdUNNQ1S5RBQv+BsbZmwBMo/Gjv3wNojc1teAUAwKMKIvrUJgqCArPjXqy3iiEEmuzWzmkwb8+3G3dVH7IA0iBDBxWB9oVOSUZwnz0MlkhRh/fOHGrxFqgeUu9RLC8wep0X/kJtNy2XRd295ezsUP/ZTfpW8ffKayFzInLmSuhP82uNEG7GdhOJcOPwJ8F+g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6akfU1ofcK50MSYfxOtWJCoVNx/OYl2Da6pLVznRY2F9c8TouvurjIj7Tnc+Q3nVrcg1IRyyz+G55pb5DulDLtaTXMpMrTdjG479K2BE/QoaIF8PFHjFz1QsLI3FQAVf//OWAMv2hv12OZ1LdjjudS9vdvYgB0/CyRnnxnpxyXoZgmQSwW6tqFhnX8z7DXv7u4zXKI3LzRtdoj+disvf6wave0EKRwOi5Q1Hzax1L6pqZHq+4qtVKigxwQ4gQixen2rIRJC0JVqes0xSySF0Bwn3BXmJQEOKBCvinl41MuG9hXS/hK6ZNFOP8igHVhStT3M8GWS+Y1VCc/C54f2+dbaX8sI3Nl9ueQWZJ/rWkvyn0enYUip7BLyG6TXASGc09TRHU5vRItKIG7t/JKIr1J+0QPs60NrZOzzQfR631T0Ir+Tw+wZ1vNpWtsa+UIYYsU2kRFA97qSaWypCo4hz2xxd15QhFSo0wH3EswkzgMD0pS9OZHxNzNtplJVoDFDRcjOeOOCBBoefDT+yReb9fBn4UOqtd91zl5e93JOBkDPmAqIuhBq5oTA/Edu/80/01xneWD+i0oq0YDquP5ORKTHVqa/7pHaMuUZAmxXn6ifUV9F+bpp3FXmf9pWP8ixK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03576eaf-c77a-4810-cb30-08df4cf7912e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 02:30:28.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErgDXl8+C7UqdVQsxTdINHqR+W+8D+U8LzYS37FjEEmmqaDYQLl0DgPqYZ9cxRJJ5sCCRCfGKOlhiFchlhVYPxzPTLs86rBC5xJcUkFTcbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8563

On Nov 18, 2026 / 10:26, Daniel Wagner wrote:
> The authentication tests fail against a target that can't do
> DH-HMAC-CHAP, and nvme/042 and nvme/043 fail on every hash or DH group
> the target doesn't support.
> 
> Skip the authentication tests if the target doesn't list dhchap-sha256,
> the hash every DH-HMAC-CHAP target supports, and skip just the steps of
> nvme/042 and nvme/043 for the other algorithms the target doesn't list.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  Documentation/running-tests.md |  7 +++++--
>  tests/nvme/041                 |  1 +
>  tests/nvme/042                 |  3 ++-
>  tests/nvme/043                 |  4 +++-
>  tests/nvme/044                 |  2 +-
>  tests/nvme/045                 |  2 +-
>  tests/nvme/063                 |  2 +-
>  tests/nvme/rc                  | 31 +++++++++++++++++++++++++------
>  8 files changed, 39 insertions(+), 13 deletions(-)

The commit message mentions the test cases nvme/042 and nvme/043 only, but
this patch touches more test cases listed above. I guess all those test cases
are modified for the same reason, right? If so, I can edit the commit message
when I apply this patch.

> 
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index b66bdf9cb2e8..d556f1d3b7cc 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -261,8 +261,11 @@ The blktests expects that the script interface implements following
>    --subsysnqn SUBSYSNQN
>  
>  config --show-features prints the optional commands the script supports,
> -e.g. add-port, set-ana or set-host, and tls if the target can set up TLS.
> -blktests skips the tests which need a feature the list lacks.
> +e.g. add-port, set-ana or set-host, the DH-HMAC-CHAP hashes and DH groups
> +the target supports, e.g. dhchap-sha256 or dhchap-ffdhe2048, and tls if
> +the target can set up TLS. blktests skips the tests which need a feature
> +the list lacks: the authentication tests without dhchap-sha256, and
> +nvme/042 and nvme/043 only the steps for the other missing algorithms.
>  
>  contrib/nvme-target-control implements this interface. It configures a Linux
>  nvmet target over ssh and can be extended for other targets, see
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index 9c3d9aaf4e12..2571c851be4d 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -16,6 +16,7 @@ requires() {
>  	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
> +	_require_nvme_target_control_feature dhchap-sha256
>  }
>  
>  set_conditions() {
> diff --git a/tests/nvme/042 b/tests/nvme/042
> index e771cb6ca4aa..f9019e9640c4 100755
> --- a/tests/nvme/042
> +++ b/tests/nvme/042
> @@ -16,7 +16,7 @@ requires() {
>  	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
> -	_require_nvme_target_control_feature set-host
> +	_require_nvme_target_control_feature set-host dhchap-sha256
>  }
>  
>  set_conditions() {
> @@ -37,6 +37,7 @@ test() {
>  
>  	for hash in none sha256 sha384 sha512; do
>  		echo "Testing hash ${hash}"
> +		_have_nvme_target_dhchap "${hash}" || continue
>  		hostkey="$(_nvme_gen_kxchap_secret --hash="${hash}" 2> /dev/null)"
>  		if [ -z "$hostkey" ] ; then
>  			echo "couldn't generate host key for hash ${hash}"
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index eb8f8b035f6d..695edaab9741 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -17,7 +17,7 @@ requires() {
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
>  	_have_crypto_algorithm dh-generic
> -	_require_nvme_target_control_feature set-host
> +	_require_nvme_target_control_feature set-host dhchap-sha256
>  }
>  
>  set_conditions() {
> @@ -45,6 +45,7 @@ test() {
>  	for hash in sha256 sha384 sha512; do
>  
>  		echo "Testing hash ${hash}"
> +		_have_nvme_target_dhchap "${hash}" || continue
>  
>  		_set_nvmet_hash "${def_hostnqn}" "hmac(${hash})"
>  
> @@ -56,6 +57,7 @@ test() {
>  	for dhgroup in ffdhe2048 ffdhe3072 ffdhe4096 ffdhe6144 ffdhe8192; do
>  
>  		echo "Testing DH group ${dhgroup}"
> +		_have_nvme_target_dhchap "${dhgroup}" || continue
>  
>  		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
>  
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index c1a48f1e3d86..01a153e1f2a0 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -17,7 +17,7 @@ requires() {
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
>  	_have_crypto_algorithm dh-generic
> -	_require_nvme_target_control_feature set-host
> +	_require_nvme_target_control_feature set-host dhchap-sha256
>  }
>  
>  set_conditions() {
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 14f4949e198e..52d04ce40860 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -18,7 +18,7 @@ requires() {
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
>  	_have_crypto_algorithm dh-generic
> -	_require_nvme_target_control_feature set-host
> +	_require_nvme_target_control_feature set-host dhchap-sha256
>  }
>  
>  set_conditions() {
> diff --git a/tests/nvme/063 b/tests/nvme/063
> index 20aabd91ca80..578cb8799a6d 100755
> --- a/tests/nvme/063
> +++ b/tests/nvme/063
> @@ -19,7 +19,7 @@ requires() {
>  	_require_nvme_trtype tcp
>  	_require_nvme_cli_auth
>  	_have_systemd_tlshd_service
> -	_require_nvme_target_control_feature set-host tls
> +	_require_nvme_target_control_feature set-host tls dhchap-sha256
>  }
>  
>  set_conditions() {
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 41811c033069..0d74c427313c 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -155,18 +155,37 @@ _require_remote_nvme_target() {
>  	return 0
>  }
>  
> -# Skip the test if the NVME_TARGET_CONTROL target lacks one of the features,
> -# the optional commands and e.g. tls, see Documentation/running-tests.md.
> -_require_nvme_target_control_feature() {
> -	local features feature
> +# Check if the NVME_TARGET_CONTROL target lists the feature, one of the
> +# optional commands or e.g. tls, see Documentation/running-tests.md. The
> +# local target has all of them.
> +_have_nvme_target_control_feature() {
> +	local features
>  
>  	if [[ -z "${nvme_target_control}" ]]; then
>  		return 0
>  	fi
>  	features=" $("${nvme_target_control}" config --show-features) "
> +	# shellcheck disable=SC2076 # match the feature literally
> +	[[ "${features}" =~ " $1 " ]]
> +}

Nit: I think the shellcehck exception above can be avoided by a local variable.
I will add another follow-up commit as below. Just in case you think wrong,
please let me know.

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e4fa9e0..879eb40 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -159,14 +159,14 @@ _require_remote_nvme_target() {
 # optional commands or e.g. tls, see Documentation/running-tests.md. The
 # local target has all of them.
 _have_nvme_target_control_feature() {
-       local features
+       local features feature

        if [[ -z "${nvme_target_control}" ]]; then
                return 0
        fi
        features=" $("${nvme_target_control}" config --show-features) "
-       # shellcheck disable=SC2076 # match the feature literally
-       [[ "${features}" =~ " $1 " ]]
+       feature=" $1 "
+       [[ "${features}" =~ $feature ]]
 }

