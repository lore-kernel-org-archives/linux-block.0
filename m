Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43ED17A305
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873134; cv=fail; b=TtK/bwKjMM1wGckao3zPF6w81rc81wMlO40CpmkqVABzCLx6V8DZjvDMo27eNN2hYbOKj5PcP/FADBV3UTmkJKsZHCyby1iEZ711quMcEA+QWn3tkPK4K35laic8UwQWvH4F6P61TXlElTSqYxqD1FzKnKkreRBLzp7SSeXGhww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873134; c=relaxed/simple;
	bh=GVWuAwKCGe7+8/h0zashj31LnVmaM1WIcfHw1SI6mWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a3CxPEV9ltbbLJVIT9Buk4wOkED4dVfEEoI5ZDa1RGU8gCUo0fvsb9b+4xg6jnGph7IKiu8uzLaU0hB++hRGf9l2PKhAfMD8vvukahouDs/GKyhnRcR8QKQNFV9A1n1LNaqTY6zsxRPvSweI/xWaz5VOksqnRIl+kjAyoyxdNjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qVlv1GYK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YkvR5Mhv; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qVlv1GYK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YkvR5Mhv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1777873133; x=1809409133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GVWuAwKCGe7+8/h0zashj31LnVmaM1WIcfHw1SI6mWs=;
  b=qVlv1GYKbf5x6I1cmUaQppScVIDzaYkHsStes8sYPwkI/RTq3lb1BIFF
   Vm5qbfi94JmA5de1SlbW1YYfZTeNMrC2CLPpa2Z8REUJz7ZqIqx38gOJ4
   9TDhKucy/YgmABp347WaiwsevnOaXAk+Z3vw0cHR0lkEDO7xvF+qC3Laq
   0j8uBvTOj7fAnRa5mXcysQBgxJRDd+8XaG8cVgvRepnvQedfViLdtkY4R
   Rbr97Z5fg+G9vxBkaHUom+dryaIdllqsxDETotkTdIFlwmKJ+AZqHtNE2
   23rug5XbCt/+rgYSkbwAiLbRLUTYc5Nu0Mfgdf5XXcMAPHpFsE6pwhAcL
   w==;
X-CSE-ConnectionGUID: 37GnI+bfQhCEasdRIBWJhA==
X-CSE-MsgGUID: BNzYKwtkRB6HcRh6xBm25Q==
X-IronPort-AV: E=Sophos;i="6.23,214,1770566400"; 
   d="scan'208";a="146221317"
Received: from mail-westus3azon11011020.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.20])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2026 13:38:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LynQaGgn72y1w9MAJ0UF+bQkU+7Z05e2Hb+S6QU3EmHfmpqfDD0/KjkKa1XdcwKuCdjqrE/FnMSaoQqw/8TWW3vmYVmjf1/QXfdUmjrTRxrVG8V5FzJIHt9DYDQqXtyTx6fOUZ8YfIT6PJd2DyOFEKnMSbvet58R6d8jztYvTiQy3gF+XHZxZCZTNXBrTHsiFxc+9mVh3+VkJCy9/Ybx89gTsrJ8Eoq3+W6Rhp/uFwP5m+r7gZvoSCkCQbqZGbdamkp76BIgxTv+sNOUO+k9sAt2XAi316LZaUTp2geazM5HpSLsdbNqAVeMtBpJCHwyODZP+qCM2lWeApvyE0jvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vPTD98f7Z+fUAVpZOqqNwb//LAMzVChLTczV0Ia9Zc=;
 b=m+Os2/8kHsK4WV6lKSctlgH8Y5lr6jAPvdkRGWY9gW0xBweil8sENFOJGOlo4NjivYJ9hc3I73icnu2OyNLXIFmSu/DmCkjDwAaTvD9aLbL41afs62y2j1b2zAlUtttnR5u9j3wDN1J3iTC2bVBW1lv/re/kfAJAyHtLxKWcpZljyRqlCX68xkupBZqvW5tmFFFBRnJ8KgCwsB1FNpiJbgwfyMQ5doOmNZMj/ZuMjyoP3DnHZirxytC4SiWCj5n9ALEf+88k0nSCkqKsnLg1nBgresLnb7O3k+btrfFN/XsSJKNDv1fhcQRAS2fM/Si47VkupjZeN23jk5PCJ+513A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vPTD98f7Z+fUAVpZOqqNwb//LAMzVChLTczV0Ia9Zc=;
 b=YkvR5Mhvr8d5nP0Wb51DWLlpHG47lf9xA3kHoReoJ8U7lx5ivDI+ngG5GfiDLVdrMsVwXqtQapDcyhpQNIqtCRCZwRpZpyCRzdrkfHrCC8Y14D78kSLdz0Xk9V7KwdSnlCydB1TCuysoKTtEmVGhyBEinccTMSx3oI8MR0nBLd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM8PR04MB8167.namprd04.prod.outlook.com (2603:10b6:8:2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 05:38:43 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 05:38:42 +0000
Date: Mon, 4 May 2026 07:38:37 +0200
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ci: Switch to actions/checkout@main
Message-ID: <afgwa7dzlmw1128_@shinmob>
References: <20260428140859.445516-1-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428140859.445516-1-bvanassche@acm.org>
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To SN7PR04MB8532.namprd04.prod.outlook.com
 (2603:10b6:806:350::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR04MB8532:EE_|DM8PR04MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: df1c75a9-31e7-464b-c3a8-08dea99f6713
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VYSp5Q6XT08vuXJlBpzDM3OF3nnIzljSIINe2V+FnslLmr3jFbecpQA3pnYJy7l8RGgqfqqllc6B4q89mzAW3rh1Zo8QCYBaPizOnzLNkBGR7oGdXZENTlLNo0BvB4qDEnDz0Y8MCTXTIO379wYMEiK+vsxpy83AoNQc94ZTes4IEYXCtUioIvZ7kgNJMmt+W6Y60OYNdbBRgvAiuC9tG9H6AQACXUjG1TmklEi7+6b3jY51jpGp6gVopZblWJiQZ67kXRuBEgeU6NwChm0sTaBp9I7f+Xh+RQ7g8ukrA24vSDbw8k8iSX6EQncayzbx6xAfX6wgXftuw0YMcCqDmX4VqrRB4aGJvFrhagiICz20AKjBbo0Gc156ntUKaiv8jMRLO64/2AkEzigeYl+wmKFlV7VvNrtq5hvSo62xVzEzZqI9/b5Ok3xoWI/uNBN1unnFJfmKd1EbaTnrZcPIG9dL+jl4mkcdlT9HjaSV7iy5Ppdaz8zlRyDQxv1jmYFDoH0GtgCBaMtCiRxazkyjidptOOLroCN4pj136hNrxNpzhyYGQDrfCn5GHZA+Z1e0Ao7T4tPq4guUaySUs5CjrnU63p7QjwMwGd9FbQMTQ381wahctDTSV/pEQVFPyuxHbZZarK/6SNljTQADdR6R5+P736xC8WroLmDoE8sn4s1yBoiGpcuiQW8f6iWgIOXJ++ZpXePlB3uFUlUP1QH5rQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NIux7fD6+GTC5ywu1h/Zbnbs/uNVIcN36g2RwNokEF/NS645Nf4Q+w1ePYOZ?=
 =?us-ascii?Q?S3YRi4pD238e54HFKDsGAhojlkQwaOyouUnbxyf3uHEju1uImSUC5XPKbC8S?=
 =?us-ascii?Q?d0jxj3GDpQZR0vHy2pcSIK85QbA63xAedJop8J/ApY8ISVL3FEXT7+ez2a8c?=
 =?us-ascii?Q?6K5ZNDapvXGXY6IIOH4mT1vzluyjL3dNxYsSRyMObRvkE8DwN5H003hmQTjk?=
 =?us-ascii?Q?URPrapJt30elRkl7XdrCxccoGYsUx0aikqIk7UkG9CzyLXWrRHhUanH5a5kN?=
 =?us-ascii?Q?IFQUGZW9AWIYRgSEkUOWFh9JOo+iwAjGicDXjRgBkeLu8mE9u6KAlt6gvKeu?=
 =?us-ascii?Q?VMJ2j8u3p9jDABQe3fw0f5mRsFk6PJHZmPCApGlr9K590DPHOIDXiFunp0ql?=
 =?us-ascii?Q?EjxmBhpq/Lmty17rS+KKFeMzl8H1bOkge1Au4Xe8NFEkRXEeKZ3P1m8QdRY6?=
 =?us-ascii?Q?n7bM+KQh6JyeaJY3aUAPawdL5jocjQ4fSCtqwLWfpph4r3hJvobRxbMS5+zC?=
 =?us-ascii?Q?4MLOEoMrxbgU/cnNdqOYj+QMiBisGrt/hwdWroT+QBJxxQI+iJwVTSIJulaN?=
 =?us-ascii?Q?0C0kcBkvIl/8vo+RrOnC0y0RV7FQcfnqkkYcGuf3hoK0+QmXdhhM7l4MmJhI?=
 =?us-ascii?Q?qE4kjAOsnU/re9QvZ3uG0TohK6bm1GGlz20YM5KGpunAjj/L8/FbAsV/IeRX?=
 =?us-ascii?Q?DKUhuzvvb1sZBOUdGfe1q2tsYpqIKwxT2hz3Xpn0ZF91AWM7Bk12sE37zx26?=
 =?us-ascii?Q?FX4vEYvibIfdWHxUOpMCfov0gewF3U2mKIXVHYbHx7GLr9YfftSXM3IIdiSv?=
 =?us-ascii?Q?nVQgfvtDbS3fkblsuPAv9JtL9sOLpxWJcTyZXX1f8pqEL3AN/VO9wlB+9lCg?=
 =?us-ascii?Q?YvBtEFJcIp1Qn+XjKdjQYlhUj3m+iUehLXRaqr0XNF1ivpos7GdcHTiFz1JL?=
 =?us-ascii?Q?YoidWajvk5jkHnT3LQaLyy1eqgM8vb2rFtzkFgnu+G44TRZScsfIbpi+q2oV?=
 =?us-ascii?Q?O6xDZLz/mlZz8M4eYtJQtD7PriFy2RNU/EVz3Ln883ObyJKmJMgzEIMOUHLP?=
 =?us-ascii?Q?tqUn4dcSV6JHTM/G0L1V1tNjVOJkMOyBqmxA1yWTZ/mCpcfp9jTi89Lp7CpU?=
 =?us-ascii?Q?GdOUGnIM9XO/50hmBSzOhIt7LXiaZgehGEI+wbp8vvDMUVkcVPej8o84/z+y?=
 =?us-ascii?Q?3EVhqO+aDTELP2bI0p2K7eOCjI/Jxotx7SJ4KBg8vGb9acoe4OD0p5dUWl06?=
 =?us-ascii?Q?hmAZIzy5hHEmUuVvs46jGtAe+/j3FqHfjD86x7twuZISixlq0JY/XKvazo8Q?=
 =?us-ascii?Q?u25tOMVEIZQfHBxn2HUKHU+F2gpj4UTQsW2wGpgeFwKp07g0eS2pX1+8vuy5?=
 =?us-ascii?Q?ToYuCNN91Zvkpl4m3e+EiZ7G3Plc3HKESvKm3LTAD6KWJscoWb1FDOhs9h7N?=
 =?us-ascii?Q?xAyFf11611AiI3oG+VOnYkCFruJYjxHztUfxyaGVBWJuDBLiHORNJCHK+3rS?=
 =?us-ascii?Q?1jEryUvSroZL++gtk2GF4iYAGbAQYg88FN22kc+f0XaaEViDwMAL8VsJdD23?=
 =?us-ascii?Q?n0MgewduUUv502xmaCDq1pm5tubz1s1Hy7WycULVHlIkid6Gnok3LHWNnhFR?=
 =?us-ascii?Q?SfTAAxgu+OUczURX9WCFMKAcakJL+/jFzxBBAHkFLSORFgTcsPuBsoUXc25E?=
 =?us-ascii?Q?c6VDw9SAtk2AusCCXDNBSNgqI3dnHR/eP6dQMVXVQOLrDyJKYl3S/y825YUu?=
 =?us-ascii?Q?UKpISkHzp8O7Dh6eO9utPRTOJd+ZHwo=3D?=
X-Exchange-RoutingPolicyChecked:
	sgYIuCrcYS4Uqf6f3D8hkKun+1rA2apGDM319w9nW9js8YuHMoZPjMlfASUDTGf30mwRhn3o9efiJkdVp7b1P5sVZKNtozi3MVkQW0CUd6Kebe5L3wDIxJtms5n056fs/AOQWLehGRRyKcwyv2RII3lYPWjYvleIkAV0eAG/4zBQTLXHGFAc59I+Hzua0sfEjSpfiQZgLYG2KcmsoT/47aX4Oyz7+1CEcBqTj4IzK43etT2GWhHHTEN8atEaxy9uNSJIQfWciW6E1CG2Qf31JmQURjtCM9BDkVpadOn2IvtXSTkKj0XOe88jtqZxLUQBHWCr+BjnorcmJXcTFdiHAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	889Y+gJjtW7oU6fahYGwRMzqLIgongSZXjfyBCzT2VycP47EzZdgAwoQBmea+nkkUnAS5BCInbdJyrb0pgPRJEoZGU8kIRCvU+n+E/WoABs8aAkNJi8zBMtwxlqDKvnajbhuV+EJdbje7iGFimt2NfpND5jKshty7tEwoWPjqDFSE0aKCF3HvjQEGAUcUfkLWrQ02JLQft3VRJdxX4VxdPDJ294IqF/U+Ul1icgWhmtKYMcPn7JE43Vb+2mSRPMeSWBLZhWafWRO8FuTur2qthDEWuGmqqRI5yxKTSqgVy1ttGks63Q86IAfuRQxhdSrJwgFng1za0E2QbLPIRWCteEJCzfwJFdtL1gp1ToegtskDNnQeivlg0HIPPqwerbSnyzRnyU4rKFIyOajiOs+9ExEFIEBvpVTqG/ny5WOVKSwsp3erM7AsCHs1mHDFQq9HcRGnRsbsZ7b7AmsHjHI7Tuo6Oa5DrWZoCJ8FPu22rtvMqB0WIMc9d6zz24wdmJvaKnLXpzwpCXwKMdtWlmgPmoaUSYrny9uuHTwIr/YX9c7Y2woySuKKvgqKQfofZo4Xs/eLFejm1H0MjHtAd1t0i/ooFpxf73PoGtMEAneV++jOoGb4XvXzQ6xAQn+91qu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1c75a9-31e7-464b-c3a8-08dea99f6713
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 05:38:42.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyPvkEFWDx3wNBDVPX0cGmUp6srntDs2ONF6MU877viZSJxSpvHcChFk4x3ePKuW2rrhn08/Njqu3d5KzQ1eTaac9L8jB2c9+jelocDMNsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8167

On Apr 28, 2026 / 07:08, Bart Van Assche wrote:
> Suppress the following GitHub warning:
> 
> Node.js 20 actions are deprecated. The following actions are running on
> Node.js 20 and may not work as expected: actions/checkout@v2. Actions will
> be forced to run with Node.js 24 by default starting June 2nd, 2026.
> Node.js 20 will be removed from the runner on September 16th, 2026. Please
> check if updated versions of these actions are available that support
> Node.js 24. To opt into Node.js 24 now, set the
> FORCE_JAVASCRIPT_ACTIONS_TO_NODE24=true environment variable on the runner
> or in your workflow file. Once Node.js 24 becomes the default, you can
> temporarily opt out by setting ACTIONS_ALLOW_USE_UNSECURE_NODE_VERSION=true.
> For more information see:s
> https://github.blog/changelog/2025-09-19-deprecation-of-node-20-on-github-actions-runners/
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Hi Bart, I applied the patch, and confirmed that the warning goes away.
Thanks a lot for fixing this problem in timely manner.
