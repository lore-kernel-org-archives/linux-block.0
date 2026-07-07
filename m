Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8D3A8FE9
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406343; cv=fail; b=kA8foyY1qyAzatWLEtM8P6qTjAXmq2T5qP6jvcfqGHxeTc+ByhB7t1nYc6aZybi5PRCeeo4yrMrUGybqZrLpdYkoQvjsj6E2HSTPblDr6vGMb5nREqbgxI2FUXhws18WWj1jLF8ZorGMB6GA/krsQGAipJ7GzR4zam5rpmG4tNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406343; c=relaxed/simple;
	bh=RCb9mEABY/uSddJBhZH12s+/RtQFsC7soTpagah2FKQ=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=d2IyQPlrTZK0+nMF3x0WVk63YZ42IFlR4fL2wThHp4kybXqAjqCXx7Ns7DHk22ovP+zIyxgilRnFYiSvR6Ec/c5ZgL8pElaVVlhlwE8bm6qsvo6bH9oEdJxUl1u/IXOGCRjhSIHbHy9HhXHBGmXRxjAfflUO/C15E5pe2cdasNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PhEIWz/h; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nH0Q3Bp9; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PhEIWz/h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nH0Q3Bp9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783406342; x=1814942342;
  h=date:from:to:subject:message-id:mime-version;
  bh=RCb9mEABY/uSddJBhZH12s+/RtQFsC7soTpagah2FKQ=;
  b=PhEIWz/h4Ir12QEnzmsZaXLBJt/6KdMkPQe5d7WxT6VWoG4nFcYW45Xa
   jAerjgII4kqD0CgX937lzN2mKTpbJYYxwJk0Bz5Tj2i7EVYxSuKBiktUh
   adxoxCkAALz1BYCAClHgeMWkGOt/iNtZ84CG0XuQxd2icbNqML8rPWv0l
   DMZdwiIwsX/T5DW8jzGz/a/LEVytYFWHDON6yWoSym4fPVvCUntHxIaWY
   JaWCr2GRJ3VJ1VR7crtLPDXfleII5ofSF08LFd2a29rKcExtzEbDJIkZr
   umT3G3+InzBJt58wxtYBuGHy0rYKspe7cT+PMqaZ6S8WDoyh60vzxMa0B
   w==;
X-CSE-ConnectionGUID: PsCPaGTcQ1mXoJkyB/qLYw==
X-CSE-MsgGUID: ILFrSaEwSUy5ZF8OdAFiFQ==
X-IronPort-AV: E=Sophos;i="6.25,153,1779120000"; 
   d="scan'208";a="150530897"
Received: from mail-westus3azon11012039.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2026 14:39:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWdlosRFUAOJ3++BAdCaHosJfO6Kn8ZGYoc+62gQGKyp2UR9lEoqPm2H5elFZ5Xcxy3XOwi67lOqfV6CXCltXKTWDjPN7Ph255H/SMUtHl+qWyh5G0JGzMHMi40sKn+a35Z0HtTiuL6lYZe89rZpuQMIAWiStFNuiJMgTGtItNb8xzKkP2ssch12BJGbWjcYCukXYDxIruXlVWiKm5sc1BfhWGuWO+MaFbvNgJg6Vz8ysXl0gT/lQ9d0IAMokAtDjLi04XUCB/PiQjaFdhTUA5slncqVOaFEmh4xwRuiILQP3nI6SkZ4y//b3l3lIavngtJP3z5AQsHpPThzwvwmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbokwZ7XnrehJ5BQVwyUF3DdVRQDAmd5FjMqiXrQBeU=;
 b=dsERCUkMSo43zpdSZ3aDvmtAg91j15LgM07wKLckcWFdE+RvDEjXvOORYclzKeOYZ19PD9lziJEsJgu03yLgTiwbS9UTlk//9iJTzQwaMgAHbeUJCbcdhrlBmDH+FOoSQjd7FHn+bSBgctts38TTEF+LpMhXHb85yXhd/HUmlFI7kYENF2WOvZ8oJFygZ8kYYL2jrWFOEXTqIn+j/gXfXJq/LYQvksyzXBNKF8Y3LiRhHqUChnKoeVkyTTNkSNxy5jfd8pjVnzDBJv8G/5GRWL9LIOHatfm1Ysh8yyKpJXRtjhNLlawu5acEO5ExlqL16zRdSKbvM50RxtsHOGWXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbokwZ7XnrehJ5BQVwyUF3DdVRQDAmd5FjMqiXrQBeU=;
 b=nH0Q3Bp910wqTVR+DzTrLXJGQ+pRotzCzZKxDO4bAPFlrhV+yO6mmFHOOWPXZ6kmwBfMxBZNQcZGA6xblgedftkYQYeEmGfxVO2Ie/WR5uR559iZ1SrlKFrBLbbOBp1p+zXUXZ9M73OaXiVaNBZRlutLBuJgWfvJeSRvioPSlm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN0PR04MB8095.namprd04.prod.outlook.com
 (2603:10b6:408:15f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 06:38:58 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 06:38:58 +0000
Date: Tue, 7 Jul 2026 15:38:51 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Li Zhijian <lizhijian@fujitsu.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	John Pittman <jpittman@redhat.com>
Subject: blktests: call for agreement to relicense GPL-2.0 files
Message-ID: <akyeX0hlcrnOC0nT@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN0PR04MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: f7921d5a-bf68-411d-005d-08dedbf26c8a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|11063799006|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	LhMUzViSNawZYCoY8GEqu2E/Vyfr6tnsuR7b16mm870nuYdlMbp1haJ+F/gqxj4CdkYXRw5sHECYhUq/b0Pyt/ZUvuH3sXdSW1VHzVUrmM2hNF4Pge44PMLV1lPLM6XutUXlLKXXTGTZUqBafK2m2PMyNiudgsg/s/k9CcPlwGlmWVDYtyJ60evG3psK4Gbl4t6K0+PDENTSmIWdBc9V6d4qfsUVXTag1AZRZE3VdHLNkNzKMVmlmli76+69Mhv0EOFKLtUg3InTogfEshcaTwPF9jhIW2I47CziQ+XXOQkKD4R9BSPcQ/KInbFhOuFG47e6Ft5NTLWwJjX/S3Shx9Ze3yF/x0rj4/fV3g8ZMhhSpsAlDbks952+0+rEHt3SKwmLyMn2Llmn60aE7ruA/OoP11TMdivbXnkftimm5gxjJjjSUKmVq5INixJseiyVsL/9teVJvLwyGsXfdy9hXFJ75Dv3loMZY1HlUtZ67fv4NsVyJSImYAiyTg0zV297aTmhH/Xlz4LUU+aQD+BQvjTE4zB1Toi157lKFQSQmkzgfiLC1euOHhfiL2QAXeDMTPvvDYHQ59tMQlkTZavQFAER8F43rBcC4m7XTdS22HDX0N0D0LOIcZlVpnBxvCkcyWK0Gr7mjagfISxFSZIgT4WWvK/jUa7PLaUd/bUN8VOV3lXkKO7L8J0Xq+PmZFfRtCbF/9MnU9bHoykx7AIc1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(11063799006)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juHmxdLQg3UwK8SytfYOOf17lDf5bvL2RUTKPDYgcMhomDzedeD8/9n1ruIW?=
 =?us-ascii?Q?T4Tjc8u2OfTDKdwSeK7OozXV6he3eKXP+BeaUPHWVIkZM43WJnFtMLy43JOE?=
 =?us-ascii?Q?h255q/RGL2urm9rVgMyPjDNFmOQr0msVpwMaBz23n4La7wSEfMRxHvPJlt0Z?=
 =?us-ascii?Q?fhYNM471Z5Qkq5c2Uc7TN6M9n+uu7fnLwBKVg+cczZGKvqTvr4WOC/qGhymb?=
 =?us-ascii?Q?ODFF/H2JsoZhomCYCNxZREgJJYCABS2D++NQOG9yqMnDWiYjbe2XDJodkXBz?=
 =?us-ascii?Q?38qlKFJIQPzzBnfCkzRV041aGgT7KWLku+K8M/ec+r9suv2giT6nyaw/geCO?=
 =?us-ascii?Q?02cuWSrRAokyyRDHHzL57VhLkmFvSnefySqvo8yZls0DYrzwAWPHe2LOXtNi?=
 =?us-ascii?Q?K9VPF6X4CYYllXLhdDsNQpoVVW/JG8PBwLk5OazDKQamprLDXXswQGUf2Lr1?=
 =?us-ascii?Q?TKX9AB8xnF88DaF7C4LoGy68z/XH2xvj53xUIvEtSh5Pc7xiws57jxCzrujN?=
 =?us-ascii?Q?lExsIRZ9MZxv9qQMfBjXalr8DinCBCyCk3Mz9oK9qTV4UqSyHA6wJr+qGLIA?=
 =?us-ascii?Q?HbrfJK+2BUbw7UCzY50XAvHAzXVRI7wRy8YfSPwgTPFGndeHBKs3t0blWirS?=
 =?us-ascii?Q?SLLuHJDwHyV7PmZ3grI8QMappW9YaLqu3x8jAmDv7HybL5Ozes9f4stjL1Xp?=
 =?us-ascii?Q?HXUgT16GcF1JNvRWtGsLbCPgsSETdf0SQBfBbPm0eCA/UvYhVO9KFJC3YyJs?=
 =?us-ascii?Q?ZvjHUImtakhoC+td2BhlBFCh3C9VSN4YKhFf2ilci0Sr/qyEG7jDQMX+h9J8?=
 =?us-ascii?Q?S7PubPdGHA5WGvKIeTamTlxTf6nYKnyO06Du+JfLZhA5rkqk7/hrv8dJBkQv?=
 =?us-ascii?Q?mm+eRvgy/4giOLTjnyOSBuDtV89FgbfJFsZFxuaNF1S+dofYx4Yc0i6RtxdN?=
 =?us-ascii?Q?L7XsfImSxXAo5WB6f+YwZxuDP+uCf4+2DeG9QQUpc8mYL7malLJN302VbuCJ?=
 =?us-ascii?Q?SogaZ0+3rea13z+eOO2sGaW76PX18WpFcKl0GDdX/SohXbtIeDHjqoonT3Qb?=
 =?us-ascii?Q?T3o1toUnqKGwIPvoIVp4Z2CExvjhupa2nvdJlp2UsnPNynsWQLSHkzMtmx8n?=
 =?us-ascii?Q?Nl7OwX2/KS4Jg9KrN4szFvK/rB3cRoNOm+saqleVZD7REBLx5g6HasrtWzwb?=
 =?us-ascii?Q?u8Ir81wSMCllcMkaYIExwOhKRJ8g/atCFSX9JE4gs19By0GmBbPZUVzjjGuV?=
 =?us-ascii?Q?unqUNYNYUc6owKaR7xYryW9pEgSWu07zZ3vk84iK1kyZfJ/wgCiaNanhHhMm?=
 =?us-ascii?Q?17GAVyyJRygicKRngK6SYnOcQ8dfM5qY1MMp4q7IDBs705IqUgdCIq5mCYmm?=
 =?us-ascii?Q?lf7KhdVFQ1/i+cJ/yuFyRDgLOJmu0g0ZcMNe6x9hkBptIM7gKM0cWYSdLw2Z?=
 =?us-ascii?Q?yUNFsNiAMeVi5Q9LoKjsue29G49GgCZ0V6xtTS2lPTAX1shK9VaeQI5BEj3P?=
 =?us-ascii?Q?/jFoFBKW1xVguBIR6aRVJLhd2YqCQWYAQ0MAbTcN9cRZyMHUCH4MT0ZMTrgb?=
 =?us-ascii?Q?JZtNpEPvVtO5uNqEpoFtc3cC0Qa6Gvfun4/s0RTGvAtLHXjbvgFPn1RnD1xc?=
 =?us-ascii?Q?GCqxQWGNiIhOi7j9lYStWRaL8+NMOfhMhrHmj91cK6ZXzDcvgwwkvQ1fJ02n?=
 =?us-ascii?Q?tirzM4eqeukHBW2V0b0kKdBpYIwI48Ztxe6EZGLbrPQdYBhRl/EKk+kmNr6G?=
 =?us-ascii?Q?+G2LDcJ5bPp/R+f8rgZk82AGvCoaGBM=3D?=
X-Exchange-RoutingPolicyChecked:
	tQnROne26khgW7PO9BCL9gSwi9thNsnTvd+XSwxfEqfKjeoYmjPN+PRjh0Ij0EKHR6BSBquT1qyeFIn4NxQGCfEPi7fwxGSRxV0PclxiC6b9hbQNGsxx4JNbCWZS4WueWv6ccaOSZp6hpeYmNFsoav0CdkXcy/7EtjEtSxhXTQqUyc0FTobH/cj+DXukXV+2MbKdowaB4KBuDsnQmu0WRD0F5dnYyhUOV4GO1vUO1cjbN13EHLdbnPV8W9/iVzi+Qa2mpt2WN1PmK6AXnlXCBgmzYJcrfVwZS3SooRBkir62zS3ggin8XWcOz589GTRPTcPlzz31HNIyf/2806XKBQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	srbyV7NMexjcg4IpPkFr/w6WxCFJoF04Zy1ugWqaxPTBj0gBmhQbp4DeYH08hh0TnMJkZ4y34OL/IlUOhbxNvsKVqjJxbB4yKy72AnZBCygN1SR9OoxuXiyMLCgZL37YACO7TmYKFOgVWsjnQAZ3F+gnNrsKLLMYkf612xTShXI2ynD5SHgmjDGvRoANPcGYpb40dKpAr5DeX75Tn5LRPa/J9PEK1WQyMZPA6BYOVQZMJnNSJ9Z0V39lPyRq8/hojt7sRRE41bAiH3FlLaIar0xho6e1n3BEV63A1IyjR/KxH+t9UFROzH+0LZadvQpy69JlIRSHcqPEV52iLKcraAv6oq2RAvQnZGf3tXcLOJgaOVJj3fl+CoAEKYnLTQSA2Xols7WU8+KOn0gYcodAv5/0UQvMo4zErrUEj38ozMUNz26cVvT05iCcHgpKmhtw9K8tQ7Ebkv0Z/pH3NBzICTZiYoCDLcKRVTnUHSmzht4Be35m7/JbfJQPu6IWE3Ad1LCNqYvPAjwc/dd/DdxurlpmEcNRCif5gylQym+tpkGk2enkvlW0syVM6Yt3rdVZWHaZ7G+P5r5DJ8lrBWjlbDCTunEukYjsNV+NhdyjstnshStDQUS8AQtCAGeLHUZS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7921d5a-bf68-411d-005d-08dedbf26c8a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:38:58.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71vgWjrwxc+WZ/b6ptPNZ1sujvO9MOCVhZiLsraUL+COTPNXXND4SN8KHoXschqkhN8syNDpdXIr5/OiOWIbng/0bY6TgeGc+UNSC/TNs1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8095

Hello blktests contributors,

Recent discussion unveiled a license inconsistency [1]. Currently, each file of
blktests has one of the licenses: GPL-2.0, GPL-2.0+ or GPL-3.0+. Majority of the
blktests code has GPL-3.0+, so the effective main license is GPL-3.0+ (e.g.,
check, common/rc). However, GPL-2.0 and GPL-3.0 are not compatible with each
other [2]. Because the majority of blktests is GPL-3.0+, blktests cannot contain
GPL-2.0 files. All files shall be GPL-2.0+ or GPL-3.0+.

  [1] https://lore.kernel.org/linux-block/20260626045650.GA8752@lst.de/
  [2] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility

As of July 2026, seven files below have GPL-2.0. It is desired to change their
license to GPL-2.0+ (or GPL-3.0+). The list below shows Authors and Contributors
of each file. "Author" means the original file creator who set the license
GPL-2.0. "Contributor" means those who made changes to the files later on.

1) block/029
    Author: Bart Van Assche <bvanassche@acm.org>
    Contributors: Yi Zhang <yi.zhang@redhat.com>
		  Christoph Hellwig <hch@lst.de>
		  Li Zhijian <lizhijian@fujitsu.com>

2) block/030
    Author: Bart Van Assche <bvanassche@acm.org>
    Contributors: Christoph Hellwig <hch@lst.de>
		  Li Zhijian <lizhijian@fujitsu.com>
		  Akinobu Mita <akinobu.mita@gmail.com>

3) block/031
    Author: Bart Van Assche <bvanassche@acm.org>
    Contributors: Yi Zhang <yi.zhang@redhat.com>
		  Christoph Hellwig <hch@lst.de>
		  Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

4) block/040
    Author: Ming Lei <ming.lei@redhat.com>

5) block/042
    Author: Keith Busch <kbusch@kernel.org>
    Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
		  John Pittman <jpittman@redhat.com>

6) block/043
    Author: Keith Busch <kbusch@kernel.org>
    Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

7) src/dio-offsets.c
    Author: Keith Busch <kbusch@kernel.org>
    Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
		  Bart Van Assche <bvanassche@acm.org>


To the authors and the contributors,

  I would like to call for your responses. Please let us know if you agree to
  modify the license of the files from GPL-2.0 to GPL-2.0+ (or GPL-3.0+).


I will wait for a few weeks to gather responses. Once agreement gets
estabilished, I will ask the authors to submit patches to make the license
change. Any other general comments on this topic will be appreciated also.

And as one of the contributors, here I express my agreement to change the
license of the files :)
