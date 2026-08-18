Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24B46D2DD
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056991; cv=fail; b=WbMrMGKp7zFmFVSpVxFufvLzd29ZkihMXumZgJI0gDTdcbDgn/pNK8u6VRAvmChwU+vjgSM+L3RfKF2dROtMs4hUsKe6SL+WrrA0IlUEU9fCqCCutDmg1bhOnTlW0lSPRoLYAG2MHTma8APpTc+w7kwTj8wuYDhuTjXhH3lCAvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056991; c=relaxed/simple;
	bh=5vm1ggTouRnmp7fkGWod4dwEU8zperaEuWCXL+Fa32U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5xH9Ks+kWifK8lhpCWPC4LOjB3zxzWOZSc8tw1yIs/oQMVMkl1HXIkdx8UdWQr8yC41g4vx/IrciErezGPbqdhPmadI2pQb77OIbKcfNDqbQAQUffalkwo3XptqSJv8nrB53wQtAm71+e2UdiPpSvukG9szFVwcIaU9rLVX0X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hlO16nxM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sGDzxlwC; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hlO16nxM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sGDzxlwC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787056990; x=1818592990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5vm1ggTouRnmp7fkGWod4dwEU8zperaEuWCXL+Fa32U=;
  b=hlO16nxM//WI7inLHY1mP9ICXPiuV4Il4VzPtHMBRljtvzHefMAYAOGk
   aokd5IGQKArILyeBHMqKDhh7rMRbI0ChH98gaMlXI72Dt73KbBDB1q6gF
   OrCFLElRG9AA1zM5+LF+imhant3tFfJ8Rq0etC8lprjN+Mrk0PHLHp5gp
   XwyTcGO6yiGryK/Gsgo+X7lXwHSgMSAIalmnOumCqu0ssP+WJR6aAih1H
   HACGX/c83vPN8w0UchfAbKgTjvepbGZyJXYP8aeP4mtxsKJnEL5A/Za9M
   ZMhSJxURnByvQDAUaS7wEU9ID2XqkLRJb5ys89UJfEhMORRwei+MzQe4o
   A==;
X-CSE-ConnectionGUID: nJ+XPxquSAu+5GknHOUbZA==
X-CSE-MsgGUID: VRg4oe0PSge0b1aI9pVkKw==
X-IronPort-AV: E=Sophos;i="6.25,230,1779120000"; 
   d="scan'208";a="153549538"
Received: from mail-westcentralusazon11010067.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.67])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2026 20:43:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daaDLZc/paubL8EBtxRB+I15eir87kMUSKzZEkLlRwrggBRLSqOHaA49VLfMWmQetzqGKDjAouahetrSUoAlhifyKHMpRWOeu0QFbjgyI02lJ7+SOsE58WOJ6DWn5fO7VIX2B5SehyqusatGGG8+w9semICY+aHZr8tarSWx0V1+xLphLR5Ab9x+6YiJiYNEvx/GCUc+lGEJVZUcghqjZzUXWZgKTh7KEANVJAIzi9uTPI95x9j0HFM6Ka56xacIdvbtmrw7BguHUvO7RT9pVfn0nkevp6ArBIsclgSq7tlOwn0XUQbt4vLlMUDZwCY4FaCvU3ZOxI9nOCBieol7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avjFmTUGTU5JrJ5dCU0DYNNaS5ozNluV+NP5cIG27SU=;
 b=eHxSIuPRavSDvhLVg9dbgHcsvu8cnoHx6IrGyDSIy96MmoELE0NtKTWFDB1OPLQH/ohD8r+x5QegwOAIRFIHUy1WBdq2I2UEugCazoD32+Oq3w+Xz6IjJkHv9fXiAapVtb3mJAUWSMANvmRY7yfrkuXJURxYHUZUiFapvlYnsxOy5D4DmiFusQc13zBTnKPQCGBX5xjn6GZu9iSxgdwaB/lNJxS0vrCP6amFjCKWg0lBQttOtri9BpKDWocCUJyLDce3vQwqhoPqDZV7zScb/CsLs3LHKn0DWrw5GKml6iAwL0Jo0PerHMQBN1/6LwmX0wb7yTkXjn+ZixAOJR9+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avjFmTUGTU5JrJ5dCU0DYNNaS5ozNluV+NP5cIG27SU=;
 b=sGDzxlwCjlVRA7Nmcf4SkJjnNxXidt/mm3fTNfB7kBTvup0guqlXKI2nLtNFtckwYnSuA7CcsCtSTru7mqGuCjVixyGuHb7gDXj9ULBhSZjIcRBufu/ANVuhNrvOJfCmHnTVrLmgDiKETYFb9vDlb6vZhf8vAZ0CQCdOXdpxJoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CYYPR04MB8868.namprd04.prod.outlook.com
 (2603:10b6:930:c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 12:43:03 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 12:43:03 +0000
Date: Tue, 18 Aug 2026 21:42:58 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai@kernel.org, 
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH blktests] tests/throtl: add a new test 009
Message-ID: <aoRRlY5AeMaRBXMh@shinhome>
References: <20260813144041.1715866-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813144041.1715866-1-cui.tao@linux.dev>
X-ClientProxiedBy: TYCP286CA0108.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CYYPR04MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: b109eb1f-73d1-46b8-d5c3-08defd263ea2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	us92iajxHKxf0Gz5vyrJFqGORROj9FEdnp7NFQdSUAW9Uu+yVmYxMfNDuxtqWvcgXfVHlqj/6xGa72eZgtH8dR+9lSWE3QY5u/FiN6l5YjGprpi0rJ/wDqmqSbAZvZ4o0C+Z3FFFA83IXFiJbLmW9rzbL5s7htwnE7I/81QFTkE3gA2hcdbuC8vPeQbdbOHL5gtpBk5S07bt0UYsoGJ922EZClQPm3oBzipPyTWvN106+eHv+aZ1CPYdx0vVkPN5Fdxknbdbu9ZAoDqe3C2lqaelVNPkcxVQbWfRBJB4fWcWValHQvORZvFneA11GK/XB6llI52g17ltZLE2QQ/UJVJqIc0lyDv/W2hX9cx8C400m7go8XKc5wD7HNHmYFd51cthQg/RaO8wQru6URylQDlc83GCqJI8xLqRpx1xtKsEk1fAzrx4oP1pVEKHPVGchDjkaqqsOoyiWVIeaDStrbebYFJwB9wu5V/TR2W5UYvNZH6KfzNIlaKNKdxJHfeHVjo+Bm/WMuAjidl7HcdTU9uSoAP99JGLUz2duRSLtdwpqyXgzlKDcyn/5SnlimohJgDZ023NuBJM+zaZtNOiu2dnV56yAAgt5ep+nIGoaG4l07dKQRxkcsT5sMcPg5Y4mdCI+4mJwmSzi7fVon3ssQ/ksI6K8/QRoFhHXWy8wEM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ezmejwfrvv583vCKX2PU9svibaCuxGZQsvDHbH4pXZsgzYsuRda9jIqWr/Ws?=
 =?us-ascii?Q?I5ByqYvbmxQmL5XipJPwQoZ7m2Q2600WYYnaSuY+xxOUpiqkp8disUQWjj+i?=
 =?us-ascii?Q?cFvMxr4hPVaxu/s4b95SFqRJ5PVW6AH9n3FtXPt3RacRq1e/w7IUl95w+oEW?=
 =?us-ascii?Q?/NHNVvOC4IgwfjVDHpO5l3ZZJZjyiupkxehTv61NS5xk+hZqmlaw4lZ6ogpd?=
 =?us-ascii?Q?7y4c+0AeZviVMPQIuGwEwtiojVhwREeiIsA+jt6+LG1UsjJP1PDbrbjuokAc?=
 =?us-ascii?Q?Yu37z752NaKQy9QP57yDJCuaRxwq2KeR+oMIuhrNTyS6xF5LkAAHdA129n6/?=
 =?us-ascii?Q?5xLv49wV1uc0yfBT1MO1GYSRQI+C8m6GtCp8Yb7JvQ5QQxFw/jgIstEfWo8a?=
 =?us-ascii?Q?2+/2Rzm67pO+kdQt3TZ01BzHopAZfiWYK1hlhKjM9P4IUDUidWR9of9hknWS?=
 =?us-ascii?Q?IJCQfFip4MgysB2Uhk0IzNMLsRGqOoT3Z/Jn+VpbL/rwCov786o/JC2fnOnv?=
 =?us-ascii?Q?6vAns3kawyvQM6HuxfoYSc3t7CxYnSHj6aG+8IbKt/qdPoY20/ZmHCpnOC9F?=
 =?us-ascii?Q?XSW7GWBdotACqPwuka8QWfb3H/NX0Gm/sQ+AH+RXPRIGfOSIr5HGyApwm1Cf?=
 =?us-ascii?Q?TR3XAaCmIdU5fiB6omKq2VlDGcTBVuNXM28KDyAJHAUzAeg40GjQQHTm+hgY?=
 =?us-ascii?Q?l03R8fBASvFXWl9f9dZdNsiiYMzoqK9PjAMsRzkxD6robSDwrEDwjGBkHN84?=
 =?us-ascii?Q?vPmj1OdoZqB10dQsAvMIO+lBY73ZJMc/lMfVN8zdV3/OYLozAZajuqb6X0k2?=
 =?us-ascii?Q?AbotQrs7lGJjgpBeMD//82naN84bb8NiwJh/NbvbZ1l3Mlm89XhShWQr67Up?=
 =?us-ascii?Q?lI2cmsGSNM1/NyS3Rd5pmwZ1xXihcWVuCsLF1PIj8rwY5q2QRmMCYIuZdcDN?=
 =?us-ascii?Q?qS2F0CIUx9xG7tgHJ7xKfifrzKfiipOAdqY+zJmdlbYGcyY3aEtIjbqyj0bH?=
 =?us-ascii?Q?SUpEZG/uXp8L8UIr4eLKba2LsHzX06qEHdcLLP6Lr9DYI6IqGBsdgSLy9nGu?=
 =?us-ascii?Q?vluoVPuznbeUBx6aqCBeGnOO/BYmgZlemNy/pOt0pWNesqiftvfEhDJfEfz6?=
 =?us-ascii?Q?obDhvkYK/Z1t4qtJkEHqkc9SXzI0lElvIXY7UeRhv/KrQhdx2sdm6V/mu8hU?=
 =?us-ascii?Q?o0wFuyY1Dr3Im6dCWUyQQUcM+O5wo4trOyRBupwol3nYYnmkH7xGx4s+nW9x?=
 =?us-ascii?Q?+kD3DlgYTLGaqBBo4rRDYfCG2SnNid70oF5B2N9SD+Lu2OkqQduo8sCI7z2N?=
 =?us-ascii?Q?vZAVmoAp8FR7Vftg6PuqbuizH01cpTCkd0/J0snQuByxmSomWy08F5texcvk?=
 =?us-ascii?Q?NUTpy+3K/wkwIVA/sN7wB9TvXTzo89fCr+iQ6VJTyNQoH7odCReW4lmeR4Ee?=
 =?us-ascii?Q?Zzhi+4flmIkash5vkAqBEPgzd4I5ve2Px4gfcywTllwWOvlnaywz6Cz76sK/?=
 =?us-ascii?Q?NpLNPBx4H1ZT37L164rvK8zABrujCNoq/zBQ1zv8OTq27fvmqi38VudX7zfA?=
 =?us-ascii?Q?bU9JXPUiV2pJNhbpT8r1c0XJGPPhbZ6hPqy+S55wcknOcSHrKBdFFQbY3yDN?=
 =?us-ascii?Q?eDlmVOsPNxRBzn2o+nUL+TBhCyf6Vc+BftIo/uZlhEFzST1gfbhe6NpwK8y6?=
 =?us-ascii?Q?vvG57qkhN8KzmL2fwK788Gchj4duvPhZKF3UPwZmoqeKnjiozKlrF4bIMEiD?=
 =?us-ascii?Q?jBZ8v4/Cn0BvVvuC8FTiIwiuC+Jyimw=3D?=
X-Exchange-RoutingPolicyChecked:
	mFYZZXlq/3HKf3Xm9xC9BkpE2X6nEBzzkbFNbZRMuYDa6A/9o+EanMP8Zxe+fmiB1sbeVIomJkIvK7dwc6Agd7Nj+3QCMjyl886ob7f+2iAqCnz8yNY0qr0A8KAX7uPfyKaq6DyDRTVRnfJeWK9068Dps7v3hnQnFoIo91kR6GllKDsSDOSJcAPLHjSniocHqOVW/s7pC4R1QIBg9CuWW/acFNVjtQLpPzcAP9GI7/Glgzg/AI+ERcBQogEVHsEML7HDzxS2DhfV/9bkKnGXm9yZjcJs1QI5nQMRkadfod4nUUYNcu09EcTix8hRCh6UPBDNrDM3iECJ0qn8Ay9wvQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uN1ILl0ORvFX/hECoIgczDMLO3KgVTU8XL6ftSAk3rDKqcVwdhJqxVQYZ2j4vIcL07OCan1JCSJhnMoIXuV5b5fTtxedTcrT4Bzhwt8Jfmgnx3RsKElZJFr9jbe7eVQVucnWdEhvrUX0+3+aPHcF9+Qkh0AiLSCN1u1FzHrytnuj0BpHA72BeGhJbo+SAdibVL7LEA9NNsd23vmyGDWAUxOyhYFnxoJ7zFfYJWuOu66gClKp8v+jOzNzX+iiDbdpK+9gLlz3i69v98iCeyHajBKPMwHUOOC+Xgyg2T3PRjT+F5cNInHWk/oMQAIzOY1FD08sV3fzt/8zPgpxC7leDjtKkcibpoZA0S2SQbIboBMUPhUQQ/7/kdYVRMc33+hrcUB/RpvK+xmS1fSXHG2knaHTIhXjriesKjlvQ6rpoll3a5koEVljNj+NdQcg/oazI1lL/G+OWdi+JY6mA7qYAqFmFYND+YJNgSsbgz8fVxTd2VIFoRatIo1NRgPHEDsicPNPQBf4zlm74RGziEkRtvTwXuz9wFKqHVISfy7y49SFfbAcN9ztRtQsPfd60gR+6YL/F0y6/45IcCFoGeNnx7CJPcoeHHQqIJ6QBp1huRKMzQNn3acRh7zUNEzes2TV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b109eb1f-73d1-46b8-d5c3-08defd263ea2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:43:03.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6TnYwycoFwlDy/GDxpvQa3oThRI8cj5fGR91I3i0VL/6DyFHC6z8ifFbzAqtsMgAtT0QBMGj4xOB5ndhKqSdd/PWAWipxcM0jzQM6bIct0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8868

On Aug 13, 2026 / 22:40, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Test the boundary condition of removing a cgroup while it still has IO
> queued in the blk-throttle queue.  The queued bios must be flushed through
> without any blk-cgroup or blk-throttle warning.
> 
> The dmesg check matches any blk-cgroup / blk-throttle warning rather than a
> single call site, so it is not tied to one symbol.

Tao, thanks for the patch. Does this test case have corresponding kernel side
fix? I'm guessing that your recent kernel patch is the fix. If so, I suggest
to mention the kernel commit in here and the test case header comment below.

> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
> See also the related blkcg "store blkcg in bio" RFC:
> https://lore.kernel.org/r/20260804065313.2092022-1-yukuai@kernel.org
> 
>  tests/throtl/009     | 67 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/throtl/009.out |  2 ++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/throtl/009
>  create mode 100644 tests/throtl/009.out
> 
> diff --git a/tests/throtl/009 b/tests/throtl/009
> new file mode 100755
> index 0000000..1f4ed67
> --- /dev/null
> +++ b/tests/throtl/009
> @@ -0,0 +1,67 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Tao Cui <cuitao@kylinos.cn>
> +#
> +# Regression test for removing a cgroup while IO is still queued in the
> +# blk-throttle queue.  The queued bios must be flushed without any
> +# blk-cgroup or blk-throttle warning, and without leaking the blkg
> +# reference they pin.
> +
> +. tests/throtl/rc
> +
> +THROTL_BLKDEV_TYPES="nullb"

Is there any reason to run this test case only for nullb? If not, I suggest to
remove the line above to run it for both nullb and scsi_debug.
