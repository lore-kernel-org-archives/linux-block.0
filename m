Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273D1A9FB0
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854010; cv=fail; b=nEE9vHizx+l02QpEP/DV5rak4MvWF+/KsExlAsMMqL7bf5tqY+IjO9RhGl4fPatMhki/ixemdbf1XOxUyhHiCPZxD5BkGSFb35BFpkLl1Xhkd4JuVOeCN8lc8TFuPRVUrKBIRzTCvQemPjV5w3KONFh73nFntoRoMhrULp2JTVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854010; c=relaxed/simple;
	bh=A4zcUAjg6oPEjoKydOya3gV4k6tl8A2lEKOEmdmOUtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZmDD5qO81mAKa0T1FXeetuEb4YxM9ScL9cSjVoO7/TrXwImtlnf+tVuzJyZcjP5v0A3oktsuubQtK1map+i9QWVEN7yJw7a8VPIWtUBIBqh2FI+xXI0RLfx0lUjUW0e8hvYovQ9Rz+qlgpa87D/LbeS0TIxboX9zbb35QFyDNCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MY6LEjcU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=g8FQqaVT; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MY6LEjcU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g8FQqaVT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784854008; x=1816390008;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A4zcUAjg6oPEjoKydOya3gV4k6tl8A2lEKOEmdmOUtc=;
  b=MY6LEjcUIK2D03/bzzH7BB2jU225sZjcCgmBDRF+Q5dEE7jM28Kj6fUT
   qzc97Dw4YdJHf+hj6RZWjJksi95Ggv6esxSZDxBAUrli/X1yfh31OCdz4
   lJDuGAJmwLJBEfmDLbAGnJSa9ufTrcq7i9Y7vwGEHNa6w9EW4PKM72BN3
   9vvu6acl1vht934Z+uP+Bu8gdTy6fVohcXRtB23fF4/1JkUiacMRBrtJj
   7BkPKoJ3zTKttZshEmrVgB4m8vVfdCGJDypVdfRVTMtX2+tQJP1kdOcsh
   hE/eEGDy8EDwqcCXzX95+FQd5KYX2XaLRQPYkZkBaLJ+th2I4CDQ1dgKZ
   A==;
X-CSE-ConnectionGUID: 6dSwaS98SLagfL0/yOxY5w==
X-CSE-MsgGUID: Sho/j2GZTleYE/48osahFw==
X-IronPort-AV: E=Sophos;i="6.25,181,1779120000"; 
   d="scan'208";a="152587211"
Received: from mail-westcentralusazon11010010.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2026 08:46:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdZCpI5yahcKHE3xmxziFK88fftr4Lgo/v5ThtIfsR2NReEQd4yokg4tAqvdrWHGLfQKSwekjP4hRiYcT3GtjiH4nRKsgdjt/m9K+FbqVhvIR/vL7c7GXVvm4fZNtdL0fYRJlCe8yRAJfLUBguUgaoCQcabot5fW/FLwPwwCqiO7KI42NLqqlAJ6et1sx3o1XzUOUglO/qT5nX0ZUDm9zHDbPv0BfyVCGL7tdE3tbpBExGkUE3V0ACUX2GIYY3/ZK2D32QjOp/oKhNgmMLWh2iNvHk3eCHG8ySjCXxOufv+1WsbjS5u2mM2EenY9o9jqIHsBhKx7KaR66H3LiFK68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsSYTvmc7Zq2va01vGcXS6CRIZdB4Mv1Kjkrh28RDs0=;
 b=M9wtmYLbSCS/A2U40ToAuJPdizbex8itzjDxlQxwwEeMhhUezy31svWxbNckeJsr+CH8aFIOku6Q2qJ7B+PHSdwoH3hkVWETLDJongyupBL/elw0OiT6WVApNckrh/pK0491C4MYDH9mrGLDPDQZVZjwRom87+qQt28RHQ4XXZm6F3/qEWq4rzX5Juy11aptjxSOjnfkM9CboIVBaB9Vbfk3T9D4WcibrZ+eFXEBOofO5ftnhTJnoouvy/65K/2nEmoN1pdJ0Y8j4uBCwrrp9+pH3Bi4DghuMOkcn2iEGrGxXdkJt/uEykslXEj4KBIo9u/aTWkTn8zxFCnwG0BG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsSYTvmc7Zq2va01vGcXS6CRIZdB4Mv1Kjkrh28RDs0=;
 b=g8FQqaVTr83LFl+QIjDskoGqy/dENMXl/apE0vfsSwvQ5zEhmxFQ+/dmZQaHCjT+ROKzl+axAwAPIBuMSRCUAx7F8C9Nby7qhkWAu9iKeYE+pygeg0z2TaJHbAazKITSaFrJBadKbb/oiFa9uIdNnQkThlYFQdzVAGi8oUgozCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7407.namprd04.prod.outlook.com
 (2603:10b6:a03:29e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 00:46:44 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 00:46:44 +0000
Date: Fri, 24 Jul 2026 09:46:40 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH blktests 2/2] loop/006: settle udev before completing the
 test
Message-ID: <amK13YyetnjmwYys@shinhome>
References: <20260721160432.27409-1-sebastian.chlad@suse.com>
 <20260721160432.27409-2-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721160432.27409-2-sebastian.chlad@suse.com>
X-ClientProxiedBy: TYCP286CA0198.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dfc6d7-b788-49d6-026a-08dee91d090f
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gjlskm7E+dt8nuowWWEmsFvcxkpPwzrPMceHNh4JsTHaRNrf+3O8suCrPNrCWm8240NoBUiP7SsRBiLWOxFedTaEFQyX8nT1UxHhvp8AnNl3/bXJKd3H0prvE6dBo1k2CFJHL2ln2gmmU1YIKXO49W1gzTYkMoBTXlgufRyC6xbJzWwdrVtIub0VWWW08U3c0wdpJL9nfOxbti3yhIZP9lZO46f07FKFrSaIwaItn4vmg0hYo0ZeIcH6u+FItyO7N3zd7sz3m6Bwnqng1Dbw6g5ubs0YlNaaBhsKhpAzRl6CB1ktoR9SXNg0MSVXBIkxX4j1jEwBq3WSqSLQiVLR54gESo+nVcbP6Zyyb3YWdeiiPDawk453siEex4VepZxOBWgCNodvv9T2HCKmn3KFIeVuC5jghgntjkpIOLTiyThD4QbH2AP1zHLaqd4/OIutpgVphGc29A/IuzdaVA3/GyqcTLz37oezIBTuOT8WEg2oUQVocFskzGC8Ix++gCnqYowbyVgfQfpt9xC/mpfOkzWZ7DI9gJ8pSRmhWQumWqtWXDAv23tdJl2/BEaxuTMMDifu/BwxjII1bRX/NFj7kwPuJsiuW217l9Eo4E3Blge78rTYS4w1WOSbe+wscZZSwg+DHk5hGQF8zL4xPx1/IsPIxZ68dO2/Xd5DXVw7mSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juO9YUBNZwUNcrjRCNHK+FFRZZFfTwlmI9DTItI8kZiVIphkRX4TxN16MIjd?=
 =?us-ascii?Q?Wp2rmPb2ia3vw/NQ3qs7cxfGtjiMioTSpVDj3DU+88wkJN/kx6jpgLEN109M?=
 =?us-ascii?Q?+PQOD6D7P9QiyYGpgrH+t0CA6LMiQQhWcCaer0eoFqm/zvx9vt2zkLrIiDEA?=
 =?us-ascii?Q?La+gbTerJxao8NGhFmPKdQ/FeCek2W9CUEoFBrXy6+CHvUuBe2YhqNi3Q03G?=
 =?us-ascii?Q?9cCSu6SAMlXHFVPpou5qck6B6bWYwGuhaRc5Li7quynabvhTg6OgM28NS9pm?=
 =?us-ascii?Q?FyABbdfQlAQ8SVJNPWQNW+rlIg47MMSX4xJFVBqPzdcwyUpz6q1xUEnnNSIZ?=
 =?us-ascii?Q?40Z67cpVU7nDbsN4olK2iPg0oooFMEuPX1lfXASHwfX1FkY+yyF9fGMshPbZ?=
 =?us-ascii?Q?5jnAPysQnF1fQYgzsdhHEIJOHEadOObU2lXlioVg91J+4VZQyHoW/7C4+b0U?=
 =?us-ascii?Q?7ERmqYDnq6Z3+fv9Fqdr3PwjIXcZzk4Bcs2KAzof1nSvgZNFpV0sixrT9DTY?=
 =?us-ascii?Q?ER8junGaiOrh7Ia9mi8uwpy+vNZHEOBmgkdSnAYXXf5mz4cmoiFOfUTO91tT?=
 =?us-ascii?Q?LxMubjq6w8rVz85DzOtmaRNcrffl5M+4pi1iOpMUDsd0aKUwyC0qn93L42XN?=
 =?us-ascii?Q?v1pxKK0jBguFy9Hw3I39FgRDd/qL/e2gQwWKpEMz4q21GVWiJ9QmPLbseq7w?=
 =?us-ascii?Q?wNVJZlUg+0h2pZbPRMuP7e4cGTDeXrpNpHp40A0ccfXDs6Of0+zTuuVVMvkA?=
 =?us-ascii?Q?L3P47ngYhGXP79eNY7VAbGEDot9Jx9OjYU1Ewl/uFHOspoPIFIjEKMkuIhVo?=
 =?us-ascii?Q?d+uuML6pM2t84ekXZXX9Gwao/l7rwvbWlljxretcErvOUZAavmp73kTTfrug?=
 =?us-ascii?Q?3vXbWh/6l3G004ybcViSNy1mkHR8CPvZ7ktCGU0UIcmU4SN8rk5rvaYW7a/N?=
 =?us-ascii?Q?3fvjf86ZxBvZN9L79BY8+YmMjkI32HJQWTlVuAdoIzF/ZEOQQQtgs/fNHIOG?=
 =?us-ascii?Q?Sgqb9yfsRQIuO79NoU2v7dVaZW6YLejxFEuQuekAh5FdIwePrKDjqWmo1pXs?=
 =?us-ascii?Q?oocuEflWNwZ85oG02mNbRfvYCLHFrLYlzsBVXHXPHl6xABeoXhfJx0jzt9il?=
 =?us-ascii?Q?fPLGo0ifdm7/KNvHH0CwJw2bjSERWkEXax358UVQtIW6Mc5adXp/GS7uVsNq?=
 =?us-ascii?Q?6pFoM00aCa49QjEnrp+XKu2rTXQWpQYRQI5xS9Eruvy3lg74yrMULKwHXvXe?=
 =?us-ascii?Q?UCmw0z42JVfA5jRzr7r8ORFwBbaapRa19HURIo0x4aGYwEVaRlsK9gSPxi3b?=
 =?us-ascii?Q?7kp8g6B6ZvYD+XEspKuA5dcj5J6Nx8c6Zg9RogRTDEyWKCMIuQymmlarEOiD?=
 =?us-ascii?Q?rZrAGGIrdelBcAc97dw0gaT/haYUfqgFWbj7zre0HTT2vkKUWDslqmK1kH3k?=
 =?us-ascii?Q?E7hCcf3270kfBESKbmOfPWbXOlvleqSGu22pJejwKZQy23mTw5yw9XZVMUkG?=
 =?us-ascii?Q?YRCvF9q5SP14HAyCyPcBq1CkkZVzyc4TNmpaS+7FaA+eLhaEnV0hQ9F4kHHY?=
 =?us-ascii?Q?z4R16hZLC+ghS4zi0iiXYLnr462V6edJnxUz/SbKtWJSRUF1Oj3QpFBaeCdu?=
 =?us-ascii?Q?lIFRxa3Mh0Qxk2FWVwvqWdpGwRJEPichPtM9v5SN50ueg/9anZvFE0o/0Vdg?=
 =?us-ascii?Q?VdTha7exjty+QhG4Ii1gtXoD14rJCD+/nrBzVRv69QJ8xYfUfj0mNWzi+nDv?=
 =?us-ascii?Q?haGRB0TWh2nN4R82SkhaSa2GNhy0rkQ=3D?=
X-Exchange-RoutingPolicyChecked:
	elYsVxmeWq/Ld6TfA/P3JjBzGkFJjO1CClRKnzTDY9AqkfE0eU6FAlv2jDcACu5O0QGNwXPcI+RdgqzZnJndtxuCW1PCNC2SXU5o8T5y5RbuSHAizaIeHXqw/MVoFuF+NZxfC7972qqhGY7HZF4PojNjpmAxsMYL/BEFMKxr2YHyD/0ZH214cg+9W9pLnKM2+FGGu2ncik9qVOS784t3uHfpIvpwxKyHD0S0cyDL68MNRXJ5h6jAQpXk0P+TdjczvDp7kkIT/f+CjI9EaOqzsefNzWeFQmO4qY1nR45MHHWL/qsJEpgyf5Qne5M19FoffeHEyO21RMQcJRcCr2kHPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cNZ6HAc6QNHTDrxf0nbQ6U7mWPfUFerdKIPJmvn7jNOmrlYLHEJ086MRSiPrjEhOMBax7riliUc8NV+pSvGSQCQYoTduY8gl4f6kvuf1JSjFGer6s9wddCA+ifty6j/4hT6rEua689We1qGN9DGN3YBuDRvbeKiu2M7mNAEFMmpDvtk24oWqv8JoK3syvcypba3DEl/qCrWIK/FJmAdKIbLWSuyFj+dr1PvTRV7L49ZZKytgq9Jlo/K6V8gpwJ8BSEj3W8MvMTle+BLh9n3ULayvhoonPnWRl27o51czN2nc5ZLpL6mTKRopXw5AvDQf/iS/kZjPsAgP5iX4qzSk5JobeT4hLXjt8qOUg8GzDDtDju6fEn9lQ0nya2kSK0g6Y2jxmR7900Ywti0USnHRPMpBTD1mEmTda59sz7k9lTg6wsDROQIpodkjfALRmWJl3917kxQfD06Uee2lcskimDSMp0WZWFXIDdLs0hlLZllEoLHyQgYcs2cnLZHQPir++W66wb1Tdr40dyFPCvn7g25n4BoEvoi7znZWqFCaBezQpW2biQDL6mbTd6QSCr9AsUvhzzYUVcGLxqI6dbZ8W/vUXFU9M4csbUkNB/vVntRG/FuFfEKfT2qlZNVup9Vb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dfc6d7-b788-49d6-026a-08dee91d090f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 00:46:44.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcVV8028uaXu8ucSUDera+DJ1j2+HtimZkJjDrz/rm2b69VGkmKAEZqmDMSHrgKOu/fBdZIPFdFpe5GBRc0p1WAMGj9GyuckSqjDyi/5Oio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7407

On Jul 21, 2026 / 18:04, Sebastian Chlad wrote:
> Ensures udev has processed the burst of attach/detach/LOOP_CHANGE_FD
> activity generated by this test before control is handed back, so it
> does not leave a backlog for the next test to contend with.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>

I applied this patch also. Thanks!
