Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66255351C22
	for <linux-block@vger.kernel.org>; Mon,  6 Jul 2026 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306419; cv=fail; b=UGRTa5iYRNv6xX3ullaVl68p5wGW8MG06MuD6GWXRkNtyF6ciFb5p7vd3Tu6hhMyaL2geGy9AiIa7U3vTuHBaN4fgqSagw/osQyeRX6f1Kf109JpzDt4ND9lLYXX5sqbc5AjR7xTKw2Y1gWOGsUDCVuLl4wrjrAmdSotuYE9yF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306419; c=relaxed/simple;
	bh=fXVY8f/jCa664wySj0dSUBkN+y45HyPpEh+RVQDsRfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u8HtLpfbcTuhDXpopUzE69fZfsvhXxAKgTtJDXiFoC9J6Mf5XaCKKCX0zEU32ygiInJc+OE4LobY8uqNowsG9c4YYjlx2yUr6AOhOinaoOxjsQ5rvji40cg/RvkQ+Sh48QFtvSj4TOyxZ7aeRJQHgwBsZAwK6d5+PdkiO0ZYyFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZOJ4b9QB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MedbjOou; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZOJ4b9QB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MedbjOou"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783306418; x=1814842418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fXVY8f/jCa664wySj0dSUBkN+y45HyPpEh+RVQDsRfw=;
  b=ZOJ4b9QBhy3HP246pifQ8Sp5ILgjG93K+ikKReDosWyBTlwcFvRtKFlq
   VKWhpnwmTD2pEqsoFjiP3xpKDTsr3Nx96A+300kQzXnVHlBFzgkxuCRx1
   9P0IWqOevg6kr7xyatE5hvZftzqOCFSd3M92CQGRCrACVsy+KCbxKZNCS
   bdrR0Fqlff8P7sc99v8P6lHa9KvLmurcq6B/zOKTrcAFMHb6oMnux6ZJ3
   Mrbr8GAPAUk6J17ath4E66yuCSdAsfwwbnLwVsd253jbW5f8s8saGxwgX
   QlDOyx2zR2Z7+wmgeKCqxY3ExtfFNeO5w9mHNwSz6wREP211z8qZe7SOF
   Q==;
X-CSE-ConnectionGUID: EXsCpRvdTU6rSKNhFdK1WA==
X-CSE-MsgGUID: ttNENR/UTHi27lktnof1fQ==
X-IronPort-AV: E=Sophos;i="6.25,149,1779120000"; 
   d="scan'208";a="150127911"
Received: from mail-westus2azon11012055.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.55])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2026 10:53:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0OPGVJda4ZB2KWxSnTFw6Si6ImhrUbzCkdRhTL+S2zre59Ebbukkt1GY1a8aCeXmXq5RtHafEBZKVOKBOF1QANESL0ogFHO2rXG52sXHl1iGt8QjOqtiXRqofxb5odg5LgZlEDJiZPNJ7dfY/DsNzP+Lsb0CUIAeQmMNzqYqItZ+5apzejY5QUtNhZkvxLHwKRsOjXhMVolwUXD+a2c5XgZ6TjwSOq7j4cmSOh1Gd/gvCV9kvZYiR+zo8W9x8M0IzwHmr4mt76OzB71alpxnapuGF5nbJzWA+ITx83EqqlVcXMHgyDdiwdiLQ34INeJZwDrdKw9Vj1PJkSyl9grtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKAI8QcLYmPo2n7gxEH2+EOoNpz+uFuG+gVhIGX8/4o=;
 b=BjdROVz1Oj9by5/RvKeUlkUfM4291FPnO53XYF3M2PmjF6D3RQU5bNSTSXXUBQNsPrYlU8EzHcd9WYFEFKzjqJwYIJK13Flx3mGXMb3DnQk35kHTVWc6qQ5NAg6m82rQmdqV22NflHtUcOsvz1JYKt3RDhaEH+rzw/oRBr7/+98hSbhR5E4zLi6HYWYkMAFjPwwBSBOSAdjL3d1mYpLukHEbGcd/R5MEL7etq3HZH4jCOWDgBYkmS0VnjMhlPk6ohNBGrFP494AO5mydKSCCulPR5NCmiehtp/qSY2Z7SK52uFv/58MKiLI+VEFaGm0HqknG5pfNG2M+LI6J9ot1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKAI8QcLYmPo2n7gxEH2+EOoNpz+uFuG+gVhIGX8/4o=;
 b=MedbjOouB2ZItzGjvsShMHe/XJRsPx8XBA4PiCW+Wx1Ri72lZUgZSSDOBdnzVjiWMkNxWOVw4+Dyz4/21Hm6e2S5+f1cd3paP/6D6YDP7k9xxW1hGuWPGRhvBKA3x9Th96lMjpdHQs/Ov1i54GLtqr+zLrEuhOhslS1fbb5tFlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PR04MB9817.namprd04.prod.outlook.com
 (2603:10b6:8:2f5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 02:53:30 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 02:53:30 +0000
Date: Mon, 6 Jul 2026 11:53:24 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Bart Van Assche <bvanassche@acm.org>, 
	Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH blktests] README.md, check: require getconf
Message-ID: <aksYjIj5uTl9uIh1@shinmob>
References: <20260624071815.54600-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624071815.54600-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TY4P301CA0092.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PR04MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: e06f9d65-114a-4b5a-b308-08dedb09c2dc
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lFzb78utajOixI+seHtDFeHMp1O1g4i4dvhOA6p1vtCoMHcJ3DqGySwF+sHNYcWRKBMYIoAzeOIZDr+hJ9koFZ3yqhz1rX2oTmTMWs+b31a+rNVXqMjAgov2T+prwJM8g75Yy+yw5r2G1Ix7+0bOokPtbfzYOnLSJkwWbkgPaCbNCPZkSfRPIWCjODCK6jVequnfDvPziVbfbDXkvfvXdW58jCpu2QBp28VxzNjzvWnAzs5k+N0X6o665azP1ZRcYrSzNFb6YzhmoWpZbYNzU5d3Pya//uYK/JtSpOdwwx3rw5UJuysHTTg6vFg1b7w7DRQaiOLZdUPc+cXHGd0fiTwTV/1/9pXu8BKd8XiHZppgs8gK55qz3p3D+n+4+1CcWAP/fNlYJxO0B9Q+85+8mzpHB+JAL7cKDUx8fab+jOx8tCElAgXD2ail+Hz/owkesE9QLP9nYw9q1ynDZ/CpsfN6qMLwp8FvGYQ6Ifqs84CmEBGGojGHOnyK3hfv5MTKznKjTBz5gwTrzhWN/r2rDCd++xj3MiuAalkMy2Lee2cnTaDvF0+WHEcP+9EMiVAioV9DlTcjKjtDqtk1hdRMtbBxKSA+i1KTzAwOoeinNfrGTaAd3VVJu5ZkEEQKJwzXLoU9RJv6qqrdilZZZ1qxSxYMeqE70ZbAt+FgjmIxaYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PRwoCLRYV8pJHll4YNtKBs3COY/KmTkqcNVpUCTYPz4poqRucWJTAjuI06cC?=
 =?us-ascii?Q?ZEmmQjmW8czZYfiR+mSOdG2Aw8mLGmQg+7eL49qxz0uJ+fge2uFxp+fgY8US?=
 =?us-ascii?Q?c53MyRzqni/pnojP8PdRSv7Ur4iPvacgTizXYXEP++OntJgolYQtBYabjnRq?=
 =?us-ascii?Q?/g7/gkcW+4iQO7c9huplpVFo7oI5/ACL1KssXprJvW2S2PG/YlhpQc8QCY7N?=
 =?us-ascii?Q?96e+G3njXnknij54+8BRXyr0WWQnWXnfXi+xQxU8l72T11rUk44zcRQh2l2S?=
 =?us-ascii?Q?TnAU9sed0/fW40C5as2o83CMf3SjQWSpXyVn1I6D9eiB3R/Peuey0SmnlanU?=
 =?us-ascii?Q?UTu6WVNDwTb0a9LWtiiIByBWhCkHsJjWXViLw9aJNNiqoE99fZPzFiUESHbF?=
 =?us-ascii?Q?dftM9bB9liu4Du7Q7emgPqB5SoIzpdVuFTsrXtn+IZg351rGhpdVGhj9ayxw?=
 =?us-ascii?Q?7DaCymycswFmkG0h2Hm41kPBHAfObiPYGlbuyNcTk994zecrRcB1amaZnaWU?=
 =?us-ascii?Q?CSMnUCnBP79Y4HQrFEN98Gig/N5gePzY+vNr/qzO2xfaMEC/zoEtdPur10To?=
 =?us-ascii?Q?ZvQzkODj8tBsbF2rv2gBH7A/owiGKJyLS3EvYnhbqnyzt2Ehfy1SMKW4jrIO?=
 =?us-ascii?Q?82UStnonxt9Mrc5EC6H+kKgwbvNQPvbVUxfT+6EL+zv1CFxYHMnnIg++YcPl?=
 =?us-ascii?Q?2Oq2LrUD+GnD9I5Q7WbOoGreKfC0/DsveqbuE30KBXiZFkWoWl9Za3nHlxhO?=
 =?us-ascii?Q?DrbCqjZrFsvM+ZfgyTxjO+Zq2iux61ZK19kYYpq+tTSVmtgFU+u8Nc6AXb8Q?=
 =?us-ascii?Q?ftTQJFH5BdMxB0gklwfnUWmO6g3ikwsJVxMOKmwEIBomsoUw+zDwd4+s/t9G?=
 =?us-ascii?Q?xQ0gQgEHYH1RarVahO6tEcspukTw1IZz4HWAv28dJyuvqCMrcjrYiyGeA+Yj?=
 =?us-ascii?Q?BqKal+wrEA26wfbOu7jBTYPiPCwzp+tLc6kxm9JQFrp7SIgGkzYomuE6Kond?=
 =?us-ascii?Q?S2m2hkBiat6Rm/1zrKzM3OwrIsIDU38o8Zi8X8nHe7heFmc71WN9qNrvZ9RC?=
 =?us-ascii?Q?ITvsQQZQOD8ZuUF7W6X+l8e+G1cRgfZIKNFN4WGogy0ruXjyTCeaieiOYa5h?=
 =?us-ascii?Q?H9tu3WhM6d+tn41EZdUaj4VwYq/E0UbgZJ9PggrWABfEO81RQCYUeqfLuW1I?=
 =?us-ascii?Q?UUk/H66mufUQ86UgO5gKZlb9Vf2D+zp3DbpHM5EWuv8fn4tRt+PaII+YyNjy?=
 =?us-ascii?Q?fd2LZ2KeNuLZwJhl2L2lAWs93VEfNYMvU6hZNhThQ340Btn5xFpaBNYtNHIi?=
 =?us-ascii?Q?WuWUOAD8LbXZyQG77bnJ122c70SvKQRkqhBNSczofXX+dA49UtNrouRsJ9X0?=
 =?us-ascii?Q?9yKDxCN+dWMOAs2X42GrVO00liIuROUY6zcaELak5iuugkVdynG85iam11cX?=
 =?us-ascii?Q?DXt8EFXbz00fk3FazP9kTdHTc0jTRkYMogyH/9grAjn9F4nbQzUFjHkkgacE?=
 =?us-ascii?Q?2nXV5RN3FuSW+9eFVD+1Mfl+Wiw2VczSQIooq8T417HQ4gducyiIgpOm5oG6?=
 =?us-ascii?Q?d7Fqj2iNCxR6mB5DBoFGs4LsrlBSjsWYWAWzin9YCLyLW/Nz+Crb0UZC9Du5?=
 =?us-ascii?Q?VjIimmcqopC8/olzYTAYWD6ADe366vgoXAFmnp2DP44+1acSHA1ubLMXnbi2?=
 =?us-ascii?Q?W/5+PA8zmI4fXqzvGEQ8Sx7B2Eo3DSqCNUyW5II4Unie2v+Q6Kc891aIoXWy?=
 =?us-ascii?Q?NdLxICuzTpz3d4Hgg64CuP9rrUvZk5I=3D?=
X-Exchange-RoutingPolicyChecked:
	nRwqGG+cOq4LohmYLI6gCJD1yonvbC9vFq7fJWF5ZuT+cWgouJ83rpuCT0ILEkSCuxykSQ+ylv2pJyIWzBXBLy312GlptL6Vx/YAzyIMmQA6zqaJyJX9ALfvaEHNbU+q3dzrrH+w1IpqgvzZGnLWNMSiRSkITkaRJ9PIE+tJYCHoqcC/d+lxDn4ZIkQOJCIawEc/s96CCbVWoDE4ODMwfkcmbrRQ/EEKrux2e0g9Yt2l/3MbXn4wvlLKtMGs6Y2y7d1ptd0+r4zH6M2QZZUpugeLEgCk5ls72V72tritv2ryq3bQeP8sHSJVQL0V2fgDbeKVVlX41l+ODbBZINJEYA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NstDAgD76MFuCfFxgwphD6w5kyyXjXNZwynBfgSszOTv2MnR2qA6y51doZarhJ5PJM+7/8AUasokcjBQmuU9artYfcO1LC9c3UTR+MoZff6INs+dojH+PH9/usWvLQtT/QPM5TAa629FUbEu6N3/K9TY06t0DrbkB9D3oPTK0HZ/cROHOwtqfwpUYRoMD5TIR811g8lETqHcD9whFClc84Tt7nvfVSjZVouUHyrACXwW45ZbUZ0Oddr87vT215+ZacvcESE7R0R9GgUHioCyLATBCdGMDt9ABbAG+TJLbC3GAzN9A/PeNcuS/YNK4WY4wjDg3545xjgpJlBP6d5hpNFdTjgEO0qngxjicDSrv56v9iRd+BIauQ+oNJNpdShEGgT1GyHJCkJcuvQf4bNmVFg12ODItByMBZll5fVfHLrFAXEZ5nwBFOGTsRz0NP3RjU49zF+yFQXMfPpdJDvW4zo/utqs0zjprNC28Z0A2jpvVanjt19YBd08KGGkynJB5fVR6dH+T6rw+QXdLyFdmpas5+FWHRcmVxICAZcgxo9CeEQSzW110IcKCEoKVk1JeV8UAA9bwrMV14I85aLxZFW7Ofjmz0BiH5rq/Q+b5Mb93fXru/UNa6bAfJBV6awm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06f9d65-114a-4b5a-b308-08dedb09c2dc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 02:53:30.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/ah9X2LH5tllw5blCAZDFzp2n5O+cv4oO3n+7VnzmKD0chr/xoX6SxJhEZY35Qe/Pln5Z+fsg3KROskTeXumLGgf/+LgrR5syenoty1nUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9817

On Jun 24, 2026 / 16:18, Shin'ichiro Kawasaki wrote:
> Some test cases use the getconf command to query the page size that the
> kernel supports (e.g. scsi/011, throtl/{002,003,007}, zbd/{010,014}).
> Add getconf to the list of required commands so its absence is reported
> clearly, and document it as a dependency in README.md.
> 
> Link: https://lore.kernel.org/linux-block/ajm1x0koQ4BftBOc@shinmob/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.
