Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795833737;
	b=ovr+xnGG7P9H0Qe5LznOHyFr1RqAlmjzhsyE0BJ0+3JwCeEp8+yY94MLrIED0Noy79Pn
	 v5qTc/Xz0tDTl6+sxgi0/Wrdt74piL63wTbY8rAItaCz3HnzNmcnthe2BkZpa0gXvh4tR
	 Qi93NOxrPYRkIzJaeKcXcqS0nQ9ww6T9iG7Nl3w3mbi6CL0bTx0xHKjJm2MKPTAI3NcSd
	 marGY5JxA80wAXL7CEcgXgY6OSTsEYFQcSLgyXv+pqIYzzsigmbB2TQ/b5jqDpcqeS69O
	 Afq5Z5VwmlO986x5OAd95NiZKvn8yXudpn+fFy1PSpvjLIOgUjOQ0FhGLoImb0YOxsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833737;
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
	bh=c1MFX4hzUHGkXaRuc5Otyq7dzxbJ7hguBWnlH5eN0zc=;
	b=ZC9m4FxyypbUbY2yvnPDh64YYw2tRV9okUmBlm/tfyoSp+d/9d6L0NJZJbGBDwvQ+E2G
	 ELK9N2nDEAAemKW2aNLK+ZOngH8C58Zq4qNYEwrrcTyMjxr1WQz6YhfTafufKKiDX0nk1
	 k7C2C/lkVF0RK9uuNeD4wURDGs1Ddb/gSfsyWoN+T931u9emmGpX6hqA5RgnNEfZHHAjy
	 1zzj9Ay+eEeLi1VAGx925F7fUInWW/Ot+oqRijCLwzOMQ5+gnvIfQC5vpDEL+o1qAuFLS
	 BEle4PgYwc2d8Ns51xkQT3bC9sFnjzSO1n+LroFYBgOvHOlZOYaqWZi6woXTAARt3EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=nhV9d+Y4;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=R7FDTNts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2B606A31C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=nhV9d+Y4;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=R7FDTNts
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795833737; x=1827369737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QPLdaPwT76veAfcUHiVhRRC+2ASXs+HTJSi5r8ff0L0=;
  b=nhV9d+Y4uoJmGH+TdnG5ix5Naj+UGyOjKKR2QvSqpiter2QjKT07oXWe
   TgSqIwSs2ZfwaiPmVhajVajOPrUuXWpgHZ4hERETlvQCvdGCk3gRYGvmT
   iOB/Y0Fgps1Pmif7hathrmm+rOZVbafFrrQ+PzRpJp4S/CCDMO8nkG8Fj
   N+nD7B+6UcG8On6plx0GH/dMqzDdqoBoYTGmz3MOCUkdeU36dG3BDuRCB
   1bVPs/o8swqmpfoDfCOgVE9CDvsk1eTRIabtsRcyK92Ws1SqzBDMUZpqI
   xSrWjZTTh3BUOo/B+jl34MQbnJdOcq7JV9ibvrKuMd/oh7CZq94KMLan/
   g==;
X-CSE-ConnectionGUID: aC9OsEYsR+SS8CxDfoW1ow==
X-CSE-MsgGUID: VVzPXQAOQXmMMq8DVVDaJQ==
X-IronPort-AV: E=Sophos;i="6.27,238,1786982400"; 
   d="scan'208";a="161874685"
Received: from mail-westus2azon11012049.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.49])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2026 10:42:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL2NG+Ca9tHYW/QyGwa5nupjV0P0v5AkO+Pc278EcKK/tZMwwv/fgRuQKu1wHz64/7Zh38Pa03rj/CITa2ibzS/2K/2OV3YzZp0fvV0DIx/v8fkG82I+owbkdEegO/MxjvS/mF+6O9X+0n+4Lt5cp+VN2QwyqZ7AA3vImBfPGD3PNnjNXRwV1cVSlJ9ENHK9np67fcOhoP+zJbCt7i9nUhLA4Ujv6uL9co+LKKk5r06qAANMCUaM49OKwFI5Q4rR/zOxaqHvr2ji0NmW2BxlPfx6xbK91KDSCFdSe+z/FVsevE4l5wstahFGbh7gZ7dzO6CMJJeeHqsPuBlrjtx+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1MFX4hzUHGkXaRuc5Otyq7dzxbJ7hguBWnlH5eN0zc=;
 b=F6PhjfuJ0G1osCu3Dq9OzJrn1hXV9sHL3Ri3QuZYNh5LJO6Gom/5DmTqmwpGwYV6inwAy0e5i8N7zaO7ZjQfyx09PNfuveddaMuOXznqWvkoQ+B3WUgG3270gvTi9C5kgeYfUnLhJunGrv+kpFHOylp55VlBsMUpygJDGPfAe2rycyf67vR7ZAp8kesPqGmQDqkh9Aa04qh2JptWFZN9yR+DHis1D5lhWoBs5Aq2OR+/tLl+mRgXqhksqrg6vKgYNbH7i49wIlY3JbfNegVhjApv7cWzSqtAqOVj9XYn7lwoBpYsReSlYYnvZVNzHw34Ox72M9Kp7d6mYA/NoK2npQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1MFX4hzUHGkXaRuc5Otyq7dzxbJ7hguBWnlH5eN0zc=;
 b=R7FDTNts6WdE6r7+YYuREOwY8OzK8UnhDVNzl1U0sLpyYy1/IwIdRg/VdjuMPvw47IfoLnqb0f+bZJc17o6KTBrZZVIHGp3MUjvGVFHSVlh8RsshW9Um9SG+R8aJDhPFiwCkgAonqnCGzRIy8EF8f/FHX9EVWWIL5SMuPhNOxVI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CY1PR04MB9737.namprd04.prod.outlook.com
 (2603:10b6:930:107::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Sat, 28 Nov
 2026 02:42:08 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 02:42:07 +0000
Date: Sat, 28 Nov 2026 11:42:02 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 2/2] nbd/006: Measure NBD IOPS with a
 null_blk backing device
Message-ID: <awo_IMQq86EXmEZ0@shinmob>
References: <20261120213434.2945873-1-bvanassche@acm.org>
 <20261120213434.2945873-3-bvanassche@acm.org>
 <awQaJh_NFpD2_-PK@shinmob>
 <f251a666-ea13-4dec-882b-85af5e964b9d@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f251a666-ea13-4dec-882b-85af5e964b9d@acm.org>
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CY1PR04MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: c92d35c2-668d-4895-af2b-08df4cf931c7
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|22082099003|18002099003|56012099006|261028144727099003|4143699003|11063799006|261026121527099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	iKv8hBStcincGdkDsqt15WVuqMUj7gT8Pkw4DBYm6BvcLGAW96t8F/qUVP14LJmjpg4UcmTaSmJcIIDRJuf6sJwFLnSnoIZqkbTxMNjdkqYR3rDGSueAv9j+ea4ulwNRr3U9SzH+fI0EuTjcsUG1nOS7Lf1C/9d4pcSm+oBkCleMyc1N5yzdSql5Km5KuBntaiijsOaeVRv5YZL68jxGiAGG5vD15fNkDUADLUX16FVkuFqtCY/BtcYclbLnO1VmyTE+0wBLtRuOW3QJ5HEYZuvqm8A3IS3VLJDlltZmBcFhcbzCRImakuL4Yo0pQGOLB/v2MlErP211vB94POEPok17P7dLWHcIUkE0pqzK6wMLn2wIFMvWSH5/+uGN7/hR7kcqJ+xJuFLEu2Bf0fc5KjpPjw59W6ppKZFbHQTrATDOQzdxsNatUUqhY2M7/g8/Feh4jk67wKzDKmLmYf2OySzHOLeaxgF3J4B5gsz7to5+NEZzeeTA9PuhEGsY9g/qKIdsDpRNPouHGBBkyYDkeDXDKQcTab2CA2D+xDkw4favoPYKlwK1o75twUrv0YvMTP466/tjvv4sG33IAh4NrSuBi/2eFM446IEeBzeDPB0Yt5I7yP9+gjm3Pt+JeYcjbpS3RxPuyeFcFKfAbatJ8SrPou5QZc6rC59FfPirmHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(261028144727099003)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQBEECGphAicgibazCL3PcHC3F1iEliEkM19mxdp36oAvUgI4bgYOHQL/5+X?=
 =?us-ascii?Q?ITHQnfbg/TwSesOO2EZ7GxLQ4hUTv8tDSm+qvl5Cs8gbHa+Qpm1JpmVAFN83?=
 =?us-ascii?Q?sqm5M+g7dWsJloq9a+OBFG6FID94/7Hlvu2EA8zZejQO8AKhJ9l53hlnHp+m?=
 =?us-ascii?Q?9ju5rR2SilIntBTiRH7EsEB288DbalsqgG0qSdongFbVzAmGm8Re94p/Zmf0?=
 =?us-ascii?Q?uHsMxs06Vq+JX3xgNRIVrW51oOnaBjImuPNCiW9OHLtMo3XBum3blCtwqJhh?=
 =?us-ascii?Q?lwx99tVMGBRTND8NnF0WAF5zrpBrE2f81BLxoQRh3Nu/NUMmHixFWENxcTpH?=
 =?us-ascii?Q?2+Ci74AeFKq0t6OJWSmSHyFLaZlKBUVTFjdU60iHQG0FtBuhBQlumlPiE+Cm?=
 =?us-ascii?Q?XgSiRDmPSOCowHwVkzZFxgPmMYCdFdckDgmB1W969/vr4/PN3bHmSPdb+7ic?=
 =?us-ascii?Q?JSzgNhaxlmhSo2jLo8HUcE67zST92C0H59OP3IoS888P7nvlbKw+vYG8RWVp?=
 =?us-ascii?Q?V/i77q2iHmstjq8WhuTsTrqsKSXguEx6v+eUtbcy7FQPzJk8fnYSUyOSOPlt?=
 =?us-ascii?Q?F79f4HJDsfa7ZuuybmaRG/oIMkomt3p/xgJ/YnqutihmGVeZTA9s/b4xh2Ul?=
 =?us-ascii?Q?0+4izGd0Z2OEGwNi9M7ujFT1WH3fiLj/vAinslfYZLw17v0VTleVft85ZXfS?=
 =?us-ascii?Q?8VkXPpBKa+M6vGbh2zrzQdA060b9ZbEQvfRmrHiC1rM9kwiWA2FHpf8Yv/cY?=
 =?us-ascii?Q?ECUzqh4T1aHZhghDlvKk15m3C4VZqxPV6QiNteaxVTerUz3peeq2eXR/3BtF?=
 =?us-ascii?Q?Z0PIe3Z68zVtJzIXzpjByxp+oISuCMXl+1relo8VTUsnxleN/ezGxz+zJ6Xw?=
 =?us-ascii?Q?TNfs33cQRxN+U4fF5FxhjegrHzbkIFhf4T6lhGoZsrqqHkmnm/JZ8BoCsHJj?=
 =?us-ascii?Q?svfGUjJeFLguMoFF3BPzqfP0a8I+67Wj5TzeILnF6x+MejiIQfEzP9nGQBiJ?=
 =?us-ascii?Q?VEq66nYp9a3Twz1Go987nzUJEvEHqXmRaSMkHeG+43xg2QrTPVAEdBoJQadt?=
 =?us-ascii?Q?CCUc+tUSVk6mpbbT6wd+EZi3WaFlbQwpnn8KIM1UjmdTI3/saMwfSZAZ1QSp?=
 =?us-ascii?Q?0Pv+OG5Cg/JP3Ye9vme/Giy86crAor8/Od5+vmtGVF+N+P03bKv/CucSGo8H?=
 =?us-ascii?Q?dt1Z7SH8Ibi8JC1m85sP+19ylkmeDl+w3SZh4vwV1o+HWHR8k5IVK0Psj1r5?=
 =?us-ascii?Q?4/9aEv27qCM9SjJxrRJxJvxdCi1+CerAXwsG8SzTyaMhn6qB9LxueRo5Daos?=
 =?us-ascii?Q?mpWAa9+YsUAv/7qO2wmyUBexahEiQg25cBX0xLZkI5RUlhhzx+K5FKfWaH4v?=
 =?us-ascii?Q?BNeHbfoT44pQs61+IDNe55LOyB7iDNlCTs6sDYG51OjeTXcN/rX+mtevUUWT?=
 =?us-ascii?Q?kRKnBntNhcovK2nCNrZbocNekKS+SJAty/8E3v7H2xJlGOmlRrbqx4T9UXAp?=
 =?us-ascii?Q?RfvirMfUD5xIzGFG+gVFZw5WlTE5IK3n4Es/qusGmf4rPNI+uLr4O0PsYH9c?=
 =?us-ascii?Q?7wV4fDZSIv8Mvh5NDPnH440rr7TBrJ//I58rIM0hQjMT5NKHb1GlvbcJCalV?=
 =?us-ascii?Q?lzJ89PJl5WoRAaakxswfJOqg5QDFPp5jW6NrGRResrcXSn/hEnB/3E8Z9f2P?=
 =?us-ascii?Q?SSICFe2TUBw43wtwK+AKmUOvbv/gwBAvroNEhVi5tUpHB/EpKBTSJY6Ydl2u?=
 =?us-ascii?Q?i90z356ZP7x0cFy7heviXg42RpVX3iU=3D?=
X-Exchange-RoutingPolicyChecked:
	MQxA3qLTNF6Tgw+u2q31HDLQpx6wt1JP4vQcaJZs6pwSY9IH7twZJ0V00dccSlkZPLgTEh+bfwbN5be2lRv/q1iTmxlGyokPdyIPXNeMGH/Y0DNqiZ8ySN+f5vVeccbmpnGA9ApcCWEhiJtNqcs2hxz0IHKhaommX5MdANtimzCnjjTl9gXdblxPms7pUKsLG5cjPw6UnE3DJoRb22a6e8N2jcO1QUaXAWz0mayFArZbIMfdgX6nB3cOyX02h54hBHTqojuycCXdoYZQIRmC533PJ96K7BmCt1woammhjRG9WFZJpWxkFQEBYBhhEeblsb/fQB/wYeiPVD1/abdEqA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2f/PF2pXFMp5KNFmSq25nDoflHChXnQIHSEL0NGNbQUvWeRXvlWZobwgL1c1/uvtdC7SxfjE0nXrVk5eoAIPM71WwWbiqqyqdZRwdqvCVj5etgLurJatsiHmutObnMgb+1KWYgOQaTZFXSmpjHyxOFW9VRkCyBeJIvMiboithPU7Gk+z/bsryWTp9DH7pm/FqZte2Cizq4wDjKbbRr8n6+Qq7Js+xS5duyYKpgKI2YHP4p7IuLT3I5EXTBNl5qu8U08cvRvt5fo46mfje3FCJuNEX57CYrSmov0lzqWv6oVWFa5M9Qx1kljld0CBYGuwwu8sdxrxMxqvcAkCFPBz/fg0+Ys5S6IzkjAPXoFxwH2d92GwpgbNQnlJ9mRjaCRJzF45Bg8bv8uk0o21IQd9XiCKp5SagwB/85Cra1nMUF0cGAC8itZ7JVTi2wZuYsFNk8zWVw3RV2U2tZ3fHR5Icb7JP13gtHiUkioEyQ51bDai164KISOR5dBzJX769F4bJ98KWHOpjYXNFe44kUC8/l3iV2JPNfWkSVjnDHF/J4W9UcjkkhHOs8OTDPL7iKZwM88r8kvGDZrFEgkIMFQoUrsawsdGMfrLSB5YWZ284tfs7c/FiYLy6hD2aYd/tZlK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92d35c2-668d-4895-af2b-08df4cf931c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 02:42:07.6716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfR/kLHMsnvveE5SWoP8VK8IktFdeTrB0h76md69MB6sb/o6qp4H48mD6cZGAI/OnWTqtC7HL/Y6ysLwpfgr3wETQswheVAQxQTN+lHv5t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB9737

On Nov 23, 2026 / 08:14, Bart Van Assche wrote:
> On 11/23/26 4:11 AM, Shin'ichiro Kawasaki wrote:
> > Just for curiosity, I wonder how performance regressions can be caputured with
> > this test case. The performance numbers are reported as described above, but the
> > test case does not report failure even when the performance numbers get worse
> > than previous runs. How do we catch such regressions in automated way?
> > 
> > Does this test case have other value than the performance regression check? For
> > example, the test case uses Unix domain socket, so I guess that this test case
> > extends nbd driver code coverage.
> 
> Detecting performance regressions falls outside the scope of this test.
> However, anyone who wants to use this test as the basis for automating
> detection of NBD performance regressions is welcome to do so.

Thanks for the explanation. I agree to add this test case.
