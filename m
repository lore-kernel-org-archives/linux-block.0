Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8A40DFB6
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873737; cv=fail; b=ogtxWhuCfYhuuesc5lzz7xkPfh1ZG37LnmT7d1/60ftCOwNZq18rZGFLb7rZCtOxVBkQxhO1c6JH+qcGlPJ1P9SW03NTkdfQjNk3TLtvSTWV8vcbP9bBg6FKHErNhHB6AOSpZzKvcjw/ltler6IlaNfCWTPncAEqkqHpYWnQedQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873737; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jqu5g4rUS/qo5g8HghEVm3tVzXpcIrPRvTK39vNoxHSIcWvTAt4ve4CzEjtN5BycaXDxnF72LoY+qqHHJKb1TrSmgDeyO80bcR15Pw1kgDsvPAxm61RkTLlTP7F+9TBce8LCscz9k9fNVExiP+GLJQ81BOdCTel8JGHgfWvdE/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ADV0N8/+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KGasX/Md; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ADV0N8/+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KGasX/Md"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774873734; x=1806409734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=ADV0N8/+hKD0mydSSu1hQDUV3qjoXcjPJGyJI/VjpOH3lT5g5ZfXTsot
   /hHCCU3D9L0V0svnJu/avhNPuR3Jo4ieuvSoTxbOrjQ21RDDhmJp955ZZ
   wefF/Mt70rtFDvzpzKgbqUjAoJQR5+jdcYV+acyzCe0PLjtnOMl6qrN/l
   gftjndkODnddBQ8wBCYlpGlz8Q3Gn+HCYxmKAVeyhCqicp38R8uGOjHi8
   NSB4qKAH5XC1HpETRDQVv+29M6zoa32vleYmCcgUHikRan0ZOOZaMCYmL
   9JF0zsPickuRPQ/5iR34Zz6Nuj0Yd9VaVutUIWTc7T2ADfXdqr9S1/cEp
   g==;
X-CSE-ConnectionGUID: 57hFmxybTnGenIw7eet8lA==
X-CSE-MsgGUID: 0iVnLwefQDi3/yrOLMqdYw==
X-IronPort-AV: E=Sophos;i="6.23,149,1770566400"; 
   d="scan'208";a="139825596"
Received: from mail-westcentralusazon11013030.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.30])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2026 20:28:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFDiqpseAZcdK1MSvB7H2I8m5SmYbMK02SyVBepN9nPvHpeiQfWqDuaqFtj5T+WdprYNHxxdmKJToaeKF2LFI7kleb07H1cMYxj+MuSKihe2C494gYNPsCdwdw5Vgy2Q2fr/rMxt+pSLyE4qNZhSkXy9im11gdnPJ1YQIHYTBPHmd9vDLKhJsneu5xUpYWOdokbB1NQBt6z+YVOJNVUw6e/8MGODYiXdL9iTrLFS2+xadQlSvJxjfSCtnK43fiiCmkzlOTf4yyXeulLow7VAKwcQoRp8TVOBsuFa+2S+KQ2qkax3+EKhIeDFAFAh21Stoux4evqpz0ckzgnczGQcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=S4f9pWUWzkjGeKvm/ZYbjad/1vqyqBFEx0lylaCeHjkuKn6jLFb592wsYjcluwdnT+0zc+vEZ0Hch/gvNXxnx6zAjKQSSBwkAin7ZIxtdw3xBeg5iF/2++wBRPO3yib0LPEGfrTYQGuU+34hvXEOJ21HQAEKMkAt/fIuCWDiNtWbLzXXWhcFX8nG+uprR4tPATz3M4AgBEBz4bos5PWGE29AD/4RI12eW3Ncs/YwS5GOtYQlF1UGm7+K2KN2ekc2gAl/oDEgexEwufZGqB6gO79gSFadupkKFTs1+dc3NTmtE5yotm0Vp5+oOd2q+lXwbQAf9H2XxGeZqRD+zLfCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=KGasX/MdQI9HBMPeoHY17vPH50BdaGDCGXoLq4dISyieeiGduNFY4TdwjChMjxOyigtykcLTCVj+c/X5P4gBVxDTIvPXaZHNbGZyj5Z6OSlsLiowN+ZmaexjSNLMIrWi3qAmrribfWh2MDxtXeVdR2el4TfB0rnFMMEGt9JOuD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BL3PR04MB8028.namprd04.prod.outlook.com (2603:10b6:208:347::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:28:46 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 12:28:46 +0000
Message-ID: <0e391635-4783-4473-a46f-c135cecf2067@wdc.com>
Date: Mon, 30 Mar 2026 14:28:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: refactor blkdev_zone_mgmt_ioctl
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, dlemoal@kernel.org
Cc: linux-block@vger.kernel.org
References: <20260327090032.3722065-1-hch@lst.de>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260327090032.3722065-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To LV8PR04MB8984.namprd04.prod.outlook.com
 (2603:10b6:408:18b::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR04MB8984:EE_|BL3PR04MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 807ca0f9-9381-49ef-720e-08de8e57e394
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|10070799003|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nzq0EdB7T94L3XLwlcOr3ZeVB1Nq2vOwSsuNTVcJTcLlM7Auk1CjjTVbl1xqFTOg/jZcwM1t8PzylECcTbYZU6f7rJwRNJwTXVZPtYr4uKED+TJYqjUGnSQGTnImh7DCiuihf5/8kY0XGyttGQJGbsomKVRadJqOPluPNhi6puck7XWGUzrHlrs9EZ8zO2LUlVhtfy/PCIv3FPHJw2jnWld3u+n/rSj/YxjiUULwTRz34aY+YAIiMprIZ9TvFoWyG5JzHArfHp4qVqMjYvP9HZgk8wr24JSFpKNHmrlU03besEM6OyBHPevEYpxZLfvJJ+LwHuIBwl1WNlLskK8rXzc9UBIyJg6wzeMYri0Ol5aO6nfE4YASzxYtoksHJVnKyTo+22bFQdoDec53y2KEfCCotITixsimwxyNmfe+cYyvGY7iCGEYW1qmPpf1y0kScmVClN0zrqCGqo8AzvabBY0iX0unRGI8BauRcMGbq7KIN4bWimwr2ItNa56Tmg/RUjb8eil+iVgz9m4Awt3OEGEuNZi75hBZjuo/Z6rwlSiV7eFAVLeQfo/xzryAsyV1GIusMnAwyesD1xBMUXuTR9/L1k7CtfX+Mm2UAMkG1cW3vzsiKFrkxTc+8OSBywjbMJpNfpzwYzgV69ZyfSWzWuHr2LCgC2jypz7dr/8M00fPixIE6f+aye2ir3AvGvOg6Ecm32o2O6cK63CdCL11Xna2dss7Nw2Rcvrp3tw/vEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THA2b01BU202dkg4ZU51NlpQdVdJRGl5dm9Deis2RnVjUkFteFBENkd4T3Fh?=
 =?utf-8?B?cjVXcEIzRUdudFIxNWxsWnRJai9XM0tiMXlvbEx6WngvemR1OUFkYXhlMVpJ?=
 =?utf-8?B?c1NmQjhxMkxGOGd3SHlLUU9BdFN1TElXUGl6VC84Zi9UNmR3SmpsZDBpVnZl?=
 =?utf-8?B?Q0Nvam1rRG9yRXZuRTZyL3FNU0NsYytJeFhQNDdGNURmZ3BwOWdNME1hdEFL?=
 =?utf-8?B?aXNCY0k4NytPdXVOUWY2NEwyWTY2ZUZ5UnpYUnB6Mi9oUFZPRlIzeWp3Z0Er?=
 =?utf-8?B?elF3Mm1aWEZlSmVXUHhFRUU1aGpWS2dpTzRUWk5sVlF5Q2U1S3o2dVZpMmlj?=
 =?utf-8?B?aHQybjVwd3craHA0ekdLZ09MR2d2SkNSUVR3eTMrR09pSlZPVHNxUFR2LzBP?=
 =?utf-8?B?ek8vQ3M2OWR6QmZ4QkNyaHBpQUU1eFdYMFR1TVdIamhmMEhLVjYwek9DSlhk?=
 =?utf-8?B?aU1rK2djVUZHQkNRNU43QTlvSlVBM2FKQ0UwdGRlQzBDUW9CODU2TC9tUUgz?=
 =?utf-8?B?UzhGOTJCWEdTdVMvYlFQZGU2VDcyMnFuSjJ0TmhiYVVKSi9xQWswZDJrbytS?=
 =?utf-8?B?VkhaTjgrSVhMcjN0bFlPYzYrUDNoeGpwd2lHWVBITHh1K3NDVTlXU20yYTZL?=
 =?utf-8?B?bmZ0R2krUnNueWpMNGgzZ1hkYmJDRzhPaEFwNHNIZ0h6MWtKMEMvZ094Y3RH?=
 =?utf-8?B?UWFtZzI3K0xQWVduSUIxUGltY0pubVBhNC8zVmUwTEpjYkxJRkp1SDJBT3dQ?=
 =?utf-8?B?SElURWhBcGtBVkZSSTRqYjA2VlBLQkZuRVU1TDdrMEwzVUVUais2UlhITzlG?=
 =?utf-8?B?OUVjMml4ZmVIUHN0UXYwb05EZkkxNHpLWS9pR1lkZENRMW90a0hDMTlVRUht?=
 =?utf-8?B?L1h4d2lBSGJjaTJtL1lBZnVUYjY0SW9QQ1BFaFNkbm04RHFWdHlhU2J4UEUx?=
 =?utf-8?B?cXBLeGhscHhpVW9XNGR5WGM2OXlXRG5MaDhKbTFiOFhEZjVCcHcwdHZnV21J?=
 =?utf-8?B?MDFNYmdQWHJOZ3BxTWJyNFo1MUt6M0t2VGE2VnJoU1QxdHZOSGd3K2o4azVR?=
 =?utf-8?B?ai92SlRqd2hHYmtWQjZnNVRXSUl6akVIRUQrazd1RXZ5NGpxOTE4aW9xYk95?=
 =?utf-8?B?amNLdlVKWXh6OStqRGxzaGcwTWxnVWJkWFFzaDBCekcvQUxwc0locnNpN055?=
 =?utf-8?B?ODhsOVBZdmkyajlqb051SC9zaTRsZEp6ZzRWZEpKYWFKWHc2SHNEMTBGaFRa?=
 =?utf-8?B?V21CL3UxaENLU09XNzlXUjJidWhLakNMSVBkdWx4T3VIbC83dm1HZWdJUGdQ?=
 =?utf-8?B?dmpHZGtMeVR4TDBucWprbGtCQnZBenUrY09pQnExSnNTbEcvV2lqN1pjWE9q?=
 =?utf-8?B?dlRyeHFxU1l2NWdjUWgxa2RqbWVYcWdRRHg0Qlp6MEk2VEVVZGRScVE5d3ND?=
 =?utf-8?B?eVNycEQvaFpDYXJtS0FrNFQrRFNCZFltV3JkbW0xRnJDZkNBS1Frdi9kU1Z1?=
 =?utf-8?B?Z3d0M1Q1c2wvQzh1dS8rSlhXRytydVROVUJyOHYzSWpnZ2RyVHNyRXIxTlZU?=
 =?utf-8?B?b2lVcndab2VVeFdQTmRCK0U1UlF6S3ZRTkIyK3o2bXhUQUZkcDNQbWlIOXF1?=
 =?utf-8?B?eVVXTWtyN3BPbFJyRkZSTjMyd1FqYmFSaGxPRmpXWktGZkxQVHdDNGM1Q1lM?=
 =?utf-8?B?V3daS21IS3ZsYWxXcHZLbGJSNDJrSFRidDBVZXRyempHUjg0Y1BFWlBUREZV?=
 =?utf-8?B?RmhDZThURmE1SkhBMVlNT0NGM0JBd1RUc1VTeEJrRzMzS09WTEpvL2d2VWFK?=
 =?utf-8?B?ZmxUeHhjN0pPMXMvSmVpL3ptU29JS0JuYWZWcUlhWVhueldKdG9nUzhtM0NT?=
 =?utf-8?B?OGU4ZjQrZUh2aVgxRGsrQXpSSjJnTk9UdHVIOVB1WEZSRzI0QVJYVyt3U2Rx?=
 =?utf-8?B?R1lTZWhqd2V5eVNlenhDUUlqU0lKcC9KMVFEaFpqOGx3aWlaVzJHdTdtMlFO?=
 =?utf-8?B?NlNjQ0RjSXQ3b2ZhZ2t0SS93cUhPSkV6bEI3NkwxNEZFYmFLSGpseXBpT3RV?=
 =?utf-8?B?MzlOYVZxYmlUamhpcnBMWUJ5VzdxL0tpdHpqU2s2TVJISGpRakVHd3dPUGl6?=
 =?utf-8?B?RlZZTXowNUkwRGZFTmdUeGNMeU9meFJYRVV6MnZkcmZWUVNyVEFoN3FvOW1k?=
 =?utf-8?B?SHMvaFlHQi9yYmo4ZlRhZlVVVk1PQTBJOVhucG1ON09qc1ZkdDUxeGU5RE1h?=
 =?utf-8?B?N2VOZS9taXNuUHNTTkZIR2ExTFlrMmxUbzhCL1hubmgxTC9lKzdOd2VKTEZP?=
 =?utf-8?B?QWd2Qnc1MzdSY0h1cjJmVWdKZGpPcEdycm9lWUE0K1Q0QTVhOGxpZEFaUkx3?=
 =?utf-8?Q?G7ISnqDm+mlo+D75DwaZApshWIDD5C9BaWQi+fK4hHt9b?=
X-MS-Exchange-AntiSpam-MessageData-1: 6++ipzFpoiAERFs5LTm37IXxFYO1Tzx+sUk=
X-Exchange-RoutingPolicyChecked:
	KnYfZyOMrqtTLILF32+4uGOvgeblrp+hM2k1N1+eiaAojfXn01nsIKdyTkb0P0zzBa3zRflNeC0CTUMw1XU7pCr8ubMmyXBpeKrLC4z5bykGuiBhJ/H1Jla/tl3i1LV0sDLH0Sb0LJ0FOw/n+6AVa8xIago5GhTFQTKyi9KcRV1fAWGwOeeQSTq4D9I22/yJm9MhKtjwWxZz6JKjIPL624dCdf24y9u8015DliwZR6CCxIGCWAkWVzu0TzQMb/KlHpeXFRFfepwudT+HijrOTKkf/45ltS80924D68+XzECbs9x2a7PyjWDzizmtP7CB9V+OYPZiNgtUCBWrYesjRg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zOKTycCNjib0/Ul5xSpk/khQFvvEmA17r4bHjYx3ceMs01iNSfRNM8NfxwWYDHzVsORej/vUqHLiF8Ibqq4nTCCVJU6Alsg8mKRTKfPuVykuEApRTGfTywzoBjeMyM7/vLG2NszuHu4y8pw7wXNuiiymrJE6INSpRTGZCQU20DVrs1SxmxSxA4/CC1QQcs5UySsn1wNkYMCXXTmNNmoxP0C47gKSAqNCY4V690rrCY4MajJDvtMWX3tN/aOp10BDVfhDJ1R7YH/L5VKEWnyaogEzetv7ov7p3Ss0bCHvnmwC7QLacxMii+/LQDAS3LTcGdPT1zMxH0R343ho/WiSoISuprmb2mydI1EJP3HmbGI9AJDp4UlChgxaIhKwvwwhorx3T6n+du6dpznblzJUDG40JOg1e6WWHkqd6k3PwMs7q8m5Nj71VCdKY+Iitp4qoxBkbJQHjJ9pofi1DedSpQGnEIjs5V7At8TGr/QJEWFutBB3UqLO+mwLXmlbzF6zedfEcFwVtIRTqKo09QgxLvCuYZWq8k/3X2fDnsms4A66cw6qBRdso9qCVkA2Ezq+1sEjJpy6FZL86LFKMnTQW1OHr0beotLT7LjoLjd0Xqfdg/Ri8KN5bc0qB5p1QXSN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807ca0f9-9381-49ef-720e-08de8e57e394
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:28:46.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmNafI0MecizSCJnvpY7FlEwJK3Gq+AC8RLazIvGdBq0WZNz3/nUZ90Ssq6e2ryuEGvxCj8v4bQ1wMWTbrvT28agsMO7gzyeegcSEsAd4nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8028

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

