Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87C2CCB9
	for <linux-block@vger.kernel.org>; Sun, 24 May 2026 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779581842; cv=fail; b=Kqkw4X+6kTF0FVAO/AIhv2GKTzjTNWKDOmLLjuvJqjcL8En9gAVT2NFVvVBpLo3q58iXaC3Lka8oe7VW3PVi2pDx12pWp26BkCupkL2cge4265yMU1c3/68Pb1Z8g/oSlD0yhGuZjVnb9JbGz1yfdzqzkEfJVgVGpp5dK4iIVPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779581842; c=relaxed/simple;
	bh=DxOapM3OTyyL+XUsRkm881tBgxAAslgjPlJm4nx/M1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEZwMCGbivwQZAVyHS/emo9WQEUAbNlY7LjAZzxWEJX/bmd688Lz1zku60Nuem9LIGvxBqdoiONtNbc0iMeQxwGaCPRQxI04PbPpGWfSjAj/vGuQ6aIwrC2n0tn7U8r94uwda4rm0iDguYhSnYKfTjR2cW2wdO9yGy66R1oYOTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rmUxPuLT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GiuqsoLD; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rmUxPuLT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GiuqsoLD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779581840; x=1811117840;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DxOapM3OTyyL+XUsRkm881tBgxAAslgjPlJm4nx/M1M=;
  b=rmUxPuLTND89jMQST7VdquZTTJUz4dMNG41bgGPz0usW9FZRm/y9dfxc
   yeJPKVvX6C/wDeUNjRg022e8TUX7qddUpE4is3iFaTsz5n24v97E5WJDQ
   nHI8n3ce+ClZNsmw5Tof4c478pXpO1wjzjxPAjwQGrn7FDW/6DkEfvSbk
   uBIjBRhaBHbE7LX8bt9DsobFBlVm4hcE3qlNNdb6N4Rkt2ptQcXw1GG/r
   60ijuLEl1VgB+jhG86mUKeNXk+92/r3waZ67zrakm7II88FimnFDso+iT
   139n6e1ce7zODqQvZ5l55Y6yOXO4i6SHdzcp+RHiKEIcYYJje8Zd6xzZm
   w==;
X-CSE-ConnectionGUID: JyVN3vg2TEeSMy5svXXq1Q==
X-CSE-MsgGUID: 9+MewqlhQm2Lx0zSyijHqg==
X-IronPort-AV: E=Sophos;i="6.24,165,1774281600"; 
   d="scan'208";a="143467909"
Received: from mail-eastusazon11012008.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.8])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 May 2026 08:17:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwtVCCDqCAKKI+0uq/VaqhMbrTkzlXuD0KE2niYp8fnhLGKtd5HKP64aa8lV93HToAsCcSKkJ9yGk2VRb1IL7JiwnwIxJH4Yp5NFYiwVurpyMfv6nV3MoMRwqRYpGrWGYSgeMpFVlICNF5ZiYnxbHJz+aVGu862F33Hx9dqrfP4CHCq/4IHvnc00AJ1UwIcUR21FEmNWxod3fqILmdB+Ck538ykhotKO1CGagme6hRsXH5ZVtVP68SLWNuO4oXF51QmcDKx6oPmIpbq5br133QN6UAhTlHAguATMtBrol0PWMpu7ai103Fc8dcdUz+BPffECtZOSVFQLl3jL9AVgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AcvgzSLx+r0SUbxrGTJnl0A78b7GsqajlvaP3zfaw4=;
 b=mRZG3cpptz7L93VvrWsTAWnEHY71mbC2glcqPMtAX1our7O1DIGZDYh0ZKmEmusu51F3ZeJFirV56R8fHkgW3L+zaX4rr4EIkjleIDcvU30JwV/jp6qdRQplPCPEy30zNNwXob/RZZBka71yNw10EnbpgEZKXJS3b9c4z6Bq+8KJlwgq3F8NPoW5UwCiSFa9J9/iN2Gr9BIFi1wLQr1ELUxrtiLA+8NhfzKH/OKzz95AlgmzzqGVaKjnbHFWQ8jgIBu+5vYmQFjOPwaoGuFbU7GsFnBbjojDFM/NmSFM6tOWBlwo9RD3MQrqJO/2RN0WCkpLeKXEuRufuI3yyTuMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AcvgzSLx+r0SUbxrGTJnl0A78b7GsqajlvaP3zfaw4=;
 b=GiuqsoLDwx/OgqZtJOVDOQvfyccgDovGHTJvL3id+IPT+irP1zlQnrvWfMlxxlneKpOEwXmQcTHxbGJuxWSc9qIwZmibGtcw765f6JaPY2FxGawyN3r10eWm/43rseu8BaS6tagkCbCd8Kg+ksG9WfdXpIfuqj2meAf2FHHTGRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH0PR04MB7955.namprd04.prod.outlook.com
 (2603:10b6:610:f6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 24 May
 2026 00:17:10 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 00:17:10 +0000
Date: Sun, 24 May 2026 09:17:04 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 0/3] introduce command trace feature
Message-ID: <ahJDRBxLbpO1vwE0@shinmob>
References: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TYCP286CA0121.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH0PR04MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 5401a650-9532-4d95-9c01-08deb929cc03
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|18002099003|56012099003|22082099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Sd3okIgiZa3vplLLvOLARz5McoFpZ672mi/wEyGb8BQBMf8yK2jgPbZDfS24BROKHWVMm9MGVn0I6cSQmsK5JOnKKEVSgLJYYz/XrjBYMzWQ6Y47OfMVnEdh6xuhqit/ppKOvfNc2ctt73PlTnkAhfwmrxD1HMmt6Jxmpky+0o65gmqcCJVjzIAENxfbc7iwbCYmTfk+AiiqpJ+FxjRX1Crcr5bTLE2KbiJBfoXQ+mX6AxZgdnQhN128VWedyZ/Tivpn3GuZMEH29CGTnHyf5S85156yLfsrui1ynz0+hbc7JvYI79XOzz7/zAgoTyp5d9SvCjYHCrWVvFJuKEjgv0iDO2uP8KoGt2rIR/FBDvz41kk1j6gDOBrZDIsh7H3J014Lnrk/+6N4ekz75SEEqkUkijSf6DmbNtCaGy4JtZYVclzrtHN5ktSb6ieTY8b1ViS/njAuR0Tbic2qcl5I9H0nyIjab4963lSvfcFHfZIVDYvS08ywQVsnu7d+JPEUlKewbLc6sFkxi13zL/owRgQtmXCgelO6RemuKnel8rtFRO26I+EqtcMVTOUXSQG2zrjoaG6le+W2fQK3r5eohBbgWSwUqVafw86njCCCYqdGLTPUa46BRN74Mkhb4leSzUvPhduQtTVKYWWjQ/lmroLkGaz3uBYSiU8ev1sFC+s8+x5N/XoGNMe81HSw0Y1j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(18002099003)(56012099003)(22082099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdhBl1evGefo2KL9ouxinddSSiKxsk7XC7FWHQl2+whVE55RaiRiYL2HLEqL?=
 =?us-ascii?Q?eCisA7CsCm9Pe82twqNWG1fdJHsYpkh7ESMGQJTaCMNKSf8cFQ2ss9vo0kxC?=
 =?us-ascii?Q?n/uEPlv1wx5H/t8FA/x28AALM8AAelZVWAOwygOvDRfoVA1ckGtpLcLIBN4M?=
 =?us-ascii?Q?A0Y+XyJ55APuHJzRHyUc1MJ55E4tyOUhC3+AOeSJtIHN16wbjZ0/ULW3X9dE?=
 =?us-ascii?Q?8SB9YuRlYMXauTIn4jUic10Cjc64hrX+fWQlmgmGsaUxiIjrmovJrALsObP9?=
 =?us-ascii?Q?nFeUj2tQPaZ2zGjR6JUhAq42Vkv0vgHHfiwCTS4tlPTKglVlhImdhMmYNR+/?=
 =?us-ascii?Q?N0aKPbtdnXLYECfE93OxycbttzIxXu0xswYyPJDSVE4Spl4y8rX8NAXDGIkL?=
 =?us-ascii?Q?jo7RkC+3cAooUmTsKJWrp55EemSK1k90564ywOFklYWS3rxmBo3xZ+ddRsWT?=
 =?us-ascii?Q?JsNqZWPqrVlrpJ9nq8hNq3wamujtVReargC9v6PrnBRcrdiMMdSs0GXxfsrx?=
 =?us-ascii?Q?rydYXWBnKuFx3lt5AsIgWSC+gcwvMTpKeCEkK5W1Wkgx3BhsLurqUgnTix6q?=
 =?us-ascii?Q?qLBhG9NjsbC+pIN/ySbfPI1kk44ApKLzLJq6my0Ska7YEmjCS38XhqNCrkIa?=
 =?us-ascii?Q?6h+nRuGXH1awcVw49kppRsKlQ+66eR8gYu73xvnXcEz1t4664TUoUL+h+80j?=
 =?us-ascii?Q?FfIyL9c9/5Ws7NxitF2cK11bKmKuR6rT+uhyjT+g4FvUy+iZ5zyeJQBIM/jS?=
 =?us-ascii?Q?O9D7WXowRhEmBQLC0UlILGMd72o50t71ZxoVivqJjEEAuRayXWvTwVS7qf8z?=
 =?us-ascii?Q?s00aFuWvsiFr3nXPnts3iiNBfQZ3e0Mh7PjmVNPW+3vDgcRgM9QA8vtZ0MnT?=
 =?us-ascii?Q?zJCp4HSvUexlB+6DAvw5hRDM1HY1eifckGkxPlSe/jEWoORqkovr1tzRVpuE?=
 =?us-ascii?Q?JSWmaQqRyrtEdIre3HpoLbn++uoYzXcOkria9c5Y/j7ik8xvyPECDC25JlhT?=
 =?us-ascii?Q?EQ6VzGq6MWMtmCpi9xilPW0k4SukuhaknVYP7LI7ZaGDvh2PHL5w6U1wY2MZ?=
 =?us-ascii?Q?QXbL+yxlnPThu+4e8fzhmPlmmr3b4Zb+cM1KP7sVKdT7Yd1prpjx3/b3f23L?=
 =?us-ascii?Q?bwS+WStSpLb5rccAqqDg+ftRRQ7pBZuW1TM+bWBOaNVdCS7UudvRlehMVxzE?=
 =?us-ascii?Q?lf62jL7rg19mISixMIizSVvTPsxZO03qGpYLB187BONskbKTjW6gdjmmfLtP?=
 =?us-ascii?Q?xiBLnGny/VonKgNres761wkgMRn6QxwEzCcKAoPJgQhv1A9Ndqyum68DkJ19?=
 =?us-ascii?Q?kNsttk49t2wVm1nK6z8vAQlbwfvsIUwQtXxJNS6wcRFx5QaOz55INyRB9ciq?=
 =?us-ascii?Q?NRhKFoirG94Bwkk1wLhknF2Xt01HJ5uw6lGuRXDGrC8kLZwztFxMO/lzXoiA?=
 =?us-ascii?Q?lWvvemY60elSepOu/lcYJrcW676sQk9h1CPgpAZv/PXRYQABnkNLDx2bTb+q?=
 =?us-ascii?Q?Ji1CGUmnMiH0S1/P6Yf94GHXiPRoiciP4wXKhSwkbCMdpIi3dY9qlk2XI5dU?=
 =?us-ascii?Q?rqHpbMQTbFOeCbghrH3Ccuv0CgaXTS2BCVlEe+VxmVcQwwCrVIJli9xkeyxJ?=
 =?us-ascii?Q?tw5Sc9Ix8XidLHSRM8lSbOiOsla9+WKzEWd/YXSfBnlIaohTW3YkbRrbhxFQ?=
 =?us-ascii?Q?wE9HQCxI0gfUngEnqiR0nRaOEGOJiV39P9AFK9/A21btf6twUwi/S+hrr417?=
 =?us-ascii?Q?6Wk5WRSFrnKUihfv3flhg8JjW6RqIDs=3D?=
X-Exchange-RoutingPolicyChecked:
	sP+eDieEfbpU5+Pk+OTHwswb9/qOjVvhB5Zze6uamyF4qnT+DapQEbWEPw9JU4w07D40zA9S8vZHt9LZSseCvVxPpy2JMj5Af9jg3bj5lZ/xe3Rov2/mZTxt6U20gSS2+M3s0hDS+4xIB9p3lRrqmPmshVjyKWVDRFgAyKGiNCgSEtOYJGE9DzWJoiODeeDkHSFnA1sH0Z+4zOxclUOCt4a9RKTYnYK1QOWYaWq8Un2Kl+ddYwF3x6U2VPAv9HqhsxKgoyKMc3zWl4Kl35SAqLiTG7iyuc07UntLyrHJILg+c+nngqCd3k+lDgGD0k+FHCKgj7GhUadeZWMo/KB1ow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	964JiTs2bF6q2RqRaKegeS8nV8Bh0t0VCB8IxlYuFTexStK3Gk01qGFowurGh9uouz+Xj48yvVNnDcbwwoCywrd/L2Nk8ewgcX05BGS0ufP2a3rtxxt/SOBitP0/9CEXxZRYpiIzE7nyl7FHiBJEWbOZ1P9P+PM/inf1DbahzgMFhViH315OR1BJRQxGt9Z5SBTkzU7TjWR0SXsGO7298F+AjbQI3uUZ+fiUSCpbJ9USbY3W1cMRg9jDfPSmYK5GRxbwPh+Iv1+Pf0PTV+3oleUbwfj6kD6jvT8pxRxBeaNVq7bKAdnFcnlx+1O+FikSn4e8tfXbc/s0z1nFIhLP1cz7GLhhZlymRDjVvEbNPbU0WHsp2egyBmOX6gpyI0orL94YfNiVq4LT2z0XV02XUhZAJSPLIGBKMk9Pv6+l5Gd6jwzLYTghV9UZ+Evq8saox4MrI8zz80AaOCZmUbLVmDq49STWrVGK7nKsdVWIK6pEXnhDEMdNO+R/YtyO0DGJd3Z6TZMM0iEzJ4X2JrymJtg9epn4H1m2OW3K3qq06J6i8LiHDom0rRAvIBj713d4oo16w1zfxw08P9SLlxg200ozHul1wdWoAJ/j6hoZ8NmaRbG1K4GoxQ1ACH12EGNt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5401a650-9532-4d95-9c01-08deb929cc03
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 00:17:10.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyZAhwg0h78o74x6ASp8mbKeK8q9BuUB/OEWcpfZ3+1lCVOw+uzDnTNT7lUX2elGkv3mZdYW8SjJT11NhWI9ZFFcrpOw/UOaUulHUFeDodY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7955

On May 16, 2026 / 21:07, Shin'ichiro Kawasaki wrote:
> Some blktests test cases have deep nesting, making their behavior
> difficult to understand. For example, the nvme test group has many
> helper functions that set sysfs attribute values and call nvme-cli
> commands. Understanding these behaviors is essential for debugging test
> case failures.
> 
> This series adds a new 'command trace' feature to blktests. The first
> patch introduces a new --cmd-trace (or -t) option to record commands
> executed during test runs. The second and third patches add a new helper
> function _set_attr(), which traces both the value and file name of sysfs
> attribute writes.
> 
> With this series, blktests users can use the option to generate a
> .cmdtrace file that records all commands executed during a test case
> run. By grepping the .cmdtrace file, users can check writes to sysfs
> attributes and nvme-cli command invocations. The example below shows how
> nvme targets are set up for the nvme/008 test case with rdma transport.

FYI, I applied this series.
