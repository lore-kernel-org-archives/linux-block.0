Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF11F4181
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785730085; cv=fail; b=PbIPwLe6ook2I9otF4TdMei2gylV6gFWxLwa+cKcEB22fhSkeQnV+/OO4fLXMpLjlXNSHDR8trpLnEXTGVMaV6dnvGtYzEdL05kkw8d8rDCRrGEUnHU0wQJS8tjEDZjiVUbiL16JRhZM/42of/hn7uzmxKeXm8b3RQPViwN4zFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785730085; c=relaxed/simple;
	bh=gs+zZsaypzJ5/GygFcQTZ5IOpacgS4RQ5sPnME9VG3w=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXGVIdZKrYsi7f5u43E9/UgbJb9t9A+BWfLRiJBqL+BvcU/kyvEvKDaeEiBcNZeafoYi5YogvJeNXjIw53JbIXA01wHFhBKrNK185pVOOAdWMYLfkBvKEK+poW4cLHU1HPM28slyMHan43d/ohxlftO7c0Nj88QI14iHKcJgkmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pYYJagwj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lQkCixG/; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pYYJagwj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lQkCixG/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785730083; x=1817266083;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=gs+zZsaypzJ5/GygFcQTZ5IOpacgS4RQ5sPnME9VG3w=;
  b=pYYJagwjzjzJD82WuaxERbbo+LW2GWoLwLx2sbOCPMIf7gE5OFz0XOwg
   pPrAT84x0lZWhf5u8F+HBLEsCt8DwLkT2k5k+KyHj7iuFFBuxgD53fZit
   hA00Xx8cp9hSJ4ZbbZKwvvtPZPUMgHLHdzUvqoeQzy0wpnUqP6Tmux4nD
   othFwmno1Dd3nxugCMWoQDeEA5M6ncLXk6NLExuCzYYmtQi9JzS77sWRo
   hmQRCEHFEi3HDEJufxrAgCeI9m4l4YPeCxQWb82rQzxPcSVOWHr8+fW2u
   LuoWX+rEb5/0fAGhV4Xww4phW1oBLQVFa39DOQ9djBik4v7JLkfADVX/m
   Q==;
X-CSE-ConnectionGUID: t0Uk5BstT/m6+MNj6RihIA==
X-CSE-MsgGUID: s/RV7JZISvKVs1m7TazhNA==
X-IronPort-AV: E=Sophos;i="6.25,201,1779120000"; 
   d="scan'208";a="152040371"
Received: from mail-westus3azon11010008.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.8])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2026 12:06:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzV2wKpayXGYI8lqr31mlrIZFiYwGfAYTFIwaOmDscIEWBgXD8ZcDlGud0IFDyQ1cC5boJLHuT5Z2lKcYWqsJpsWmeuCjH0iAF0JgumjL6VxfV1zNq/wBjGjOYZhU0spbfbfANJpEKRjAJYU/t+4V0kZEi2eToqiEkPNQsHBhWxVSvrsChxCg3IMmoIR/ukfLKkUuXAb7trVmTBpGF9Za7y5xSctFAFYoBv4200dqUzNBXCTH4THGLypOYQYPaM4sKq6/R18v7tKNtebLIE5HjmhLLAe6DHe8Y0GrbHpcAsE782oj7DOGgdbmbO596KZmHKRehju7Bm8Lf2ah5ID6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBjGtDRlxgQHha7EhImQWdWm/nq9p2Plqz2+vjouhoI=;
 b=Ho4YNiBPXBeeC6ixQnzVrPL7hP1MDYe0Lk16g1OZZB3vcas9/EhMyT6coay2RonQyNTIjnJTOtao+VPltK28oyZnyK20zaPimb1g2/w3b90MeXJMnD08mT+zYWh86pfRTUfIiY7fWFJLhBGtjZFxSVsewPXDp/2pGoXE44HWzey7piEYnYGQin3lcxT1pYBO0YAqGWD55x9BbOu18N3ONkiQ2AEORXZ8rqOG+6WssNDZBifyM/68wCEpe0EuB+CQ/l3WHU/0rmqXraJYk4Wcs2mU2/CR452+okrtaoGYGUdM698GcSJaOELmSgYIFW4JlykrKeBkzrxJ/fCKfs6Rsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBjGtDRlxgQHha7EhImQWdWm/nq9p2Plqz2+vjouhoI=;
 b=lQkCixG/udSdumuxRo/wiKJ3h6hsZlK0o2Qtn9HnC2wCnJs0oCZanbNsG185o6z0MVB+5zIjQ6hau511DuX1t2g1OGkvN5DKmt8q8Rf9TQ57/sEHw8eYjxaQIThQ7e1dS6a9Xu7guppRPjrWdiijToYsTWtWO2hyf7YDYeGDeW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB8371.namprd04.prod.outlook.com
 (2603:10b6:510:f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 04:06:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 04:06:50 +0000
Date: Mon, 3 Aug 2026 13:06:41 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 0/3] test and handle concurrent IO scheduler
 switching
Message-ID: <anATkguTHjesxYqH@shinmob>
References: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f840bee-7723-4f2a-3c10-08def114a4db
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1ubA6QSHtcILPJl80NPMtwUfHVeXU1jpOU7vURCMCULI9l9O/WxgsZdMRjHLakDq+0DvdZOAhdr8OTFwiNozGo1CezqG3Xh7biRveXakblHmJaezvo33X812mYOw2sAmp40K/IjClDjZmj+kFWTI25MrlVdzyFo0mGteOjRLCsh/WaPTUClq8iju2CTT9q9GqHVZ0GzX+TF+m4acYwMCQY/QYG9ynHF18yOBhfiBeGP4QkX0n+lSXGmv9Ca5maSyzWh+p5+MxasyRntM3xx/UlAhLA6tv2y4jNfWfXEoL6l+z/JEzhiGnHtPhpcQ+10YSHKaqM9EEc2viCNcA6+FR0UIBfmKcRuUvdntkSeA2gUK1mNCJvrsnDjKAYcb/SwLmlacLPIJwsQW2ikAAJ+ZrMmDe/dFM47voRejFao1aDryoAnirZ6/y4fX7+JeZmXPpSZnKNlJFnBtsdDeDiOEMqRLw0wLJxkyjeSjVHvJPUfQS0qFMx2TSpIEMWPLyN8ro9XDyIh7TUTshlsBG3KhbbXoBhHjBjxgeIkqPS0ypfp71nb5gDhKngipGyJ1qCiOdwm2QKagd4ANH++z7eop8/X69WhmTzkGFRj3LwM+5n4CcGpLoi2DX2tm4AgpDplvEAMHgtx84+N+2htMlBF8WKCjzbgGMQHzHAKGz7NItdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NzhU5E8dOZLKGhmZkK70H8+K7SE0xWQOAaONj8CxNQ/JlrIEnXbXQbEmWFZt?=
 =?us-ascii?Q?F39OAAZr5D/0L5kBj6mxETg/1hqyqMPo5q9pF5QiLM4s4rSqHb10Nfg+d4/+?=
 =?us-ascii?Q?+HLHIHezNQaqhRh6j3UM7q/QYoJLMqi9NqlKCoTdSLUCbRTRHqS/Tb/29Bol?=
 =?us-ascii?Q?LJ2+6a/WMx+Sdhb1MiGIuel8MGSLgO/KesObNtQBK5z8gKju+Ru8s4Z4Lpyx?=
 =?us-ascii?Q?Y+xuZ3sY2CDIcqLiXCBjrcPs7qShdGjQ+X8T+bEQq40oAXpeqJGtbXXHRx/w?=
 =?us-ascii?Q?hGW1tEU8/aaDQzi6NOb/v3TVTJXxNXvalXQv9GwMmjzK0lV1LQiinyNlhjGQ?=
 =?us-ascii?Q?38Eq9Rbq9s9/mXj7Al2cKiA3YajXxs1DglFq3cFJ8isJlaOb2LQEAqdUTiMV?=
 =?us-ascii?Q?uollYLx8jQyt6Acw/YN+OscH3f2Lh3UwioCNL90de8z55CpcG6qkqc5Uh5JS?=
 =?us-ascii?Q?OmZ3S2qtRsZ3Zi+ElAFlpC98e/AuyHkf+2VCaDg8JNvMK/Jk4W5L7Wn5gdfJ?=
 =?us-ascii?Q?57xGsEVke5+2ZYx2SsBvdCeeIPsrArTMDLP2FtJ6htJPrulVDKRRHGnjyCAJ?=
 =?us-ascii?Q?ui/Jo3OTDjzGU0hA2vXeh6E0rKPzM1GdSnd0fcAGEBmRmSh8ureZvc/rxisg?=
 =?us-ascii?Q?NuFoY4OFwPX3oj0up0XR4rkkXsmPeT9o7hMU7nKxT4xfbvdaXY8eMl6QkuY1?=
 =?us-ascii?Q?hdliDNQDEMRqJNoFpWPg2EplA3TuYrfdZiRPC770UPLKjRdU20z8BOnJAZpZ?=
 =?us-ascii?Q?Vcvldc51ryM0BjftaghHty/xqHa8TX3gIbvEcjT+6Qs7nbR6LKMqhv7i13Rp?=
 =?us-ascii?Q?VmYDafLSakBwEGb6KvQABFU6a6BxKsWDrWTtb0Nrtcy56FsNCtk1cP4Q+3K0?=
 =?us-ascii?Q?UcTPux77+oN0hsbB8psDNWF0CCnREG6HK7KScT3j4EYRwzsFEeFrQdURGlE9?=
 =?us-ascii?Q?Vx+Y6E9OlydX4pUMF5Btt5sQQbmQnDtkE5sS5nTwRzVJGKKgwr2xMe+lCM/z?=
 =?us-ascii?Q?GwsZ52DtQ7c+0yqRvDF1JIDr1D6eFzaqM3pWp6xrqKHOwW4oU0avgNIo5gjj?=
 =?us-ascii?Q?NcCpZC7ek/71+mmrv2Xe2etkzVDB13ztaXe+LpASOmyNfhXHEcpNEZR8f5oO?=
 =?us-ascii?Q?rdaXWj8jnlvmj3OF4Y1hduVs6z0TGG74Q00O33Vu3F6YMl+qFKElj0xMVPTR?=
 =?us-ascii?Q?EleixIabTU/P6eGUZejdlavsat69u41BDb/Cp2O5WCPXQ2a4FvJ7ArnKhSA8?=
 =?us-ascii?Q?gdMFbPUtotpWoHT+Ai3fUeV6M/DXs50TbApW2Z1D2/7eOWO/vzVROAC0Qeb5?=
 =?us-ascii?Q?4j+xvhUrkUqU7Hej550V04PWPFMygH08ZmmOjbE3T0l9JTt3Fs18mibuwDGV?=
 =?us-ascii?Q?+BG0uUhE35+rH8hoFyheOLMYDfU+ZPUi6SflYGn61oc5Cr0dAghvJJZSoCh6?=
 =?us-ascii?Q?rLBZNX2DNZEIm+g7Kd/QEvc/htPj/G2qtKuqzI1YSvRzWxNC5oqmb1nMiTlk?=
 =?us-ascii?Q?epIrh4L787kRYMvUNiHYDLXbMxi6piz6T8DKVpOpX840BZc71c2+TTPOtvjw?=
 =?us-ascii?Q?tY6nZYpl82V2fzqWhTQhvF4K08ostoNu/vJ5STOSwSOed0n7X2gRW1DeqNZ7?=
 =?us-ascii?Q?u2Rx3TvS1zdWROdAnczLFmedCQaGHVHiwDvzrsdo4urY3ypsB7aEzxUS4ohh?=
 =?us-ascii?Q?E/cxyTwip8aiMNGZ/PKh/hSvZUWOlsyHGmhgnWKOzOoyl/9ZMzlegj9EE/r0?=
 =?us-ascii?Q?QeZDG+7mvFEQrif3T8Eyl8OKJtZGOPY=3D?=
X-Exchange-RoutingPolicyChecked:
	s5/Gq5HjjVWOg847TunwVtqHWQPi+pGVcsGom7JEKTMXbizsUXySRyMaNCaoQtXKFUXTu/ix7BgTY2Mu8tEiMbdFxPy0yNfYGrJWFrddf8B0f87SsjQvpuolIhCJWntfWnEfLi8OB7BQ7eEuIYSY/s3ZqxHGmr6Idxn8kGKlrU9uH/Ono5ASXlBmqBB5VrhmBktzilyMNGnVo2TGEsj+Q3DmgYVNTd7qSm0JX0rsPComqw+lSy0/jwS83IFuctuj2eS3W7HxCyx3KJAvyLuRwwN1pQb+tjbcJwfNJAuPaHwYY8Giu/p1K06DF9dVG4yKMl5ImTBQiMndXx+liX84DQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YTDssfTxAJfREDF6AmmcOvVbjQBtZDLxmtGzIGr6oHAp+bxMlTQwNpTM1+0vgw/rjsfqkc7LzSwVaHYVWp719zf1JY3TqaFE1palmHtoFHX0UZLFUOx8AK1DfaGrjq6vot9m+/InmFARSL8DHGPI34NGTkP37b87zrZgjvcuZNkyN5NfTobSBVq4bZR8EsI6w3Sm4lxAuZIvV375+PDDIGHjy3PEyrtjX4wlCs2U5PP7hrE117bqDrJ4lCl7v6Hy1w93/C9GPWh5Ve75hDru+dkWI4DpqG9ZloGx/UZQlsbIMqMJ9bgtp0u0Z9r6tlY8KoCMUG8Es7HaDNkb5mfipcdBT33jGzr85c5HNXHIP/kvwQoivYxmTlKV/XoQzo8SVfBCiuhd2QM6cQ990p0snDKrAcv/BwwYNGWjAg161mB6thTav5er8jizkHWYDZeyr9/EeXTIvHybj6EKsIxK/ZarPoaBooZkSsSfdO2VySL7UM3Z26AJd61aRE1Cu7txgAgIkonD62EKAuzb7lFJr4hkSG09sZxv8KN7gUIcIjOnO4tc6SV9WOJ/Mcd0k/UG52oc2d1huLi23K0QD5T38ndbpDdWFQGmfrr2SjpJnzKenzyxX7enS45AHFfBtUNE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f840bee-7723-4f2a-3c10-08def114a4db
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 04:06:50.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6zROy8n9NG1kRqT+IFyaYv9i9clKY5utYtm/0WVuNWBOa/Z65we8WbhpSsaW/vfBm7jiTigfhd3SCtNkj3Vpxpl3j1jy7wECnaxLgt5bME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8371

On Jul 26, 2026 / 14:32, Shin'ichiro Kawasaki wrote:
> Until the recent kernel commit 4ff58d6bc9dd ("block: serialize elevator
> changes for the same queue using a writer lock") concurrent writes to
> the sysfs file queue/scheduler caused KASAN failures [1]. The first
> patch of this series adds the regression test case for the fix.
> 
> After the kernel commit, writes to the file queue/scheduler can return
> -EBUSY. This is rare but can happen when udevd writes to the file at
> exactly the same timing as blktests test cases, and it results in
> unexpected test failures. The other two patches in this series handle
> -EBUSY and avoid the failures.
> 
> [1] https://lore.kernel.org/linux-block/20260626004221.711326-1-shinichiro.kawasaki@wdc.com/
> 
> Shin'ichiro Kawasaki (3):
>   block: add test for concurrent IO scheduler switching
>   check: introduce _write_queue_sched() to repeat queue/scheduler writes
>   common, block/{015,020,021,027,040}, zbd/012: use _write_queue_sched()

FYI, I applied the series. As to the first patch, I renumbered the test case
from block/045 to block/047.
